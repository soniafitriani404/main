CREATE DATABASE akademik;

USE akademik;

CREATE TABLE Mahasiswa (
    nim INT PRIMARY KEY,
    nama VARCHAR(50),
    jurusan VARCHAR(50),
    angkatan YEAR
);

INSERT INTO Mahasiswa (nim, nama, jurusan, angkatan) VALUES
(230154, 'Iklil Mubarok', 'Sistem Informasi', 2023),
(230010, 'Zainul Arifin', 'Sistem Informasi', 2023),
(230020, 'Rizky Firman', 'Teknik Informatika', 2021),
(230030, 'Arifin Abdillah', 'Teknik Elektro', 2020),
(230040, 'Diki Waluya', 'Sistem Informasi', 2024),
(230050, 'Zidan  Nabil', 'Teknik Informatika', 2022),
(230060, 'Aditya', 'Sistem Informasi', 2020),
(230070, 'Abd Based', 'Teknik Elektro', 2021),
(230080, 'Umam', 'Teknik Informatika', 2020),
(230090, 'Herriyanto', 'Sistem Informasi', 2022);

SELECT * FROM Mahasiswa;

CREATE TABLE Dosen (
    nidn INT PRIMARY KEY,
    nama_dosen VARCHAR(50),
    gelar VARCHAR(20),
    departemen VARCHAR(50)
);

INSERT INTO Dosen (nidn, nama_dosen, gelar, departemen) VALUES
(001, 'Prof. Dr. Bambang', 'S.T., M.T.', 'Teknik Informatika'),
(002, 'Dr. Sri Wahyuni', 'M.Kom.', 'Sistem Informasi'),
(003, 'Dr. Agus Salim', 'S.T., M.Kom.', 'Teknik Komputer'),
(004, 'Prof. Dr. Fatimah', 'S.T., M.T.', 'Teknik Elektro'),
(005, 'Dr. Rina Dewi', 'M.Kom.', 'Sistem Informasi'),
(006, 'Dr. Budi Hartono', 'S.T., M.T.', 'Teknik Informatika'),
(007, 'Dr. Riza Purnama', 'M.Kom.', 'Sistem Informasi'),
(008, 'Prof. Dr. Arif Hidayat', 'S.T., M.T.', 'Teknik Elektro'),
(009, 'Dr. Retno Sari', 'S.T., M.Kom.', 'Sistem Informasi'),
(010, 'Dr. Imam Subekti', 'M.Kom.', 'Teknik Komputer');

CREATE TABLE MataKuliah (
    kode_mk VARCHAR(10) PRIMARY KEY,
    nama_mk VARCHAR(100),
    sks INT
);

INSERT INTO MataKuliah (kode_mk, nama_mk, sks) VALUES
('MK001', 'Algoritma dan Pemrograman', 3),
('MK002', 'Basis Data', 3),
('MK003', 'Struktur Data', 3),
('MK004', 'Jaringan Komputer', 3),
('MK005', 'Sistem Operasi', 3),
('MK006', 'Pengembangan Web', 3),
('MK007', 'Kecerdasan Buatan', 3),
('MK008', 'Pemrograman Mobile', 3),
('MK009', 'Rekayasa Perangkat Lunak', 3),
('MK010', 'Manajemen Proyek TI', 3);

CREATE TABLE KRS (
    id_krs INT AUTO_INCREMENT PRIMARY KEY,
    nim INT,
    kode_mk VARCHAR(10),
    nidn INT,
    semester INT,
    FOREIGN KEY (nim) REFERENCES Mahasiswa(nim),
    FOREIGN KEY (kode_mk) REFERENCES MataKuliah(kode_mk),
    FOREIGN KEY (nidn) REFERENCES Dosen(nidn)
);

INSERT INTO KRS (nim, nidn, kode_mk, semester) VALUES
(230154, 001, 'MK001', 1),
(230010, 002, 'MK002', 2),
(230020, 003, 'MK003', 1),
(230030, 004, 'MK004', 3),
(230040, 005, 'MK005', 4);

SELECT * FROM Mahasiswa;

SELECT * FROM Dosen;

SELECT * FROM MataKuliah;

SELECT * FROM KRS;

ALTER TABLE Siswa RENAME TO Mahasiswa;

DROP DATABASE akademik;


