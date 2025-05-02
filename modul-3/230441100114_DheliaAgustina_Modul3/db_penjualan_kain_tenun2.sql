CREATE DATABASE db_penjualan_kain_tenun;

USE db_penjualan_kain_tenun;

CREATE TABLE tbl_Pelanggan(
	id_pelanggan INT PRIMARY KEY,
	nama VARCHAR(50) NOT NULL,
	alamat VARCHAR(100),
	no_telepon VARCHAR(20)
);

INSERT INTO tbl_Pelanggan VALUES (101, 'Ibu Sari', 'Jl. Kenanga No.10', '081234567890')
INSERT INTO tbl_Pelanggan VALUES(102, 'Bapak Ahmad', 'Jl. Melati No.5', '085612345678')
INSERT INTO tbl_Pelanggan VALUES(103, 'Bu Rina', 'Jl. Mawar No.3', '089876543210')

SELECT * FROM tbl_Pelanggan;


CREATE TABLE tbl_ProdukKain(
	id_kain INT PRIMARY KEY,
	nama_kain VARCHAR(50),
	harga INT,
	stok INT
);

INSERT INTO tbl_ProdukKain VALUES (201, 'Tenun Ikat Sumba', 250000, 10)
INSERT INTO tbl_ProdukKain VALUES (202, 'Tenun Troso', 300000, 5)
INSERT INTO tbl_ProdukKain VALUES (203, 'Tenun Endek Bali', 200000, 15)

SELECT * FROM tbl_ProdukKain;

CREATE TABLE tbl_Pegawai(
	id_pegawai INT PRIMARY KEY,
	nama_pegawai VARCHAR(50),
	jabatan VARCHAR(50)
);

INSERT INTO tbl_Pegawai VALUES (301, 'Dewi Lestari', 'Kasir')
INSERT INTO tbl_Pegawai VALUES (302, 'Rudi Hartono', 'Admin')
INSERT INTO tbl_Pegawai VALUES (303, 'Ayu Pratiwi', 'Sales')

SELECT * FROM tbl_Pegawai;

CREATE TABLE tbl_Penjualan(
	id_penjualan INT PRIMARY KEY,
	id_pelanggan INT UNIQUE NOT NULL,
	id_pegawai INT UNIQUE NOT NULL,
	tanggal DATE,
	total INT
);

INSERT INTO tbl_Penjualan VALUES (401, 101, 301, '2025-04-01', 500000)
INSERT INTO tbl_Penjualan VALUES (402, 102, 302, '2025-04-02', 300000)

SELECT * FROM tbl_Penjualan;

CREATE TABLE tbl_DetailPenjualan(
	id_detail INT PRIMARY KEY,
	id_penjualan INT UNIQUE NOT NULL,
	id_kain INT UNIQUE NOT NULL,
	jumlah INT,
	subtotal INT
);

INSERT INTO tbl_DetailPenjualan VALUES (501, 401, 201, 2, 500000.00)
INSERT INTO tbl_DetailPenjualan VALUES (502, 402, 203, 1, 200000.00)

SELECT * FROM tbl_DetailPenjualan;


-- no 1 menampilkan tabel pegawai dan penjualan
CREATE VIEW view_penjualan_pegawai AS 
SELECT 
	pj.id_penjualan, 
	pj.tanggal AS Tanggal_Penjualan, 
	pj.total AS Total_Penjualan, 
	pg.nama_pegawai AS Nama_Pegawai, 
	pg.jabatan AS Jabatan
FROM tbl_Penjualan pj
JOIN tbl_Pegawai pg ON pj.id_pegawai = pg.id_pegawai;

SELECT * FROM view_penjualan_pegawai;

-- no 2 menampilkan tabel pegawai,penjualan, dan detail penjualan
CREATE VIEW view_detail_penjualan_pegawai AS 
SELECT 
	pj.id_penjualan, 
	pj.tanggal AS Tanggal_Penjualan, 
	pj.total AS Total_Penjualan, 
	pg.nama_pegawai AS Nama_Pegawai, 
	pg.jabatan AS Jabatan, 
	dp.jumlah AS Jumlah_Kain, 
	dp.subtotal AS Subtotal
