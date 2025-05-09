CREATE DATABASE db_penjualan_kain_tenun2;
USE db_penjualan_kain_tenun2;



-- Tabel Pelanggan
CREATE TABLE tbl_Pelanggan(
	id_pelanggan INT PRIMARY KEY,
	nama VARCHAR(50) NOT NULL,
	alamat VARCHAR(100),
	no_telepon VARCHAR(20)
);

INSERT INTO tbl_Pelanggan VALUES 
(101, 'Ibu Sari', 'Jl. Kenanga No.10', '081234567890'),
(102, 'Bapak Ahmad', 'Jl. Melati No.5', '085612345678'),
(103, 'Bu Rina', 'Jl. Mawar No.3', '089876543210'),
(104, 'Pak Budi', 'Jl. Anggrek No.2', '081122334455'),
(105, 'Ibu Tuti', 'Jl. Dahlia No.7', '082233445566'),
(106, 'Pak Joko', 'Jl. Flamboyan No.12', '083344556677'),
(107, 'Bu Lina', 'Jl. Cempaka No.8', '084455667788'),
(108, 'ayana', 'Jl. Pegangsaaan No.7', '0814532769042');



-- Tabel Produk Kain
CREATE TABLE tbl_ProdukKain(
	id_kain INT PRIMARY KEY,
	nama_kain VARCHAR(50),
	harga INT,
	stok INT
);

INSERT INTO tbl_ProdukKain VALUES 
(201, 'Tenun Ikat Sumba', 250000, 10),
(202, 'Tenun Troso', 300000, 5),
(203, 'Tenun Endek Bali', 200000, 15),
(204, 'Tenun Gringsing', 350000, 7),
(205, 'Tenun Jepara', 280000, 12),
(206, 'Tenun Sintang', 220000, 8),
(207, 'Tenun Sambas', 260000, 6);


-- Tabel Pegawai
CREATE TABLE tbl_Pegawai(
	id_pegawai INT PRIMARY KEY,
	nama_pegawai VARCHAR(50),
	jabatan VARCHAR(50)
);

INSERT INTO tbl_Pegawai VALUES 
(301, 'Dewi Lestari', 'Kasir'),
(302, 'Rudi Hartono', 'Admin'),
(303, 'Ayu Pratiwi', 'Sales'),
(304, 'Budi Santoso', 'Manajer'),
(305, 'Siti Aminah', 'Sales'),
(306, 'Andi Nugroho', 'Gudang'),
(307, 'Melati Putri', 'Customer Service');


-- Tabel Penjualan (dengan tambahan atribut)
CREATE TABLE tbl_Penjualan(
	id_penjualan INT PRIMARY KEY,
	id_pelanggan INT NOT NULL,
	id_pegawai INT NOT NULL,
	tanggal DATE,
	total INT,
	STATUS ENUM('Belum Dibayar', 'Lunas') DEFAULT 'Belum Dibayar', -- Ganti dari VARCHAR
	valid BOOLEAN DEFAULT TRUE,
	jumlah_transaksi INT DEFAULT 1
);

ALTER TABLE tbl_Penjualan
MODIFY STATUS ENUM('Belum Dibayar', 'Lunas', 'non-aktif', 'pasif', 'aktif') DEFAULT 'Belum Dibayar';


INSERT INTO tbl_Penjualan VALUES 
(401, 101, 301, '2025-05-08', 500000, 'Lunas', TRUE, 2),
(402, 102, 302, '2025-05-05', 300000, 'Lunas', TRUE, 1),
(403, 103, 303, '2025-05-01', 250000, 'Belum Dibayar', TRUE, 1),
(404, 101, 301, '2025-04-20', 150000, 'Belum Dibayar', TRUE, 1),
(405, 104, 303, '2025-04-01', 450000, 'Lunas', TRUE, 2),
(406, 105, 302, '2025-03-08', 350000, 'Lunas', TRUE, 1),
(407, 106, 301, '2025-02-15', 600000, 'Belum Dibayar', TRUE, 3),
(408, 107, 302, '2024-04-30', 400000, 'Lunas', TRUE, 1),
(409, 108, 301, '2024-03-15', 550000, 'Belum Dibayar', TRUE, 2),
(410, 109, 303, '2024-02-10', 200000, 'Lunas', TRUE, 1),
(411, 110, 302, '2024-01-05', 650000, 'Belum Dibayar', TRUE, 3);

