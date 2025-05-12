
USE penyewaanrumah;

-- nomor 1 --
DELIMITER //

CREATE PROCEDURE Tampilkanlamapenyewaan (
	IN tanggal_awal DATE,
	IN jumlah_hari INT
)
BEGIN
    SELECT * FROM penyewaan 
    WHERE tanggal_mulai >= tanggal_awal
	AND  tanggal_selesai <= DATE_ADD(tanggal_awal, INTERVAL jumlah_hari DAY) ;
END //

DELIMITER ;

CALL Tampilkanlamapenyewaan ('2025-05-01', 30);
DROP PROCEDURE Tampilkanlamapenyewaan;

-- nomor 2 --
DELIMITER //

CREATE PROCEDURE HapusPenyewaanDurasiSetahun()
BEGIN
    DELETE FROM penyewaan
    WHERE 
        sts = 'Selesai'
        AND DATEDIFF(tanggal_selesai, tanggal_mulai) >= 365;
END //

DELIMITER ;

CALL HapusPenyewaanDurasiSetahun();
SELECT * FROM penyewaan;

DROP PROCEDURE HapusPenyewaanLebihSetahun


-- nomor 3 --
DELIMITER //

CREATE PROCEDURE UbahStatus7Transaksi()
BEGIN
    UPDATE penyewaan
    SET sts = 'selesai'
    WHERE sts = 'Aktif'
    LIMIT 7;
END //

DELIMITER ;

CALL UbahStatus7Transaksi(); 
SELECT * FROM penyewaan;

-- nomor 4--
DELIMITER //

CREATE PROCEDURE UpdateUserDenganValidasiTransaksi (
    IN p_user_id INT,
    IN p_nama_baru VARCHAR(255),
    IN p_email_baru VARCHAR(100)
)
BEGIN
    DECLARE jumlah_transaksi INT;

    -- Cek apakah user masih memiliki transaksi
    SELECT COUNT(*) INTO jumlah_transaksi
    FROM Penyewaan  -- Menggunakan tabel Penyewaan untuk cek transaksi pengguna
    WHERE id_penyewa = p_user_id;

    -- Jika tidak ada transaksi, lakukan update
    IF jumlah_transaksi = 0 THEN
        UPDATE Penyewa  -- Menggunakan tabel Penyewa untuk update nama dan email
        SET nama_penyewa = p_nama_baru,
            no_hp = p_email_baru
        WHERE id_penyewa = p_user_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User tidak dapat diedit karena masih memiliki transaksi.';
    END IF;
END //

DELIMITER ;



CALL UpdateUserDenganValidasiTransaksi(1, 'Adzka', 'adzkanafisa@gmail.com');
SELECT * FROM Penyewa WHERE id_penyewa = 1;

DROP PROCEDURE UpdateUserDenganValidasiTransaksi;

-- NOMOR 5 --
DELIMITER //

CREATE PROCEDURE UpdateStatusPenyewaanBerdasarkanTransaksi()
BEGIN
    -- Buat tabel sementara untuk simpan total transaksi per penyewaan
    CREATE TEMPORARY TABLE TotalPembayaran AS
    SELECT 
        id_pen yewaan,
        SUM(jumlah_bayar) AS total_bayar
    FROM Pembayaran
    WHERE tanggal_bayar >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    GROUP BY id_penyewaan;

    -- Cari total paling kecil, sedang, dan terbesar
    SET @min_bayar := (SELECT MIN(total_bayar) FROM TotalPembayaran);
    SET @max_bayar := (SELECT MAX(total_bayar) FROM TotalPembayaran);
    SET @avg_bayar := (SELECT AVG(total_bayar) FROM TotalPembayaran);

    -- Update status menjadi Non-Aktif untuk pembayaran paling sedikit
    UPDATE Penyewaan
    SET sts = 'Non-Aktif'
    WHERE id_penyewaan IN (
        SELECT id_penyewaan FROM TotalPembayaran
        WHERE total_bayar = @min_bayar
    );

    -- Update status menjadi Aktif untuk pembayaran paling besar
    UPDATE Penyewaan
    SET sts = 'Aktif'
    WHERE id_penyewaan IN (
        SELECT id_penyewaan FROM TotalPembayaran
        WHERE total_bayar = @max_bayar
    );

    -- Update status menjadi Pasif untuk nilai antara min dan max
    UPDATE Penyewaan
    SET sts = 'Pasif'
    WHERE id_penyewaan IN (
        SELECT id_penyewaan FROM TotalPembayaran
        WHERE total_bayar > @min_bayar AND total_bayar < @max_bayar
    );

    -- Drop temporary table
    DROP TEMPORARY TABLE TotalPembayaran;
