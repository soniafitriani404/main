DELIMITER //

CREATE PROCEDURE AddUMKM (
    IN p_nama_usaha VARCHAR(200),
    IN p_jumlah_karyawan INT
)
BEGIN
    INSERT INTO umkm (
        nama_usaha,
        jumlah_karyawan,
        tanggal_registrasi
    ) VALUES (
        p_nama_usaha,
        p_jumlah_karyawan,
        CURDATE()
    );
END //

DELIMITER ;

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

DELIMITER //

CREATE PROCEDURE DeletePemilikUMKM (
    IN p_id_pemilik INT
)
BEGIN
    DELETE FROM pemilik_umkm
    WHERE id_pemilik = p_id_pemilik;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE AddProduk (
    IN p_id_umkm INT,
    IN p_nama_produk VARCHAR(200),
    IN p_harga DECIMAL(15,2)
)
BEGIN
    INSERT INTO produk_umkm (
        id_umkm,
        nama_produk,
        harga
    ) VALUES (
        p_id_umkm,
        p_nama_produk,
        p_harga
    );
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetUMKMByID (
    IN p_id_umkm INT
)
BEGIN
    SELECT * FROM umkm
    WHERE id_umkm = p_id_umkm;
END //

DELIMITER ;
