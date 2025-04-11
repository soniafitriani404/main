CREATE DATABASE stok_penjualan; -- Membuat database

USE stok_penjualan; -- Menggunakan database yang dibuat

-- Membuat tabel Master(produk, pelanggan, karyawan)
CREATE TABLE Produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    nama_produk VARCHAR(100) NOT NULL,
    kategori VARCHAR(50),
    harga DECIMAL(10,2) NOT NULL,
    stok INT NOT NULL
);

CREATE TABLE Pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama_pelanggan VARCHAR(100) NOT NULL,
    alamat VARCHAR(255),
    no_telp VARCHAR(15)
);

CREATE TABLE Karyawan (
    id_karyawan INT AUTO_INCREMENT PRIMARY KEY,
    nama_karyawan VARCHAR(100) NOT NULL,
    posisi VARCHAR(50),
    no_telp VARCHAR(15)
);

-- Membuat tabel Transaksi (penjualan, detail Penjualan)
CREATE TABLE Penjualan (
    id_penjualan INT AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT,
    id_karyawan INT,
    tanggal DATE NOT NULL,
    total DECIMAL(10,2),
    FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan),
    FOREIGN KEY (id_karyawan) REFERENCES Karyawan(id_karyawan)
);

CREATE TABLE DetailPenjualan (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_penjualan INT,
    id_produk INT,
    jumlah INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_penjualan) REFERENCES Penjualan(id_penjualan),
    FOREIGN KEY (id_produk) REFERENCES Produk(id_produk)
);

SHOW TABLES; -- Menampilkan tabel yang sudah dibuat