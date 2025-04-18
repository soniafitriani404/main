CREATE DATABASE db_UMKM;

USE db_UMKM;

CREATE TABLE pemilik_umkm (
    id_pemilik INT AUTO_INCREMENT PRIMARY KEY ,
    nik VARCHAR (16) NOT NULL,
    nama_lengkap VARCHAR (200),
    jenis_kelamin ENUM ('Laki-laki', 'Perempuan'),
    alamat TEXT,
    nomor_telepon VARCHAR (15),
    email VARCHAR (100)
);

CREATE TABLE kategori_umkm (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR (100) NOT NULL,
    deskripsi TEXT
);

CREATE TABLE skala_umkm (
    id_skala INT AUTO_INCREMENT PRIMARY KEY,
    nama_skala VARCHAR (50) NOT NULL,
    batas_aset_bawah DECIMAL (15,2), 
    batas_aset_atas DECIMAL (15,2), 
    batas_omzet_bawah DECIMAL (15,2), 
    batas_omzet_atas DECIMAL (15,2)
);

CREATE TABLE kabupaten_kota (
    id_kabupaten_kota INT AUTO_INCREMENT PRIMARY KEY,
    nama_kabupaten_kota VARCHAR(100) NOT NULL
);

CREATE TABLE UMKM (
    id_umkm INT AUTO_INCREMENT PRIMARY KEY,
    nama_usaha VARCHAR(200) NOT NULL,
    id_pemilik INT NOT NULL,
    id_kategori INT NOT NULL,
    id_skala INT NOT NULL,
    id_kabupaten_kota INT NOT NULL,
    alamat_usaha TEXT,
    nib VARCHAR(50),
    npwp VARCHAR(20),
    tahun_berdiri YEAR,
    jumlah_karyawan INT,
    total_aset DECIMAL(15,2),
    omzet_per_tahun DECIMAL(15,2),
    deskripsi_usaha TEXT,
    tanggal_registrasi DATE,
    FOREIGN KEY (id_pemilik) REFERENCES pemilik_umkm(id_pemilik) ON DELETE CASCADE,
    FOREIGN KEY (id_kategori) REFERENCES kategori_umkm(id_kategori) ON DELETE CASCADE,
    FOREIGN KEY (id_skala) REFERENCES skala_umkm(id_skala) ON DELETE CASCADE,
    FOREIGN KEY (id_kabupaten_kota) REFERENCES kabupaten_kota(id_kabupaten_kota) ON DELETE CASCADE
);
CREATE TABLE produk_umkm (
    id_produk INT PRIMARY KEY,
    id_umkm INT NOT NULL,
    nama_produk VARCHAR(200) NOT NULL,
    deskripsi_produk TEXT,
    harga DECIMAL(15,2),
    FOREIGN KEY (id_umkm) REFERENCES UMKM(id_umkm) ON DELETE CASCADE
);

-- Penggantian PRIMARY KEY karena tidak AUTO INCREMENT --
ALTER TABLE produk_umkm MODIFY COLUMN id_produk INT AUTO_INCREMENT;
SELECT * FROM produk_umkm;

-- 1. berisi nama usaha, nama pemilik, kategori UMKM, skala usaha, nama kabupaten/kota, dan tahun berdiri. --
CREATE VIEW view_umkm_detail AS 
SELECT umk.nama_usaha,      	   -- dari table umkm
	pu.nama_lengkap,    	   -- dari table pemilik_umkm
	ku.nama_kategori,   	   -- dari table kategori_umkm
	su.nama_skala,       	   -- dari table skala_umkm
	su.batas_aset_bawah,       -- dari table skala_umkm
	su.batas_aset_atas,        -- dari table skala_umkm
	su.batas_omzet_bawah,      -- dari table skala_umkm
	su.batas_omzet_atas,       -- dari table skala_umkm
	kku.nama_kabupaten_kota,   -- dari table kabupaten_kota
	umk.tahun_berdiri     	   -- dari table umkm
FROM umkm umk 
JOIN pemilik_umkm pu ON umk.id_pemilik = pu.id_pemilik
JOIN kategori_umkm ku ON umk.id_kategori = ku.id_kategori
JOIN skala_umkm su ON umk.id_skala = su.id_skala
JOIN kabupaten_kota kku ON umk.id_kabupaten_kota = kku.id_kabupaten_kota;

-- Memanggil VIEW view_umkm_detail --
SELECT * FROM view_umkm_detail;

-- 2. menampilkan NIK, nama lengkap pemilik, jenis kelamin, nomor telepon, email, serta nama usaha yang dimiliki. --
CREATE VIEW view_pemilik_dan_usaha AS
SELECT pu.nik,            	 -- dari table pemilik_umkm
	pu.nama_lengkap,     	 -- dari table pemilik_umkm
	pu.jenis_kelamin,     	 -- dari table pemilik_umkm
	pu.nomor_telepon,     	 -- dari table pemilik_umkm
	pu.email,         	 -- dari table pemilik_umkm
	umk.nama_usaha           -- dari table umkm
FROM pemilik_umkm pu
JOIN umkm umk ON pu.id_pemilik = umk.id_pemilik;

-- Memanggil VIEW view_pemilik_dan_usaha --
SELECT * FROM view_pemilik_dan_usaha;

-- 3. menampilkan nama usaha, nama produk, deskripsi produk, dan harga. --
CREATE VIEW view_produk_umkm AS
SELECT umk.nama_usaha,            -- dari table umkm
	pku.nama_produk,     	  -- dari table produk_umkm
	pku.deskripsi_produk,     -- dari table produk_umkm
	pku.harga        	  -- dari table produk_umkm
FROM produk_umkm pku
JOIN umkm umk ON pku.id_umkm = umk.id_umkm;

-- Memanggil VIEW view_pemilik_dan_usaha --
SELECT * FROM view_produk_umkm;

-- 4. menampilkan daftar UMKM dengan skala usaha Menengah, beserta informasi nama usaha, nama pemilik, total aset, dan omzet per tahun. --
CREATE VIEW view_umkm_menengah AS
SELECT umk.nama_usaha, 		-- dari table umkm
	pu.nama_lengkap,	-- dari table pemilik_umkm
	umk.total_aset,		-- dari table umkm
	umk.omzet_per_tahun,	-- dari table umkm
	su.batas_aset_bawah,	-- dari table skala_umkm
	su.batas_aset_atas,	-- dari table skala_umkm
	su.batas_omzet_bawah,	-- dari table skala_umkm
	su.batas_omzet_atas	-- dari table skala_umkm
FROM umkm umk
JOIN skala_umkm su ON umk.id_skala = su.id_skala
JOIN pemilik_umkm pu ON umk.id_pemilik = pu.id_pemilik
WHERE su.nama_skala = 'Menengah';

-- Memanggil VIEW view_umkm_menengah --
SELECT * FROM view_umkm_menengah;

-- 5. menampilkan jumlah UMKM di setiap kabupaten/kota, dengan menampilkan nama kabupaten/kota dan jumlah UMKM yang terdaftar. --
CREATE VIEW view_umkm_per_kota AS
SELECT kku.nama_kabupaten_kota,		-- dari table kabupaten_kota
	COUNT(umk.id_umkm) AS jumlah_umkm
FROM umkm umk
JOIN kabupaten_kota kku ON kku.id_kabupaten_kota = umk.id_kabupaten_kota
GROUP BY kku.nama_kabupaten_kota ORDER BY jumlah_umkm DESC;

-- Memanggil VIEW view_umkm_per_kota --
SELECT * FROM view_umkm_per_kota;