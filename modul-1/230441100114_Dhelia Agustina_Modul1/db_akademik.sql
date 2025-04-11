CREATE DATABASE db_akademik;

USE db_akademik;

CREATE TABLE tbl_Mahasiswa( 
	nim INT PRIMARY KEY,
	nama VARCHAR (50) NOT NULL,
	jurusan VARCHAR(50),
	angkatan INT
);

INSERT INTO tbl_Mahasiswa VALUES (908,'dhelia agustina', 'sistem informasi',2023)
INSERT INTO tbl_Mahasiswa VALUES (907,'safira fatma', 'sistem informasi',2023)
INSERT INTO tbl_Mahasiswa VALUES (909,'mutiara tara', 'sistem informasi',2023)
INSERT INTO tbl_Mahasiswa VALUES (605,'ana safitri', 'sistem informasi',2023)
INSERT INTO tbl_Mahasiswa VALUES (297,'Andi Pratama', 'Teknik Informatika',2025)
INSERT INTO tbl_Mahasiswa VALUES (456,'Eko Saputra', 'Teknik Informatika',2021)
INSERT INTO tbl_Mahasiswa VALUES (887,'Gita Anjani', 'Teknik Informatika',2022)
INSERT INTO tbl_Mahasiswa VALUES (133,'Indra Permana', 'sistem informasi',2024)
INSERT INTO tbl_Mahasiswa VALUES (65,'Dewi Kusuma', 'Teknik Informatika',2021)
INSERT INTO tbl_Mahasiswa VALUES (776,'Citra Lestari', 'sistem informasi',2022)


SELECT * FROM tbl_Mahasiswa
SELECT * FROM Mahasiswa

CREATE TABLE tbl_Dosen(
	nip INT PRIMARY KEY,
	nama VARCHAR(50),
	bidang VARCHAR(50)
);

INSERT INTO tbl_Dosen VALUES (1001,'Dr. Agus Suyanto', 'Machine Learning')
INSERT INTO tbl_Dosen VALUES (1002,'Dr. Budi Hartono', 'Database')
INSERT INTO tbl_Dosen VALUES (1023,'Dr. Cahyono Siregar', 'Jaringan Komputer')
INSERT INTO tbl_Dosen VALUES (1079,'Dr. Didi Suprapto', 'Pemrograman Web')
INSERT INTO tbl_Dosen VALUES (1003,'Dr. Eko Wijaya', 'Sistem Informasi')
INSERT INTO tbl_Dosen VALUES (1009,'Dr. Fadli Rahman', 'Keamanan Informasi')
INSERT INTO tbl_Dosen VALUES (1012,'Dr. Gina Aulia', 'Kecerdasan Buatan')
INSERT INTO tbl_Dosen VALUES (1000,'Dr. Hasan Basri', 'Big Data')
INSERT INTO tbl_Dosen VALUES (1004,'Dr. Indra Maulana', 'Pemrograman Mobile')
INSERT INTO tbl_Dosen VALUES (1005,'Dr. Junaedi Saputra', 'Rekayasa Perangkat Lunak')

SELECT * FROM tbl_Dosen

CREATE TABLE tbl_MataKuliah(
	kode_matakuliah INT primary key,
	nama_matakuliah VARCHAR(50),
	sks INT,
	nip INT
);

INSERT INTO tbl_MataKuliah VALUES (001, 'Pemrograman Dasar', 3, 1079)
INSERT INTO tbl_MataKuliah VALUES (2, 'Struktur Data', 3, 1002)
INSERT INTO tbl_MataKuliah VALUES (3, 'Jaringan Komputer', 3, 1023)
INSERT INTO tbl_MataKuliah VALUES (4, 'Keamanan Jaringan', 3, 1009)
INSERT INTO tbl_MataKuliah VALUES (5, 'Pemrograman Web', 3, 1079)
INSERT INTO tbl_MataKuliah VALUES (6, 'Kecerdasan Buatan', 3, 1012)
INSERT INTO tbl_MataKuliah VALUES (7, 'Sistem Basis Data', 3, 1002)
INSERT INTO tbl_MataKuliah VALUES (8, 'Analisis Algoritma', 3, 1001)
INSERT INTO tbl_MataKuliah VALUES (9, 'Pemrograman Mobile', 3, 1004)
INSERT INTO tbl_MataKuliah VALUES (10, 'Big Data', 3, 1000)

SELECT * FROM tbl_MataKuliah

CREATE TABLE tbl_KRS(
	id_krs INT primary key,
	nim INT unique not null,
	kode_matakuliah INT unique not null,
	semester INT,
	tahun_ajaran date
);

INSERT INTO tbl_KRS (id_krs,nim, kode_matakuliah, semester, tahun_ajaran) VALUES(772,908, 1, 1, '2025-04-05')
INSERT INTO tbl_KRS (id_krs,nim, kode_matakuliah, semester, tahun_ajaran) VALUES(87,907, 2, 5, '2005-01-15')
INSERT INTO tbl_KRS (id_krs,nim, kode_matakuliah, semester, tahun_ajaran) VALUES(443,909, 3, 3, '2004-03-21')
INSERT INTO tbl_KRS (id_krs,nim, kode_matakuliah, semester, tahun_ajaran) VALUES(228,605, 4, 1, '2005-09-23')
INSERT INTO tbl_KRS (id_krs,nim, kode_matakuliah, semester, tahun_ajaran) VALUES(45,456, 5, 2, '2004-06-18')


SELECT * FROM tbl_KRS


ALTER TABLE tbl_Mahasiswa RENAME Mahasiswa;

DROP DATABASE db_akademik;

select nama_matakuliah from tbl_matakuliah where nip= 1004;


