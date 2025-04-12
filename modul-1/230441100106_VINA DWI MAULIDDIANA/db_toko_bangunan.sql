CREATE DATABASE Toko_Bangunan;
USE Toko_Bangunan;

-- Membuat Tabel Master --

-- Membuat Tabel Kategori --
CREATE TABLE Kategori(
ID_Kategori INT PRIMARY KEY AUTO_INCREMENT, 
Kategori VARCHAR(100) NOT NULL
);

-- Membuat Tabel Supplier --
CREATE TABLE Supplier (
ID_Supplier INT AUTO_INCREMENT PRIMARY KEY, 
Nama_Supplier VARCHAR (100) NOT NULL, 
Alamat TEXT NOT NULL, 
No_Telfon VARCHAR (20) NOT NULL
);

-- Membuat Tabel Produk --
CREATE TABLE Produk(
ID_Produk INT AUTO_INCREMENT PRIMARY KEY, 
Nama_Produk VARCHAR (100) NOT NULL, 
Harga DECIMAL (14,2)NOT NULL, 
Stok INT NOT NULL, 
ID_Kategori INT NOT NULL,
FOREIGN KEY (ID_Kategori) REFERENCES Kategori(ID_Kategori)

);

-- Membuat Table Transksi --

-- Membuat Tabel Pembelian --
CREATE TABLE Pembelian(
ID_Pembelian INT AUTO_INCREMENT PRIMARY KEY,
Tanggal DATE NOT NULL,
ID_Supplier INT NOT NULL,
FOREIGN KEY (ID_Supplier)REFERENCES Supplier (ID_Supplier)
);

-- Membuat Tabel Detail Pembelian--
CREATE TABLE Detail_Pembelian(
ID_Detail INT AUTO_INCREMENT PRIMARY KEY, 
ID_Pembelian INT NOT NULL,
ID_Produk INT NOT NULL, 
Jumlah INT NOT NULL, 
Harga_Beli DECIMAL (14,2) NOT NULL,
FOREIGN KEY (ID_Pembelian) REFERENCES Pembelian(ID_Pembelian),
FOREIGN KEY (ID_Produk) REFERENCES Produk(ID_Produk)
);

-- Mengisikan data pada Tabel Kategori --
INSERT INTO Kategori (Kategori) VALUES
('Alat Bangunan'),
('Alat Listrik'),
('Cat dan Pelapis'),
('Plumbing');

-- Mengisikan data pada Tabel Supplier --
INSERT INTO Supplier (Nama_Supplier, Alamat, No_Telfon) VALUES
('PT. Bangun Jaya', 'Jl. Raya Cokro No. 1, Surabaya', '081234567890'),
('CV. Sumber Makmur', 'Jl. Mawar No. 10, Sidoarjo', '082233445566'),
('Toko Cahaya Abadi', 'Jl. Kenari No. 7, Malang', '081112223333'),
('CV. Karya Mandiri', 'Jl. Garuda No. 3, Gresik', '085612345678');

-- Mengisikan data pada Tabel Produk --
INSERT INTO Produk (Nama_Produk, Harga, Stok, ID_Kategori) VALUES
('Semen Gresik 50kg', 70000, 100, 1),
('Cat Tembok Avitex 5kg', 85000, 50, 3),
('Pipa PVC 3 inch', 20000, 75, 4),
('Stop Kontak Arde', 15000, 200, 2);

-- Mengisikan data pada Tabel Pembelian --
INSERT INTO Pembelian (Tanggal, ID_Supplier) VALUES
('2025-04-01', 1),
('2025-04-02', 2),
('2025-04-03', 3),
('2025-04-04', 4);

-- Mengisikan data pada Tabel Detail Pembelian-
INSERT INTO Detail_Pembelian (ID_Pembelian, ID_Produk, Jumlah, Harga_Beli) VALUES
(1, 1, 10, 68000),
(2, 2, 5, 83000),
(3, 3, 20, 19500),
(4, 4, 15, 14000);

SELECT * FROM Kategori;
SELECT * FROM Produk;
SELECT * FROM Supplier;
SELECT * FROM Pembelian;
SELECT * FROM Detail_Pembelian;