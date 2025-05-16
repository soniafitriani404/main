CREATE DATABASE db_klinik;
USE db_klinik;


CREATE TABLE pasien (
    id_pasien INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    tanggal_lahir DATE,
    jenis_kelamin ENUM('Laki-laki', 'Perempuan'),
    alamat VARCHAR(200),
    no_telp VARCHAR(15)
);

CREATE TABLE dokter (
    id_dokter INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    spesialisasi VARCHAR(100),
    jadwal_praktek VARCHAR(50),
    no_telp VARCHAR(15)
);

CREATE TABLE obat (
    id_obat INT AUTO_INCREMENT PRIMARY KEY,
    nama_obat VARCHAR(100),
    jenis_obat VARCHAR(50),
    dosis VARCHAR(50),
    stok INT
);

CREATE TABLE kunjungan (
    id_kunjungan INT AUTO_INCREMENT PRIMARY KEY,
    id_pasien INT,
    id_dokter INT,
    tanggal_kunjungan DATE,
    keluhan VARCHAR(255),
    diagnosa VARCHAR(255),
    FOREIGN KEY (id_pasien) REFERENCES pasien(id_pasien),
    FOREIGN KEY (id_dokter) REFERENCES dokter(id_dokter)
);

CREATE TABLE resep (
    id_resep INT AUTO_INCREMENT PRIMARY KEY,
    id_kunjungan INT,
    id_obat INT,
    jumlah INT,
    aturan_pakai VARCHAR(255),
    FOREIGN KEY (id_kunjungan) REFERENCES kunjungan(id_kunjungan),
    FOREIGN KEY (id_obat) REFERENCES obat(id_obat)
);

CREATE TABLE transaksi (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    id_pasien INT,
    tanggal_transaksi DATE,
    jumlah INT,
    STATUS VARCHAR(20),
    valid BOOLEAN,
    FOREIGN KEY (id_pasien) REFERENCES pasien(id_pasien)
);

SHOW TABLES;

INSERT INTO pasien (nama, tanggal_lahir, jenis_kelamin, alamat, no_telp) VALUES
('Andi Saputra', '1990-05-14', 'Laki-laki', 'Jl. Merdeka No. 10, Nganjuk', '081234567890'),
('Rina Wulandari', '1985-08-23', 'Perempuan', 'Jl. Melati No. 5, Kediri', '081245678901'),
('Budi Santoso', '1978-12-11', 'Laki-laki', 'Jl. Mawar No. 15, Madiun', '081256789012'),
('Dewi Kartika', '1992-01-19', 'Perempuan', 'Jl. Kenanga No. 21, Blitar', '081267890123'),
('Hadi Pranoto', '1980-06-30', 'Laki-laki', 'Jl. Sukun No. 3, Malang', '081278901234'),
('Sri Rahayu', '1995-04-17', 'Perempuan', 'Jl. Anggrek No. 9, Surabaya', '081289012345'),
('Tono Wijaya', '1988-09-08', 'Laki-laki', 'Jl. Dahlia No. 18, Jombang', '081290123456'),
('Intan Permatasari', '1993-11-05', 'Perempuan', 'Jl. Flamboyan No. 12, Mojokerto', '081201234567'),
('Agus Saputro', '1981-03-27', 'Laki-laki', 'Jl. Cendana No. 6, Tulungagung', '081212345678'),
('Fitri Anjani', '1996-07-14', 'Perempuan', 'Jl. Teratai No. 14, Sidoarjo', '081223456789');

INSERT INTO pasien (nama, tanggal_lahir, jenis_kelamin, alamat, no_telp) VALUES
('Anisa Putri', '1986-05-11', 'Perempuan', 'Jl. Anggrek No. 3, Kediri', '081322341425');

INSERT INTO dokter (nama, spesialisasi, jadwal_praktek, no_telp) VALUES
('Dr. Siti Handayani', 'Umum', 'Senin - Jumat 08:00-12:00', '082112345678'),
('Dr. Budi Hartono', 'Pediatri', 'Senin & Kamis 10:00-14:00', '082223344556'),
('Dr. Lina Marlina', 'Gigi', 'Selasa & Jumat 09:00-13:00', '082334455667'),
('Dr. Agus Wirawan', 'Umum', 'Senin - Rabu 08:00-12:00', '082445566778'),
('Dr. Ratna Sari', 'Kulit', 'Rabu & Kamis 10:00-15:00', '082556677889');

