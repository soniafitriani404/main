
CREATE DATABASE aksesoris_cewek;
USE aksesoris cewek;

-- Tabel Master

-- 1. Tabel Kategori
CREATE TABLE tbl_kategori (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL
);


INSERT INTO tbl_kategori (nama_kategori) VALUES
('Cincin'),
('Kalung'),
('Gelang');



-- 2. Tabel Produk
CREATE TABLE tbl_produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    nama_produk VARCHAR(150) NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    stok INT NOT NULL,
    id_kategori INT,
    FOREIGN KEY (id_kategori) REFERENCES tbl_kategori(id_kategori) ON DELETE SET NULL
);

INSERT INTO tbl_produk (nama_produk, harga, stok, id_kategori) VALUES
('Cincin Perak', 50000, 10, 1),
('Kalung Emas', 250000, 5, 2),
('Gelang Mutiara', 100000, 7, 3);


-- 3. Tabel Pelanggan
CREATE TABLE tbl_pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama_pelanggan VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    alamat TEXT NOT NULL
);

INSERT INTO tbl_pelanggan (nama_pelanggan, email, alamat) VALUES
('Siti Aisyah', 'siti@gmail.com', 'Jakarta'),
('Rina Putri', 'rina@gmail.com', 'Surabaya');

-- Tabel Transaksi

-- 4. Tabel Transaksi
CREATE TABLE tbl_transaksi (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT,
    tanggal_transaksi DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_harga DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pelanggan) REFERENCES tbl_pelanggan(id_pelanggan) ON DELETE CASCADE
);

INSERT INTO tbl_transaksi (id_pelanggan, tanggal_transaksi, total_harga) VALUES
(1, '2025-03-30', 300000),
(2, '2025-03-29', 100000);


-- 5. Tabel Detail Transaksi
CREATE TABLE tbl_detail_transaksi (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_transaksi INT,
    id_produk INT,
    jumlah INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_transaksi) REFERENCES tbl_transaksi(id_transaksi) ON DELETE CASCADE,
    FOREIGN KEY (id_produk) REFERENCES tbl_produk(id_produk) ON DELETE CASCADE
);

INSERT INTO tbl_detail_transaksi (id_transaksi, id_produk, jumlah, subtotal) VALUES
(1, 1, 1, 50000),      -- Siti beli 1x Cincin Perak
(1, 2, 1, 250000),     -- Siti beli 1x Kalung Emas
(2, 3, 1, 100000);     -- Rina beli 1x Gelang Mutiara


SELECT * FROM tbl_transaksi;
SELECT * FROM tbl_kategori;
SELECT * FROM tbl_detail_transaksi;
SELECT * FROM tbl_pelanggan;
SELECT * FROM tbl_produk;



CREATE DATABASE UMKM;
DROP DATABASE umkm;

USE UMKM;

CREATE TABLE kategori_umkm (
    id_kategori INT(11) PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(100) NOT NULL,
    deskripsi TEXT
);

INSERT INTO kategori_umkm (id_kategori, nama_kategori, deskripsi) VALUES
(1, 'Kuliner', 'Usaha yang bergerak di bidang makanan dan minuman'),
(2, 'Fesyen', 'Usaha yang bergerak di bidang pakaian, aksesoris, dan produk fashion lainnya'),
(3, 'Kerajinan', 'Usaha yang bergerak di bidang pembuatan produk kerajinan tangan'),
(4, 'Pertanian', 'Usaha yang bergerak di bidang pertanian, perkebunan, dan pengolahan hasil pertanian'),
(5, 'Peternakan', 'Usaha yang bergerak di bidang peternakan dan pengolahan hasil peternakan'),
(6, 'Perikanan', 'Usaha yang bergerak di bidang perikanan dan pengolahan hasil perikanan'),
(7, 'Jasa', 'Usaha yang bergerak di bidang pelayanan jasa'),
(8, 'Perdagangan', 'Usaha yang bergerak di bidang perdagangan barang'),
(9, 'Manufaktur', 'Usaha yang bergerak di bidang pembuatan produk'),
(10, 'Teknologi', 'Usaha yang bergerak di bidang teknologi informasi'),
(11, 'Pariwisata', 'Usaha yang bergerak di bidang pariwisata dan hospitality'),
(12, 'Ekonomi Kreatif', 'Usaha yang bergerak di bidang ekonomi kreatif seperti desain, seni, dll'),
(13, 'Transportasi', 'Usaha yang bergerak di bidang jasa angkutan darat, laut, dan udara'),
(14, 'Kesehatan', 'Usaha yang bergerak di bidang pelayanan kesehatan dan alat kesehatan'),
(15, 'Pendidikan', 'Usaha yang bergerak di bidang pendidikan dan pelatihan');


