CREATE DATABASE pa_smbd

USE pa_smbd

SHOW TABLES

CREATE TABLE pemilik (
	id_pemilik INT PRIMARY KEY AUTO_INCREMENT,
	nama_pemilik VARCHAR(50) NOT NULL,
	kontak VARCHAR(20) NOT NULL,
	alamat VARCHAR(255) NOT NULL
);

CREATE TABLE kost (
	id_kost INT PRIMARY KEY AUTO_INCREMENT,
	id_pemilik INT,
	nama_kost VARCHAR(100) NOT NULL,
	alamat VARCHAR(255) NOT NULL,
	deskripsi TEXT,
	FOREIGN KEY (id_pemilik) REFERENCES pemilik(id_pemilik)
);

CREATE TABLE informasi_kamar (
	id_info_kamar INT PRIMARY KEY AUTO_INCREMENT,
	id_kost INT UNIQUE,
	harga_perbulan INT NOT NULL,
	jumlah_kamar INT NOT NULL,
	deskripsi TEXT,
	FOREIGN KEY (id_kost) REFERENCES kost(id_kost)
);

CREATE TABLE fasilitas (
	id_fasilitas INT PRIMARY KEY AUTO_INCREMENT,
	nama_fasilitas VARCHAR(70) NOT NULL,
	deskripsi TEXT
);

CREATE TABLE fasilitas_kost (
	id_fasilitas_kost INT PRIMARY KEY AUTO_INCREMENT,
	id_kost INT,
	id_fasilitas INT,
	FOREIGN KEY (id_kost) REFERENCES kost(id_kost),
	FOREIGN KEY (id_fasilitas) REFERENCES fasilitas(id_fasilitas)
);