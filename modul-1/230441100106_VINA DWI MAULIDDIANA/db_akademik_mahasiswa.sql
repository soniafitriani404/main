CREATE DATABASE akademik_mahasiswa;
USE akademik_mahasiswa;

CREATE TABLE mhs (
	nim VARCHAR(50)NOT NULL PRIMARY KEY,
	nama_mhs VARCHAR(50) NOT NULL,
	prodi VARCHAR (100) NOT NULL,
	Angkatan INT(4) NULL,
	smt INT NOT NULL,
	asal_kota VARCHAR (50) NOT NULL,
	jenis_kelamin ENUM('Perempuan', 'Laki Laki')
);

CREATE TABLE dosen (
	nip VARCHAR (50) PRIMARY KEY,
	nama_dosen VARCHAR (100) NOT NULL,
	no_tlp VARCHAR (15)
);

CREATE TABLE matkul(
	kode_matkul VARCHAR(30) PRIMARY KEY,
	nama_matkul VARCHAR(100) NOT NULL,
	sks INT NOT NULL,
	nip VARCHAR(50) NOT NULL,
	FOREIGN KEY(nip) REFERENCES dosen(nip)
	);

CREATE TABLE krs(
	kode_krs VARCHAR(50) PRIMARY KEY,
	kode_matkul VARCHAR(50) NOT NULL,
	nim VARCHAR(50) NOT NULL,
	thn_akademik VARCHAR(20) NOT NULL,
	FOREIGN KEY (nim) REFERENCES mhs(nim),
	FOREIGN KEY (kode_matkul) REFERENCES matkul(kode_matkul)
);

CREATE TABLE kls(
	id_kls VARCHAR(50) PRIMARY KEY,
	kode_matkul VARCHAR (50) NOT NULL,
	ruang VARCHAR(50),
	jadwal VARCHAR(50),
	nip VARCHAR (50) NOT NULL,
	FOREIGN KEY (kode_matkul) REFERENCES matkul(kode_matkul),
	FOREIGN KEY (nip) REFERENCES dosen(nip)
);
	
	
INSERT INTO mhs (nim, nama_mhs, prodi, Angkatan, smt, asal_kota, jenis_kelamin) VALUES
	('23016', 'Zendia Ayunda', 'Sistem Informasi', 2023 , 4, 'Sidoarjo', 'Perempuan'),
	('23030', 'Rohmatul Azli Fitri Devi', 'Sistem Informasi', 2024, 3,'Gresik', 'Perempuan'),
	('23046', 'Amalia Fitri Lestari', 'Sistem Informasi', 2023, 4, 'Jombang', 'Perempuan'),
	('23158', 'Muhammad Alvinas Zidan','Sistem Informasi', 2024, 2, 'Madura','Laki Laki'),
	('23031', 'Alini Mira Triwahyuningsing', 'Sistem Informasi', 2023, 4, 'Surabaya', 'Perempuan'),
	('23011', 'Muhammad Anwar', 'Sistem Informasi', 2024, 2, 'Malang', 'Laki Laki'),
	('23180', 'Arhamiz Fegianti',  'Sistem Informasi', 2024, 3, 'Tuban', 'Perempuan'),
	('23151', 'Diki Waluya', 'Sistem Informasi', 2023, 4, 'Jakarta', 'Laki Laki'),
	('23181', 'Melati Ulfa Wijaya','Sistem Informasi',  2024, 4, 'Lamongan', 'Perempuan'),
	('23094', 'Muhammad Dias Mukholif', 'Sistem Informasi', 2023, 2, 'Nganjuk', 'Laki Laki');
	
	
INSERT INTO dosen (nama_dosen, nip, no_tlp) VALUES
	('Dr. Wahyudi Agustiono , S.T., M.Kom', '198705202019031013', '089657681256'),
	('Rosa Mala Apillia, S.T.', '197709212008122002', '089543235612'),
	('Eza Rahmanita, S.Kom., M.Kom', '198308282008122002', '276712345432'),
	('Zain Ramadhani, S.T., M.T', '197509092002121001', '087515467892'),
	('Yudha Putra Negara, S.T., M.Kom', '197805042002121002', '089616573456'),
	('Dr. Yeni Kustiyahningsih, S.Kom., M.Sc., Ph.D', '198711272014042001', '087631561728'),
	('Mashudah Sabilaturisqi, S.T., M.Kom', '197906052003122003', '081257528167'),
	('Ali Muhammad, S.T., M.T.', '198306082008012005', '089412678923'),
	('Rosida Vivin Nahari, S.Kom., M.Sc., Ph.D', '197808042003121001', '089154678211'),
	('Ali Yahya, S.Kom, M.Kom', '198003212008011008', '081167789999');

		
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
	
INSERT INTO krs(kode_krs, kode_matkul, nim, thn_akademik) VALUES
	('SI443', 'MK007', '23016', '2024/2025'),   
	('SI448', 'MK002', '23030', '2024/2025'),   
	('SI441', 'MK010', '23046', '2023/2024'),   
	('SI446', 'MK005', '23158', '2024/2025'), 
	('SI449', 'MK003', '23031', '2023/2024'),  
	('SI440', 'MK008', '23011', '2023/2024'), 
	('SI445', 'MK001', '23180', '2024/2025'),
	('SI442', 'MK004', '23151', '2024/2025'), 
	('SI447', 'MK009', '23181', '2023/2024'),
	('SI444', 'MK006', '23094', '2023/2024');
	
	
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
	
SELECT * FROM mhs;
SELECT * FROM matkul;
SELECT * FROM dosen;
SELECT * FROM krs;
SELECT * FROM kls;
select * from matkul where nip = '197509092002121001';

-- Menghapus salah satu nilai --
DELETE FROM mhs
WHERE nim = '23016';

DELETE FROM krs WHERE nim = '23016';

-- Lihat semua table
SHOW TABLES;

-- Mengubah Tabel Mahasiswa--
UPDATE mhs SET nama_mhs = 'Zendia Ayunda Sari' WHERE nim = '23016';

RENAME TABLE mata_kuliah TO matkul;

DROP DATABASE akademik_mahasiswa;