CREATE DATABASE PenyewaanRumah;

USE PenyewaanRumah;

CREATE TABLE Pemilik (
    id_pemilik INT  PRIMARY KEY,
    nama_pemilik VARCHAR(255) NOT NULL,
    no_hp VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Rumah (
    id_rumah INT PRIMARY KEY,
    alamat VARCHAR(255) NOT NULL,
    tipe VARCHAR(50) NOT NULL,
    harga_sewa DOUBLE NOT NULL,
    sts ENUM('Tersedia', 'Tidak Tersedia') DEFAULT 'Tersedia',
    id_pemilik INT NOT NULL,
    FOREIGN KEY (id_pemilik) REFERENCES Pemilik(id_pemilik) 
);

CREATE TABLE Penyewa (
    id_penyewa INT  PRIMARY KEY,
    nama_penyewa VARCHAR(255) NOT NULL,
    no_ktp VARCHAR(20) UNIQUE NOT NULL,
    no_hp VARCHAR(15) NOT NULL,
    pekerjaan VARCHAR(100)
);

CREATE TABLE Penyewaan (
    id_penyewaan INT PRIMARY KEY,
    id_rumah INT NOT NULL,
    id_penyewa INT NOT NULL,
    tanggal_mulai DATE NOT NULL,
    tanggal_selesai DATE NOT NULL,
    sts ENUM('Aktif', 'Selesai') DEFAULT 'Aktif',
    FOREIGN KEY (id_rumah) REFERENCES Rumah(id_rumah) ,
    FOREIGN KEY (id_penyewa) REFERENCES Penyewa(id_penyewa) 
);

CREATE TABLE Pembayaran (
    id_pembayaran INT PRIMARY KEY,
    id_penyewaan INT NOT NULL,
    tanggal_bayar DATE NOT NULL,
    jumlah_bayar DOUBLE NOT NULL,
    metode_pembayaran ENUM('Transfer Bank', 'Tunai', 'E-Wallet') NOT NULL,
    FOREIGN KEY (id_penyewaan) REFERENCES Penyewaan(id_penyewaan) 
);