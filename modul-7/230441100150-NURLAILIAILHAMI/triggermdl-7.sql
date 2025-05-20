CREATE DATABASE Tiket_kereta;

USE Tiket_kereta;

CREATE TABLE kereta (
    id_kereta INT PRIMARY KEY AUTO_INCREMENT,
    nama_kereta VARCHAR(100) NOT NULL,
    jenis_kereta ENUM('Eksekutif', 'Bisnis', 'Ekonomi') NOT NULL,
    kapasitas INT NOT NULL
);

CREATE TABLE stasiun (
    id_stasiun INT PRIMARY KEY AUTO_INCREMENT,
    nama_stasiun VARCHAR(100) NOT NULL,
    lokasi VARCHAR(255) NOT NULL
);

CREATE TABLE penumpang (
    id_penumpang INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    no_telepon VARCHAR(15) NOT NULL,
    alamat TEXT
);

CREATE TABLE jadwal (
    id_jadwal INT PRIMARY KEY AUTO_INCREMENT,
    id_kereta INT NOT NULL,
    id_stasiun_asal INT NOT NULL,
    id_stasiun_tujuan INT NOT NULL,
    tanggal_keberangkatan DATE NOT NULL,
    waktu_berangkat TIME NOT NULL,
    waktu_tiba TIME NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_kereta) REFERENCES kereta(id_kereta),
    FOREIGN KEY (id_stasiun_asal) REFERENCES stasiun(id_stasiun),
    FOREIGN KEY (id_stasiun_tujuan) REFERENCES stasiun(id_stasiun)
);

CREATE TABLE pemesanan (
    id_pemesanan INT PRIMARY KEY AUTO_INCREMENT,
    id_penumpang INT NOT NULL,
    id_jadwal INT NOT NULL,
    jumlah_tiket INT NOT NULL,
    total_harga DECIMAL(10,2) NOT NULL,
    STATUS ENUM('Dipesan', 'Dibayar', 'Dibatalkan') NOT NULL DEFAULT 'Dipesan',
    tanggal_pemesanan TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_penumpang) REFERENCES penumpang(id_penumpang),
    FOREIGN KEY (id_jadwal) REFERENCES jadwal(id_jadwal)
);




INSERT INTO kereta (nama_kereta, jenis_kereta, kapasitas) VALUES
('Argo Bromo Anggrek', 'Eksekutif', 300),
('Gaya Baru Malam Selatan', 'Ekonomi', 350),
('Taksaka', 'Bisnis', 250);
('Matarmaja', 'Ekonomi', 400),
('Senja Utama Solo', 'Bisnis', 270),
('Argo Wilis', 'Eksekutif', 320);


INSERT INTO stasiun (nama_stasiun, lokasi) VALUES
('Stasiun Surabaya Gubeng', 'Surabaya'),
('Stasiun Pasar Senen', 'Jakarta'),
('Stasiun Yogyakarta', 'Yogyakarta'),
('Stasiun Malang', 'Malang');
('Stasiun Bandung', 'Bandung'),
('Stasiun Semarang Tawang', 'Semarang'),
('Stasiun Jember', 'Jember');


INSERT INTO penumpang (nama, email, no_telepon, alamat) VALUES
('Laili Ilhami', 'laili@email.com', '081234567890', 'Sampang, Madura'),
('Budi Santoso', 'budi@email.com', '082345678901', 'Jakarta'),
('Siti Aminah', 'siti@email.com', '083456789012', 'Yogyakarta');
('Andi Saputra', 'andi@email.com', '084567890123', 'Bandung'),
('Nina Larasati', 'nina@email.com', '085678901234', 'Semarang'),
('Rahmat Hidayat', 'rahmat@email.com', '086789012345', 'Jember');

INSERT INTO jadwal (id_kereta, id_stasiun_asal, id_stasiun_tujuan, tanggal_keberangkatan, waktu_berangkat, waktu_tiba, harga) VALUES
(1, 1, 2, '2025-04-20', '08:00:00', '16:00:00', 450000.00),
(2, 2, 3, '2025-04-21', '19:00:00', '06:00:00', 300000.00),
(3, 3, 4, '2025-04-22', '10:00:00', '14:00:00', 350000.00),
(4, 5, 2, '2025-04-23', '07:30:00', '15:00:00', 280000.00),
(5, 6, 3, '2025-04-24', '20:00:00', '04:30:00', 330000.00),
(6, 7, 1, '2025-04-25', '09:15:00', '17:45:00', 500000.00);


