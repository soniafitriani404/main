CREATE DATABASE db_penyewaan_kamera;
USE db_penyewaan_kamera;

CREATE TABLE penyewa (
    penyewa_id INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    no_tlp VARCHAR(20),
    email VARCHAR(100),
    upload_identitas VARCHAR(255)
);

CREATE TABLE kamera (
    kamera_id INT PRIMARY KEY AUTO_INCREMENT,
    merk VARCHAR(100),
    harga_sewa_perhari DECIMAL(10,2),
    stok INT
);

CREATE TABLE spesifikasi (
    spesifikasi_id INT PRIMARY KEY AUTO_INCREMENT,
    kamera_id INT,
    resolusi VARCHAR(50),
    sensor VARCHAR(50),
    iso_max VARCHAR(50),
    FOREIGN KEY (kamera_id) REFERENCES kamera(kamera_id) ON DELETE CASCADE
);

CREATE TABLE detail_sewa (
    detail_sewa_id INT PRIMARY KEY AUTO_INCREMENT,
    penyewa_id INT,
    kamera_id INT,
    tanggal_pinjam DATE,
    tanggal_kembali DATE,
    jumlah INT,
    harga_perhari DECIMAL(10,2),
    FOREIGN KEY (penyewa_id) REFERENCES penyewa(penyewa_id) ON DELETE CASCADE,
    FOREIGN KEY (kamera_id) REFERENCES kamera(kamera_id) ON DELETE CASCADE
);

CREATE TABLE transaksi (
    transaksi_id INT PRIMARY KEY AUTO_INCREMENT,
    detail_sewa_id INT,
    total DECIMAL(10,2),
    metode_pembayaran VARCHAR(50),
    FOREIGN KEY (detail_sewa_id) REFERENCES detail_sewa(detail_sewa_id) ON DELETE CASCADE
);

CREATE TABLE denda (
    denda_id INT PRIMARY KEY AUTO_INCREMENT,
    detail_sewa_id INT,
    jenis_denda ENUM('terlambat', 'kerusakan'),
    jumlah_denda DECIMAL(10,2),
    keterangan TEXT,
    FOREIGN KEY (detail_sewa_id) REFERENCES detail_sewa(detail_sewa_id) ON DELETE CASCADE
);

INSERT INTO penyewa (nama, no_tlp, email, upload_identitas) VALUES
('Diah Ayu', '081234567890', 'ahmad@gmail.com', 'ktp_ahmad.jpg'),
('Siti Mala', '082345678901', 'siti@gmail.com', 'ktp_siti.jpg'),
('Ayu Nur', '083456789012', 'budi@gmail.com', 'ktp_budi.jpg'),
('Nur Lestari', '084567890123', 'dewi@gmail.com', 'ktp_dewi.jpg'),
('Lia Amalia', '085678901234', 'agus@gmail.com', 'ktp_agus.jpg'),
('Indah Permata', '086789012345', 'indah@gmail.com', 'ktp_indah.jpg');

INSERT INTO kamera (merk, harga_sewa_perhari, stok) VALUES
('Canon EOS 1500D', 150000.00, 5),
('Nikon D3500', 160000.00, 4),
('Sony Alpha A6000', 180000.00, 3),
('Fujifilm X-T200', 175000.00, 2),
('Panasonic Lumix G7', 170000.00, 3),
('Olympus OM-D E-M10', 165000.00, 4);

INSERT INTO spesifikasi (kamera_id, resolusi, sensor, iso_max) VALUES
(1, '24.1MP', 'CMOS', '6400'),
(2, '24.2MP', 'CMOS', '25600'),
(3, '24.3MP', 'APS-C', '25600'),
(4, '24.2MP', 'APS-C', '12800'),
(5, '16MP', 'Live MOS', '25600'),
(6, '16.1MP', 'Live MOS', '25600');

INSERT INTO detail_sewa (penyewa_id, kamera_id, tanggal_pinjam, tanggal_kembali, jumlah, harga_perhari) VALUES
(1, 1, '2025-04-10', '2025-04-12', 1, 150000.00),
(2, 2, '2025-04-12', '2025-04-15', 1, 160000.00),
(3, 3, '2025-04-13', '2025-04-14', 2, 180000.00),
(4, 4, '2025-04-14', '2025-04-16', 1, 175000.00),
(5, 5, '2025-04-15', '2025-04-17', 1, 170000.00),
(6, 6, '2025-04-16', '2025-04-18', 1, 165000.00);

INSERT INTO transaksi (detail_sewa_id, total, metode_pembayaran) VALUES
(1, 300000.00, 'Transfer'),
(2, 480000.00, 'Cash'),
(3, 360000.00, 'QRIS'),
(4, 350000.00, 'Transfer'),
(5, 340000.00, 'Cash'),
(6, 330000.00, 'QRIS');

INSERT INTO denda (detail_sewa_id, jenis_denda, jumlah_denda, keterangan) VALUES
(1, 'terlambat', 50000.00, 'Terlambat 1 hari'),
(2, 'kerusakan', 100000.00, 'Lensa retak'),
(3, 'terlambat', 30000.00, 'Terlambat beberapa jam'),
(4, 'kerusakan', 75000.00, 'LCD rusak'),
(5, 'terlambat', 40000.00, 'Terlambat 1 hari'),
(6, 'kerusakan', 120000.00, 'Bodi kamera lecet');
