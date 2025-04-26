CREATE DATABASE pertanian_bawang_merah;
USE pertanian_bawang_merah;

---tableMaster petani
CREATE TABLE petani (
	id_petani INT PRIMARY KEY AUTO_INCREMENT,
	nama_petani VARCHAR(50)NOT NULL,
	no_hp VARCHAR(20),
	alamat TEXT
);

CREATE TABLE lahan (
	id_lahan INT AUTO_INCREMENT PRIMARY KEY,
	id_petani INT,
	lokasi VARCHAR(50),
	luas_ha DECIMAL(5,2),
	jenis_tanah VARCHAR(50),
	FOREIGN KEY (id_petani) REFERENCES petani (id_petani)
);

CREATE TABLE pembeli (
	id_pembeli INT AUTO_INCREMENT PRIMARY KEY,
	nama_pembeli VARCHAR(50),
	no_hp VARCHAR(50)
);

---tableTransaksi

CREATE TABLE perawatan (
	id_perawatan INT AUTO_INCREMENT PRIMARY KEY,
	id_lahan INT,
	tgl DATE,
	jenis_perawatan ENUM('Pemupukan', 'Penyemprotan', 'Penyiangan'),
	biaya DECIMAL(10,2),
	FOREIGN KEY (id_lahan) REFERENCES lahan(id_lahan)
);

CREATE TABLE panen (
	id_panen INT AUTO_INCREMENT PRIMARY KEY,
	id_lahan INT,
	tgl_panen DATE,
	berat_kg DECIMAL(10,2),
	kualitas ENUM('A', 'B', 'C'),
	FOREIGN KEY (id_lahan) REFERENCES lahan(id_lahan)
);

CREATE TABLE pembelian (
	id_pembelian INT AUTO_INCREMENT PRIMARY KEY,
	id_panen INT,
	id_pembeli INT,
	harga_per_kg DECIMAL(10,2),
	total_kg DECIMAL (10,2),
	tgl_beli DATE,
	FOREIGN KEY (id_panen) REFERENCES panen(id_panen),
	FOREIGN KEY (id_pembeli) REFERENCES pembeli(id_pembeli)
);