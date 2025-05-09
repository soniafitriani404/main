CREATE DATABASE penjualan_tanaman_hias;
USE penjualan_tanaman_hias;

CREATE TABLE kategori (
    id_kategori INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(100),
    keterangan TEXT
);

CREATE TABLE tanaman (
    id_tanaman INT PRIMARY KEY AUTO_INCREMENT,
    nama_tanaman VARCHAR(100),
    jenis VARCHAR(50),
    harga DECIMAL(10,2),
    stok INT,
    deskripsi TEXT,
    id_kategori INT,
    FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategori)
);

CREATE TABLE pelanggan (
    id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
    nama_pelanggan VARCHAR(100),
    alamat TEXT,
    no_hp VARCHAR(15)
);

CREATE TABLE penjualan (
    id_penjualan INT PRIMARY KEY AUTO_INCREMENT,
    id_pelanggan INT,
    tanggal_penjualan DATE,
    total_harga DECIMAL(12,2),
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan)
);

CREATE TABLE detail_penjualan (
    id_detail INT PRIMARY KEY AUTO_INCREMENT,
    id_penjualan INT,
    id_tanaman INT,
    jumlah INT,
    subtotal DECIMAL(12,2),
    FOREIGN KEY (id_penjualan) REFERENCES penjualan(id_penjualan),
    FOREIGN KEY (id_tanaman) REFERENCES tanaman(id_tanaman)
);

INSERT INTO kategori (nama_kategori, keterangan) VALUES
('Tanaman Hias Daun', 'Tanaman yang memiliki keindahan pada daun'),
('Tanaman Bunga', 'Tanaman yang berbunga indah dan berwarna-warni'),
('Kaktus', 'Tanaman berduri dan cocok untuk daerah kering');

INSERT INTO tanaman (nama_tanaman, jenis, harga, stok, deskripsi, id_kategori) VALUES
('Monstera', 'Indoor', 120000.00, 10, 'Tanaman daun besar berlubang, cocok untuk dekorasi ruangan', 1),
('Aglaonema', 'Indoor', 90000.00, 15, 'Tanaman daun hias dengan warna menarik', 1),
('Mawar Merah', 'Outdoor', 15000.00, 30, 'Bunga mawar berwarna merah cerah', 2),
('Kaktus Mini', 'Indoor', 25000.00, 25, 'Kaktus ukuran kecil, cocok untuk meja kerja', 3),
('Lavender', 'Outdoor', 40000.00, 20, 'Tanaman berbunga wangi yang menarik lebah', 2);

INSERT INTO pelanggan (nama_pelanggan, alamat, no_hp) VALUES
('Ayu Lestari', 'Jl. Melati No. 10', '081234567890'),
('Budi Santoso', 'Jl. Kenanga No. 22', '082112345678'),
('Clara Wijaya', 'Jl. Mawar No. 7', '085267890123');

-- update
ALTER TABLE penjualan ADD COLUMN STATUS VARCHAR(20) DEFAULT 'belum lunas';
INSERT INTO penjualan (id_pelanggan, tanggal_penjualan, total_harga, STATUS) VALUES
(1, '2025-04-10', 255000.00, 'belum lunas'),
(2, '2025-04-11', 40000.00, 'lunas'),
(1, '2025-04-11', 45000.00, 'belum lunas'),
(3, '2025-04-11', 275000.00, 'belum lunas'),
(1, '2025-04-15', 100000.00, 'belum lunas'),
(2, '2025-04-16', 50000.00, 'belum lunas'),
(3, '2025-04-17', 125000.00, 'lunas'),
(1, '2025-04-18', 85000.00, 'belum lunas');
(3, '2025-04-19', 10000.00, 'belum lunas');

INSERT INTO detail_penjualan (id_penjualan, id_tanaman, jumlah, subtotal) VALUES
(1, 1, 1, 120000.00),
(1, 3, 3, 45000.00),
(1, 4, 3, 90000.00),
(2, 5, 1, 40000.00),
(3, 2, 1, 90000.00),
(3, 1, 1, 120000.00),
(3, 3, 4, 60000.00);

SELECT * FROM tanaman;
SELECT * FROM kategori;
SELECT * FROM pelanggan;
SELECT * FROM penjualan;
SELECT * FROM detail_penjualan;