DROP TABLE tbl_Pelanggan;



-- Tabel Detail Penjualan
CREATE TABLE tbl_DetailPenjualan(
	id_detail INT PRIMARY KEY,
	id_penjualan INT NOT NULL,
	id_kain INT NOT NULL,
	jumlah INT,
	subtotal INT
);

INSERT INTO tbl_DetailPenjualan VALUES 
(501, 401, 201, 2, 500000),
(502, 402, 203, 1, 200000),
(503, 403, 202, 3, 600000),
(504, 404, 201, 1, 150000),
(505, 405, 203, 2, 400000),
(506, 406, 202, 1, 350000),
(507, 407, 201, 3, 750000);


-- Lihat semua data
SELECT * FROM tbl_Pelanggan;
SELECT * FROM tbl_ProdukKain;
SELECT * FROM tbl_Pegawai;
SELECT * FROM tbl_Penjualan;
SELECT * FROM tbl_DetailPenjualan;



-- no 1
DELIMITER //

CREATE PROCEDURE sp_Penjualan_ByDurasi(
	IN pilihan_durasi VARCHAR(20)
)
BEGIN
	IF pilihan_durasi = '1_MINGGU' THEN
		SELECT * FROM tbl_Penjualan
		WHERE tanggal >= CURDATE() - INTERVAL 7 DAY;

	ELSEIF pilihan_durasi = '1_BULAN' THEN
		SELECT * FROM tbl_Penjualan
		WHERE tanggal >= CURDATE() - INTERVAL 1 MONTH;

	ELSEIF pilihan_durasi = '3_BULAN' THEN
		SELECT * FROM tbl_Penjualan
		WHERE tanggal >= CURDATE() - INTERVAL 3 MONTH;

	ELSE
		SELECT 'Pilihan durasi tidak valid. Gunakan: 1_MINGGU, 1_BULAN, atau 3_BULAN.' AS pesan;
	END IF;
END //

DELIMITER ;

CALL sp_Penjualan_ByDurasi('1_MINGGU');


-- no 2
DELIMITER //

CREATE PROCEDURE sp_HapusTransaksiLama()
BEGIN
	DELETE FROM tbl_Penjualan
	WHERE 
		tanggal < CURDATE() - INTERVAL 1 YEAR
		AND valid = TRUE
		AND STATUS = 'Lunas';
END //

DELIMITER ;

CALL sp_HapusTransaksiLama();


-- no 3
DELIMITER //

CREATE PROCEDURE ubahStatusPenjualan()
BEGIN
    
    UPDATE tbl_Penjualan
    SET STATUS = 'Lunas'
    WHERE STATUS = 'Belum Dibayar'
    ORDER BY tanggal ASC
    LIMIT 7;
END //

DELIMITER ;

CALL ubahStatusPenjualan();


DROP PROCEDURE IF EXISTS sp_TampilkanTransaksiBerdasarkanWaktu;


--  no 4

DELIMITER //

CREATE PROCEDURE editPelanggan(
    IN p_id INT,
    IN p_nama VARCHAR(50),
    IN p_alamat VARCHAR(100),
    IN p_no_telepon VARCHAR(20)
)
BEGIN
    -- Cek apakah pelanggan memiliki transaksi
    IF NOT EXISTS (
        SELECT 1 FROM tbl_Penjualan WHERE id_pelanggan = p_id
    ) THEN
        
        UPDATE tbl_Pelanggan
        SET nama = p_nama,
            alamat = p_alamat,
            no_telepon = p_no_telepon
        WHERE id_pelanggan = p_id;
    ELSE
       
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pelanggan tidak dapat diedit karena masih memiliki transaksi';
    END IF;
END //

DELIMITER ;

CALL editPelanggan(108, 'Ayana Takahashi', 'Jl. Pegangsaan Timur No.7', '081234567890');


-- no 5

DELIMITER //