INSERT INTO obat (nama_obat, jenis_obat, dosis, stok) VALUES
('Paracetamol', 'Analgesik', '500 mg', 100),
('Amoxicillin', 'Antibiotik', '500 mg', 50),
('Ibuprofen', 'Anti-inflamasi', '400 mg', 80),
('Cetirizine', 'Antihistamin', '10 mg', 70),
('Loperamide', 'Antidiare', '2 mg', 60),
('Omeprazole', 'Antasida', '20 mg', 40),
('Metformin', 'Antidiabetik', '500 mg', 30),
('Salbutamol', 'Bronkodilator', '2 mg', 90),
('Amlodipine', 'Antihipertensi', '5 mg', 25),
('Diazepam', 'Sedatif', '5 mg', 20);

INSERT INTO kunjungan (id_pasien, id_dokter, tanggal_kunjungan, keluhan, diagnosa) VALUES
(1, 1, '2025-04-10', 'Demam dan sakit kepala', 'Influenza ringan'),
(2, 2, '2025-04-11', 'Batuk berkepanjangan', 'Bronkitis'),
(3, 3, '2025-04-12', 'Gigi berlubang', 'Karies dentis'),
(4, 4, '2025-04-13', 'Ruam kulit', 'Dermatitis kontak'),
(5, 5, '2025-04-14', 'Sakit perut', 'Gastritis'),
(6, 1, '2025-04-15', 'Demam dan pilek', 'Flu'),
(7, 2, '2025-04-16', 'Anak rewel dan demam', 'Tonsilitis'),
(8, 1, '2025-04-17', 'Pusing dan lemas', 'Hipotensi'),
(9, 4, '2025-04-18', 'Gatal-gatal', 'Alergi kulit'),
(10, 3, '2025-04-19', 'Sakit gigi', 'Infeksi pulpa');

INSERT INTO resep (id_kunjungan, id_obat, jumlah, aturan_pakai) VALUES
(1, 1, 10, '3x1 setelah makan'),
(2, 2, 15, '3x1 sebelum makan'),
(3, 3, 10, '2x1 setelah makan'),
(4, 4, 10, '1x1 malam hari'),
(5, 5, 5, '2x1 sebelum makan'),
(6, 1, 8, '3x1 setelah makan'),
(7, 2, 10, '3x1 sebelum makan'),
(8, 9, 7, '1x1 setiap pagi'),
(9, 4, 12, '2x1 siang dan malam'),
(10, 3, 10, '3x1 setelah makan');

INSERT INTO transaksi (id_pasien, tanggal_transaksi, jumlah, STATUS, valid) VALUES
(3, '2025-05-03', 110885, 'non-aktif', FALSE),
(10, '2025-05-04', 127749, 'non-aktif', TRUE),
(3, '2025-05-02', 103731, 'aktif', TRUE),
(3, '2025-05-02', 131446, 'non-aktif', FALSE),
(3, '2025-04-16', 123571, 'aktif', TRUE),
(12, '2025-04-10', 138037, 'non-aktif', TRUE),
(12, '2025-04-12', 134730, 'non-aktif', TRUE),
(7, '2025-04-15', 115584, 'aktif', FALSE),
(13, '2025-04-23', 137150, 'pasif', TRUE),
(7, '2025-03-24', 147008, 'aktif', FALSE),
(1, '2025-03-21', 139827, 'aktif', FALSE),
(4, '2025-03-15', 80148, 'aktif', FALSE),
(10, '2025-03-03', 137872, 'pasif', FALSE),
(5, '2025-03-14', 134554, 'aktif', FALSE),
(12, '2024-10-27', 124594, 'pasif', TRUE),
(1, '2024-06-08', 133819, 'aktif', TRUE),
(5, '2024-05-10', 109990, 'aktif', TRUE),
(5, '2024-11-02', 143570, 'non-aktif', FALSE),
(7, '2024-07-19', 145345, 'non-aktif', TRUE),
(9, '2023-12-01', 121045, 'aktif', TRUE),
(2, '2023-08-01', 114000, 'pasif', FALSE),
(11, '2023-05-20', 130005, 'non-aktif', TRUE),
(6, '2023-04-13', 140200, 'aktif', FALSE),
(8, '2023-01-05', 150000, 'pasif', TRUE),
(4, '2022-12-25', 135000, 'aktif', FALSE),
(13, '2022-11-11', 142000, 'non-aktif', TRUE);

