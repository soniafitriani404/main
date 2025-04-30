USE umkm;
USE penyewaanrumah;

-- DATABASE: umkm

-- 1. AddUMKM
DELIMITER //
CREATE PROCEDURE AddUMKM (
	IN nama_usaha VARCHAR(50),
	IN jumlah_karyawan INT
)
BEGIN
	INSERT INTO umkm (
		nama_usaha, id_pemilik, id_kategori, id_skala, id_kabupaten_kota,
		alamat_usaha, nib, npwp, tahun_berdiri, jumlah_karyawan,
		total_aset, omzet_per_tahun, deskripsi_usaha, tanggal_registrasi
	) VALUES (
		nama_usaha, 1, 1, 3, 4,
		'Jombang', '9120001234567', '09.876.543.2-123.000', 2019, jumlah_karyawan,
		35000000, 250000000, 'pecel wenakk', '2023-03-15'
	);
END //
DELIMITER ;
CALL AddUMKM('Pecel Mbok', 10);


-- 2. UpdateKategoriUMKM
DELIMITER //
CREATE PROCEDURE UpdateKategoriUMKM (
	IN param_id_kategori INT,
	IN nama_baru VARCHAR(45)
)
BEGIN
	UPDATE kategori_umkm
	SET nama_kategori = nama_baru
	WHERE id_kategori = param_id_kategori;
END //
DELIMITER ;

CALL UpdateKategoriUMKM(2, 'Kuliner Baru');


-- 3. DeletePemilikUMKM
DELIMITER //
CREATE PROCEDURE DeletePemilikUMKM (
	IN p_id_pemilik INT
)
BEGIN
	DELETE FROM umkm
	WHERE id_pemilik = p_id_pemilik;

	DELETE FROM pemilik_umkm
	WHERE id_pemilik = p_id_pemilik;
END //
DELIMITER ;

 CALL DeletePemilikUMKM(5);


-- 4. AddProduk
DELIMITER //
CREATE PROCEDURE AddProduk (
	IN id_umkm INT,
	IN nama_produk VARCHAR(45),
	IN harga INT
)
BEGIN
	INSERT INTO produk_umkm (
		id_umkm, nama_produk, deskripsi_produk, harga
	) VALUES (
		id_umkm, nama_produk, 'Sambel hejo dengan tingkat kepedasan rendah', harga
	);
END //
DELIMITER ;

CALL AddProduk(1, 'Sambel Hejo', 15000);


-- 5. GetUMKMByID
DELIMITER //
CREATE PROCEDURE GetUMKMByID (
	IN param_id_umkm INT,
	OUT nama_umkm VARCHAR(100)
)
BEGIN
	SELECT nama_usaha
	INTO nama_umkm
	FROM umkm
	WHERE id_umkm = param_id_umkm;
END //
DELIMITER ;

CALL GetUMKMByID(2, @nama);
SELECT @nama;














-- DATABASE: penyewaanrumah


-- 1. UpdateDataMaster
DELIMITER //
CREATE PROCEDURE UpdateDataMaster (
	IN p_id_pemilik INT,
	IN p_no_hp_baru VARCHAR(20),
	OUT status_out VARCHAR(100)
)
BEGIN
	UPDATE pemilik
	SET no_hp = p_no_hp_baru
	WHERE id_pemilik = p_id_pemilik;

	SET status_out = 'Sukses Update';
END //
DELIMITER ;

CALL UpdateDataMaster(1, '08123456789', @status);
SELECT @status;


-- 2. CountTransaksi
DELIMITER //
CREATE PROCEDURE CountTransaksi (
	OUT jumlah_transaksi INT
)
BEGIN
	SELECT COUNT(*)
	INTO jumlah_transaksi
	FROM penyewaan;
END //
DELIMITER ;
CALL CountTransaksi(@jumlah);
SELECT @jumlah;


-- 3. GetDataMasterByID
DELIMITER //
CREATE PROCEDURE GetDataMasterByID (
	IN p_id_pemilik INT,
	OUT p_nama VARCHAR(255),
	OUT p_no_hp VARCHAR(20),
	OUT p_email VARCHAR(100)
)
BEGIN
	SELECT nama_pemilik, no_hp, email
	INTO p_nama, p_no_hp, p_email
	FROM pemilik
	WHERE id_pemilik = p_id_pemilik;
END //
DELIMITER ;

CALL GetDataMasterByID(1, @nama, @nohp, @email);
SELECT @nama, @nohp, @email;


-- 4. UpdateFieldTransaksi
DELIMITER //
CREATE PROCEDURE UpdateFieldTransaksi (
	IN p_id_penyewaan INT,
	IN p_tanggal_mulai DATE,
	IN p_tanggal_selesai DATE
)
BEGIN
	UPDATE penyewaan
	SET tanggal_mulai = p_tanggal_mulai,
		tanggal_selesai = p_tanggal_selesai
	WHERE id_penyewaan = p_id_penyewaan;
END //
DELIMITER ;

 CALL UpdateFieldTransaksi(2, '2025-05-01', '2025-06-01');


-- 5. DeleteEntriesByIDMaster
DELIMITER //
CREATE PROCEDURE DeleteEntriesByIDMaster (
	IN p_id_pemilik INT
)
BEGIN
	DELETE pembayaran
	FROM pembayaran
	JOIN penyewaan ON pembayaran.id_penyewaan = penyewaan.id_penyewaan
	JOIN rumah ON penyewaan.id_rumah = rumah.id_rumah
	WHERE rumah.id_pemilik = p_id_pemilik;

	DELETE penyewaan
	FROM penyewaan
	JOIN rumah ON penyewaan.id_rumah = rumah.id_rumah
	WHERE rumah.id_pemilik = p_id_pemilik;

	DELETE FROM rumah
	WHERE id_pemilik = p_id_pemilik;

	DELETE FROM pemilik
	WHERE id_pemilik = p_id_pemilik;
END //
DELIMITER ;

CALL DeleteEntriesByIDMaster(3);