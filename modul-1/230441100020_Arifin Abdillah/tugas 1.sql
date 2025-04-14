CREATE DATABASE akademik_prodi1;

USE akademik_prodi1;

CREATE TABLE mahasiswa (
	nim INT (10) PRIMARY KEY,
	nama VARCHAR (50),
	prodi VARCHAR (100)
);

CREATE TABLE Dosen (
	nip INT (10) PRIMARY KEY,
	nama VARCHAR(100),
	bidang_keahlian VARCHAR(100)
);

CREATE TABLE MataKuliah (
	kode_mk INT (6) PRIMARY KEY,
	nama_mk VARCHAR(100),
	sks INT,
	nip INT,
	FOREIGN KEY (nip) REFERENCES Dosen(nip) ) ON DELETE SET NULL
);


CREATE TABLE KRS (
	id_krs INT AUTO_INCREMENT PRIMARY KEY,
	nim INT(10),
	kode_mk INT (6),
	semester INT,
	FOREIGN KEY (nim) REFERENCES Mahasiswa(nim) ON DELETE CASCADE,
	FOREIGN KEY (kode_mk) REFERENCES MataKuliah(kode_mk) ON DELETE CASCADE
);

INSERT INTO Mahasiswa VALUES
('220001', 'Budi Santoso', 'Informatika'),
('220002', 'Siti Aisyah', 'Sistem Informasi'),
('220003', 'Ahmad Fadli', 'Teknik Elektro'),
('220004', 'Dewi Lestari', 'Manajemen Informatika'),
('220005', 'Rizky Ramadhan','Informatika'),
('220006', 'Anita Sari', 'Sistem Informasi'),
('220007', 'Fajar Pratama', 'Teknik Elektro'),
('220008', 'Lina Mardiana', 'Informatika'),
('220009', 'Hendro Saputro','Manajemen Informatika'),
('220010', 'Nadia Zahra', 'Sistem Informasi');

INSERT INTO Dosen VALUES
('10001', 'Dr. Andi Wijaya', 'Basis Data'),
('10002', 'Prof. Sari Lestari', 'Jaringan Komputer'),
('10003', 'Dr. Bambang Sutrisno', 'Pemrograman Web'),
('10004', 'Dr. Rina Kartika', 'Data Mining'),
('10005', 'Dr. Yudi Pratama', 'Sistem Operasi'),
('10006', 'Prof. Indah Permata', 'AI & Machine Learning'),
('10007', 'Dr. Agus Suryadi', 'Keamanan Informasi'),
('10008', 'Dr. Wulan Sari', 'Rekayasa Perangkat Lunak'),
('10009', 'Dr. Budi Santoso', 'Komputasi Awan'),
('10010', 'Dr. Rahayu Putri', 'Robotika');

INSERT INTO MataKuliah VALUES
('1', 'Basis Data', 3, '10001'),
('2', 'Jaringan Komputer', 3, '10002'),
('3', 'Pemrograman Web', 4, '10003'),
('4', 'Data Mining', 3, '10004'),
('5', 'Sistem Operasi', 3, '10005'),
('6', 'Machine Learning', 4, '10006'),
('7', 'Keamanan Informasi', 3, '10007'),
('8', 'Rekayasa Perangkat Lunak', 4, '10008'),
('9', 'Komputasi Awan', 3, '10009'),
('10', 'Robotika', 4, '10010');

SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM MataKuliah;
SELECT * FROM KRS;

INSERT INTO KRS (nim, kode_mk, semester) VALUES
('220001', '1', 1),
('220002', '3', 2),
('220003', '5', 3),
('220004', '7', 2),
('220005', '9', 4);

ALTER TABLE KRS RENAME TO Registrasi_MK;

DROP DATABASE akademik_prodi;
	