CREATE TABLE skala_umkm (
    id_skala INT(11) PRIMARY KEY AUTO_INCREMENT,
    nama_skala VARCHAR(5) NOT NULL,
    batas_aset_bawah DECIMAL(15,2),
    batas_aset_atas DECIMAL(15,2),
    batas_omzet_bawah DECIMAL(15,2),
    batas_omzet_atas DECIMAL(15,2)
);

INSERT INTO skala_umkm (id_skala,nama_skala, batas_aset_bawah, batas_aset_atas, batas_omzet_bawah, batas_omzet_atas) VALUES
(111,'Mikro', 0, 50000000, 0, 300000000),
(112,'Kecil', 50000000, 500000000, 300000000, 2500000000),
(113,'Menengah', 500000000, 10000000000, 2500000000, 50000000000);



CREATE TABLE kabupaten_kota (
    id_kabupaten_kota INT(11) PRIMARY KEY AUTO_INCREMENT,
    nama_kabupaten_kota VARCHAR(100) NOT NULL
);

INSERT INTO kabupaten_kota (id_kabupaten_kota,nama_kabupaten_kota) VALUES
(221,'Kota Bandung'),
(222,'Kota Bekasi'),
(223,'Kota Bogor'),
(224,'Kota Cimahi'),
(225,'Kota Cirebon'),
(226,'Kota Depok'),
(227,'Kota Sukabumi'),
(228,'Kota Tasikmalaya'),
(229,'Kota Banjar'),
(230,'Kabupaten Bandung'),
(231,'Kabupaten Bandung Barat'),
(232,'Kabupaten Bekasi'),
(233,'Kabupaten Bogor'),
(234,'Kabupaten Ciamis'),
(235,'Kabupaten Cianjur');

CREATE TABLE pemilik_umkm (
    id_pemilik INT(11) PRIMARY KEY AUTO_INCREMENT,
    nik VARCHAR(16) NOT NULL UNIQUE,
    nama_lengkap VARCHAR(200) NOT NULL,
    jenis_kelamin ENUM('Laki-laki', 'Perempuan') NOT NULL,
    alamat TEXT,
    nomor_telepon VARCHAR(15),
    email VARCHAR(100)
);

