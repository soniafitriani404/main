USE umkm_jawa_barat
-- 1. AddUMKM
DELIMITER //

CREATE PROCEDURE AddUMKM (
    IN p_nama_usaha VARCHAR(200),
    IN p_jumlah_karyawan INT
)
BEGIN
    INSERT INTO umkm (nama_usaha, jumlah_karyawan)
    VALUES (p_nama_usaha, p_jumlah_karyawan);
END //

DELIMITER ;

-- Memanggil stored procedure
CALL AddUMKM("Usaha Baru Saya", 5);
SELECT * FROM umkm

-- Memverifikasi data yang dimasukkan
-- SELECT * FROM umkm ORDER BY id_umkm DESC LIMIT 1;

-- 2. UpdateKategoriUMKM
DELIMITER //
CREATE PROCEDURE UpdateKategoriUMKM (
    IN id_input INT,
    IN nama_baru VARCHAR(100)
)
BEGIN
    UPDATE kategori_umkm
    SET nama_kategori = nama_baru
    WHERE id_kategori = id_input;
END//
DELIMITER ;
-- drop procedure UpdateKategoriUMKM
-- 2. Panggil UpdateKategoriUMKM
CALL UpdateKategoriUMKM(2, 'Makanan');
SELECT * FROM kategori_umkm

-- 3. DeletePemilikUMKM
DELIMITER //

CREATE PROCEDURE DeletePemilikUMKM (
    IN p_id_pemilik INT
)
BEGIN
    DELETE FROM pemilik_umkm 
    WHERE id_pemilik = p_id_pemilik;
END //

DELIMITER ;

-- Cara memanggil procedure
CALL DeletePemilikUMKM(5);

-- Verifikasi data (bukan memanggil procedure sebagai SELECT)
SELECT * FROM pemilik_umkm WHERE id_pemilik = 5;

-- 4. AddProduk
DELIMITER //
CREATE PROCEDURE AddProduk (
    IN id_umkm INT,
    IN nama_produk VARCHAR(100),
    IN harga DECIMAL(10,2)
)
BEGIN
    INSERT INTO produk_umkm (id_umkm, nama_produk, harga)
    VALUES (id_umkm, nama_produk, harga);
END //
DELIMITER ;
-- 4. Panggil AddProduk
CALL AddProduk(1, 'Keripik Singkong', 15000.00);
SELECT * FROM produk_umkm


-- 5. GetUMKMByID
DELIMITER //
CREATE PROCEDURE GetUMKMByID (
    IN id_umkm INT,
    OUT nama_usaha VARCHAR(100),
    OUT jumlah_karyawan INT
)
BEGIN
    SELECT u.nama_usaha, u.jumlah_karyawan
    INTO nama_usaha, jumlah_karyawan
    FROM umkm u
    WHERE u.id_umkm = id_umkm;
END //
DELIMITER ;
-- 5. Panggil GetUMKMByID
SET @nama := '';
SET @jumlah := 0;
CALL GetUMKMByID(1, @nama, @jumlah);

SELECT @nama AS nama_usaha, @jumlah AS jumlah_karyawan;