CREATE DATABASE akademik;
USE akademik;

CREATE TABLE Mahasiswa (
nim INT (10) PRIMARY KEY,
nama VARCHAR(50),
prodi VARCHAR (25),
alamat VARCHAR (50)

)

CREATE TABLE Dosen(
nip INT (10) PRIMARY KEY,
nama_dosen VARCHAR (50),
jabatan VARCHAR (50)

)


CREATE TABLE MataKuliah (
    kode_mk INT(10) PRIMARY KEY,
    nama_mk VARCHAR(100),
    sks INT,
    nip INT(10),
    FOREIGN KEY (nip) REFERENCES Dosen(nip)
);

CREATE TABLE KRS (
    id_krs INT AUTO_INCREMENT PRIMARY KEY,
    nim INT(10),
    kode_mk INT(10),
    semester INT,
    FOREIGN KEY (nim) REFERENCES Mahasiswa(nim),
    FOREIGN KEY (kode_mk) REFERENCES MataKuliah(kode_mk)
);

INSERT INTO Mahasiswa VALUES 
(220301,'Diah','Sistem Informasi','Tuban'),
(220302,'Icha','Sistem Informasi','Surabaya'),
(220303,'Nadhifa','PGSD','Gresik'),
(220304,'Rizka','Teknik Mesin','Gresik'),
(220305,'Refalino','Teknik Informatika','Jakarta'),
(220306,'Fikri','Hukum','Surabaya'),
(220307,'Haidar','Sistem Informasi','Sidoarjo'),
(220308,'Muhlis','Manajemen','Bangkalan'),
(220309,'Yakin','Adminitrasi Bisnis','Kediri'),
(220310,'Yuli','DKV','Lamongan');


INSERT INTO Dosen VALUES 
(20001, 'Prof. Andika Pratama', 'Dekan'),
(20002, 'Dr. Bella Saraswati', 'Wakil Dekan'),
(20003, 'Dr. Cahyono Putra', 'Ketua Prodi'),
(20004, 'Dr. Dian Lestari', 'Sekretaris Prodi'),
(20005, 'Dr. Endang Wibowo', 'Dosen Tetap'),
(20006, 'Dr. Farah Azizah', 'Dosen Tetap'),
(20007, 'Dr. Galang Prakoso', 'Dosen Tetap'),
(20008, 'Dr. Hanifah Zahra', 'Dosen Tetap'),
(20009, 'Dr. Irfan Syahputra', 'Dosen Tetap'),
(20010, 'Dr. Jelita Mahardika', 'Dosen Tetap');

INSERT INTO MataKuliah (kode_mk, nama_mk, sks, nip) VALUES 
(201, 'Struktur Data', 3, 20001),
(202, 'Pemrograman Mobile', 3, 20002),
(203, 'Machine Learning', 3, 20003),
(204, 'Big Data', 3, 20004),
(205, 'Manajemen Sistem Informasi', 2, 20005),
(206, 'Internet of Things', 2, 20006),
(207, 'Cloud Computing', 3, 20007),
(208, 'Visualisasi Data', 3, 20008),
(209, 'Etika Profesi TI', 2, 20009),
(210, 'UI/UX Design', 3, 20010);


SELECT * FROM Matakuliah;
SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM KRS;


INSERT INTO KRS (nim, kode_mk, semester) VALUES 
(220301, 201, 1),
(220302, 202, 1),
(220303, 203, 2),
(220304, 204, 2),
(220305, 205, 3);

ALTER TABLE Mahasiswa RENAME TO MahasiswaUTM;

DROP DATABASE akademik;










