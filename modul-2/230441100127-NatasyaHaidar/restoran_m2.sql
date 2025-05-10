-- Membuat database
CREATE DATABASE restoran_m2;
USE restoran_m2;

-- Membuat tabel Menu (Master)
CREATE TABLE Menu (
    id_menu INT AUTO_INCREMENT PRIMARY KEY,
    nama_menu VARCHAR(100) NOT NULL,
    kategori ENUM('Makanan', 'Minuman') NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    stok INT NOT NULL,
    deskripsi TEXT
);

-- Membuat tabel Pelanggan (Master)
CREATE TABLE Pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    no_hp VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    alamat TEXT
);

-- Membuat tabel Karyawan (Master)
CREATE TABLE Karyawan (
    id_karyawan INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    jabatan ENUM('Kasir', 'Pelayan', 'Koki') NOT NULL,
    no_hp VARCHAR(15) UNIQUE NOT NULL
);

-- Membuat tabel Pesanan (Transaksi)
CREATE TABLE Pesanan (
    id_pesanan INT AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT NOT NULL,
    id_karyawan INT, -- dibuat NULLABLE karena pakai ON DELETE SET NULL
    tanggal DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_harga DECIMAL(10,2) NOT NULL,
    STATUS ENUM('Belum Dibayar', 'Lunas') DEFAULT 'Belum Dibayar',
    FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan) ON DELETE CASCADE,
    FOREIGN KEY (id_karyawan) REFERENCES Karyawan(id_karyawan) ON DELETE SET NULL
);


-- Membuat tabel Detail_Pesanan (Transaksi)
CREATE TABLE Detail_Pesanan (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_pesanan INT NOT NULL,
    id_menu INT NOT NULL,
    jumlah INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pesanan) REFERENCES Pesanan(id_pesanan) ON DELETE CASCADE,
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu) ON DELETE CASCADE
);

INSERT INTO Menu (nama_menu, kategori, harga, stok, deskripsi) VALUES
('Nasi Goreng Spesial', 'Makanan', 25000, 20, 'Nasi goreng dengan ayam, telur, dan sayuran'),
('Mie Ayam', 'Makanan', 18000, 15, 'Mie dengan potongan ayam dan sawi'),
('Es Teh Manis', 'Minuman', 5000, 30, 'Teh manis dengan es batu'),
('Jus Alpukat', 'Minuman', 12000, 10, 'Jus alpukat segar dengan susu coklat'),
('Sate Ayam', 'Makanan', 20000, 12, 'Sate ayam dengan bumbu kacang');

INSERT INTO Pelanggan (nama, no_hp, email, alamat) VALUES
('Refalino Oktavio', '081234567890', 'lino@gmail.com', 'Jl. Merdeka No.10'),
('Natasya Haidar', '081298765432', 'nat@yahoo.com', 'Jl. Melati No.5'),
('Aisya Putri', '081345678901', 'Aisya@gmail.com', 'Jl. Anggrek No.22');

INSERT INTO Karyawan (nama, jabatan, no_hp) VALUES
('Dewi Aminah', 'Kasir', '081212121212'),
('Dedi Hermawan', 'Pelayan', '081313131313'),
('Rosa Lestari', 'Koki', '081414141414');

INSERT INTO Pesanan (id_pelanggan, id_karyawan, total_harga, STATUS) VALUES
(1, 1, 55000, 'Lunas'),
(2, 3, 18000, 'Belum Dibayar'),
(3, 2, 32000, 'Lunas');

INSERT INTO Detail_Pesanan (id_pesanan, id_menu, jumlah, subtotal) VALUES
(1, 1, 2, 50000),
(1, 3, 1, 5000),
(2, 2, 1, 18000),
(3, 4, 2, 24000),
(3, 5, 1, 8000);

SELECT * FROM menu;
SELECT * FROM pelanggan;
SELECT * FROM pesanan;
SELECT * FROM karyawan;
SELECT * FROM detail_pesanan;

-- View ini menampilkan data pesanan lengkap dengan informasi pelanggan
CREATE VIEW view_pesanan_pelanggan AS
SELECT 
    p.id_pesanan,
    pel.nama AS nama_pelanggan,
    p.tanggal,
    p.total_harga,
    p.status
FROM Pesanan p
JOIN Pelanggan pel ON p.id_pelanggan = pel.id_pelanggan;

-- View ini memberikan detail lengkap pesanan
CREATE VIEW view_detail_pesanan_lengkap AS
SELECT 
    p.id_pesanan,
    pel.nama AS nama_pelanggan,
    m.nama_menu,
    dp.jumlah,
    dp.subtotal,
    p.status,
    p.tanggal
FROM Pesanan p
JOIN Pelanggan pel ON p.id_pelanggan = pel.id_pelanggan
JOIN Detail_Pesanan dp ON p.id_pesanan = dp.id_pesanan
JOIN Menu m ON dp.id_menu = m.id_menu;

-- View ini menyaring hanya pesanan yang belum dibayar oleh pelanggan.
CREATE VIEW view_pesanan_belum_dibayar AS
SELECT 
    p.id_pesanan,
    pel.nama AS nama_pelanggan,
    p.total_harga,
    p.tanggal
FROM Pesanan p
JOIN Pelanggan pel ON p.id_pelanggan = pel.id_pelanggan
WHERE p.status = 'Belum Dibayar';

-- View ini menghitung total pendapatan dari pelanggan yang sudah melakukan pembayaran (status Lunas).
CREATE VIEW view_total_pendapatan_per_pelanggan AS
SELECT 
    pel.nama AS nama_pelanggan,
    SUM(p.total_harga) AS total_pendapatan
FROM Pesanan p
JOIN Pelanggan pel ON p.id_pelanggan = pel.id_pelanggan
WHERE p.status = 'Lunas'
GROUP BY pel.nama;

-- View ini menampilkan daftar menu yang stoknya menipis (kurang dari 15).
CREATE VIEW view_menu_perlu_restock AS
SELECT 
    id_menu,
    nama_menu,
    kategori,
    stok,
    harga
FROM Menu
WHERE stok < 15;

SELECT * FROM view_pesanan_pelanggan;
SELECT * FROM view_detail_pesanan_lengkap;
SELECT * FROM view_pesanan_belum_dibayar;
SELECT * FROM view_total_pendapatan_per_pelanggan;
SELECT * FROM view_menu_perlu_restock;










