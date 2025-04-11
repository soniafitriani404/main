CREATE DATABASE db_Akademik_Studi;
USE db_Akademik_Studi;

CREATE TABLE Program_Studi (
    id_program_studi INT AUTO_INCREMENT PRIMARY KEY,
    kode_program VARCHAR(10) UNIQUE NOT NULL,
    nama_program VARCHAR(100) NOT NULL,
    fakultas VARCHAR(100) NOT NULL
);

CREATE TABLE Mahasiswa (
    nim INT PRIMARY KEY,
    nama_mhs VARCHAR(100) NOT NULL,
    angkatan YEAR NOT NULL,
    id_program_studi INT NOT NULL,
    tanggal_lahir DATE,
    jenis_kelamin ENUM('Laki-laki', 'Perempuan'),
    FOREIGN KEY (id_program_studi) REFERENCES Program_Studi(id_program_studi) ON DELETE CASCADE
);

CREATE TABLE Dosen (
    nip INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    no_hp VARCHAR(20),
    alamat TEXT,
    id_program_studi INT NOT NULL,
    FOREIGN KEY (id_program_studi) REFERENCES Program_Studi(id_program_studi) ON DELETE CASCADE
);

CREATE TABLE Mata_Kuliah (
    id_matakuliah INT AUTO_INCREMENT PRIMARY KEY,
    kode_matakuliah VARCHAR(10) UNIQUE NOT NULL,
    nama_matakuliah VARCHAR(100) NOT NULL,
    sks INT NOT NULL CHECK (sks > 0), 
    semester INT NOT NULL CHECK (semester BETWEEN 1 AND 8),
    id_dosen INT NULL,
    id_program_studi INT NOT NULL,
    FOREIGN KEY (id_dosen) REFERENCES Dosen(nip) ON DELETE SET NULL,
    FOREIGN KEY (id_program_studi) REFERENCES Program_Studi(id_program_studi) ON DELETE CASCADE
);

CREATE TABLE Kelas_rkbf (
    id_kelas INT AUTO_INCREMENT PRIMARY KEY,
    nama_kelas VARCHAR(50) NOT NULL,
    id_matakuliah INT NOT NULL,
    id_dosen INT NOT NULL,
    tahun_akademik VARCHAR(9) NOT NULL,
    semester INT NOT NULL CHECK (semester BETWEEN 1 AND 8),
    kapasitas INT NOT NULL CHECK (kapasitas > 0),
    FOREIGN KEY (id_matakuliah) REFERENCES Mata_Kuliah(id_matakuliah) ON DELETE CASCADE,
    FOREIGN KEY (id_dosen) REFERENCES Dosen(nip) ON DELETE CASCADE
);

CREATE TABLE KRS (
    id_krs INT AUTO_INCREMENT PRIMARY KEY,
    id_mahasiswa INT NOT NULL,
    id_kelas INT NOT NULL,
    tahun_akademik VARCHAR(9) NOT NULL,
    FOREIGN KEY (id_mahasiswa) REFERENCES Mahasiswa(nim) ON DELETE CASCADE,
    FOREIGN KEY (id_kelas) REFERENCES Kelas(id_kelas) ON DELETE CASCADE
);

INSERT INTO Program_Studi (kode_program, nama_program, fakultas) VALUES
('IF', 'Informatika', 'Teknik'),
('SI', 'Sistem Informasi', 'Ekonomi & Bisnis'),
('TI', 'Teknik Industri', 'Teknik');

INSERT INTO Mahasiswa (nim, nama_mhs, angkatan, id_program_studi, tanggal_lahir, jenis_kelamin) VALUES
(230001, 'Ana Safitri', 2023, 1, '2004-04-06', 'Perempuan'),
(230002, 'Ana', 2023, 2, '2004-02-15', 'Perempuan'),
(230003, 'Safitri', 2023, 3, '2002-07-20', 'Perempuan'),
(240004, 'Kira', 2024, 1, '2003-11-25', 'Laki-laki'),
(230005, 'Rizky', 2023, 2, '2005-03-12', 'Laki-laki'),
(230006, 'Adit', 2023, 3, '2004-08-30', 'Laki-laki'),
(200007, 'Doni', 2020, 1, '2001-09-18', 'Laki-laki'),
(230008, 'Tara', 2023, 2, '2005-12-28', 'Perempuan'),
(230009, 'Dhelia', 2023, 3, '2004-06-22', 'Perempuan'),
(230010, 'Safira', 2023, 1, '2005-04-17', 'Perempuan');

