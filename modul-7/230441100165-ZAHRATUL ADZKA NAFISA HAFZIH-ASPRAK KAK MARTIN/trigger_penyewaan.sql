DELIMITER //

-- 1. BEFORE INSERT: Cek status rumah harus 'tersedia'
CREATE TRIGGER before_insert_penyewaan
BEFORE INSERT ON penyewaan
FOR EACH ROW
BEGIN
  DECLARE status_rumah VARCHAR(20);
  SELECT sts INTO status_rumah FROM rumah WHERE id_rumah = NEW.id_rumah;
  IF status_rumah != 'tersedia' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Rumah tidak tersedia untuk disewa.';
  END IF;
END//

DROP TRIGGER IF EXISTS before_insert_penyewaan;

INSERT INTO penyewaan (id_rumah, id_penyewa, tanggal_mulai)
VALUES (2, 101, '2025-05-18');


DELIMITER //

-- 2. AFTER INSERT: Ubah status rumah jadi 'disewa'
CREATE TRIGGER after_insert_penyewaan
AFTER INSERT ON penyewaan
FOR EACH ROW
BEGIN
  UPDATE rumah SET sts = 'disewa' WHERE id_rumah = NEW.id_rumah;
END//

DROP TRIGGER IF EXISTS after_insert_penyewaan;

INSERT INTO penyewaan (id_rumah, id_penyewa, tanggal_mulai)
VALUES (9, 4, '2025-09-01');


-- 3. BEFORE UPDATE: Tidak boleh update jika status sudah 'Selesai' atau 'Non-Aktif'
CREATE TRIGGER before_update_penyewaan
BEFORE UPDATE ON penyewaan
FOR EACH ROW
BEGIN
  IF OLD.sts IN ('Selesai', 'Non-Aktif') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Penyewaan ini tidak dapat diubah.';
  END IF;
END//

-- 4. AFTER UPDATE: Jika status jadi 'Selesai', ubah status rumah jadi 'tersedia'
CREATE TRIGGER after_update_penyewaan
AFTER UPDATE ON penyewaan
FOR EACH ROW
BEGIN
  IF NEW.sts = 'Selesai' AND OLD.sts != 'Selesai' THEN
    UPDATE rumah SET sts = 'tersedia' WHERE id_rumah = NEW.id_rumah;
  END IF;
END//

-- 5. BEFORE DELETE: Tidak boleh hapus jika status masih 'Aktif'
CREATE TRIGGER before_delete_penyewaan
BEFORE DELETE ON penyewaan
FOR EACH ROW
BEGIN
  IF OLD.sts = 'Aktif' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tidak bisa hapus penyewaan yang masih aktif.';
  END IF;
END//

-- 6. AFTER DELETE: Jika rumah sebelumnya disewa, ubah status rumah jadi 'tersedia'
CREATE TRIGGER after_delete_penyewaan
AFTER DELETE ON penyewaan
FOR EACH ROW
BEGIN
  UPDATE rumah SET sts = 'tersedia' WHERE id_rumah = OLD.id_rumah AND sts = 'disewa';
END//

DELIMITER ;



--  rumah dengan id_rumah = 1 harus punya status = 'tersedia'
INSERT INTO penyewaan (id_penyewaan, id_rumah, id_penyewa, tanggal_mulai, tanggal_selesai, sts)
VALUES (12, 1, 3, '2025-05-15', '2025-06-15', 'Aktif');

-- Mengubah status penyewaan ke 'Selesai'
UPDATE penyewaan
SET sts = 'Selesai' 
WHERE id_penyewaan = 12;


SELECT * FROM rumah WHERE id_rumah = 1;