INSERT INTO pemilik_umkm (id_pemilik,nik, nama_lengkap, jenis_kelamin, alamat, nomor_telepon, email) VALUES
(441,'3273012505780001', 'Ahmad Sudrajat', 'Laki-laki', 'Jl. Pahlawan No. 123, Bandung', '081234567890', 'ahmad.sudrajat@gmail.com'),
(442,'3217016004850002', 'Siti Rahayu', 'Perempuan', 'Jl. Merdeka No. 45, Bekasi', '085678901234', 'siti.rahayu@gmail.com'),
(443,'3273025601900003', 'Budi Santoso', 'Laki-laki', 'Jl. Sukajadi No. 78, Bandung', '081345678901', 'budi.santoso@gmail.com'),
(444,'3271046502870004', 'Dewi Lestari', 'Perempuan', 'Jl. Veteran No. 56, Bogor', '087890123456', 'dewi.lestari@gmail.com'),
(445,'3275021203830005', 'Joko Widodo', 'Laki-laki', 'Jl. Cendana No. 34, Bekasi', '089012345678', 'joko.widodo@gmail.com'),
(446,'3277054408920006', 'Rina Anggraini', 'Perempuan', 'Jl. Kemuning No. 67, Cimahi', '082345678901', 'rina.anggraini@gmail.com'),
(447,'3210015509870007', 'Agus Hermawan', 'Laki-laki', 'Jl. Teratai No. 89, Bandung', '081456789012', 'agus.hermawan@gmail.com'),
(448,'3215026302860008', 'Ani Yudhoyono', 'Perempuan', 'Jl. Cikutra No. 23, Garut', '083567890123', 'ani.yudhoyono@gmail.com'),
(449,'3601014507830009', 'Hendra Wijaya', 'Laki-laki', 'Jl. Sudirman No. 56, Cianjur', '085678901234', 'hendra.wijaya@gmail.com'),
(450,'3216028308910010', 'Maya Sari', 'Perempuan', 'Jl. Gatot Subroto No. 78, Cirebon', '087890123456', 'maya.sari@gmail.com'),
(451,'3214013011820011', 'Rudi Hartono', 'Laki-laki', 'Jl. Setiabudi No. 90, Kuningan', '089012345678', 'rudi.hartono@gmail.com'),
(452,'3279027105860012', 'Lina Marlina', 'Perempuan', 'Jl. Pasteur No. 45, Majalengka', '081234567890', 'lina.marlina@gmail.com'),
(453,'3278011708840013', 'Dedi Kurniawan', 'Laki-laki', 'Jl. Ciganitri No. 67, Purwakarta', '085678901234', 'dedi.kurniawan@gmail.com'),
(454,'3215023004900014', 'Tuti Winarti', 'Perempuan', 'Jl. Cibaduyut No. 23, Sumedang', '081345678901', 'tuti.winarti@gmail.com'),
(455,'3211014406870015', 'Eko Susanto', 'Laki-laki', 'Jl. Anggrek No. 76, Tasikmalaya', '087890123456', 'eko.susanto@gmail.com');

CREATE TABLE umkm (
    id_umkm INT(11) PRIMARY KEY AUTO_INCREMENT,
    nama_usaha VARCHAR(200) NOT NULL,
    id_pemilik INT(11),
    id_kategori INT(11),
    id_skala INT(11),
    id_kabupaten_kota INT(11),
    alamat_usaha TEXT,
    nib VARCHAR(50),
    npwp VARCHAR(20),
    tahun_berdiri YEAR(4),
    jumlah_karyawan INT(11),
    total_aset DECIMAL(15,2),
    omzet_per_tahun DECIMAL(15,2),
    deskripsi_usaha TEXT,
    tanggal_registrasi DATE,
    FOREIGN KEY (id_pemilik) REFERENCES pemilik_umkm(id_pemilik),
    FOREIGN KEY (id_kategori) REFERENCES kategori_umkm(id_kategori),
    FOREIGN KEY (id_skala) REFERENCES skala_umkm(id_skala),
    FOREIGN KEY (id_kabupaten_kota) REFERENCES kabupaten_kota(id_kabupaten_kota)
);

