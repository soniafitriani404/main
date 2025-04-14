-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 11 Apr 2025 pada 11.07
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `akademik_prodi`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `dosen`
--

CREATE TABLE `dosen` (
  `nip` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `bidang_keahlian` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `dosen`
--

INSERT INTO `dosen` (`nip`, `nama`, `bidang_keahlian`) VALUES
(2001, 'Dr. Satrio Wibowo', 'Pemrograman Web'),
(2002, 'Dr. Rina Amelia', 'Basis Data'),
(2003, 'Prof. Agus Wijaya', 'Kecerdasan Buatan'),
(2004, 'Dr. Dedi Prasetyo', 'Jaringan Komputer'),
(2005, 'Dr. Anita Kusuma', 'Pemrograman Mobile'),
(2006, 'Dr. Budi Hartanto', 'Algoritma dan Struktur Data'),
(2007, 'Dr. Wenny Paramitha', 'Sistem Operasi'),
(2008, 'Prof. Rachmat Hidayat', 'Analisis Data'),
(2009, 'Dr. Susanto Rahayu', 'Manajemen Proyek TI'),
(2010, 'Dr. Farhan Maulana', 'Keamanan Siber');

-- --------------------------------------------------------

--
-- Struktur dari tabel `krs`
--

CREATE TABLE `krs` (
  `id_krs` int(11) NOT NULL,
  `nim` varchar(100) DEFAULT NULL,
  `kode_mk` int(6) DEFAULT NULL,
  `semester` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `krs`
--

INSERT INTO `krs` (`id_krs`, `nim`, `kode_mk`, `semester`) VALUES
(1, '230441100005', 3001, 2),
(2, '230441100007', 3002, 2),
(3, '230441100008', 3003, 3),
(4, '2304411000013', 3004, 3),
(5, '2304411000019', 3005, 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `nim` varchar(100) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jenis_kelamin` enum('L','P') DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `mahasiswa`
--

INSERT INTO `mahasiswa` (`nim`, `nama`, `tanggal_lahir`, `jenis_kelamin`, `alamat`) VALUES
('230441100005', 'Safira Rihadatul Aisy', '2002-05-14', 'P', 'Surabaya'),
('230441100007', 'Khusnur Faizah', '2002-07-20', 'P', 'Gresik'),
('230441100008', 'Muhammad Yusri', '2001-12-10', 'L', 'Sidoarjo'),
('230441100013', 'Yuliatin Agustina', '2003-02-25', 'P', 'Malang'),
('230441100019', 'Frinanda Al Fitrah Ramadhani', '2002-11-05', 'P', 'Jombang'),
('230441100020', 'Arifin Abdillah', '2001-08-17', 'L', 'Bangkalan'),
('230441100021', 'Jasmine Kurnia Ramadhani', '2002-04-30', 'P', 'Madiun'),
('230441100025', 'Achmad Chusnul Yakin', '2001-09-14', 'L', 'Pasuruan'),
('230441100029', 'Vikas Irman Wansyah', '2003-03-12', 'L', 'Mojokerto'),
('230441100032', 'Mahrus Solihin', '2001-06-22', 'L', 'Lamongan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `matakuliah`
--

CREATE TABLE `matakuliah` (
  `kode_matkul` int(11) NOT NULL,
  `nama_matkul` varchar(100) DEFAULT NULL,
  `sks` int(11) DEFAULT NULL,
  `nip` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `matakuliah`
--

INSERT INTO `matakuliah` (`kode_matkul`, `nama_matkul`, `sks`, `nip`) VALUES
(3001, 'Pemrograman Web', 3, 2001),
(3002, 'Basis Data', 3, 2002),
(3003, 'Kecerdasan Buatan', 3, 2003),
(3004, 'Jaringan Komputer', 3, 2004),
(3005, 'Pemrograman Mobile', 3, 2005),
(3006, 'Algoritma dan Struktur Data', 3, 2006),
(3007, 'Sistem Operasi', 3, 2007),
(3008, 'Analisis Data', 3, 2008),
(3009, 'Manajemen Proyek TI', 3, 2009),
(3010, 'Keamanan Siber', 3, 2010);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`nip`);

--
-- Indeks untuk tabel `krs`
--
ALTER TABLE `krs`
  ADD PRIMARY KEY (`id_krs`);

--
-- Indeks untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`nim`);

--
-- Indeks untuk tabel `matakuliah`
--
ALTER TABLE `matakuliah`
  ADD PRIMARY KEY (`kode_matkul`),
  ADD KEY `nip` (`nip`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `krs`
--
ALTER TABLE `krs`
  MODIFY `id_krs` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `matakuliah`
--
ALTER TABLE `matakuliah`
  ADD CONSTRAINT `matakuliah_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `dosen` (`nip`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
