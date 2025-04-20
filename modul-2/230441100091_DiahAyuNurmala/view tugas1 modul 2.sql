CREATE VIEW v_umkm_detail AS
SELECT 
    u.nama_usaha,
    p.nama_lengkap AS nama_pemilik,
    k.nama_kategori,
    s.nama_skala,
    kk.nama_kabupaten_kota,
    u.tahun_berdiri
FROM umkm u
JOIN pemilik_umkm p ON u.id_pemilik = p.id_pemilik
JOIN kategori_umkm k ON u.id_kategori = k.id_kategori
JOIN skala_umkm s ON u.id_skala = s.id_skala
JOIN kabupaten_kota kk ON u.id_kabupaten_kota = kk.id_kabupaten_kota;


CREATE VIEW v_pemilik_dan_usaha AS
SELECT 
    p.nik,
    p.nama_lengkap,
    p.jenis_kelamin,
    p.nomor_telepon,
    p.email,
    u.nama_usaha
FROM pemilik_umkm p
JOIN umkm u ON p.id_pemilik = u.id_pemilik;

CREATE VIEW v_produk_umkm AS
SELECT 
    u.nama_usaha,
    pr.nama_produk,
    pr.deskripsi_produk,
    pr.harga
FROM produk_umkm pr
JOIN umkm u ON pr.id_umkm = u.id_umkm;

CREATE VIEW v_umkm_menengah AS
SELECT 
    u.nama_usaha,
    p.nama_lengkap AS nama_pemilik,
    u.total_aset,
    u.omzet_per_tahun
FROM umkm u
JOIN skala_umkm s ON u.id_skala = s.id_skala
JOIN pemilik_umkm p ON u.id_pemilik = p.id_pemilik
WHERE s.nama_skala = 'Menengah';

CREATE VIEW v_umkm_per_kota AS
SELECT 
    kk.nama_kabupaten_kota,
    COUNT(u.id_umkm) AS jumlah_umkm
FROM kabupaten_kota kk
LEFT JOIN umkm u ON kk.id_kabupaten_kota = u.id_kabupaten_kota
GROUP BY kk.nama_kabupaten_kota;


SELECT * FROM v_umkm_detail;
SELECT * FROM v_pemilik_dan_usaha;
SELECT * FROM v_produk_umkm;
SELECT * FROM v_umkm_menengah;
SELECT * FROM v_umkm_per_kota;

