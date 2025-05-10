CREATE DATABASE db_akademik;
USE db_akademik;


CREATE TABLE Mhs (
	nim INT (10) PRIMARY KEY,
	nama VARCHAR(50),
	prodi VARCHAR (25),
	alamat VARCHAR (50)

);

CREATE TABLE Dosen(
	nip INT (10) PRIMARY KEY,
	nama_dosen VARCHAR (50),
	jabatan VARCHAR (50)
);

CREATE TABLE MK (
	kode_mk INT PRIMARY KEY,
	nama_mk VARCHAR(100),
	sks INT,
	nip INT(10),
	FOREIGN KEY (nip) REFERENCES Dosen(nip)
);

CREATE TABLE KRS (
	id_krs INT AUTO_INCREMENT PRIMARY KEY,
	nim INT(10),
	kode_mk INT(10),
	semester INT,
	FOREIGN KEY (nim) REFERENCES Mhs(nim),
	FOREIGN KEY (kode_mk) REFERENCES MK(kode_mk)
);

INSERT INTO Mhs VALUES 
(230411, 'Diah', 'Sistem Informasi', 'Tuban'),
(230414, 'Rahmat', 'Teknik Informatika', 'Malang'),
(230419, 'Siti', 'Psikologi', 'Magelang'),
(230412, 'Andi', 'Sistem Informasi', 'Pati'),
(230417, 'Nadia', 'Sistem Informasi', 'Medan'),
(230418, 'Lutfi', 'Sistem Informasi', 'Soccah'),
(230413, 'Budi', 'Hukum', 'Gresik'),
(230415, 'Joko', 'Manajemen', 'Tuban'),
(230416, 'Rizky', 'Agribisnis', 'Surabaya'),
(2304110, 'Fajar', 'Sastra Mesin', 'Jombang');


INSERT INTO Dosen VALUES 
(19001, 'Prof. ayu', 'Dekan'),
(19002, 'Dr. Surya', 'Wakil Dekan'),
(19003, 'Dr. Nanda', 'Ketua Prodi'),
(19004, 'Dr. Sari', 'Sekretaris Prodi'),
(19005, 'Dr. lina', 'Dosen Tetap'),
(19006, 'Dr. Lestari', 'Dosen Tetap'),
(19007, 'Dr. Wahyu', 'Dosen Tetap'),
(19008, 'Dr. Putra', 'Dosen Tetap'),
(19009, 'Dr. Anisa', 'Dosen Tetap'),
(19010, 'Dr. Bayu', 'Dosen Tetap');


INSERT INTO MK (kode_mk, nama_mk, sks, nip) VALUES 
(101, 'Pemrograman Berbasis Web', 3, 19001),
(102, 'Jaringan Komputer', 3, 19002),
(103, 'Pemrograman Bergerak', 3, 19003),
(104, 'Sistem Basis Data', 3, 19004),
(105, 'Manajemen Proyek IT', 2, 19005),
(106, 'Pemrograman Berbasis Objek', 2, 19006),
(107, 'Pemrograman Visual', 3, 19007),
(108, 'Analisis Data', 3, 19008),
(109, 'Keamanan Informasi', 2, 19009),
(110, 'Algoritma Pemrograman', 3, 19010);

SELECT * FROM Mhs;
SELECT * FROM MK;
SELECT * FROM Dosen;
SELECT * FROM KRS;


INSERT INTO KRS (nim, kode_mk, semester) VALUES 
(230411, 101, 1),
(230412, 102, 1),
(230415, 103, 2),
(230418, 104, 2),
(230419, 105, 3);

ALTER TABLE dosen RENAME TO Dosen;