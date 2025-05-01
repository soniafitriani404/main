USE stok_penjualan;

-- 1. Menambahkan kolom keterangan di tabel Produk
ALTER TABLE Produk ADD COLUMN keterangan VARCHAR(255);

-- 2. Gabungan dua tabel: Penjualan dan Pelanggan (untuk melihat data penjualan beserta nama pelanggan)
CREATE VIEW view_penjualan_pelanggan AS
SELECT 
    p.id_penjualan,
    pl.nama_pelanggan,
    p.tanggal,
    p.total
FROM 
    Penjualan p
JOIN 
    Pelanggan pl ON p.id_pelanggan = pl.id_pelanggan;

-- 3. Urutan kolom menggunakan ORDER BY dengan DESC dan ASC
SELECT * FROM Produk ORDER BY harga DESC;  -- Mengurutkan produk berdasarkan harga secara menurun
SELECT * FROM Karyawan ORDER BY nama_karyawan ASC;  -- Mengurutkan karyawan berdasarkan nama secara naik

-- 4. Mengubah tipe data kolom pada tabel Penjualan (misalnya mengubah kolom total dari DECIMAL menjadi DOUBLE)
ALTER TABLE Penjualan MODIFY COLUMN total DOUBLE;

-- 5. Gabungan LEFT JOIN, RIGHT JOIN, dan SELF JOIN
-- LEFT JOIN: Menampilkan semua penjualan meskipun tidak ada pelanggan yang sesuai
SELECT * FROM Penjualan p LEFT JOIN Pelanggan pl ON p.id_pelanggan = pl.id_pelanggan;

-- RIGHT JOIN: Menampilkan semua pelanggan meskipun tidak ada penjualan yang sesuai
SELECT * FROM Penjualan p RIGHT JOIN Pelanggan pl ON p.id_pelanggan = pl.id_pelanggan;

-- SELF JOIN: Menampilkan hubungan antara karyawan yang berbeda (misalnya supervisor vs kasir)
SELECT k1.nama_karyawan AS supervisor, k2.nama_karyawan AS kasir
FROM Karyawan k1, Karyawan k2
WHERE k1.posisi = 'Supervisor' AND k2.posisi = 'Kasir';

-- 6. Menggunakan operator perbandingan
SELECT * FROM Produk WHERE harga > 100000;  -- Produk dengan harga lebih besar dari 100000
SELECT * FROM Produk WHERE stok <= 10;  -- Produk dengan stok kurang dari atau sama dengan 10
SELECT * FROM Penjualan WHERE total BETWEEN 200000 AND 500000;  -- Penjualan dengan total antara 200000 dan 500000
SELECT * FROM Pelanggan WHERE alamat LIKE '%No. 10';  -- Pelanggan yang alamatnya mengandung 'No. 10'
SELECT * FROM Karyawan WHERE no_telp LIKE '08%';  -- Karyawan dengan nomor telepon yang diawali dengan '08'