-- Modul 5 & 6
-- 1. Menampilkan transaksi berdasarkan lama waktu
DELIMITER //

CREATE PROCEDURE getPenjualan1Bulan()
BEGIN
    SELECT * FROM penjualan
    WHERE tanggal_penjualan >= CURDATE() - INTERVAL 1 MONTH;
END;
//

DELIMITER ;

CALL getPenjualan1Bulan();

-- 2. Menghapus transaksi lebih dari 1 tahun jika status lunas
DELIMITER //

CREATE PROCEDURE hapusTransaksiLama()
BEGIN
    DELETE FROM penjualan
    WHERE tanggal_penjualan < CURDATE() - INTERVAL 1 YEAR
    AND STATUS = 'lunas';
END;
//

DELIMITER ;

CALL hapusTransaksiLama();
SELECT * FROM penjualan;


-- 3. Mengubah status transaksi ke 'lunas' untuk minimal 7 transaksi
DELIMITER //

CREATE PROCEDURE updateStatusTransaksi()
BEGIN
    UPDATE penjualan
    SET STATUS = 'lunas'
    WHERE STATUS != 'lunas'
    LIMIT 7;
END;
//

DELIMITER ;

CALL updateStatusTransaksi();
SELECT * FROM penjualan WHERE STATUS = 'lunas';

-- 4. Mengedit data pelanggan jika belum ada transaksi
DELIMITER //

CREATE PROCEDURE updatePelanggan(
    IN pid INT
)
BEGIN
    DELETE FROM pelanggan
    WHERE id_pelanggan = pid
    AND NOT EXISTS (
        SELECT 1 FROM penjualan
        WHERE penjualan.id_pelanggan = pelanggan.id_pelanggan
    );
END;
//

DELIMITER ;

CALL updatePelanggan(2, 'Budi Update', 'Jl. Mawar Baru No. 99', '081234567899');
SELECT * FROM pelanggan WHERE id_pelanggan = 2;

-- 5. Brancing status transaksi 1 bulan terakhir
DELIMITER //

CREATE PROCEDURE updateStatusTransaksiBulanTerakhir()
BEGIN
    DECLARE id_min INT;
    DECLARE id_max INT;
    DECLARE id_mid INT;

    SELECT id_penjualan INTO id_min
    FROM penjualan
    WHERE tanggal_penjualan >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    ORDER BY total_harga ASC
    LIMIT 1;

    SELECT id_penjualan INTO id_max
    FROM penjualan
    WHERE tanggal_penjualan >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    ORDER BY total_harga DESC
    LIMIT 1;

    SELECT id_penjualan INTO id_mid
    FROM penjualan
    WHERE tanggal_penjualan >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
      AND id_penjualan NOT IN (id_min, id_max)
    ORDER BY total_harga
    LIMIT 1;

    UPDATE penjualan SET STATUS = 'non-aktif' WHERE id_penjualan = id_min;
    UPDATE penjualan SET STATUS = 'aktif' WHERE id_penjualan = id_max;
    UPDATE penjualan SET STATUS = 'pasif' WHERE id_penjualan = id_mid;
END;
//

DELIMITER ;


CALL updateStatusTransaksiBulanTerakhir();
SELECT * FROM penjualan WHERE tanggal_penjualan >= CURDATE() - INTERVAL 1 MONTH;

-- 6. Looping jumlah transaksi berhasil 1 bulan terakhir
DELIMITER //
CREATE PROCEDURE countTransaksiBerhasil1Bulan()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE total INT DEFAULT 0;
    DECLARE cur CURSOR FOR SELECT id_penjualan FROM penjualan WHERE STATUS = 'lunas' AND tanggal_penjualan >= CURDATE() - INTERVAL 1 MONTH;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO total;
        IF done THEN
            LEAVE read_loop;
        END IF;
    END LOOP;

    CLOSE cur;

    SELECT COUNT(*) AS jumlah_transaksi_berhasil
    FROM penjualan
    WHERE STATUS = 'lunas' AND tanggal_penjualan >= CURDATE() - INTERVAL 1 MONTH;
END;
//
DELIMITER ;

CALL countTransaksiBerhasil1Bulan();
SELECT COUNT(*) AS jumlah_transaksi_berhasil
FROM penjualan
WHERE STATUS = 'lunas' AND tanggal_penjualan >= NOW() - INTERVAL 1 MONTH;
