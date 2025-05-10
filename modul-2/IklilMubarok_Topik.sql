CREATE DATABASE sekolah_musik;

USE sekolah_musik;

CREATE TABLE Murid (
    id_murid INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(50),
    usia INT,
    alamat VARCHAR(100),
    telepon VARCHAR(15)
);

CREATE TABLE Guru (
    id_guru INT AUTO_INCREMENT PRIMARY KEY,
    nama_guru VARCHAR(50),
    spesialisasi VARCHAR(50),
    pengalaman_tahun INT
);

CREATE TABLE AlatMusik (
    id_alat INT AUTO_INCREMENT PRIMARY KEY,
    nama_alat VARCHAR(50),
    jenis VARCHAR(30),
    harga_sewa DECIMAL(10, 2)
);

CREATE TABLE KelasMusik (
    id_kelas INT AUTO_INCREMENT PRIMARY KEY,
    nama_kelas VARCHAR(50),
    id_guru INT,
    id_alat INT,
    durasi_jam INT,
    biaya DECIMAL(10, 2),
    FOREIGN KEY (id_guru) REFERENCES Guru(id_guru),
    FOREIGN KEY (id_alat) REFERENCES AlatMusik(id_alat)
);

CREATE TABLE Pendaftaran (
    id_pendaftaran INT AUTO_INCREMENT PRIMARY KEY,
    id_murid INT,
    id_kelas INT,
    tanggal_pendaftaran DATE,
    FOREIGN KEY (id_murid) REFERENCES Murid(id_murid),
    FOREIGN KEY (id_kelas) REFERENCES KelasMusik(id_kelas)
);


INSERT INTO Murid (nama, usia, alamat, telepon) VALUES
('Alya Putri', 13, 'Jl. Melodi No.1', '081234561111'),
('Bima Saputra', 15, 'Jl. Nada No.5', '081234561112'),
('Cindy Rahma', 14, 'Jl. Irama No.8', '081234561113'),
('Dodi Pratama', 16, 'Jl. Musik No.10', '081234561114'),
('Eka Nurul', 12, 'Jl. Lagu No.3', '081234561115'),
('Fahri Anwar', 13, 'Jl. Simfoni No.9', '081234561116'),
('Gilang Ramadhan', 17, 'Jl. Do Re Mi No.4', '081234561117'),
('Hesti Aprilia', 14, 'Jl. Harmoni No.6', '081234561118'),
('Ivan Permana', 15, 'Jl. Nada Indah No.2', '081234561119'),
('Jihan Maulida', 13, 'Jl. Komposer No.7', '081234561120');

INSERT INTO Guru (nama_guru, spesialisasi, pengalaman_tahun) VALUES
('Pak Dodi', 'Gitar', 5),
('Bu Nina', 'Piano', 7),
('Pak Ari', 'Biola', 6),
('Bu Reni', 'Drum', 4),
('Pak Fajar', 'Saxophone', 8),
('Bu Lilis', 'Vokal', 10),
('Pak Andi', 'Keyboard', 3),
('Bu Maya', 'Flute', 6),
('Pak Budi', 'Bass', 5),
('Bu Tika', 'Vokal', 9);

INSERT INTO AlatMusik (nama_alat, jenis, harga_sewa) VALUES
('Gitar Akustik', 'Petik', 50000),
('Piano Digital', 'Tuts', 120000),
('Biola', 'Gesek', 80000),
('Drum Elektrik', 'Perkusi', 100000),
('Saxophone', 'Tiup', 110000),
('Keyboard', 'Tuts', 90000),
('Bass Elektrik', 'Petik', 95000),
('Flute', 'Tiup', 60000),
('Cajon', 'Perkusi', 40000),
('Ukulele', 'Petik', 45000);

INSERT INTO KelasMusik (nama_kelas, id_guru, id_alat, durasi_jam, biaya) VALUES
('Gitar Pemula', 1, 1, 2, 150000),
('Piano Dasar', 2, 2, 2, 200000),
('Biola Lanjutan', 3, 3, 3, 250000),
('Drum Anak', 4, 4, 1, 120000),
('Saxophone Dewasa', 5, 5, 2, 300000),
('Vokal Reguler', 6, 6, 2, 180000),
('Keyboard Dasar', 7, 6, 2, 160000),
('Flute Remaja', 8, 8, 2, 170000),
('Bass Intensif', 9, 7, 2, 190000),
('Vokal Profesional', 10, 6, 3, 350000);

INSERT INTO Pendaftaran (id_murid, id_kelas, tanggal_pendaftaran) VALUES
(1, 1, '2025-04-01'),
(2, 2, '2025-04-02'),
(3, 3, '2025-04-03'),
(4, 4, '2025-04-04'),
(5, 5, '2025-04-05'),
(6, 6, '2025-04-06'),
(7, 7, '2025-04-07'),
(8, 8, '2025-04-08'),
(9, 9, '2025-04-09'),
(10, 10, '2025-04-10');

-- 1 Gabungkan data Murid dan Pendaftaran agar terlihat murid mendaftar kapan.
CREATE VIEW view_murid_pendaftaran AS
SELECT 
    m.id_murid,
    m.nama AS nama_murid,
    p.tanggal_pendaftaran
FROM Murid m
JOIN Pendaftaran p ON m.id_murid = p.id_murid;

-- sudah di exc

-- 2 Gabungkan Murid, Pendaftaran, dan KelasMusik agar bisa melihat murid ikut kelas apa.
CREATE VIEW view_murid_kelas AS
SELECT 
    m.nama AS nama_murid,
    k.nama_kelas,
    p.tanggal_pendaftaran
FROM Murid m
JOIN Pendaftaran p ON m.id_murid = p.id_murid
JOIN KelasMusik k ON p.id_kelas = k.id_kelas;

-- 3 Tampilkan hanya murid yang mengikuti kelas dengan biaya lebih dari 200.000.
CREATE VIEW view_murid_kelas_mahal AS
SELECT 
    m.nama AS nama_murid,
    k.nama_kelas,
    k.biaya
FROM Murid m
JOIN Pendaftaran p ON m.id_murid = p.id_murid
JOIN KelasMusik k ON p.id_kelas = k.id_kelas
WHERE k.biaya > 200000;

-- 4 Tampilkan jumlah murid per kelas.
CREATE VIEW view_jumlah_murid_per_kelas AS
SELECT 
    k.nama_kelas,
    COUNT(p.id_murid) AS jumlah_murid
FROM KelasMusik k
JOIN Pendaftaran p ON k.id_kelas = p.id_kelas
GROUP BY k.nama_kelas;

-- 5 Tampilkan detail kelas lengkap: siapa gurunya, alat musik apa yang digunakan, dan biayanya. Ini berguna untuk analisis operasional kelas.
CREATE VIEW view_detail_kelas AS
SELECT 
    k.nama_kelas,
    g.nama_guru,
    a.nama_alat,
    k.durasi_jam,
    k.biaya
FROM KelasMusik k
JOIN Guru g ON k.id_guru = g.id_guru
JOIN AlatMusik a ON k.id_alat = a.id_alat;






