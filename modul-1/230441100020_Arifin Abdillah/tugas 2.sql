CREATE DATABASE toko_baju;

USE toko_baju;

CREATE TABLE Pelanggan (
	id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
	nama VARCHAR (50),
	alamat TEXT
);

CREATE TABLE Produk (
	id_produk INT AUTO_INCREMENT PRIMARY KEY,
	nama_produk VARCHAR(100),
	kategori VARCHAR(50),
	harga DECIMAL(10,2),
	stok INT
);

CREATE TABLE Pegawai (
	id_pegawai INT AUTO_INCREMENT PRIMARY KEY,
	nama VARCHAR(100),
	jabatan VARCHAR(50)
);

CREATE TABLE Penjualan (
	id_penjualan INT AUTO_INCREMENT PRIMARY KEY,
	id_pelanggan INT,
	id_pegawai INT,
	tanggal DATE,
	total_harga DECIMAL(10,2),
	FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan) ON DELETE CASCADE,
	FOREIGN KEY (id_pegawai) REFERENCES Pegawai(id_pegawai) ON DELETE SET NULL
);

CREATE TABLE Detail_Penjualan (
	id_detail INT AUTO_INCREMENT PRIMARY KEY,
	id_penjualan INT,
	id_produk INT,
	jumlah INT,
	subtotal DECIMAL(10,2),
	FOREIGN KEY (id_penjualan) REFERENCES Penjualan(id_penjualan) ON DELETE CASCADE,
	FOREIGN KEY (id_produk) REFERENCES Produk(id_produk) ON DELETE CASCADE
);

