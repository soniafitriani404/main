DELIMITER //

CREATE PROCEDURE UpdateDataMaster (
    IN p_id INT,
    IN p_nilai_baru VARCHAR(15),
    OUT p_status VARCHAR(20)
)
BEGIN
    DECLARE v_exist INT;

    SELECT COUNT(*) INTO v_exist
    FROM penghuni
    WHERE id_penghuni = p_id;

    IF v_exist > 0 THEN
        UPDATE penghuni
        SET no_hp = p_nilai_baru
        WHERE id_penghuni = p_id;

        SET p_status = 'Berhasil';
    ELSE
        SET p_status = 'Gagal';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE CountTransaksi (
    OUT p_total INT
)
BEGIN
    SELECT COUNT(*) INTO p_total
    FROM penempatan_penghuni;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetDataMasterByID (
    IN p_id INT,
    OUT p_nama_lengkap VARCHAR(100),
    OUT p_no_hp VARCHAR(15)
)
BEGIN
    SELECT nama_lengkap, no_hp
    INTO p_nama_lengkap, p_no_hp
    FROM penghuni
    WHERE id_penghuni = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE UpdateFieldTransaksi (
    IN p_id INT,
    INOUT p_tanggal_keluar DATE,
    INOUT p_id_kamar INT
)
BEGIN
    UPDATE penempatan_penghuni
    SET tanggal_keluar = p_tanggal_keluar,
        id_kamar = p_id_kamar
    WHERE id_penempatan = p_id;
    
    -- Ambil nilai terbaru dari database untuk validasi
    SELECT tanggal_keluar, id_kamar
    INTO p_tanggal_keluar, p_id_kamar
    FROM penempatan_penghuni
    WHERE id_penempatan = p_id;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE DeleteEntriesByIDMaster (
    IN p_id INT
)
BEGIN
    -- Hapus entri terkait dari penempatan_penghuni
    DELETE FROM penempatan_penghuni
    WHERE id_penghuni = p_id;

    -- Hapus entri utama dari tabel penghuni
    DELETE FROM penghuni
    WHERE id_penghuni = p_id;
END //

DELIMITER ;
