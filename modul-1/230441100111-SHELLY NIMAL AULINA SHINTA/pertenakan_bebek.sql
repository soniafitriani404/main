CREATE DATABASE peternakan_bebek;
USE peternakan_bebek;

CREATE TABLE peternak (
    id_peternak INT PRIMARY KEY,
    nama VARCHAR(50),
    alamat VARCHAR(100),
    no_hp VARCHAR(15)
);

CREATE TABLE kandang (
    id_kandang INT PRIMARY KEY,
    lokasi VARCHAR(100),
    kapasitas INT,
    id_peternak INT,
    FOREIGN KEY (id_peternak) REFERENCES peternak(id_peternak)
);

CREATE TABLE bebek (
    id_bebek INT PRIMARY KEY,
    jenis_kelamin VARCHAR(10),
    tgl_masuk DATE,
    id_kandang INT,
    FOREIGN KEY (id_kandang) REFERENCES kandang(id_kandang)
);

CREATE TABLE produksi_telur (
    id_produksi INT PRIMARY KEY,
    tanggal DATE,
    jumlah_telur INT,
    kualitas VARCHAR(20),
    id_kandang INT,
    id_bebek INT,
    FOREIGN KEY (id_kandang) REFERENCES kandang(id_kandang),
    FOREIGN KEY (id_bebek) REFERENCES bebek(id_bebek)
);

CREATE TABLE Pakan_Harian (
    id_pakan INT PRIMARY KEY,
    tanggal DATE,
    jenis_pakan VARCHAR(100),
    jumlah_kg DECIMAL(5,2),
    id_kandang INT,
    FOREIGN KEY (id_kandang) REFERENCES Kandang(id_kandang)
);

-- Peternak
INSERT INTO peternak (id_peternak,nama, alamat, no_hp) VALUES
(1, 'Pak Sholikin', 'Jl. Mawar No.1', '081234567891'),
(2, 'Bu Siti Khoiriyah', 'Jl. Melati No.2', '082345678912');

-- Kandang
INSERT INTO kandang (id_kandang, lokasi, kapasitas, id_peternak) VALUES
(101, 'Blok A1', 50, 1),
(102, 'Blok A2', 40, 1),
(103, 'Blok B1', 60, 2);

-- Bebek
INSERT INTO bebek (id_bebek, jenis_kelamin, tgl_masuk, id_kandang) VALUES
(201, 'Betina', '2024-01-01', 101),
(202, 'Jantan', '2024-01-01', 101),
(203, 'Betina', '2024-01-05', 101),
(204, 'Jantan', '2024-01-10', 102),
(205, 'Betina', '2024-01-12', 102),
(206, 'Betina', '2024-01-13', 102),
(207, 'Jantan', '2024-01-14', 102),
(208, 'Betina', '2024-01-15', 103),
(209, 'Jantan', '2024-01-16', 103),
(210, 'Betina', '2024-01-17', 103);

-- produksi telur
INSERT INTO produksi_telur (id_produksi, tanggal, jumlah_telur, kualitas, id_kandang, id_bebek) VALUES
(301, '2025-04-01', 12, 'Baik', 101, 201),
(302, '2025-04-02', 10, 'Sedang', 102, 205),
(303, '2025-04-03', 15, 'Baik', 103, 210);

INSERT INTO produksi_telur (id_produksi, tanggal, jumlah_telur, kualitas, id_kandang, id_bebek) VALUES 
(304, '2025-04-10', 45, 'Baik', 101, 201),
(305, '2025-04-10', 38, 'Sedang', 102, 205),
(306, '2025-04-11', 50, 'Baik', 103, 210),
(307, '2025-04-11', 41, 'Baik', 101, 203),
(308, '2025-04-12', 36, 'Buruk', 102, 206);

INSERT INTO Pakan_Harian (id_pakan, tanggal, jenis_pakan, jumlah_kg, id_kandang) VALUES
(1, '2025-04-01', 'Dedak Halus', 5.5, 101),
(2, '2025-04-02', 'Jagung Giling', 6.0, 102),
(3, '2025-04-02', 'Pelet', 4.0, 103);

SELECT * FROM peternak;
SELECT * FROM kandang;
SELECT * FROM bebek;
SELECT * FROM produksi_telur;
SELECT * FROM pakan_harian;

RENAME TABLE bebek TO data_bebek;
SHOW TABLES;
DROP DATABASE peternakan_bebek;