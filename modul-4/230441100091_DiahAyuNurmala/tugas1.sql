USE db_penyewaan_kamera;

-- 1. Tambahkan kolom keterangan ke tabel kamera
ALTER TABLE kamera ADD keterangan TEXT;
SELECT * FROM kamera;

-- 2. Gabungan dua tabel: penyewa dan detail_sewa
SELECT p.nama, p.no_tlp, d.tanggal_pinjam, d.tanggal_kembali, d.jumlah, d.harga_perhari
FROM penyewa p
JOIN detail_sewa d ON p.penyewa_id = d.penyewa_id;

-- 3. ORDER BY ASC/DESC/ASC
SELECT * FROM kamera ORDER BY harga_sewa_perhari ASC;
SELECT * FROM transaksi ORDER BY total DESC;
SELECT * FROM penyewa ORDER BY nama ASC;

-- 4. Perubahan tipe data no_tlp agar bisa menampung nomor lebih panjang
ALTER TABLE penyewa MODIFY no_tlp VARCHAR(30);
SELECT * FROM penyewa;


-- 5a. LEFT JOIN: Menampilkan semua kamera, meskipun tidak ada spesifikasi
SELECT k.merk, s.resolusi, s.sensor
FROM kamera k
LEFT JOIN spesifikasi s ON k.kamera_id = s.kamera_id;

-- 5b. RIGHT JOIN: Menampilkan semua spesifikasi, meskipun kamera tidak tersedia
SELECT s.resolusi, s.sensor, k.merk
FROM spesifikasi s
RIGHT JOIN kamera k ON s.kamera_id = k.kamera_id;

-- 5c. SELF JOIN: Menampilkan pasangan penyewa yang memiliki nama depan yang sama
SELECT p1.nama AS penyewa1, p2.nama AS penyewa2
FROM penyewa p1
JOIN penyewa p2 ON LEFT(p1.nama, 3) = LEFT(p2.nama, 3)
WHERE p1.penyewa_id < p2.penyewa_id;

-- 6. Operator Perbandingan

-- a. Kamera dengan harga sewa lebih dari 160000
SELECT * FROM kamera WHERE harga_sewa_perhari > 160000;

-- b. Kamera dengan stok kurang dari atau sama dengan 3
SELECT * FROM kamera WHERE stok <= 3;

-- c. Transaksi dengan total tidak sama dengan 330000
SELECT * FROM transaksi WHERE total <> 330000;

-- d. Denda lebih besar atau sama dengan 75000
SELECT * FROM denda WHERE jumlah_denda >= 75000;

-- e. Detail sewa dengan jumlah antara 1 dan 2
SELECT * FROM detail_sewa WHERE jumlah >= 1 AND jumlah <= 2;
