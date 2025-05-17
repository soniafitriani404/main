CREATE DATABASE penjualan_tanaman_hias;
USE penjualan_tanaman_hias;

CREATE TABLE kategori (
    id_kategori INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(100),
    keterangan TEXT
);

CREATE TABLE tanaman (
    id_tanaman INT PRIMARY KEY AUTO_INCREMENT,
    nama_tanaman VARCHAR(100),
    jenis VARCHAR(50),
    harga DECIMAL(10,2),
    stok INT,
    deskripsi TEXT,
    id_kategori INT,
    FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategori)
);

CREATE TABLE pelanggan (
    id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
    nama_pelanggan VARCHAR(100),
    alamat TEXT,
    no_hp VARCHAR(15)
);

CREATE TABLE penjualan (
    id_penjualan INT PRIMARY KEY AUTO_INCREMENT,
    id_pelanggan INT,
    tanggal_penjualan DATE,
    total_harga DECIMAL(12,2),
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan)
);

CREATE TABLE detail_penjualan (
    id_detail INT PRIMARY KEY AUTO_INCREMENT,
    id_penjualan INT,
    id_tanaman INT,
    jumlah INT,
    subtotal DECIMAL(12,2),
    FOREIGN KEY (id_penjualan) REFERENCES penjualan(id_penjualan),
    FOREIGN KEY (id_tanaman) REFERENCES tanaman(id_tanaman)
);

INSERT INTO kategori (nama_kategori, keterangan) VALUES
('Tanaman Hias Daun', 'Tanaman yang memiliki keindahan pada daun'),
('Tanaman Bunga', 'Tanaman yang berbunga indah dan berwarna-warni'),
('Kaktus', 'Tanaman berduri dan cocok untuk daerah kering');

INSERT INTO tanaman (nama_tanaman, jenis, harga, stok, deskripsi, id_kategori) VALUES
('Monstera', 'Indoor', 120000.00, 10, 'Tanaman daun besar berlubang, cocok untuk dekorasi ruangan', 1),
('Aglaonema', 'Indoor', 90000.00, 15, 'Tanaman daun hias dengan warna menarik', 1),
('Mawar Merah', 'Outdoor', 15000.00, 30, 'Bunga mawar berwarna merah cerah', 2),
('Kaktus Mini', 'Indoor', 25000.00, 25, 'Kaktus ukuran kecil, cocok untuk meja kerja', 3),
('Lavender', 'Outdoor', 40000.00, 20, 'Tanaman berbunga wangi yang menarik lebah', 2);

INSERT INTO pelanggan (nama_pelanggan, alamat, no_hp) VALUES
('Ayu Lestari', 'Jl. Melati No. 10', '081234567890'),
('Budi Santoso', 'Jl. Kenanga No. 22', '082112345678'),
('Clara Wijaya', 'Jl. Mawar No. 7', '085267890123');

-- update
ALTER TABLE penjualan ADD COLUMN STATUS VARCHAR(20) DEFAULT 'belum lunas';
INSERT INTO penjualan (id_pelanggan, tanggal_penjualan, total_harga, STATUS) VALUES
(1, '2025-04-10', 255000.00, 'belum lunas'),
(2, '2025-04-11', 40000.00, 'lunas'),
(1, '2025-04-11', 45000.00, 'belum lunas'),
(3, '2025-04-11', 275000.00, 'belum lunas'),
(1, '2025-04-15', 100000.00, 'belum lunas'),
(2, '2025-04-16', 50000.00, 'belum lunas'),
(3, '2025-04-17', 125000.00, 'lunas'),
(1, '2025-04-18', 85000.00, 'belum lunas');
(3, '2025-04-19', 10000.00, 'belum lunas');

INSERT INTO detail_penjualan (id_penjualan, id_tanaman, jumlah, subtotal) VALUES
(1, 1, 1, 120000.00),
(1, 3, 3, 45000.00),
(1, 4, 3, 90000.00),
(2, 5, 1, 40000.00),
(3, 2, 1, 90000.00),
(3, 1, 1, 120000.00),
(3, 3, 4, 60000.00);

SELECT * FROM tanaman;
SELECT * FROM kategori;
SELECT * FROM pelanggan;
SELECT * FROM penjualan;
SELECT * FROM detail_penjualan;


