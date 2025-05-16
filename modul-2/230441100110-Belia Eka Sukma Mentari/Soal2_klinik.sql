CREATE DATABASE db_klinik;
USE db_klinik;

CREATE TABLE pasien (
    id_pasien INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    tanggal_lahir DATE,
    jenis_kelamin ENUM('Laki-laki', 'Perempuan'),
    alamat VARCHAR(200),
    no_telp VARCHAR(15)
);

CREATE TABLE dokter (
    id_dokter INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    spesialisasi VARCHAR(100),
    jadwal_praktek VARCHAR(50),
    no_telp VARCHAR(15)
);

CREATE TABLE obat (
    id_obat INT AUTO_INCREMENT PRIMARY KEY,
    nama_obat VARCHAR(100),
    jenis_obat VARCHAR(50),
    dosis VARCHAR(50),
    stok INT
);

CREATE TABLE kunjungan (
    id_kunjungan INT AUTO_INCREMENT PRIMARY KEY,
    id_pasien INT,
    id_dokter INT,
    tanggal_kunjungan DATE,
    keluhan VARCHAR(255),
    diagnosa VARCHAR(255),
    FOREIGN KEY (id_pasien) REFERENCES pasien(id_pasien),
    FOREIGN KEY (id_dokter) REFERENCES dokter(id_dokter)
);

CREATE TABLE resep (
    id_resep INT AUTO_INCREMENT PRIMARY KEY,
    id_kunjungan INT,
    id_obat INT,
    jumlah INT,
    aturan_pakai VARCHAR(255),
    FOREIGN KEY (id_kunjungan) REFERENCES kunjungan(id_kunjungan),
    FOREIGN KEY (id_obat) REFERENCES obat(id_obat)
);

SHOW TABLES;

INSERT INTO pasien (nama, tanggal_lahir, jenis_kelamin, alamat, no_telp) VALUES
('Andi Saputra', '1990-05-14', 'Laki-laki', 'Jl. Merdeka No. 10, Nganjuk', '081234567890'),
('Rina Wulandari', '1985-08-23', 'Perempuan', 'Jl. Melati No. 5, Kediri', '081245678901'),
('Budi Santoso', '1978-12-11', 'Laki-laki', 'Jl. Mawar No. 15, Madiun', '081256789012'),
('Dewi Kartika', '1992-01-19', 'Perempuan', 'Jl. Kenanga No. 21, Blitar', '081267890123'),
('Hadi Pranoto', '1980-06-30', 'Laki-laki', 'Jl. Sukun No. 3, Malang', '081278901234'),
('Sri Rahayu', '1995-04-17', 'Perempuan', 'Jl. Anggrek No. 9, Surabaya', '081289012345'),
('Tono Wijaya', '1988-09-08', 'Laki-laki', 'Jl. Dahlia No. 18, Jombang', '081290123456'),
('Intan Permatasari', '1993-11-05', 'Perempuan', 'Jl. Flamboyan No. 12, Mojokerto', '081201234567'),
('Agus Saputro', '1981-03-27', 'Laki-laki', 'Jl. Cendana No. 6, Tulungagung', '081212345678'),
('Fitri Anjani', '1996-07-14', 'Perempuan', 'Jl. Teratai No. 14, Sidoarjo', '081223456789');

INSERT INTO dokter (nama, spesialisasi, jadwal_praktek, no_telp) VALUES
('Dr. Siti Handayani', 'Umum', 'Senin - Jumat 08:00-12:00', '082112345678'),
('Dr. Budi Hartono', 'Pediatri', 'Senin & Kamis 10:00-14:00', '082223344556'),
('Dr. Lina Marlina', 'Gigi', 'Selasa & Jumat 09:00-13:00', '082334455667'),
('Dr. Agus Wirawan', 'Umum', 'Senin - Rabu 08:00-12:00', '082445566778'),
('Dr. Ratna Sari', 'Kulit', 'Rabu & Kamis 10:00-15:00', '082556677889');

INSERT INTO obat (nama_obat, jenis_obat, dosis, stok) VALUES
('Paracetamol', 'Analgesik', '500 mg', 100),
('Amoxicillin', 'Antibiotik', '500 mg', 50),
('Ibuprofen', 'Anti-inflamasi', '400 mg', 80),
('Cetirizine', 'Antihistamin', '10 mg', 70),
('Loperamide', 'Antidiare', '2 mg', 60),
('Omeprazole', 'Antasida', '20 mg', 40),
('Metformin', 'Antidiabetik', '500 mg', 30),
('Salbutamol', 'Bronkodilator', '2 mg', 90),
('Amlodipine', 'Antihipertensi', '5 mg', 25),
('Diazepam', 'Sedatif', '5 mg', 20);

