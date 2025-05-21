USE aksesoris_cewek;
-- soal 1--
ALTER TABLE tbl_produk
ADD COLUMN keterangan TEXT;
SHOW COLUMNS FROM tbl_produk;


-- soal 2--
SELECT 
    p.id_produk, p.nama_produk, p.harga, p.stok,
    k.nama_kategori
FROM tbl_produk p
JOIN tbl_kategori k ON p.id_kategori = k.id_kategori;

-- soal 3--
SELECT * FROM tbl_produk
ORDER BY harga ASC;

SELECT * FROM tbl_produk
ORDER BY stok DESC;

-- soal 4--
ALTER TABLE tbl_produk
MODIFY COLUMN stok SMALLINT;
SHOW COLUMNS FROM tbl_produk;


-- soal 5--
-- leef--
SELECT 
    p.nama_produk, k.nama_kategori
FROM tbl_produk p
LEFT JOIN tbl_kategori k ON p.id_kategori = k.id_kategori;

-- right --
SELECT 
    p.nama_produk, k.nama_kategori
FROM tbl_produk p
RIGHT JOIN tbl_kategori k ON p.id_kategori = k.id_kategori;

-- self --
SELECT 
    A.nama_produk AS produk_1,
    B.nama_produk AS produk_2,
    A.harga
FROM tbl_produk A
JOIN tbl_produk B ON A.harga = B.harga
WHERE A.id_produk < B.id_produk;

SELECT id_produk, nama_produk, harga
FROM tbl_produk;

-- soal 6--
SELECT * FROM tbl_produk
WHERE 
    harga > 100000 AND     -- lebih dari 100 ribu
    stok < 10 AND          -- stok di bawah 10
    harga <= 250000 AND    -- harga maksimal 250 ribu
    id_kategori != 2 AND   -- bukan kategori id 2
    stok BETWEEN 5 AND 10; -- stok antara 5 sampai 10
