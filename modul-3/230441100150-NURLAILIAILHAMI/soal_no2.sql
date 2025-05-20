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

INSERT INTO stasiun (nama_stasiun, lokasi) VALUES
('Stasiun Surabaya Gubeng', 'Surabaya'),
('Stasiun Pasar Senen', 'Jakarta'),
('Stasiun Yogyakarta', 'Yogyakarta'),
('Stasiun Malang', 'Malang');

INSERT INTO penumpang (nama, email, no_telepon, alamat) VALUES
('Laili Ilhami', 'laili@email.com', '081234567890', 'Sampang, Madura'),
('Budi Santoso', 'budi@email.com', '082345678901', 'Jakarta'),
('Siti Aminah', 'siti@email.com', '083456789012', 'Yogyakarta');


INSERT INTO jadwal (id_kereta, id_stasiun_asal, id_stasiun_tujuan, tanggal_keberangkatan, waktu_berangkat, waktu_tiba, harga) VALUES
(1, 1, 2, '2025-04-20', '08:00:00', '16:00:00', 450000.00),
(2, 2, 3, '2025-04-21', '19:00:00', '06:00:00', 300000.00),
(3, 3, 4, '2025-04-22', '10:00:00', '14:00:00', 350000.00);


INSERT INTO pemesanan (id_penumpang, id_jadwal, jumlah_tiket, total_harga, STATUS) VALUES
(1, 1, 2, 900000.00, 'Dipesan'),
(2, 2, 1, 300000.00, 'Dibayar'),
(3, 3, 3, 1050000.00, 'Dipesan');




----1----
DELIMITER //
CREATE PROCEDURE UpdateDataMaster (
    IN p_id INT,
    IN p_nilai_baru VARCHAR(100),
    OUT status_output VARCHAR(20)
)
BEGIN
    DECLARE rows_affected INT;

    -- Update nama kereta berdasarkan id
    UPDATE kereta
    SET nama_kereta = p_nilai_baru
    WHERE id_kereta = p_id;

    -- Cek apakah update berhasil
    SET rows_affected = ROW_COUNT();

    IF rows_affected > 0 THEN
        SET status_output = 'Sukses';
    ELSE
        SET status_output = 'Gagal';
    END IF;
END//
DELIMITER ;

CALL UpdateDataMaster(1, 'Argo Wilis', @status);
SELECT @status AS Status_Operasi;

---2---
DELIMITER //
CREATE PROCEDURE CountTransaksi (
    OUT jumlah_transaksi INT
)
BEGIN
    SELECT COUNT(*) INTO jumlah_transaksi
    FROM pemesanan;
END//
DELIMITER ;
CALL CountTransaksi(@total);
SELECT @total AS Jumlah_Transaksi;

---3---
DELIMITER //
CREATE PROCEDURE GetDataMasterByID (
    IN p_id INT,
    OUT p_nama_kereta VARCHAR(100),
    OUT p_jenis_kereta VARCHAR(50),
    OUT p_kapasitas INT
)
BEGIN
    SELECT nama_kereta, jenis_kereta, kapasitas
    INTO p_nama_kereta, p_jenis_kereta, p_kapasitas
    FROM kereta
    WHERE id_kereta = p_id;
END//
DELIMITER ;
CALL GetDataMasterByID(1, @nama, @jenis, @kapasitas);
SELECT @nama AS Nama_Kereta, @jenis AS Jenis_Kereta, @kapasitas AS Kapasitas;

--4--
DELIMITER //
CREATE PROCEDURE UpdateFieldTransaksi (
    IN p_id INT,
    INOUT p_jumlah_tiket INT,
    INOUT p_status VARCHAR(20)
)
BEGIN
    -- Variabel untuk menyimpan data lama dari database
    DECLARE old_jumlah_tiket INT;
    DECLARE old_status VARCHAR(20);

    -- Ambil data lama dari database berdasarkan id_pemesanan
    SELECT jumlah_tiket, STATUS
    INTO old_jumlah_tiket, old_status
    FROM pemesanan
    WHERE id_pemesanan = p_id;

    -- Cek apakah field1 kosong (nol atau NULL), jika ya pakai data lama
    IF p_jumlah_tiket IS NULL OR p_jumlah_tiket = 0 THEN
        SET p_jumlah_tiket = old_jumlah_tiket;
    END IF;

    -- Cek apakah field2 kosong (string kosong atau NULL), jika ya pakai data lama
    IF p_status IS NULL OR p_status = '' THEN
        SET p_status = old_status;
    END IF;

    -- Update data ke tabel pemesanan
    UPDATE pemesanan
    SET jumlah_tiket = p_jumlah_tiket,
        STATUS = p_status
    WHERE id_pemesanan = p_id;
END//
DELIMITER ;
SET @jumlah = 5;
SET @status = '';
CALL UpdateFieldTransaksi(2, @jumlah, @status);
SELECT @jumlah AS Tiket_Terbaru, @status AS Status_Terbaru;

----5----
DELIMITER //
CREATE PROCEDURE DeleteEntriesByIDMaster (
    IN p_id INT
)
BEGIN
    DELETE FROM kereta
    WHERE id_kereta = p_id;
END//
DELIMITER ;
CALL DeleteEntriesByIDMaster(2);

