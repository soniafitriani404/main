USE pa_smbd

DESC 

SHOW TABLES
DESC pemilik

-- soal no 1
ALTER TABLE pemilik ADD COLUMN keterangan TEXT AFTER alamat

-- soal no 2 (menampilkan informasi kost)
SELECT
  kost.nama_kost,
  kost.alamat,
  informasi_kamar.harga_perbulan,
  informasi_kamar.jumlah_kamar,
  informasi_kamar.deskripsi
FROM kost
JOIN informasi_kamar ON kost.id_kost = informasi_kamar.id_kost;

-- soal no 3
-- order by
SELECT nama_kost, alamat FROM kost
ORDER BY nama_kost ASC

-- desc
SELECT id_kost, harga_perbulan FROM informasi_kamar
ORDER BY harga_perbulan DESC;

-- default asc
SELECT * FROM fasilitas ORDER BY nama_fasilitas;

-- Soal no 4
DESC pemilik

ALTER TABLE pemilik
MODIFY COLUMN kontak VARCHAR(30) NOT NULL;

-- soal no 5
-- left join (menampilkan semua kost & info kamarnya jika ada)
SELECT kost.nama_kost, informasi_kamar.harga_perbulan
FROM kost
LEFT JOIN informasi_kamar ON kost.id_kost = informasi_kamar.id_kost;

-- right join (Menampilkan semua pemilik beserta kost yang mereka miliki, jika ada)
SELECT
    pemilik.nama_pemilik,
    kost.nama_kost
FROM kost
RIGHT JOIN
    pemilik ON kost.id_pemilik = pemilik.id_pemilik;

-- selft join  
SELECT 
    A.nama_kost AS kost_1,
    B.nama_kost AS kost_2,
    A.id_pemilik
FROM kost A
JOIN kost B 
    ON A.id_pemilik = B.id_pemilik 
    AND A.id_kost <> B.id_kost
ORDER BY A.id_pemilik;

-- Soal no 6
SELECT * FROM kost WHERE nama_kost = 'Mawar Asri';
SELECT * FROM informasi_kamar WHERE harga_perbulan > 500000;
SELECT * FROM informasi_kamar WHERE jumlah_kamar < 8;
SELECT * FROM pemilik WHERE id_pemilik >= 2;
SELECT * FROM fasilitas WHERE nama_fasilitas != 'AC';





