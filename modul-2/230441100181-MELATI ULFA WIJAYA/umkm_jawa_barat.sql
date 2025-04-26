-- soal 1 --
-- Menampilkan informasi lengkap UMKM --
CREATE VIEW view_umkm_detail AS
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

-- soal 2 --
-- Buat view bernama view_pemilik_dan_usaha yang menampilkan NIK, nama lengkap --
-- pemilik, jenis kelamin, nomor telepon, email, serta nama usaha yang dimiliki--
CREATE VIEW view_pemilik_dan_usaha AS
SELECT 
    p.nik,
    p.nama_lengkap,
    p.jenis_kelamin,
    p.nomor_telepon,
    p.email,
    u.nama_usaha
FROM 
    pemilik_umkm p
JOIN 
    umkm u ON p.id_pemilik = u.id_pemilik;
    
SELECT * FROM view_pemilik_dan_usaha;

-- soal 3 --
-- Buat view bernama view_produk_umkm yang menampilkan nama usaha, nama produk,--
-- deskripsi produk, dan harga dengan menghubungkan tabel umkm dan produk_umkm --
CREATE VIEW view_produk_umkm AS
SELECT 
    u.nama_usaha,
    pr.nama_produk,
    pr.deskripsi_produk,
    pr.harga
FROM produk_umkm pr
JOIN umkm u ON pr.id_umkm = u.id_umkm;

SELECT * FROM view_produk_umkm;

-- soal 4 --
-- Buat view bernama view_umkm_menengah yang menampilkan daftar UMKM dengan --
-- skala usaha Menengah, beserta informasi nama usaha, nama pemilik, total aset, dan omzet per tahun--
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

SELECT * FROM view_umkm_menengah;

-- soal 5 --
-- Buat view bernama view_umkm_per_kota yang menampilkan jumlah UMKM di setiap --
-- kabupaten/kota, dengan menampilkan nama kabupaten/kota dan jumlah UMKM yangterdaftar -- 
CREATE VIEW view_umkm_per_kota AS
SELECT 
    kk.nama_kabupaten_kota,
    COUNT(u.id_umkm) AS jumlah_umkm
FROM umkm u
JOIN kabupaten_kota kk ON u.id_kabupaten_kota = kk.id_kabupaten_kota
GROUP BY kk.nama_kabupaten_kota;
SELECT * FROM view_umkm_per_kota;