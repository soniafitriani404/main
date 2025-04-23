
----------------------------------------------MODUL 4--------------------------------------------------------------------


-- # No. 1 Kolom keterangan di salah satu tabel pada bagian akhir tabel tersebut!

ALTER TABLE perawatan
ADD COLUMN keterangan TEXT;

UPDATE perawatan
SET keterangan = 'Dilakukan pada pagi hari'
WHERE id_perawatan = 1;

UPDATE perawatan
SET keterangan = 'Menggunakan pupuk organik'
WHERE id_perawatan = 2;

UPDATE perawatan
SET keterangan = 'Menggunakan alat manual'
WHERE id_perawatan = 3;

UPDATE perawatan
SET keterangan = 'Dilakukan secara rutin setiap dua hari'
WHERE id_perawatan = 4;

UPDATE perawatan
SET keterangan = 'Menggunakan alat semprot otomatis'
WHERE id_perawatan = 5;

UPDATE perawatan
SET keterangan = 'Menggunakan pupuk NPK'
WHERE id_perawatan = 6;

UPDATE perawatan
SET keterangan = 'Penyemprotan dilakukan dua kali'
WHERE id_perawatan = 7;

UPDATE perawatan
SET keterangan = 'Pembersihan dilakukan oleh dua orang'
WHERE id_perawatan = 8;

UPDATE perawatan
SET keterangan = 'Penyiraman dilakukan sore hari'
WHERE id_perawatan = 9;

UPDATE perawatan
SET keterangan = 'Menggunakan cangkul untuk membersihkan gulma'
WHERE id_perawatan = 10;


SELECT * FROM perawatan



--------------------------------------------------------------------------------------------------------------------------------------

-- # No. 2 Gabungan 2 tabel yang memungkinkan dan memiliki fungsi pada penerapannya!

SELECT 
    bm.id_bawang,
    bm.tanggal_panen,
    bm.berat_kg AS total_berat_panen,
    dp.jumlah_kg AS jumlah_terjual,
    dp.harga_per_kg,
    (dp.jumlah_kg * dp.harga_per_kg) AS total_penjualan,
    p.nama_pembeli,
    p.kontak_pembeli
FROM bawang_merah bm
JOIN detail_pembelian dp ON bm.id_bawang = dp.id_bawang
JOIN pembeli p ON dp.id_pembeli = p.id_pembeli
ORDER BY bm.tanggal_panen ASC, total_penjualan DESC;


bawang_merah digabung dengan detail_pembelian berdasarkan id_bawang
detail_pembelian digabung lagi dengan pembeli berdasarkan id_pembeli

--------------------------------------------------------------------------------------------------

-- # No. 3 Urutan kolom pada setiap tabel menggunakan perintah Order By, DESC, dan ASC
(minimal 1 untuk setiap perintah) 

SELECT * FROM petani
ORDER BY nama_petani ASC;

SELECT * FROM lahan
ORDER BY luas DESC;

SELECT * FROM perawatan
ORDER BY tanggal_perawatan ASC;

SELECT * FROM bawang_merah
ORDER BY berat_kg DESC;

SELECT * FROM pembeli
ORDER BY nama_pembeli DESC;

SELECT * FROM detail_pembelian
ORDER BY tanggal_pembelian DESC;


-----------------------------------------------------------------------------------------------------


-- #  No. 4 Perubahan pada salah satu tipe data yang dapat berguna
-- dari varchar => enum

ALTER TABLE perawatan
MODIFY COLUMN jenis_perawatan ENUM(
    'Penyemprotan', 
    'Pemupukan', 
    'Penyiangan', 
    'Penyiraman', 
    'Pembersihan Gulma'
);


SELECT * FROM perawatan



---------------------------------------------------------------------------------------------------------------

-- # No. 5 Kode Left Join, Right Join dan Self Join beserta dengan alur prosesnya


--- KIRI ---

SELECT p.nama_petani, l.lokasi, l.luas
FROM petani p
LEFT JOIN lahan l ON p.id_petani = l.id_petani;


Tabel petani ada di sebelah kiri.
Tabel lahan ada di kanan join.



--- KANAN ---

SELECT l.lokasi, p.nama_petani
FROM petani p
RIGHT JOIN lahan l ON p.id_petani = l.id_petani;



l.lokasi dari kolom lokalahan dari tabel lahan
p.nama_petani dari kolom nama petani dari tabel petani

--- DIRI SENDIRI---

SELECT 
  p1.nama_petani AS petani_1,
  p2.nama_petani AS petani_2,
  p1.alamat
FROM petani p1
JOIN petani p2 ON p1.alamat = p2.alamat
WHERE p1.id_petani != p2.id_petani;

JOINn dilakukan berdasarkan alamat yang sama
kondisi agar tidak membandingkan petani yang sama:

-----------------------------------------------------------------------------------------------

-- # No. 6 Kode yang mengandung operator perbandingan (Minimal 5)

SELECT * FROM petani
WHERE nama_petani = 'Lestari Ayuningtyas';

SELECT * FROM bawang_merah
WHERE berat_kg > 170.00;

SELECT * FROM lahan
WHERE luas < 2.00;

SELECT * FROM detail_pembelian
WHERE harga_per_kg >= 25500;

SELECT * FROM perawatan
WHERE tanggal_perawatan <= '2025-03-01';

SELECT * FROM pembeli
WHERE nama_pembeli != 'PT Pangan Nusantara';

SELECT * FROM pembeli
WHERE nama_pembeli <> 'PT Pangan Nusantara';

SELECT * FROM bawang_merah
WHERE berat_kg BETWEEN 150 AND 180;

SELECT p.nama_petani
FROM petani p
WHERE p.nama_petani LIKE'A%'

SELECT 
    p.nama_pembeli,
    p.kontak_pembeli
FROM pembeli p
WHERE p.nama_pembeli LIKE 'Toko%';

SELECT 
    p.nama_pembeli,
    p.kontak_pembeli
FROM pembeli p
WHERE p.nama_pembeli LIKE '%Segar';

SELECT 
    p.nama_pembeli,
    p.kontak_pembeli
FROM pembeli p
WHERE p.nama_pembeli LIKE '%Tani%';


SELECT * FROM petani
WHERE nama_petani IS NULL;




    
