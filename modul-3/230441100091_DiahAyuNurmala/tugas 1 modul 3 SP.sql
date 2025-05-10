USE db_umkm;

-- 1. Menambahkan data ke tabel umkm.
DELIMITER //

CREATE PROCEDURE AddUMKM (
    IN p_nama_usaha VARCHAR(100),
    IN p_jumlah_karyawan INT
)
BEGIN
    INSERT INTO umkm (nama_usaha, jumlah_karyawan)
    VALUES (p_nama_usaha, p_jumlah_karyawan);
END//

DELIMITER ;

CALL AddUMKM('Toko Maju Jaya', 15);

SELECT * FROM umkm;

-- 2. Memperbarui nama kategori UMKM berdasarkan ID.
DELIMITER //

CREATE PROCEDURE UpdateKategoriUMKM (
    IN p_id_kategori INT,
    IN p_nama_baru VARCHAR(50)
)
BEGIN
    UPDATE kategori_umkm
    SET nama_kategori = p_nama_baru
    WHERE id_kategori = p_id_kategori;
END//

DELIMITER ;

CALL UpdateKategoriUMKM(2, 'Kerajinan Lokal');

SELECT * FROM kategori_umkm;

-- 3. Menghapus pemilik UMKM berdasarkan ID.
DELIMITER //

CREATE PROCEDURE DeletePemilikUMKM(IN p_id_pemilik INT)
BEGIN
    -- Hapus data produk terlebih dahulu yang terkait dengan UMKM milik pemilik ini
    DELETE FROM produk_umkm
    WHERE id_umkm IN (
        SELECT id_umkm FROM umkm WHERE id_pemilik = p_id_pemilik
    );

    -- Hapus UMKM milik pemilik ini
    DELETE FROM umkm WHERE id_pemilik = p_id_pemilik;

    -- Hapus pemilik UMKM
    DELETE FROM pemilik_umkm WHERE id_pemilik = p_id_pemilik;
END //

DELIMITER ;

CALL DeletePemilikUMKM(3);

SELECT * FROM pemilik_umkm;


-- 4. Menambahkan produk ke tabel produk_umkm.
DELIMITER //

CREATE PROCEDURE AddProduk (
    IN p_id_umkm INT,
    IN p_nama_produk VARCHAR(100),
    IN p_harga DECIMAL(10,2)
)
BEGIN
    INSERT INTO produk_umkm (id_umkm, nama_produk, harga)
    VALUES (p_id_umkm, p_nama_produk, p_harga);
END//

DELIMITER ;

CALL AddProduk(1, 'Kopi Arabika', 45000.00);

SELECT * FROM produk_umkm WHERE id_umkm = 1;

-- 5. Mengambil data UMKM berdasarkan ID dan mengembalikannya melalui parameter OUT.
DELIMITER //

CREATE PROCEDURE GetUMKMByID (
    IN p_id_umkm INT,
    OUT p_nama_usaha VARCHAR(100),
    OUT p_jumlah_karyawan INT
)
BEGIN
    SELECT nama_usaha, jumlah_karyawan
    INTO p_nama_usaha, p_jumlah_karyawan
    FROM umkm
    WHERE id_umkm = p_id_umkm;
END//

DELIMITER ;

-- Buat variabel untuk OUT-nya
SET @nama_usaha = '';
SET @jumlah_karyawan = 0;

-- Panggil prosedurnya
CALL GetUMKMByID(1, @nama_usaha, @jumlah_karyawan);

-- Tampilkan hasil OUT-nya
SELECT @nama_usaha AS nama_usaha, @jumlah_karyawan AS jumlah_karyawan;