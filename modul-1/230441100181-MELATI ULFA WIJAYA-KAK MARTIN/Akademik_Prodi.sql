CREATE DATABASE Akademik_Prodi;
USE Akademik_Prodi;

CREATE TABLE mhs (
	nim VARCHAR(50)NOT NULL PRIMARY KEY,
	nama_mhs VARCHAR(50) NOT NULL,
	prodi VARCHAR (100) NOT NULL,
	angkatan YEAR NOT NULL,
	smt INT NOT NULL,
	jenis_kelamin ENUM('Perempuan' , 'Laki-Laki'),
	asal_kota VARCHAR(50) NOT NULL
);

INSERT INTO mhs (nim, nama_mhs, prodi, angkatan, smt, jenis_kelamin, asal_kota) VALUES
	('23181', 'Melati Ulfa Wijaya', 'Sistem Informasi', 2023, 4, 'Perempuan', 'Nganjuk'),
	('23182', 'Tegar Firmansyah', 'Sistem Informasi', 2024, 2, 'Laki-Laki', 'Jombang'),
	('23183', 'Casilda Junisa', 'Sistem Informasi', 2023, 4, 'Perempuan', 'Nganjuk'),
	('23184', 'Muhammad Ilham Fanani', 'Sistem Informasi', 2024, 2, 'Laki-Laki', 'Surabaya'),
	('23185', 'Pradita Intan', 'Sistem Informasi', 2023, 4, 'Perempuan', 'Malang'),
	('23186', 'Ahmad Arik', 'Sistem Informasi', 2024, 2, 'Laki-Laki', 'Jombang'),
	('23187', 'Nafisa Aulia', 'Sistem Informasi', 2023, 4, 'Perempuan', 'Jember'),
	('23190', 'Rifki Rozak', 'Laki - Laki', 2023, 2, 'Laki-Laki' , 'Banyuwangi'),
	('23191', 'Marsya Ayunda', 'Perempuan', 2024, 4, 'Perempuan', 'Madiun'),
	('23192', 'Muhammad Arif', 'Laki - Laki', 2023, 2, 'Laki-Laki' ,'Blitar');

CREATE TABLE dosen (
	nip VARCHAR (50) PRIMARY KEY,
	nama_dosen VARCHAR (100) NOT NULL,
	no_tlp VARCHAR(20) NOT NULL
	);

INSERT INTO dosen (nip, nama_dosen, no_tlp) VALUES
	('198705202019031013', 'Dr. Wahyudi Agustiono , S.T., M.Kom', '089657681256'),
	('197709212008122002', 'Rosa Mala Apillia, S.T.', '089543235612'),
	('198308282008122002', 'Eza Rahmanita, S.Kom., M.Kom', '086712345432'),
	('197509092002121001', 'Zain Ramadhani, S.T., M.T', '087515467892'),
	('197805042002121002', 'Yudha Putra Negara, S.T., M.Kom', '089616573456'),
	('198711272014042001', 'Dr. Yeni Kustiyahningsih, S.Kom., M.Sc., Ph.D', '087631561728'),
	('197906052003122003', 'Mashudah Sabilaturisqi, S.T., M.Kom', '081257528167'),
	('198306082008012005', 'Ali Muhammad, S.T., M.T.', '089412678923'),
	('197808042003121001', 'Rosida Vivin Nahari, S.Kom., M.Sc., Ph.D', '089154678211'),
	('198003212008011008', 'Ali Yahya, S.Kom, M.Kom', '081167789999');

CREATE TABLE matkul(
	kode_matkul VARCHAR(30) PRIMARY KEY,
	nama_matkul VARCHAR(100) NOT NULL,
	sks INT NOT NULL,
	nip VARCHAR(50) NOT NULL,
	FOREIGN KEY(nip) REFERENCES dosen(nip)
	);
	
