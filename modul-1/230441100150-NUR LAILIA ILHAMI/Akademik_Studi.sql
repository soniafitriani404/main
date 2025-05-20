CREATE DATABASE akademik_studi;

USE akademik_studi;

CREATE TABLE Mahasiswa (
    nim INT NOT NULL,
    nama_mhs VARCHAR(50) NOT NULL,
    tgl_lahir DATE NOT NULL,
    alamat TEXT NOT NULL,
    Prodi VARCHAR(50),
    PRIMARY KEY(nim)
);

CREATE TABLE Dosen (
    NIP INT(10) PRIMARY KEY,
    Nama VARCHAR(100),
    Bidang VARCHAR(100),
    Email VARCHAR(100)
);


CREATE TABLE MataKuliah (
    Kode_MK INT(10) PRIMARY KEY,
    Nama_MK VARCHAR(100),
    SKS INT,
    Semester INT
);

CREATE TABLE Kelas (
    ID_Kelas INT AUTO_INCREMENT PRIMARY KEY,
    Nama_Kelas VARCHAR(50),
    Kode_MK INT,
    NIP INT,
    Tahun_Ajaran VARCHAR(10),
    Semester INT,
    FOREIGN KEY (Kode_MK) REFERENCES MataKuliah(Kode_MK),
    FOREIGN KEY (NIP) REFERENCES Dosen(NIP)
);

CREATE TABLE kartu_studi (
    ID_KRS INT AUTO_INCREMENT PRIMARY KEY,
    nim INT NOT NULL,
    ID_Kelas INT NOT NULL,
    FOREIGN KEY (nim) REFERENCES mahasiswa(nim)
);


INSERT INTO Mahasiswa (nim, nama_mhs, tgl_lahir, alamat, Prodi) VALUES
(1001, 'Andi Wijaya', '2002-05-12', 'Jl. Merpati No.1', 'Informatika'),
(1002, 'Budi Santoso', '2003-07-22', 'Jl. Melati No.5', 'Sistem Informasi'),
(1003, 'Citra Dewi', '2001-12-03', 'Jl. Kenanga No.3', 'Teknik Komputer'),
(1004, 'Dedi Prasetyo', '2002-09-15', 'Jl. Mawar No.7', 'Informatika'),
(1005, 'Eka Purnama', '2003-01-28', 'Jl. Flamboyan No.2', 'Sistem Informasi'),
(1006, 'Farah Nabila', '2002-03-18', 'Jl. Anggrek No.10', 'Teknik Komputer'),
(1007, 'Gilang Ramadhan', '2001-11-25', 'Jl. Dahlia No.4', 'Informatika'),
(1008, 'Hana Salsabila', '2003-06-30', 'Jl. Kamboja No.6', 'Sistem Informasi'),
(1009, 'Ivan Nugroho', '2002-08-08', 'Jl. Teratai No.9', 'Teknik Komputer'),
(1010, 'Jihan Amalia', '2001-04-01', 'Jl. Melur No.8', 'Informatika');

INSERT INTO Dosen (NIP, Nama, Bidang, Email) VALUES
(9011, 'Dr.andi', 'agama','andi@univ.ac.id' )


INSERT INTO MataKuliah (Kode_MK, Nama_MK, SKS, Semester) VALUES
(101, 'Basis Data', 3, 3),
(102, 'Pemrograman Dasar', 3, 1),
(103, 'Jaringan Komputer', 3, 4),
(104, 'Sistem Informasi', 3, 5),
(105, 'Kecerdasan Buatan', 3, 6),
(106, 'Algoritma & Struktur Data', 3, 2),
(107, 'Rekayasa Perangkat Lunak', 3, 5),
(108, 'Statistik Komputasi', 2, 2),
(109, 'Analisis dan Perancangan Sistem', 3, 4),
(110, 'Pemrograman Web', 3, 3);

INSERT INTO Kelas (Nama_Kelas, Kode_MK, NIP, Tahun_Ajaran, Semester) VALUES
('A', 101, 9001, '2024/2025', 3),
('B', 102, 9002, '2024/2025', 1),
('A', 103, 9003, '2024/2025', 4),
('B', 104, 9004, '2024/2025', 5),
('A', 105, 9005, '2024/2025', 6),
('B', 106, 9006, '2024/2025', 2),
('A', 107, 9007, '2024/2025', 5),
('B', 108, 9008, '2024/2025', 2),
('A', 109, 9009, '2024/2025', 4),
('B', 110, 9010, '2024/2025', 3);

INSERT INTO kartu_studi (nim, ID_Kelas) VALUES
(1001, 1),
(1002, 2),
(1003, 3),
(1004, 4),
(1005, 5);

SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM MataKuliah;
select * from kartu_studi;
SELECT * FROM Kelas;

select * from mahasiswa where prodi='informatika'

RENAME TABLE Mahasiswa TO DataMahasiswa;

DROP DATABASE akademik_studi;

select * from Dosen WHERE NIP='9001' 




