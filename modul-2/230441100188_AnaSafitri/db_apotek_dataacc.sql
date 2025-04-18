CREATE DATABASE db_apotek;
USE db_apotek;

CREATE TABLE USER (
    Id_User INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PASSWORD VARCHAR(255) NOT NULL,
    Jabatan VARCHAR(50) NOT NULL
);

CREATE TABLE Pegawai (
    Id_Pegawai INT AUTO_INCREMENT PRIMARY KEY,
    Id_User INT NOT NULL,
    Nama VARCHAR(100) NOT NULL,
    Alamat TEXT NOT NULL,
    No_HP VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    JenisKelamin ENUM('Laki-laki', 'Perempuan') NOT NULL,
    FOREIGN KEY (Id_User) REFERENCES USER(Id_User) ON DELETE CASCADE
);

CREATE TABLE Pembeli (
    Id_Pembeli INT AUTO_INCREMENT PRIMARY KEY,
    Id_User INT NOT NULL,
    Nama VARCHAR(100) NOT NULL,
    Alamat TEXT NOT NULL,
    No_HP VARCHAR(20) NOT NULL,
    Keluhan_Sakit VARCHAR(255),
    Tgl_Lahir DATE NOT NULL,
    FOREIGN KEY (Id_User) REFERENCES USER(Id_User) ON DELETE CASCADE
);

CREATE TABLE Produsen (
    Id_Produsen INT AUTO_INCREMENT PRIMARY KEY,
    Id_User INT NOT NULL,
    Nama VARCHAR(100) NOT NULL,
    Alamat TEXT NOT NULL,
    FOREIGN KEY (Id_User) REFERENCES USER(Id_User) ON DELETE CASCADE
);

CREATE TABLE Obat (
    Id_Obat INT AUTO_INCREMENT PRIMARY KEY,
    Id_Produsen INT NOT NULL,
    Id_User INT NOT NULL,
    Nama VARCHAR(100) NOT NULL,
    Deskripsi TEXT,
    Stok INT NOT NULL CHECK (Stok >= 0),
    Kategori VARCHAR(50),
    Harga DECIMAL(10,2) NOT NULL CHECK (Harga > 0),
    FOREIGN KEY (Id_Produsen) REFERENCES Produsen(Id_Produsen) ON DELETE CASCADE,
    FOREIGN KEY (Id_User) REFERENCES USER(Id_User) ON DELETE CASCADE
);

CREATE TABLE Penjualan (
    Id_Penjualan INT AUTO_INCREMENT PRIMARY KEY,
    Id_Obat INT NOT NULL,
    Id_User INT NOT NULL,
    Total INT NOT NULL CHECK (Total > 0),
    Jumlah_Bayar DECIMAL(10,2) NOT NULL CHECK (Jumlah_Bayar > 0),
    FOREIGN KEY (Id_Obat) REFERENCES Obat(Id_Obat) ON DELETE CASCADE,
    FOREIGN KEY (Id_User) REFERENCES USER(Id_User) ON DELETE CASCADE
);

CREATE TABLE Pembelian (
    Id_Pembelian INT AUTO_INCREMENT PRIMARY KEY,
    Id_Pembeli INT NOT NULL,
    Id_Produsen INT NOT NULL,
    Tgl_Transaksi DATE NOT NULL,
    Jumlah INT NOT NULL CHECK (Jumlah > 0),
    FOREIGN KEY (Id_Pembeli) REFERENCES Pembeli(Id_Pembeli) ON DELETE CASCADE,
    FOREIGN KEY (Id_Produsen) REFERENCES Produsen(Id_Produsen) ON DELETE CASCADE
);

-- Tabel USER
INSERT INTO USER (Username, Email, PASSWORD, Jabatan) VALUES
('admin_super', 'admin@medicorps.com', 'hashed_admin_pass', 'Admin'),
('dina_pegawai', 'dina@medicorps.com', 'hashed_dina_pass', 'Pegawai'),
('rian_pembeli', 'rian@gmail.com', 'hashed_rian_pass', 'Pembeli'),
('sari_pembeli', 'sari@gmail.com', 'hashed_sari_pass', 'Pembeli'),
('pharma_industri', 'pharma@industri.com', 'hashed_pharma_pass', 'Produsen'),
('natural_heal', 'contact@naturalheal.com', 'hashed_natural_pass', 'Produsen');

-- Tabel Pegawai
INSERT INTO Pegawai (Id_User, Nama, Alamat, No_HP, Email, JenisKelamin) VALUES
(4, 'Muhammad Maul', 'Jl. Haji Sudirman, Bogor', '08265367823', 'maul123@medicorps.com', 'Laki-laki');

-- Tabel Pembeli
INSERT INTO Pembeli (Id_User, Nama, Alamat, No_HP, Keluhan_Sakit, Tgl_Lahir) VALUES
(1, 'Maya Putri', 'Jl. Majapahit No.002, Madura', '08523829128', 'Infeksi Bakteri', '2003-04-19'),
(2, 'Fitriana Ashifa', 'Jl. Pahlawan No.10, Bandung', '08526472892', 'Demam', '1998-07-22'),
(3, 'Rian Pratama', 'Jl. Jambu No.20, Bandung', '082198765432', 'Demam', '1990-04-10'),
(4, 'Sari Ayu', 'Jl. Mangga No.45, Surabaya', '085212345678', 'Demam', '2001-01-25'),
(5, 'Dewi Septiyanti', 'Jl. Maritim No.45, Madura', '08522102040', 'Pegal-pegal', '1993-06-15');