INSERT INTO kunjungan (id_pasien, id_dokter, tanggal_kunjungan, keluhan, diagnosa) VALUES
(1, 1, '2025-04-10', 'Demam dan sakit kepala', 'Influenza ringan'),
(2, 2, '2025-04-11', 'Batuk berkepanjangan', 'Bronkitis'),
(3, 3, '2025-04-12', 'Gigi berlubang', 'Karies dentis'),
(4, 4, '2025-04-13', 'Ruam kulit', 'Dermatitis kontak'),
(5, 5, '2025-04-14', 'Sakit perut', 'Gastritis'),
(6, 1, '2025-04-15', 'Demam dan pilek', 'Flu'),
(7, 2, '2025-04-16', 'Anak rewel dan demam', 'Tonsilitis'),
(8, 1, '2025-04-17', 'Pusing dan lemas', 'Hipotensi'),
(9, 4, '2025-04-18', 'Gatal-gatal', 'Alergi kulit'),
(10, 3, '2025-04-19', 'Sakit gigi', 'Infeksi pulpa');

INSERT INTO resep (id_kunjungan, id_obat, jumlah, aturan_pakai) VALUES
(1, 1, 10, '3x1 setelah makan'),
(2, 2, 15, '3x1 sebelum makan'),
(3, 3, 10, '2x1 setelah makan'),
(4, 4, 10, '1x1 malam hari'),
(5, 5, 5, '2x1 sebelum makan'),
(6, 1, 8, '3x1 setelah makan'),
(7, 2, 10, '3x1 sebelum makan'),
(8, 9, 7, '1x1 setiap pagi'),
(9, 4, 12, '2x1 siang dan malam'),
(10, 3, 10, '3x1 setelah makan');

SELECT * FROM pasien;
SELECT * FROM dokter;
SELECT * FROM obat;
SELECT * FROM kunjungan;
SELECT * FROM resep;

#no 1
CREATE VIEW view_kunjungan_pasien_dokter AS
SELECT 
    k.id_kunjungan,
    p.nama AS nama_pasien,
    p.jenis_kelamin,
    p.tanggal_lahir,
    d.nama AS nama_dokter,
    d.spesialisasi,
    k.tanggal_kunjungan,
    k.keluhan,
    k.diagnosa
FROM kunjungan k
JOIN pasien p ON k.id_pasien = p.id_pasien
JOIN dokter d ON k.id_dokter = d.id_dokter;

SELECT * FROM view_kunjungan_pasien_dokter;

#no 2
CREATE VIEW view_resep_kunjungan_pasien AS
SELECT 
    k.id_kunjungan,
    p.nama AS nama_pasien,
    k.tanggal_kunjungan,
    k.keluhan,
    k.diagnosa,
    o.nama_obat,
    o.jenis_obat,
    r.jumlah,
    r.aturan_pakai
FROM resep r
JOIN kunjungan k ON r.id_kunjungan = k.id_kunjungan
JOIN pasien p ON k.id_pasien = p.id_pasien
JOIN obat o ON r.id_obat = o.id_obat;

SELECT * FROM view_resep_kunjungan_pasien;

#no 3
CREATE VIEW view_resep_jumlah_lebih_5 AS
SELECT 
    r.id_resep,
    r.id_kunjungan,
    o.nama_obat,
    o.jenis_obat,
    r.jumlah,
    r.aturan_pakai
FROM resep r
JOIN obat o ON r.id_obat = o.id_obat
WHERE r.jumlah > 5;

SELECT * FROM view_resep_jumlah_lebih_5;

#no 4
CREATE VIEW view_agregat_obat_resep AS
SELECT 
    o.jenis_obat,
    COUNT(r.id_resep) AS jumlah_resep,
    SUM(r.jumlah) AS total_obat_diresepkan,
    AVG(r.jumlah) AS rata_rata_jumlah
FROM resep r
JOIN obat o ON r.id_obat = o.id_obat
GROUP BY o.jenis_obat;

SELECT * FROM view_agregat_obat_resep;

#no 5
CREATE VIEW view_pasien_kunjungan_terbanyak_2025 AS
SELECT 
    p.id_pasien,
    p.nama AS nama_pasien,
    p.jenis_kelamin,
    p.tanggal_lahir,
    COUNT(k.id_kunjungan) AS total_kunjungan
FROM pasien p
JOIN kunjungan k ON p.id_pasien = k.id_pasien
WHERE YEAR(k.tanggal_kunjungan) = 2025
GROUP BY p.id_pasien, p.nama, p.jenis_kelamin, p.tanggal_lahir
ORDER BY total_kunjungan DESC;

SELECT * FROM view_pasien_kunjungan_terbanyak_2025;