FROM tbl_Penjualan pj
JOIN tbl_Pegawai pg ON pj.id_pegawai = pg.id_pegawai
JOIN tbl_DetailPenjualan dp ON pj.id_penjualan = dp.id_penjualan;

SELECT * FROM view_detail_penjualan_pegawai;


-- no 3 menampilkan tabel pelanggan dan tabel pegawai dengan syarat hanya menampilkan data penjualan yang dilakukan oleh pegawai dengan jabatan 'Kasir'.
CREATE VIEW view_pelanggan_kasir AS 
SELECT 
	pl.id_pelanggan,
	pl.nama AS Nama_Pelanggan,
	pl.alamat,
	pl.no_telepon,
	pg.id_pegawai,
	pg.nama_pegawai,
	pg.jabatan
FROM tbl_Penjualan pj
JOIN tbl_Pelanggan pl ON pj.id_pelanggan = pl.id_pelanggan
JOIN tbl_Pegawai pg ON pj.id_pegawai = pg.id_pegawai
WHERE pg.jabatan = 'Kasir';

SELECT * FROM view_pelanggan_kasir;

-- no 4 dengan sum pada tabel tbl_Penjualan dan tbl_DetailPenjualan
CREATE VIEW view_total_penjualan_per_pegawai AS 
SELECT 
	pg.id_pegawai,
	pg.nama_pegawai,
	pg.jabatan,
	SUM(dp.subtotal) AS total_penjualan
FROM tbl_Pegawai pg
JOIN tbl_Penjualan pj ON pg.id_pegawai = pj.id_pegawai
JOIN tbl_DetailPenjualan dp ON pj.id_penjualan = dp.id_penjualan
GROUP BY pg.id_pegawai, pg.nama_pegawai, pg.jabatan;

SELECT * FROM view_total_penjualan_per_pegawai;

--no 5 
CREATE VIEW view_stok_kain_rendah AS
SELECT 
    id_kain,
    nama_kain,
    harga,
    stok
FROM tbl_ProdukKain
WHERE stok < 10;

SELECT * FROM view_stok_kain_rendah;






-- no1
DELIMITER //

CREATE PROCEDURE UpdateDataMaster (
    IN p_id INT,
    IN p_nama_baru VARCHAR(50),
    OUT p_status VARCHAR(50)
)
BEGIN
    UPDATE tbl_Pelanggan
    SET nama = p_nama_baru
    WHERE id_pelanggan = p_id;

    SET p_status = 'Update Selesai';
END;
//

DELIMITER ;

CALL UpdateDataMaster(101, 'Ibu Sari Dewi', @status);


SELECT @status;
SELECT * FROM tbl_Pelanggan;




-- no 2
DELIMITER //

CREATE PROCEDURE CountTransaksi (
    OUT p_total INT
)
BEGIN
    SELECT COUNT(*) INTO p_total
      FROM tbl_Penjualan;
END //

DELIMITER ;

CALL CountTransaksi(@total);
SELECT @total AS total_transaksi;



DROP PROCEDURE IF EXISTS  UpdateAlamatPelanggan;


-- no 3
DELIMITER //

CREATE PROCEDURE GetDataMasterByID (
	IN p_id_pelanggan INT,
	OUT p_nama VARCHAR(50),
	OUT p_alamat VARCHAR(100),
	OUT p_no_telepon VARCHAR(20)
)
BEGIN
	SELECT nama, alamat, no_telepon
	INTO p_nama, p_alamat, p_no_telepon
	FROM tbl_Pelanggan
	WHERE id_pelanggan = p_id_pelanggan;
END //

DELIMITER ;

CALL GetDataMasterByID(101, @nama, @alamat, @telepon);
SELECT @nama AS Nama, @alamat AS Alamat, @telepon AS No_Telepon;

-- no 4
DELIMITER //

