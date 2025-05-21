USE db_toko_aksesoris;

-- soal 1
DELIMITER //

CREATE PROCEDURE tampil_produk_berdasarkan_waktu(IN rentang VARCHAR(20))
BEGIN
    DECLARE selisih INT;

    IF rentang = 'SEMINGGU' THEN
        SET selisih = 7;
    ELSEIF rentang = '1 BULAN' THEN
        SET selisih = 30;
    ELSEIF rentang = '3 BULAN' THEN
        SET selisih = 90;
    END IF;

    SELECT * FROM tbl_produk
    WHERE tanggal_masuk >= CURDATE() - INTERVAL selisih DAY;
END //

DELIMITER ;
ALTER TABLE tbl_produk ADD tanggal_masuk DATE DEFAULT CURRENT_DATE;
CALL tampil_produk_berdasarkan_waktu('SEMINGGU');
CALL tampil_produk_berdasarkan_waktu('1 BULAN');
CALL tampil_produk_berdasarkan_waktu('3 BULAN');

-- soal 2
DELIMITER //

CREATE PROCEDURE hapus_transaksi_lama()
BEGIN
    DELETE FROM tbl_transaksi
    WHERE tanggal_transaksi < CURDATE() - INTERVAL 1 YEAR
    AND STATUS = 'lunas';
END //

DELIMITER ;
ALTER TABLE tbl_transaksi ADD STATUS ENUM('lunas', 'belum lunas') DEFAULT 'belum lunas';
CALL hapus_transaksi_lama();
SELECT * FROM tbl_transaksi;
-- soal 3
DELIMITER //

CREATE PROCEDURE ubah_status_transaksi()
BEGIN
    UPDATE tbl_transaksi
    SET STATUS = 'lunas'
    WHERE STATUS = 'belum lunas'
    LIMIT 7;
END //

DELIMITER ;
CALL ubah_status_transaksi();
SELECT * FROM tbl_transaksi WHERE STATUS = 'lunas';

-- soal 4
DELIMITER //

CREATE PROCEDURE edit_pelanggan(
    IN pid INT,
    IN pnama VARCHAR(150),
    IN pemail VARCHAR(150),
    IN palamat TEXT,
    OUT status_out VARCHAR(100)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM tbl_transaksi WHERE id_pelanggan = pid) THEN
        UPDATE tbl_pelanggan
        SET nama_pelanggan = pnama,
            email = pemail,
            alamat = palamat
        WHERE id_pelanggan = pid;
        SET status_out = 'Data pelanggan berhasil diubah';
    ELSE
        SET status_out = 'Pelanggan masih memiliki transaksi, tidak bisa diedit';
    END IF;
END //
SELECT * FROM tbl_transaksi;
DELIMITER ;
CALL edit_pelanggan(5, 'Siti Aisyah', 'siti@gmail.com', 'Jakarta');


-- soal 5
CREATE TEMPORARY TABLE temp_transaksi AS
SELECT ...

ALTER TABLE tbl_transaksi
ADD COLUMN status_transaksi ENUM('aktif', 'pasif', 'non-aktif') DEFAULT 'pasif';
DELIMITER //

CREATE PROCEDURE update_status_transaksi_bulan()
BEGIN
DECLARE id_min INT;
    DECLARE id_max INT;
    DECLARE id_mid INT;
    DECLARE mid_value INT;

    -- Ambil transaksi 1 bulan terakhir
 SELECT 
        id_transaksi, 
        SUM(jumlah) AS total_jumlah
    FROM tbl_detail_transaksi
    WHERE id_transaksi IN (
        SELECT id_transaksi 
        FROM tbl_transaksi 
        WHERE tanggal_transaksi >= CURDATE() - INTERVAL 1 MONTH
    )
    GROUP BY id_transaksi;

    -- Cari id dengan jumlah paling kecil
    SELECT id_transaksi INTO id_min
    FROM temp_transaksi
    ORDER BY total_jumlah ASC
    LIMIT 1;

    -- Cari id dengan jumlah paling besar
    SELECT id_transaksi INTO id_max
    FROM temp_transaksi
    ORDER BY total_jumlah DESC
    LIMIT 1;

    -- Cari jumlah sedang (urutan ke-2 kalau ada 3 data)
    SELECT id_transaksi INTO id_mid
    FROM temp_transaksi
    ORDER BY total_jumlah
    LIMIT 1 OFFSET 1;

    -- Update status
    UPDATE tbl_transaksi SET status_transaksi = 'non-aktif'
    WHERE id_transaksi = id_min;

    UPDATE tbl_transaksi SET status_transaksi = 'aktif'
    WHERE id_transaksi = id_max;
   CREATE TEMPORARY TABLE temp_transaksi AS
UPDATE tbl_transaksi SET status_transaksi = 'pasif'
    WHERE id_transaksi = id_mid;

    DROP TEMPORARY TABLE temp_transaksi;
END //
DELIMITER ;
CALL update_status_transaksi_bulan();
SELECT id_transaksi, status_transaksi 
FROM tbl_transaksi 
WHERE tanggal_transaksi >= CURDATE() - INTERVAL 1 MONTH;

-- soal 6
DELIMITER //

CREATE PROCEDURE hitung_transaksi_berhasil()
BEGIN
    DECLARE selesai INT DEFAULT 0;
    DECLARE id INT;
    DECLARE jumlah INT DEFAULT 0;

    DECLARE cur CURSOR FOR 
        SELECT id_transaksi 
        FROM tbl_transaksi 
        WHERE tanggal_transaksi >= CURDATE() - INTERVAL 1 MONTH 
        AND status_transaksi = 'aktif';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET selesai = 1;

    OPEN cur;
-- Perulangan untuk menghitung jumlah baris yang diambil cursor.
    baca: LOOP
        FETCH cur INTO id;
        IF selesai = 1 THEN
            LEAVE baca;
        END IF;
        SET jumlah = jumlah + 1;
    END LOOP;

    CLOSE cur;

    SELECT CONCAT('Jumlah transaksi berhasil dalam 1 bulan terakhir: ', jumlah) AS hasil;
END //

DELIMITER ;
CALL hitung_transaksi_berhasil();
ALTER TABLE tbl_transaksi
ADD COLUMN status_transaksi ENUM('aktif', 'pasif', 'non-aktif') DEFAULT 'pasif';
