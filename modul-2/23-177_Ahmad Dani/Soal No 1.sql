CREATE DATABASE praktikum_smbd_modul_2

USE praktikum_smbd_modul_2

SHOW TABLES

CREATE TABLE kategori_umkm (
  id_kategori INT PRIMARY KEY AUTO_INCREMENT,
  nama_kategori VARCHAR(100) NOT NULL,
  deskripsi TEXT NOT NULL
)

CREATE TABLE pemilik_umkm (
  id_pemilik INT(11) PRIMARY KEY AUTO_INCREMENT,
  nik VARCHAR(16) NOT NULL,
  nama_lengkap VARCHAR(200) NOT NULL,
  jenis_kelamin ENUM('Laki-laki','Perempuan') NOT NULL,
  alamat TEXT NOT NULL,
  nomor_telepon VARCHAR(15) NOT NULL,
  email VARCHAR(100) NOT NULL,
)

CREATE TABLE produk_umkm (
  id_produk INT(11) PRIMARY KEY AUTO_INCREMENT,
  id_umkm INT(11) NOT NULL,
  nama_produk VARCHAR(200) NOT NULL,
  deskripsi_produk TEXT NOT NULL,
  harga DECIMAL(15,2) NOT NULL,
  FOREIGN KEY (id_umkm) REFERENCES umkm(id_umkm)
)

CREATE TABLE skala_umkm (
  id_skala INT(11) PRIMARY KEY AUTO_INCREMENT,
  nama_skala VARCHAR(50) NOT NULL,
  batas_aset_bawah DECIMAL(15,2) NOT NULL,
  batas_aset_atas DECIMAL(15,2) NOT NULL,
  batas_omzet_bawah DECIMAL(15,2) NOT NULL,
  batas_omzet_atas DECIMAL(15,2) NOT NULL
)


CREATE TABLE kabupaten_kota (
  id_kabupaten_kota INT(11) PRIMARY KEY AUTO_INCREMENT,
  nama_kabupaten_kota VARCHAR(100) NOT NULL
)

CREATE TABLE umkm (
  id_umkm INT(11) PRIMARY KEY AUTO_INCREMENT,
  nama_usaha VARCHAR(200) NOT NULL,
  id_pemilik INT(11),
  id_kategori INT(11),
  id_skala INT(11),
  id_kabupaten_kota INT(11),
  alamat_usaha TEXT NOT NULL,
  nib VARCHAR(50) NOT NULL,
  npwp VARCHAR(20) NOT NULL,
  tahun_berdiri YEAR(4) NOT NULL,
  jumlah_karyawan INT(11) NOT NULL,
  total_aset DECIMAL(10,0) NOT NULL,
  omzet_per_tahun INT(11) NOT NULL,
  deskripsi_usaha TEXT NOT NULL,
  tanggal_registrasi DATE NOT NULL,
  FOREIGN KEY (id_pemilik) REFERENCES pemilik_umkm(id_pemilik),
  FOREIGN KEY (id_kategori) REFERENCES kategori_umkm(id_kategori),
  FOREIGN KEY (id_skala) REFERENCES skala_umkm(id_skala),
  FOREIGN KEY (id_kabupaten_kota) REFERENCES kabupaten_kota(id_kabupaten_kota)
)

SHOW TABLES

SELECT * FROM kategori_umkm
SELECT * FROM kabupaten_kota
SELECT * FROM kategori_umkm
SELECT * FROM produk_umkm
SELECT * FROM skala_umkm
SELECT * FROM umkm

# Answer to question number 1
CREATE VIEW view_umkm_detail AS 
	SELECT umkm.nama_usaha, 
	pemilik_umkm.nama_lengkap AS nama_pemilik,
	kategori_umkm.nama_kategori AS kategori_umkm,
	skala_umkm.nama_skala AS skala_umkm,
	kabupaten_kota.nama_kabupaten_kota AS kabupaten_kota,
	umkm.tahun_berdiri
	FROM umkm
	JOIN pemilik_umkm ON umkm.id_pemilik = pemilik_umkm.id_pemilik
	JOIN kategori_umkm ON umkm.id_kategori = kategori_umkm.id_kategori
	JOIN skala_umkm ON umkm.id_skala = skala_umkm.id_skala
	JOIN kabupaten_kota ON umkm.id_kabupaten_kota = kabupaten_kota.id_kabupaten_kota
	
SELECT * FROM view_umkm_detail

# Answer to question number 2
CREATE VIEW view_pemilik_dan_usaha AS 
	SELECT pemilik_umkm.nik, 
	pemilik_umkm.nama_lengkap, 
	pemilik_umkm.jenis_kelamin, 
	pemilik_umkm.nomor_telepon, 
	pemilik_umkm.email, 
	umkm.nama_usaha 
	FROM pemilik_umkm
	JOIN umkm ON pemilik_umkm.id_pemilik = umkm.id_pemilik

SELECT * FROM view_pemilik_dan_usaha

# Answer to question number 3
CREATE VIEW view_produk_umkm AS 
	SELECT umkm.nama_usaha,
	produk_umkm.nama_produk,
	produk_umkm.deskripsi_produk,
	produk_umkm.harga
	FROM umkm
	JOIN produk_umkm ON umkm.id_umkm = produk_umkm.id_umkm

SELECT * FROM view_produk_umkm

# Answer to question number 4
CREATE VIEW view_umkm_menengah AS 
	SELECT umkm.nama_usaha, 
	pemilik_umkm.nama_lengkap AS nama_pemilik,
	umkm.total_aset,
	umkm.omzet_per_tahun
	FROM umkm 
	JOIN pemilik_umkm ON umkm.id_pemilik = pemilik_umkm.id_pemilik
	JOIN skala_umkm ON umkm.id_skala = skala_umkm.id_skala
	WHERE skala_umkm.nama_skala = "Menengah"

SELECT * FROM view_umkm_menengah

# Answer to question number 5
CREATE VIEW view_umkm_per_kota AS 
	SELECT kabupaten_kota.nama_kabupaten_kota,
	COUNT(umkm.id_umkm) AS jumlah_umkm
	FROM kabupaten_kota
	LEFT JOIN umkm ON kabupaten_kota.id_kabupaten_kota = umkm.id_kabupaten_kota
	GROUP BY kabupaten_kota.nama_kabupaten_kota
	

SELECT * FROM view_umkm_per_kota
