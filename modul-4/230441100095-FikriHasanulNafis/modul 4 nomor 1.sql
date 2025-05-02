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
-- 1
ALTER TABLE kamar
ADD COLUMN keterangan TEXT AFTER fasilitas;
SELECT * FROM kamar;
-- 2
SELECT p.nama_lengkap, k.nomor_kamar, pp.tanggal_masuk, pp.tanggal_keluar
FROM penempatan_penghuni pp
JOIN penghuni p ON pp.id_penghuni = p.id_penghuni
JOIN kamar k ON pp.id_kamar = k.id_kamar;
-- 3
SELECT * FROM penghuni
ORDER BY nama_lengkap ASC;
SELECT * FROM pelanggaran
ORDER BY tanggal DESC;
SELECT * FROM kamar
ORDER BY kapasitas ASC;
SELECT * FROM peminjaman_fasilitas
ORDER BY nama_fasilitas ASC;
SELECT * FROM penempatan_penghuni
ORDER BY tanggal_masuk DESC;
SELECT * FROM admin
ORDER BY nama ASC;
-- 4
ALTER TABLE penghuni
MODIFY COLUMN no_hp VARCHAR(20);

SELECT * FROM penghuni;
DESC penghuni;

-- 5
SELECT p.nama_lengkap, pf.nama_fasilitas, pf.tanggal_pinjam
FROM penghuni p
LEFT JOIN peminjaman_fasilitas pf ON p.id_penghuni = pf.id_penghuni;

SELECT p.nama_lengkap, pf.nama_fasilitas
FROM penghuni p
RIGHT JOIN peminjaman_fasilitas pf ON p.id_penghuni = pf.id_penghuni;

SELECT A.nama_lengkap AS penghuni1, B.nama_lengkap AS penghuni2
FROM penghuni A
JOIN penghuni B ON LEFT(A.nama_lengkap, INSTR(A.nama_lengkap, 'Andi Susanto')) = LEFT(B.nama_lengkap, INSTR(B.nama_lengkap, 'Budi Pratama '))
WHERE A.id_penghuni < B.id_penghuni;

-- 6
SELECT * FROM penghuni WHERE YEAR(tanggal_lahir) < 2000;
SELECT * FROM kamar WHERE kapasitas >= 2;
SELECT * FROM kamar WHERE tersedia <= 3;
SELECT * FROM pelanggaran WHERE tanggal > '2025-03-01';
SELECT * FROM peminjaman_fasilitas WHERE STATUS = 'Dipinjam';





