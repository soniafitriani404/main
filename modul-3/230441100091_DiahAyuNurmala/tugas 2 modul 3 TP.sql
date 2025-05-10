USE db_penyewaan_kamera;


-- 1. Stored Procedure: UpdateDataMaster
DELIMITER //

CREATE PROCEDURE UpdateDataMaster (
    IN p_id INT,
    IN p_nilai_baru INT,
    OUT p_status VARCHAR(100)
)
BEGIN
    DECLARE v_exist INT;

    SELECT COUNT(*) INTO v_exist FROM kamera WHERE kamera_id = p_id;

    IF v_exist > 0 THEN
        UPDATE kamera SET stok = p_nilai_baru WHERE kamera_id = p_id;
        SET p_status = 'Update berhasil';
    ELSE
        SET p_status = 'ID tidak ditemukan';
    END IF;
END //

DELIMITER ;

SET @status = '';
CALL UpdateDataMaster(1, 10, @status);
SELECT @status AS status_update;


-- 2. Stored Procedure: CountTransaksi
DELIMITER //

CREATE PROCEDURE CountTransaksi (
    OUT jumlah_transaksi INT
)
BEGIN
    SELECT COUNT(*) INTO jumlah_transaksi FROM transaksi;
END //

DELIMITER ;

-- Call dan cek hasil:
SET @jumlah = 0;
CALL CountTransaksi(@jumlah);
SELECT @jumlah AS total_transaksi;


-- 3. Stored Procedure: GetDataMasterByID
DELIMITER //
CREATE PROCEDURE GetDataMasterByID (
    IN p_id INT,
    OUT p_merk VARCHAR(100),
    OUT p_harga DECIMAL(10,2),
    OUT p_stok INT
)
BEGIN
    SELECT merk, harga_sewa_perhari, stok
    INTO p_merk, p_harga, p_stok
    FROM kamera
    WHERE kamera_id = p_id;
END //

DELIMITER ;

SET @merk = '', @harga = 0.0, @stok = 0;
CALL GetDataMasterByID(3, @merk, @harga, @stok);
SELECT @merk AS merk, @harga AS harga_sewa_perhari, @stok AS stok;


-- 4. Stored Procedure: UpdateFieldTransaksi
DELIMITER //
CREATE PROCEDURE UpdateFieldTransaksi (
    IN p_id INT,
    INOUT p_total DECIMAL(10,2),
    INOUT p_metode VARCHAR(50)
)
BEGIN
    DECLARE v_total DECIMAL(10,2);
    DECLARE v_metode VARCHAR(50);

    SELECT total, metode_pembayaran INTO v_total, v_metode
    FROM transaksi WHERE transaksi_id = p_id;

    UPDATE transaksi SET
        total = IF(p_total IS NULL OR p_total = 0, v_total, p_total),
        metode_pembayaran = IF(p_metode IS NULL OR p_metode = '', v_metode, p_metode)
    WHERE transaksi_id = p_id;

    SELECT total, metode_pembayaran INTO p_total, p_metode
    FROM transaksi WHERE transaksi_id = p_id;
END //

DELIMITER ;

SET @total = 0;
SET @metode = 'Transfer';
CALL UpdateFieldTransaksi(2, @total, @metode);
SELECT @total AS total_akhir, @metode AS metode_akhir;

-- 5. Stored Procedure: DeleteEntriesByIDMaster
DELIMITER //

CREATE PROCEDURE DeleteEntriesByIDMaster(
    IN p_table VARCHAR(50),
    IN p_id INT,
    OUT p_status VARCHAR(100)
)
BEGIN
    DECLARE v_query TEXT;

    -- Memeriksa tabel yang dipilih
    IF p_table = 'kamera' THEN
        SET v_query = CONCAT('DELETE FROM kamera WHERE kamera_id = ?');
    ELSEIF p_table = 'penyewa' THEN
        SET v_query = CONCAT('DELETE FROM penyewa WHERE penyewa_id = ?');
    ELSEIF p_table = 'transaksi' THEN
        SET v_query = CONCAT('DELETE FROM transaksi WHERE transaksi_id = ?');
    ELSE
        SET p_status = 'Tabel tidak valid';
        SET v_query = NULL;
    END IF;

    -- Eksekusi query jika tabel valid
    IF v_query IS NOT NULL THEN
        SET @sql = v_query;
        SET @id = p_id;

        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @id;
        DEALLOCATE PREPARE stmt;

        SET p_status = 'Data berhasil dihapus';
    END IF;
END //

DELIMITER ;

-- Mengatur variabel input dan output
SET @id = 6; 
SET @table = 'kamera';  
SET @status = '';       

CALL DeleteEntriesByIDMaster(@table, @id, @status);
SELECT @status AS hasil_penghapusan;
SELECT * FROM kamera WHERE kamera_id = 6;
