CREATE DATABASE sekolah_musik;

USE sekolah_musik;

CREATE TABLE Murid (
    id_murid INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(50),
    usia INT,
    alamat VARCHAR(100),
    telepon VARCHAR(15)
);

CREATE TABLE Guru (
    id_guru INT AUTO_INCREMENT PRIMARY KEY,
    nama_guru VARCHAR(50),
    spesialisasi VARCHAR(50),
    pengalaman_tahun INT
);

CREATE TABLE AlatMusik (
    id_alat INT AUTO_INCREMENT PRIMARY KEY,
    nama_alat VARCHAR(50),
    jenis VARCHAR(30),
    harga_sewa DECIMAL(10, 2)
);

CREATE TABLE KelasMusik (
    id_kelas INT AUTO_INCREMENT PRIMARY KEY,
    nama_kelas VARCHAR(50),
    id_guru INT,
    id_alat INT,
    durasi_jam INT,
    biaya DECIMAL(10, 2),
    FOREIGN KEY (id_guru) REFERENCES Guru(id_guru),
    FOREIGN KEY (id_alat) REFERENCES AlatMusik(id_alat)
);

CREATE TABLE Pendaftaran (
    id_pendaftaran INT AUTO_INCREMENT PRIMARY KEY,
    id_murid INT,
    id_kelas INT,
    tanggal_pendaftaran DATE,
    FOREIGN KEY (id_murid) REFERENCES Murid(id_murid),
    FOREIGN KEY (id_kelas) REFERENCES KelasMusik(id_kelas)
);




