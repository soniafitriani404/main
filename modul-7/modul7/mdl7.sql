USE db_toko_aksesoris;

-- soal 1
-- Trigger: BEFORE INSERT
DELIMITER //
CREATE TRIGGER before_insert_produk
BEFORE INSERT ON tbl_produk
FOR EACH ROW
BEGIN
  IF NEW.stok < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Stok tidak boleh negatif.';
  END IF;
END;
//
DELIMITER ;
INSERT INTO tbl_produk (nama_produk, harga, stok, tanggal_masuk, id_kategori, keterangan)
VALUES ('Cincin Emas', 50000, 56, NOW(), 1, 'Stok negatif'); 

-- Trigger: BEFORE UPDATE
DELIMITER //
CREATE TRIGGER before_update_produk
BEFORE UPDATE ON tbl_produk
FOR EACH ROW
BEGIN
  IF NEW.harga <= 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Harga harus lebih dari 0.';
  END IF;
END;
//
DELIMITER ;
UPDATE tbl_produk SET harga = -1 WHERE nama_produk = 'Gelang Manik'; 

-- Trigger: BEFORE DELETE
DELIMITER //
CREATE TRIGGER before_delete_produk
BEFORE DELETE ON tbl_produk
FOR EACH ROW
BEGIN
  DECLARE count_transaksi INT;
  SELECT COUNT(*) INTO count_transaksi FROM tbl_detail_transaksi WHERE id_produk = OLD.id_produk;
  IF count_transaksi > 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Produk tidak bisa dihapus karena masih digunakan di transaksi.';
  END IF;
END;
//
DELIMITER ;
DELETE FROM tbl_produk WHERE id_produk = 6;
select * from tbl_produk;


-- soal 2
-- Trigger: AFTER INSERT
DELIMITER //
CREATE TRIGGER after_insert_produk
AFTER INSERT ON tbl_produk
FOR EACH ROW
BEGIN
  INSERT INTO tbl_log (aksi, deskripsi, waktu) 
  VALUES ('INSERT', CONCAT('Produk baru ditambahkan: ', NEW.nama_produk), NOW());
END;
//
DELIMITER ;
INSERT INTO tbl_produk (nama_produk, harga, stok, tanggal_masuk, id_kategori, keterangan)
VALUES ('Gelang Manik', 25000, 10, NOW(), 1, 'Aksesori baru');

-- Trigger: AFTER UPDATE
DELIMITER //
CREATE TRIGGER after_update_stok
AFTER UPDATE ON tbl_produk
FOR EACH ROW
BEGIN
  IF NEW.stok <> OLD.stok THEN
    INSERT INTO tbl_log (aksi, deskripsi, waktu)
    VALUES ('UPDATE', CONCAT('Stok ', NEW.nama_produk, ' berubah dari ', OLD.stok, ' jadi ', NEW.stok), NOW());
  END IF;
END;
//
DELIMITER ;
UPDATE tbl_produk SET stok = 20 WHERE nama_produk = 'Gelang Manik';

-- Trigger: AFTER DELETE
DELIMITER //
CREATE TRIGGER after_delete_produk
AFTER DELETE ON tbl_produk
FOR EACH ROW
BEGIN
  INSERT INTO tbl_log (aksi, deskripsi, waktu)
  VALUES ('DELETE', CONCAT('Produk dihapus: ', OLD.nama_produk), NOW());
END;
//
DELIMITER ;
DELETE FROM tbl_produk WHERE nama_produk = 'Gelang Manik';
SELECT * FROM tbl_log ORDER BY waktu DESC;
select * from tbl_log;