INSERT INTO Dosen (nip, nama, email, no_hp, alamat, id_program_studi) VALUES
(123450, 'Pak Budi', 'budi@trunojoyo.ac.id', '081234567890', 'Jl. Trunojoyo, No.22', 1),
(123451, 'Bu Yeni', 'yeni@trunojoyo.ac.id', '081345678901', 'Perumahan Graha', 2),
(123452, 'Pak Zain', 'zain@trunojoyo.ac.id', '081456789012', 'Telang Asri', 3),
(123453, 'Bu Mala', 'mala@trunojoyo.ac.id', '081567890123', 'Kayangan Residen', 1),
(123454, 'Bu Bila', 'bila@trunojoyo.ac.id', '081678901234', 'Telang Asri', 2),
(123455, 'Pak Firli', 'firli@trunojoyo.ac.id', '081789012345', 'Perumahan Graha', 3),
(123456, 'Pak Doni', 'doni@trunojoyo.ac.id', '081890123456', 'Telang Asri', 1),
(123457, 'Bu Rosida', 'roshida@trunojoyo.ac.id', '081901234567', 'Perumahan Indah', 2),
(123458, 'Bu Fitri', 'fitri@trunojoyo.ac.id', '082012345678', 'Perumahan Indah', 3),
(123459, 'Pak Yudha', 'yudha@trunojoyo.ac.id', '082123456789', 'Perumahan Graha', 1);

INSERT INTO Mata_Kuliah (kode_matakuliah, nama_matakuliah, sks, semester, id_dosen, id_program_studi) VALUES
('RKBF01', 'Riset Operasi', 3, 1, 123450, 1),
('RKBF02', 'Sumber Daya Perusahaan', 3, 1, 123451, 1),
('RKBF03', 'Algoritma Pemrograman', 4, 2, 123452, 1),
('RKBF04', 'Pemrograman Bergerak', 3, 2, 123453, 1),
('RKBF05', 'Sistem Manajemen Basis Data', 3, 3, 123454, 1),
('RKBF06', 'Rekayasa Perangkat Lunak', 3, 3, 123455, 2),
('RKBF07', 'Arsitektur', 4, 4, 123456, 2),
('RKBF08', 'Manajemen Proyek IT', 3, 4, 123457, 2),
('RKBF09', 'Kepemimpinan', 3, 5, 123458, 3),
('RKBF10', 'Analisis Proses Bisnis', 3, 5, 123459, 3);

INSERT INTO KRS (id_mahasiswa, id_kelas, tahun_akademik) VALUES
(230001, 1, '2025/2026'),
(230002, 2, '2025/2026'),
(230003, 3, '2025/2026'),
(240004, 1, '2025/2026'),
(230005, 2, '2025/2026');

INSERT INTO Kelas_rkbf (nama_kelas, id_matakuliah, id_dosen, tahun_akademik, semester, kapasitas) VALUES
('Kelas A', 1, 123450, '2025/2026', 1, 30),
('Kelas B', 2, 123451, '2025/2026', 1, 30),
('Kelas C', 3, 123452, '2025/2026', 2, 30);

-- Menampilkan Data Table --
SELECT * FROM Mahasiswa;

SELECT * FROM dosen;

SELECT * FROM mata_kuliah;

-- Mengganti Atau Update Table --
UPDATE Mahasiswa SET tanggal_lahir = '2006-06-26' WHERE nim = '230010';

ALTER TABLE kelas RENAME kelas_rkbf;

-- Mengganti Nama Kolom Pada Table Mahasiswa --
ALTER TABLE mahasiswa 
CHANGE nama nama_mhs VARCHAR(100);

-- Menghapus seluruh database --
DROP DATABASE db_akademik_studi;