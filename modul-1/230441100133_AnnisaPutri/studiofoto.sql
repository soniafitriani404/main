-- 1. BUAT DATABASE DAN PAKAI
CREATE DATABASE IF NOT EXISTS db_studio_foto;
USE db_studio_foto;

-- 2. BUAT TABEL
CREATE TABLE Pelanggan (
    pelanggan_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    no_hp VARCHAR(15),
    email VARCHAR(100),
    alamat TEXT
);

CREATE TABLE Paket (
    paket_id INT AUTO_INCREMENT PRIMARY KEY,
    nama_paket VARCHAR(100),
    harga INT,
    deskripsi TEXT
);

CREATE TABLE Fotografer (
    fotografer_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    no_hp VARCHAR(15)
);

-- Relasi kreatif: satu fotografer bisa handle banyak paket, dan sebaliknya
CREATE TABLE Fotografer_Paket (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fotografer_id INT,
    paket_id INT,
    FOREIGN KEY (fotografer_id) REFERENCES Fotografer(fotografer_id),
    FOREIGN KEY (paket_id) REFERENCES Paket(paket_id)
);

CREATE TABLE Pemesanan (
    pemesanan_id INT AUTO_INCREMENT PRIMARY KEY,
    pelanggan_id INT,
    paket_id INT,
    fotografer_id INT,
    tanggal_pesan DATE,
    jam_pesan TIME,
    STATUS ENUM('Menunggu Pembayaran', 'Diproses', 'Selesai'),
    FOREIGN KEY (pelanggan_id) REFERENCES Pelanggan(pelanggan_id),
    FOREIGN KEY (paket_id) REFERENCES Paket(paket_id),
    FOREIGN KEY (fotografer_id) REFERENCES Fotografer(fotografer_id)
);

CREATE TABLE Voucher (
    voucher_id INT AUTO_INCREMENT PRIMARY KEY,
    kode_voucher VARCHAR(20),
    diskon_persen INT
);

CREATE TABLE Pembayaran (
    pembayaran_id INT AUTO_INCREMENT PRIMARY KEY,
    pemesanan_id INT,
    total_bayar INT,
    metode_pembayaran ENUM('Transfer', 'Cash', 'QRIS'),
    voucher_id INT,
    tanggal_bayar DATE,
    FOREIGN KEY (pemesanan_id) REFERENCES Pemesanan(pemesanan_id),
    FOREIGN KEY (voucher_id) REFERENCES Voucher(voucher_id)
);

CREATE TABLE HasilFoto (
    hasil_id INT AUTO_INCREMENT PRIMARY KEY,
    pemesanan_id INT,
    nama_file VARCHAR(100),
    url_file TEXT,
    FOREIGN KEY (pemesanan_id) REFERENCES Pemesanan(pemesanan_id)
);

-- 3. INSERT DATA
INSERT INTO Pelanggan (nama, no_hp, email, alamat) VALUES
('Dina Lestari', '081234567890', 'dina@gmail.com', 'Jl. Kenanga No.12'),
('Andi Saputra', '082198765432', 'andi@yahoo.com', 'Jl. Melati No.5'),
('Sari Wulandari', '083356789012', 'sari@gmail.com', 'Jl. Anggrek No.9');

INSERT INTO Paket (nama_paket, harga, deskripsi) VALUES
('Paket Keluarga', 350000, '10 foto cetak + softcopy + edit'),
('Paket Couple', 250000, '8 foto cetak + softcopy + edit'),
('Paket Wisuda', 200000, '5 foto cetak + softcopy');

INSERT INTO Fotografer (nama, no_hp) VALUES
('Riko Pratama', '085212345678'),
('Nina Sari', '085267890123');

INSERT INTO Fotografer_Paket (fotografer_id, paket_id) VALUES
(1, 1),
(1, 3),
(2, 2),
(2, 3);

INSERT INTO Pemesanan (pelanggan_id, paket_id, fotografer_id, tanggal_pesan, jam_pesan, STATUS) VALUES
(1, 1, 1, '2025-04-08', '10:00:00', 'Menunggu Pembayaran'),
(2, 2, 2, '2025-04-09', '14:00:00', 'Diproses'),
(3, 3, 1, '2025-04-07', '09:00:00', 'Selesai');

INSERT INTO Voucher (kode_voucher, diskon_persen) VALUES
('PROMO10', 10),
('HEMAT15', 15);

INSERT INTO Pembayaran (pemesanan_id, total_bayar, metode_pembayaran, voucher_id, tanggal_bayar) VALUES
(1, 315000, 'Transfer', 1, '2025-04-08'),
(2, 250000, 'QRIS', NULL, '2025-04-09'),
(3, 170000, 'Cash', 2, '2025-04-07');

INSERT INTO HasilFoto (pemesanan_id, nama_file, url_file) VALUES
(3, 'wisuda1.jpg', 'https://example.com/foto/wisuda1.jpg'),
(3, 'wisuda2.jpg', 'https://example.com/foto/wisuda2.jpg');

SELECT * FROM Pelanggan;
SELECT * FROM Paket;
SELECT * FROM Pemesanan;
SELECT * FROM Pembayaran;
