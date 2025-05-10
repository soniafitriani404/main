CREATE DATABASE akademik; -- Membuat db akademik

USE akademik; -- Menggunakan db akademik

CREATE TABLE mahasiswa( -- Membuat tabel Mahasiswa
	nim INT PRIMARY KEY,
	nama VARCHAR(50),
	alamat VARCHAR(100),
	no_telp VARCHAR(15)
);

CREATE TABLE dosen( -- Membuat tabel dosen
	nid INT PRIMARY KEY,
	nama VARCHAR(50),
	bidang VARCHAR(50),
	no_telp VARCHAR(15)
);

CREATE TABLE MataKuliah ( -- Membuat tabel mtkuliah
    kode_mk VARCHAR(10) PRIMARY KEY,
    nama_mk VARCHAR(50),
    sks INT
);

CREATE TABLE KRS (-- Membuat tabel krs
    id_krs INT AUTO_INCREMENT PRIMARY KEY,
    nim INT,
    kode_mk VARCHAR(10),
    semester INT,
    FOREIGN KEY (nim) REFERENCES Mahasiswa(nim),
    FOREIGN KEY (kode_mk) REFERENCES MataKuliah(kode_mk)
);

INSERT INTO mahasiswa VALUES -- Mengisi data ke tabel Mahasiswa
(101, 'Safira Rihadatul Aisy', 'Bangkalan', '081234567890'),
(102, 'Rizky Ramadhan', 'Surabaya', '081212345678'),
(103, 'Nadia Aulia', 'Gresik', '081398765432'),
(104, 'Daffa Alfarizi', 'Mojokerto', '081354321987'),
(105, 'Putri Wulandari', 'Sidoarjo', '081287654321'),
(106, 'Hana Permata', 'Malang', '081265432189'),
(107, 'Adit Prasetyo', 'Jember', '081356789123'),
(108, 'Siti Rahma', 'Madura', '081276543210'),
(109, 'Farhan Pradana', 'Banyuwangi', '081289765432'),
(110, 'Dian Lestari', 'Probolinggo', '081234569876');

INSERT INTO Dosen VALUES -- Mengisi data ke tabel dosen
(2001, 'Dr. Bambang', 'Basis Data', '081111111111'),
(2002, 'Prof. Siti Aisyah', 'Pemrograman', '081122222222'),
(2003, 'Dr. Rudi Hartono', 'Jaringan Komputer', '081133333333'),
(2004, 'Dr. Lestari', 'Kecerdasan Buatan', '081144444444'),
(2005, 'Dr. Rian Saputra', 'Sistem Operasi', '081155555555'),
(2006, 'Prof. Widya Astuti', 'Keamanan Informasi', '081166666666'),
(2007, 'Dr. Andi Wijaya', 'Pengolahan Citra', '081177777777'),
(2008, 'Dr. Lina Susanti', 'Analisis Algoritma', '081188888888'),
(2009, 'Dr. Dwi Kurniawan', 'Data Science', '081199999999'),
(2010, 'Prof. Ilham Kusuma', 'Manajemen Proyek IT', '081122233344');

INSERT INTO MataKuliah VALUES -- Mengisi data ke tabel mtkuliah
('MK001', 'Basis Data', 3),
('MK002', 'Pemrograman Java', 4),
('MK003', 'Jaringan Komputer', 3),
('MK004', 'Sistem Operasi', 3),
('MK005', 'Keamanan Informasi', 3),
('MK006', 'Pemrograman visual', 3),
('MK007', 'Analisis Algoritma', 3),
('MK008', 'Data Science', 4),
('MK009', 'Manajemen Proyek IT', 2),
('MK010', 'Kecerdasan Buatan', 3);

SELECT * FROM mahasiswa; -- Menampilkan data mhs
SELECT * FROM Dosen; -- Menampilkan data dsn
SELECT * FROM MataKuliah; -- Menampilkan data mk

INSERT INTO KRS (nim, kode_mk, semester) VALUES -- Menambahkan data tabel KRS sebanyak 5 data
(101, 'MK001', 1),
(102, 'MK002', 2),
(103, 'MK003', 3),
(104, 'MK004', 4),
(105, 'MK005', 5);

SELECT * FROM KRS; -- Menampilkan data dari tabel KRS

ALTER TABLE mahasiswa RENAME TO DataMahasiswa; -- Mengubah nama tabel mahasiswa menjadi DataMahasiswa

SELECT * FROM DataMahasiswa; -- Menampilkan dataMhs

SHOW TABLES; -- Menampilkan tabel setelah perubahan nama

DROP DATABASE akademik; -- Menghapus database akademik
