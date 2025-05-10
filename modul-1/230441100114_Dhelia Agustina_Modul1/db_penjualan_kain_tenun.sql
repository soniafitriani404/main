CREATE DATABASE db_penjualan_kain_tenun;

USE db_penjualan_kain_tenun;

CREATE TABLE tbl_Pelanggan(
	id_pelanggan INT PRIMARY KEY,
	nama VARCHAR(50) NOT NULL,
	alamat VARCHAR(100),
	no_telepon VARCHAR(20)
);

INSERT INTO tbl_Pelanggan VALUES (101, 'Ibu Sari', 'Jl. Kenanga No.10', '081234567890')
INSERT INTO tbl_Pelanggan VALUES(102, 'Bapak Ahmad', 'Jl. Melati No.5', '085612345678')
INSERT INTO tbl_Pelanggan VALUES(103, 'Bu Rina', 'Jl. Mawar No.3', '089876543210')

SELECT * FROM tbl_Pelanggan;


CREATE TABLE tbl_ProdukKain(
	id_kain INT PRIMARY KEY,
	nama_kain VARCHAR(50),
	harga int,
	stok INT
);

INSERT INTO tbl_ProdukKain VALUES (201, 'Tenun Ikat Sumba', 250000, 10)
INSERT INTO tbl_ProdukKain VALUES (202, 'Tenun Troso', 300000, 5)
INSERT INTO tbl_ProdukKain VALUES (203, 'Tenun Endek Bali', 200000, 15)

SELECT * FROM tbl_ProdukKain;

CREATE TABLE tbl_Pegawai(
	id_pegawai INT PRIMARY KEY,
	nama_pegawai VARCHAR(50),
	jabatan VARCHAR(50)
);

INSERT INTO tbl_Pegawai VALUES (301, 'Dewi Lestari', 'Kasir')
INSERT INTO tbl_Pegawai VALUES (302, 'Rudi Hartono', 'Admin')
INSERT INTO tbl_Pegawai VALUES (303, 'Ayu Pratiwi', 'Sales')

SELECT * FROM tbl_Pegawai;

CREATE TABLE tbl_Penjualan(
	id_penjualan INT PRIMARY KEY,
	id_pelanggan INT UNIQUE not null,
	id_pegawai INT UNIQUE not null,
	tanggal DATE,
	total int
);

INSERT INTO tbl_Penjualan VALUES (401, 101, 301, '2025-04-01', 500000)
INSERT INTO tbl_Penjualan VALUES (402, 102, 302, '2025-04-02', 300000)

SELECT * FROM tbl_Penjualan;

CREATE TABLE tbl_DetailPenjualan(
	id_detail INT PRIMARY KEY,
	id_penjualan INT UNIQUE not null,
	id_kain INT UNIQUE not null,
	jumlah INT,
	subtotal int
);

INSERT INTO tbl_DetailPenjualan VALUES (501, 401, 201, 2, 500000.00)
INSERT INTO tbl_DetailPenjualan VALUES (502, 402, 203, 1, 200000.00)

SELECT * FROM tbl_DetailPenjualan;



