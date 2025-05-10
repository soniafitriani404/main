CREATE VIEW view_penyewa_kamera AS
SELECT 
    p.penyewa_id,
    p.nama AS nama_penyewa,
    k.kamera_id,
    k.merk,
    ds.tanggal_pinjam,
    ds.tanggal_kembali
FROM detail_sewa ds
JOIN penyewa p ON ds.penyewa_id = p.penyewa_id
JOIN kamera k ON ds.kamera_id = k.kamera_id;

CREATE VIEW view_detail_transaksi AS
SELECT 
    p.nama AS nama_penyewa,
    k.merk AS nama_kamera,
    ds.tanggal_pinjam,
    ds.tanggal_kembali,
    t.total,
    t.metode_pembayaran
FROM transaksi t
JOIN detail_sewa ds ON t.detail_sewa_id = ds.detail_sewa_id
JOIN penyewa p ON ds.penyewa_id = p.penyewa_id
JOIN kamera k ON ds.kamera_id = k.kamera_id;

CREATE VIEW view_sewa_aktif AS
SELECT 
    p.nama AS nama_penyewa,
    k.merk AS kamera_disewa,
    ds.tanggal_pinjam,
    ds.tanggal_kembali
FROM detail_sewa ds
JOIN penyewa p ON ds.penyewa_id = p.penyewa_id
JOIN kamera k ON ds.kamera_id = k.kamera_id
WHERE ds.tanggal_kembali >= CURDATE();

CREATE VIEW view_total_pemasukan_per_kamera AS
SELECT 
    k.kamera_id,
    k.merk,
    SUM(t.total) AS total_pemasukan
FROM transaksi t
JOIN detail_sewa ds ON t.detail_sewa_id = ds.detail_sewa_id
JOIN kamera k ON ds.kamera_id = k.kamera_id
GROUP BY k.kamera_id, k.merk;

CREATE VIEW view_laporan_denda AS
SELECT 
    p.nama AS nama_penyewa,
    k.merk AS kamera_disewa,
    d.jenis_denda,
    d.jumlah_denda,
    d.keterangan
FROM denda d
JOIN detail_sewa ds ON d.detail_sewa_id = ds.detail_sewa_id
JOIN penyewa p ON ds.penyewa_id = p.penyewa_id
JOIN kamera k ON ds.kamera_id = k.kamera_id;

SELECT * FROM view_penyewa_kamera;
SELECT * FROM view_detail_transaksi;
SELECT * FROM view_sewa_aktif;
SELECT * FROM view_total_pemasukan_per_kamera;
SELECT * FROM view_laporan_denda;