CREATE PROCEDURE UpdateFieldTransaksi (
	IN p_id_penjualan INT,
	INOUT p_total INT,
	INOUT p_tanggal DATE
)
BEGIN
	-- Update data transaksi
	UPDATE tbl_Penjualan
	SET total = p_total,
		tanggal = p_tanggal
	WHERE id_penjualan = p_id_penjualan;

	-- Ambil kembali data terbaru setelah update
	SELECT total, tanggal
	INTO p_total, p_tanggal
	FROM tbl_Penjualan
	WHERE id_penjualan = p_id_penjualan;
END //

DELIMITER ;

SET @total= 50000;
SET @tanggal = '2005-02-01';

CALL UpdateFieldTransaksi( 402,@total, @tanggal);
SELECT @total AS TotalBaru, @tanggal AS TanggalBaru;

SELECT * FROM tbl_Penjualan;

-- no 5
DELIMITER //

CREATE PROCEDURE DeleteEntriesByIDMaster(IN id INT)
BEGIN
    
    DELETE FROM tbl_DetailPenjualan WHERE id_penjualan = id;

   
    DELETE FROM tbl_Penjualan WHERE id_penjualan = id;
END //

DELIMITER ;

CALL DeleteEntriesByIDMaster(401);


SELECT * FROM tbl_DetailPenjualan;













-- no 1
ALTER TABLE tbl_Penjualan
ADD COLUMN keterangan VARCHAR(100) AFTER total;

SELECT * FROM tbl_Penjualan;

-- no 2
CREATE OR REPLACE VIEW vw_RingkasPenjualan AS
SELECT  p.id_penjualan,
        pel.nama        AS pelanggan,
        p.tanggal,
        p.total,
        p.keterangan
FROM    tbl_Penjualan  AS p
JOIN    tbl_Pelanggan  AS pel  ON p.id_pelanggan = pel.id_pelanggan;


-- n0 3
SELECT * FROM tbl_ProdukKain
ORDER BY harga ASC;


SELECT * FROM tbl_Penjualan
ORDER BY tanggal DESC;


-- 4
ALTER TABLE tbl_Pelanggan
MODIFY COLUMN no_telepon VARCHAR(25);

SELECT * FROM tbl_Pelanggan;

-- no 5
-- left join
SELECT  p.id_penjualan,
        p.tanggal,
        d.id_kain,
        k.nama_kain
FROM    tbl_Penjualan      AS p
LEFT JOIN tbl_DetailPenjualan AS d ON p.id_penjualan = d.id_penjualan
LEFT JOIN tbl_ProdukKain       AS k ON d.id_kain     = k.id_kain;

-- right join
SELECT  k.id_kain,
        k.nama_kain,
        d.jumlah,
        p.tanggal
FROM    tbl_Penjualan        AS p
RIGHT JOIN tbl_DetailPenjualan AS d ON p.id_penjualan = d.id_penjualan
RIGHT JOIN tbl_ProdukKain       AS k ON d.id_kain     = k.id_kain;

-- self join
SELECT  a.id_pelanggan  AS id1,
        a.nama          AS nama1,
        b.id_pelanggan  AS id2,
        b.nama          AS nama2,
        a.alamat
FROM    tbl_Pelanggan AS a
JOIN    tbl_Pelanggan AS b
      ON a.alamat = b.alamat
     AND a.id_pelanggan < b.id_pelanggan;   -- hindari duplikat & diri sendiri


-- 1. harga kain lebih dari 250000
SELECT * FROM tbl_ProdukKain WHERE harga > 250000;

-- 2. stok kurang atau sama dengan 5
SELECT * FROM tbl_ProdukKain WHERE stok <= 5;

-- 3. penjualan antara 1–3 April 2025
SELECT * FROM tbl_Penjualan
WHERE tanggal BETWEEN '2025-04-01' AND '2025-04-03';

-- 4. pelanggan bukan 'Bapak Ahmad'
SELECT * FROM tbl_Pelanggan WHERE nama <> 'Bapak Ahmad';

-- 5. produk dengan nama LIKE '%Bali%'
SELECT * FROM tbl_ProdukKain WHERE nama_kain LIKE '%Bali%';