INSERT INTO transaksi (id_pasien, tanggal_transaksi, jumlah, STATUS, valid) VALUES
(9, '2025-05-08', 119000, 'aktif', TRUE);

TRUNCATE TABLE transaksi;

SELECT * FROM pasien;
SELECT * FROM dokter;
SELECT * FROM obat;
SELECT * FROM kunjungan;
SELECT * FROM resep;

#no 1
CREATE VIEW view_kunjungan_pasien_dokter AS
SELECT 
    k.id_kunjungan,
    p.nama AS nama_pasien,
    p.jenis_kelamin,
    p.tanggal_lahir,
    d.nama AS nama_dokter,
    d.spesialisasi,
    k.tanggal_kunjungan,
    k.keluhan,
    k.diagnosa
FROM kunjungan k
JOIN pasien p ON k.id_pasien = p.id_pasien
JOIN dokter d ON k.id_dokter = d.id_dokter;

SELECT * FROM view_kunjungan_pasien_dokter;

#no 2
CREATE VIEW view_resep_kunjungan_pasien AS
SELECT 
    k.id_kunjungan,
    p.nama AS nama_pasien,
    k.tanggal_kunjungan,
    k.keluhan,
    k.diagnosa,
    o.nama_obat,
    o.jenis_obat,
    r.jumlah,
    r.aturan_pakai
FROM resep r
JOIN kunjungan k ON r.id_kunjungan = k.id_kunjungan
JOIN pasien p ON k.id_pasien = p.id_pasien
JOIN obat o ON r.id_obat = o.id_obat;

SELECT * FROM view_resep_kunjungan_pasien;

#no 3
CREATE VIEW view_resep_jumlah_lebih_5 AS
SELECT 
    r.id_resep,
    r.id_kunjungan,
    o.nama_obat,
    o.jenis_obat,
    r.jumlah,
    r.aturan_pakai
FROM resep r
JOIN obat o ON r.id_obat = o.id_obat
WHERE r.jumlah > 5;

SELECT * FROM view_resep_jumlah_lebih_5;

#no 4
CREATE VIEW view_agregat_obat_resep AS
SELECT 
    o.jenis_obat,
    COUNT(r.id_resep) AS jumlah_resep,
    SUM(r.jumlah) AS total_obat_diresepkan,
    AVG(r.jumlah) AS rata_rata_jumlah
FROM resep r
JOIN obat o ON r.id_obat = o.id_obat
GROUP BY o.jenis_obat;

SELECT * FROM view_agregat_obat_resep;

#no 5
CREATE VIEW view_pasien_kunjungan_terbanyak_2025 AS
SELECT 
    p.id_pasien,
    p.nama AS nama_pasien,
    p.jenis_kelamin,
    p.tanggal_lahir,
    COUNT(k.id_kunjungan) AS total_kunjungan
FROM pasien p
JOIN kunjungan k ON p.id_pasien = k.id_pasien
WHERE YEAR(k.tanggal_kunjungan) = 2025
GROUP BY p.id_pasien, p.nama, p.jenis_kelamin, p.tanggal_lahir
ORDER BY total_kunjungan DESC;

SELECT * FROM view_pasien_kunjungan_terbanyak_2025;


#Modul3

#no1

DELIMITER //

CREATE PROCEDURE UpdateDataMaster(
    IN id INT,
    IN nilai_baru INT
)
BEGIN
    UPDATE obat
    SET stok = nilai_baru
    WHERE id_obat = id;
END//

DELIMITER ;

CALL UpdateDataMaster(1, 125);
SELECT * FROM obat WHERE id_obat = 1;

#no2

DELIMITER //

CREATE PROCEDURE CountTransaksi(OUT total_transaksi INT)

