CREATE DATABASE restoran_3;
USE restoran_3;

-- Membuat tabel Menu (Master)
CREATE TABLE Menu (
    id_menu INT AUTO_INCREMENT PRIMARY KEY,
    nama_menu VARCHAR(100) NOT NULL,
    kategori ENUM('Makanan', 'Minuman') NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    stok INT NOT NULL,
    deskripsi TEXT
);

-- Membuat tabel Pelanggan (Master)
CREATE TABLE Pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    no_hp VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    alamat TEXT
);

-- Membuat tabel Karyawan (Master)
CREATE TABLE Karyawan (
    id_karyawan INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    jabatan ENUM('Kasir', 'Pelayan', 'Koki') NOT NULL,
    no_hp VARCHAR(15) UNIQUE NOT NULL
);

-- Membuat tabel Pesanan (Transaksi)
CREATE TABLE Pesanan (
    id_pesanan INT AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT NOT NULL,
    id_karyawan INT, -- dibuat NULLABLE karena pakai ON DELETE SET NULL
    tanggal DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_harga DECIMAL(10,2) NOT NULL,
    STATUS ENUM('Belum Dibayar', 'Lunas') DEFAULT 'Belum Dibayar',
    FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan) ON DELETE CASCADE,
    FOREIGN KEY (id_karyawan) REFERENCES Karyawan(id_karyawan) ON DELETE SET NULL
);


-- Membuat tabel Detail_Pesanan (Transaksi)
CREATE TABLE Detail_Pesanan (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_pesanan INT NOT NULL,
    id_menu INT NOT NULL,
    jumlah INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pesanan) REFERENCES Pesanan(id_pesanan) ON DELETE CASCADE,
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu) ON DELETE CASCADE
);

INSERT INTO Menu (nama_menu, kategori, harga, stok, deskripsi) VALUES
('Nasi Goreng Spesial', 'Makanan', 25000, 20, 'Nasi goreng dengan ayam, telur, dan sayuran'),
('Mie Ayam', 'Makanan', 18000, 15, 'Mie dengan potongan ayam dan sawi'),
('Es Teh Manis', 'Minuman', 5000, 30, 'Teh manis dengan es batu'),
('Jus Alpukat', 'Minuman', 12000, 10, 'Jus alpukat segar dengan susu coklat'),
('Sate Ayam', 'Makanan', 20000, 12, 'Sate ayam dengan bumbu kacang');

INSERT INTO Pelanggan (nama, no_hp, email, alamat) VALUES
('Andi Saputra', '081234567890', 'andi@gmail.com', 'Jl. Merdeka No.10'),
('Rina Marlina', '081298765432', 'rina@yahoo.com', 'Jl. Melati No.5'),
('Budi Santoso', '081345678901', NULL, 'Jl. Anggrek No.22');

INSERT INTO Karyawan (nama, jabatan, no_hp) VALUES
('Siti Aminah', 'Kasir', '081212121212'),
('Dedi Hermawan', 'Pelayan', '081313131313'),
('Rosa Lestari', 'Koki', '081414141414');

INSERT INTO Pesanan (id_pelanggan, id_karyawan, total_harga, STATUS) VALUES
(1, 1, 55000, 'Lunas'),
(2, 2, 18000, 'Belum Dibayar'),
(3, NULL, 32000, 'Lunas');

INSERT INTO Detail_Pesanan (id_pesanan, id_menu, jumlah, subtotal) VALUES
(1, 1, 2, 50000),
(1, 3, 1, 5000),
(2, 2, 1, 18000),
(3, 4, 2, 24000),
(3, 5, 1, 8000);

-- 1. Mengupdate nama menu di tabel Menu berdasarkan id_menu.
DELIMITER //

CREATE PROCEDURE UpdateDataMaster(
    IN p_id INT,
    IN p_nilai_baru VARCHAR(100),
    OUT p_status VARCHAR(100)
)
BEGIN
    -- Cek apakah data dengan id tersebut ada
    IF EXISTS (SELECT 1 FROM Menu WHERE id_menu = p_id) THEN
        -- Kalau ada, lakukan update
        UPDATE Menu SET nama_menu = p_nilai_baru WHERE id_menu = p_id;
        SET p_status = 'Data berhasil diperbarui';
    ELSE
        -- Kalau tidak ada
        SET p_status = 'Data dengan ID tersebut tidak ditemukan';
    END IF;
END//

DELIMITER ;


-- Siapkan variabel output
SET @status = '';

-- Panggil prosedur
CALL UpdateDataMaster(1, 'Mie Ayam Special Jumbo', @status);

-- Tampilkan status
SELECT @status;

SELECT * FROM Menu WHERE id_menu = 1;


