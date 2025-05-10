CREATE DATABASE les_bahasa_inggris;
USE les_bahasa_inggris;

CREATE TABLE siswa (
    id_siswa INT AUTO_INCREMENT PRIMARY KEY,
    nama_siswa VARCHAR(100),
    alamat TEXT,
    no_telepon VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE instruktur (
    id_instruktur INT AUTO_INCREMENT PRIMARY KEY,
    nama_instruktur VARCHAR(100),
    spesialisasi VARCHAR(100),
    no_telepon VARCHAR(15)
);

CREATE TABLE kelas (
    id_kelas INT AUTO_INCREMENT PRIMARY KEY,
    nama_kelas VARCHAR(100),
    tingkat ENUM('Beginner', 'Intermediate', 'Advanced'),
    jadwal VARCHAR(50),
    biaya DECIMAL(10,2),
    id_instruktur INT,
    FOREIGN KEY (id_instruktur) REFERENCES instruktur(id_instruktur)
);

CREATE TABLE pendaftaran (
    id_pendaftaran INT AUTO_INCREMENT PRIMARY KEY,
    id_siswa INT,
    id_kelas INT,
    tanggal_daftar DATE,
    STATUS ENUM('Aktif', 'Tidak Aktif'),
    FOREIGN KEY (id_siswa) REFERENCES siswa(id_siswa),
    FOREIGN KEY (id_kelas) REFERENCES kelas(id_kelas)
);

CREATE TABLE pembayaran (
    id_pembayaran INT AUTO_INCREMENT PRIMARY KEY,
    id_pendaftaran INT,
    tanggal_bayar DATE,
    jumlah_bayar DECIMAL(10,2),
    metode_bayar ENUM('Cash', 'Transfer', 'QRIS'),
    FOREIGN KEY (id_pendaftaran) REFERENCES pendaftaran(id_pendaftaran)
);


-- pengisian data
INSERT INTO siswa (nama_siswa, alamat, no_telepon, email) VALUES
('Rizki Fajar', 'Jl. Mangga No.12, Malang', '081330958200', 'fajar@gmail.com'),
('Rafi Refalda', 'Jl. Melati No.5, Surabaya', '082298765432', 'rafi@yahoo.com'),
('Yoga Herlindo', 'Jl. Mawar No.3, Surabaya', '083312341234', 'yogababel@gmail.com');

INSERT INTO instruktur (nama_instruktur, spesialisasi, no_telepon) VALUES
('Aidan Fawwaz', 'Speaking', '082217171172'),
('Rina Ayu', 'Grammar', '082345678901'),
('Andi Widodo', 'TOEFL Preparation', '083456789012');

INSERT INTO kelas (nama_kelas, tingkat, jadwal, biaya, id_instruktur) VALUES
('Kelas Dasar A', 'Beginner', 'Senin & Rabu 10.00-12.00', 750000, 1),
('Kelas Menengah B', 'Intermediate', 'Selasa & Kamis 13.00-15.00', 850000, 2),
('TOEFL Intensive', 'Advanced', 'Sabtu & Minggu 09.00-11.00', 1000000, 3);

INSERT INTO pendaftaran (id_siswa, id_kelas, tanggal_daftar, STATUS) VALUES
(1, 1, '2025-04-01', 'Aktif'),
(2, 2, '2025-04-02', 'Aktif'),
(3, 3, '2025-04-03', 'Tidak Aktif');

INSERT INTO pembayaran (id_pendaftaran, tanggal_bayar, jumlah_bayar, metode_bayar) VALUES
(1, '2025-04-01', 750000, 'Cash'),
(2, '2025-04-02', 850000, 'Transfer'),
(3, '2025-04-04', 0, 'Cash'); -- Tidak aktif, belum bayar

SELECT * FROM instruktur;
SELECT * FROM kelas;
SELECT * FROM pembayaran;
SELECT * FROM pendaftaran;
SELECT * FROM siswa;
