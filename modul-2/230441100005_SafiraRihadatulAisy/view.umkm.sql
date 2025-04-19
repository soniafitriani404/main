-- View 1: Menampilkan detail lengkap UMKM
CREATE VIEW view_umkm_detail AS
SELECT 
    u.nama_usaha,
    p.nama_lengkap AS nama_pemilik,
    k.nama_kategori AS kategori_umkm,
    s.nama_skala AS skala_usaha,
    kk.nama_kabupaten_kota,
    u.tahun_berdiri
FROM umkm u
JOIN pemilik_umkm p ON u.id_pemilik = p.id
JOIN kategori_umkm k ON u.id_kategori = k.id
JOIN skala_umkm s ON u.id_skala = s.id
JOIN kabupaten_kota kk ON u.id_kabupaten_kota = kk.id;

-- View 2: Menampilkan data pemilik dan usaha yang dimiliki
CREATE VIEW view_pemilik_dan_usaha AS
SELECT 
    p.nik,
    p.nama_lengkap,
    p.jenis_kelamin,
    p.nomor_telepon,
    p.email,
    u.nama_usaha
FROM pemilik_umkm p
JOIN umkm u ON p.id = u.id_pemilik;

-- View 3: Menampilkan produk UMKM dan informasi usahanya
CREATE VIEW view_produk_umkm AS
SELECT 
    u.nama_usaha,
    pr.nama_produk,
    pr.deskripsi_produk,
    pr.harga
FROM produk_umkm pr
JOIN umkm u ON pr.id_umkm = u.id;

-- View 4: Menampilkan UMKM dengan skala usaha Menengah
CREATE VIEW view_umkm_menengah AS
SELECT 
    u.nama_usaha,
    p.nama_lengkap AS nama_pemilik,
    u.total_aset,
    u.omzet_per_tahun
FROM umkm u
JOIN skala_umkm s ON u.id_skala = s.id
JOIN pemilik_umkm p ON u.id_pemilik = p.id
WHERE s.nama_skala = 'Menengah';

-- View 5: Menampilkan jumlah UMKM per kabupaten/kota
CREATE VIEW view_umkm_per_kota AS
SELECT 
    kk.nama_kabupaten_kota,
    COUNT(u.id) AS jumlah_umkm
FROM umkm u
JOIN kabupaten_kota kk ON u.id_kabupaten_kota = kk.id
GROUP BY kk.nama_kabupaten_kota;
