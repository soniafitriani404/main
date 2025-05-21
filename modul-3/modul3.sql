DELIMITER //
CREATE PROCEDURE AddUMKM (
    IN p_nama_usaha VARCHAR(100),
    IN p_jumlah_karyawan INT
)
BEGIN
    INSERT INTO umkm(nama_usaha, jumlah_karyawan)
    VALUES (p_nama_usaha, p_jumlah_karyawan);
END //
DELIMITER ;

CALL AddUMKM('Toko Anime Faiz', 10);

-- 2 ---
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

CALL UpdateKategoriUMKM(1, 'Kuliner');

-- 3 --
DELIMITER //
CREATE PROCEDURE DeletePemilikUMKM (
    IN p_id_pemilik INT
)
BEGIN
    DELETE FROM pemilik_umkm
    WHERE id_pemilik = p_id_pemilik;
END //
DELIMITER ;

CALL DeletePemilikUMKM(2);

-- 4 --
DELIMITER //
CREATE PROCEDURE AddProduk (
    IN p_id_umkm INT,
    IN p_nama_produk VARCHAR(100),
    IN p_harga DECIMAL(10,2)
)
BEGIN
    INSERT INTO produk_umkm(id_umkm, nama_produk, harga)
    VALUES (p_id_umkm, p_nama_produk, p_harga);
END //
DELIMITER ;

CALL AddProduk(1, 'Gantungan Kunci Anime', 15000.00);

-- 5 --

DELIMITER //
CREATE PROCEDURE GetUMKMByID (
    IN p_id_umkm INT,
    OUT p_nama_usaha VARCHAR(100)
)
BEGIN
    SELECT nama_usaha
    INTO p_nama_usaha
    FROM umkm
    WHERE id_umkm = p_id_umkm;
END //
DELIMITER ;

CALL GetUMKMByID(13,@nama_usaha);
SELECT @nama_usaha


 Soal No. 2
  -- MODUL 3 SOAL 2

DELIMITER //
CREATE PROCEDURE UpdateDataMaster (
  IN p_id INT,
  IN p_nama_baru VARCHAR(50),
  OUT p_status VARCHAR(20)
)
BEGIN
  UPDATE Kategori SET nama_kategori = p_nama_baru WHERE id_kategori = p_id;
  SET p_status = 'Selesai';
END //
DELIMITER ;

-- CALL
SET @status = '';
CALL UpdateDataMaster(1, 'Figure', @status);
SELECT @status;

-- 2 --
DELIMITER //
CREATE PROCEDURE CountTransaksi (
  OUT jumlah_transaksi INT
)
BEGIN
  SELECT COUNT(*) INTO jumlah_transaksi FROM Penjualan;
END //
DELIMITER ;

-- CALL
SET @jumlah = 0;
CALL CountTransaksi(@jumlah);
SELECT @jumlah;   

-- 3 --

DELIMITER //
CREATE PROCEDURE GetDataMasterByID (
  IN p_id INT,
  OUT p_nama VARCHAR(100),
  OUT p_alamat VARCHAR(255),
  OUT p_no_hp VARCHAR(15)
)
BEGIN
  SELECT nama, alamat, no_hp
  INTO p_nama, p_alamat, p_no_hp
  FROM Pelanggan
  WHERE id_pelanggan = p_id;
END //
DELIMITER ;

-- CALL
SET @nama = ''; SET @alamat = ''; SET @hp = '';
CALL GetDataMasterByID(1, @nama, @alamat, @hp);
SELECT @nama, @alamat, @hp;

-- 4 --

DELIMITER //
CREATE PROCEDURE UpdateFieldTransaksi (
  IN p_id INT,
  INOUT p_jumlah INT,
  INOUT p_subtotal INT
)
BEGIN
  UPDATE DetailPenjualan
  SET jumlah = p_jumlah, subtotal = p_subtotal
  WHERE id_detail = p_id;
END //
DELIMITER ;

-- CALL
SET @jumlah = 2;
SET @subtotal = 80000;
CALL UpdateFieldTransaksi(1, @jumlah, @subtotal);
SELECT @jumlah, @subtotal;
