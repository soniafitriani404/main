-- Gunakan database UMKM
USE umkm_db;

-- =======================
-- No 1: Tambah data UMKM
-- =======================
DELIMITER //

CREATE PROCEDURE AddUMKM (
    IN p_nama_usaha VARCHAR(200),
    IN p_jumlah_karyawan INT,
    IN p_tahun_berdiri YEAR
)
BEGIN
    INSERT INTO umkm (nama_usaha, jumlah_karyawan, tahun_berdiri)
    VALUES (p_nama_usaha, p_jumlah_karyawan, p_tahun_berdiri);
END //

DELIMITER ;

-- Tambah contoh data
CALL AddUMKM('Kopi Warung Kita', 5, 2019);
CALL AddUMKM('OB', 10, 2020);

SELECT * FROM umkm;

-- ===============================
-- No 2: Update nama kategori UMKM
-- ===============================
DELIMITER //

CREATE PROCEDURE UpdateKategoriUMKM (
    IN p_id_kategori INT,
    IN p_nama_baru VARCHAR(100)
)
BEGIN
    UPDATE kategori_umkm
    SET nama_kategori = p_nama_baru
    WHERE id_kategori = p_id_kategori;
END //

DELIMITER ;

-- Uji update kategori
CALL UpdateKategoriUMKM(3, 'Kerajinan Tangan');
SELECT * FROM kategori_umkm;

-- ======================================
-- No 3: Hapus pemilik dan data UMKM-nya
-- ======================================
DROP PROCEDURE IF EXISTS DeletePemilikUMKM;
DELIMITER //

CREATE PROCEDURE DeletePemilikUMKM (
    IN p_id_pemilik INT
)
BEGIN
    DELETE FROM umkm WHERE id_pemilik = p_id_pemilik;
    DELETE FROM pemilik_umkm WHERE id = p_id_pemilik;
END //

DELIMITER ;

-- Uji hapus pemilik
CALL DeletePemilikUMKM(5);
SELECT * FROM pemilik_umkm;

-- =============================
-- No 4: Tambahkan produk UMKM
-- =============================
DELIMITER //

CREATE PROCEDURE AddProduk (
    IN p_id_umkm INT,
    IN p_nama_produk VARCHAR(200),
    IN p_harga DECIMAL(15,2)
)
BEGIN
    INSERT INTO produk_umkm (id_umkm, nama_produk, harga)
    VALUES (p_id_umkm, p_nama_produk, p_harga);
END //

DELIMITER ;

-- Tambahkan contoh produk
CALL AddProduk(2, 'Keripik Pisang', 15000.00);
SELECT * FROM produk_umkm;

-- ============================================
-- No 5: Ambil data UMKM berdasarkan ID (OUT)
-- ============================================
DELIMITER //

DROP PROCEDURE IF EXISTS GetUMKMByID;
DELIMITER //

CREATE PROCEDURE GetUMKMByID (
    IN p_id INT,
    OUT p_nama_usaha VARCHAR(200),
    OUT p_jumlah_karyawan INT,
    OUT p_tahun_berdiri YEAR
)
BEGIN
    SELECT 
        nama_usaha, 
        jumlah_karyawan, 
        tahun_berdiri
    INTO 
        p_nama_usaha, 
        p_jumlah_karyawan, 
        p_tahun_berdiri
    FROM umkm
    WHERE id = p_id;
END //

DELIMITER ;


-- Menggunakan OUT parameters
SET @nama := '';
SET @karyawan := 0;
SET @tahun := 0;

-- Tampilkan kolom hasil OUT
CALL GetUMKMByID(2, @nama, @karyawan, @tahun);

-- Tampilkan hasil
SELECT @nama AS Nama_Usaha, @karyawan AS Jumlah_Karyawan, @tahun AS Tahun_Berdiri;
