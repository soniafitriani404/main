--  1 View Gabungan dari Minimal 2 Tabel --

CREATE VIEW view_user_transaksi AS
SELECT 
    u.nama,
    u.email,
    t.kode_transaksi,
    t.tanggal_pesan,
    t.metode_pembayaran,
    t.status_pembayaran
FROM USER u
JOIN Transaksi t ON u.id_user = t.id_user;

-- 2 View Gabungan dari Minimal 3 Tabel --

CREATE VIEW view_transaksi_jadwal_film AS
SELECT 
    t.kode_transaksi,
    f.judul AS nama_film,
    j.tanggal,
    j.jam,
    t.total_bayar
FROM Transaksi t
JOIN Jadwal j ON t.jadwal_id = j.jadwal_id
JOIN Film f ON j.id_film = f.id_film;

-- 3 View dengan Syarat Tertentu --

CREATE VIEW view_transaksi_lunas AS
SELECT 
    t.kode_transaksi,
    u.nama,
    j.tanggal,
    f.judul,
    t.total_bayar
FROM Transaksi t
JOIN USER u ON t.id_user = u.id_user
JOIN Jadwal j ON t.jadwal_id = j.jadwal_id
JOIN Film f ON j.id_film = f.id_film
WHERE t.status_pembayaran = 'Lunas';

-- 4 View dengan Fungsi Agregasi --

CREATE VIEW view_pendapatan_film AS
SELECT 
    f.judul AS nama_film,
    COUNT(t.transaksi_id) AS jumlah_transaksi,
    SUM(t.total_bayar) AS total_pendapatan
FROM Transaksi t
JOIN Jadwal j ON t.jadwal_id = j.jadwal_id
JOIN Film f ON j.id_film = f.id_film
WHERE t.status_pembayaran = 'Lunas'
GROUP BY f.judul;

-- 5 View Custom (Bebas + Berguna) --

CREATE VIEW view_kursi_dipesan AS
SELECT 
    t.kode_transaksi,
    u.nama AS nama_pemesan,
    f.judul AS film,
    j.tanggal,
    k.kode_kursi
FROM Detail_Transaksi dt
JOIN Transaksi t ON dt.transaksi_id = t.transaksi_id
JOIN USER u ON t.id_user = u.id_user
JOIN Jadwal j ON t.jadwal_id = j.jadwal_id
JOIN Film f ON j.id_film = f.id_film
JOIN Kursi k ON dt.id_kursi = k.id_kursi;

SELECT * FROM view_user_transaksi;
SELECT * FROM view_transaksi_jadwal_film;
SELECT * FROM view_transaksi_lunas;
SELECT * FROM view_pendapatan_film;
SELECT * FROM view_kursi_dipesan;
