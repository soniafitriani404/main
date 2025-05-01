-- 1: AddUMKM
DELIMITER //
CREATE PROCEDURE AddUMKM (
    IN p_nama_usaha VARCHAR(100),
    IN p_jumlah_karyawan INT
)
BEGIN
    INSERT INTO umkm (nama_usaha, jumlah_karyawan)
    VALUES (p_nama_usaha, p_jumlah_karyawan);
END;
//
DELIMITER ;

-- CALL dan SELECT
CALL AddUMKM('Usaha Baru Jaya', 5);
SELECT * FROM umkm;


-- 2: UpdateKategoriUMKM
DELIMITER //
CREATE PROCEDURE UpdateKategoriUMKM (
    IN p_id_kategori INT,
    IN p_nama_baru VARCHAR(100)
)
BEGIN
    UPDATE kategori_umkm
    SET nama_kategori = p_nama_baru
    WHERE id = p_id_kategori;
END;
//
DELIMITER ;

-- CALL dan SELECT
CALL UpdateKategoriUMKM(1, 'Kuliner Nusantara');
SELECT * FROM kategori_umkm;


-- 3: DeletePemilikUMKM
DELIMITER //
CREATE PROCEDURE DeletePemilikUMKM (
    IN p_id_pemilik INT
)
BEGIN
    DELETE FROM pemilik_umkm
    WHERE id = p_id_pemilik;
END;
//
DELIMITER ;

-- CALL dan SELECT
CALL DeletePemilikUMKM(15);
SELECT * FROM pemilik_umkm;


-- 4: AddProduk
DELIMITER //
CREATE PROCEDURE AddProduk (
    IN p_id_umkm INT,
    IN p_nama_produk VARCHAR(100),
    IN p_harga INT
)
BEGIN
    INSERT INTO produk_umkm (id_umkm, nama_produk, harga)
    VALUES (p_id_umkm, p_nama_produk, p_harga);
END;
//
DELIMITER ;

-- CALL dan SELECT
CALL AddProduk(1, 'Sambel Geprek', 12000);
SELECT * FROM produk_umkm;


-- 5: GetUMKMByID
DELIMITER //
CREATE PROCEDURE GetUMKMByID (
    IN p_id_umkm INT
)
BEGIN
    SELECT * FROM umkm WHERE id = p_id_umkm;
END;
//
DELIMITER ;

-- CALL dan SELECT
CALL GetUMKMByID(1);
