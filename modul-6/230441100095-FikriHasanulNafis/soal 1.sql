-- No 1
DELIMITER //

CREATE PROCEDURE tampilkan_barang_lama(
    IN periode VARCHAR(10)
)
BEGIN
    IF periode = '1 BULAN' THEN
        SELECT * FROM peminjaman_fasilitas
        WHERE tanggal_pinjam >= CURDATE() - INTERVAL 1 MONTH;
    END IF;
END //

DELIMITER ;
CALL tampilkan_barang_lama('1 BULAN');
SELECT * FROM peminjaman_fasilitas
WHERE tanggal_pinjam >= CURDATE() - INTERVAL 1 MONTH;

-- No 2 
DELIMITER $$

CREATE PROCEDURE hapus_transaksi_tua()
BEGIN
    DELETE FROM peminjaman_fasilitas
    WHERE tanggal_pinjam <= CURDATE() - INTERVAL 1 YEAR
    AND STATUS IN ('Dikembalikan', 'Lunas', 'Sudah Dibayar');
END $$

DELIMITER ;
CALL hapus_transaksi_tua();
SELECT * FROM peminjaman_fasilitas;

-- No 3
DELIMITER $$

CREATE PROCEDURE ubah_status_transaksi()
BEGIN
    UPDATE peminjaman_fasilitas
    SET STATUS = 'Dikembalikan'  -- Ganti dengan status yang diinginkan
    WHERE id_peminjaman IN (
        SELECT id_peminjaman
        FROM peminjaman_fasilitas
        GROUP BY id_peminjaman
        HAVING COUNT(*) >= 7
    );
END $$

DELIMITER ;

CALL ubah_status_transaksi();
SELECT * FROM peminjaman_fasilitas;
SELECT id_peminjaman, id_penghuni, nama_fasilitas, tanggal_pinjam, STATUS
FROM peminjaman_fasilitas WHERE id_penghuni = 1;



-- No 4
DELIMITER $$

CREATE PROCEDURE edit_user(
    IN user_id INT,
    IN new_nama_lengkap VARCHAR(100),
    IN new_no_hp VARCHAR(15),
    IN new_email VARCHAR(50)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM peminjaman_fasilitas WHERE id_penghuni = user_id AND STATUS = 'Dipinjam') THEN
        UPDATE penghuni
        SET nama_lengkap = new_nama_lengkap, no_hp = new_no_hp, email = new_email
        WHERE id_penghuni = user_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User masih memiliki transaksi yang belum selesai';
    END IF;
END $$

DELIMITER ;

CALL edit_user(1, 'Nama Baru', '08123456789', 'emailbaru@example.com');
SELECT * FROM penghuni WHERE id_penghuni = 1;

-- No 5
DELIMITER $$

CREATE PROCEDURE update_status_transaksi_sederhana()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE id_penghuni_val INT;
    DECLARE jumlah_transaksi_val INT;

    -- Cursor untuk iterasi penghuni & jumlah transaksinya menyimpan hasil quey
    DECLARE cur CURSOR FOR
        SELECT id_penghuni, COUNT(*) AS jumlah_transaksi
        FROM peminjaman_fasilitas
        WHERE tanggal_pinjam >= CURDATE() - INTERVAL 1 MONTH
        GROUP BY id_penghuni;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Buka cursor
    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO id_penghuni_val, jumlah_transaksi_val;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Update status berdasarkan jumlah transaksi
        IF jumlah_transaksi_val >= 5 THEN
            UPDATE peminjaman_fasilitas
            SET STATUS = 'Aktif'
            WHERE id_penghuni = id_penghuni_val
              AND tanggal_pinjam >= CURDATE() - INTERVAL 1 MONTH;
        ELSEIF jumlah_transaksi_val BETWEEN 3 AND 4 THEN
            UPDATE peminjaman_fasilitas
            SET STATUS = 'Pasif'
            WHERE id_penghuni = id_penghuni_val
              AND tanggal_pinjam >= CURDATE() - INTERVAL 1 MONTH;
        ELSE
            UPDATE peminjaman_fasilitas
            SET STATUS = 'Non-aktif'
            WHERE id_penghuni = id_penghuni_val
              AND tanggal_pinjam >= CURDATE() - INTERVAL 1 MONTH;
        END IF;
    END LOOP;

    CLOSE cur;
END $$

DELIMITER ;
CALL update_status_transaksi_sederhana();

-- Lihat hasilnya
SELECT id_penghuni, STATUS, COUNT(*) AS jumlah_transaksi
FROM peminjaman_fasilitas
WHERE tanggal_pinjam >= CURDATE() - INTERVAL 1 MONTH
GROUP BY id_penghuni, STATUS;



CALL update_status_transaksi_berdasarkan_jumlah();
SELECT id_penghuni, COUNT(*) AS jumlah_transaksi, STATUS
FROM peminjaman_fasilitas
WHERE tanggal_pinjam >= CURDATE() - INTERVAL 1 MONTH
GROUP BY id_penghuni, STATUS;
-- No 6
DELIMITER $$

CREATE PROCEDURE tampilkan_jumlah_transaksi_berhasil()
BEGIN
    DECLARE total_transaksi INT DEFAULT 0;
    
    -- Menghitung jumlah transaksi dengan status 'Dikembalikan' dalam 1 bulan terakhir
    SELECT COUNT(*) INTO total_transaksi
    FROM peminjaman_fasilitas
    WHERE STATUS = 'Dikembalikan'
    AND tanggal_pinjam >= CURDATE() - INTERVAL 1 MONTH;
    
    -- Menampilkan jumlah transaksi berhasil
    SELECT total_transaksi AS jumlah_transaksi_berhasil;
END $$

DELIMITER ;
CALL tampilkan_jumlah_transaksi_berhasil(); 
SELECT COUNT(*) AS jumlah_transaksi_berhasil
FROM peminjaman_fasilitas
WHERE STATUS = 'Dikembalikan'
AND tanggal_pinjam >= CURDATE() - INTERVAL 1 MONTH;