CREATE PROCEDURE sp_UpdateStatusByTransaksi()
BEGIN
    DECLARE min_trans INT;
    DECLARE max_trans INT;

    -- Ambil jumlah transaksi terkecil dan terbesar dalam 1 bulan terakhir
    SELECT MIN(jumlah_transaksi), MAX(jumlah_transaksi)
    INTO min_trans, max_trans
    FROM tbl_Penjualan
    WHERE tanggal >= CURDATE() - INTERVAL 1 MONTH;

    -- Update transaksi paling sedikit jadi 'non-aktif'
    IF min_trans IS NOT NULL THEN
        UPDATE tbl_Penjualan
        SET STATUS = 'non-aktif'
        WHERE jumlah_transaksi = min_trans
          AND tanggal >= CURDATE() - INTERVAL 1 MONTH;
    END IF;

    -- Update transaksi paling banyak jadi 'aktif'
    IF max_trans IS NOT NULL THEN
        UPDATE tbl_Penjualan
        SET STATUS = 'aktif'
        WHERE jumlah_transaksi = max_trans
          AND tanggal >= CURDATE() - INTERVAL 1 MONTH;
    END IF;

    -- Update transaksi yang tidak min dan tidak max jadi 'pasif'
    IF min_trans IS NOT NULL AND max_trans IS NOT NULL THEN
        UPDATE tbl_Penjualan
        SET STATUS = 'pasif'
        WHERE jumlah_transaksi NOT IN (min_trans, max_trans)
          AND tanggal >= CURDATE() - INTERVAL 1 MONTH;
    END IF;
END//

DELIMITER ;


CALL sp_UpdateStatusByTransaksi();

SELECT id_pelanggan, jumlah_transaksi, STATUS
FROM tbl_Penjualan
WHERE tanggal >= CURDATE() - INTERVAL 1 MONTH;



-- no 6

DELIMITER //

CREATE PROCEDURE sp_TampilkanTransaksiBerhasil()
BEGIN
    DECLARE done INT DEFAULT FALSE;-- menandai apakah sudah mencapai akhir data
    DECLARE v_id INT;
    DECLARE v_tanggal DATE;
    DECLARE v_total INT;
    DECLARE v_counter INT DEFAULT 0;

    -- mengambil
    DECLARE cur CURSOR FOR
        SELECT id_penjualan, tanggal, total
        FROM tbl_Penjualan
        WHERE STATUS = 'aktif'
          AND tanggal >= CURDATE() - INTERVAL 1 MONTH;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE; -- bahwa jika cursor tidak menemukan data lagi

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_id, v_tanggal, v_total;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- menampilkan 
        SELECT CONCAT('ID: ', v_id, ' | Tanggal: ', v_tanggal, ' | Total: ', v_total) AS Info_Transaksi;

        -- Tambah counter
        SET v_counter = v_counter + 1;
    END LOOP;

    CLOSE cur;

    -- Tampilkan total transaksi berhasil
    SELECT CONCAT('Jumlah transaksi berhasil 1 bulan terakhir: ', v_counter) AS Total_Berhasil;

END//

DELIMITER ;

CALL sp_TampilkanTransaksiBerhasil();

DROP PROCEDURE IF EXISTS sp_UpdateStatusByTransaksi;

















-- no 6 
DELIMITER //

CREATE PROCEDURE sp_HitungLunasLooping()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_id INT;
    DECLARE total INT DEFAULT 0;

    -- Cursor untuk mengambil id_penjualan yang lunas dan dalam 1 bulan terakhir
    DECLARE cur CURSOR FOR 
        SELECT id_penjualan 
        FROM tbl_Penjualan
        WHERE STATUS = 'aktif'
          AND tanggal >= CURDATE() - INTERVAL 1 MONTH;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    loop_transaksi: LOOP
        FETCH cur INTO v_id;

        IF done THEN
            LEAVE loop_transaksi;
        END IF;

        SET total = total + 1;
    END LOOP;

    CLOSE cur;

    -- Tampilkan hasilnya
    SELECT CONCAT('Jumlah transaksi LUNAS 1 bulan terakhir: ', total) AS Total_Lunas;
END//

DELIMITER ;

CALL sp_HitungLunasLooping();













