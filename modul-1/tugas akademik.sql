CREATE DATABASE akademik5;

-- 1. Membuat Database Akademik

USE akademik5;
DROP TABLE mahasiswa;

-- Membuat Tabel Mahasiswa
CREATE TABLE mahasiswa (
    nim INT PRIMARY KEY,
    nama VARCHAR(100),
    kelas_id INT,
    angkatan INT,
    FOREIGN KEY (kelas_id) REFERENCES kelas(id)
);




-- Membuat Tabel Kelas
CREATE TABLE kelas (
    id INT PRIMARY KEY,
    nama_kelas VARCHAR(50)
);

-- menambahkan kolom nip pada dosen
ALTER TABLE Kelas ADD COLUMN nip INT UNIQUE NOT NULL;

ALTER TABLE Kelas ADD CONSTRAINT Dosen FOREIGN KEY (nip) REFERENCES Dosen(nip);

-- mengubah primary key
ALTER TABLE Kelas CHANGE id id_kelas INT AUTO_INCREMENT;

SELECT * FROM Kelas;

-- Membuat Tabel Dosen
CREATE TABLE Dosen (
    nip INT PRIMARY KEY,
    nama VARCHAR(100),
    gelar VARCHAR(50)
    ALTER TABLE Dosen ADD PRIMARY KEY (nip);

);


-- Membuat Tabel Mata Kuliah
CREATE TABLE MataKuliah (
    kode_mk INT PRIMARY KEY,
    nama_mk VARCHAR(100),
    sks INT,
    semester INT,
    nip INT,
    FOREIGN KEY (nip) REFERENCES Dosen(nip)
);



DROP TABLE MataKuliah;

-- Membuat Tabel KRS (menghubungkan Mahasiswa dan Mata Kuliah)
DROP TABLE  KRS;

CREATE TABLE KRS (
    id_krs INT PRIMARY KEY,
    nim INT,
    kode_mk INT,
    semester INT,
    FOREIGN KEY (nim) REFERENCES mahasiswa(nim),
    FOREIGN KEY (kode_mk) REFERENCES matkul(kode_mk)
) ENGINE = INNODB;


CREATE TABLE krs (
	id_krs INT PRIMARY KEY,
	nim INT,
	kode_mk INT,
	tahun_ajaran INT,
	semester INT,
	FOREIGN KEY (nim) REFERENCES Mahasiswa(nim),
	FOREIGN KEY (kode_mk) REFERENCES MataKuliah(kode_mk)
);

ALTER TABLE mahasiswa ENGINE = INNODB;
ALTER TABLE matkul ENGINE = INNODB;
ALTER TABLE KRS ENGINE = INNODB;



-- 2. Memasukkan 10 data ke tabel Kelas
INSERT INTO Kelas (id,nama_kelas) VALUES
(1, 'SI-21'),
(2, 'SI-22'),
(3, 'SI-23'),
(4, 'SI-24'),
(5, 'SI-25'),
(6, 'SI-26'),
(7, 'SI-27'),
(8, 'SI-28'),
(9, 'SI-29'),
(10, 'SI-30');

-- 2. Memasukkan 10 data ke tabel Mahasiswa
INSERT INTO Mahasiswa (nim,nama,kelas_id,angkatan)VALUES
('210001', 'Ali Mahasiswa', 1, 2021),
('210002', 'Budi Cerdas', 1, 2021),
('210003', 'Citra Harapan', 2, 2022),
('210004', 'Dinda Nurani', 2, 2022),
('210005', 'Eka Wijaya', 3, 2023),
('210006', 'Farhan Kusuma', 3, 2023),
('210007', 'Gita Melati', 4, 2024),
('210008', 'Hadi Saputra', 4, 2024),
('210009', 'Indra Permana', 4, 2024),
('210010', 'Joko Santoso', 4, 2024);

-- Memasukkan 10 data ke tabel Dosen
INSERT INTO Dosen (nip,nama,gelar)VALUES
('10001', 'Dr. Andi Saputra', 'S.Kom., M.Kom'),
('10002', 'Dr. Bambang Sugiarto', 'S.Kom., M.T'),
('10003', 'Dr. Cahyono Wijaya', 'S.T., M.T'),
('10004', 'Prof. Dewi Lestari', 'S.Kom., Ph.D'),
('10005', 'Dr. Edwin Haryono', 'S.T., M.Kom'),
('10006', 'Dr. Fitriani Sari', 'S.Kom., M.Sc'),
('10007', 'Dr. Gunawan Prasetyo', 'S.T., M.T'),
('10008', 'Dr. Hendra Wijaya', 'S.Kom., M.Kom'),
('10009', 'Dr. Indah Permata', 'S.Kom., M.Sc'),
('10010', 'Dr. Joko Waluyo', 'S.T., M.T');

-- Memasukkan 10 data ke tabel Mata Kuliah
INSERT INTO MataKuliah (kode_mk,nama_mk,sks) VALUES
(00001, 'Basis Data', 3),
(00002, 'Algoritma dan Pemrograman', 4),
(00003, 'Pemrograman Web', 3),
(00004, 'Sistem Operasi', 3),
(00005, 'Jaringan Komputer', 3),
(00006, 'Manajemen Proyek TI', 2),
(00007, 'Kecerdasan Buatan', 3),
(00008, 'Keamanan Siber', 3),
(00009, 'Data Science', 3),
(00010, 'Pemrograman Mobile', 3);

-- 3. Menampilkan keseluruhan data pada setiap tabel
SELECT * FROM Kelas;
SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM MataKuliah;
SELECT * FROM KRS;

-- 4. Menambahkan 5 data ke tabel KRS
INSERT INTO KRS (nim, kode_mk, semester) VALUES
('210001', 00001, 3),
('210002', 00002, 3),
('210003', 00003, 3),
('210004', 00004, 3),
('210005', 00005, 3);

-- 5. Mengubah nama tabel MataKuliah menjadi Matkul
ALTER TABLE MataKuliah RENAME TO Matkul;

-- 6. Menghapus database
DROP DATABASE akademik;

