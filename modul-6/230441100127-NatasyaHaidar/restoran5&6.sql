-- Membuat database
CREATE DATABASE restoran_56;
USE restoran_56;

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

-- Menambahkan data untuk tabel Menu (Master)
INSERT INTO Menu (nama_menu, kategori, harga, stok, deskripsi) VALUES
('Nasi Goreng Seafood', 'Makanan', 30000, 25, 'Nasi goreng dengan seafood pilihan'),
('Mie Goreng Spesial', 'Makanan', 22000, 18, 'Mie goreng dengan ayam, bakso, dan telur'),
('Teh Tawar', 'Minuman', 3000, 40, 'Teh tawar tanpa gula'),
('Jus Jeruk', 'Minuman', 10000, 15, 'Jus jeruk segar dengan pulp'),
('Kopi Hitam', 'Minuman', 8000, 10, 'Kopi hitam dengan cita rasa pahit khas');

-- Menambahkan data untuk tabel Pelanggan (Master)
INSERT INTO Pelanggan (nama, no_hp, email, alamat) VALUES
('Dewi Putri', '081234567891', 'dewi@gmail.com', 'Jl. Suka No.8'),
('Joko Santoso', '081987654321', 'joko@ymail.com', 'Jl. Satria No.7'),
('Maya Arista', '081122334455', 'maya@gmail.com', 'Jl. Indah No.11'),
('Toni Pratama', '081334455667', 'toni@outlook.com', 'Jl. Merdeka No.30'),
('Andi J', '081234567890', 'Andi@gmail.com', 'Jl. Merdeka No. 10' );

-- Menambahkan data untuk tabel Karyawan (Master)
INSERT INTO Karyawan (nama, jabatan, no_hp) VALUES
('Joni Hidayat', 'Kasir', '081212123123'),
('Fauzan Ridwan', 'Pelayan', '081223234234'),
('Dewi Lestari', 'Koki', '081234345345');

-- Menambahkan data untuk tabel Pesanan (Transaksi)
INSERT INTO Pesanan (id_pelanggan, id_karyawan, total_harga, STATUS) VALUES
(1, 1, 70000, 'Lunas'),
(2, 2, 25000, 'Belum Dibayar'),
(3, NULL, 15000, 'Lunas'),
(4, 3, 10000, 'Lunas');

-- Menambahkan data untuk tabel Detail_Pesanan (Transaksi)
INSERT INTO Detail_Pesanan (id_pesanan, id_menu, jumlah, subtotal) VALUES
(1, 1, 1, 30000),
(1, 3, 2, 14000),
(2, 2, 1, 22000),
(3, 4, 1, 10000),
(4, 5, 1, 8000);

-- Menambahkan transaksi lebih dari 1 tahun
INSERT INTO Pesanan (id_pelanggan, id_karyawan, total_harga, STATUS, tanggal) VALUES
(2, 2, 20000, 'Lunas', '2023-03-10 10:00:00'),
(3, 1, 40000, 'Belum Dibayar', '2022-05-15 08:30:00');



SELECT * FROM menu;
SELECT * FROM pelanggan;
SELECT * FROM pesanan;
SELECT * FROM karyawan;
SELECT * FROM detail_pesanan;


-- 1. Menampilkan Pesanan Berdasarkan Lama Waktu (1 minggu / 1 bulan / 3 bulan)
DELIMITER //

CREATE PROCEDURE TampilPesananBerdasarkanLama(
    IN lama VARCHAR(10)
)
BEGIN
    IF lama = 'SEMINGGU' THEN
        SELECT * FROM Pesanan
        WHERE tanggal >= NOW() - INTERVAL 7 DAY;
    ELSEIF lama = '1 BULAN' THEN
        SELECT * FROM Pesanan
        WHERE tanggal >= NOW() - INTERVAL 1 MONTH;
    ELSEIF lama = '3 BULAN' THEN
        SELECT * FROM Pesanan
        WHERE tanggal >= NOW() - INTERVAL 3 MONTH;
    END IF;
END //

DELIMITER ;

CALL TampilPesananBerdasarkanLama('1 BULAN');
SELECT * FROM pesanan;


-- 2. Hapus Pesanan Lebih dari 1 Tahun Jika Sudah Lunas
DELIMITER //

CREATE PROCEDURE HapusPesananLama()
BEGIN
    DELETE FROM Pesanan
    WHERE tanggal < NOW() - INTERVAL 1 YEAR
    AND STATUS = 'Lunas';
END //

DELIMITER ;

CALL HapusPesananLama();
SELECT * FROM Pesanan;

-- 3. mengubah status maksimal 7 pesanan pertama yang masih 'Belum Dibayar'.
DELIMITER //

CREATE PROCEDURE UpdateStatusTransaksi()
BEGIN
    UPDATE Pesanan
    SET STATUS = 'Lunas'
    WHERE STATUS = 'Belum Dibayar'
    LIMIT 7;
END //

DELIMITER ;

CALL UpdateStatusTransaksi();
SELECT id_pesanan, STATUS FROM Pesanan ORDER BY id_pesanan;


