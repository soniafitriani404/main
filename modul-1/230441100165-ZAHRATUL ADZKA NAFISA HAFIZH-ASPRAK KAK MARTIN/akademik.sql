CREATE DATABASE akademik;
USE akademik;

CREATE TABLE mahasiswa (
    nim VARCHAR(20) NOT NULL PRIMARY KEY,
    nama_mahasiswa VARCHAR(255) NOT NULL,
    prodi VARCHAR(100) NOT NULL,
    semester INT NOT NULL,
    angkatan YEAR NOT NULL
);

CREATE TABLE dosen (
    nip VARCHAR(20) PRIMARY KEY,
    nama_dosen VARCHAR(255) NOT NULL,
    no_telepon BIGINT
);

CREATE TABLE matakuliah (
    kode_matkul VARCHAR(20) PRIMARY KEY,
    nama_matkul VARCHAR(255) NOT NULL,
    sks INT NOT NULL,
    nip VARCHAR(20) NOT NULL ,
    FOREIGN KEY (nip) REFERENCES dosen(nip)
);

CREATE TABLE krs (
    kode_krs VARCHAR(20) PRIMARY KEY,
    nim VARCHAR(20) NOT NULL,
    kode_matkul VARCHAR(20) NOT NULL,
    semester INT NOT NULL,
    tahun_akademik VARCHAR(10) NOT NULL,
    FOREIGN KEY (nim) REFERENCES mahasiswa(nim),
    FOREIGN KEY (kode_matkul) REFERENCES matakuliah(kode_matkul) 
);

CREATE TABLE kelas (
    id_kelas VARCHAR(20) PRIMARY KEY,
    kode_matkul VARCHAR(20) NOT NULL,
    nip VARCHAR(20) NOT NULL,
    ruang VARCHAR(20),
    jadwal VARCHAR(100),
    FOREIGN KEY (kode_matkul) REFERENCES matakuliah(kode_matkul),
    FOREIGN KEY (nip) REFERENCES dosen(nip)
);

INSERT INTO mahasiswa (nim, nama_mahasiswa, prodi, semester, angkatan) VALUES
('230441100156', 'AGATHA YASMIN RAHMAN', 'SISTEM INFORMASI', 2, 2023),
('230441100071', 'ANANDA EKAWATI', 'SISTEM INFORMASI', 2, 2023),
('230441100166', 'Shahaf Lanjaya Putra Mujiono', 'SISTEM INFORMASI', 2, 2023),
('230441100181', 'Melati Ulfa Wijaya', 'SISTEM INFORMASI', 2, 2023),
('230441100022', 'Lanny Aprilia', 'SISTEM INFORMASI', 2, 2023),
('230441100184', 'Wira Selfina Laydi', 'SISTEM INFORMASI', 2, 2023),
('230441100147', 'Moh Muchlis', 'SISTEM INFORMASI', 2, 2023),
('230441100120', 'Alvyan Maulana Karnawan Putra', 'SISTEM INFORMASI', 2, 2023),
('230441100111', 'Shelly Nimal Aulina Shinta', 'SISTEM INFORMASI', 2, 2023),
('230441100091', 'Diah Ayu Nurmala', 'SISTEM INFORMASI', 2, 2023);

INSERT INTO dosen (nama_dosen, nip, no_telepon) VALUES
('Dr. Budi Dwi Satoto, S.T., M.Kom', '197509092002121001', '085646658710'),
('Mohammad Syarief, S.T., M.Cs.', '198003212008011008', '085612345678'),
('Eza Rahmanita, S.T., M.T.', '197906052003122003', '085623456789'),
('Doni Abdul Fatah, S.Kom., M.Kom', '198705202019031013', '085634567890'),
('Wahyudi Agustiono, S.Kom., M.Sc., Ph.D', '197808042003121001', '085645678901'),
('Dr. Yeni Kustiyahningsih, S.Kom., M.Kom (Ketua Jurusan T. Informatika)', '197709212008122002', '085656789012'),
('Sri Herawati, S.Kom., M.Kom', '198308282008122002', '085667890123'),
('Firmansyah Adiputra, S.T., M.Cs.', '197805042002121002', '085678901234'),
('Rosida Vivin Nahari, S.Kom., M.T', '198306082008012005', '085689012345'),
('Novi Prastiti, S.Kom, M.Kom', '198711272014042001', '085690123456');



