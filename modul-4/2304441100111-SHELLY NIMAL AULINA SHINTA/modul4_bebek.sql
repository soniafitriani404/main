----------------------------------------------MODUL 4--------------------------------------------------------------------

-- # No. 1 Kolom keterangan di salah satu tabel pada bagian akhir tabel tersebut!

ALTER TABLE produksi_telur
ADD COLUMN keterangan TEXT;

UPDATE produksi_telur
SET keterangan = 'Produksi normal'
WHERE id_produksi = 1;

UPDATE produksi_telur
SET keterangan = 'Ada peningkatan produksi'
WHERE id_produksi = 2;

UPDATE produksi_telur
SET keterangan = 'Produksi menurun karena cuaca'
WHERE id_produksi = 3;

UPDATE produksi_telur
SET keterangan = 'Produksi stabil'
WHERE id_produksi = 4;

UPDATE produksi_telur
SET keterangan = 'Puncak produksi'
WHERE id_produksi = 5;

UPDATE produksi_telur
SET keterangan = 'Ada beberapa telur rusak'
WHERE id_produksi = 6;v

UPDATE produksi_telur
SET keterangan = 'Produksi sangat baik'
WHERE id_produksi = 7;

UPDATE produksi_telur
SET keterangan = 'Produksi rata-rata'
WHERE id_produksi = 8;

UPDATE produksi_telur
SET keterangan = 'Ada gangguan listrik'
WHERE id_produksi = 9;

UPDATE produksi_telur
SET keterangan = 'Rekor produksi tertinggi'
WHERE id_produksi = 10;

SELECT * FROM produksi_telur;

--------------------------------------------------------------------------------------------------------------------------------------

-- # No. 2 Gabungan 2 tabel yang memungkinkan dan memiliki fungsi pada penerapannya!

SELECT 
    pt.id_produksi,
    pt.tanggal_produksi_telur,
    pt.jumlah_telur,
    dp.jumlah_telur AS jumlah_terjual,
    dp.harga_satuan,
    (dp.jumlah_telur * dp.harga_satuan) AS total_penjualan,
    pb.nama_pembeli,
    pb.no_hp
FROM produksi_telur pt
JOIN detail_pembelian dp ON pt.id_produksi = dp.id_produksi
JOIN pembeli pb ON dp.id_pembeli = pb.id_pembeli
ORDER BY pt.tanggal_produksi_telur ASC, total_penjualan DESC;

-- produksi_telur digabung dengan detail_pembelian berdasarkan id_produksi
-- detail_pembelian digabung lagi dengan pembeli berdasarkan id_pembeli

--------------------------------------------------------------------------------------------------

-- # No. 3 Urutan kolom pada setiap tabel menggunakan perintah Order By, DESC, dan ASC
-- (minimal 1 untuk setiap perintah) 

SELECT * FROM peternak
ORDER BY nama_peternak ASC;

SELECT * FROM kandang
ORDER BY kapasitas DESC;

SELECT * FROM pakan_harian
ORDER BY tanggal ASC;

SELECT * FROM produksi_telur
ORDER BY jumlah_telur DESC;

SELECT * FROM pembeli
ORDER BY nama_pembeli DESC;

SELECT * FROM detail_pembelian
ORDER BY tanggal DESC;

-----------------------------------------------------------------------------------------------------

-- # No. 4 Perubahan pada salah satu tipe data yang dapat berguna
-- dari varchar => enum

ALTER TABLE bebek
MODIFY COLUMN jenis_bebek ENUM('Bebek Pedaging', 'Bebek Petelur', 'Bebek Hias');

SELECT * FROM bebek;

---------------------------------------------------------------------------------------------------------------

-- # No. 5 Kode Left Join, Right Join dan Self Join beserta dengan alur prosesnya

--- LEFT JOIN ---
SELECT p.nama_peternak, k.nama_kandang, k.lokasi
FROM peternak p
LEFT JOIN kandang k ON p.id_peternak = k.id_peternak;

-- Tabel peternak ada di sebelah kiri.
-- Tabel kandang ada di kanan join.

--- RIGHT JOIN ---
SELECT k.lokasi, p.nama_peternak
FROM peternak p
RIGHT JOIN kandang k ON p.id_peternak = k.id_peternak;

-- k.lokasi dari kolom lokasi dari tabel kandang
-- p.nama_peternak dari kolom nama peternak dari tabel peternak

--- SELF JOIN ---
SELECT 
  p1.nama_pembeli AS pembeli_1,
  p2.nama_pembeli AS pembeli_2,
  p1.alamat
FROM pembeli p1
JOIN pembeli p2 ON p1.alamat = p2.alamat
WHERE p1.id_pembeli != p2.id_pembeli;

-- JOIN dilakukan berdasarkan alamat yang sama
-- kondisi WHERE agar tidak membandingkan pembeli dengan dirinya sendiri

-----------------------------------------------------------------------------------------------

-- # No. 6 Kode yang mengandung operator perbandingan (Minimal 5)

SELECT * FROM peternak
WHERE nama_peternak = 'Lina Maya';

-- lebih besar dari 250
SELECT * FROM produksi_telur
WHERE jumlah_telur > 250;

-- lebih kecil dari 120
SELECT * FROM kandang
WHERE kapasitas < 120;

-- Transaksi pembelian dengan harga minimal Rp 1.500 per telur
SELECT * FROM detail_pembelian
WHERE harga_satuan >= 1500;

--  Data pemberian pakan hingga tanggal 1 Maret 2025
SELECT * FROM pakan_harian
WHERE tanggal <= '2025-03-01';

-- data yang tidak ada melati
SELECT * FROM pembeli
WHERE nama_pembeli != 'Melati';

SELECT * FROM pembeli
WHERE nama_pembeli <> 'Melati';

-- Produksi telur antara 200-250 butir (termasuk 200 dan 250)
SELECT * FROM produksi_telur
WHERE jumlah_telur BETWEEN 200 AND 250;


-- menampilkan nama yang depannya a
SELECT p.nama_peternak
FROM peternak p
WHERE p.nama_peternak LIKE 'A%';

SELECT 
    pb.nama_pembeli,
    pb.no_hp
FROM pembeli pb
WHERE pb.nama_pembeli LIKE 'A%';

-- menampilkan nama yang belakangnya a
SELECT 
    pb.nama_pembeli,
    pb.no_hp
FROM pembeli pb
WHERE pb.nama_pembeli LIKE '%a';

-- menampilkan nama yang mengandung an
SELECT 
    pb.nama_pembeli,
    pb.no_hp
FROM pembeli pb
WHERE pb.nama_pembeli LIKE '%an%';

