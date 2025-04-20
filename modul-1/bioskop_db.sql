CREATE DATABASE bioskop_db;


CREATE TABLE USER (
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    no_hp VARCHAR(15)
);

CREATE TABLE Teater (
    id_teater INT AUTO_INCREMENT PRIMARY KEY,
    nama_teater VARCHAR(50),
    kapasitas INT
);

CREATE TABLE Film (
    id_film INT AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(100),
    genre VARCHAR(50),
    durasi INT
);

CREATE TABLE Kursi (
    id_kursi INT AUTO_INCREMENT PRIMARY KEY,
    id_teater INT,
    kode_kursi VARCHAR(5),
    FOREIGN KEY (id_teater) REFERENCES Teater(id_teater)
);

CREATE TABLE Jadwal (
    jadwal_id INT AUTO_INCREMENT PRIMARY KEY,
    id_film INT,
    id_teater INT,
    tanggal DATE,
    jam TIME,
    FOREIGN KEY (id_film) REFERENCES Film(id_film),
    FOREIGN KEY (id_teater) REFERENCES Teater(id_teater)
);

CREATE TABLE Transaksi (
    transaksi_id INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT,
    jadwal_id INT,
    id_kursi INT,
    tanggal_pesan DATE,
    metode_pembayaran ENUM('Cash', 'QRIS', 'Transfer', 'E-Wallet'),
    total_bayar DECIMAL(10,2),
    FOREIGN KEY (id_user) REFERENCES USER(id_user),
    FOREIGN KEY (jadwal_id) REFERENCES Jadwal(jadwal_id),
    FOREIGN KEY (id_kursi) REFERENCES Kursi(id_kursi)
);

INSERT INTO USER (nama, email, no_hp) VALUES
('Diah Ayu', 'diahayu@gmail.com', '085854111594'),
('Icha', 'itscha@gmail.com', '083119437004');

INSERT INTO Film (judul, genre, durasi) VALUES
('The Conjuring', 'Horor', 120),
('The Scream', 'Thriller', 145);

INSERT INTO Teater (nama_teater, kapasitas) VALUES
('Teater 1', 50),
('Teater 2', 70);

INSERT INTO Kursi (id_teater, kode_kursi) VALUES
(1, 'A1'),
(1, 'A2'),
(2, 'B1'),
(2, 'B5');

INSERT INTO Jadwal (id_film, id_teater, tanggal, jam) VALUES
(1, 1, '2025-04-27', '14:15:00'),
(2, 2, '2025-04-27', '15:00:00');

INSERT INTO Transaksi (id_user, jadwal_id, id_kursi, tanggal_pesan, metode_pembayaran, total_bayar) VALUES
(1, 1, 1, '2025-04-26', 'QRIS', 30000.00),
(2, 2, 3, '2025-04-25', 'E-Wallet', 35000.00);

SELECT * FROM USER;
SELECT * FROM Film;
SELECT * FROM Teater;
SELECT * FROM Kursi;
SELECT * FROM Jadwal;
SELECT * FROM Transaksi;

SELECT nama, no_hp FROM USER;




SHOW TABLES;