INSERT INTO matkul (kode_matkul, nama_matkul, sks, nip) VALUES
	('MK001', 'Data Mining', 3 , '197509092002121001'), 
	('MK002', 'Pemrograman Visual', 2 , '198003212008011008'), 
	('MK003', 'Jaringan Komputer', 3 , '197906052003122003'), 
	('MK004', 'Etika Profesi', 2 , '198705202019031013'), 
	('MK005', 'Sistem Operasi', 3 , '197808042003121001'), 
	('MK006', 'Pemrograman Web', 4 , '197709212008122002'), 
	('MK007', 'Financial Technology', 3 , '198308282008122002'), 
	('MK008', 'Manajemen Proyek IT', 2 , '197805042002121002'), 
	('MK009', 'Algoritma Pemrograman', 4 , '198306082008012005'), 
	('MK010', 'Analisa Proses Bisnis', 3 , '198711272014042001'); 
		

CREATE TABLE krs(
	kode_krs VARCHAR(50) PRIMARY KEY,
	kode_matkul VARCHAR(50) NOT NULL,
	nim VARCHAR(50) NOT NULL,
	thn_akademik VARCHAR(20) NOT NULL,
	FOREIGN KEY (nim) REFERENCES mhs(nim),
	FOREIGN KEY (kode_matkul) REFERENCES matkul(kode_matkul));
	

INSERT INTO krs(kode_krs, kode_matkul, nim, thn_akademik) VALUES
	('SI443', 'MK007', '23181', '2024/2025'),   
	('SI448', 'MK002', '23184', '2024/2025'),   
	('SI441', 'MK010', '23185', '2023/2024'),   
	('SI446', 'MK005', '23182', '2024/2025'), 
	('SI449', 'MK003', '23187', '2023/2024'),  
	('SI440', 'MK008', '23183', '2023/2024'), 
	('SI445', 'MK001', '23186', '2024/2025'),
	('SI442', 'MK004', '23191', '2024/2025'), 
	('SI447', 'MK009', '23190', '2023/2024'),
	('SI444', 'MK006', '23192', '2023/2024');
		

--tableTambahan

CREATE TABLE kls(
	id_kls VARCHAR(50) PRIMARY KEY,
	kode_matkul VARCHAR (50) NOT NULL,
	ruang VARCHAR(50),
	jadwal VARCHAR(50),
	nip VARCHAR (50) NOT NULL,
	FOREIGN KEY (kode_matkul) REFERENCES matkul(kode_matkul),
	FOREIGN KEY (nip) REFERENCES dosen(nip));
	
	
INSERT INTO kls(id_kls, kode_matkul, ruang, jadwal, nip) VALUES
	('CJA701', 'MK001', 'RKBF 308', 'Senin 09:30-11:10', '197509092002121001'),
	('CJA704', 'MK002', 'Lab BIS', 'Rabu 13:00-14:40', '198003212008011008'),
	('CJA700', 'MK003', 'RKBF 409', 'Kamis 15:30-17:10', '197906052003122003'),
	('CJA707', 'MK004', 'Lab TI', 'Selasa 07:30-09:10', '198705202019031013'),
	('CJA702', 'MK005', 'RKBF 407', 'Jumat 10:10-11:50', '197808042003121001'),
	('CJA709', 'MK006', 'RKBF 207', 'Rabu 08:00-09:40', '197709212008122002'),
	('CJA705', 'MK007', 'RKBF 409', 'Senin 13:20-15:00', '198308282008122002'),
	('CJA703', 'MK008', 'RKBF 307', 'Kamis 10:10-11:50', '197805042002121002'),
	('CJA708', 'MK009', 'Lab BIS', 'Selasa 14:00-15:40', '198306082008012005'),
	('CJA706', 'MK010', 'Lab TI', 'Jumat 07:30-09:10', '198711272014042001');

SHOW TABLES;
SELECT * FROM mhs;
SELECT * FROM dosen;
SELECT * FROM matkul;
SELECT * FROM krs;
SELECT * FROM kls;

SELECT * FROM matkul WHERE nip='198705202019031013';
SELECT * FROM mhs WHERE asal_kota='Nganjuk';
SELECT * FROM mhs WHERE angkatan = 2023;
SELECT * FROM mhs WHERE jenis_kelamin = 'Laki-Laki' AND asal_kota = 'Jombang';