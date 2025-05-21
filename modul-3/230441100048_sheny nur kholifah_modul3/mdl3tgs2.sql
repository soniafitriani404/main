USE db_toko_aksesoris;
-- soal 1
DELIMITER //

CREATE PROCEDURE UpdateDataMaster (
    IN id INT,
    IN nilai_baru INT,
    OUT status_out VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
        SET status_out = 'Terjadi kesalahan saat update';

    IF EXISTS (SELECT 1 FROM tbl_produk WHERE id_produk = id) THEN
        UPDATE tbl_produk SET stok = nilai_baru WHERE id_produk = id;
        SET status_out = 'Update berhasil';
    ELSE
        SET status_out = 'Data tidak ditemukan';
    END IF;
END;
//

DELIMITER ;
SET @status = '';
CALL UpdateDataMaster(1, 20, @status);
SELECT @status;



-- soal 2
DELIMITER //

CREATE PROCEDURE CountTransaksi (
    OUT jumlah_out INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
        SET jumlah_out = -1;

    SELECT COUNT(*) INTO jumlah_out FROM tbl_transaksi;
END;
//

DELIMITER ;
SET @jumlah = 0;
CALL CountTransaksi(@jumlah);
SELECT @jumlah AS total_transaksi;


-- soal 3
DELIMITER //

CREATE PROCEDURE GetDataMasterByID (
    IN id INT,
    OUT nama_out VARCHAR(100),
    OUT harga_out INT,
    OUT stok_out INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
        BEGIN
            SET nama_out = NULL;
            SET harga_out = NULL;
            SET stok_out = NULL;
        END;

    IF EXISTS (SELECT 1 FROM tbl_produk WHERE id_produk = id) THEN
        SELECT nama_produk, harga, stok
        INTO nama_out, harga_out, stok_out
        FROM tbl_produk
        WHERE id_produk = id;
    ELSE
        SET nama_out = NULL;
        SET harga_out = NULL;
        SET stok_out = NULL;
    END IF;
END;
//

DELIMITER ;
SET @nama = '', @harga = 0, @stok = 0;
CALL GetDataMasterByID(1, @nama, @harga, @stok);
SELECT @nama AS nama_produk, @harga AS harga, @stok AS stok;

-- spal 4
DELIMITER //

CREATE PROCEDURE UpdateFieldTransaksi (
    IN id INT,
    INOUT field1 INT,
    INOUT field2 DATE
)
BEGIN
    DECLARE v_total INT;
    DECLARE v_tanggal DATE;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        SET field1 = NULL;
        SET field2 = NULL;
    END;

    -- Ambil nilai lama
    SELECT total_harga, tanggal_transaksi
    INTO v_total, v_tanggal
    FROM tbl_transaksi
    WHERE id_transaksi = id;

    -- Gunakan nilai lama jika NULL
    IF field1 IS NULL THEN
        SET field1 = v_total;
    END IF;

    IF field2 IS NULL THEN
        SET field2 = v_tanggal;
    END IF;

    -- Update
    UPDATE tbl_transaksi
    SET total_harga = field1,
        tanggal_transaksi = field2
    WHERE id_transaksi = id;
END;
//

DELIMITER ;
SET @total = 200000, @tgl = NULL;
CALL UpdateFieldTransaksi(1, @total, @tgl);
SELECT @total AS total_harga_akhir, @tgl AS tanggal_akhir;

-- soal 5
DELIMITER //

CREATE PROCEDURE DeleteEntriesByIDMaster (
    IN id INT,
    OUT status_out VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
        SET status_out = 'Gagal menghapus data';

    IF EXISTS (SELECT 1 FROM tbl_produk WHERE id_produk = id) THEN
        DELETE FROM tbl_produk WHERE id_produk = id;
        SET status_out = 'Data berhasil dihapus';
    ELSE
        SET status_out = 'Data tidak ditemukan';
    END IF;
END;
//

DELIMITER ;
CALL DeleteEntriesByIDMaster(4, @hasil);
SELECT * FROM tbl_produk;
SELECT * FROM tbl_produk WHERE id_produk = 4;