BEGIN
    SELECT COUNT(*) INTO total_transaksi FROM resep;
END//

DELIMITER ;

SELECT * FROM resep;
CALL CountTransaksi(@jumlah_resep);
SELECT @jumlah_resep;


#no3
DELIMITER //

CREATE PROCEDURE GetDataMasterByID(
    IN id_pasien_input INT,
    OUT nama_pasien VARCHAR(100),
    OUT tanggal_lahir_pasien DATE,
    OUT jenis_kelamin_pasien ENUM('Laki-laki', 'Perempuan'),
    OUT alamat_pasien VARCHAR(200),
    OUT no_telp_pasien VARCHAR(15)
)
BEGIN
    SELECT nama, tanggal_lahir, jenis_kelamin, alamat, no_telp
    INTO nama_pasien, tanggal_lahir_pasien, jenis_kelamin_pasien, alamat_pasien, no_telp_pasien
    FROM pasien
    WHERE id_pasien = id_pasien_input;
END //

DELIMITER ;

CALL GetDataMasterByID(1, @nama, @tgl_lahir, @jk, @alamat, @telp);
SELECT @nama, @tgl_lahir, @jk, @alamat, @telp;

#no4

DELIMITER //

CREATE PROCEDURE UpdateFieldTransaksi(
    IN id_kunjungan_input INT,
    INOUT keluhan_input VARCHAR(255),
    INOUT diagnosa_input VARCHAR(255)
)
BEGIN
    DECLARE keluhan_db VARCHAR(255);
    DECLARE diagnosa_db VARCHAR(255);

    -- Ambil data asli dari database
    SELECT keluhan, diagnosa INTO keluhan_db, diagnosa_db
    FROM kunjungan
    WHERE id_kunjungan = id_kunjungan_input;

    -- Jika input kosong atau NULL, gunakan nilai asli dari database
    IF keluhan_input IS NULL OR keluhan_input = '' THEN
        SET keluhan_input = keluhan_db;
    END IF;

    IF diagnosa_input IS NULL OR diagnosa_input = '' THEN
        SET diagnosa_input = diagnosa_db;
    END IF;

    -- Update data
    UPDATE kunjungan
    SET keluhan = keluhan_input,
        diagnosa = diagnosa_input
    WHERE id_kunjungan = id_kunjungan_input;
END //

DELIMITER ;

SET @keluhan = 'Flu';
SET @diagnosa = '';

CALL UpdateFieldTransaksi(6, @keluhan, @diagnosa);

-- Cek hasil:
SELECT * FROM kunjungan WHERE id_kunjungan = 6;

#no5

DELIMITER //

CREATE PROCEDURE DeleteEntriesByIDMaster(
    IN id_master INT
)
BEGIN
    -- Hapus entri resep yang terkait kunjungan pasien ini
    DELETE FROM resep
    WHERE id_kunjungan IN (
        SELECT id_kunjungan FROM kunjungan WHERE id_pasien = id_master
    );

    -- Hapus entri kunjungan pasien ini
    DELETE FROM kunjungan
    WHERE id_pasien = id_master;

    -- Hapus data pasien dari tabel master
    DELETE FROM pasien
    WHERE id_pasien = id_master;
END //

DELIMITER ;

CALL DeleteEntriesByIDMaster(10);

SELECT * FROM resep;

#modul4

#no1

ALTER TABLE resep
ADD COLUMN keterangan VARCHAR(255) AFTER aturan_pakai;

SELECT * FROM resep;

#no2

SELECT 
    r.id_resep,
    o.nama_obat,
    o.jenis_obat,
    r.jumlah,
    r.aturan_pakai
FROM resep r
JOIN obat o ON r.id_obat = o.id_obat;

#no3

SELECT * FROM resep
ORDER BY jumlah ASC;

SELECT * FROM resep
ORDER BY jumlah DESC;

#no4

ALTER TABLE obat
MODIFY stok SMALLINT;

DESC obat;

#no5

SELECT 
    p.nama AS nama_pasien,
    k.tanggal_kunjungan,
    k.diagnosa
FROM pasien p
LEFT JOIN kunjungan k ON p.id_pasien = k.id_pasien;

