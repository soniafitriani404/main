CREATE VIEW view_penghuni_kamar AS
SELECT 
    p.id_penghuni,
    p.nama_lengkap,
    k.nomor_kamar,
    pk.tanggal_masuk,
    pk.tanggal_keluar
FROM 
    penempatan_penghuni pk
JOIN 
    penghuni p ON pk.id_penghuni = p.id_penghuni
JOIN 
    kamar k ON pk.id_kamar = k.id_kamar;


CREATE VIEW view_penempatan_lengkap AS
SELECT 
    p.nama_lengkap,
    k.nomor_kamar,
    a.nama AS nama_admin,
    pk.tanggal_masuk,
    pk.tanggal_keluar
FROM 
    penempatan_penghuni pk
JOIN 
    penghuni p ON pk.id_penghuni = p.id_penghuni
JOIN 
    kamar k ON pk.id_kamar = k.id_kamar
JOIN 
    admin a ON pk.id_admin = a.id_admin;
    
CREATE VIEW view_penghuni_aktif AS
SELECT 
    p.nama_lengkap,
    k.nomor_kamar,
    pk.tanggal_masuk
FROM 
    penempatan_penghuni pk
JOIN 
    penghuni p ON pk.id_penghuni = p.id_penghuni
JOIN 
    kamar k ON pk.id_kamar = k.id_kamar
WHERE 
    pk.tanggal_keluar IS NULL;
    
 
 CREATE VIEW view_jumlah_penghuni_per_kamar AS
SELECT 
    k.nomor_kamar,
    COUNT(pk.id_penghuni) AS jumlah_penghuni
FROM 
    penempatan_penghuni pk
JOIN 
    kamar k ON pk.id_kamar = k.id_kamar
GROUP BY 
    k.nomor_kamar;

CREATE VIEW view_jumlah_pelanggaran_penghuni AS
SELECT 
    p.nama_lengkap,
    COUNT(pl.id_pelanggaran) AS total_pelanggaran
FROM 
    pelanggaran pl
JOIN 
    penghuni p ON pl.id_penghuni = p.id_penghuni
GROUP BY 
    p.nama_lengkap;


