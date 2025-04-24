CREATE DATABASE peternakan_bebek;
USE peternakan_bebek;

-- table master
CREATE TABLE peternak (
    id_peternak INT PRIMARY KEY AUTO_INCREMENT,
    nama_peternak VARCHAR(100),
    alamat TEXT,
    no_hp VARCHAR(20)
);
-- Insert data into peternak
INSERT INTO peternak (nama_peternak, alamat, no_hp) VALUES
('Budi Susilo', 'Jl. Raya No.1, Jakarta', '081234567890'),
('Siti Khoiriyah', 'Jl. Pahlawan No.2, Bandung', '082134567891'),
('Antonny', 'Jl. Merdeka No.3, Surabaya', '083234567892'),
('Dewi Kartika', 'Jl. Kebon Jeruk No.4, Medan', '084234567893'),
('Rina Dwi', 'Jl. Pasar No.5, Yogyakarta', '085234567894'),
('Hendra Juna', 'Jl. Raya No.6, Bali', '086234567895'),
('Toni Kerkasa', 'Jl. Merpati No.7, Solo', '087234567896'),
('Farhan Alim', 'Jl. Anggrek No.8, Makassar', '088234567897'),
('Lina Maya', 'Jl. Kenangan No.9, Malang', '089234567898'),
('Ari Yahya', 'Jl. Suka No.10, Semarang', '090234567899');

CREATE TABLE pembeli (
    id_pembeli INT PRIMARY KEY AUTO_INCREMENT,
    nama_pembeli VARCHAR(100),
    alamat TEXT,
    no_hp VARCHAR(20)
);

-- Insert data into pembeli
INSERT INTO pembeli (nama_pembeli, alamat, no_hp) VALUES
('Melati', 'Jl. Bambu No.11, Jakarta', '091234567800'),
('Aaliyah', 'Jl. Suka No.12, Bandung', '092234567801'),
('Citra', 'Jl. Mawar No.13, Surabaya', '093234567802'),
('Dono', 'Jl. Sinar No.14, Medan', '094234567803'),
('Eka', 'Jl. Bunga No.15, Yogyakarta', '095234567804'),
('Fani', 'Jl. Pantai No.16, Bali', '096234567805'),
('Fina', 'Jl. Taman No.17, Solo', '097234567806'),
('Hendra', 'Jl. Hijau No.18, Makassar', '098234567807'),
('Indra', 'Jl. Raya No.19, Malang', '099234567808'),
('Joko', 'Jl. Kemenangan No.20, Semarang', '100234567809');

INSERT INTO pembeli (nama_pembeli, alamat, no_hp) VALUES
('Rahmawati', 'Jl. Bambu No.11, Jakarta', '091111111101'),
('Zaki Maulana', 'Jl. Bambu No.11, Jakarta', '091111111102'),
('Syifa Nabila', 'Jl. Bambu No.11, Jakarta', '091111111103'),
('Ridho Saputra', 'Jl. Bambu No.11, Jakarta', '091111111104'),
('Nadia Putri', 'Jl. Bambu No.11, Jakarta', '091111111105');

SELECT * FROM pembeli WHERE alamat = 'Jl. Bambu No.11, Jakarta';


CREATE TABLE kandang (
    id_kandang INT PRIMARY KEY AUTO_INCREMENT,
    nama_kandang VARCHAR(100),
    lokasi VARCHAR(100),
    kapasitas INT,
    id_peternak INT,
    FOREIGN KEY (id_peternak) REFERENCES peternak(id_peternak)
);

-- Insert data into kandang
INSERT INTO kandang (nama_kandang, lokasi, kapasitas, id_peternak) VALUES
('Kandang Postal', 'Jakarta', 100, 1),
('Kandang Panggung', 'Jakarta', 150, 2),
('Kandang Boks', 'Jakarta', 120, 3),
('Kandang Baterai', 'Bandung', 80, 4),
('Kandang Ren', 'Bandung', 200, 5),
('Kandang Ren', 'Surabaya', 90, 6),
('Kandang Ren', 'Surabaya', 130, 7),
('Kandang Postal', 'Yogyakarta', 110, 8),
('Kandang Postal', 'Yogyakarta', 140, 9),
('Kandang Boks', 'Bali', 160, 10);

CREATE TABLE bebek (
    id_bebek INT PRIMARY KEY AUTO_INCREMENT,
    kode_bebek VARCHAR(50),
    jenis_bebek VARCHAR(50),
    id_kandang INT,
    FOREIGN KEY (id_kandang) REFERENCES kandang(id_kandang)
);

