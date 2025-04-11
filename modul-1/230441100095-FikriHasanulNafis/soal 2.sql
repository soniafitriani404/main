CREATE DATABASE asrama;
USE asrama;

-- TABEL MASTER
CREATE TABLE penghuni (
    id_penghuni INT PRIMARY KEY AUTO_INCREMENT,
    nama_lengkap VARCHAR(100) NOT NULL,
    jenis_kelamin ENUM('L', 'P') NOT NULL,
    tanggal_lahir DATE NOT NULL,
    alamat TEXT NOT NULL,
    no_hp VARCHAR(15) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE kamar (
    id_kamar INT PRIMARY KEY AUTO_INCREMENT,
    nomor_kamar VARCHAR(10) NOT NULL UNIQUE,
    kapasitas INT NOT NULL,
    tersedia INT NOT NULL,
    fasilitas TEXT
);

CREATE TABLE admin (
    id_admin INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    PASSWORD VARCHAR(255) NOT NULL
);

-- TABEL TRANSAKSI
CREATE TABLE penempatan_penghuni (
    id_penempatan INT PRIMARY KEY AUTO_INCREMENT,
    id_penghuni INT,
    id_kamar INT,
    id_admin INT,
    tanggal_masuk DATE NOT NULL,
    tanggal_keluar DATE,
    FOREIGN KEY (id_penghuni) REFERENCES penghuni(id_penghuni),
    FOREIGN KEY (id_kamar) REFERENCES kamar(id_kamar),
    FOREIGN KEY (id_admin) REFERENCES admin(id_admin)
);

CREATE TABLE peminjaman_fasilitas (
    id_peminjaman INT PRIMARY KEY AUTO_INCREMENT,
    id_penghuni INT,
    id_admin INT,
    nama_fasilitas VARCHAR(100),
    tanggal_pinjam DATE NOT NULL,
    tanggal_kembali DATE,
    STATUS ENUM('Dipinjam', 'Dikembalikan') DEFAULT 'Dipinjam',
    FOREIGN KEY (id_penghuni) REFERENCES penghuni(id_penghuni),
    FOREIGN KEY (id_admin) REFERENCES admin(id_admin)
);

CREATE TABLE pelanggaran (
    id_pelanggaran INT PRIMARY KEY AUTO_INCREMENT,
    id_penghuni INT,
    id_admin INT,
    tanggal DATE NOT NULL,
    jenis_pelanggaran VARCHAR(100),
    deskripsi TEXT,
    tindakan VARCHAR(100),
    FOREIGN KEY (id_penghuni) REFERENCES penghuni(id_penghuni),
    FOREIGN KEY (id_admin) REFERENCES admin(id_admin)
);
SELECT * FROM penghuni;
SELECT * FROM kamar;
SELECT * FROM admin;
SELECT * FROM penempatan_penghuni;
SELECT * FROM peminjaman_fasilitas;
SELECT * FROM pelanggaran;
