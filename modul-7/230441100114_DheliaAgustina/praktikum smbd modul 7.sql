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

INSERT INTO tbl_pegawai VALUES
(309, ' aya', 'Manajer');





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
-- insert
DELIMITER //
CREATE TRIGGER trg_before_insert_penjualan
BEFORE INSERT ON tbl_Penjualan
FOR EACH ROW
BEGIN
    IF NEW.total < 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Total penjualan tidak boleh negatif!';
    END IF;
END;
//
DELIMITER ;

INSERT INTO tbl_Penjualan(id_penjualan, id_pelanggan, id_pegawai, tanggal, total, STATUS)
VALUES (412, 101, 301, '2025-05-14', -100000, 'Belum Dibayar');

INSERT INTO tbl_Penjualan(id_penjualan, id_pelanggan, id_pegawai, tanggal, total, STATUS)
VALUES (412, 101, 301, '2025-05-14', 100000, 'Belum Dibayar');

SELECT * FROM tbl_Penjualan;


-- update
DELIMITER //
CREATE TRIGGER trg_before_update_harga_produk
BEFORE UPDATE ON tbl_ProdukKain
FOR EACH ROW
BEGIN
    IF NEW.harga <= 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Harga kain harus lebih dari 0!';
    END IF;
END;
//
DELIMITER ;

UPDATE tbl_ProdukKain
SET harga = -750000
WHERE id_kain = 201;

SELECT * FROM tbl_ProdukKain;

DROP TRIGGER IF EXISTS trg_before_update_harga_produk;

-- delete
DELIMITER //
CREATE TRIGGER trg_before_delete_pegawai
BEFORE DELETE ON tbl_Pegawai
FOR EACH ROW
BEGIN
    IF OLD.jabatan = 'Manajer' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Pegawai dengan jabatan Manajer tidak boleh dihapus!';
    END IF;
END;
//
DELIMITER ;

DELETE FROM tbl_Pegawai
WHERE id_pegawai = 305;  -- id_pegawai 305 adalah Sales

DELETE FROM tbl_Pegawai
WHERE id_pegawai = 309;  -- id_pegawai 304 adalah Manajer ini akan error

SELECT * FROM tbl_Pegawai;

INSERT INTO tbl_pegawai 



-- No 2
-- insert
DELIMITER //

CREATE TRIGGER trg_after_insert_detailpenjualan
AFTER INSERT ON tbl_DetailPenjualan
FOR EACH ROW
BEGIN
    UPDATE tbl_ProdukKain
    SET stok = stok - NEW.jumlah
    WHERE id_kain = NEW.id_kain;
END;
//

DELIMITER ;


INSERT INTO tbl_DetailPenjualan(id_detail, id_penjualan, id_kain, jumlah, subtotal)
VALUES (510, 401, 201, 2, 500000);

SELECT * FROM tbl_DetailPenjualan;
SELECT * FROM tbl_ProdukKain;


-- update 

-- Buat tabel log sederhana
CREATE TABLE log_status_lunas (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_penjualan INT,
    waktu TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger-nya
DELIMITER //
CREATE TRIGGER trg_after_update_penjualan
AFTER UPDATE ON tbl_Penjualan
FOR EACH ROW
BEGIN
    IF NEW.status = 'Lunas' AND OLD.status != 'Lunas' THEN
        INSERT INTO log_status_lunas(id_penjualan)
        VALUES (NEW.id_penjualan);
    END IF;
END;
//
DELIMITER ;

UPDATE tbl_Penjualan
SET STATUS = 'Lunas'
WHERE id_penjualan = 401;


SELECT * FROM tbl_Penjualan;

SELECT * FROM log_status_lunas;

-- delete
DELIMITER //
CREATE TRIGGER trg_after_delete_detailpenjualan
AFTER DELETE ON tbl_DetailPenjualan
FOR EACH ROW
BEGIN
    UPDATE tbl_ProdukKain
    SET stok = stok + OLD.jumlah
    WHERE id_kain = OLD.id_kain;
END;
//
DELIMITER ;

DELETE FROM tbl_DetailPenjualan
WHERE id_detail = 508;


SELECT * FROM  tbl_DetailPenjualan;
SELECT * FROM  tbl_ProdukKain;