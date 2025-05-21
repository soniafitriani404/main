 soal 1 
CREATE DATABASE akademik;
USE akademik;


CREATE TABLE Mahasiswa (
  nim VARCHAR(10) PRIMARY KEY,
  nama VARCHAR(50),
  jurusan VARCHAR(50),
  angkatan INT
);

INSERT INTO Mahasiswa VALUES
('01', 'Tanji', 'Informatika', 2023),
('02', 'Rival valentino', 'sistem informasi', 2023),
('03', 'Rusydi Chalim', 'Sistem Informasi', 2023),
('04', 'Akhmad Muhtadyin', 'Teknik Komputer', 2023),
('05', 'izam Mahendra ', 'Informatika', 2022),
('06', 'Muhammad Miftahul Faizin', 'Sistem Informasi', 2023),
('07', 'Payrudin', 'Informatika', 2022),
('08', 'Muhammad Denis Benevolensa ', 'Teknik Komputer', 2021),
('09', 'KIM JONG UN', 'Informatika', 2023),
('10', 'Naruto Uzumaki ', 'Sistem Informasi', 2023);


CREATE TABLE Dosen (
  nidn VARCHAR(10) PRIMARY KEY,
  nama VARCHAR(50),
  bidang VARCHAR(50)
);

INSERT INTO Dosen VALUES
('D001', 'Pak Budi', 'Pemrograman'),
('D002', 'Bu Fitri', 'Basis Data'),
('D003', 'Pak Syarif', 'Jaringan Komputer'),
('D004', 'Pak Ali', 'Algoritma'),
('D005', 'Bu Eza', 'Sistem Informasi'),
('D006', 'Bu Billa ', 'AI'),
('D007', 'Pak Zain', 'Keamanan'),
('D008', 'Pak Hendra', 'Apk Development'),
('D009', 'Bu Novi', 'Teknik Komputer'),
('D010', 'Bu Imamah', 'Web Development');


CREATE TABLE MataKuliah (
  kode_mk VARCHAR(10) PRIMARY KEY,
  nama_mk VARCHAR(50),
  sks INT,
  nidn VARCHAR(10),
  FOREIGN KEY (nidn) REFERENCES Dosen(nidn)
);

INSERT INTO MataKuliah VALUES
('MK01', 'PEMROGRAMAN BERBASIS WEB', 3, 'D001'),
('MK02', 'SISTEM BASIS DATA', 3, 'D002'),
('MK03', 'SISTEM PENDUKUNG KEPUTUSAN', 3, 'D003'),
('MK04', 'ALGORITMA  PEMROGRAMAN', 3, 'D004'),
('MK05', 'PEMROGRAMAN BERBAIS OBJEK', 3, 'D005'),
('MK06', 'KEAMANAN INFORMASI', 3, 'D006'),
('MK07', 'PEMROGRAMAN BERGERAK', 3, 'D007'),
('MK08', 'PENDUKUNG BASIS DATA', 3, 'D008'),
('MK09', 'RISET OPERASI', 3, 'D009'),
('MK10', 'PEMROGRAMAN VISUAL', 3, 'D010');

CREATE TABLE KRS (
  id_krs INT AUTO_INCREMENT PRIMARY KEY,
  nim VARCHAR(10),
  kode_mk VARCHAR(10),
  semester INT,
  FOREIGN KEY (nim) REFERENCES Mahasiswa(nim),
  FOREIGN KEY (kode_mk) REFERENCES MataKuliah(kode_mk)
);

INSERT INTO KRS (nim, kode_mk, semester) VALUES
('01', 'MK01', 1),
('02', 'MK02', 1),
('03', 'MK03', 2),
('04', 'MK04', 2),
('05', 'MK05', 3);

SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM MataKuliah;
SELECT * FROM KRS;

UPDATE Mahasiswa
SET nama = 'Tanji'
WHERE nim = '02';

DROP DATABASE Akademik;



 
 
 
 
 
 
 
 
 
soal 2  
CREATE DATABASE db_tokoanime;
USE db_tokoanime;


CREATE TABLE Kategori (
  id_kategori INT AUTO_INCREMENT PRIMARY KEY,
  nama_kategori VARCHAR(50)
);


CREATE TABLE Barang (
  id_barang INT AUTO_INCREMENT PRIMARY KEY,
  nama_barang VARCHAR(100),
  harga INT,
  stok INT,
  id_kategori INT,
  FOREIGN KEY (id_kategori) REFERENCES Kategori(id_kategori)
);


CREATE TABLE Pelanggan (
  id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
  nama VARCHAR(100),
  alamat VARCHAR(255),
  no_hp VARCHAR(15)
);


CREATE TABLE Pegawai (
  id_pegawai INT AUTO_INCREMENT PRIMARY KEY,
  nama VARCHAR(100),
  posisi VARCHAR(50)
);


CREATE TABLE Penjualan (
  id_penjualan INT AUTO_INCREMENT PRIMARY KEY,
  id_pelanggan INT,
  id_pegawai INT,
  tanggal DATE,
  FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan),
  FOREIGN KEY (id_pegawai) REFERENCES Pegawai(id_pegawai)
);


CREATE TABLE DetailPenjualan (
  id_detail INT AUTO_INCREMENT PRIMARY KEY,
  id_penjualan INT,
  id_barang INT,
  jumlah INT,
  subtotal INT,
  FOREIGN KEY (id_penjualan) REFERENCES Penjualan(id_penjualan),
  FOREIGN KEY (id_barang) REFERENCES Barang(id_barang)
);
