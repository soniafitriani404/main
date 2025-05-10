#Soal No 1

CREATE DATABASE praktikum_smbd

USE praktikum_smbd

SHOW TABLES;

CREATE TABLE mahasiswa (
	nim INT PRIMARY KEY NOT NULL,
	nama VARCHAR(50) NOT NULL,
	tanggal_lahir DATE NOT NULL,
	alamat VARCHAR(255) NOT NULL,
	prodi VARCHAR(70) NOT NULL
);

DESC mahasiswa;

CREATE TABLE dosen (
	nip INT PRIMARY KEY NOT NULL,
	nama VARCHAR(100) NOT NULL,
	tanggal_lahir DATE NOT NULL,
	bidang_keahlian VARCHAR(255) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE
);

DESC dosen

CREATE TABLE matakuliah (
	kode_mk VARCHAR(7) PRIMARY KEY UNIQUE NOT NULL,
	nama_mk VARCHAR(255) NOT NULL,
	sks INT NOT NULL,
	nip_dosen INT,
	FOREIGN KEY (nip_dosen) REFERENCES dosen(nip)
);

DESC matakuliah

CREATE TABLE krs (
	id_krs INT AUTO_INCREMENT PRIMARY KEY,
	nim_mahasiswa INT,
	kode_mk VARCHAR(7),
	semester INT NOT NULL,
	FOREIGN KEY (nim_mahasiswa) REFERENCES mahasiswa(nim),
	FOREIGN KEY (kode_mk) REFERENCES matakuliah(kode_mk)
);

DESC krs

# Soal No 2
INSERT INTO mahasiswa (nim, nama, tanggal_lahir, alamat, prodi) VALUES
(1001, 'Ani', '2000-01-01', 'Jl. Merdeka 1', 'Teknik Informatika'),
(1002, 'Budi', '2001-02-02', 'Jl. Pahlawan 2', 'Sistem Informasi'),
(1003, 'Citra', '2002-03-03', 'Jl. Sudirman 3', 'Teknik Informatika'),
(1004, 'Dedi', '2003-04-04', 'Jl. Gatot Subroto 4', 'Manajemen Informatika'),
(1005, 'Eka', '2004-05-05', 'Jl. Thamrin 5', 'Sistem Informasi'),
(1006, 'Fani', '2005-06-06', 'Jl. Diponegoro 6', 'Teknik Informatika'),
(1007, 'Gilang', '2006-07-07', 'Jl. Hasanuddin 7', 'Manajemen Informatika'),
(1008, 'Hani', '2007-08-08', 'Jl. Kartini 8', 'Sistem Informasi'),
(1009, 'Indra', '2008-09-09', 'Jl. Pattimura 9', 'Teknik Informatika'),
(1010, 'Joko', '2009-10-10', 'Jl. Imam Bonjol 10', 'Manajemen Informatika');

INSERT INTO dosen (nip, nama, tanggal_lahir, bidang_keahlian, email) VALUES
(2001, 'Dr. Andi', '1970-01-01', 'Basis Data', 'andi@email.com'),
(2002, 'Dr. Budi', '1971-02-02', 'Pemrograman Web', 'budi.dosen@email.com'),
(2003, 'Dr. Citra', '1972-03-03', 'Analisis Algoritma', 'citra.dosen@email.com'),
(2004, 'Dr. Dedi', '1973-04-04', 'Jaringan Komputer', 'dedi.dosen@email.com'),
(2005, 'Dr. Eka', '1974-05-05', 'Sistem Operasi', 'eka.dosen@email.com'),
(2006, 'Dr. Fani', '1975-06-06', 'Rekayasa Perangkat Lunak', 'fani.dosen@email.com'),
(2007, 'Dr. Gilang', '1976-07-07', 'Kecerdasan Buatan', 'gilang.dosen@email.com'),
(2008, 'Dr. Hani', '1977-08-08', 'Sistem Informasi Manajemen', 'hani.dosen@email.com'),
(2009, 'Dr. Indra', '1978-09-09', 'Data Mining', 'indra.dosen@email.com'),
(2010, 'Dr. Joko', '1979-10-10', 'Grafika Komputer', 'joko.dosen@email.com');

INSERT INTO matakuliah (kode_mk, nama_mk, sks, nip_dosen) VALUES
('MK001', 'Basis Data', 3, 2001),
('MK002', 'Pemrograman Web', 4, 2002),
('MK003', 'Analisis Algoritma', 3, 2003),
('MK004', 'Jaringan Komputer', 4, 2004),
('MK005', 'Sistem Operasi', 3, 2005),
('MK006', 'Rekayasa Perangkat Lunak', 4, 2006),
('MK007', 'Kecerdasan Buatan', 3, 2007),
('MK008', 'Sistem Informasi Manajemen', 4, 2008),
('MK009', 'Data Mining', 3, 2009),
('MK010', 'Grafika Komputer', 4, 2010);

# soal no 3
SELECT * FROM mahasiswa;

SELECT * FROM dosen;

SELECT * FROM matakuliah;

SELECT * FROM krs;

# soal no 4
INSERT INTO krs (nim_mahasiswa, kode_mk, semester) VALUES
(1001, 'MK001', 1),
(1002, 'MK002', 1),
(1003, 'MK003', 1),
(1004, 'MK004', 1),
(1005, 'MK005', 1);

# soal no 5
RENAME TABLE matakuliah TO mata_kuliah

# soal no 6
DROP DATABASE praktikum_smbd;