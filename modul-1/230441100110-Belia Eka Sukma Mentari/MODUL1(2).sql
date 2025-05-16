CREATE DATABASE db_klinik;
USE db_klinik;

CREATE TABLE pasien (
    id_pasien INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    tanggal_lahir DATE,
    jenis_kelamin ENUM('Laki-laki', 'Perempuan'),
    alamat VARCHAR(200),
    no_telp VARCHAR(15)
);

CREATE TABLE dokter (
    id_dokter INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    spesialisasi VARCHAR(100),
    jadwal_praktek VARCHAR(50),
    no_telp VARCHAR(15)
);

CREATE TABLE obat (
    id_obat INT AUTO_INCREMENT PRIMARY KEY,
    nama_obat VARCHAR(100),
    jenis_obat VARCHAR(50),
    dosis VARCHAR(50),
    stok INT
);

CREATE TABLE kunjungan (
    id_kunjungan INT AUTO_INCREMENT PRIMARY KEY,
    id_pasien INT,
    id_dokter INT,
    tanggal_kunjungan DATE,
    keluhan VARCHAR(255),
    diagnosa VARCHAR(255),
    FOREIGN KEY (id_pasien) REFERENCES pasien(id_pasien),
    FOREIGN KEY (id_dokter) REFERENCES dokter(id_dokter)
);

CREATE TABLE resep (
    id_resep INT AUTO_INCREMENT PRIMARY KEY,
    id_kunjungan INT,
    id_obat INT,
    jumlah INT,
    aturan_pakai VARCHAR(255),
    FOREIGN KEY (id_kunjungan) REFERENCES kunjungan(id_kunjungan),
    FOREIGN KEY (id_obat) REFERENCES obat(id_obat)
);

SHOW TABLES;

INSERT INTO pasien (nama, tanggal_lahir, jenis_kelamin, alamat, no_telp)
VALUES ('Andi Saputra', '1990-05-14', 'Laki-laki', 'Jl. Merdeka No. 10, Nganjuk', '081234567890');

INSERT INTO dokter (nama, spesialisasi, jadwal_praktek, no_telp)
VALUES ('Dr. Siti Handayani', 'Umum', 'Senin - Jumat 08:00-12:00', '082112345678');

INSERT INTO obat (nama_obat, jenis_obat, dosis, stok)
VALUES ('Paracetamol', 'Analgesik', '500 mg', 100);

INSERT INTO kunjungan (id_pasien, id_dokter, tanggal_kunjungan, keluhan, diagnosa)
VALUES (1, 1, '2025-04-10', 'Demam dan sakit kepala', 'Influenza ringan');

INSERT INTO resep (id_kunjungan, id_obat, jumlah, aturan_pakai)
VALUES (1, 1, 10, '3x1 setelah makan');

SELECT * FROM pasien;
SELECT * FROM dokter;
SELECT * FROM obat;
SELECT * FROM kunjungan;
SELECT * FROM resep;
