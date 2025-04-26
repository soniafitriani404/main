
---------------------------------------------------------MODUL 3 SOAL NO.2-----------------------------------------------

-- no.1

DROP PROCEDURE UpdateDataPetani

DELIMITER //

CREATE PROCEDURE UpdateDataPetani(
    IN p_id_petani INT,
    IN p_nama_petani VARCHAR(100),
    IN p_alamat TEXT,
    IN p_kontak_petani VARCHAR(20)
)
BEGIN
    UPDATE petani
    SET nama_petani = p_nama_petani,
        alamat = p_alamat,
        kontak_petani = p_kontak_petani
    WHERE id_petani = p_id_petani;
END //
DELIMITER;

CALL UpdateDataPetani(2, 'Ahmad Mauluna', 'Jl. Bawang No. 12', '081234567890');
SELECT * FROM petani;

------------------------------------------------------------------------------------------------------------------------------------------

-- no 2

DELIMITER //

CREATE PROCEDURE CountPembelianByPembeli(
    IN p_id_pembeli INT, 
    OUT jumlah_pembelian INT
)
BEGIN
    SELECT COUNT(*) INTO jumlah_pembelian
    FROM pembelian
    WHERE id_pembeli = p_id_pembeli;
END //

DELIMITER ;

CALL CountPembelianByPembeli(2, @jumlah);
SELECT @jumlah AS jumlah_pembelian


-------------------------------------------------------------------------------------------------------------------------

-- no. 3


DELIMITER//
CREATE PROCEDURE GetPetaniByID(
    IN p_id_petani INT
)
BEGIN
    SELECT * FROM petani
    WHERE id_petani = p_id_petani;
END //
DELIMITER;

CALL GetPetaniByID(10);

DROP PROCEDURE GetPetaniByID

-------------------------------------------------------------------------------------------------------------------------

-- no 4


DELIMITER //
CREATE PROCEDURE UpdateBeratBawang(
    IN p_id_bawang INT,
    IN p_berat_kg DECIMAL(10,2)
)
BEGIN
    UPDATE bawang_merah
    SET berat_kg = p_berat_kg
    WHERE id_bawang = p_id_bawang;
END //
DELIMITER ;


CALL UpdateBeratBawang(3, 200.00);
SELECT * FROM bawang_merah;

-------------------------------------------------------------------------------------------------------------------------

-- no. 5

DELIMITER //
CREATE PROCEDURE DeletePetaniByID(
    IN p_id_petani INT
)
BEGIN
    DELETE FROM petani
    WHERE id_petani = p_id_petani;
END //

DELIMITER ;
CALL DeletePetaniByID(11);
SELECT * FROM petani;




