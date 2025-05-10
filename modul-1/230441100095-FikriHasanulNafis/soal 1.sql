CREATE DATABASE akademik2;

USE akademik2;

CREATE TABLE Mahasiswa (
nim INT (10) PRIMARY KEY,
nama VARCHAR(50),
prodi VARCHAR (25),
alamat VARCHAR (50)

);

CREATE TABLE Dosenutm(
nip INT (10) PRIMARY KEY,
nama_dosen VARCHAR (50),
jabatan VARCHAR (50)

);


CREATE TABLE MataKuliah (
    kode_mk INT(10) PRIMARY KEY,
    nama_mk VARCHAR(100),
    sks INT,
    nip INT(10),
    FOREIGN KEY (nip) REFERENCES Dosenutm(nip)
);

CREATE TABLE KRS (
    id_krs INT AUTO_INCREMENT PRIMARY KEY,
    nim INT(10),
    kode_mk INT(10),
    semester INT,
    FOREIGN KEY (nim) REFERENCES Mahasiswa(nim),
    FOREIGN KEY (kode_mk) REFERENCES MataKuliah(kode_mk)
);

INSERT INTO Mahasiswa VALUES 
(230411,'Fikri','Sistem Informasi','Surabaya'),
(230412,'Rivangga','Sistem Informasi','Pati'),
(230413,'Eko','Hukum','Gresik'),
(230414,'Fariel','Teknik Informatika','Malang'),
(230415,'Tio','Manajemen','Langkap'),
(230416,'Yakin','Agribisnis','Surabaya'),
(230417,'Natasya','Sistem Informasi','Medan'),
(230418,'Yuli','Sistem Informasi','Soccah'),
(230419,'Habib','Psikologi','Magelang'),
(2304110,'Nafis','Sastra Mesin','Jombang');


INSERT INTO Dosenutm VALUES 
(19001, 'Dr. Agus', 'Dekan'),
(19002, 'Dr. Budi', 'Wakil Dekan'),
(19003, 'Dr. Citra', 'Ketua Prodi'),
(19004, 'Dr. Dewi', 'Sekretaris Prodi'),
(19005, 'Dr. Eko', 'Dosen Tetap'),
(19006, 'Dr. Fajar', 'Dosen Tetap'),
(19007, 'Dr. Gita', 'Dosen Tetap'),
(19008, 'Dr. Hadi', 'Dosen Tetap'),
(19009, 'Dr. Ira', 'Dosen Tetap'),
(19010, 'Dr. Joko', 'Dosen Tetap');

INSERT INTO MataKuliah (kode_mk, nama_mk, sks, nip) VALUES 
(101, 'Algoritma dan Pemrograman', 3, 19001),
(102, 'Jaringan Komputer', 3, 19002),
(103, 'Kecerdasan Buatan', 3, 19003),
(104, 'Sistem Basis Data', 3, 19004),
(105, 'Manajemen Proyek TI', 2, 19005),
(106, 'Robotika', 2, 19006),
(107, 'Sistem Tertanam', 3, 19007),
(108, 'Analisis Data', 3, 19008),
(109, 'Keamanan Siber', 2, 19009),
(110, 'Pemrograman Web', 3, 19010);

SELECT * FROM Matakuliah;
SELECT * FROM Mahasiswa;
SELECT * FROM Dosenutm;
SELECT * FROM KRS;
SELECT * FROM Matakuliah WHERE nip = 19006;

INSERT INTO KRS (nim, kode_mk, semester) VALUES 
(230411, 101, 1),
(230412, 102, 1),
(230415, 103, 2),
(230418, 104, 2),
(230419, 105, 3);

ALTER TABLE Mahasiswa RENAME TO Mhsutm;

DROP DATABASE akademik2;
