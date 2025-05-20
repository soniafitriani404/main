CREATE DATABASE Tiket_kereta;

USE Tiket_kereta;

CREATE TABLE kereta (
    id_kereta INT PRIMARY KEY AUTO_INCREMENT,
    nama_kereta VARCHAR(100) NOT NULL,
    jenis_kereta ENUM('Eksekutif', 'Bisnis', 'Ekonomi') NOT NULL,
    kapasitas INT NOT NULL
);

CREATE TABLE stasiun (
    id_stasiun INT PRIMARY KEY AUTO_INCREMENT,
    nama_stasiun VARCHAR(100) NOT NULL,
    lokasi VARCHAR(255) NOT NULL
);

CREATE TABLE penumpang (
    id_penumpang INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    no_telepon VARCHAR(15) NOT NULL,
    alamat TEXT
);

CREATE TABLE jadwal (
    id_jadwal INT PRIMARY KEY AUTO_INCREMENT,
    id_kereta INT NOT NULL,
    id_stasiun_asal INT NOT NULL,
    id_stasiun_tujuan INT NOT NULL,
    tanggal_keberangkatan DATE NOT NULL,
    waktu_berangkat TIME NOT NULL,
    waktu_tiba TIME NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_kereta) REFERENCES kereta(id_kereta),
    FOREIGN KEY (id_stasiun_asal) REFERENCES stasiun(id_stasiun),
    FOREIGN KEY (id_stasiun_tujuan) REFERENCES stasiun(id_stasiun)
);

CREATE TABLE pemesanan (
    id_pemesanan INT PRIMARY KEY AUTO_INCREMENT,
    id_penumpang INT NOT NULL,
    id_jadwal INT NOT NULL,
    jumlah_tiket INT NOT NULL,
    total_harga DECIMAL(10,2) NOT NULL,
    STATUS ENUM('Dipesan', 'Dibayar', 'Dibatalkan') NOT NULL DEFAULT 'Dipesan',
    tanggal_pemesanan TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_penumpang) REFERENCES penumpang(id_penumpang),
    FOREIGN KEY (id_jadwal) REFERENCES jadwal(id_jadwal)
);

INSERT INTO kereta (nama_kereta, jenis_kereta, kapasitas) VALUES
('Argo Bromo Anggrek', 'Eksekutif', 300),
('Gaya Baru Malam Selatan', 'Ekonomi', 350),
('Taksaka', 'Bisnis', 250);

INSERT INTO stasiun (nama_stasiun, lokasi) VALUES
('Stasiun Surabaya Gubeng', 'Surabaya'),
('Stasiun Pasar Senen', 'Jakarta'),
('Stasiun Yogyakarta', 'Yogyakarta'),
('Stasiun Malang', 'Malang');

INSERT INTO penumpang (nama, email, no_telepon, alamat) VALUES
('Laili Ilhami', 'laili@email.com', '081234567890', 'Sampang, Madura'),
('Budi Santoso', 'budi@email.com', '082345678901', 'Jakarta'),
('Siti Aminah', 'siti@email.com', '083456789012', 'Yogyakarta');


INSERT INTO jadwal (id_kereta, id_stasiun_asal, id_stasiun_tujuan, tanggal_keberangkatan, waktu_berangkat, waktu_tiba, harga) VALUES
(1, 1, 2, '2025-04-20', '08:00:00', '16:00:00', 450000.00),
(2, 2, 3, '2025-04-21', '19:00:00', '06:00:00', 300000.00),
(3, 3, 4, '2025-04-22', '10:00:00', '14:00:00', 350000.00);


INSERT INTO pemesanan (id_penumpang, id_jadwal, jumlah_tiket, total_harga, STATUS) VALUES
(1, 1, 2, 900000.00, 'Dipesan'),
(2, 2, 1, 300000.00, 'Dibayar'),
(3, 3, 3, 1050000.00, 'Dipesan');

---1---
ALTER TABLE pemesanan
ADD keterangan TEXT AFTER tanggal_pemesanan;
UPDATE pemesanan
SET keterangan = 'Tiket dikirim melalui email'
WHERE id_pemesanan = 1;
SELECT * FROM pemesanan;

----2----
SELECT 
    p.id_pemesanan,
    pen.nama AS nama_penumpang,
    pen.email AS email_penumpang,
    pen.no_telepon,
    p.jumlah_tiket,
    p.total_harga,
    p.STATUS,
    p.tanggal_pemesanan
FROM pemesanan p
JOIN penumpang pen ON p.id_penumpang = pen.id_penumpang;

---3 mengurutkan tabel dgn perintah orderby,ASC,DESC---
SELECT * FROM kereta
ORDER BY kapasitas DESC;
SELECT * FROM kereta
ORDER BY nama_kereta ASC;

SELECT * FROM stasiun
ORDER BY lokasi ASC;
SELECT * FROM stasiun
ORDER BY nama_stasiun DESC;

SELECT * FROM penumpang
ORDER BY nama ASC;
SELECT * FROM penumpang
ORDER BY id_penumpang DESC;

SELECT * FROM jadwal
ORDER BY tanggal_keberangkatan ASC;
SELECT * FROM jadwal
ORDER BY harga DESC;

SELECT * FROM pemesanan
ORDER BY tanggal_pemesanan ASC;
SELECT * FROM pemesanan
ORDER BY total_harga DESC;

---4blm fixx---
ALTER TABLE penumpang
MODIFY no_telepon VARCHAR(20) NOT NULL;

SELECT id_penumpang, nama, no_telepon, email, alamat
FROM penumpang;

----5---
SELECT p.id_pemesanan, pen.nama AS nama_penumpang, j.tanggal_keberangkatan
FROM pemesanan p
LEFT JOIN penumpang pen ON p.id_penumpang = pen.id_penumpang
LEFT JOIN jadwal j ON p.id_jadwal = j.id_jadwal;

SELECT p.id_pemesanan, pen.nama AS nama_penumpang, j.tanggal_keberangkatan
FROM pemesanan p
RIGHT JOIN penumpang pen ON p.id_penumpang = pen.id_penumpang
RIGHT JOIN jadwal j ON p.id_jadwal = j.id_jadwal;

SELECT a.id_penumpang, a.nama AS nama_penumpang, b.nama AS nama_penumpang_lain
FROM penumpang a
JOIN penumpang b ON a.id_penumpang != b.id_penumpang;

SELECT p.id_pemesanan, pen.nama AS nama_penumpang, j.tanggal_keberangkatan, p.total_harga
FROM pemesanan p
JOIN penumpang pen ON p.id_penumpang = pen.id_penumpang
JOIN jadwal j ON p.id_jadwal = j.id_jadwal
WHERE p.total_harga > 500000.00  -- Menggunakan operator perbandingan `>`
AND j.tanggal_keberangkatan <= '2025-04-21'  -- Menggunakan operator perbandingan `<=`
AND pen.nama != 'Budi Santoso'  -- Menggunakan operator perbandingan `!=`
AND j.harga >= 300000.00  -- Menggunakan operator perbandingan `>=`
AND pen.email LIKE '%@email.com';  -- Menggunakan operator perbandingan `LIKE` untuk pencocokan pola








