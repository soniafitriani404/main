---SOAL NO.1 Buatlah vieww yang menampilkan dataa gabungan dari minimal 2 tabel dalam databasee yang 
sudah dikembangkan pada modul sebelumnya

CREATE VIEW vw_panen_lahan AS
SELECT 
    bm.id_bawang,
    bm.tanggal_panen,
    bm.berat_kg,
    l.lokasi,
    l.luas
FROM 
    bawang_merah bm
JOIN 
    lahan l ON bm.id_lahan = l.id_lahan;
    
    ---Menghubungkan kedua tabel berdasarkan kolom id_lahan yang sama.

-----------------------------------------------------------------------------------------------------------


---SOAL NO.2 Buatlah vieww yang menampilkan dataa gabungan dari minimal 3 tabel dalam databasee yang 
sudah dikembangkan pada modul sebelumnya  

CREATE VIEW vw_transaksi_pembelian AS
SELECT 
    dp.id_detail,
    dp.tanggal_pembelian,
    p.nama_pembeli,
    bm.tanggal_panen,
    dp.jumlah_kg,
    dp.harga_per_kg,
    (dp.jumlah_kg * dp.harga_per_kg) AS total_harga
FROM 
    detail_pembelian dp
JOIN 
    bawang_merah bm ON dp.id_bawang = bm.id_bawang
JOIN 
    pembeli p ON dp.id_pembeli = p.id_pembeli;

--dp detail pembelian
--------------------------------------------------------------------------------------------------------


SOAL NO.3 Buatlah vieww yang menampilkan dataa dari minimal 2 tabel, tetapi hanya menampilkan dataa 
yang memenuhi syarat tertentu dalam databasee yang sudah dikembangkan pada modul 
sebelumnya 

CREATE VIEW vw_pembelian_besar AS
SELECT 
    dp.id_detail,
    p.nama_pembeli,
    dp.jumlah_kg,
    dp.harga_per_kg,
    dp.tanggal_pembelian
FROM 
    detail_pembelian dp
JOIN 
    pembeli p ON dp.id_pembeli = p.id_pembeli
WHERE 
    dp.jumlah_kg >= 120;


---------------------------------------------------------------------------------------------------------


---SOAL NO.4 Buatlah vieww yang menampilkan hasil dari fungsi agregasi (SUM, AVG, COUNT, MIN, 
atau MAX) pada dataa yang berasal dari minimal 2 tabel dalam databasee yang sudah 
dikembangkan pada modul sebelumnya  

CREATE VIEW vw_statistik_panen_petani AS
SELECT 
    pt.nama_petani,
    MIN(bm.berat_kg) AS min_berat,
    MAX(bm.berat_kg) AS max_berat,
    AVG(bm.berat_kg) AS rata_rata_berat
FROM 
    petani pt
JOIN 
    lahan l ON pt.id_petani = l.id_petani
JOIN 
    bawang_merah bm ON l.id_lahan = bm.id_lahan
GROUP BY 
    pt.nama_petani;

--------------------------------------------------------------------------------------------------------


---SOAL NO.5 Buatlah sebuah VIEW yang menurut kalian berguna dalam DATABASE yang sudah 
dikembangkan pada modul sebelumnya kalian bebas menentukan DATA apa yang ingin 
ditampilkan, tetapi pastikan VIEW tersebut memiliki manfaat dalam menganalisis atau 
menampilkan informasi yang relevan. 

CREATE VIEW vw_ringkasan_perawatan AS
SELECT 
    pt.nama_petani,
    COUNT(pw.id_perawatan) AS jumlah_perawatan,
    GROUP_CONCAT(DISTINCT l.lokasi SEPARATOR ', ') AS lokasi_dirawat
FROM 
    perawatan pw
JOIN 
    petani pt ON pw.id_petani = pt.id_petani
JOIN 
    lahan l ON pw.id_lahan = l.id_lahan
GROUP BY 
    pt.nama_petani;
--mengelompokkan hasil dari nama petani    
--mwnghitung jumlah baris id perawatan dri tabel perawatan
--count menghitung jumlah baris 
--group concatt mengambil nilai dari kolom lokasi dari tabel lahan