INSERT INTO umkm (id_umkm,nama_usaha, id_pemilik, id_kategori, id_skala, id_kabupaten_kota, alamat_usaha, nib, npwp, tahun_berdiri, jumlah_karyawan, total_aset, omzet_per_tahun, deskripsi_usaha, tanggal_registrasi) VALUES
(661,'Warung Sambel Hejo', 441, 1, 111, 221, 'Jl. Pahlawan No. 123, Bandung', '9120001234567', '09.876.543.2-123.000', 2018, 3, 35000000, 250000000, 'Warung makan spesialis sambel khas Sunda dengan aneka lauk', '2022-03-15'),
(662,'Butik Batik Pesona', 442, 2, 112, 222, 'Jl. Merdeka No. 45, Bekasi', '9120001234568', '09.876.543.2-123.001', 2015, 7, 320000000, 1200000000, 'Butik batik dengan motif khas Jawa Barat', '2021-07-20'),
(663,'Kerajinan Anyaman Rahayu', 443, 3, 113, 223, 'Jl. Sukajadi No. 78, Bandung', '9120001234569', '09.876.543.2-123.002', 2019, 5, 45000000, 280000000, 'Produk kerajinan anyaman bambu dan rotan', '2022-01-10'),
(664,'Taman Buah Sejahtera', 444, 4, 111, 224, 'Jl. Veteran No. 56, Bogor', '9120001234570', '09.876.543.2-123.003', 2014, 10, 450000000, 2000000000, 'Pertanian buah-buahan lokal dan jeruk impor', '2020-11-05'),
(665,'Ternak Ayam Makmur', 445, 5, 112, 225, 'Jl. Cendana No. 34, Bekasi', '9120001234571', '09.876.543.2-123.004', 2020, 4, 48000000, 275000000, 'Peternakan ayam dan pengolahan telur', '2022-02-28'),
(666,'Budidaya Ikan Barokah', 446, 6, 113, 226, 'Jl. Kemuning No. 67, Cimahi', '9120001234572', '09.876.543.2-123.005', 2017, 8, 380000000, 1800000000, 'Budidaya ikan air tawar dan olahan ikan', '2021-04-12'),
(667,'Bengkel Las Abadi', 447, 7, 111, 227, 'Jl. Teratai No. 89, Bandung', '9120001234573', '09.876.543.2-123.006', 2016, 6, 49000000, 290000000, 'Jasa pengelasan dan pembuatan pagar', '2022-05-17'),
(668,'Toko Sembako Barokah', 448, 8, 112, 228, 'Jl. Cikutra No. 23, Garut', '9120001234574', '09.876.543.2-123.007', 2013, 5, 420000000, 2300000000, 'Perdagangan sembako dan kebutuhan rumah tangga', '2020-08-23'),
(669,'Furniture Kayu Jati', 449, 9, 113, 229, 'Jl. Sudirman No. 56, Cianjur', '9120001234575', '09.876.543.2-123.008', 2012, 20, 2500000000, 15000000000, 'Produksi furniture kayu jati untuk ekspor', '2020-03-10'),
(670,'Digital Solution', 450, 10, 112, 230, 'Jl. Gatot Subroto No. 78, Cirebon', '9120001234576', '09.876.543.2-123.009', 2018, 12, 480000000, 2200000000, 'Pengembangan aplikasi dan website', '2021-09-15'),
(671,'Homestay Panorama', 451,11, 113, 231, 'Jl. Setiabudi No. 90, Kuningan', '9120001234577', '09.876.543.2-123.010', 2019, 4, 47000000, 270000000, 'Penyedia akomodasi homestay di daerah wisata', '2022-04-21'),
(672,'Studio Desain Kreatif', 452, 12, 111, 232, 'Jl. Pasteur No. 45, Majalengka', '9120001234578', '09.876.543.2-123.011', 2016, 8, 350000000, 1900000000, 'Jasa desain grafis dan branding', '2021-05-17'),
(673,'Oleh-oleh Khas Sunda', 453, 13, 112, 233, 'Jl. Ciganitri No. 67, Purwakarta', '9120001234579', '09.876.543.2-123.012', 2015, 9, 370000000, 2100000000, 'Makanan oleh-oleh khas Sunda Buhun', '2020-10-30'),
(674,'Rajutan Cantik', 454, 14, 113, 234, 'Jl. Cibaduyut No. 23, Sumedang', '9120001234580', '09.876.543.2-123.013', 2020, 3, 40000000, 260000000, 'Produk rajutan handmade berkualitas', '2022-02-14'),
(675,'Perkebunan Kopi Gunung', 455, 15, 111, 235, 'Jl. Anggrek No. 76, Tasikmalaya', '9120001234581', '09.876.543.2-123.014', 2010, 25, 3500000000, 20000000000, 'Perkebunan dan pengolahan kopi premium', '2020-01-05');

CREATE TABLE produk_umkm (
    id_produk INT(11) PRIMARY KEY AUTO_INCREMENT,
    id_umkm INT(11),
    nama_produk VARCHAR(200) NOT NULL,
    deskripsi_produk TEXT,
    harga DECIMAL(15,2),
    FOREIGN KEY (id_umkm) REFERENCES umkm(id_umkm)
);

