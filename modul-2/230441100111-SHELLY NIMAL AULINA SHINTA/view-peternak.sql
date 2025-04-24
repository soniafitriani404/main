-- Buatlah view yang menampilkan data gabungan dari minimal 2 tabel dalam database yang sudah dikembangkan pada modul sebelumnya
-- menampilkan data bebek beserta kandangnya
CREATE VIEW view_bebek_kandang AS
SELECT 
	b.id_bebek,
	b.kode_bebek,
	b.jenis_bebek,
	k.nama_kandang, 
	k.lokasi
FROM 
	bebek b
JOIN 
	kandang k ON b.id_kandang = k.id_kandang;
	

-- Buatlah view yang menampilkan data gabungan dari minimal 3 tabel dalam database yang sudah dikembangkan pada modul sebelumnya
-- gabungan tabel detail_pembelian,pembeli dan produksi telur
CREATE VIEW view_pembelian_telur AS
SELECT 
    d.id_pembelian,
    p.nama_pembeli,
    pt.tanggal_produksi_telur,
    d.tanggal AS tanggal_pembelian,
    d.jumlah_telur,
    d.harga_satuan,
    d.total_harga
FROM detail_pembelian d
JOIN pembeli p ON d.id_pembeli = p.id_pembeli
JOIN produksi_telur pt ON d.id_produksi = pt.id_produksi;
-- menampilkan informasi pembelian tekur oleh pembeli, disertai tanggal produksinya

-- Buatlah view yang menampilkan data dari minimal 2 tabel, tetapi hanya menampilkan data yang memenuhi syarat tertentu dalam database yang sudah dikembangkan pada modul sebelumnya
-- menampilkan bebek yang bertipe 'bebek berelur' dan informasi kandangnya
CREATE VIEW view_bebek_petelur AS
SELECT 
    b.kode_bebek,
    b.jenis_bebek,
    k.nama_kandang,
    k.lokasi
FROM bebek b
JOIN kandang k ON b.id_kandang = k.id_kandang
WHERE b.jenis_bebek = 'Bebek Petelur';


-- Buatlah view yang menampilkan hasil dari fungsi agregasi (SUM, AVG, COUNT, MIN, atau MAX) pada data yang berasal dari minimal 2 tabel dalam database yang sudah dikembangkan pada modul sebelumnya
-- menampilkan hitungan total pakan yang diberikan untuk setiap kandang 
CREATE VIEW view_total_pakan_per_kandang AS
SELECT 
    k.nama_kandang,
    k.lokasi,
    SUM(p.jumlah_pakan) AS total_pakan_kg,
    COUNT(p.id_pakan) AS jumlah_pemberian_pakan
FROM pakan_harian p
JOIN kandang k ON p.id_kandang = k.id_kandang
GROUP BY k.nama_kandang, k.lokasi;


-- Buatlah sebuah view yang menurut kalian berguna dalam database yang sudah dikembangkan pada modul sebelumnya kalian bebas menentukan data apa yang ingin ditampilkan, tetapi pastikan view tersebut memiliki manfaat dalam menganalisis atau menampilkan informasi yang relevan.
-- memberikan ringkasan penting tentang jumlah bebek, produksi telur, penjualan dan pendapatan per kandang
CREATE VIEW view_ringkasan_kandang AS
SELECT 
    k.nama_kandang,
    k.lokasi,
    COUNT(DISTINCT b.id_bebek) AS jumlah_bebek,
    SUM(pt.jumlah_telur) AS total_produksi_telur,
    SUM(dp.jumlah_telur) AS total_telur_terjual,
    SUM(dp.total_harga) AS total_pendapatan
FROM kandang k
LEFT JOIN bebek b ON k.id_kandang = b.id_kandang
LEFT JOIN produksi_telur pt ON k.id_kandang = pt.id_kandang
LEFT JOIN detail_pembelian dp ON pt.id_produksi = dp.id_produksi
GROUP BY k.nama_kandang, k.lokasi;


