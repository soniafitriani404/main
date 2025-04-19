-- VIEW 1: Gabungan minimal 2 tabel
CREATE VIEW view_produk_terjual AS
SELECT 
    dp.id_detail,
    p.nama_produk,
    dp.jumlah,
    dp.subtotal
FROM 
    DetailPenjualan dp
JOIN 
    Produk p ON dp.id_produk = p.id_produk;

-- VIEW 2: Gabungan minimal 3 tabel
CREATE VIEW view_penjualan_lengkap AS
SELECT 
    pj.id_penjualan,
    pj.tanggal,
    pl.nama_pelanggan,
    ky.nama_karyawan,
    pr.nama_produk,
    dp.jumlah,
    dp.subtotal
FROM 
    Penjualan pj
JOIN 
    Pelanggan pl ON pj.id_pelanggan = pl.id_pelanggan
JOIN 
    Karyawan ky ON pj.id_karyawan = ky.id_karyawan
JOIN 
    DetailPenjualan dp ON pj.id_penjualan = dp.id_penjualan
JOIN 
    Produk pr ON dp.id_produk = pr.id_produk;

-- VIEW 3: Gabungan 2 tabel dengan kondisi tertentu
CREATE VIEW view_penjualan_diatas_100rb AS
SELECT 
    pj.id_penjualan,
    pj.tanggal,
    pj.total,
    pl.nama_pelanggan
FROM 
    Penjualan pj
JOIN 
    Pelanggan pl ON pj.id_pelanggan = pl.id_pelanggan
WHERE 
    pj.total > 100000;

-- VIEW 4: Fungsi agregasi dari 2 tabel
CREATE VIEW view_total_penjualan_per_produk AS
SELECT 
    pr.nama_produk,
    SUM(dp.jumlah) AS total_terjual,
    SUM(dp.subtotal) AS total_pendapatan
FROM 
    DetailPenjualan dp
JOIN 
    Produk pr ON dp.id_produk = pr.id_produk
GROUP BY 
    pr.nama_produk;

-- VIEW 5: View bermanfaat tambahan
CREATE VIEW view_stok_menipis AS
SELECT 
    id_produk,
    nama_produk,
    stok
FROM 
    Produk
WHERE 
    stok < 10;
    
SELECT * FROM view_produk_terjual;
SELECT * FROM view_penjualan_lengkap;
SELECT * FROM view_penjualan_diatas_100rb;
SELECT * FROM view_total_penjualan_per_produk;
SELECT * FROM view_stok_menipis;