-- Modul 7
-- 1. 
-- a. TRIGGER BEFORE INSERT: Validasi harga & stok tanaman
DELIMITER //

CREATE TRIGGER before_insert_tanaman
BEFORE INSERT ON tanaman
FOR EACH ROW
BEGIN
    IF NEW.harga < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Harga tidak boleh negatif';
    END IF;
    IF NEW.stok < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stok tidak boleh negatif';
    END IF;
END;
//

DELIMITER ;

INSERT INTO tanaman (nama_tanaman, jenis, harga, stok, deskripsi, id_kategori)
VALUES ('Tanaman Tes', 'Indoor', -10000.00, 5, 'Tes tanaman negatif', 1);

SELECT * FROM tanaman;


-- b. TRIGGER BEFORE UPDATE: Validasi status penjualan
DELIMITER //

CREATE TRIGGER before_update_penjualan
BEFORE UPDATE ON penjualan
FOR EACH ROW
BEGIN
    IF NEW.status NOT IN ('lunas', 'belum lunas') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Status harus "lunas" atau "belum lunas"';
    END IF;
END;
//

DELIMITER ;

UPDATE penjualan SET STATUS = 'diproses' WHERE id_penjualan = 1;

SELECT * FROM penjualan;


-- c. TRIGGER BEFORE DELETE: Cegah hapus kategori yang masih digunakan
DELIMITER //

CREATE TRIGGER before_delete_kategori
BEFORE DELETE ON kategori
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM tanaman WHERE id_kategori = OLD.id_kategori) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tidak bisa menghapus kategori yang masih dipakai oleh tanaman';
    END IF;
END;
//

DELIMITER ;

DELETE FROM kategori WHERE id_kategori = 1;

SELECT * FROM tanaman;


-- 2. 
-- a. TRIGGER AFTER INSERT: Update total_harga di penjualan
DELIMITER //

CREATE TRIGGER after_insert_detail_penjualan
AFTER INSERT ON detail_penjualan
FOR EACH ROW
BEGIN
    UPDATE penjualan
    SET total_harga = (
        SELECT SUM(subtotal)
        FROM detail_penjualan
        WHERE id_penjualan = NEW.id_penjualan
    )
    WHERE id_penjualan = NEW.id_penjualan;
END;
//

DELIMITER ;

INSERT INTO detail_penjualan (id_penjualan, id_tanaman, jumlah, subtotal)
VALUES (1, 2, 2, 180000.00);
SELECT * FROM penjualan;
SELECT * FROM detail_penjualan;


-- b. TRIGGER AFTER UPDATE: Simpan log perubahan status penjualan
CREATE TABLE IF NOT EXISTS log_update_penjualan (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_penjualan INT,
    status_lama VARCHAR(20),
    status_baru VARCHAR(20),
    waktu_update DATETIME
);

DELIMITER //

CREATE TRIGGER after_update_penjualan
AFTER UPDATE ON penjualan
FOR EACH ROW
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO log_update_penjualan (id_penjualan, status_lama, status_baru, waktu_update)
        VALUES (OLD.id_penjualan, OLD.status, NEW.status, NOW());
    END IF;
END;
//

DELIMITER ;
UPDATE penjualan SET STATUS = 'belum lunas' WHERE id_penjualan = 2;
UPDATE penjualan SET STATUS = 'lunas' WHERE id_penjualan = 2;
SELECT * FROM penjualan;
SELECT * FROM log_update_penjualan;

-- c. TRIGGER AFTER DELETE: Simpan log penghapusan tanaman
CREATE TABLE IF NOT EXISTS log_hapus_tanaman (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    nama_tanaman VARCHAR(100),
    waktu_hapus DATETIME
);

DELIMITER //

CREATE TRIGGER after_delete_tanaman
AFTER DELETE ON tanaman
FOR EACH ROW
BEGIN
    INSERT INTO log_hapus_tanaman (nama_tanaman, waktu_hapus)
    VALUES (OLD.nama_tanaman, NOW());
END;
//

DELIMITER ;

DELETE FROM detail_penjualan WHERE id_tanaman = 1;
DELETE FROM tanaman WHERE id_tanaman = 1;

SELECT * FROM log_hapus_tanaman;
