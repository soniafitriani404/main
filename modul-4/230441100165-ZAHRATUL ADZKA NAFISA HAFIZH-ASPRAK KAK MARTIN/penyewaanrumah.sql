-- ============================= 
-- MODUL 1: DATABASE, TABLES, & INSERT DATA 
-- ============================= 

-- Membuat database PenyewaanRumah dan menggunakannya
CREATE DATABASE IF NOT EXISTS penyewaanrumah;
USE penyewaanrumah;

-- Drop database PenyewaanRumah (hati-hati, akan menghapus semua data)
DROP DATABASE IF EXISTS PenyewaanRumah;

-- Tabel Pemilik
CREATE TABLE IF NOT EXISTS Pemilik (
    id_pemilik INT PRIMARY KEY,
    nama_pemilik VARCHAR(255) NOT NULL,
    no_hp VARCHAR(20) NOT NULL, -- Menggunakan VARCHAR karena nomor telepon bisa mengandung tanda "-"
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Tabel Kompleks
CREATE TABLE IF NOT EXISTS Kompleks (
    id_kompleks INT PRIMARY KEY,
    nama_kompleks VARCHAR(100) NOT NULL,
    alamat VARCHAR(255) NOT NULL
);

-- Tabel Rumah
CREATE TABLE IF NOT EXISTS Rumah (
    id_rumah INT PRIMARY KEY,
    alamat VARCHAR(255) NOT NULL,
    tipe VARCHAR(50) NOT NULL,
    harga_sewa DECIMAL(10,2) NOT NULL, -- Memperbaiki tipe harga sewa menjadi DECIMAL
    sts ENUM('Tersedia', 'Tidak Tersedia') DEFAULT 'Tersedia',
    id_pemilik INT NOT NULL,
    id_kompleks INT,
    FOREIGN KEY (id_pemilik) REFERENCES Pemilik(id_pemilik),
    FOREIGN KEY (id_kompleks) REFERENCES Kompleks(id_kompleks)
);

-- Tabel Penyewa
CREATE TABLE IF NOT EXISTS Penyewa (
    id_penyewa INT PRIMARY KEY,
    nama_penyewa VARCHAR(255) NOT NULL,
    no_ktp VARCHAR(20) UNIQUE NOT NULL,
    no_hp VARCHAR(15) NOT NULL,
    pekerjaan VARCHAR(100)
);

-- Tabel Penyewaan
CREATE TABLE IF NOT EXISTS Penyewaan (
    id_penyewaan INT PRIMARY KEY,
    id_rumah INT NOT NULL,
    id_penyewa INT NOT NULL,
    tanggal_mulai DATE NOT NULL,
    tanggal_selesai DATE NOT NULL,
    sts ENUM('Aktif', 'Selesai') DEFAULT 'Aktif',
    keterangan VARCHAR(255), -- Menambahkan kolom keterangan
    FOREIGN KEY (id_rumah) REFERENCES Rumah(id_rumah),
    FOREIGN KEY (id_penyewa) REFERENCES Penyewa(id_penyewa)
);

-- Tabel Pembayaran
CREATE TABLE IF NOT EXISTS Pembayaran (
    id_pembayaran INT PRIMARY KEY,
    id_penyewaan INT NOT NULL,
    tanggal_bayar DATE NOT NULL,
    jumlah_bayar DECIMAL(10,2) NOT NULL, -- Menggunakan DECIMAL untuk presisi pembayaran
    metode_pembayaran ENUM('Transfer Bank', 'Tunai', 'E-Wallet') NOT NULL,
    FOREIGN KEY (id_penyewaan) REFERENCES Penyewaan(id_penyewaan)
);

-- Tabel Fasilitas
CREATE TABLE IF NOT EXISTS Fasilitas (
    id_fasilitas INT PRIMARY KEY,
    nama_fasilitas VARCHAR(100),
    deskripsi TEXT
);

-- Menyisipkan data pemilik
INSERT INTO Pemilik (id_pemilik, nama_pemilik, no_hp, email) VALUES
(1, 'Budi Santoso', '081234567890', 'budi@example.com'),
(2, 'Siti Aminah', '082345678901', 'siti@example.com'),
(3, 'Agus Prabowo', '081298765432', 'agus@example.com'),
(4, 'Dewi Kartika', '085612345678', 'dewi@example.com'),
(5, 'Rudi Hartono', '089912345678', 'rudi@example.com'),
(6, 'Lina Maharani', '087712345678', 'lina@example.com');

-- Menyisipkan data kompleks
INSERT INTO Kompleks (id_kompleks, nama_kompleks, alamat) VALUES
(1, 'Kompleks Melati Indah', 'Jl. Melati Raya'),
(2, 'Kompleks Mawar Asri', 'Jl. Mawar Utama'),
(3, 'Kompleks Dahlia Sejahtera', 'Jl. Dahlia Raya');

-- Menyisipkan data rumah
INSERT INTO Rumah (id_rumah, alamat, tipe, harga_sewa, sts, id_pemilik, id_kompleks) VALUES
(1, 'Jl. Melati No. 5', 'Tipe 36', 15000000, 'Tersedia', 1, 1),
(2, 'Jl. Mawar No. 10', 'Tipe 45', 20000000, 'Tidak Tersedia', 2, 2),
(3, 'Jl. Anggrek No. 8', 'Tipe 60', 2500000, 'Tersedia', 1, 1),
(4, 'Jl. Kenanga No. 3', 'Tipe 70', 3000000, 'Tersedia', 3, 3),
(5, 'Jl. Dahlia No. 12', 'Tipe 36', 1400000, 'Tidak Tersedia', 4, 3),
(6, 'Jl. Bougenville No. 7', 'Tipe 90', 3500000, 'Tersedia', 5, 2),
(7, 'Jl. Flamboyan No. 9', 'Tipe 45', 2200000, 'Tersedia', 2, 1),
(8, 'Jl. Teratai No. 11', 'Tipe 36', 1600000, 'Tersedia', 3, 2);

-- Menyisipkan data penyewa
INSERT INTO Penyewa (id_penyewa, nama_penyewa, no_ktp, no_hp, pekerjaan) VALUES
(1, 'Andi Wijaya', '3271012345678901', '089876543210', 'Karyawan Swasta'),
(2, 'Rina Lestari', '3271098765432109', '087654321098', 'Guru'),
(3, 'Eko Nugroho', '3201123456789001', '081311223344', 'Wiraswasta'),
(4, 'Maya Sari', '3271065432109876', '082233445566', 'Dosen'),
(5, 'Tono Rahman', '3271054321098765', '085266778899', 'Mahasiswa');

-- Menyisipkan data fasilitass
INSERT INTO Fasilitas (id_fasilitas, nama_fasilitas, deskripsi) VALUES
(1, 'Kolam Renang', 'Kolam renang umum di tengah kompleks'),
(2, 'Taman Bermain', 'Area bermain untuk anak-anak'),
(3, 'Keamanan 24 Jam', 'Penjagaan dan CCTV'),
(4, 'Tempat Parkir', 'Area parkir luas untuk penghuni'),
(5, 'Lapangan Olahraga', 'Lapangan multifungsi untuk olahraga');

-- Menyisipkan data penyewaan
INSERT INTO Penyewaan (id_penyewaan, id_rumah, id_penyewa, tanggal_mulai, tanggal_selesai, sts) VALUES
(1, 1, 1, '2025-01-01', '2025-06-01', 'Selesai'),
(2, 3, 2, '2025-03-01', '2025-09-01', 'Aktif'),
(3, 5, 3, '2025-02-01', '2025-07-01', 'Aktif'),
(4, 6, 4, '2025-03-01', '2025-09-01', 'Aktif'),
(5, 7, 5, '2025-04-01', '2025-10-01', 'Aktif');

-- Menyisipkan data pembayaran
INSERT INTO Pembayaran (id_pembayaran, id_penyewaan, tanggal_bayar, jumlah_bayar, metode_pembayaran) VALUES
(1, 1, '2025-01-01', 2000000, 'Transfer Bank'),
(2, 1, '2025-02-01', 2000000, 'E-Wallet'),
(3, 2, '2025-04-01', 2500000, 'Tunai'),
(4, 3, '2025-02-01', 1400000, 'Transfer Bank'),
(5, 4, '2025-03-01', 3500000, 'E-Wallet'),
(6, 5, '2025-04-10', 2200000, 'Tunai');

-- =============================
-- MODUL 2: VIEW-VIEW
-- =============================

-- View 1: Gabungan minimal 2 tabel
CREATE VIEW view_penyewa_rumah AS
SELECT py.nama_penyewa, r.alamat, r.tipe
FROM Penyewa py
JOIN Penyewaan p ON py.id_penyewa = p.id_penyewa
JOIN Rumah r ON p.id_rumah = r.id_rumah;

-- View 2: Gabungan minimal 3 tabel
CREATE VIEW view_detail_penyewaan AS
SELECT py.nama_penyewa, r.alamat, pm.jumlah_bayar, pm.metode_pembayaran
FROM Penyewa py
JOIN Penyewaan p ON py.id_penyewa = p.id_penyewa
JOIN Pembayaran pm ON p.id_penyewaan = pm.id_penyewaan
JOIN Rumah r ON p.id_rumah = r.id_rumah;

-- View 3: Dengan syarat tertentu
CREATE VIEW view_rumah_mahal AS
SELECT id_rumah, alamat, harga_sewa
FROM Rumah
WHERE harga_sewa > 1500000;

-- View 4: Agregasi Total Pembayaran per Penyewa
CREATE VIEW view_total_transaksi_pembayaran AS
SELECT 
    py.nama_penyewa,
    COUNT(pm.id_pembayaran) AS jumlah_transaksi,
    SUM(pm.jumlah_bayar) AS total_pembayaran,
    AVG(pm.jumlah_bayar) AS rata_rata_pembayaran,
    MAX(pm.jumlah_bayar) AS pembayaran_tertinggi,
    MIN(pm.jumlah_bayar) AS pembayaran_terendah
FROM Penyewa py
JOIN Penyewaan p ON py.id_penyewa = p.id_penyewa
JOIN Pembayaran pm ON p.id_penyewaan = pm.id_penyewaan
GROUP BY py.nama_penyewa;

-- View 5: Statistik rumah per kompleks
CREATE VIEW view_statistik_rumah_per_kompleks AS
SELECT k.nama_kompleks, COUNT(r.id_rumah) AS jumlah_rumah, AVG(r.harga_sewa) AS rata_harga_sewa
FROM Kompleks k
JOIN Rumah r ON k.id_kompleks = r.id_kompleks
GROUP BY k.nama_kompleks;








	-- ============================= 
	-- MODUL 3: PROCEDURE
	-- ============================= 

	-- 1. Buatlah stored procedure UpdateDataMaster yang menerima parameter id
	-- (IN) dan nilai_baru (IN) untuk memperbarui nilai tertentu dalam tabel
	-- master di database Anda, dan mengembalikan status operasi melalui
	-- parameter OUT.
	-- (Procedure untuk Update Data Master)
	DELIMITER $$

	CREATE PROCEDURE UpdatePemilikByID(
	    IN id INT,               
	    IN nilai_baru VARCHAR(100), 
	    OUT STATUS VARCHAR(50)    
	)
	BEGIN
	    DECLARE rowCount INT;

	    -- Update data pada tabel Pemilik
	    UPDATE Pemilik
	    SET nama_pemilik = nilai_baru
	    WHERE id_pemilik = id;

	    SELECT ROW_COUNT() INTO rowCount;

	    IF rowCount > 0 THEN
		SET STATUS = 'Data berhasil diperbarui';
	    ELSE
		SET STATUS = 'Tidak ada data yang diperbarui';
	    END IF;
	END $$

	DELIMITER ;
	
	CALL UpdatePemilikByID(1, 'adzka', '0812345678444', 'adzkaa@gmail.com');
	CALL UpdatePemilikByID(2, 'Siti Aminah', '081234567891', 'siti@gmail.com');
	CALL UpdatePemilikByID(3, 'Agus Prabowo', '081234567892', 'agus@gmail.com');
	CALL UpdatePemilikByID(4, 'Dewi Kartika', '081234777893', 'dewi@gmail.com');
	CALL UpdatePemilikByID(5, 'Rudi Hartono', '081234563817', 'rudi@gmail.com');
	
	
	
	SELECT * FROM Pemilik WHERE id_pemilik = 1;
	SELECT * FROM Pemilik WHERE id_pemilik IN (1, 2, 3, 4, 5, 6);

	DROP PROCEDURE IF EXISTS UpdateDataMaster

	-- 2. Buatlah stored procedure CountTransaksi yang tidak menerima parameter
        -- dan mengembalikan jumlah total entri yang terdaftar di tabel transaksi di
	-- database Anda melalui parameter OUT.
	-- (Procedure untuk Menghitung Pembayaran Sewa)
	DELIMITER $$

	CREATE PROCEDURE HitungPembayaranSewa(
	    IN id_penyewa INT,
	    OUT total_bayar DECIMAL(10,2)
	)
	BEGIN
	    SELECT SUM(jumlah_bayar) 
	    INTO total_bayar
	    FROM Pembayaran 
	    WHERE id_penyewaan IN (SELECT id_penyewaan FROM Penyewaan WHERE id_penyewa = id_penyewa);
	END $$

	DELIMITER ;

	SET @total_transaksi = 0;  -- Inisialisasi variabel untuk menyimpan hasil
	CALL CountTransaksi(@total_transaksi);  -- Memanggil prosedur
	SELECT @total_transaksi AS TotalTransaksi;

	-- 3. Buatlah stored procedure GetDataMasterByID yang menerima parameter id
	-- (IN) dan mengembalikan data dari tabel master terkait berdasarkan ID
	-- tersebut melalui parameter OUT.
	-- (Procedure untuk Menghapus Penyewa)
	DELIMITER $$

	CREATE PROCEDURE HapusPenyewa(
	    IN id_penyewa INT,
	    OUT status_message VARCHAR(255)
	)
	BEGIN
	    DELETE FROM Penyewa WHERE id_penyewa = id_penyewa;

	    IF ROW_COUNT() > 0 THEN
		SET status_message = 'Penyewa berhasil dihapus';
	    ELSE
		SET status_message = 'Penyewa tidak ditemukan';
	    END IF;
	END $$

	DELIMITER ;


	-- 4. Buatlah stored procedure UpdateFieldTransaksi yang menerima parameter
	-- id (IN), field1 (INOUT), dan field2 (INOUT) untuk memperbarui nilai dari
	-- dua kolom dalam tabel transaksi berdasarkan ID yang diberikan. Jika field1
	-- atau field2 kosong, maka tetap gunakan nilai yang ada di database Anda.
	-- (Stored Procedure UpdateFieldTransaksi)
	DELIMITER $$

	CREATE PROCEDURE UpdateStatusRumah(
	    IN id_rumah INT,
	    IN status_baru ENUM('Tersedia', 'Tidak Tersedia'),
	    OUT status_message VARCHAR(255)
	)
	BEGIN
	    UPDATE Rumah
	    SET sts = status_baru
	    WHERE id_rumah = id_rumah;

	    IF ROW_COUNT() > 0 THEN
		SET status_message = 'Status rumah berhasil diperbarui';
	    ELSE
		SET status_message = 'Rumah tidak ditemukan';
	    END IF;
	END $$

	DELIMITER ;


	-- 5.Buatlah stored procedure DeleteEntriesByIDMaster yang menerima
	-- parameter id (IN) dan menghapus entri yang terkait berdasarkan ID tersebut
	-- dari tabel master di database Anda. 
	-- (Stored Procedure DeleteEntriesByIDMaster)
	DELIMITER $$

	CREATE PROCEDURE TambahPembayaran(
	    IN id_penyewaan INT,
	    IN jumlah_bayar DECIMAL(10,2),
	    IN metode_pembayaran ENUM('Transfer Bank', 'Tunai', 'E-Wallet'),
	    OUT status_message VARCHAR(255)
	)
	BEGIN
	    INSERT INTO Pembayaran (id_penyewaan, tanggal_bayar, jumlah_bayar, metode_pembayaran)
	    VALUES (id_penyewaan, CURDATE(), jumlah_bayar, metode_pembayaran);

	    IF ROW_COUNT() > 0 THEN
		SET status_message = 'Pembayaran berhasil ditambahkan';
	    ELSE
		SET status_message = 'Pembayaran gagal ditambahkan';
	    END IF;
	END $$

	DELIMITER ;


	
	-- Contoh 1 	 
	-- Menjalankan CountTransaksi
	CALL CountTransaksi(@total_transaksi);
	SELECT @total_transaksi AS TotalTransaksi;

	
	
	-- Contoh 2 :
	-- Menjalankan CountTransaksi
	CALL CountTransaksi(@total_transaksi);
	SELECT @total_transaksi AS TotalTransaksi;

	
	
	-- Contoh 3 :	
	-- Menjalankan GetDataMasterByID
	CALL GetDataMasterByID(1, @kolom_data);
	SELECT @kolom_data AS DataMaster;

	
	
	-- Contoh 4 :
	
	-- Menjalankan UpdateFieldTransaksi
	SET @field1 = 'Field1 Updated';
	SET @field2 = 'Field2 Updated';
	CALL UpdateFieldTransaksi(1, @field1, @field2);
	SELECT @field1 AS Field1, @field2 AS Field2;

	
	
	
	
	-- Contoh 5 :
	-- Menjalankan DeleteEntriesByIDMaster
	CALL DeleteEntriesByIDMaster(1, @status);
	SELECT @status AS StatusOperasi;
















	-- =============================
	-- MODUL 4 DDL,DML,DCL
	-- =============================




	-- 1. Kolom Keterangan di Salah Satu Tabel pada Bagian Akhir Tabel Tersebut
	-- Menambahkan kolom 'keterangan' setelah kolom 'sts' pada tabel Penyewaan
	ALTER TABLE Penyewaan
	ADD COLUMN keterangan VARCHAR(255) AFTER sts;


	-- 2. Gabungan 2 Tabel yang Memungkinkan dan Memiliki Fungsi pada Penerapannya
	-- Menggabungkan tabel Penyewa dan Penyewaan berdasarkan id_penyewa
	SELECT py.nama_penyewa, p.tanggal_mulai, p.tanggal_selesai
	FROM Penyewa py
	JOIN Penyewaan p ON py.id_penyewa = p.id_penyewa;


	-- 3. Urutan Kolom pada Setiap Tabel Menggunakan Perintah ORDER BY, DESC, dan ASC
	-- Mengurutkan data berdasarkan 'tanggal_selesai' secara Ascending (ASC)
	SELECT id_penyewaan, tanggal_mulai, tanggal_selesai
	FROM Penyewaan
	ORDER BY tanggal_selesai ASC;

	-- Mengurutkan data berdasarkan 'harga_sewa' secara Descending (DESC)
	SELECT id_rumah, alamat, harga_sewa
	FROM Rumah
	ORDER BY harga_sewa DESC;


	-- 4. Perubahan pada Salah Satu Tipe Data yang Dapat Berguna
	-- Mengubah tipe data kolom 'harga_sewa' menjadi DECIMAL(10,2)
	ALTER TABLE Rumah
	MODIFY COLUMN harga_sewa DECIMAL(10,2);


	-- 5. Kode LEFT JOIN, RIGHT JOIN, dan SELF JOIN Beserta dengan Alur Prosesnya
	-- LEFT JOIN: Mengambil semua data dari Penyewa dan data Penyewaan yang cocok, jika ada
	SELECT py.id_penyewa, py.nama_penyewa, p.tanggal_mulai
	FROM Penyewa py
	LEFT JOIN Penyewaan p ON py.id_penyewa = p.id_penyewa;

	-- RIGHT JOIN: Mengambil semua data dari Penyewaan dan data Penyewa yang cocok, jika ada
	SELECT p.id_penyewaan, p.tanggal_mulai, py.nama_penyewa
	FROM Penyewaan p
	RIGHT JOIN Penyewa py ON p.id_penyewa = py.id_penyewa;

	-- SELF JOIN: Menghubungkan data dalam tabel Penyewa berdasarkan hubungan atasan dan bawahan
	SELECT a.id_penyewa AS id_atasan, b.id_penyewa AS id_bawahan, a.nama_penyewa AS nama_atasan, b.nama_penyewa AS nama_bawahan
	FROM Penyewa a
	JOIN Penyewa b ON a.id_penyewa = b.id_penyewa; -- Misalnya menggunakan hubungan tertentu antara Penyewa

	-- 6. Kode yang Mengandung Operator Perbandingan (Minimal 5)
	-- 1. Operator = : Mencari Penyewa dengan nama yang sama dengan 'Andi Wijaya'
	SELECT id_penyewa, nama_penyewa
	FROM Penyewa
	WHERE nama_penyewa = 'Andi Wijaya';

	-- 2. Operator <> (Not Equal): Mencari Penyewa yang namanya bukan 'Rina Lestari'
	SELECT id_penyewa, nama_penyewa
	FROM Penyewa
	WHERE nama_penyewa <> 'Rina Lestari';

	-- 3. Operator > : Mencari rumah dengan harga sewa lebih besar dari 2.000.000
	SELECT id_rumah, alamat, harga_sewa
	FROM Rumah
	WHERE harga_sewa > 2000000;

	-- 4. Operator < : Mencari rumah dengan harga sewa kurang dari 3.000.000
	SELECT id_rumah, alamat, harga_sewa
	FROM Rumah
	WHERE harga_sewa < 3000000;

	-- 5. Operator BETWEEN : Mencari rumah dengan harga sewa antara 1.500.000 dan 3.000.000
	SELECT id_rumah, alamat, harga_sewa
	FROM Rumah
	WHERE harga_sewa BETWEEN 1500000 AND 3000000;


