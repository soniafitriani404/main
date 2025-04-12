CREATE DATABASE Akademik;

CREATE TABLE Mahasiswa (
NIM INT PRIMARY KEY,
Nama VARCHAR(50),
Prodi VARCHAR (25),
Alamat VARCHAR (50)
);

CREATE TABLE Dosen(
NIP INT PRIMARY KEY,
Nama_Dosen VARCHAR (50),
Jabatan VARCHAR (50)

);


CREATE TABLE MataKuliah (
    Kode_MK VARCHAR(50) PRIMARY KEY,
    Nama_MK VARCHAR(100),
    SKS INT,
    NIP INT,
    FOREIGN KEY (NIP) REFERENCES Dosen(NIP)
);

CREATE TABLE KRS (
    Kode_KRS INT AUTO_INCREMENT PRIMARY KEY,
    NIM INT,
    Kode_MK VARCHAR(50),
    Semester INT,
    FOREIGN KEY (NIM) REFERENCES Mahasiswa(NIM),
    FOREIGN KEY (Kode_MK) REFERENCES MataKuliah(Kode_MK)
);

INSERT INTO Mahasiswa VALUES 
(230013,'Yuli','Sistem Informasi','Bangkalan'),
(230088,'Friska','Sistem Informasi','Tuban'),
(230091,'Diah','Sistem Informasi','Tuban'),
(230127,'Natasya','Sistem Informasi','Gresik'),
(230170,'Icha','Sistem Informasi','Surabaya'),
(230015,'Jingga','Teknik Informatika','Madura'),
(230026,'Najwa','Teknik Industri','Lamongan'),
(230085,'Matus','Hukum','Surabaya'),
(230153,'Isma','Psikologi','Sampang'),
(230151,'Anggi','Ekonomi Islam','Surabaya');


INSERT INTO Dosen VALUES 
(10001, 'Dr. Arif Hidayat', 'Dekan'),
(10002, 'Dr. Budi', 'Wakil Dekan'),
(10003, 'Dr. Siti Rahma', 'Ketua Prodi'),
(10004, 'Dr. Dewi', 'Sekretaris Prodi'),
(10005, 'Dr. Bambang Setiawan', 'Dosen Tetap'),
(10006, 'Dr. Fajar', 'Dosen Tetap'),
(10007, 'Dr. Rina Amelia', 'Dosen Tetap'),
(10008, 'Dr. Handoko', 'Dosen Tetap'),
(10009, 'Dr. Ira Rahmawati', 'Dosen Tetap'),
(10010, 'Dr. Fauzi', 'Dosen Tetap');

INSERT INTO MataKuliah (Kode_MK, Nama_MK, SKS, NIP) VALUES 
('MK001', 'Algoritma Pemrograman', 3, 10001),
('MK002', 'Logika Engineering', 2, 10002),
('MK003', 'Pemrograman Web', 3, 10003),
('MK004', 'Pemrograman Berbasis Objek', 3, 10004),
('MK005', 'Desain Manajemen Jaringan', 2, 10005),
('MK006', 'Pemrograman Visual', 3, 10006),
('MK007', 'Pengantar Basis Data', 3, 10007),
('MK008', 'Analisis Data', 3, 10008),
('MK009', 'PTIK', 2, 10009),
('MK010', 'Jaringan Komputer', 3, 10010);

SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM Matakuliah;

INSERT INTO KRS (NIM, Kode_MK, semester) VALUES 
(230091, 'MK001', 1),
(230088, 'MK005', 2),
(230127, 'MK003', 2),
(230013, 'MK008', 3),
(230170, 'MK006', 3);

SELECT * FROM KRS;

ALTER TABLE Dosen RENAME TO Dosen_UTM;

SHOW TABLES;

DROP DATABASE akademik;










