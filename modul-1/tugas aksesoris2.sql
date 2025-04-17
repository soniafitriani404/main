
CREATE DATABASE aksesoris_cewek;
USE aksesoris cewek;

-- Tabel Master

-- 1. Tabel Kategori
CREATE TABLE tbl_kategori (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL
);


INSERT INTO tbl_kategori (nama_kategori) VALUES
('Cincin'),
('Kalung'),
('Gelang');



-- 2. Tabel Produk
CREATE TABLE tbl_produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    nama_produk VARCHAR(150) NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    stok INT NOT NULL,
    id_kategori INT,
    FOREIGN KEY (id_kategori) REFERENCES tbl_kategori(id_kategori) ON DELETE SET NULL
);

INSERT INTO tbl_produk (nama_produk, harga, stok, id_kategori) VALUES
('Cincin Perak', 50000, 10, 1),
('Kalung Emas', 250000, 5, 2),
('Gelang Mutiara', 100000, 7, 3);


-- 3. Tabel Pelanggan
CREATE TABLE tbl_pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama_pelanggan VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    alamat TEXT NOT NULL
);

INSERT INTO tbl_pelanggan (nama_pelanggan, email, alamat) VALUES
('Siti Aisyah', 'siti@gmail.com', 'Jakarta'),
('Rina Putri', 'rina@gmail.com', 'Surabaya');

-- Tabel Transaksi

-- 4. Tabel Transaksi
CREATE TABLE tbl_transaksi (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT,
    tanggal_transaksi DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_harga DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pelanggan) REFERENCES tbl_pelanggan(id_pelanggan) ON DELETE CASCADE
);

INSERT INTO tbl_transaksi (id_pelanggan, tanggal_transaksi, total_harga) VALUES
(1, '2025-03-30', 300000),
(2, '2025-03-29', 100000);


-- 5. Tabel Detail Transaksi
CREATE TABLE tbl_detail_transaksi (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_transaksi INT,
    id_produk INT,
    jumlah INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_transaksi) REFERENCES tbl_transaksi(id_transaksi) ON DELETE CASCADE,
    FOREIGN KEY (id_produk) REFERENCES tbl_produk(id_produk) ON DELETE CASCADE
);

INSERT INTO tbl_detail_transaksi (id_transaksi, id_produk, jumlah, subtotal) VALUES
(1, 1, 1, 50000),      -- Siti beli 1x Cincin Perak
(1, 2, 1, 250000),     -- Siti beli 1x Kalung Emas
(2, 3, 1, 100000);     -- Rina beli 1x Gelang Mutiara


SELECT * FROM tbl_transaksi;
SELECT * FROM tbl_kategori;
SELECT * FROM tbl_detail_transaksi;
SELECT * FROM tbl_pelanggan;
SELECT * FROM tbl_produk;