INSERT INTO produk_umkm (id_umkm, nama_produk, deskripsi_produk, harga) VALUES
(661, 'Sambel Hejo Level 1', 'Sambel hejo dengan tingkat kepedasan rendah', 15000),
(662, 'Sambel Hejo Level 3', 'Sambel hejo dengan tingkat kepedasan sedang', 17000),
(663, 'Sambel Hejo Level 5', 'Sambel hejo dengan tingkat kepedasan tinggi', 20000),
(664, 'Ayam Goreng Sambel Hejo', 'Paket nasi dengan ayam goreng dan sambel hejo', 25000),
(665, 'Batik Tulis Mega Mendung', 'Batik tulis motif mega mendung khas Cirebon', 750000),
(666, 'Batik Cap Kujang', 'Batik cap dengan motif kujang', 350000),
(667, 'Kemeja Batik Pria', 'Kemeja batik pria lengan panjang', 275000),
(668, 'Dress Batik Modern', 'Dress batik modern untuk wanita', 325000),
(669, 'Keranjang Anyaman Bambu', 'Keranjang anyaman bambu multi fungsi', 85000),
(670, 'Topi Anyaman Bambu', 'Topi anyaman bambu untuk bertani', 45000),
(671, 'Vas Bunga Rotan', 'Vas bunga dari rotan dengan desain klasik', 120000),
(672, 'Jeruk Keprok 1 kg', 'Jeruk keprok segar langsung dari kebun', 30000),
(673, 'Mangga Gedong Gincu 1 kg', 'Mangga gedong gincu khas Indramayu', 45000),
(674, 'Telur Ayam Kampung 1 kg', 'Telur ayam kampung organik', 60000),
(675, 'Ayam Potong Segar 1 ekor', 'Ayam potong segar', 75000);


SELECT * FROM kabupaten_kota;
SELECT * FROM kategori_umkm;
SELECT * FROM pemilik_umkm;
SELECT * FROM produk_umkm;
SELECT * FROM skala_umkm;
SELECT * FROM umkm;
DESCRIBE pemilik_umkm;
ALTER TABLE pemilik_umkm ADD COLUMN nama_lengkap VARCHAR(200);
SELECT id_pemilik, nama_lengkap FROM pemilik_umkm;
SHOW COLUMNS FROM pemilik_umkm;





DROP VIEW IF EXISTS view_umkm_detail;

CREATE OR REPLACE VIEW view_umkm_detail AS
SELECT 
    umkm.nama_usaha,
    pemilik_umkm.nama_lengkap,
    kategori_umkm.nama_kategori,
    skala_umkm.nama_skala,
    kabupaten_kota.nama_kabupaten_kota,
    umkm.tahun_berdiri
FROM umkm
JOIN kategori_umkm ON umkm.id_kategori = kategori_umkm.id_kategori
JOIN skala_umkm ON umkm.id_skala = skala_umkm.id_skala
JOIN kabupaten_kota ON umkm.id_kabupaten_kota = kabupaten_kota.id_kabupaten_kota
JOIN pemilik_umkm ON umkm.id_pemilik = pemilik_umkm.id_pemilik;


CREATE OR REPLACE VIEW view_pemilik_dan_usaha AS
SELECT 
    pemilik_umkm.nik,
    pemilik_umkm.nama_lengkap,
    pemilik_umkm.jenis_kelamin,
    pemilik_umkm.email,
    umkm.nama_usaha
FROM 
    pemilik_umkm
JOIN 
    umkm ON pemilik_umkm.id_pemilik = umkm.id_pemilik;



CREATE OR REPLACE VIEW view_produk_umkm AS
SELECT 
    umkm.nama_usaha,
    produk_umkm.nama_produk,
    produk_umkm.deskripsi_produk,
    produk_umkm.harga
FROM 
    produk_umkm
JOIN 
    umkm ON produk_umkm.id_umkm = umkm.id_umkm;
    
    
 
 CREATE OR REPLACE VIEW view_umkm_menengah AS
SELECT 
    umkm.nama_usaha, 
    pemilik_umkm.nama_lengkap AS nama_pemilik, 
    umkm.total_aset, 
    umkm.omzet_per_tahun
FROM umkm
JOIN pemilik_umkm ON umkm.id_pemilik = pemilik_umkm.id_pemilik
JOIN skala_umkm ON umkm.id_skala = skala_umkm.id_skala
WHERE skala_umkm.nama_skala = 'Menengah';





