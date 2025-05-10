CREATE DATABASE les_bahasa_inggris;
USE les_bahasa_inggris;

CREATE TABLE siswa (
    id_siswa INT AUTO_INCREMENT PRIMARY KEY,
    nama_siswa VARCHAR(100),
    alamat TEXT,
    no_telepon VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE instruktur (
    id_instruktur INT AUTO_INCREMENT PRIMARY KEY,
    nama_instruktur VARCHAR(100),
    spesialisasi VARCHAR(100),
    no_telepon VARCHAR(15)
);

CREATE TABLE kelas (
    id_kelas INT AUTO_INCREMENT PRIMARY KEY,
    nama_kelas VARCHAR(100),
    tingkat ENUM('Beginner', 'Intermediate', 'Advanced'),
    jadwal VARCHAR(50),
    biaya DECIMAL(10,2),
    id_instruktur INT,
    FOREIGN KEY (id_instruktur) REFERENCES instruktur(id_instruktur)
);

CREATE TABLE pendaftaran (
    id_pendaftaran INT AUTO_INCREMENT PRIMARY KEY,
    id_siswa INT,
    id_kelas INT,
    tanggal_daftar DATE,
    STATUS ENUM('Aktif', 'Tidak Aktif'),
    FOREIGN KEY (id_siswa) REFERENCES siswa(id_siswa),
    FOREIGN KEY (id_kelas) REFERENCES kelas(id_kelas)
);

CREATE TABLE pembayaran (
    id_pembayaran INT AUTO_INCREMENT PRIMARY KEY,
    id_pendaftaran INT,
    tanggal_bayar DATE,
    jumlah_bayar DECIMAL(10,2),
    metode_bayar ENUM('Cash', 'Transfer', 'QRIS'),
    FOREIGN KEY (id_pendaftaran) REFERENCES pendaftaran(id_pendaftaran)
);


-- pengisian data
INSERT INTO siswa (nama_siswa, alamat, no_telepon, email) VALUES
('Rizki Fajar', 'Jl. Mangga No.12, Malang', '081330958200', 'fajar@gmail.com'),
('Rafi Refalda', 'Jl. Melati No.5, Surabaya', '082298765432', 'rafi@yahoo.com'),
('ravre', 'Jl. Melati No.5, Surabaya', '082298765432', 'rafi@yahoo.com'),
('Juju', 'Jl. Melati No.12, Madiun', '082298765432', 'juju@yahoo.com'),
('Yoga Herlindo', 'Jl. Mawar No.3, Surabaya', '083312341234', 'yogababel@gmail.com'),
('Salsabila Putri', 'Jl. Kenanga No.7, Kediri', '082200001111', 'salsa@gmail.com'),
('Dian Apriani', 'Jl. Flamboyan No.10, Malang', '082223344556', 'dianap@gmail.com'),
('Bayu Nugroho', 'Jl. Cemara No.15, Blitar', '081234567890', 'bayu.n@gmail.com'),
('Tari Hidayah', 'Jl. Pahlawan No.2, Kediri', '083345678901', 'tari.h@gmail.com'),
('Eko Prasetyo', 'Jl. Kartini No.3, Madiun', '082212345678', 'eko.p@gmail.com');

INSERT INTO instruktur (nama_instruktur, spesialisasi, no_telepon) VALUES
('Aidan Fawwaz', 'Speaking', '082217171172'),
('Rina Ayu', 'Grammar', '082345678901'),
('Andi Widodo', 'TOEFL Preparation', '083456789012'),
('Siti Munawaroh', 'Writing', '082211122233'),
('Budi Setiawan', 'Listening', '083311122233');

INSERT INTO kelas (nama_kelas, tingkat, jadwal, biaya, id_instruktur) VALUES
('Kelas Dasar A', 'Beginner', 'Senin & Rabu 10.00-12.00', 750000, 1),
('Kelas Menengah B', 'Intermediate', 'Selasa & Kamis 13.00-15.00', 850000, 2),
('TOEFL Intensive', 'Advanced', 'Sabtu & Minggu 09.00-11.00', 1000000, 3),
('Speaking Mastery', 'Intermediate', 'Senin & Kamis 16.00-18.00', 900000, 1),
('Grammar Booster', 'Beginner', 'Rabu & Jumat 14.00-16.00', 800000, 2);

INSERT INTO pendaftaran (id_siswa, id_kelas, tanggal_daftar, STATUS) VALUES
(1, 1, '2025-04-01', 'Aktif'),
(2, 2, '2025-04-02', 'Aktif'),
(3, 3, '2025-04-03', 'Tidak Aktif'),
(4, 4, '2025-04-05', 'Aktif'),
(5, 5, '2025-04-06', 'Tidak Aktif'),
(6, 1, '2025-04-07', 'Aktif'),
(7, 2, '2025-04-08', 'Aktif'),
(8, 3, '2025-04-09', 'Tidak Aktif');

INSERT INTO pembayaran (id_pendaftaran, tanggal_bayar, jumlah_bayar, metode_bayar) VALUES
(1, '2025-04-01', 750000, 'Cash'),
(2, '2025-04-02', 850000, 'Transfer'),
(3, '2025-04-04', 0, 'Cash'),
(4, '2025-04-05', 900000, 'QRIS'),
(6, '2025-04-07', 750000, 'Transfer'),
(7, '2025-04-08', 850000, 'Cash'),
(8, '2025-04-10', 0, 'QRIS');

SELECT * FROM instruktur;
SELECT * FROM kelas;
SELECT * FROM pembayaran;
SELECT * FROM pendaftaran;
SELECT * FROM siswa;


-- view untuk menampilkan data siswa dan pendaftaran kelas yang diikuti
CREATE VIEW view_siswa_pendaftaran AS SELECT 
s.id_siswa,
s.nama_siswa,
p.id_pendaftaran,
p.id_kelas,
p.tanggal_daftar,
p.status
FROM siswa s JOIN pendaftaran p ON s.id_siswa = p.id_siswa;

-- view informasi siswa, kelas yg diikuti, dan instrukturnya
CREATE VIEW view_siswa_kelas_instruktur AS SELECT
s.nama_siswa,
k.nama_kelas,
k.tingkat,
k.jadwal,
i.nama_instruktur
FROM siswa s 
JOIN pendaftaran p ON s.id_siswa = p.id_siswa
JOIN kelas k ON p.id_kelas = k.id_kelas
JOIN instruktur i ON k.id_instruktur = i.id_instruktur;

-- view siswa yang masih aktif
CREATE VIEW view_siswa_aktif AS SELECT 
s.nama_siswa,
s.email,
p.tanggal_daftar,
p.status
FROM siswa s JOIN pendaftaran p ON s.id_siswa = p.id_siswa WHERE p.status = 'Aktif';

-- view total pembayran
CREATE VIEW view_total_pembayaran_persiswa AS SELECT 
s.nama_siswa,
SUM(k.jumlah_bayar) AS total_pembayaran
FROM siswa s 
JOIN pendaftaran p ON s.id_siswa = p.id_siswa
JOIN pembayaran k ON p.id_pendaftaran = k.id_pendaftaran GROUP BY s.nama_siswa;

-- view menampilkan daftar kelas dan jumlah siswa yg ad di dlm nya
CREATE VIEW view_jumlah_peserta_per_kelas AS SELECT 
k.nama_kelas,
COUNT(p.id_pendaftaran) AS jumlah_peserta
FROM kelas k JOIN pendaftaran p ON k.id_kelas = p.id_kelas
WHERE p.status = 'Aktif' GROUP BY k.nama_kelas;

SELECT * FROM view_jumlah_peserta_per_kelas;
DROP VIEW IF EXISTS view_jumlah_peserta_per_kelas;


-- store procedure 

-- Stored procedure untuk memperbarui nama siswa berdasarkan ID siswa
DELIMITER //
CREATE PROCEDURE UpdateDataMaster(
    IN p_id INT,
    IN p_nilai_baru VARCHAR(100),
    OUT p_status VARCHAR(50)
)
BEGIN
    UPDATE siswa SET nama_siswa = p_nilai_baru WHERE id_siswa = p_id;
END //
DELIMITER ;
SET @status = '';
CALL UpdateDataMaster(3, 'Kojar', @status);
SELECT * FROM siswa WHERE id_siswa = 3;


-- Stored procedure untuk menghitung jumlah total data di pembayaran
DELIMITER //
CREATE PROCEDURE CountTransaksi(
    OUT total_transaksi INT
)
BEGIN
    SELECT COUNT(*) INTO total_transaksi FROM pembayaran;
END //
DELIMITER ;
SET @total = 0;
CALL CountTransaksi(@total);
SELECT @total;


-- Stored procedure untuk mengambil nama siswa berdasarkan ID siswa
DELIMITER //
CREATE PROCEDURE GetDataMasterByID(
    IN p_id INT,
    OUT p_nama VARCHAR(100)
)
BEGIN
    SELECT nama_siswa INTO p_nama FROM siswa WHERE id_siswa = p_id LIMIT 1;
END //
DELIMITER ;
SET @nama = '';
CALL GetDataMasterByID(2, @nama);
SELECT @nama;


-- Stored procedure untuk memperbarui jumlah_bayar dan metode_bayar berdasarkan ID pembayaran
-- Jika nilai input kosong, nilai lama akan dipertahankan
DELIMITER //
CREATE PROCEDURE UpdateFieldTransaksi(
    IN p_id INT,
    INOUT p_jumlah_bayar DECIMAL(10,2),
    INOUT p_metode_bayar ENUM('Cash', 'Transfer', 'QRIS')
)
BEGIN
    DECLARE db_jumlah DECIMAL(10,2);
    DECLARE db_metode ENUM('Cash', 'Transfer', 'QRIS');

    SELECT jumlah_bayar, metode_bayar INTO db_jumlah, db_metode
    FROM pembayaran WHERE id_pembayaran = p_id;

    IF p_jumlah_bayar IS NULL OR p_jumlah_bayar = 0 THEN
        SET p_jumlah_bayar = db_jumlah;
    END IF;

    IF p_metode_bayar IS NULL OR p_metode_bayar = '' THEN
        SET p_metode_bayar = db_metode;
    END IF;

    UPDATE pembayaran
    SET jumlah_bayar = p_jumlah_bayar,
        metode_bayar = p_metode_bayar
    WHERE id_pembayaran = p_id;
END //
DELIMITER ;
SET @jumlah = 100000;
SET @metode = 'Transfer'; 

CALL UpdateFieldTransaksi(1, @jumlah, @metode);
SELECT * FROM pembayaran WHERE id_pembayaran = 1;


-- Stored procedure untuk menghapus data siswa berdasarkan ID siswa
DELIMITER //
CREATE PROCEDURE DeleteEntriesByIDMaster(
    IN p_id INT
)
BEGIN
    DELETE FROM siswa WHERE id_siswa = p_id;
END //
DELIMITER ;
CALL DeleteEntriesByIDMaster(22);


-- modul 4

-- menambahkan kolom keterangan pada tbl pembayarna
ALTER TABLE pembayaran ADD COLUMN keterangan TEXT AFTER metode_bayar;

-- gabungan tbl siswa dan pendafatran utk melihat siapa yang mendaftar dan statusnya
SELECT 
    s.nama_siswa, 
    p.id_kelas, 
    p.tanggal_daftar, 
    p.status
FROM siswa s
JOIN pendaftaran p ON s.id_siswa = p.id_siswa;

-- asc 
SELECT * FROM siswa ORDER BY nama_siswa ASC;
-- desc
SELECT * FROM pembayaran ORDER BY jumlah_bayar DESC;


ALTER TABLE siswa MODIFY COLUMN no_telepon VARCHAR(20);

-- left join : semua data dari kelas meski blom ad pendaftaran
SELECT k.nama_kelas, p.id_pendaftaran
FROM kelas k
LEFT JOIN pendaftaran p ON k.id_kelas = p.id_kelas;

-- right join :smua data dari pendaftaran walau tidk smua aktif
SELECT p.id_pendaftaran, k.nama_kelas
FROM kelas k
RIGHT JOIN pendaftaran p ON k.id_kelas = p.id_kelas;

-- self join : membanding kan antar siswa yang alamat nya sama
SELECT s1.nama_siswa AS siswa1, s2.nama_siswa AS siswa2, s1.alamat
FROM siswa s1
JOIN siswa s2 ON s1.alamat = s2.alamat AND s1.id_siswa != s2.id_siswa;

-- 1. Sama dengan
SELECT * FROM siswa WHERE email = 'fajar@gmail.com';

-- 2. Lebih besar dari
SELECT * FROM pembayaran WHERE jumlah_bayar > 800000;

-- 3. Lebih kecil dari atau sama dengan
SELECT * FROM pembayaran WHERE jumlah_bayar <= 850000;

-- 4. Tidak sama dengan
SELECT * FROM pendaftaran WHERE STATUS != 'Aktif';

-- 5. Lebih besar dari atau sama dengan
SELECT * FROM kelas WHERE biaya >= 900000;

