USE db_penyewaan_kamera;


-- 1. Menampilkan data berdasarkan lama waktu
DELIMITER //

CREATE PROCEDURE tampil_data_berdasarkan_lama_waktu(IN pilihan VARCHAR(20))
BEGIN
    DECLARE batas_tanggal DATE;

    SET batas_tanggal = CASE 
        WHEN pilihan = 'SEMINGGU' THEN CURDATE() - INTERVAL 7 DAY
        WHEN pilihan = '1 BULAN' THEN CURDATE() - INTERVAL 1 MONTH
        WHEN pilihan = '3 BULAN' THEN CURDATE() - INTERVAL 3 MONTH
        ELSE NULL
    END;

    SELECT ds.*, t.total, t.metode_pembayaran
    FROM detail_sewa ds
    JOIN transaksi t ON ds.detail_sewa_id = t.detail_sewa_id
    WHERE ds.tanggal_pinjam >= batas_tanggal;
END //

DELIMITER ;
CALL tampil_data_berdasarkan_lama_waktu('3 BULAN');


-- 2. Hapus transaksi lebih dari 1 tahun jika valid
DELIMITER //
CREATE PROCEDURE hapus_transaksi_lama()

BEGIN
    DELETE t FROM transaksi t
    JOIN detail_sewa ds ON t.detail_sewa_id = ds.detail_sewa_id
    WHERE ds.tanggal_kembali < CURDATE() - INTERVAL 1 YEAR
    AND NOT EXISTS (
        SELECT 1 FROM denda d WHERE d.detail_sewa_id = ds.detail_sewa_id
    );
END //
CALL hapus_transaksi_lama();
SELECT * FROM transaksi;


-- 3. Update status minimal 7 transaksi
DELIMITER //
CREATE PROCEDURE update_status_transaksi()
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_transaksi_id (
        transaksi_id INT
    );
    
    INSERT INTO temp_transaksi_id (transaksi_id)
    SELECT transaksi_id FROM transaksi ORDER BY transaksi_id LIMIT 7;

    UPDATE transaksi
    SET STATUS = 'sukses'
    WHERE transaksi_id IN (SELECT transaksi_id FROM temp_transaksi_id);

    DROP TEMPORARY TABLE IF EXISTS temp_transaksi_id;
END //
DELIMITER ;
CALL update_status_transaksi();

SELECT transaksi_id, STATUS FROM transaksi;

-- 4. Edit user jika tidak punya transaksi
DELIMITER //
CREATE PROCEDURE edit_user(
    IN id INT,
    IN new_nama VARCHAR(100),
    IN new_no_tlp VARCHAR(20),
    IN new_email VARCHAR(100)
)
BEGIN
    -- Update hanya jika user tidak punya transaksi
    UPDATE penyewa
    SET nama = new_nama, no_tlp = new_no_tlp, email = new_email
    WHERE penyewa_id = id
    AND NOT EXISTS (
        SELECT 1 FROM detail_sewa WHERE penyewa_id = id
    );
END //
DELIMITER ;
CALL edit_user(3, 'Budi Santoso', '081234567890', 'budi@email.com');
SELECT * FROM penyewa WHERE penyewa_id = 3;

-- 5. Update status transaksi 1 bulan terakhir (dengan branching)
DELIMITER //
CREATE PROCEDURE update_status_transaksi_terbaru()
BEGIN
    DECLARE min_jumlah INT;
    DECLARE max_jumlah INT;
    DECLARE mid_jumlah INT;

    -- Mengambil nilai jumlah minimum, maksimum, dan rata-rata
    SELECT MIN(ds.jumlah), MAX(ds.jumlah), FLOOR(AVG(ds.jumlah))
    INTO min_jumlah, max_jumlah, mid_jumlah
    FROM detail_sewa ds
    JOIN transaksi t ON t.detail_sewa_id = ds.detail_sewa_id
    WHERE ds.tanggal_pinjam >= CURDATE() - INTERVAL 1 MONTH;

    -- Branching menggunakan IF-ELSE
    IF min_jumlah IS NOT NULL THEN
        UPDATE transaksi t
        JOIN detail_sewa ds ON t.detail_sewa_id = ds.detail_sewa_id
        SET t.status = 'non-aktif'
        WHERE ds.jumlah = min_jumlah AND ds.tanggal_pinjam >= CURDATE() - INTERVAL 1 MONTH;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Jumlah minimum tidak ditemukan.';
    END IF;

    IF mid_jumlah IS NOT NULL THEN
        UPDATE transaksi t
        JOIN detail_sewa ds ON t.detail_sewa_id = ds.detail_sewa_id
        SET t.status = 'pasif'
        WHERE ds.jumlah = mid_jumlah AND ds.tanggal_pinjam >= CURDATE() - INTERVAL 1 MONTH;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Jumlah rata-rata tidak ditemukan.';
    END IF;

    IF max_jumlah IS NOT NULL THEN
        UPDATE transaksi t
        JOIN detail_sewa ds ON t.detail_sewa_id = ds.detail_sewa_id
        SET t.status = 'aktif'
        WHERE ds.jumlah = max_jumlah AND ds.tanggal_pinjam >= CURDATE() - INTERVAL 1 MONTH;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Jumlah maksimum tidak ditemukan.';
    END IF;
END //
DELIMITER ;
CALL update_status_transaksi_terbaru();
SELECT transaksi_id, STATUS FROM transaksi;

-- 6. Looping hitung transaksi sukses 1 bulan terakhir
DROP PROCEDURE IF EXISTS hitung_transaksi_berhasil;

DELIMITER //

CREATE PROCEDURE hitung_transaksi_berhasil()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_tanggal DATE;
    DECLARE total INT DEFAULT 0;

    DECLARE cur CURSOR FOR
        SELECT transaksi_id, tanggal_pinjam  -- Menggunakan tanggal_pinjam dari detail_sewa
        FROM transaksi t
        JOIN detail_sewa ds ON t.detail_sewa_id = ds.detail_sewa_id
        WHERE t.status_transaksi = 'disetujui'
        AND ds.tanggal_pinjam >= CURDATE() - INTERVAL 1 MONTH;  -- Filter transaksi dalam 1 bulan terakhir

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_id, v_tanggal;

        IF done THEN
            LEAVE read_loop;
        END IF;

        SET total = total + 1;  -- Menghitung total transaksi berhasil

    END LOOP;

    CLOSE cur;

    -- Menampilkan hasil akhir
    IF total > 0 THEN
        SELECT CONCAT('Jumlah transaksi berhasil dalam 1 bulan terakhir: ', total) AS hasil;
    ELSE
        SELECT 'Tidak ada transaksi berhasil dalam 1 bulan terakhir' AS hasil;
    END IF;
END //
DELIMITER ;
CALL hitung_transaksi_berhasil();
