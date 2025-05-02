CREATE VIEW view_umkm_detail AS
SELECT 
    u.nama_usaha,
    p.nama_lengkap AS nama_pemilik,
    k.nama_kategori AS kategori_umkm,
    s.nama_skala AS skala_usaha,
    ktk.nama_kabupaten_kota AS nama_kabupaten_kota,
    u.tahun_berdiri
FROM umkm u
JOIN pemilik_umkm p ON u.id_pemilik = p.id_pemilik
JOIN kategori_umkm k ON u.id_kategori = k.id_kategori
JOIN skala_umkm s ON u.id_skala = s.id_skala
JOIN kabupaten_kota ktk ON u.id_kabupaten_kota = ktk.id_kabupaten_kota;


CREATE VIEW view_pemilik_dan_usaha AS
SELECT 
    p.nik,
    p.nama_lengkap,
    p.jenis_kelamin,
    p.nomor_telepon,
    p.email,
    u.nama_usaha
FROM pemilik_umkm p
JOIN umkm u ON p.id_pemilik = u.id_pemilik;


CREATE VIEW view_produk_umkm AS
SELECT 
    u.nama_usaha,
    pr.nama_produk,
    pr.deskripsi_produk,
    pr.harga
FROM produk_umkm pr
JOIN umkm u ON pr.id_umkm = u.id_umkm;


CREATE VIEW view_umkm_menengah AS
SELECT 
    u.nama_usaha,
    p.nama_lengkap AS nama_pemilik,
    u.total_aset,
    u.omzet_per_tahun
FROM umkm u
JOIN pemilik_umkm p ON u.id_pemilik = p.id_pemilik
JOIN skala_umkm s ON u.id_skala = s.id_skala
WHERE s.nama_skala = 'Menengah';



CREATE VIEW view_umkm_per_kota AS
SELECT 
    ktk.nama_kabupaten_kota,
    COUNT(u.id_umkm) AS jumlah_umkm
FROM kabupaten_kota ktk
LEFT JOIN umkm u ON ktk.id_kabupaten_kota = u.id_kabupaten_kota
GROUP BY ktk.id_kabupaten_kota;

DROP VIEW view_produk_umkm;
DROP VIEW view_pemilik_dan_usaha;
DROP VIEW view_umkm_detail;
DROP VIEW view_umkm_menengah;
DROP VIEW view_umkm_per_kota;