-- Insert data into bebek
INSERT INTO bebek (kode_bebek, jenis_bebek, id_kandang) VALUES
('B001', 'Bebek Pedaging', 1),
('B002', 'Bebek Petelur', 2),
('B003', 'Bebek Pedaging', 3),
('B004', 'Bebek Petelur', 4),
('B005', 'Bebek Pedaging', 5),
('B006', 'Bebek Petelur', 6),
('B007', 'Bebek Pedaging', 7),
('B008', 'Bebek Petelur', 8),
('B009', 'Bebek Pedaging', 9),
('B010', 'Bebek Petelur', 10);

-- tabel transaksi
CREATE TABLE pakan_harian (
    id_pakan INT PRIMARY KEY AUTO_INCREMENT,
    tanggal DATE,
    jenis_pakan VARCHAR(100),
    jumlah_pakan FLOAT, -- dalam kilogram
    id_kandang INT,
    FOREIGN KEY (id_kandang) REFERENCES kandang(id_kandang)
);

-- Insert data into pakan_harian
INSERT INTO pakan_harian (tanggal, jenis_pakan, jumlah_pakan, id_kandang) VALUES
('2025-02-01', 'Jagung', 50, 1), 
('2025-04-12', 'Dedak Padi', 70, 2),  
('2025-03-10', 'Jagung', 60, 3),  
('2025-04-04', 'Kedelai', 40, 4),  
('2025-02-13', 'Dedak Padi', 80, 5), 
('2025-05-06', 'Jagung', 55, 6), 
('2025-10-07', 'Kedelai', 65, 7),  
('2025-09-08', 'Dedak Padi', 75, 8),  
('2025-07-09', 'Jagung', 50, 9),  
('2025-08-10', 'Kedelai', 85, 10); 

CREATE TABLE produksi_telur (
    id_produksi INT PRIMARY KEY AUTO_INCREMENT,
    tanggal_produksi_telur DATE,
    jumlah_telur INT,
    id_kandang INT,
    FOREIGN KEY (id_kandang) REFERENCES kandang(id_kandang)
);

-- Insert data into produksi_telur
INSERT INTO produksi_telur (tanggal_produksi_telur, jumlah_telur, id_kandang) VALUES
('2025-02-13', 200, 1),
('2025-04-20', 250, 2),
('2025-03-17', 180, 3),
('2025-06-04', 220, 4),
('2025-07-05', 300, 5),
('2025-08-06', 240, 6),
('2025-09-07', 280, 7),
('2025-05-08', 260, 8),
('2025-08-09', 220, 9),
('2025-09-10', 310, 10);

CREATE TABLE detail_pembelian (
    id_pembelian INT PRIMARY KEY AUTO_INCREMENT,
    tanggal DATE,
    jumlah_telur INT,
    harga_satuan DECIMAL(10,2),
    total_harga DECIMAL(10,2),
    id_pembeli INT,
    id_produksi INT,
    FOREIGN KEY (id_pembeli) REFERENCES pembeli(id_pembeli),
    FOREIGN KEY (id_produksi) REFERENCES produksi_telur(id_produksi)
);

-- Insert data into detail_pembelian
INSERT INTO detail_pembelian (tanggal, jumlah_telur, harga_satuan, total_harga, id_pembeli, id_produksi) VALUES
('2025-09-01', 50, 1500, 75000, 1, 1),
('2025-04-02', 60, 1450, 87000, 2, 2),
('2025-02-03', 40, 1400, 56000, 3, 3),
('2025-08-04', 70, 1600, 112000, 4, 4),
('2025-06-05', 80, 1550, 124000, 5, 5),
('2025-10-06', 50, 1500, 75000, 6, 6),
('2025-07-07', 90, 1600, 144000, 7, 7),
('2025-03-08', 60, 1450, 87000, 8, 8),
('2025-02-09', 50, 1500, 75000, 9, 9),
('2025-08-10', 100, 1400, 140000, 10, 10);



SELECT * FROM peternak;
SELECT * FROM kandang;
SELECT * FROM bebek;
SELECT * FROM produksi_telur;
SELECT * FROM pakan_harian;
SELECT * FROM pembeli;

RENAME TABLE bebek TO data_bebek;
SHOW TABLES;
-- DROP DATABASE peternakan_bebek;