USE db_studio_foto;

-- 1. Menambahkan kolom keterangan pada tabel Pemesanan
ALTER TABLE Pemesanan
ADD COLUMN keterangan TEXT;

-- 2. Gabungan 2 tabel: Pemesanan dan Pembayaran
SELECT 
    Pemesanan.pemesanan_id, 
    Pemesanan.tanggal_pesan, 
    Pemesanan.jam_pesan, 
    Pembayaran.total_bayar, 
    Pembayaran.metode_pembayaran
FROM 
    Pemesanan
INNER JOIN 
    Pembayaran 
ON 
    Pemesanan.pemesanan_id = Pembayaran.pemesanan_id;

-- 3. Urutan Kolom dengan ORDER BY, DESC, dan ASC:
-- Mengurutkan harga paket secara menurun (DESC)
SELECT * FROM Paket
ORDER BY harga DESC;

-- Mengurutkan harga paket secara menaik (ASC)
SELECT * FROM Paket
ORDER BY harga ASC;

-- 4. Perubahan pada tipe data: Mengubah tipe data no_hp menjadi VARCHAR(20)
ALTER TABLE Pelanggan
MODIFY COLUMN no_hp VARCHAR(20);

-- 5. Kode LEFT JOIN, RIGHT JOIN, dan SELF JOIN:

-- LEFT JOIN antara Pelanggan dan Pemesanan
SELECT 
    Pelanggan.nama, 
    Pemesanan.tanggal_pesan 
FROM 
    Pelanggan
LEFT JOIN 
    Pemesanan 
ON 
    Pelanggan.pelanggan_id = Pemesanan.pelanggan_id;

-- RIGHT JOIN antara Pembayaran dan Pemesanan
SELECT 
    Pemesanan.pemesanan_id, 
    Pembayaran.total_bayar
FROM 
    Pembayaran
RIGHT JOIN 
    Pemesanan 
ON 
    Pembayaran.pemesanan_id = Pemesanan.pemesanan_id;

-- SELF JOIN pada Fotografer_Paket untuk melihat fotografer yang menangani paket yang sama
SELECT 
    F1.nama AS Fotografer_1, 
    F2.nama AS Fotografer_2
FROM 
    Fotografer_Paket FP1
INNER JOIN 
    Fotografer_Paket FP2
ON 
    FP1.paket_id = FP2.paket_id
INNER JOIN 
    Fotografer F1
ON 
    FP1.fotografer_id = F1.fotografer_id
INNER JOIN 
    Fotografer F2
ON 
    FP2.fotografer_id = F2.fotografer_id;

-- 6. Operator Perbandingan:
-- Menampilkan pemesanan dengan total bayar lebih dari 200000
SELECT * FROM Pembayaran
WHERE total_bayar > 200000;

-- Menampilkan pemesanan dengan harga paket kurang dari atau sama dengan 250000
SELECT * FROM Pemesanan
JOIN Paket ON Pemesanan.paket_id = Paket.paket_id
WHERE Paket.harga <= 250000;

-- Menampilkan pelanggan yang memiliki nomor telepon yang tidak sama dengan yang terdaftar
SELECT * FROM Pelanggan
WHERE no_hp != '083356789012';

-- Menampilkan pemesanan yang terjadi setelah tanggal tertentu
SELECT * FROM Pemesanan
WHERE tanggal_pesan > '2025-04-08';

-- Menampilkan pembayaran yang menggunakan metode QRIS
SELECT * FROM Pembayaran
WHERE metode_pembayaran = 'QRIS';