INSERT INTO matakuliah (nama_matkul, kode_matkul, sks, nip) VALUES
('Data Mining', 'INF101', 3, '197509092002121001'),
('Sistem manajemen Basis Data', 'INF102', 4, '198003212008011008'),
('Perencanaan Sumber Daya Perusahaan', 'INF103', 3, '197906052003122003'),
('E-Business Dan E-Commerce', 'INF104', 3, '198705202019031013'),
('Implemntasi Dan Pengujian Perangkat Lunak', 'INF105', 3, '197808042003121001'),
('Perencanaan Sumber Daya Perusahaan', 'INF106', 3, '197709212008122002'),
('Sistem Pendukung Keputusan', 'INF107', 3, '198308282008122002'),
('Pemograman Berbasis Objek', 'INF108', 3, '197805042002121002'),
('MANAJEMEN PROYEK IT', 'INF109', 3, '198306082008012005'),
('FINANCIAL TECHNOLOGY', 'INF110', 3, '198711272014042001');

INSERT INTO kelas (id_kelas, kode_matkul, nip, ruang, jadwal) VALUES
('KLS001', 'INF101', '197509092002121001', 'Ruang 307', 'Senin 08:00 - 10:00'),
('KLS002', 'INF102', '198003212008011008', 'Ruang 204', 'Selasa 10:00 - 12:00'),
('KLS003', 'INF103', '197906052003122003', 'Ruang 308', 'Rabu 08:00 - 10:00'),
('KLS004', 'INF104', '198705202019031013', 'Ruang 304', 'Kamis 10:00 - 12:00'),
('KLS005', 'INF105', '197808042003121001', 'Ruang 207', 'Jumat 08:00 - 10:00'),
('KLS006', 'INF106', '197709212008122002', 'Ruang 208', 'Senin 10:00 - 12:00'),
('KLS007', 'INF107', '198308282008122002', 'Ruang 306', 'Selasa 08:00 - 10:00'),
('KLS008', 'INF108', '197805042002121002', 'Lab TI', 'Rabu 10:00 - 12:00'),
('KLS009', 'INF109', '198306082008012005', 'Lab Bis', 'Kamis 08:00 - 10:00'),
('KLS010', 'INF110', '198711272014042001', 'Ruang 202', 'Jumat 10:00 - 12:00');

INSERT INTO krs (kode_krs, nim, kode_matkul, semester, tahun_akademik) VALUES
('KRS001', '230441100156', 'INF101', 1, '2023/2024'),
('KRS002', '230441100071', 'INF101', 1, '2023/2024'),
('KRS003', '230441100166', 'INF103', 3, '2023/2024'),
('KRS004', '230441100181', 'INF103', 3, '2023/2024'),
('KRS005', '230441100022', 'INF105', 5, '2023/2024'),
('KRS006', '230441100184', 'INF105', 5, '2023/2024'),
('KRS007', '230441100147', 'INF107', 7, '2023/2024'),
('KRS008', '230441100120', 'INF107', 7, '2023/2024'),
('KRS009', '230441100111', 'INF109', 9, '2023/2024'),
('KRS010', '230441100091', 'INF109', 9, '2023/2024');

ALTER TABLE dosen ADD no_telepon VARCHAR(50);

SELECT * FROM matakuliah

`pembayaran`

SELECT * FROM mahasiswa

SELECT * FROM krs

SELECT * FROM kelas

DROP DATABASE akademik;

RENAME TABLE matakuliah TO matkul;