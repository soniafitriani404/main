-- No 1
-- Insert
DELIMITER //
CREATE TRIGGER before_insert_penghuni
BEFORE INSERT ON penghuni
FOR EACH ROW
BEGIN
    -- Validasi sederhana: pastikan nama tidak kosong
    IF TRIM(NEW.nama_lengkap) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nama penghuni tidak boleh kosong!';
    END IF;
    
    -- Validasi sederhana: pastikan tanggal lahir tidak di masa depan
    IF NEW.tanggal_lahir > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tanggal lahir tidak valid!';
    END IF;
END//
DELIMITER ;

-- Contoh 
INSERT INTO penghuni (nama_lengkap, email, tanggal_lahir)
VALUES ('', 'dummy@email.com', '2000-01-01');
-- Akan menghasilkan error: Nama penghuni tidak boleh kosong!

INSERT INTO penghuni (nama_lengkap, email, tanggal_lahir)
VALUES ('John Doe', 'john@email.com', '2100-01-01');
-- Akan menghasilkan error: Tanggal lahir tidak valid!


-- Before Update
DELIMITER //
CREATE TRIGGER before_update_kamar
BEFORE UPDATE ON kamar
FOR EACH ROW
BEGIN
    -- Validasi sederhana: kapasitas tidak boleh nol atau negatif
    IF NEW.kapasitas <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kapasitas kamar harus lebih dari 0!';
    END IF;
    
    -- Validasi sederhana: tersedia tidak boleh negatif
    IF NEW.tersedia < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Jumlah tersedia tidak boleh negatif!';
    END IF;
END//
DELIMITER ;
-- Contoh 
UPDATE kamar
SET kapasitas = 0
WHERE id_kamar = 1;
-- Akan error: Kapasitas kamar harus lebih dari 0!
UPDATE kamar
SET tersedia = -1
WHERE id_kamar = 1;
-- Akan error: Jumlah tersedia tidak boleh negatif!

-- Before Delete
DELIMITER //
CREATE TRIGGER before_delete_penempatan
BEFORE DELETE ON penempatan_penghuni
FOR EACH ROW
BEGIN
    -- Cek apakah penempatan masih aktif (belum checkout)
    IF OLD.tanggal_keluar IS NULL OR OLD.tanggal_keluar > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tidak dapat menghapus data penempatan yang masih aktif!';
    END IF;
END//
DELIMITER ;
-- Contoh
DELETE FROM penempatan_penghuni
WHERE id_penempatan = 1;
-- Akan error: Tidak dapat menghapus data penempatan yang masih aktif!



-- No 2
-- After Insert
CREATE TABLE log_penghuni (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aktivitas VARCHAR(100),
    tanggal DATETIME,
    detail TEXT
);

DELIMITER //
-- Buat tabel log sederhana
-- Trigger sederhana untuk mencatat penghuni baru
CREATE TRIGGER after_insert_penghuni
AFTER INSERT ON penghuni
FOR EACH ROW
BEGIN
    -- Mencatat info penghuni baru ke tabel log
    INSERT INTO log_penghuni (aktivitas, tanggal, detail)
    VALUES ('Penghuni Baru', NOW(), CONCAT('Nama: ', NEW.nama_lengkap, ', Email: ', NEW.email));
END//
DELIMITER ;
-- Contoh 
INSERT INTO penghuni (nama_lengkap, email, tanggal_lahir)
VALUES ('Anton aja', 'ari@email.com', '1991-04-10');

-- Cek isi log:
SELECT * FROM log_penghuni;


-- After Update
DELIMITER //
CREATE TRIGGER after_update_kamar
AFTER UPDATE ON kamar
FOR EACH ROW
BEGIN
    -- Jika tersedia = 0, tambahkan catatan bahwa kamar sudah penuh
    IF NEW.tersedia = 0 AND OLD.tersedia > 0 THEN
        INSERT INTO log_penghuni (aktivitas, tanggal, detail)
        VALUES ('Kamar Penuh', NOW(), CONCAT('Kamar nomor ', NEW.nomor_kamar, ' sudah mencapai kapasitas maksimal'));
    END IF;
    
    -- Jika tersedia bertambah dari 0, berarti kamar tersedia kembali
    IF NEW.tersedia > 0 AND OLD.tersedia = 0 THEN
        INSERT INTO log_penghuni (aktivitas, tanggal, detail)
        VALUES ('Kamar Tersedia', NOW(), CONCAT('Kamar nomor ', NEW.nomor_kamar, ' kembali tersedia dengan ', NEW.tersedia, ' tempat'));
    END IF;
END//
DELIMITER ;

-- Contoh 
UPDATE kamar SET tersedia = 0 WHERE id_kamar = 1; -- Log "Kamar Penuh"
UPDATE kamar SET tersedia = 2 WHERE id_kamar = 1; -- Log "Kamar Tersedia"


-- Cek isi log:
SELECT * FROM log_penghuni;

-- After delete
DELIMITER //
CREATE TRIGGER after_delete_peminjaman
AFTER DELETE ON peminjaman_fasilitas
FOR EACH ROW
BEGIN
    -- Mendapatkan nama penghuni untuk rekaman yang lebih informatif
    DECLARE nama_peminjam VARCHAR(100);
    
    SELECT nama_lengkap INTO nama_peminjam
    FROM penghuni
    WHERE id_penghuni = OLD.id_penghuni;
    
    -- Mencatat penghapusan data peminjaman
    INSERT INTO log_penghuni (aktivitas, tanggal, detail)
    VALUES (
        'Hapus Peminjaman', 
        NOW(), 
        CONCAT(
            'Peminjaman ID: ', OLD.id_peminjaman,
            ', Fasilitas: ', OLD.nama_fasilitas,
            ', Peminjam: ', nama_peminjam,
            ', Status terakhir: ', OLD.status
        )
    );
END//
DELIMITER ;
-- contoh 
DELETE FROM peminjaman_fasilitas
WHERE id_peminjaman = 70;

SELECT * FROM peminjaman_fasilitas;

-- Cek isi log:
SELECT * FROM log_penghuni;


