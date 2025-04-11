CREATE DATABASE akademik_sisteminformsi;

CREATE TABLE Mahasiswa (
    nim INT PRIMARY KEY,
    nama VARCHAR(100),
    jurusan VARCHAR(100),
    angkatan INT
);

CREATE TABLE Dosen (
    nip INT PRIMARY KEY,
    nama VARCHAR(100),
    mengampu VARCHAR(100)
);

CREATE TABLE MataKuliah (
    kode_mk INT PRIMARY KEY,
    nama_mk VARCHAR(100),
    sks INT,
    nip INT,
    FOREIGN KEY (nip) REFERENCES Dosen(nip)
);

CREATE TABLE KRS (
    id_krs INT AUTO_INCREMENT PRIMARY KEY,
    nim INT,
    kode_mk INT,
    semester INT,
    FOREIGN KEY (nim) REFERENCES Mahasiswa(nim),
    FOREIGN KEY (kode_mk) REFERENCES MataKuliah(kode_mk)
);

INSERT INTO Mahasiswa VALUES
(23001, 'Safira Fatma M', 'Sistem Informasi', 2023),
(23002, 'Dhelia Agustina', 'Sistem Informasi', 2023),
(23003, 'Mutiara Tania P', 'Sistem Informasi', 2023),
(23004, 'Ana Safitri', 'Sistem Informasi', 2023),
(23005, 'Sarah Agustriyana', 'Sistem Informasi', 2023),
(23006, 'Alya Eka Zhafira', 'Sistem Informasi', 2023),
(23007, 'Alya Shafira Putri A', 'Sistem Informasi', 2023),
(23008, 'Habibi Maulana Y', 'Sistem Informasi', 2023),
(23009, 'Hisyam Muazam Y', 'Sistem Informasi', 2023),
(23010, 'Anggara Satria A', 'Sistem Informasi', 2023);

INSERT INTO Dosen VALUES
(1001, 'Sri Herawati, S.Kom., M.Kom', 'Pemrograman Berbasis Web'),
(1002, 'Mohammad Syarief, S.T., M.Cs.', 'Basis Data'),
(1003, 'Eza Rahmanita, S.T., M.T.', 'Sistem Pendukung Keputusan'),
(1004, 'Doni Abdul Fatah, S.Kom., M.Kom', 'Interaksi Manusia Dan Komputer'),
(1005, 'Yudha Dwi Putra Negara, S.Kom., M.Kom', 'Arsitektur SI/TI'),
(1006, 'Firli Irhamni, S.T., M.Kom', 'Rekayasa Perangkat Lunak'),
(1007, 'Dr. Wahyudi Setiawan, S.Kom, M.Kom', 'Data Mining'),
(1008, 'Imamah, S.Kom., M.Kom', 'Pemrograman Bergerak'),
(1009, 'Fitri Damayanti, S.Kom, M.Kom', 'Image Processing'),
(1010, 'Achmad Zain Nur, S.Kom.,M.T.', 'Pemrograman Berbasis Objek');

INSERT INTO MataKuliah VALUES
(101, 'Pemrograman Berbasis Web', 3, 1001),
(102, 'Basis Data', 3, 1002),
(103, 'Sistem Pendukung Keputusan', 3, 1003),
(104, 'Interaksi Manusia Dan Komputer', 3, 1004),
(105, 'Arsitektur SI/TI', 3, 1005),
(106, 'Rekayasa Perangkat Lunak', 3, 1006),
(107, 'Data Mining', 3, 1007),
(108, 'Pemrograman Bergerak', 3, 1008),
(109, 'Image Processing', 3, 1009),
(110, 'Pemrograman Berbasis Objek', 3, 1010);

INSERT INTO KRS (nim, kode_mk, semester) VALUES
(23001, 101, 1),
(23002, 102, 1),
(23003, 103, 2),
(23004, 104, 2),
(23005, 105, 3);

SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM MataKuliah;
SELECT * FROM KRS;
SELECT nama_mk FROM Matakuliah WHERE nip = 1010;
RENAME TABLE Dosen TO DataDosen;

DROP DATABASE akademik_sisteminformasi;

DROP TABLE Mahasiswa;
