 ALTER TABLE Barang ADD keterangan VARCHAR(255);

SELECT Penjualan.id_penjualan, Pelanggan.nama, Penjualan.tanggal
FROM Penjualan
JOIN Pelanggan ON Penjualan.id_pelanggan = Pelanggan.id_pelanggan;

-- ASC
SELECT * FROM Barang
ORDER BY nama_barang ASC;

-- DESC
SELECT * FROM Penjualan
ORDER BY tanggal DESC;

ALTER TABLE Barang
MODIFY harga DECIMAL(10,2);

SELECT Pelanggan.nama, Penjualan.tanggal
FROM Pelanggan
LEFT JOIN Penjualan ON Pelanggan.id_pelanggan = Penjualan.id_pelanggan;

SELECT Penjualan.id_penjualan, Pegawai.nama
FROM Penjualan
RIGHT JOIN Pegawai ON Penjualan.id_pegawai = Pegawai.id_pegawai;

SELECT A.nama AS Pegawai1, B.nama AS Pegawai2
FROM Pegawai A, Pegawai B
WHERE A.id_pegawai <> B.id_pegawai;

-- 1. Sama dengan (=)
SELECT * FROM Barang WHERE harga = 50000;

-- 2. Tidak sama dengan (!=)
SELECT * FROM Barang WHERE harga != 100000;

-- 3. Lebih besar dari (>)
SELECT * FROM Barang WHERE harga > 75000;

-- 4. Kurang dari (<)
SELECT * FROM Barang WHERE stok < 10;

-- 5. Lebih besar atau sama dengan (>=)
SELECT * FROM Barang WHERE harga >= 50000;

