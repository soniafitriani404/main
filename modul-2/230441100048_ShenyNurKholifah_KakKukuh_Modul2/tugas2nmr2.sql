CREATE OR REPLACE VIEW view_produk_pelanggan AS
SELECT 
    p.nama_pelanggan,
    pr.nama_produk,
    pr.harga,
    pr.stok,
    d.jumlah,
    d.subtotal
FROM tbl_detail_transaksi d
JOIN tbl_transaksi t ON d.id_transaksi = t.id_transaksi
JOIN tbl_pelanggan p ON t.id_pelanggan = p.id_pelanggan
JOIN tbl_produk pr ON d.id_produk = pr.id_produk;


CREATE OR REPLACE VIEW view_transaksi_pelanggan_produk AS
SELECT 
    t.id_transaksi,
    p.nama_pelanggan,
    pr.nama_produk,
    pr.harga,
    d.jumlah,
    d.subtotal,
    t.tanggal_transaksi
FROM tbl_transaksi t
JOIN tbl_pelanggan p ON t.id_pelanggan = p.id_pelanggan
JOIN tbl_detail_transaksi d ON t.id_transaksi = d.id_transaksi
JOIN tbl_produk pr ON d.id_produk = pr.id_produk;


CREATE OR REPLACE VIEW view_produk_terlaris AS
SELECT 
    pr.nama_produk,
    SUM(d.jumlah) AS total_terjual
FROM tbl_detail_transaksi d
JOIN tbl_produk pr ON d.id_produk = pr.id_produk
GROUP BY pr.nama_produk
HAVING SUM(d.jumlah) > 0; 



CREATE OR REPLACE VIEW view_total_penjualan_per_pelanggan AS
SELECT 
    p.nama_pelanggan,
    SUM(t.total_harga) AS total_penjualan
FROM tbl_transaksi t
JOIN tbl_pelanggan p ON t.id_pelanggan = p.id_pelanggan
GROUP BY p.nama_pelanggan;

CREATE OR REPLACE VIEW view_kategori_terlaris AS
SELECT 
    k.nama_kategori,
    SUM(d.subtotal) AS total_penjualan_kategori
FROM tbl_detail_transaksi d
JOIN tbl_produk pr ON d.id_produk = pr.id_produk
JOIN tbl_kategori k ON pr.id_kategori = k.id_kategori
GROUP BY k.nama_kategori
ORDER BY total_penjualan_kategori DESC
LIMIT 1;

SELECT * FROM view_produk_pelanggan;
SELECT * FROM view_transaksi_pelanggan_produk;
SELECT * FROM view_produk_terlaris;
SELECT * FROM view_total_penjualan_per_pelanggan; 
SELECT * FROM view_kategori_terlaris;