SELECT * FROM Pembeli;

-- Tabel Produsen
INSERT INTO Produsen (Id_User, Nama, Alamat) VALUES
(2, 'Penempah Rempah Indonesia', 'Jl. Angkrek Timur, Taman Indah'),
(5, 'Pharma Industri Tbk', 'Kawasan Industri Pulogadung, Jakarta'),
(6, 'Natural Heal Indonesia', 'Jl. Organik Hijau No.3, Bogor');

-- Tabel Obat
INSERT INTO Obat (Id_Produsen, Id_User, Nama, Deskripsi, Stok, Kategori, Harga) VALUES
(1, 5, 'Paracetamol 500mg', 'Obat untuk meredakan nyeri dan menurunkan demam', 200, 'Analgesik', 3500.00),
(1, 5, 'Amoxicillin 500mg', 'Antibiotik untuk mengatasi infeksi bakteri', 120, 'Antibiotik', 7500.00),
(2, 6, 'Herbal Relax', 'Obat herbal untuk membantu tidur nyenyak', 60, 'Herbal', 12000.00),
(2, 6, 'Anti Masuk Angin', 'Obat tradisional untuk masuk angin dan pegal-pegal', 90, 'Herbal', 9500.00),
(5, 4, 'Flukadek', 'Obat untuk mengatasi demam, flu dan pusing', 100, 'Analgesik', 10000.00); 

-- Tabel Penjualan
INSERT INTO Penjualan (Id_Obat, Id_User, Total, Jumlah_Bayar) VALUES
(1, 3, 3, 10500.00), 
(2, 4, 2, 15000.00), 
(4, 3, 1, 9500.00),  
(3, 4, 1, 12000.00); 

-- Tabel Pembelian
INSERT INTO Pembelian (Id_Pembeli, Id_Produsen, Tgl_Transaksi, Jumlah) VALUES
(4, 1, '2025-04-02', 5), 
(6, 2, '2025-04-05', 3), 
(8, 2, '2025-04-08', 2),
(6, 2, '2025-04-11', 5),
(4, 2, '2025-04-23', 1),
(5, 7, '2025-04-10', 3);


-- 1. VIEW dengan dua table --
CREATE OR REPLACE VIEW view_user_pembeli AS
SELECT 
    u.Id_User,
    u.Username,
    u.Email AS Email_User,
    p.Id_Pembeli,
    p.Nama AS Nama_Pembeli,
    p.Alamat,
    p.No_HP,
    p.Keluhan_Sakit,
    p.Tgl_Lahir
FROM USER u
JOIN Pembeli p ON u.Id_User = p.Id_User;

SELECT * FROM view_user_pembeli;

-- 2. VIEW dengan tiga table --
CREATE OR REPLACE VIEW view_info_penjualan_obat AS
SELECT 
    pj.Id_Penjualan,
    ob.Nama AS Nama_Obat,
    ob.Kategori,
    ob.Harga,
    u.Username AS Nama_Pembeli,
    pj.Total,
    pj.Jumlah_Bayar,
    pj.Tgl_Transaksi
FROM Penjualan pj
JOIN Obat ob ON pj.Id_Obat = ob.Id_Obat
JOIN USER u ON pj.Id_User = u.Id_User;

SELECT * FROM view_info_penjualan_obat;

-- 3. VIEW yang memenuhi syarat --
CREATE VIEW view_pembelian_aktif AS
SELECT 
    pbl.Id_Pembelian,
    pb.Nama AS Nama_Pembeli,
    ps.Nama AS Nama_Produsen,
    pbl.Tgl_Transaksi,
    pbl.Jumlah
FROM Pembelian pbl
JOIN Pembeli pb ON pbl.Id_Pembeli = pb.Id_Pembeli
JOIN Produsen ps ON pbl.Id_Produsen = ps.Id_Produsen
WHERE pbl.Jumlah > 2;

SELECT * FROM view_pembelian_aktif;

DROP VIEW view_pembelian_aktif;

-- 4. Buatlah view yang menampilkan hasil dari fungsi agregasi (SUM, AVG, COUNT, MIN, atau MAX) pada data yang berasal dari minimal 2 tabel 
CREATE VIEW view_rata_rata_harga_per_kategori AS
SELECT 
    ob.Kategori,
    AVG(ob.Harga) AS Rata_Rata_Harga
FROM Penjualan pj
JOIN Obat ob ON pj.Id_Obat = ob.Id_Obat
GROUP BY ob.Kategori;

SELECT * FROM view_rata_rata_harga_per_kategori;

-- 5. Buat VIEW yang berguna untuk informasi data
CREATE VIEW view_total_penjualan_per_obat AS
SELECT 
    ob.Nama AS Nama_Obat,
    SUM(pj.Jumlah_Bayar) AS Total_Pendapatan,
    COUNT(pj.Id_Penjualan) AS Jumlah_Transaksi
FROM Penjualan pj
JOIN Obat ob ON pj.Id_Obat = ob.Id_Obat
GROUP BY ob.Nama;

SELECT * FROM view_total_penjualan_per_obat;