CREATE DATABASE PenyewaanRumah;
USE PenyewaanRumah;

-- Tabel Pemilik
CREATE TABLE Pemilik (
    id_pemilik INT PRIMARY KEY,
    nama_pemilik VARCHAR(255) NOT NULL,
    no_hp VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Tabel Rumah
CREATE TABLE Rumah (
    id_rumah INT PRIMARY KEY,
    alamat VARCHAR(255) NOT NULL,
    tipe VARCHAR(50) NOT NULL,
    harga_sewa DOUBLE NOT NULL,
    sts ENUM('Tersedia', 'Tidak Tersedia') DEFAULT 'Tersedia',
    id_pemilik INT NOT NULL,
    id_kompleks INT,
    FOREIGN KEY (id_pemilik) REFERENCES Pemilik(id_pemilik),
    FOREIGN KEY (id_kompleks) REFERENCES Kompleks(id_kompleks)
);

-- Tabel Penyewa
CREATE TABLE Penyewa (
    id_penyewa INT PRIMARY KEY,
    nama_penyewa VARCHAR(255) NOT NULL,
    no_ktp VARCHAR(20) UNIQUE NOT NULL,
    no_hp VARCHAR(15) NOT NULL,
    pekerjaan VARCHAR(100)
);

-- Tabel Penyewaan
CREATE TABLE Penyewaan (
    id_penyewaan INT PRIMARY KEY,
    id_rumah INT NOT NULL,
    id_penyewa INT NOT NULL,
    tanggal_mulai DATE NOT NULL,
    tanggal_selesai DATE NOT NULL,
    sts ENUM('Aktif', 'Selesai') DEFAULT 'Aktif',
    FOREIGN KEY (id_rumah) REFERENCES Rumah(id_rumah),
    FOREIGN KEY (id_penyewa) REFERENCES Penyewa(id_penyewa)
);

-- Tabel Pembayaran
CREATE TABLE Pembayaran (
    id_pembayaran INT PRIMARY KEY,
    id_penyewaan INT NOT NULL,
    tanggal_bayar DATE NOT NULL,
    jumlah_bayar DOUBLE NOT NULL,
    metode_pembayaran ENUM('Transfer Bank', 'Tunai', 'E-Wallet') NOT NULL,
    FOREIGN KEY (id_penyewaan) REFERENCES Penyewaan(id_penyewaan)
);

-- Tabel Kompleks
CREATE TABLE Kompleks (
    id_kompleks INT PRIMARY KEY,
    nama_kompleks VARCHAR(100) NOT NULL,
    alamat VARCHAR(255)
);

-- Tabel Fasilitas
CREATE TABLE Fasilitas (
    id_fasilitas INT PRIMARY KEY,
    nama_fasilitas VARCHAR(100),
    deskripsi TEXT
);

-- Data Pemilik
INSERT INTO Pemilik (id_pemilik, nama_pemilik, no_hp, email) VALUES
(1, 'Budi Santoso', '081234567890', 'budi@example.com'),
(2, 'Siti Aminah', '082345678901', 'siti@example.com'),
(3, 'Agus Prabowo', '081298765432', 'agus@example.com'),
(4, 'Dewi Kartika', '085612345678', 'dewi@example.com'),
(5, 'Rudi Hartono', '089912345678', 'rudi@example.com');

-- Data Kompleks
INSERT INTO Kompleks (id_kompleks, nama_kompleks, alamat) VALUES
(1, 'Kompleks Melati Indah', 'Jl. Melati Raya'),
(2, 'Kompleks Mawar Asri', 'Jl. Mawar Utama'),
(3, 'Kompleks Dahlia Sejahtera', 'Jl. Dahlia Raya');

-- Data Rumah (sudah disesuaikan id_kompleks)
INSERT INTO Rumah (id_rumah, alamat, tipe, harga_sewa, sts, id_pemilik, id_kompleks) VALUES
(1, 'Jl. Melati No. 5', 'Tipe 36', 15000000, 'Tersedia', 1, 1),
(2, 'Jl. Mawar No. 10', 'Tipe 45', 20000000, 'Tidak Tersedia', 2, 2),
(3, 'Jl. Anggrek No. 8', 'Tipe 60', 2500000, 'Tersedia', 1, 1),
(4, 'Jl. Kenanga No. 3', 'Tipe 70', 3000000, 'Tersedia', 3, 3),
(5, 'Jl. Dahlia No. 12', 'Tipe 36', 1400000, 'Tidak Tersedia', 4, 3),
(6, 'Jl. Bougenville No. 7', 'Tipe 90', 3500000, 'Tersedia', 5, 2),
(7, 'Jl. Flamboyan No. 9', 'Tipe 45', 2200000, 'Tersedia', 2, 1),
(8, 'Jl. Teratai No. 11', 'Tipe 36', 1600000, 'Tersedia', 3, 2);

-- Data Penyewa
INSERT INTO Penyewa (id_penyewa, nama_penyewa, no_ktp, no_hp, pekerjaan) VALUES
(1, 'Andi Wijaya', '3271012345678901', '089876543210', 'Karyawan Swasta'),
(2, 'Rina Lestari', '3271098765432109', '087654321098', 'Guru'),
(3, 'Eko Nugroho', '3201123456789001', '081311223344', 'Wiraswasta'),
(4, 'Maya Sari', '3271065432109876', '082233445566', 'Dosen'),
(5, 'Tono Rahman', '3271054321098765', '085266778899', 'Mahasiswa');

-- Data Fasilitas
INSERT INTO Fasilitas (id_fasilitas, nama_fasilitas, deskripsi) VALUES
(1, 'Kolam Renang', 'Kolam renang umum di tengah kompleks'),
(2, 'Taman Bermain', 'Area bermain untuk anak-anak'),
(3, 'Keamanan 24 Jam', 'Penjagaan dan CCTV'),
(4, 'Tempat Parkir', 'Area parkir luas untuk penghuni'),
(5, 'Lapangan Olahraga', 'Lapangan multifungsi untuk olahraga');

-- Data Penyewaan
INSERT INTO Penyewaan (id_penyewaan, id_rumah, id_penyewa, tanggal_mulai, tanggal_selesai, sts) VALUES
(1, 1, 1, '2025-01-01', '2025-06-01', 'Selesai'),
(2, 3, 2, '2025-03-01', '2025-09-01', 'Aktif'),
(3, 5, 3, '2025-02-01', '2025-07-01', 'Aktif'),
(4, 6, 4, '2025-03-01', '2025-09-01', 'Aktif'),
(5, 7, 5, '2025-04-01', '2025-10-01', 'Aktif');

-- Data Pembayaran
INSERT INTO Pembayaran (id_pembayaran, id_penyewaan, tanggal_bayar, jumlah_bayar, metode_pembayaran) VALUES
(1, 1, '2025-01-01', 2000000, 'Transfer Bank'),
(2, 1, '2025-02-01', 2000000, 'E-Wallet'),
(3, 2, '2025-04-01', 2500000, 'Tunai'),
(4, 3, '2025-02-01', 1400000, 'Transfer Bank'),
(5, 4, '2025-03-01', 3500000, 'E-Wallet'),
(6, 5, '2025-04-10', 2200000, 'Tunai');

-- =============================
-- VIEW-VIEW
-- =============================

-- View 1: Gabungan minimal 2 tabel
CREATE VIEW view_penyewa_rumah AS
SELECT py.nama_penyewa, r.alamat, r.tipe
FROM Penyewa py
JOIN Penyewaan p ON py.id_penyewa = p.id_penyewa
JOIN Rumah r ON p.id_rumah = r.id_rumah;

-- View 2: Gabungan minimal 3 tabel
CREATE VIEW view_detail_penyewaan AS
SELECT py.nama_penyewa, r.alamat, pm.jumlah_bayar, pm.metode_pembayaran
FROM Penyewa py
JOIN Penyewaan p ON py.id_penyewa = p.id_penyewa
JOIN Pembayaran pm ON p.id_penyewaan = pm.id_penyewaan
JOIN Rumah r ON p.id_rumah = r.id_rumah;

-- View 3: Dengan syarat tertentu
CREATE VIEW view_rumah_mahal AS
SELECT id_rumah, alamat, harga_sewa
FROM Rumah
WHERE harga_sewa > 1500000;

CREATE VIEW view_total_transaksi_pembayaran AS
SELECT 
    py.nama_penyewa,
    COUNT(pm.id_pembayaran) AS jumlah_transaksi,
    SUM(pm.jumlah_bayar) AS total_pembayaran,
    AVG(pm.jumlah_bayar) AS rata_rata_pembayaran,
    MAX(pm.jumlah_bayar) AS pembayaran_tertinggi,
    MIN(pm.jumlah_bayar) AS pembayaran_terendah
FROM Penyewa py
JOIN Penyewaan p ON py.id_penyewa = p.id_penyewa
JOIN Pembayaran pm ON p.id_penyewaan = pm.id_penyewaan
GROUP BY py.nama_penyewa;


-- View 4: Agregasi Total Pembayaran per Penyewa
CREATE VIEW view_total_pembayaran_penyewa AS
SELECT py.nama_penyewa, COUNT(pm.id_pembayaran) AS jumlah_transaksi, SUM(pm.jumlah_bayar) AS total_pembayaran
FROM Penyewa py
JOIN Penyewaan p ON py.id_penyewa = p.id_penyewa
JOIN Pembayaran pm ON p.id_penyewaan = pm.id_penyewaan
GROUP BY py.nama_penyewa;

-- View 5: Statistik rumah per kompleks
CREATE VIEW view_statistik_rumah_per_kompleks AS
SELECT k.nama_kompleks, COUNT(r.id_rumah) AS jumlah_rumah, AVG(r.harga_sewa) AS rata_harga_sewa
FROM Kompleks k
JOIN Rumah r ON k.id_kompleks = r.id_kompleks
GROUP BY k.nama_kompleks;


DROP VIEW view_rumah_mahal;
DROP TABLE Pembayaran;
DROP TABLE Penyewaan;
DROP TABLE Fasilitas;
DROP TABLE Penyewa;
DROP TABLE Rumah;
DROP TABLE Kompleks;
DROP TABLE Pemilik;