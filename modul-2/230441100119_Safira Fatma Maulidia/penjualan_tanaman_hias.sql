CREATE DATABASE penjualan_tanaman_hias;

CREATE TABLE kategori (
    id_kategori INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(100),
    keterangan TEXT
);

CREATE TABLE tanaman (
    id_tanaman INT PRIMARY KEY AUTO_INCREMENT,
    nama_tanaman VARCHAR(100),
    jenis VARCHAR(50),
    harga DECIMAL(10,2),
    stok INT,
    deskripsi TEXT,
    id_kategori INT,
    FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategori)
);

CREATE TABLE pelanggan (
    id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
    nama_pelanggan VARCHAR(100),
    alamat TEXT,
    no_hp VARCHAR(15)
);

CREATE TABLE penjualan (
    id_penjualan INT PRIMARY KEY AUTO_INCREMENT,
    id_pelanggan INT,
    tanggal_penjualan DATE,
    total_harga DECIMAL(12,2),
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan)
);

CREATE TABLE detail_penjualan (
    id_detail INT PRIMARY KEY AUTO_INCREMENT,
    id_penjualan INT,
    id_tanaman INT,
    jumlah INT,
    subtotal DECIMAL(12,2),
    FOREIGN KEY (id_penjualan) REFERENCES penjualan(id_penjualan),
    FOREIGN KEY (id_tanaman) REFERENCES tanaman(id_tanaman)
);

INSERT INTO kategori (nama_kategori, keterangan) VALUES
('Tanaman Hias Daun', 'Tanaman yang memiliki keindahan pada daun'),
('Tanaman Bunga', 'Tanaman yang berbunga indah dan berwarna-warni'),
('Kaktus', 'Tanaman berduri dan cocok untuk daerah kering');

INSERT INTO tanaman (nama_tanaman, jenis, harga, stok, deskripsi, id_kategori) VALUES
('Monstera', 'Indoor', 120000.00, 10, 'Tanaman daun besar berlubang, cocok untuk dekorasi ruangan', 1),
('Aglaonema', 'Indoor', 90000.00, 15, 'Tanaman daun hias dengan warna menarik', 1),
('Mawar Merah', 'Outdoor', 15000.00, 30, 'Bunga mawar berwarna merah cerah', 2),
('Kaktus Mini', 'Indoor', 25000.00, 25, 'Kaktus ukuran kecil, cocok untuk meja kerja', 3),
('Lavender', 'Outdoor', 40000.00, 20, 'Tanaman berbunga wangi yang menarik lebah', 2);

INSERT INTO pelanggan (nama_pelanggan, alamat, no_hp) VALUES
('Ayu Lestari', 'Jl. Melati No. 10', '081234567890'),
('Budi Santoso', 'Jl. Kenanga No. 22', '082112345678'),
('Clara Wijaya', 'Jl. Mawar No. 7', '085267890123');

INSERT INTO penjualan (id_pelanggan, tanggal_penjualan, total_harga) VALUES
(1, '2025-04-10', 255000.00),
(2, '2025-04-11', 40000.00),
(3, '2025-04-11', 275000.00);

INSERT INTO detail_penjualan (id_penjualan, id_tanaman, jumlah, subtotal) VALUES
(1, 1, 1, 120000.00),
(1, 3, 3, 45000.00),
(1, 4, 3, 90000.00),
(2, 5, 1, 40000.00),
(3, 2, 1, 90000.00),
(3, 1, 1, 120000.00),
(3, 3, 4, 60000.00);

SELECT * FROM tanaman;
SELECT * FROM kategori;
SELECT * FROM pelanggan;
SELECT * FROM penjualan;
SELECT * FROM detail_penjualan;

#1
CREATE VIEW view_tanaman_dengan_kategori AS
SELECT 
    t.id_tanaman, t.nama_tanaman, t.jenis, t.harga,
    t.stok, k.nama_kategori, k.keterangan
FROM tanaman t
JOIN kategori k ON t.id_kategori = k.id_kategori;

#2
CREATE VIEW view_detail_penjualan_lengkap AS
SELECT 
    dp.id_detail, p.tanggal_penjualan, pl.nama_pelanggan,
    t.nama_tanaman, dp.jumlah, dp.subtotal
FROM detail_penjualan dp
JOIN penjualan p ON dp.id_penjualan = p.id_penjualan
JOIN pelanggan pl ON p.id_pelanggan = pl.id_pelanggan
JOIN tanaman t ON dp.id_tanaman = t.id_tanaman;

#3
CREATE VIEW view_tanaman_stok_rendah AS
SELECT 
    t.id_tanaman, t.nama_tanaman, t.stok,
    k.nama_kategori
FROM tanaman t
JOIN kategori k ON t.id_kategori = k.id_kategori
WHERE t.stok < 10;

#4
CREATE VIEW view_total_penjualan_per_pelanggan AS
SELECT 
    pl.id_pelanggan,
    pl.nama_pelanggan,
    COUNT(p.id_penjualan) AS jumlah_transaksi,
    SUM(p.total_harga) AS total_belanja
FROM pelanggan pl
JOIN penjualan p ON pl.id_pelanggan = p.id_pelanggan
GROUP BY pl.id_pelanggan, pl.nama_pelanggan;

#5
CREATE VIEW view_tanaman_terlaris AS
SELECT 
    t.id_tanaman,
    t.nama_tanaman,
    SUM(dp.jumlah) AS total_terjual
FROM detail_penjualan dp
JOIN tanaman t ON dp.id_tanaman = t.id_tanaman
GROUP BY t.id_tanaman, t.nama_tanaman
ORDER BY total_terjual DESC;

SELECT * FROM view_tanaman_dengan_kategori;
SELECT * FROM view_detail_penjualan_lengkap; 
SELECT * FROM view_tanaman_stok_rendah;
SELECT * FROM view_total_penjualan_per_pelanggan;
SELECT * FROM view_tanaman_terlaris;

