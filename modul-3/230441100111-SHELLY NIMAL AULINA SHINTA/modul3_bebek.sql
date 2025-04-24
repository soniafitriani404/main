USE peternakan_bebek

DELIMITER //

-- 1. Stored Procedure: UpdateDataPeternak
CREATE PROCEDURE UpdateDataPeternak(
    IN p_id_peternak INT,
    IN p_nama_peternak VARCHAR(100),
    IN p_alamat TEXT,
    IN p_no_hp VARCHAR(20)
)
BEGIN
    UPDATE peternak
    SET nama_peternak = p_nama_peternak,
        alamat = p_alamat,
        no_hp = p_no_hp
    WHERE id_peternak = p_id_peternak;
END //
DELIMITER ;

-- 2. Stored Procedure: CountPembelianByPembeli
DELIMITER //
CREATE PROCEDURE CountPembelianByPembeli(
    IN p_id_pembeli INT,
    OUT jumlah_pembelian INT
)
BEGIN
    SELECT COUNT(*) INTO jumlah_pembelian
    FROM detail_pembelian
    WHERE id_pembeli = p_id_pembeli;
END //
DELIMITER ;
-- 3. Stored Procedure: GetPeternakByID
DELIMITER //
CREATE PROCEDURE GetPeternakByID(
    IN p_id_peternak INT
)
BEGIN
    SELECT * FROM peternak
    WHERE id_peternak = p_id_peternak;
END //
DELIMITER ;

-- 4. Stored Procedure: UpdateJumlahTelurProduksi
DELIMITER//
CREATE PROCEDURE UpdateJumlahTelurProduksi(
    IN p_id_produksi INT,
    IN p_jumlah_telur INT
)
BEGIN
    UPDATE produksi_telur
    SET jumlah_telur = p_jumlah_telur
    WHERE id_produksi = p_id_produksi;
END //
DELIMITER ;
-- 5. Stored Procedure: DeletePeternakByID
DELIMITER//
CREATE PROCEDURE DeletePeternakByID(
    IN p_id_peternak INT
)
BEGIN
    DELETE FROM peternak
    WHERE id_peternak = p_id_peternak;
END //

DELIMITER ;

-- cara memanggil
CALL UpdateDataPeternak(1, 'Ahmad Hadi', 'Jl. Bebek No. 12', '081234567890');
SELECT * FROM peternak
-- Pertama, deklarasikan variabel output (jika pakai MySQL Client atau Workbench)
SET @jumlah = 0;

-- Panggil prosedur dengan variabel output
CALL CountPembelianByPembeli(2, @jumlah);

-- Tampilkan hasilnya
SELECT @jumlah AS total_pembelian;
CALL GetPeternakByID(1);
CALL UpdateJumlahTelurProduksi(3, 200);
SELECT * FROM  produksi_telur

CALL DeletePeternakByID(4);