-- 2. Menghitung total jumlah data dari tabel Pesanan dan Detail_Pesanan, lalu menjumlahkannya.
DELIMITER //

CREATE PROCEDURE CountTransaksi(
    OUT total_transaksi INT
)
BEGIN
    SELECT 
        (SELECT COUNT(*) FROM Pesanan) +
        (SELECT COUNT(*) FROM Detail_Pesanan)
    INTO total_transaksi;
END//

DELIMITER ;

-- Siapkan variabel output
SET @total = 0;

-- Panggil prosedur
CALL CountTransaksi(@total);

-- Tampilkan hasil
SELECT @total AS total_transaksi;



-- 3. Mengambil data detail dari tabel Menu berdasarkan id_menu.
DELIMITER //

CREATE PROCEDURE GetDataMasterByID(
    IN p_id INT,
    OUT p_nama_menu VARCHAR(100),
    OUT p_kategori VARCHAR(20),
    OUT p_harga DECIMAL(10,2),
    OUT p_stok INT
)
BEGIN
    SELECT nama_menu, kategori, harga, stok
    INTO p_nama_menu, p_kategori, p_harga, p_stok
    FROM Menu
    WHERE id_menu = p_id;
END //

DELIMITER ;

-- Siapkan variabel output
SET @nama = '';
SET @kategori = '';
SET @harga = 0;
SET @stok = 0;

-- Panggil prosedur
CALL GetDataMasterByID(2, @nama, @kategori, @harga, @stok);

-- Tampilkan hasil
SELECT @nama AS nama_menu, @kategori AS kategori, @harga, @stok;


DROP DATABASE restoran_3;

-- 4. •	Mengupdate total_harga dan status pada tabel Pesanan, tapi jika input NULL atau kosong, tetap pakai nilai lama dari database.
DELIMITER //
CREATE PROCEDURE UpdateFieldTransaksi(
    IN p_id INT,
    INOUT p_total_harga DECIMAL(10,2),
    INOUT p_status VARCHAR(20)
)
BEGIN
    DECLARE v_total_harga DECIMAL(10,2);
    DECLARE v_status VARCHAR(20);

    -- Ambil nilai saat ini dari database
    SELECT total_harga, STATUS 
    INTO v_total_harga, v_status
    FROM Pesanan
    WHERE id_pesanan = p_id;

    -- Jika nilai input kosong/null, gunakan nilai lama dari database
    IF p_total_harga IS NULL OR p_total_harga = 0 THEN
        SET p_total_harga = v_total_harga;
    END IF;

    IF p_status IS NULL OR p_status = '' THEN
        SET p_status = v_status;
    END IF;

    -- Update data di database
    UPDATE Pesanan
    SET total_harga = p_total_harga,
        STATUS = p_status
    WHERE id_pesanan = p_id;
END //
DELIMITER ;

SET @id = 1;
SET @total = 70000; 
SET @status = 'Belum Dibayar';   


CALL UpdateFieldTransaksi(@id, @total, @status);

SELECT @total AS total_harga_terpakai, @status AS status_terpakai;

SELECT * FROM Pesanan WHERE id_pesanan = @id;


-- 5. Menghapus data dari tabel master (Menu, Pelanggan, atau Karyawan) berdasarkan ID.
DELIMITER //
CREATE PROCEDURE DeleteEntriesByIDMaster(
    IN p_table VARCHAR(50),
    IN p_id INT,
    OUT p_status VARCHAR(100)
)
BEGIN
    DECLARE v_query TEXT;

    IF p_table = 'Menu' THEN
        SET v_query = CONCAT('DELETE FROM Menu WHERE id_menu = ?');
    ELSEIF p_table = 'Pelanggan' THEN
        SET v_query = CONCAT('DELETE FROM Pelanggan WHERE id_pelanggan = ?');
    ELSEIF p_table = 'Karyawan' THEN
        SET v_query = CONCAT('DELETE FROM Karyawan WHERE id_karyawan = ?');
    ELSE
        SET p_status = 'Tabel tidak valid';
        SET v_query = NULL;
    END IF;

    IF v_query IS NOT NULL THEN
        SET @sql = v_query;
        SET @id = p_id;

        PREPARE stmt FROM @sql;
        EXECUTE stmt USING @id;
        DEALLOCATE PREPARE stmt;

        SET p_status = 'Data berhasil dihapus';
    END IF;
END//
DELIMITER ;

SET @id = 1;
SET @table = 'Menu'; 
SET @status = '';

CALL DeleteEntriesByIDMaster(@table, @id, @status);

SELECT @status AS hasil_penghapusan;

SELECT * FROM menu;


DROP PROCEDURE DeleteEntriesByIDMaster;


