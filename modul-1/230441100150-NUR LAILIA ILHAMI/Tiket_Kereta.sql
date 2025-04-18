CREATE DATABASE Tiket_kereta;

USE Tiket_kereta;

CREATE TABLE kereta (
    id_kereta INT PRIMARY KEY AUTO_INCREMENT,
    nama_kereta VARCHAR(100) NOT NULL,
    jenis_kereta ENUM('Eksekutif', 'Bisnis', 'Ekonomi') NOT NULL,
    kapasitas INT NOT NULL
);

CREATE TABLE stasiun (
    id_stasiun INT PRIMARY KEY AUTO_INCREMENT,
    nama_stasiun VARCHAR(100) NOT NULL,
    lokasi VARCHAR(255) NOT NULL
);

CREATE TABLE penumpang (
    id_penumpang INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    no_telepon VARCHAR(15) NOT NULL,
    alamat TEXT
);

CREATE TABLE jadwal (
    id_jadwal INT PRIMARY KEY AUTO_INCREMENT,
    id_kereta INT NOT NULL,
    id_stasiun_asal INT NOT NULL,
    id_stasiun_tujuan INT NOT NULL,
    tanggal_keberangkatan DATE NOT NULL,
    waktu_berangkat TIME NOT NULL,
    waktu_tiba TIME NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_kereta) REFERENCES kereta(id_kereta),
    FOREIGN KEY (id_stasiun_asal) REFERENCES stasiun(id_stasiun),
    FOREIGN KEY (id_stasiun_tujuan) REFERENCES stasiun(id_stasiun)
);

CREATE TABLE pemesanan (
    id_pemesanan INT PRIMARY KEY AUTO_INCREMENT,
    id_penumpang INT NOT NULL,
    id_jadwal INT NOT NULL,
    jumlah_tiket INT NOT NULL,
    total_harga DECIMAL(10,2) NOT NULL,
    STATUS ENUM('Dipesan', 'Dibayar', 'Dibatalkan') NOT NULL DEFAULT 'Dipesan',
    tanggal_pemesanan TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_penumpang) REFERENCES penumpang(id_penumpang),
    FOREIGN KEY (id_jadwal) REFERENCES jadwal(id_jadwal)
);

INSERT INTO kereta (nama_kereta, jenis_kereta, kapasitas) VALUES
('Argo Bromo Anggrek', 'Eksekutif', 300),
('Gaya Baru Malam Selatan', 'Ekonomi', 350),
('Taksaka', 'Bisnis', 250);

INSERT INTO stasiun (nama_stasiun, lokasi) VALUES
('Stasiun Surabaya Gubeng', 'Surabaya'),
('Stasiun Pasar Senen', 'Jakarta'),
('Stasiun Yogyakarta', 'Yogyakarta'),
('Stasiun Malang', 'Malang');

INSERT INTO penumpang (nama, email, no_telepon, alamat) VALUES
('Laili Ilhami', 'laili@email.com', '081234567890', 'Sampang, Madura'),
('Budi Santoso', 'budi@email.com', '082345678901', 'Jakarta'),
('Siti Aminah', 'siti@email.com', '083456789012', 'Yogyakarta');


INSERT INTO jadwal (id_kereta, id_stasiun_asal, id_stasiun_tujuan, tanggal_keberangkatan, waktu_berangkat, waktu_tiba, harga) VALUES
(1, 1, 2, '2025-04-20', '08:00:00', '16:00:00', 450000.00),
(2, 2, 3, '2025-04-21', '19:00:00', '06:00:00', 300000.00),
(3, 3, 4, '2025-04-22', '10:00:00', '14:00:00', 350000.00);


INSERT INTO pemesanan (id_penumpang, id_jadwal, jumlah_tiket, total_harga, status) VALUES
(1, 1, 2, 900000.00, 'Dipesan'),
(2, 2, 1, 300000.00, 'Dibayar'),
(3, 3, 3, 1050000.00, 'Dipesan');


---2 table penumpang dan pemesanan--
CREATE VIEW view_pemesanan_penumpang AS
SELECT 
    p.id_pemesanan,
    pn.nama AS nama_penumpang,
    pn.email,
    pn.no_telepon,
    p.jumlah_tiket,
    p.total_harga,
    p.status,
    p.tanggal_pemesanan
FROM 
    pemesanan p
JOIN 
    penumpang pn ON p.id_penumpang = pn.id_penumpang;

SELECT * FROM view_pemesanan_penumpang;

--- 3 tabell penumpang jadwal pemesanan--
CREATE VIEW view_pemesanan_penumpang_jadwal AS
SELECT 
    p.id_pemesanan,
    pn.nama AS nama_penumpang,
    pn.email,
    pn.no_telepon,
    j.tanggal_keberangkatan,
    j.waktu_berangkat,
    j.waktu_tiba,
    j.harga,
    p.jumlah_tiket,
    p.total_harga,
    p.status,
    p.tanggal_pemesanan
FROM 
    pemesanan p
JOIN 
    penumpang pn ON p.id_penumpang = pn.id_penumpang
JOIN 
    jadwal j ON p.id_jadwal = j.id_jadwal;
    
SELECT * FROM view_pemesanan_penumpang_jadwal;

--- tabel yang memenunuhi syarat----
CREATE VIEW view_pemesanan_dibayar AS
SELECT 
    p.id_pemesanan,
    pn.nama AS nama_penumpang,
    pn.email,
    p.jumlah_tiket,
    p.total_harga,
    p.status,
    p.tanggal_pemesanan
FROM 
    pemesanan p
JOIN 
    penumpang pn ON p.id_penumpang = pn.id_penumpang
WHERE 
    p.status = 'Dibayar';
SELECT * FROM view_pemesanan_dibayar;

---fungsi agregasi---

CREATE VIEW view_ringkasan_pemesanan AS
SELECT 
    pn.id_penumpang,
    pn.nama AS nama_penumpang,
    COUNT(p.id_pemesanan) AS jumlah_pemesanan,
    SUM(p.jumlah_tiket) AS total_tiket,
    SUM(p.total_harga) AS total_bayar
FROM 
    pemesanan p
JOIN 
    penumpang pn ON p.id_penumpang = pn.id_penumpang
GROUP BY 
    pn.id_penumpang, pn.nama;

SELECT * FROM view_ringkasan_pemesanan;

---- no 5---
CREATE VIEW view_jadwal_kereta_lengkap AS
SELECT 
    j.id_jadwal,
    k.nama_kereta,
    k.jenis_kereta,
    sa.nama_stasiun AS stasiun_asal,
    st.nama_stasiun AS stasiun_tujuan,
    j.tanggal_keberangkatan,
    j.waktu_berangkat,
    j.waktu_tiba,
    j.harga
FROM 
    jadwal j
JOIN 
    kereta k ON j.id_kereta = k.id_kereta
JOIN 
    stasiun sa ON j.id_stasiun_asal = sa.id_stasiun
JOIN 
    stasiun st ON j.id_stasiun_tujuan = st.id_stasiun;

SELECT * FROM view_jadwal_kereta_lengkap;