INSERT INTO jadwal (id_kereta, id_stasiun_asal, id_stasiun_tujuan, tanggal_keberangkatan, waktu_berangkat, waktu_tiba, harga) VALUES
(1, 1, 2, '2024-05-20', '08:00:00', '16:00:00', 80000.00),
(2, 2, 3, '2023-01-21', '19:00:00', '06:00:00', 400000.00),
(3, 3, 4, '2022-03-22', '10:00:00', '14:00:00', 750000.00),
(4, 5, 2, '2022-02-23', '07:30:00', '15:00:00', 380000.00),
(5, 6, 3, '2023-03-24', '20:00:00', '04:30:00', 430000.00),
(6, 7, 1, '2025-05-25', '09:15:00', '17:45:00', 600000.00);

SELECT * FROM jadwal;


INSERT INTO pemesanan (id_penumpang, id_jadwal, jumlah_tiket, total_harga, STATUS) VALUES
(1, 1, 2, 900000.00, 'Dipesan'),
(2, 2, 1, 300000.00, 'Dibayar'),
(3, 3, 3, 10500.00, 'Dipesan'),
(4, 4, 1, 280000.00, 'Dibayar'),
(5, 5, 2, 660000.00, 'Dipesan'),
(6, 6, 1, 500000.00, 'Dibayar'),
(7, 7, 5, 1050000.00, 'Dipesan'),
(5 5, 3, 1050000.00, 'Dipesan');

SELECT * FROM pemesanan;

---1----
DELIMITER //
CREATE TRIGGER before_insert_pemesanan
BEFORE INSERT ON pemesanan
FOR EACH ROW
BEGIN
    IF NEW.jumlah_tiket <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Jumlah tiket harus lebih dari 0';
    END IF;
END//
DELIMITER ;
INSERT INTO pemesanan (id_penumpang, id_jadwal, jumlah_tiket, total_harga, STATUS)
VALUES (2, 2, 0, 600000.00, 'Dipesan');

SELECT * FROM pemesanan;


DELIMITER //
CREATE TRIGGER before_update_status_pemesanan
BEFORE UPDATE ON pemesanan
FOR EACH ROW
BEGIN
    IF NEW.STATUS NOT IN ('Dipesan', 'Dibayar', 'Dibatalkan') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Status tidak valid';
    END IF;
END//
DELIMITER ;
UPDATE pemesanan
SET STATUS = 'Dibayar'
WHERE id_pemesanan = 22;
SELECT * FROM pemesanan WHERE id_pemesanan = 22;


DELIMITER //
CREATE TRIGGER before_delete_penumpang
BEFORE DELETE ON penumpang
FOR EACH ROW
BEGIN
    DECLARE pemesanan_count INT;
    SELECT COUNT(*) INTO pemesanan_count
    FROM pemesanan
    WHERE id_penumpang = OLD.id_penumpang AND STATUS != 'Dibatalkan';

    IF pemesanan_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Penumpang tidak dapat dihapus karena masih memiliki pemesanan aktif';
    END IF;
END//
DELIMITER ;
DELETE FROM penumpang WHERE id_penumpang = 3;



---2--
CREATE TABLE log_pemesanan (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    aksi VARCHAR(50),
    waktu TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    keterangan TEXT
);

DELIMITER //
CREATE TRIGGER after_insert_pemesanan
AFTER INSERT ON pemesanan
FOR EACH ROW
BEGIN
    INSERT INTO log_pemesanan (aksi, keterangan)
    VALUES ('INSERT', CONCAT('Pemesanan baru oleh ID Penumpang ', NEW.id_penumpang, ' untuk jadwal ', NEW.id_jadwal));
END//
DELIMITER ;
INSERT INTO pemesanan (id_penumpang, id_jadwal, jumlah_tiket, total_harga, STATUS)
VALUES (5, 1, 1, 450000.00, 'Dipesan');
SELECT * FROM log_pemesanan;


DELIMITER //
CREATE TRIGGER after_update_status
AFTER UPDATE ON pemesanan
FOR EACH ROW
BEGIN
    INSERT INTO log_pemesanan (aksi, keterangan)
    VALUES ('UPDATE', CONCAT('Status pemesanan ID ', NEW.id_pemesanan, ' diubah menjadi ', NEW.STATUS));
END//
DELIMITER ;
UPDATE pemesanan SET STATUS = 'Dibayar' WHERE id_pemesanan = 5;


DELIMITER //
CREATE TRIGGER after_delete_jadwal
AFTER DELETE ON jadwal
FOR EACH ROW
BEGIN
    INSERT INTO log_pemesanan (aksi, keterangan)
    VALUES ('DELETE', CONCAT('Jadwal keberangkatan dengan ID ', OLD.id_jadwal, ' telah dihapus.'));
END//
DELIMITER ;

DELETE FROM jadwal WHERE id_jadwal = 23;
SELECT * FROM log_pemesanan;







