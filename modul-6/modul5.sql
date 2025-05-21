CREATE PROCEDURE sp_tampilkan_transaksi_1_bulan()
BEGIN
    SELECT *
    FROM Penjualan
    WHERE tanggal >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
END;

DELIMITER ;

CALL sp_tampilkan_transaksi_1_bulan();

--

DELIMITER //
CREATE PROCEDURE HapusTransaksiLama()
BEGIN
  DELETE FROM Penjualan
  WHERE tanggal < CURDATE() - INTERVAL 1 YEAR
    AND STATUS = 'Lunas';
END;
//
DELIMITER ;

CALL HapusTransaksiLama();
--

DELIMITER //

CREATE PROCEDURE sp_update_status_7_transaksi()
BEGIN
    UPDATE Penjualan
    SET STATUS = 'sukses'
    WHERE id_penjualan IN (
        SELECT id_penjualan
        FROM Penjualan
        LIMIT 5
    );
END;

DELIMITER ;
CALL sp_update_status_7_transaksi();

--

DELIMITER //

CREATE PROCEDURE sp_edit_pelanggan(
    IN pid INT,
    IN pnama_baru VARCHAR(100)
)
BEGIN
    IF pid NOT IN (SELECT id_pelanggan FROM Penjualan) THEN
        UPDATE Pelanggan
        SET nama = pnama_baru
        WHERE id_pelanggan = pid;
    END IF;
END;

DELIMITER ;

CALL sp_edit_pelanggan();
--

DELIMITER //

CREATE PROCEDURE sp_update_transaksi_1bulan()
BEGIN
    DECLARE id_terkecil INT;
    DECLARE id_sedang INT;
    DECLARE id_terbesar INT;

    -- Transaksi terkecil
    SELECT id_penjualan INTO id_terkecil
    FROM (
        SELECT id_penjualan, SUM(subtotal) AS total
        FROM DetailPenjualan
        WHERE id_penjualan IN (
            SELECT id_penjualan
            FROM Penjualan
            WHERE tanggal >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
        )
        GROUP BY id_penjualan
        ORDER BY total ASC
        LIMIT 1
    ) AS temp1;

    -- Transaksi sedang
    SELECT id_penjualan INTO id_sedang
    FROM (
        SELECT id_penjualan, SUM(subtotal) AS total
        FROM DetailPenjualan
        WHERE id_penjualan IN (
            SELECT id_penjualan
            FROM Penjualan
            WHERE tanggal >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
        )
        GROUP BY id_penjualan
        ORDER BY total
        LIMIT 1 OFFSET 1
    ) AS temp2;

    -- Transaksi terbesar
    SELECT id_penjualan INTO id_terbesar
    FROM (
        SELECT id_penjualan, SUM(subtotal) AS total
        FROM DetailPenjualan
        WHERE id_penjualan IN (
            SELECT id_penjualan
            FROM Penjualan
            WHERE tanggal >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
        )
        GROUP BY id_penjualan
        ORDER BY total DESC
        LIMIT 1
    ) AS temp3;

    -- Update status
        UPDATE Penjualan SET status_aktif = 'kurang laku' WHERE id_penjualan = id_terkecil;
    UPDATE Penjualan SET status_aktif = 'lumayan laku' WHERE id_penjualan = id_sedang;
    UPDATE Penjualan SET status_aktif = 'laku' WHERE id_penjualan = id_terbesar;

END;

DELIMITER ;

CALL sp_update_transaksi_1bulan();
--

DELIMITER //

CREATE PROCEDURE sp_loop_1bulan()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE id INT;
    DECLARE jumlah INT DEFAULT 0;

    DECLARE cur CURSOR FOR
        SELECT DISTINCT id_penjualan
        FROM DetailPenjualan
        WHERE id_penjualan IN (
            SELECT id_penjualan
            FROM Penjualan
            WHERE tanggal >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
        );

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    loop_label: LOOP
        FETCH cur INTO id;
        IF done THEN
            LEAVE loop_label;
        END IF;

        SET jumlah = jumlah + 1;
    END LOOP;

    CLOSE cur;

    SELECT jumlah AS jumlah_transaksi_berhasil;
END;

DELIMITER ;

CALL sp_loop_1bulan();
