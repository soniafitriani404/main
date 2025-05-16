-- Membuat database dan menggunakan db_studio_foto
CREATE DATABASE IF NOT EXISTS db_studio_foto;
USE db_studio_foto;

-- Tabel Pelanggan
CREATE TABLE IF NOT EXISTS Pelanggan (
    pelanggan_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    no_hp VARCHAR(15) NOT NULL,
    email VARCHAR(100),
    alamat TEXT
);

-- Tabel Paket
CREATE TABLE IF NOT EXISTS Paket (
    paket_id INT AUTO_INCREMENT PRIMARY KEY,
    nama_paket VARCHAR(100),
    harga DECIMAL(10, 2) NOT NULL
);

-- Tabel Fotografer
CREATE TABLE IF NOT EXISTS Fotografer (
    fotografer_id INT AUTO_INCREMENT PRIMARY KEY,
    nama_fotografer VARCHAR(100)
);

-- Tabel Fotografer_Paket (Relasi antara Fotografer dan Paket)
CREATE TABLE IF NOT EXISTS Fotografer_Paket (
    fotografer_id INT,
    paket_id INT,
    PRIMARY KEY (fotografer_id, paket_id),
    FOREIGN KEY (fotografer_id) REFERENCES Fotografer(fotografer_id),
    FOREIGN KEY (paket_id) REFERENCES Paket(paket_id)
);

-- Tabel Pemesanan
CREATE TABLE IF NOT EXISTS Pemesanan (
    pemesanan_id INT AUTO_INCREMENT PRIMARY KEY,
    pelanggan_id INT,
    paket_id INT,
    STATUS VARCHAR(50),
    tanggal_pemesanan DATETIME,
    FOREIGN KEY (pelanggan_id) REFERENCES Pelanggan(pelanggan_id),
    FOREIGN KEY (paket_id) REFERENCES Paket(paket_id)
);

-- Tabel Pembayaran
CREATE TABLE IF NOT EXISTS Pembayaran (
    pembayaran_id INT AUTO_INCREMENT PRIMARY KEY,
    pemesanan_id INT,
    jumlah DECIMAL(10, 2),
    tanggal_pembayaran DATETIME,
    FOREIGN KEY (pemesanan_id) REFERENCES Pemesanan(pemesanan_id)
);

-- Tabel HasilFoto
CREATE TABLE IF NOT EXISTS HasilFoto (
    hasil_id INT AUTO_INCREMENT PRIMARY KEY,
    pemesanan_id INT,
    nama_file VARCHAR(255),
    url_file VARCHAR(255),
    FOREIGN KEY (pemesanan_id) REFERENCES Pemesanan(pemesanan_id)
);

-- Trigger BEFORE INSERT pada Pelanggan
DELIMITER //
CREATE TRIGGER before_insert_pelanggan
BEFORE INSERT ON Pelanggan
FOR EACH ROW
BEGIN
    IF NEW.no_hp IS NULL OR NEW.no_hp = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nomor HP tidak boleh kosong!';
    END IF;
END;
//
DELIMITER ;

-- Trigger BEFORE UPDATE pada Paket
DELIMITER //
CREATE TRIGGER before_update_paket
BEFORE UPDATE ON Paket
FOR EACH ROW
BEGIN
    IF NEW.harga < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Harga paket tidak boleh negatif!';
    END IF;
END;
//
DELIMITER ;

-- Trigger BEFORE DELETE pada Fotografer
DELIMITER //
CREATE TRIGGER before_delete_fotografer
BEFORE DELETE ON Fotografer
FOR EACH ROW
BEGIN
    DECLARE jumlah_relasi INT;
    SELECT COUNT(*) INTO jumlah_relasi FROM Fotografer_Paket WHERE fotografer_id = OLD.fotografer_id;
    IF jumlah_relasi > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Fotografer masih terhubung ke paket!';
    END IF;
END;
//
DELIMITER ;

-- Trigger AFTER INSERT pada Pembayaran
DELIMITER //
CREATE TRIGGER after_insert_pembayaran
AFTER INSERT ON Pembayaran
FOR EACH ROW
BEGIN
    UPDATE Pemesanan
    SET STATUS = 'Diproses'
    WHERE pemesanan_id = NEW.pemesanan_id;
END;
//
DELIMITER ;

-- Trigger AFTER UPDATE pada Pemesanan
DELIMITER //
CREATE TRIGGER after_update_pemesanan
AFTER UPDATE ON Pemesanan
FOR EACH ROW
BEGIN
    IF OLD.STATUS <> NEW.STATUS THEN
        INSERT INTO HasilFoto (pemesanan_id, nama_file, url_file)
        VALUES (NEW.pemesanan_id, CONCAT('LOG_', NEW.STATUS), 'Perubahan status');
    END IF;
END;
//
DELIMITER ;

-- Trigger AFTER DELETE pada Pemesanan
DELIMITER //
CREATE TRIGGER after_delete_pemesanan
AFTER DELETE ON Pemesanan
FOR EACH ROW
BEGIN
    DELETE FROM HasilFoto WHERE pemesanan_id = OLD.pemesanan_id;
END;
//
DELIMITER ;

-- Contoh Operasi INSERT pada Pelanggan
INSERT INTO Pelanggan (nama, no_hp, email, alamat)
VALUES ('John Doe', '081234567890', 'john@example.com', 'Jl. ABC No. 123');

SELECT * FROM Pelanggan;

-- Contoh Operasi UPDATE pada Paket
INSERT INTO Paket (paket_id, nama_paket, harga)
VALUES (1, 'Paket Basic', 1000000)
ON DUPLICATE KEY UPDATE nama_paket = VALUES(nama_paket), harga = VALUES(harga);

SELECT * FROM Paket;

UPDATE Paket
SET harga = 1500000
WHERE paket_id = 1;

SELECT * FROM Paket;


-- Contoh Operasi DELETE pada Fotografer
DELETE FROM Fotografer
WHERE fotografer_id = 1;

-- Query untuk memeriksa data yang terpengaruh oleh trigger

-- 1. Menampilkan data Pelanggan setelah operasi INSERT
-- Ganti '081234567890' dengan nomor HP yang dimasukkan
SELECT * FROM Pelanggan WHERE no_hp = '081234567890';

-- 2. Menampilkan data Paket setelah operasi UPDATE
-- Ganti [ID_PAKET] dengan ID paket yang dimaksud
SELECT * FROM Paket WHERE paket_id = 1;

-- 3. Menampilkan data Fotografer_Paket sebelum operasi DELETE
-- Ganti [ID_FOTOGRAFER] dengan ID fotografer yang dimaksud
SELECT * FROM Fotografer_Paket WHERE fotografer_id = 1; 





