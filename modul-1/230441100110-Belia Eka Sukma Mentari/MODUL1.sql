CREATE DATABASE akademik_prodi;

USE akademik_prodi;

CREATE TABLE Mahasiswa (
    nim VARCHAR(10) PRIMARY KEY,
    nama VARCHAR(100),
    tanggal_lahir DATE,
    jenis_kelamin ENUM('L', 'P'),
    alamat VARCHAR(255)
);

CREATE TABLE Dosen (
    nidn VARCHAR(10) PRIMARY KEY,
    nama VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE MataKuliah (
    kode_mk VARCHAR(10) PRIMARY KEY,
    nama_mk VARCHAR(100),
    sks INT
);

CREATE TABLE KRS (
    id_krs INT AUTO_INCREMENT PRIMARY KEY,
    nim VARCHAR(10),
    kode_mk VARCHAR(10),
    nidn VARCHAR(10),
    semester INT,
    FOREIGN KEY (nim) REFERENCES Mahasiswa(nim) ON DELETE CASCADE,
    FOREIGN KEY (kode_mk) REFERENCES MataKuliah(kode_mk) ON DELETE CASCADE,
    FOREIGN KEY (nidn) REFERENCES Dosen(nidn) ON DELETE CASCADE
);

SHOW TABLES;

INSERT INTO Mahasiswa VALUES
('220001', 'Ali Ahmad', '2002-03-12', 'L', 'Surabaya'),
('220002', 'Budi Santoso', '2003-05-22', 'L', 'Malang'),
('220003', 'Citra Dewi', '2002-11-15', 'P', 'Jakarta'),
('220004', 'Dina Lestari', '2001-07-19', 'P', 'Bandung'),
('220005', 'Eko Saputra', '2003-01-30', 'L', 'Yogyakarta'),
('220006', 'Fajar Ramadhan', '2002-06-18', 'L', 'Solo'),
('220007', 'Gita Maharani', '2004-02-10', 'P', 'Bali'),
('220008', 'Hadi Prasetyo', '2003-09-25', 'L', 'Semarang'),
('220009', 'Indah Permata', '2001-12-07', 'P', 'Medan'),
('220010', 'Joko Setiawan', '2002-08-20', 'L', 'Surabaya');

INSERT INTO Dosen VALUES
('10001', 'Dr. Ahmad Fauzi', 'ahmadf@example.com'),
('10002', 'Dr. Budi Hartono', 'budih@example.com'),
('10003', 'Dr. Citra Mawar', 'citram@example.com'),
('10004', 'Dr. Dimas Saputra', 'dimass@example.com'),
('10005', 'Dr. Elvira Sari', 'elviras@example.com'),
('10006', 'Dr. Faisal Ramadhan', 'faisalr@example.com'),
('10007', 'Dr. Gita Indri', 'gitai@example.com'),
('10008', 'Dr. Hasan Basri', 'hasanb@example.com'),
('10009', 'Dr. Irma Dewi', 'irmad@example.com'),
('10010', 'Dr. Joko Widodo', 'jokow@example.com');

INSERT INTO MataKuliah VALUES
('MK001', 'Pemrograman Dasar', 3),
('MK002', 'Basis Data', 4),
('MK003', 'Algoritma & Struktur Data', 3),
('MK004', 'Jaringan Komputer', 3),
('MK005', 'Kecerdasan Buatan', 4),
('MK006', 'Sistem Operasi', 3),
('MK007', 'Manajemen Proyek TI', 2),
('MK008', 'Keamanan Informasi', 3),
('MK009', 'Rekayasa Perangkat Lunak', 3),
('MK010', 'Pemrograman Web', 3);

SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM MataKuliah;

INSERT INTO KRS (nim, kode_mk, nidn, semester) VALUES
('220001', 'MK001', '10001', 1),
('220002', 'MK002', '10002', 1),
('220003', 'MK003', '10003', 2),
('220004', 'MK004', '10004', 2),
('220005', 'MK005', '10005', 3);

ALTER TABLE MataKuliah RENAME TO Mata_Kuliah;

SELECT * FROM Mata_Kuliah;

SELECT * FROM KRS;

DROP DATABASE akademik_prodi;