-- 4. Edit Data Pelanggan Hanya Jika Tidak Ada Transaksi
DELIMITER //
CREATE PROCEDURE EditPelanggan(
    IN pid INT,
    IN pnama VARCHAR(100),
    IN pno_hp VARCHAR(15),
    IN pemail VARCHAR(100),
    IN palamat TEXT
)
BEGIN
    UPDATE Pelanggan p
    LEFT JOIN Pesanan ps ON ps.id_pelanggan = p.id_pelanggan
    SET p.nama = pnama, p.no_hp = pno_hp, p.email = pemail, p.alamat = palamat
    WHERE p.id_pelanggan = pid AND ps.id_pesanan IS NULL;
END //
DELIMITER ;


CALL EditPelanggan(2, 'wandono', '081111111111', 'wandono@gmail.com', 'jl.setro');
CALL EditPelanggan(5, 'ade', '0813824569503', 'ade@email.com', 'jl.laban');

SELECT * FROM Pelanggan WHERE id_pelanggan = 2;
SELECT * FROM Pelanggan WHERE id_pelanggan = 5;

SELECT * FROM Pelanggan;



-- 5. Melakukan update status pesanan bulan ini dengan logika branching (percabangan) dalam 1 Bulan Terakhir
ALTER TABLE Pesanan MODIFY STATUS ENUM('Belum Dibayar', 'Lunas', 'Non-Aktif', 'Pasif', 'Aktif') DEFAULT 'Belum Dibayar';


DELIMITER //

CREATE PROCEDURE UpdateStatusTransaksiBulanIni()
BEGIN
    DECLARE id_terkecil INT DEFAULT NULL;
    DECLARE id_sedang INT DEFAULT NULL;
    DECLARE id_terbesar INT DEFAULT NULL;
    DECLARE total INT;

    DROP TEMPORARY TABLE IF EXISTS TransaksiBulanIni;
    CREATE TEMPORARY TABLE TransaksiBulanIni AS
    SELECT p.id_pesanan, SUM(dp.jumlah) AS total_item, SUM(dp.subtotal) AS total_harga
    FROM Detail_Pesanan dp
    JOIN Pesanan p ON dp.id_pesanan = p.id_pesanan
    WHERE p.tanggal >= NOW() - INTERVAL 1 MONTH
    GROUP BY p.id_pesanan;

    -- Hitung jumlah transaksi
    SELECT COUNT(*) INTO total FROM TransaksiBulanIni;

    -- Ambil id transaksi jumlah item paling sedikit
    SELECT id_pesanan INTO id_terkecil
    FROM TransaksiBulanIni
    ORDER BY total_item ASC
    LIMIT 1;

    -- Ambil id transaksi jumlah item sedang (hanya jika ada >= 3 transaksi)
    IF total >= 3 THEN
        SELECT id_pesanan INTO id_sedang
        FROM TransaksiBulanIni
        ORDER BY total_item ASC
        LIMIT 1 OFFSET 1;
    END IF;

    -- Ambil id transaksi dengan total harga paling besar
    SELECT id_pesanan INTO id_terbesar
    FROM TransaksiBulanIni
    ORDER BY total_harga DESC
    LIMIT 1;

    -- Update status sesuai ketentuan soal
    IF id_terkecil IS NOT NULL THEN
        UPDATE Pesanan SET STATUS = 'Non-Aktif' WHERE id_pesanan = id_terkecil;
    END IF;

    IF id_sedang IS NOT NULL THEN
        UPDATE Pesanan SET STATUS = 'Pasif' WHERE id_pesanan = id_sedang;
    END IF;

    IF id_terbesar IS NOT NULL THEN
        UPDATE Pesanan SET STATUS = 'Aktif' WHERE id_pesanan = id_terbesar;
    END IF;

    DROP TEMPORARY TABLE IF EXISTS TransaksiBulanIni;
END //

DELIMITER ;

CALL UpdateStatusTransaksiBulanIni();

-- Lihat hasil update
SELECT id_pesanan, total_harga, STATUS 
FROM Pesanan 
WHERE tanggal >= NOW() - INTERVAL 1 MONTH;


-- 6. Menghitung jumlah pesanan yang sudah lunas dalam 1 bulan terakhir, dengan looping
DELIMITER //

CREATE PROCEDURE HitungTransaksiLunas()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE jumlah INT DEFAULT 0;
    DECLARE v_id INT;

    DECLARE cur CURSOR FOR
        SELECT id_pesanan FROM Pesanan
        WHERE STATUS = 'Lunas' AND tanggal >= NOW() - INTERVAL 1 MONTH;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET jumlah = jumlah + 1;
    END LOOP;

    CLOSE cur;

    SELECT CONCAT('Jumlah transaksi lunas 1 bulan terakhir: ', jumlah) AS info;
END //

DELIMITER ;


CALL HitungTransaksiLunas();


SELECT COUNT(*) FROM Pesanan
WHERE STATUS = 'Lunas' AND tanggal >= NOW() - INTERVAL 1 MONTH;

