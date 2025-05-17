CREATE DATABASE penjualan_tanaman_hias;

CREATE TABLE kategori (
    id_kategori INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(100),
    keterangan TEXT
);

CREATE TABLE tanaman (
    id_tanaman INT PRIMARY KEY AUTO_INCREMENT,
    nama_tanaman VARCHAR(100),
    jenis VARCHAR(50),
    harga DECIMAL(10,2),
    stok INT,
    deskripsi TEXT,
    id_kategori INT,
    FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategori)
);

CREATE TABLE pelanggan (
    id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
    nama_pelanggan VARCHAR(100),
    alamat TEXT,
    no_hp VARCHAR(15)
);

CREATE TABLE penjualan (
    id_penjualan INT PRIMARY KEY AUTO_INCREMENT,
    id_pelanggan INT,
    tanggal_penjualan DATE,
    total_harga DECIMAL(12,2),
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan)
);

CREATE TABLE detail_penjualan (
    id_detail INT PRIMARY KEY AUTO_INCREMENT,
    id_penjualan INT,
    id_tanaman INT,
    jumlah INT,
    subtotal DECIMAL(12,2),
    FOREIGN KEY (id_penjualan) REFERENCES penjualan(id_penjualan),
    FOREIGN KEY (id_tanaman) REFERENCES tanaman(id_tanaman)
);

INSERT INTO kategori (nama_kategori, keterangan) VALUES
('Tanaman Hias Daun', 'Tanaman yang memiliki keindahan pada daun'),
('Tanaman Bunga', 'Tanaman yang berbunga indah dan berwarna-warni'),
('Kaktus', 'Tanaman berduri dan cocok untuk daerah kering');

INSERT INTO tanaman (nama_tanaman, jenis, harga, stok, deskripsi, id_kategori) VALUES
('Monstera', 'Indoor', 120000.00, 10, 'Tanaman daun besar berlubang, cocok untuk dekorasi ruangan', 1),
('Aglaonema', 'Indoor', 90000.00, 15, 'Tanaman daun hias dengan warna menarik', 1),
('Mawar Merah', 'Outdoor', 15000.00, 30, 'Bunga mawar berwarna merah cerah', 2),
('Kaktus Mini', 'Indoor', 25000.00, 25, 'Kaktus ukuran kecil, cocok untuk meja kerja', 3),
('Lavender', 'Outdoor', 40000.00, 20, 'Tanaman berbunga wangi yang menarik lebah', 2);

INSERT INTO pelanggan (nama_pelanggan, alamat, no_hp) VALUES
('Ayu Lestari', 'Jl. Melati No. 10', '081234567890'),
('Budi Santoso', 'Jl. Kenanga No. 22', '082112345678'),
('Clara Wijaya', 'Jl. Mawar No. 7', '085267890123');

INSERT INTO penjualan (id_pelanggan, tanggal_penjualan, total_harga) VALUES
(1, '2025-04-10', 255000.00),
(2, '2025-04-11', 40000.00),
(3, '2025-04-11', 275000.00);

INSERT INTO detail_penjualan (id_penjualan, id_tanaman, jumlah, subtotal) VALUES
(1, 1, 1, 120000.00),
(1, 3, 3, 45000.00),
(1, 4, 3, 90000.00),
(2, 5, 1, 40000.00),
(3, 2, 1, 90000.00),
(3, 1, 1, 120000.00),
(3, 3, 4, 60000.00);

SELECT * FROM tanaman;
SELECT * FROM kategori;
SELECT * FROM pelanggan;
SELECT * FROM penjualan;
SELECT * FROM detail_penjualan;

-- modul2
#1
CREATE VIEW view_tanaman_dengan_kategori AS
SELECT 
    t.id_tanaman, t.nama_tanaman, t.jenis, t.harga,
    t.stok, k.nama_kategori, k.keterangan
