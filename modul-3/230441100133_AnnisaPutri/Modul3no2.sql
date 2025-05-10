USE db_studio_foto;


DELIMITER $$

-- 1. UpdateDataMaster: Memperbarui data di tabel master (Paket)
DELIMITER $$

CREATE PROCEDURE UpdateDataMaster(
    IN id INT,
    IN nilai_baru VARCHAR(255),
    OUT STATUS VARCHAR(50)
)
BEGIN
    UPDATE Paket
    SET nama_paket = nilai_baru
    WHERE paket_id = id;

    IF ROW_COUNT() > 0 THEN
        SET STATUS = 'Update Berhasil';
    ELSE
        SET STATUS = 'ID Tidak Ditemukan';
    END IF;
END$$

DELIMITER ;


-- 2. CountTransaksi: Menghitung jumlah total entri di tabel Pemesanan
DELIMITER $$

CREATE PROCEDURE CountTransaksi(
    OUT total_transaksi INT
)
BEGIN
    SELECT COUNT(*) INTO total_transaksi FROM Pemesanan;
END$$

DELIMITER ;


-- 3. GetDataMasterByID: Mengambil data master (Paket) berdasarkan ID
DELIMITER $$

CREATE PROCEDURE GetDataMasterByID(
    IN id INT,
    OUT data_master VARCHAR(255)
)
BEGIN
    SELECT nama_paket INTO data_master
    FROM Paket
    WHERE paket_id = id;
END$$

DELIMITER ;


-- 4. UpdateFieldTransaksi: Memperbarui dua kolom (STATUS dan jam_pesan) pada tabel Pemesanan
DELIMITER $$

CREATE PROCEDURE UpdateFieldTransaksi(
    IN id INT,
    INOUT field1 VARCHAR(255),
    INOUT field2 TIME
)
BEGIN
    IF field1 IS NOT NULL AND field1 != '' THEN
        UPDATE Pemesanan
        SET STATUS = field1
        WHERE pemesanan_id = id;
    END IF;

    IF field2 IS NOT NULL THEN
        UPDATE Pemesanan
        SET jam_pesan = field2
        WHERE pemesanan_id = id;
    END IF;
END$$

DELIMITER ;


-- 5. DeleteEntriesByIDMaster: Menghapus entri di tabel master (Paket) berdasarkan ID
DELIMITER $$

CREATE PROCEDURE DeleteEntriesByIDMaster(
    IN id INT
)
BEGIN
    -- Hapus HasilFoto yang terhubung lewat Pemesanan
    DELETE HF FROM HasilFoto HF
    JOIN Pemesanan P ON HF.pemesanan_id = P.pemesanan_id
    WHERE P.paket_id = id;

    -- Hapus Pembayaran yang terhubung lewat Pemesanan
    DELETE PM FROM Pembayaran PM
    JOIN Pemesanan P ON PM.pemesanan_id = P.pemesanan_id
    WHERE P.paket_id = id;

    -- Hapus Pemesanan berdasarkan paket_id
    DELETE FROM Pemesanan WHERE paket_id = id;

    -- Hapus relasi di Fotografer_Paket
    DELETE FROM Fotografer_Paket WHERE paket_id = id;

    -- Terakhir, hapus data Paket itu sendiri
    DELETE FROM Paket WHERE paket_id = id;
END$$

DELIMITER ;


ALTER TABLE Pemesanan
DROP FOREIGN KEY pemesanan_ibfk_2;

ALTER TABLE Pemesanan
ADD CONSTRAINT pemesanan_ibfk_2
FOREIGN KEY (paket_id) REFERENCES Paket(paket_id)
ON DELETE CASCADE;

DELIMITER ;


CALL UpdateDataMaster(1, 'Paket Baru', @status);
SELECT @status;

CALL CountTransaksi(@total_transaksi);
SELECT @total_transaksi;

CALL GetDataMasterByID(1, @data_master);
SELECT @data_master;

SET @field1 = 'Selesai';
SET @field2 = '15:00:00';
CALL UpdateFieldTransaksi(1, @field1, @field2);
SELECT @field1, @field2;

CALL DeleteEntriesByIDMaster(1);
SELECT * FROM Paket;


SHOW PROCEDURE STATUS WHERE Db = 'db_studio_foto';
SHOW CREATE PROCEDURE DeleteEntriesByIDMaster;