END //

DELIMITER ;

CALL UpdateStatusPenyewaanBerdasarkanTransaksi();
SELECT* FROM penyewaan;


-- NOMOR 6 --

DELIMITER //

CREATE PROCEDURE HitungTransaksiBerhasilBulanIni()
BEGIN
    DECLARE jumlah INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;
    DECLARE total_row INT;

    -- Buat temporary table untuk simpan id transaksi berhasil
    CREATE TEMPORARY TABLE IF NOT EXISTS TransaksiBerhasil AS
    SELECT DISTINCT pm.id_pembayaran
    FROM Pembayaran pm
    JOIN Penyewaan p ON pm.id_penyewaan = p.id_penyewaan
    WHERE p.sts = 'Selesai'
      AND pm.tanggal_bayar >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

    -- Hitung jumlah baris di temporary table
    SELECT COUNT(*) INTO total_row FROM TransaksiBerhasil;

    -- WHILE loop untuk menghitung jumlah
    WHILE i <= total_row DO
        SET jumlah = jumlah + 1;
        SET i = i + 1;
    END WHILE;

    -- Tampilkan hasil
    SELECT jumlah AS jumlah_transaksi_berhasil;

    -- Hapus temporary table
    DROP TEMPORARY TABLE IF EXISTS TransaksiBerhasil;
END //

DELIMITER ;


CALL HitungTransaksiBerhasilBulanIni();

DROP PROCEDURE HitungTransaksiBerhasilBulanIni






























DELIMITER //

CREATE PROCEDURE HitungTransaksiBerhasilBulanIni()
BEGIN
    SELECT COUNT(DISTINCT pm.id_pembayaran) AS jumlah_transaksi_berhasil
    FROM Pembayaran pm
    JOIN Penyewaan p ON pm.id_penyewaan = p.id_penyewaan
    WHERE p.sts = 'Selesai'
      AND pm.tanggal_bayar >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
END //

DELIMITER ;



CALL HitungTransaksiBerhasilBulanIni();

DROP PROCEDURE HitungTransaksiBerhasilBulanIni













































DELIMITER //

CREATE PROCEDURE HitungTransaksiBerhasilBulanIni()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE total INT DEFAULT 0;

    -- Cursor ambil id transaksi berhasil 1 bulan terakhir
    DECLARE transaksi_cursor CURSOR FOR
        SELECT DISTINCT pm.id_pembayaran
        FROM Pembayaran pm
        JOIN Penyewaan p ON pm.id_penyewaan = p.id_penyewaan
        WHERE p.sts = 'Selesai'
          AND pm.tanggal_bayar >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN transaksi_cursor;

    transaksi_loop: LOOP
        FETCH transaksi_cursor INTO v_id;
        IF done THEN
            LEAVE transaksi_loop;
        END IF;

        -- Tambah counter transaksi
        SET total = total + 1;
    END LOOP;

    CLOSE transaksi_cursor;

    -- Tampilkan hasil
    SELECT total AS jumlah_transaksi_berhasil;
END //

DELIMITER ;


CALL HitungTransaksiBerhasilBulanIni();
SELECT* FROM penyewaan;


-- Menghapus prosedur setelah dijalankan (opsional)
DROP PROCEDURE HitungTransaksiBerhasilBulanIni;













DELIMITER //

CREATE PROCEDURE HapusPenyewaanDurasiSetahun()
BEGIN
    DELETE FROM penyewaan
    WHERE 
        sts = 'Selesai'
        AND TIMESTAMPDIFF(YEAR, tanggal_mulai, tanggal_selesai) >= 1;
END //


DELIMITER ;
CALL HapusPenyewaanDurasiSetahun();
