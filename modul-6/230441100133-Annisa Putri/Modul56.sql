CREATE DATABASE IF NOT EXISTS barang_db;
USE barang_db;

DROP TABLE IF EXISTS transaksi;
DROP TABLE IF EXISTS USER;

CREATE TABLE USER (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL
);

CREATE TABLE transaksi (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT,
    tanggal_transaksi DATE,
    status_valid ENUM('valid', 'belum lunas', 'belum dibayar', 'belum dikembalikan') DEFAULT 'valid',
    STATUS ENUM('aktif', 'non-aktif', 'pasif', 'berhasil', 'gagal') DEFAULT 'pasif',
    jumlah INT,
    FOREIGN KEY (id_user) REFERENCES USER(id)
);

-- INSERT DATA DUMMY

INSERT INTO USER (nama) VALUES 
('Adit'), ('Budi'), ('Citra'), ('Dina'), ('Eka');

INSERT INTO transaksi (id_user, tanggal_transaksi, status_valid, STATUS, jumlah) VALUES
(1, CURDATE(), 'valid', 'pasif', 10000),
(1, CURDATE() - INTERVAL 2 DAY, 'valid', 'pasif', 15000),
(1, CURDATE() - INTERVAL 5 DAY, 'valid', 'pasif', 12000),
(1, CURDATE() - INTERVAL 1 MONTH, 'valid', 'pasif', 11000),
(1, CURDATE() - INTERVAL 2 MONTH, 'valid', 'pasif', 14000),
(1, CURDATE() - INTERVAL 3 MONTH, 'valid', 'pasif', 16000),
(1, CURDATE() - INTERVAL 4 MONTH, 'valid', 'pasif', 9000),

(2, CURDATE() - INTERVAL 10 DAY, 'belum lunas', 'pasif', 8000),
(2, CURDATE() - INTERVAL 400 DAY, 'valid', 'pasif', 7000),

(3, CURDATE() - INTERVAL 2 DAY, 'valid', 'pasif', 10000),
(3, CURDATE() - INTERVAL 10 DAY, 'valid', 'berhasil', 12000),
(3, CURDATE() - INTERVAL 20 DAY, 'valid', 'berhasil', 13000),
(3, CURDATE() - INTERVAL 30 DAY, 'valid', 'berhasil', 9000),

(4, CURDATE() - INTERVAL 1 MONTH, 'valid', 'berhasil', 5000),
(4, CURDATE() - INTERVAL 2 MONTH, 'valid', 'berhasil', 4000),

(5, CURDATE() - INTERVAL 3 MONTH, 'valid', 'berhasil', 3000);

-- 1 Menampilkan berdasarkan durasi
DELIMITER //
CREATE PROCEDURE tampilkan_barang(IN durasi VARCHAR(10))
BEGIN
    DECLARE batasTanggal DATE;

    IF durasi = 'SEMINGGU' THEN
        SET batasTanggal = DATE_SUB(CURDATE(), INTERVAL 7 DAY);
    ELSEIF durasi = '1 BULAN' THEN
        SET batasTanggal = DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
    ELSEIF durasi = '3 BULAN' THEN
        SET batasTanggal = DATE_SUB(CURDATE(), INTERVAL 3 MONTH);
    END IF;

    SELECT * FROM transaksi
    WHERE tanggal_transaksi >= batasTanggal;
END //
DELIMITER ;

-- 2 Hapus transaksi > 1 tahun jika valid
DELIMITER //
CREATE PROCEDURE hapus_transaksi_lama()
BEGIN
    DELETE FROM transaksi
    WHERE tanggal_transaksi < DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
      AND status_valid = 'valid';
END //
DELIMITER ;

-- 3 Ubah status jika transaksi >= 7
DELIMITER //
CREATE PROCEDURE ubah_status_transaksi()
BEGIN
    UPDATE transaksi
    SET STATUS = 'berhasil'
    WHERE id_user IN (
        SELECT id_user
        FROM transaksi
        GROUP BY id_user
        HAVING COUNT(*) >= 7
    );
END //
DELIMITER ;

-- 4 Edit user jika tidak punya transaksi
DELIMITER //
CREATE PROCEDURE edit_user(IN uid INT, IN nama_baru VARCHAR(100))
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM transaksi WHERE id_user = uid
    ) THEN
        UPDATE USER
        SET nama = nama_baru
        WHERE id = uid;
    END IF;
END //
DELIMITER ;

-- 5 Update status aktif/non-aktif
DELIMITER //
CREATE PROCEDURE update_status_transaksi()
BEGIN
    DECLARE id_min INT;
    DECLARE id_max INT;

    SELECT id_user INTO id_min
    FROM transaksi
    WHERE tanggal_transaksi >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    GROUP BY id_user
    ORDER BY COUNT(*) ASC
    LIMIT 1;

    UPDATE transaksi
    SET STATUS = 'non-aktif'
    WHERE id_user = id_min;

    SELECT id_user INTO id_max
    FROM transaksi
    WHERE tanggal_transaksi >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    GROUP BY id_user
    ORDER BY COUNT(*) DESC
    LIMIT 1;

    UPDATE transaksi
    SET STATUS = 'aktif'
    WHERE id_user = id_max;
END //
DELIMITER ;

-- 6 Hitung transaksi berhasil (loop)
DELIMITER //
CREATE PROCEDURE hitung_transaksi_berhasil()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE uid INT;
    DECLARE cur CURSOR FOR
        SELECT DISTINCT id_user FROM transaksi
        WHERE STATUS = 'berhasil' AND tanggal_transaksi >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    loop_user: LOOP
        FETCH cur INTO uid;
        IF done THEN
            LEAVE loop_user;
        END IF;

        SELECT id_user, COUNT(*) AS total_transaksi
        FROM transaksi
        WHERE id_user = uid
        AND STATUS = 'berhasil'
        AND tanggal_transaksi >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
        GROUP BY id_user;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;

-- Menampilkan transaksi 1 bulan terakhir
CALL tampilkan_barang('1 BULAN');

-- Hapus transaksi lama dan valid
CALL hapus_transaksi_lama();

-- Ubah status user dengan transaksi >= 7
CALL ubah_status_transaksi();

-- Ubah nama user id=5 jadi 'Fajar' (jika user tsb tidak punya transaksi)
CALL edit_user(5, 'Fajar');

-- Update status aktif/non-aktif berdasarkan banyaknya transaksi
CALL update_status_transaksi();

-- Hitung transaksi berhasil per user
CALL hitung_transaksi_berhasil();

SELECT * FROM USER;
SELECT * FROM transaksi;