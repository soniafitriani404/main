-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS db_akademik;
USE db_akademik;

-- CREATE TABLES
CREATE TABLE Mahasiswa (
    nim VARCHAR(10) PRIMARY KEY,
    nama VARCHAR(100),
    jenis_kelamin ENUM('L', 'P'),
    jurusan_id INT,
    FOREIGN KEY (jurusan_id) REFERENCES Jurusan(jurusan_id)
);

CREATE TABLE Dosen (
    nip VARCHAR(10) PRIMARY KEY,
    nama VARCHAR(100)
);

CREATE TABLE MataKuliah (
    kode_mk VARCHAR(10) PRIMARY KEY,
    nama_mk VARCHAR(100),
    sks INT,
    nip VARCHAR(10),
    FOREIGN KEY (nip) REFERENCES Dosen(nip)
);

CREATE TABLE KRS (
    krs_id INT AUTO_INCREMENT PRIMARY KEY,
    nim VARCHAR(10),
    kode_mk VARCHAR(10),
    semester ENUM('Ganjil', 'Genap'),
    FOREIGN KEY (nim) REFERENCES Mahasiswa(nim),
    FOREIGN KEY (kode_mk) REFERENCES MataKuliah(kode_mk)
);

-- INSERT INTO Jurusan
INSERT INTO Jurusan (nama_jurusan) VALUES
('Teknik Informatika'),
('Sistem Informasi'),
('Teknik Elektro'),
('Teknik Industri'),
('Manajemen'),
('Akuntansi'),
('Ilmu Komunikasi'),
('Desain Produk'),
('Psikologi'),
('Pendidikan Matematika');

-- INSERT INTO Mahasiswa
INSERT INTO Mahasiswa (nim, nama, jenis_kelamin, jurusan_id) VALUES
('M001', 'Aulia Rahma', 'P', 1),
('M002', 'Budi Santoso', 'L', 2),
('M003', 'Citra Dewi', 'P', 3),
('M004', 'Deni Saputra', 'L', 4),
('M005', 'Eka Lestari', 'P', 5),
('M006', 'Fajar Nugroho', 'L', 6),
('M007', 'Gita Putri', 'P', 7),
('M008', 'Hendra Gunawan', 'L', 8),
('M009', 'Intan Sari', 'P', 9),
('M010', 'Joko Widodo', 'L', 10);

-- INSERT INTO Dosen
INSERT INTO Dosen (nip, nama) VALUES
('D001', 'Dr. Andi Nugraha'),
('D002', 'Prof. Lina Kurnia'),
('D003', 'Bambang Susanto'),
('D004', 'Rina Marlina');

-- INSERT INTO MataKuliah
INSERT INTO MataKuliah (kode_mk, nama_mk, sks, nip) VALUES
('MK001', 'Basis Data', 3, 'D001'),
('MK002', 'Pemrograman Web', 3, 'D002'),
('MK003', 'Jaringan Komputer', 2, 'D001'),
('MK004', 'Manajemen Proyek', 3, 'D003');

-- INSERT INTO KRS
INSERT INTO KRS (nim, kode_mk, semester) VALUES
('M001', 'MK001', 'Ganjil'),
('M002', 'MK002', 'Genap'),
('M003', 'MK003', 'Ganjil'),
('M004', 'MK001', 'Genap'),
('M005', 'MK004', 'Ganjil');

-- UPDATE Mahasiswa
UPDATE Mahasiswa
SET nama = 'Aulia Nur Rahma'
WHERE nim = 'M001';

SELECT * FROM Jurusan;
SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM MataKuliah;
SELECT * FROM KRS;
