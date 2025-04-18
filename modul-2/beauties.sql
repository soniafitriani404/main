CREATE DATABASE db_kosmetik;
USE db_kosmetik;

-- 1. Tabel Kategori
CREATE TABLE Kategori (
    id_kategori INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(50) NOT NULL
);

-- 2. Tabel Produk
CREATE TABLE Produk (
    id_produk INT PRIMARY KEY AUTO_INCREMENT,
    nama_produk VARCHAR(100) NOT NULL,
    harga DECIMAL(10,2),
    stok INT,
    id_kategori INT,
    FOREIGN KEY (id_kategori) REFERENCES Kategori(id_kategori)
);

-- 3. Tabel Pelanggan
CREATE TABLE Pelanggan (
    id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100),
    no_hp VARCHAR(15),
    alamat TEXT
);

-- 4. Tabel Penjualan
CREATE TABLE Penjualan (
    id_penjualan INT PRIMARY KEY AUTO_INCREMENT,
    tanggal DATE,
    id_pelanggan INT,
    total DECIMAL(12,2),
    FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan)
);

-- 5. Tabel Detail Penjualan
CREATE TABLE DetailPenjualan (
    id_detail INT PRIMARY KEY AUTO_INCREMENT,
    id_penjualan INT,
    id_produk INT,
    jumlah INT,
    subtotal DECIMAL(12,2),
    FOREIGN KEY (id_penjualan) REFERENCES Penjualan(id_penjualan),
    FOREIGN KEY (id_produk) REFERENCES Produk(id_produk)
);

INSERT INTO Kategori (nama_kategori) VALUES 
('Skincare'),
('Makeup'),
('Bodycare'),
('Haircare'),
('Fragrance'),
('Tools'),
('Masker'),
('Serum'),
('Toner'),
('Sunscreen');

INSERT INTO Produk (nama_produk, harga, stok, id_kategori) VALUES
('Moisturizer Glow', 95000, 20, 1),
('Facial Wash Lemon', 45000, 30, 1),
('Lip Cream Nude', 75000, 25, 2),
('Body Lotion Vanilla', 60000, 40, 3),
('Blush On Pinky', 80000, 15, 2),
('Shampoo Herbal', 55000, 50, 4),
('Parfum Floral', 120000, 35, 5),
('Beauty Blender', 30000, 60, 6),
('Sheet Mask Green Tea', 15000, 70, 7),
('Serum Brightening', 110000, 22, 8);

INSERT INTO Pelanggan (nama, no_hp, alamat) VALUES
('Ayu Lestari', '081234567890', 'Jl. Melati No. 10'),
('Rina Putri', '082134567891', 'Jl. Anggrek No. 21'),
('Sari Intan', '083134567892', 'Jl. Mawar No. 3'),
('Indah Permata', '084134567893', 'Jl. Kenanga No. 4'),
('Nina Salma', '085134567894', 'Jl. Teratai No. 5'),
('Tari Melati', '086134567895', 'Jl. Cempaka No. 6'),
('Lina Anjani', '087134567896', 'Jl. Sakura No. 7'),
('Dewi Oktavia', '088134567897', 'Jl. Dahlia No. 8'),
('Vina Kartika', '089134567898', 'Jl. Angsana No. 9'),
('Mega Ayuning', '081534567899', 'Jl. Bougenville No. 10');

INSERT INTO Penjualan (tanggal, id_pelanggan, total) VALUES
('2025-04-01', 1, 160000),
('2025-04-02', 2, 135000),
('2025-04-03', 3, 175000),
('2025-04-04', 4, 150000),
('2025-04-05', 5, 200000),
('2025-04-06', 6, 90000),
('2025-04-07', 7, 220000),
('2025-04-08', 8, 125000),
('2025-04-09', 9, 145000),
('2025-04-10', 10, 110000);

INSERT INTO DetailPenjualan (id_penjualan, id_produk, jumlah, subtotal) VALUES
(1, 1, 1, 95000),
(1, 2, 1, 45000),
(2, 3, 1, 75000),
(2, 5, 1, 60000),
(3, 4, 2, 120000),
(4, 6, 1, 55000),
(5, 7, 2, 240000),
(6, 8, 3, 90000),
(7, 10, 2, 220000),
(8, 9, 2, 30000);

SELECT * FROM Kategori;
SELECT * FROM Produk;
SELECT * FROM Pelanggan;
SELECT * FROM Penjualan;
SELECT * FROM DetailPenjualan;