SELECT 
    d.nama AS nama_dokter,
    k.tanggal_kunjungan,
    k.keluhan
FROM kunjungan k
RIGHT JOIN dokter d ON k.id_dokter = d.id_dokter;

SELECT 
    A.nama AS pasien_1,
    B.nama AS pasien_2,
    A.alamat
FROM pasien A
JOIN pasien B ON A.alamat = B.alamat AND A.id_pasien <> B.id_pasien;

#no6

SELECT 
    p.nama,
    p.jenis_kelamin,
    p.tanggal_lahir,
    k.tanggal_kunjungan,
    k.diagnosa,
    o.stok,
    r.jumlah
FROM pasien p
JOIN kunjungan k ON p.id_pasien = k.id_pasien
JOIN resep r ON k.id_kunjungan = r.id_kunjungan
JOIN obat o ON r.id_obat = o.id_obat
WHERE 
    p.jenis_kelamin = 'Perempuan'            -- Sama dengan
    AND YEAR(p.tanggal_lahir) < 1990         -- Kurang dari
    AND o.stok >= 50                          -- Lebih dari atau sama dengan
    AND r.jumlah <> 10                        -- Tidak sama dengan
    AND k.tanggal_kunjungan >= '2025-04-10'  -- Mulai dari tanggal ini
    AND k.tanggal_kunjungan <= '2025-04-20'; -- Sampai tanggal ini

#modul5&6

#no1
DELIMITER //

CREATE PROCEDURE tampil_transaksi_1bulan()
BEGIN
    SELECT * FROM transaksi
    WHERE tanggal_transaksi >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
END //

DELIMITER ;

CALL tampil_transaksi_1bulan;

#no2
DELIMITER //

CREATE PROCEDURE hapus_transaksi_lama()
BEGIN
    DELETE FROM transaksi
    WHERE tanggal_transaksi < CURDATE() - INTERVAL 1 YEAR
      AND valid = TRUE;
END //

DELIMITER ;

SELECT * FROM transaksi;

CALL hapus_transaksi_lama();


#no3
DELIMITER //

CREATE PROCEDURE ubah_nonaktif_ke_aktif()
BEGIN
    UPDATE transaksi
    SET STATUS = 'aktif'
    WHERE id_transaksi IN (
        SELECT id_transaksi
        FROM (
            SELECT id_transaksi
            FROM transaksi
            WHERE STATUS = 'non-aktif'
            ORDER BY id_transaksi
            LIMIT 7
        ) AS sub
    );
END //

DELIMITER ;

CALL ubah_nonaktif_ke_aktif();

#no4
DELIMITER //

CREATE PROCEDURE edit_pasien_syarat(
    IN p_id INT,
    IN p_nama VARCHAR(100),
    IN p_alamat TEXT,
    IN p_no_telp VARCHAR(20)
)
BEGIN
    UPDATE pasien
    SET nama = p_nama,
        alamat = p_alamat,
        no_telp = p_no_telp
    WHERE id_pasien = p_id
      AND NOT EXISTS (
          SELECT 1 FROM transaksi WHERE id_pasien = p_id
      );
END //

DELIMITER ;

SELECT * FROM pasien;
SELECT * FROM transaksi;

CALL edit_pasien_syarat(14, 'anisaaa', 'Alamat Baru', '0899999999');

#no5
DELIMITER //

CREATE PROCEDURE update_status_transaksi_bulanan()
BEGIN
    DECLARE id_min INT;
    DECLARE id_max INT;
    DECLARE id_mid INT;

    -- Ambil id_transaksi dengan tanggal_transaksi paling lama dalam 1 bulan terakhir
    SELECT id_transaksi INTO id_min
    FROM transaksi
    WHERE tanggal_transaksi >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    ORDER BY tanggal_transaksi ASC
    LIMIT 1;

    -- Ambil id_transaksi dengan tanggal_transaksi paling baru dalam 1 bulan terakhir
    SELECT id_transaksi INTO id_max
    FROM transaksi
    WHERE tanggal_transaksi >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    ORDER BY tanggal_transaksi DESC
    LIMIT 1;

    -- Ambil id_transaksi dengan tanggal_transaksi di tengah (bukan paling lama/bukan terbaru)
    SELECT id_transaksi INTO id_mid
    FROM transaksi
    WHERE tanggal_transaksi >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
      AND id_transaksi NOT IN (id_min, id_max)
    ORDER BY tanggal_transaksi ASC
    LIMIT 1;

    -- Update status sesuai kategori tanggal (lama, tengah, terbaru)
    UPDATE transaksi
    SET STATUS = 'non-aktif'
    WHERE id_transaksi = id_min;

    UPDATE transaksi
    SET STATUS = 'pasif'
    WHERE id_transaksi = id_mid;

    UPDATE transaksi
    SET STATUS = 'aktif'
    WHERE id_transaksi = id_max;
