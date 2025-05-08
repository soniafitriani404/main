USE restoran_4;



-- 1. Menambahkan kolom keterangan diakhir tabel menu
ALTER TABLE Pesanan ADD keterangan VARCHAR(100);

UPDATE Pesanan SET keterangan = 'natasya' WHERE id_pesanan = 1;

SELECT * FROM pesanan;

-- 2. Menampilkan Data Pesanan Bersama Nama Pelanggan
SELECT 
    p.id_pesanan,
    pl.nama AS nama_pelanggan,
    p.tanggal,
    p.total_harga,
    p.status
FROM 
    Pesanan p
JOIN 
    Pelanggan pl ON p.id_pelanggan = pl.id_pelanggan;


-- 3. Urutan Kolom pada Tabel
SELECT * FROM Menu ORDER BY harga ASC;
SELECT * FROM Pesanan ORDER BY tanggal DESC;
SELECT * FROM Karyawan ORDER BY nama;

-- 4. Mengubah Tipe Data Kolom (harga diubah ke INT)
ALTER TABLE Menu MODIFY harga INT;

DESC Menu;


-- 5. 
-- left join : Menampilkan semua pesanan meskipun tidak ada karyawannya (id_karyawan NULL), tetap ditampilkan.
SELECT 
    p.id_pesanan,
    pel.nama AS pelanggan,
    k.nama AS karyawan
FROM Pesanan p
LEFT JOIN Karyawan k ON p.id_karyawan = k.id_karyawan
JOIN Pelanggan pel ON p.id_pelanggan = pel.id_pelanggan;


-- right join : Menampilkan semua karyawan, bahkan jika mereka belum menangani pesanan.
SELECT 
    Karyawan.nama AS karyawan,
    Pesanan.id_pesanan,
    Pesanan.status
FROM 
    Pesanan
RIGHT JOIN Karyawan ON Pesanan.id_karyawan = Karyawan.id_karyawan;


-- self join : Bandingkan karyawan dengan jabatan yang sama
SELECT 
	a.nama AS karyawan1, 
	b.nama AS karyawan2, 
	a.jabatan
FROM 
	Karyawan a
JOIN Karyawan b ON a.jabatan = b.jabatan
WHERE a.id_karyawan < b.id_karyawan;


-- 6. Kode dengan Operator Perbandingan
-- 1. Harga lebih dari 20000
SELECT * FROM Menu WHERE harga > 20000;

-- 2. Stok kurang dari 15
SELECT * FROM Menu WHERE stok < 15;

-- 3. Pesanan dengan total_harga lebih dari atau sama dengan 30000
SELECT * FROM Pesanan WHERE total_harga >= 30000;

-- 4. Pesanan dengan status selain 'Lunas'
SELECT * FROM Pesanan WHERE STATUS != 'Lunas';

-- 5. Detail pesanan dengan jumlah antara 1 dan 2
SELECT * FROM Detail_Pesanan WHERE jumlah BETWEEN 1 AND 2;
