CREATE DATABASE akademikk;
USE akademikk;

-- Tabel Mahasiswa
CREATE TABLE Mahasiswa (
    nim CHAR(10) PRIMARY KEY,
    nama VARCHAR(50),
    jurusan VARCHAR(50),
    angkatan INT
);

-- Tabel Dosen
CREATE TABLE Dosen (
    nip CHAR(10) PRIMARY KEY,
    nama VARCHAR(50),
    departemen VARCHAR(50)
);

-- Tabel MataKuliah
CREATE TABLE MataKuliah (
    kode_mk CHAR(6) PRIMARY KEY,
    nama_mk VARCHAR(50),
    sks INT,
    nip CHAR(10),
    FOREIGN KEY (nip) REFERENCES Dosen(nip)
);

-- Tabel KRS
CREATE TABLE KRS (
    id_krs INT AUTO_INCREMENT PRIMARY KEY,
    nim CHAR(10),
    kode_mk CHAR(6),
    semester INT,
    FOREIGN KEY (nim) REFERENCES Mahasiswa(nim),
    FOREIGN KEY (kode_mk) REFERENCES MataKuliah(kode_mk)
);

INSERT INTO Mahasiswa VALUES
('M001', 'Andi', 'Informatika', 2022),
('M002', 'Budi', 'Sistem Informasi', 2021),
('M003', 'Citra', 'Informatika', 2022),
('M004', 'Dina', 'Sistem Informasi', 2023),
('M005', 'Eka', 'Informatika', 2020),
('M006', 'Fajar', 'Teknik Komputer', 2022),
('M007', 'Gina', 'Informatika', 2021),
('M008', 'Hadi', 'Teknik Komputer', 2023),
('M009', 'Ira', 'Sistem Informasi', 2022),
('M010', 'Joko', 'Informatika', 2023);

INSERT INTO Dosen VALUES
('D001', 'Dr. Rina', 'Informatika'),
('D002', 'Dr. Yoga', 'Sistem Informasi'),
('D003', 'Dr. Fajar', 'Teknik Komputer'),
('D004', 'Dr. Sinta', 'Informatika'),
('D005', 'Dr. Anton', 'Sistem Informasi'),
('D006', 'Dr. Indah', 'Teknik Komputer'),
('D007', 'Dr. Bimo', 'Informatika'),
('D008', 'Dr. Lestari', 'Sistem Informasi'),
('D009', 'Dr. Kiki', 'Informatika'),
('D010', 'Dr. Rudi', 'Teknik Komputer');

INSERT INTO MataKuliah VALUES
('MK001', 'Basis Data', 3, 'D001'),
('MK002', 'Algoritma', 3, 'D004'),
('MK003', 'Jaringan', 3, 'D003'),
('MK004', 'Pemrograman Web', 3, 'D005'),
('MK005', 'Sistem Operasi', 3, 'D006'),
('MK006', 'Pemrograman Mobile', 3, 'D002'),
('MK007', 'Kecerdasan Buatan', 3, 'D007'),
('MK008', 'Keamanan Sistem', 3, 'D008'),
('MK009', 'Machine Learning', 3, 'D009'),
('MK010', 'Etika Profesi', 2, 'D010');

SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM MataKuliah;
SELECT * FROM KRS;

INSERT INTO KRS (nim, kode_mk, semester) VALUES
('M001', 'MK001', 2),
('M002', 'MK002', 4),
('M003', 'MK003', 2),
('M004', 'MK004', 4),
('M005', 'MK005', 6);

ALTER TABLE siswa RENAME TO mahasiswa;

DROP DATABASE akademik;
