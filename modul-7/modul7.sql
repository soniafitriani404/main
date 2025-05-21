DELIMITER //
CREATE TRIGGER before_insert_barang
BEFORE INSERT ON Barang
FOR EACH ROW
BEGIN
  IF NEW.stok < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stok tidak boleh negatif!';
  END IF;

  IF NEW.harga < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Harga tidak boleh negatif!';
  END IF;
END;
//
DELIMITER ;

-- Insert

DELIMITER //
CREATE TRIGGER before_update_barang
BEFORE UPDATE ON Barang
FOR EACH ROW
BEGIN
  IF NEW.nama_barang IS NULL OR NEW.nama_barang = '' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nama barang tidak boleh kosong!';
  END IF;
END;
//
DELIMITER ;

-- Update

-- Soal 2 

CREATE TABLE LogBarang (
  id_log INT AUTO_INCREMENT PRIMARY KEY,
  aksi VARCHAR(50),
  nama_barang VARCHAR(100),
  tanggal_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER after_insert_barang
AFTER INSERT ON Barang
FOR EACH ROW
BEGIN
  INSERT INTO LogBarang (aksi, nama_barang)
  VALUES ('INSERT', NEW.nama_barang);
END;
//
DELIMITER ;

-- After Insert

DELIMITER //
CREATE TRIGGER after_update_barang
AFTER UPDATE ON Barang
FOR EACH ROW
BEGIN
  INSERT INTO LogBarang (aksi, nama_barang)
  VALUES ('UPDATE', NEW.nama_barang);
END;
//
DELIMITER ;