FROM tanaman t
JOIN kategori k ON t.id_kategori = k.id_kategori;

#2
CREATE VIEW view_detail_penjualan_lengkap AS
SELECT 
    dp.id_detail, p.tanggal_penjualan, pl.nama_pelanggan,
    t.nama_tanaman, dp.jumlah, dp.subtotal
FROM detail_penjualan dp
JOIN penjualan p ON dp.id_penjualan = p.id_penjualan
JOIN pelanggan pl ON p.id_pelanggan = pl.id_pelanggan
JOIN tanaman t ON dp.id_tanaman = t.id_tanaman;

#3
CREATE VIEW view_tanaman_stok_rendah AS
SELECT 
    t.id_tanaman, t.nama_tanaman, t.stok,
    k.nama_kategori
FROM tanaman t
JOIN kategori k ON t.id_kategori = k.id_kategori
WHERE t.stok < 10;

#4
CREATE VIEW view_total_penjualan_per_pelanggan AS
SELECT 
    pl.id_pelanggan,
    pl.nama_pelanggan,
    COUNT(p.id_penjualan) AS jumlah_transaksi,
    SUM(p.total_harga) AS total_belanja
FROM pelanggan pl
JOIN penjualan p ON pl.id_pelanggan = p.id_pelanggan
GROUP BY pl.id_pelanggan, pl.nama_pelanggan;

#5
CREATE VIEW view_tanaman_terlaris AS
SELECT 
    t.id_tanaman,
    t.nama_tanaman,
    SUM(dp.jumlah) AS total_terjual
FROM detail_penjualan dp
JOIN tanaman t ON dp.id_tanaman = t.id_tanaman
GROUP BY t.id_tanaman, t.nama_tanaman
ORDER BY total_terjual DESC;

SELECT * FROM view_tanaman_dengan_kategori;
SELECT * FROM view_detail_penjualan_lengkap; 
SELECT * FROM view_tanaman_stok_rendah;
SELECT * FROM view_total_penjualan_per_pelanggan;
SELECT * FROM view_tanaman_terlaris;






-- modul3
-- 1. Stored Procedure untuk Update Data Master
DELIMITER //

CREATE PROCEDURE UpdateDataMaster(IN id INT, IN nilai_baru VARCHAR(100), OUT STATUS INT)
BEGIN
    UPDATE kategori 
    SET nama_kategori = nilai_baru
    WHERE id_kategori = id;
    IF ROW_COUNT() > 0 THEN
        SET STATUS = 1;  -- Operasi berhasil
    ELSE
        SET STATUS = 0;  -- Operasi gagal
    END IF;
END //
DELIMITER ;

SET @status = 0;
CALL UpdateDataMaster(2, 'Tanaman Aesthetic', @status);
SELECT @status; -- hasilnya 1 jika berhasil

SELECT * FROM kategori;

-- 2. Stored Procedure untuk Count Transaksi
DELIMITER //

CREATE PROCEDURE CountTransaksi(OUT total_transaksi INT)
BEGIN
    -- Menghitung jumlah total entri dalam tabel penjualan
    SELECT COUNT(*) INTO total_transaksi FROM penjualan;
END //

DELIMITER ;

-- CALL untuk CountTransaksi
SET @total_transaksi = 0;
CALL CountTransaksi(@total_transaksi);
SELECT @total_transaksi AS jumlah_transaksi;


-- #3. Stored Procedure untuk Get Data Master By ID
DELIMITER //

CREATE PROCEDURE GetDataMasterByID(IN id INT, OUT kategori_name VARCHAR(100), OUT kategori_desc TEXT)
BEGIN
    SELECT nama_kategori, keterangan INTO kategori_name, kategori_desc
    FROM kategori
    WHERE id_kategori = id;
END //

DELIMITER ;

-- CALL untuk GetDataMasterByID
SET @nama_kategori = '';
SET @keterangan = '';
CALL GetDataMasterByID(1, @nama_kategori, @keterangan);
SELECT @nama_kategori AS nama_kategori, @keterangan AS keterangan;

