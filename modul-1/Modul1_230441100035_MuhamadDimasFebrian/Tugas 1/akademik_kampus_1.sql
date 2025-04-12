qlCREATE DATABASE Akademik_Kampus;
USE Akademik;

CREATE TABLE Mahasiswa (
    NIM CHAR(10) PRIMARY KEY,
    Nama VARCHAR(100),
    Jurusan VARCHAR(50),
    Alamat VARCHAR(100)
);

CREATE TABLE Dosen (
    NIP CHAR(10) PRIMARY KEY,
    Nama VARCHAR(100),
    Prodi VARCHAR(50)
);

CREATE TABLE MataKuliah (
    KodeMK CHAR(6) PRIMARY KEY,
    NamaMK VARCHAR(100),
    SKS INT,
    NIP_Dosen CHAR(10),
    FOREIGN KEY (NIP_Dosen) REFERENCES Dosen(NIP)
);

CREATE TABLE KRS (
    ID_KRS INT AUTO_INCREMENT PRIMARY KEY,
    NIM CHAR(10),
    KodeMK CHAR(6),
    Semester INT,
    TahunAkademik VARCHAR(10),
    FOREIGN KEY (NIM) REFERENCES Mahasiswa(NIM),
    FOREIGN KEY (KodeMK) REFERENCES MataKuliah(KodeMK)
);


-- Masukin data 
INSERT INTO Mahasiswa VALUES
('001', 'Miftah Faizin', 'Sistem Informasi', 'Gresik'),
('002', 'Rizki Fajar', 'Sistem Informasi', 'Malang'),
('003', 'Ravi Revalda', 'Sistem Informasi', 'Bandung'),
('004', 'Aidan Fawaz', 'Sistem Informasi', 'Balikpapan'),
('005', 'Alfath Hanif', 'Sistem Informasi', 'Jakarta'),
('006', 'Ibnu Alhaitham', 'Sistem Informasi', 'Madura'),
('007', 'Jonatan', 'Sistem Informasi', 'Malang'),
('008', 'Junio Farinbi', 'Sistem Informasi', 'Banjar'),
('009', 'Ipank Satria', 'Sistem Informasi', 'Samarinda'),
('010', 'Fufu Fafa', 'Sistem Informasi', 'Solo');

INSERT INTO Dosen VALUES
('001', 'Budi, S.Kom., M.Kom.', 'Algoritma'),
('002', 'Sinta, S.Kom., M.Kom.', 'Database'),
('003', 'Dr. Ratio, S.Kom., M.Kom.', 'AI'),
('004', 'Prof. Dr. Anaxagoras, S.Kom., M.Kom.', 'Jaringan'),
('005', 'Andi, S.Kom., M.Kom.', 'Pemrograman Visual'),
('006', 'Lina, S.Kom., M.Kom.', 'Manajemen Proyek'),
('007', 'Rudi, S.Kom., M.Kom.', 'Analisis Data'),
('008', 'Maya, S.Kom., M.Kom.', 'Sistem Manajemen Basis Data'),
('009', 'Hasan, S.Kom., M.Kom.', 'Etika Profesi'),
('010', 'Kiki, S.Kom., M.Kom.', 'Logika Engineering');

INSERT INTO MataKuliah VALUES
('MK001', 'Algoritma dan Pemrograman', 3, '001'),
('MK002', 'Basis Data', 3, '002'),
('MK003', 'Kecerdasan Buatan', 3, '003'),
('MK004', 'Jaringan Komputer', 2, '004'),
('MK005', 'Pemrograman Visual', 3, '005'),
('MK006', 'Manajemen Proyek Teknologi Informasi', 2, '006'),
('MK007', 'Analisis dan Perancangan Sistem Informasi', 3, '007'),
('MK008', 'Sistem Manajemen Basis Data', 2, '008'),
('MK009', 'Etika Profesi dan Hukum IT', 2, '009'),
('MK010', 'Logika Engineering', 3, '010');

INSERT INTO KRS (NIM, KodeMK, Semester, TahunAkademik) VALUES
('001', 'MK001', 1, '2024/2025'),
('002', 'MK002', 1, '2024/2025'),
('003', 'MK003', 1, '2024/2025'),
('004', 'MK004', 2, '2024/2025'),
('005', 'MK005', 2, '2024/2025');

SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM MataKuliah;
SELECT * FROM KRS;

RENAME TABLE Mahasiswa TO Data_Mahasiswa;
DROP DATABASE Akademik_Kampus;

