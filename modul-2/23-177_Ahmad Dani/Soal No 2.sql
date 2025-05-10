-- Soal No 1
USE pa_smbd

CREATE VIEW view_kost_pemilik AS
SELECT
    kost.id_kost,
    kost.nama_kost,
    pemilik.nama_pemilik,
    pemilik.kontak
FROM kost
JOIN pemilik ON kost.id_pemilik = pemilik.id_pemilik;

-- Soal No 2
CREATE VIEW view_info_kost_lengkap AS
SELECT
    kost.id_kost,
    kost.nama_kost,
    pemilik.nama_pemilik,
    informasi_kamar.harga_perbulan,
    informasi_kamar.jumlah_kamar,
    informasi_kamar.deskripsi AS deskripsi_kamar
FROM kost
JOIN pemilik ON kost.id_pemilik = pemilik.id_pemilik
JOIN informasi_kamar ON kost.id_kost = informasi_kamar.id_kost;

-- Soal No 3
CREATE VIEW view_kost_murah AS
SELECT
    kost.nama_kost,
    informasi_kamar.harga_perbulan
FROM kost
JOIN informasi_kamar ON kost.id_kost = informasi_kamar.id_kost
WHERE informasi_kamar.harga_perbulan < 1000000;

-- Soal No 4 (Rata rata harga kost per pemilik)
CREATE VIEW view_rata_rata_harga_kost AS
SELECT
    pemilik.nama_pemilik,
    AVG(informasi_kamar.harga_perbulan) AS rata_rata_harga
FROM pemilik
JOIN kost ON pemilik.id_pemilik = kost.id_pemilik
JOIN informasi_kamar ON kost.id_kost = informasi_kamar.id_kost
GROUP BY pemilik.nama_pemilik;

-- Soal No 5
CREATE VIEW view_fasilitas_per_kost AS
SELECT
    kost.nama_kost,
    fasilitas.nama_fasilitas
FROM kost
JOIN fasilitas_kost ON kost.id_kost = fasilitas_kost.id_kost
JOIN fasilitas ON fasilitas.id_fasilitas = fasilitas_kost.id_fasilitas
ORDER BY kost.nama_kost;

SELECT * FROM view_kost_pemilik
SELECT * FROM view_info_kost_lengkap
SELECT * FROM view_kost_murah
SELECT * FROM view_rata_rata_harga_kost
SELECT * FROM view_fasilitas_per_kost


-- Test
SELECT 
    nama_kost,
    GROUP_CONCAT(nama_fasilitas SEPARATOR ', ') AS daftar_fasilitas
FROM view_fasilitas_per_kost
GROUP BY nama_kost;