-- #4. Stored Procedure untuk Update Field Transaksi
DELIMITER //

CREATE PROCEDURE UpdateFieldTransaksi(IN id INT, INOUT field1 DECIMAL(12,2), INOUT field2 DECIMAL(12,2))
BEGIN
    IF field1 IS NOT NULL THEN
        UPDATE penjualan
        SET total_harga = field1
        WHERE id_penjualan = id;
    END IF;
    IF field2 IS NOT NULL THEN
        UPDATE penjualan
        SET total_harga = field2
        WHERE id_penjualan = id;
    END IF;
END //

DELIMITER ;

-- CALL untuk UpdateFieldTransaksi
SET @total_baru = 200000.00;
SET @tanggal_baru = NULL;
CALL UpdateFieldTransaksi(1, @total_baru, @tanggal_baru);
SELECT * FROM penjualan WHERE id_penjualan = 1;

-- #5. Stored Procedure untuk Delete Entries By ID Master
DELIMITER //

CREATE PROCEDURE DeleteKategoriByID(IN p_id_kategori INT)
BEGIN
    -- Hapus data terkait di tabel tanaman
    DELETE FROM tanaman WHERE id_kategori = p_id_kategori;

    -- Hapus data kategori
    DELETE FROM kategori WHERE id_kategori = p_id_kategori;
END //

DELIMITER ;

-- Contoh pemanggilan prosedur
CALL DeleteKategoriByID(3);

SELECT * FROM kategori;

-- modul4
-- 1. Kolom Keterangan di Salah Satu Tabel pada Bagian Akhir Tabel
ALTER TABLE penjualan ADD COLUMN keterangan TEXT;

SELECT * FROM penjualan;

-- 2. Gabungan 2 Tabel yang Memungkinkan dan Memiliki Fungsi pada Penerapannya
SELECT p.id_penjualan, p.tanggal_penjualan, p.total_harga, pl.nama_pelanggan, pl.no_hp
FROM penjualan p
JOIN pelanggan pl ON p.id_pelanggan = pl.id_pelanggan;

-- 3. Urutan Kolom pada Setiap Tabel Menggunakan Perintah ORDER BY, DESC, dan ASC
SELECT * FROM tanaman
ORDER BY harga ASC;

SELECT * FROM penjualan
ORDER BY tanggal_penjualan DESC;

-- 4. Perubahan pada Salah Satu Tipe Data 
ALTER TABLE pelanggan MODIFY COLUMN no_hp VARCHAR(20);

SELECT * FROM pelanggan;

-- 5. Kode LEFT JOIN, RIGHT JOIN, dan SELF JOIN Beserta dengan Alur Prosesnya
SELECT p.id_penjualan, p.tanggal_penjualan, p.total_harga, pl.nama_pelanggan
FROM penjualan p
LEFT JOIN pelanggan pl ON p.id_pelanggan = pl.id_pelanggan;

SELECT t.id_tanaman, t.nama_tanaman, t.harga, dp.id_penjualan
FROM tanaman t
RIGHT JOIN detail_penjualan dp ON t.id_tanaman = dp.id_tanaman;

SELECT t1.id_tanaman AS Tanaman1, t2.id_tanaman AS Tanaman2
FROM tanaman t1, tanaman t2
WHERE t1.id_kategori = t2.id_kategori AND t1.id_tanaman != t2.id_tanaman;

-- 6. Kode yang Mengandung Operator Perbandingan (Minimal 5)
SELECT * FROM tanaman WHERE harga > 100;

SELECT * FROM pelanggan WHERE no_hp IS NULL;

SELECT * FROM penjualan WHERE total_harga >= 500;

SELECT * FROM tanaman WHERE jenis != 'Cactus';

SELECT * FROM detail_penjualan WHERE jumlah < 5;
