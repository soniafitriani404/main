DELIMITER //

CREATE PROCEDURE AddUMKM (
    IN p_nama_usaha VARCHAR(200),
    IN p_jumlah_karyawan INT
)
BEGIN
    INSERT INTO umkm (
        nama_usaha, 
        id_pemilik, 
        id_kategori, 
        id_skala, 
        id_kabupaten_kota, 
        alamat_usaha, 
        nib, 
        npwp, 
        tahun_berdiri, 
        jumlah_karyawan, 
        total_aset, 
        omzet_per_tahun, 
        deskripsi_usaha, 
        tanggal_registrasi
    ) VALUES (
        p_nama_usaha,
        441, -- ID pemilik dummy
        1,   -- ID kategori dummy
        111, -- ID skala dummy
        221, -- ID kabupaten/kota dummy
        'Alamat belum diisi',
        NULL,
        NULL,
        YEAR(CURDATE()),
        p_jumlah_karyawan,
        0,
        0,
        'Deskripsi belum tersedia',
        CURDATE()
    );
END //

DELIMITER ;

CALL AddUMKM('Toko Bunga Melati', 5);