END //

DELIMITER ;

SELECT * FROM transaksi;

CALL update_status_transaksi_bulanan();

#no6
DELIMITER //

CREATE PROCEDURE jumlah_transaksi_berhasil()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE trx_status VARCHAR(50);
    DECLARE total INT DEFAULT 0;
    DECLARE cur CURSOR FOR 
        SELECT STATUS FROM transaksi
        WHERE tanggal_transaksi >= CURDATE() - INTERVAL 1 MONTH;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO trx_status;
        IF done THEN
            LEAVE read_loop;
        END IF;

        IF trx_status = 'aktif' THEN
            SET total = total + 1;
        END IF;
    END LOOP;

    CLOSE cur;

    SELECT total AS jumlah_transaksi_aktif;
END //

DELIMITER ;

SELECT * FROM transaksi;

CALL jumlah_transaksi_berhasil();

#MODUL 7
#No1
DELIMITER //

CREATE TRIGGER before_insert_obat
BEFORE INSERT ON obat
FOR EACH ROW
BEGIN
    IF NEW.stok < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stok obat tidak boleh negatif.';
    END IF;
END;
//

DELIMITER ;

INSERT INTO obat (nama_obat, jenis_obat, dosis, stok)
VALUES ('Obat', 'Antibiotik', '500mg', -5);

DELIMITER //

CREATE TRIGGER before_update_no_telp_pasien
BEFORE UPDATE ON pasien
FOR EACH ROW
BEGIN
    IF CHAR_LENGTH(NEW.no_telp) < 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nomor telepon pasien minimal harus 10 digit.';
    END IF;
END;
//

DELIMITER ;

UPDATE pasien SET no_telp = '0812' WHERE id_pasien = 1;

DELIMITER //

CREATE TRIGGER before_delete_pasien
BEFORE DELETE ON pasien
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM kunjungan WHERE id_pasien = OLD.id_pasien
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tidak bisa menghapus pasien yang sudah memiliki riwayat kunjungan.';
    END IF;
END//

DELIMITER ;

DELETE FROM pasien WHERE id_pasien = 1;

#No2
DELIMITER //

CREATE TRIGGER after_insert_resep
AFTER INSERT ON resep
FOR EACH ROW
BEGIN
    UPDATE obat
    SET stok = stok - NEW.jumlah
    WHERE id_obat = NEW.id_obat;
END//

DELIMITER ;

INSERT INTO resep (id_kunjungan, id_obat, jumlah, aturan_pakai)
VALUES (1, 2, 7, '3x1 setelah makan');

SELECT * FROM resep;
SELECT * FROM obat;

DELIMITER //

CREATE TRIGGER after_update_resep
AFTER UPDATE ON resep
FOR EACH ROW
BEGIN
    -- Hitung selisih jumlah obat lama dan baru
    DECLARE selisih INT;
    SET selisih = OLD.jumlah - NEW.jumlah;

    -- Update stok obat sesuai selisih
    UPDATE obat
    SET stok = stok + selisih
    WHERE id_obat = NEW.id_obat;
END//

DELIMITER ;

UPDATE resep SET jumlah = 7 WHERE id_resep = 12;

DELIMITER //

CREATE TRIGGER after_delete_resep
AFTER DELETE ON resep
FOR EACH ROW
BEGIN
    UPDATE obat
    SET stok = stok + OLD.jumlah
    WHERE id_obat = OLD.id_obat;
END;
//

DELIMITER ;

DELETE FROM resep WHERE id_resep = 13;
SELECT * FROM resep;
SELECT * FROM obat;

