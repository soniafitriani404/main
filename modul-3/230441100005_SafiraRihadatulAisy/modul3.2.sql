USE stok_penjualan;

-- =======================
-- 1. UpdateDataMaster
-- =======================
-- Prosedur ini memperbarui harga produk berdasarkan ID produk yang diberikan.
-- Jika ID ditemukan, harga diperbarui dan status OUT bernilai 1.
-- Jika tidak ditemukan, status OUT bernilai 0.

DELIMITER //
CREATE PROCEDURE UpdateDataMaster(
    IN p_id INT,
    IN p_nilai_baru DECIMAL(10,2),
    OUT p_status INT
)
BEGIN
    DECLARE v_exists INT;

    SELECT COUNT(*) INTO v_exists FROM Produk WHERE id_produk = p_id;

    IF v_exists = 1 THEN
        UPDATE Produk SET harga = p_nilai_baru WHERE id_produk = p_id;
        SET p_status = 1;
    ELSE
        SET p_status = 0;
    END IF;
END //
DELIMITER ;

-- Contoh:
CALL UpdateDataMaster(1, 75000.00, @status);
SELECT @status;

-- =======================
-- 2. CountTransaksi
-- =======================
-- Prosedur ini menghitung total data pada tabel Penjualan dan mengembalikannya melalui parameter OUT.

DELIMITER //
CREATE PROCEDURE CountTransaksi(OUT total_transaksi INT)
BEGIN
    SELECT COUNT(*) INTO total_transaksi FROM Penjualan;
END //
DELIMITER ;

-- Contoh:
CALL CountTransaksi(@total);
SELECT @total;

-- ==============================
-- 3. GetDataMasterByID
-- ==============================
-- Prosedur ini mengambil data lengkap produk berdasarkan ID,
-- dan mengembalikan nama_produk, kategori, harga, dan stok melalui parameter OUT.

DELIMITER //
CREATE PROCEDURE GetDataMasterByID(
    IN p_id INT,
    OUT p_nama_produk VARCHAR(100),
    OUT p_kategori VARCHAR(50),
    OUT p_harga DECIMAL(10,2),
    OUT p_stok INT
)
BEGIN
    SELECT nama_produk, kategori, harga, stok
    INTO p_nama_produk, p_kategori, p_harga, p_stok
    FROM Produk WHERE id_produk = p_id;
END //
DELIMITER ;

-- Contoh:
CALL GetDataMasterByID(2, @nama, @kategori, @harga, @stok);
SELECT @nama, @kategori, @harga, @stok;

-- ========================================
-- 4. UpdateFieldTransaksi
-- ========================================
-- Prosedur ini memperbarui 2 kolom dalam tabel Penjualan (total dan tanggal).
-- Jika parameter INOUT kosong (NULL), maka akan mempertahankan nilai sebelumnya dari database.

DELIMITER //
CREATE PROCEDURE UpdateFieldTransaksi(
    IN p_id INT,
    INOUT p_total DECIMAL(10,2),
    INOUT p_tanggal DATE
)
BEGIN
    DECLARE v_total DECIMAL(10,2);
    DECLARE v_tanggal DATE;

    SELECT total, tanggal INTO v_total, v_tanggal FROM Penjualan WHERE id_penjualan = p_id;

    IF p_total IS NULL OR p_total = 0 THEN
        SET p_total = v_total;
    END IF;

    IF p_tanggal IS NULL THEN
        SET p_tanggal = v_tanggal;
    END IF;

    UPDATE Penjualan
    SET total = p_total,
        tanggal = p_tanggal
    WHERE id_penjualan = p_id;
END //
DELIMITER ;

-- Contoh:
SET @total = NULL;
SET @tgl = '2025-04-10';
CALL UpdateFieldTransaksi(1, @total, @tgl);
SELECT @total, @tgl;

-- =======================================
-- 5. DeleteEntriesByIDMaster
-- =======================================
-- Prosedur ini menghapus data dari tabel Produk berdasarkan ID produk yang diberikan.

DELIMITER //
CREATE PROCEDURE DeleteEntriesByIDMaster(
    IN p_id INT
)
BEGIN
    DELETE FROM Produk WHERE id_produk = p_id;
END //
DELIMITER ;

-- Contoh:
CALL DeleteEntriesByIDMaster(10);
