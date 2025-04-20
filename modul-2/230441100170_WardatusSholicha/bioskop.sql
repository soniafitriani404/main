CREATE DATABASE bioskop;
USE bioskop;

CREATE TABLE USER (
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    no_hp VARCHAR(15)
);

-- 3. Tabel Teater
CREATE TABLE Teater (
    id_teater INT AUTO_INCREMENT PRIMARY KEY,
    nama_teater VARCHAR(50),
    kapasitas INT
);

-- 4. Tabel Film
CREATE TABLE Film (
    id_film INT AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(100),
    genre VARCHAR(50),
    durasi INT
);

-- 5. Tabel Kursi
CREATE TABLE Kursi (
    id_kursi INT AUTO_INCREMENT PRIMARY KEY,
    id_teater INT,
    kode_kursi VARCHAR(5),
    FOREIGN KEY (id_teater) REFERENCES Teater(id_teater)
);

-- 6. Tabel Jadwal
CREATE TABLE Jadwal (
    jadwal_id INT AUTO_INCREMENT PRIMARY KEY,
    id_film INT,
    id_teater INT,
    tanggal DATE,
    jam TIME,
    FOREIGN KEY (id_film) REFERENCES Film(id_film),
    FOREIGN KEY (id_teater) REFERENCES Teater(id_teater)
);

-- 7. Tabel Transaksi
CREATE TABLE Transaksi (
    transaksi_id INT AUTO_INCREMENT PRIMARY KEY,
    kode_transaksi VARCHAR(20) UNIQUE,
    id_user INT,
    jadwal_id INT,
    tanggal_pesan DATE,
    waktu_pesan DATETIME DEFAULT CURRENT_TIMESTAMP,
    metode_pembayaran ENUM('Cash', 'QRIS', 'Transfer', 'E-Wallet'),
    status_pembayaran ENUM('Menunggu', 'Lunas', 'Dibatalkan') DEFAULT 'Menunggu',
    total_bayar DECIMAL(10,2),
    FOREIGN KEY (id_user) REFERENCES USER(id_user),
    FOREIGN KEY (jadwal_id) REFERENCES Jadwal(jadwal_id)
);

-- 8. Tabel Detail Transaksi
CREATE TABLE Detail_Transaksi (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    transaksi_id INT,
    id_kursi INT,
    FOREIGN KEY (transaksi_id) REFERENCES Transaksi(transaksi_id),
    FOREIGN KEY (id_kursi) REFERENCES Kursi(id_kursi)
);

-- USER (Akun)
INSERT INTO USER (nama, email, no_hp) VALUES
('Diah Ayu', 'diahayu@gmail.com', '085854111594'),
('Icha', 'itscha@gmail.com', '083119437004');

-- Film
INSERT INTO Film (judul, genre, durasi) VALUES
('The Conjuring', 'Horor', 120),
('The Scream', 'Thriller', 145);

-- Teater
INSERT INTO Teater (nama_teater, kapasitas) VALUES
('Teater 1', 50),
('Teater 2', 70);

-- Kursi
INSERT INTO Kursi (id_teater, kode_kursi) VALUES
(1, 'A1'),
(1, 'A2'),
(2, 'B1'),
(2, 'B5');

-- Jadwal Tayang
INSERT INTO Jadwal (id_film, id_teater, tanggal, jam) VALUES
(1, 1, '2025-04-27', '14:15:00'),
(2, 2, '2025-04-27', '15:00:00');

-- Transaksi
INSERT INTO Transaksi (kode_transaksi, id_user, jadwal_id, tanggal_pesan, metode_pembayaran, status_pembayaran, total_bayar)
VALUES
('INV20250426001', 1, 1, '2025-04-26', 'QRIS', 'Lunas', 60000.00),
('INV20250425001', 2, 2, '2025-04-25', 'E-Wallet', 'Menunggu', 35000.00);

-- Detail Kursi yang Dipesan
INSERT INTO Detail_Transaksi (transaksi_id, id_kursi) VALUES
(1, 1), -- A1
(1, 2), -- A2
(2, 3); 

INSERT INTO USER (nama, email, no_hp) VALUES
('Natasya', 'tasya@gmail.com', '082233445566'),
('Fikri', 'Fikri@gmail.com', '081288776655'),
('Yuli', 'Yulyuli@gmail.com', '085644332211'),
('Yakin', 'kin123@gmail.com', '082166553322'),
('Lanny', 'LannyAp@gmail.com', '081355667788');

INSERT INTO Film (judul, genre, durasi) VALUES
('Avengers: Endgame', 'Action', 180),
('Frozen II', 'Animasi', 110),
('A Quiet Place', 'Horor', 95),
('Parasite', 'Drama', 132),
('Inception', 'Sci-Fi', 148);

INSERT INTO Teater (nama_teater, kapasitas) VALUES
('Teater 3', 60),
('Teater 4', 80),
('Teater 5', 100),
('Studio 2', 30),
('Studio 4', 40);

INSERT INTO Kursi (id_teater, kode_kursi) VALUES
(3, 'C1'),
(3, 'C2'),
(4, 'D1'),
(5, 'E1'),
(5, 'E2');

INSERT INTO Jadwal (id_film, id_teater, tanggal, jam) VALUES
(3, 3, '2025-04-28', '17:30:00'),
(4, 4, '2025-04-28', '19:00:00'),
(5, 5, '2025-04-29', '20:00:00'),
(6, 1, '2025-04-29', '18:15:00'),
(7, 2, '2025-04-30', '13:45:00');

INSERT INTO Transaksi (kode_transaksi, id_user, jadwal_id, tanggal_pesan, metode_pembayaran, status_pembayaran, total_bayar) VALUES
('INV20250427001', 3, 3, '2025-04-27', 'Cash', 'Lunas', 30000.00),
('INV20250428001', 4, 4, '2025-04-28', 'Transfer', 'Menunggu', 45000.00),
('INV20250429001', 5, 5, '2025-04-29', 'E-Wallet', 'Lunas', 70000.00),
('INV20250429002', 6, 6, '2025-04-29', 'QRIS', 'Lunas', 35000.00),
('INV20250430001', 7, 7, '2025-04-30', 'Cash', 'Dibatalkan', 0.00);

INSERT INTO Detail_Transaksi (transaksi_id, id_kursi) VALUES
(3, 5),  
(3, 6),  
(4, 7), 
(5, 8),  
(6, 1);  

