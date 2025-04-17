/*
SQLyog Community v13.3.0 (64 bit)
MySQL - 10.4.32-MariaDB : Database - akademi_sihir
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`akademi_sihir` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `akademi_sihir`;

/*Table structure for table `dosen` */

DROP TABLE IF EXISTS `dosen`;

CREATE TABLE `dosen` (
  `nip` int(11) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `bidang_keahlian` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`nip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `dosen` */

insert  into `dosen`(`nip`,`nama`,`bidang_keahlian`) values 
(14410097,'Kaelen Vortex','Dimensi Paralel dan Waktu'),
(14420032,'Selvara Nyxwind','Transmutasi dan Alkimia'),
(14420040,'Yvainne Veil','Sihir Sosial dan Psikomagika'),
(14420068,'Naeriel','Penyembuhan dan Ilmu Roh'),
(14430031,'Eldrin Moonwhisper','Ilmu Sihir Elemental'),
(14430075,'Grimwald Ironroot','Rekayasa Artefak dan Golemologi'),
(14450059,'Bartholom Dewcaller','Druidisme dan Fauna Fantastis'),
(14460086,'Mirathiel Silverglen','Enchanting dan Rune Kuno'),
(14470063,'Thalion Duskbane','Strategi Perang Magis'),
(14490044,'Liora Fireweaver','Seni Ilusi dan Manipulasi Cahaya');

/*Table structure for table `krs` */

DROP TABLE IF EXISTS `krs`;

CREATE TABLE `krs` (
  `id_krs` int(11) NOT NULL,
  `nim` int(11) DEFAULT NULL,
  `kode_mk` int(11) DEFAULT NULL,
  `tahun_ajaran` int(11) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_krs`),
  KEY `nim` (`nim`),
  KEY `kode_mk` (`kode_mk`),
  CONSTRAINT `krs_ibfk_1` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`),
  CONSTRAINT `krs_ibfk_2` FOREIGN KEY (`kode_mk`) REFERENCES `matakuliah` (`kode_mk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `krs` */

insert  into `krs`(`id_krs`,`nim`,`kode_mk`,`tahun_ajaran`,`semester`) values 
(2001,2201001,1001,2024,1),
(2002,2201002,1002,2024,2),
(2003,2101003,1003,2024,3),
(2004,2301004,1004,2025,1),
(2005,2001005,1005,2024,4),
(2006,2201006,1006,2024,2),
(2007,2101007,1007,2024,5),
(2008,2301008,1008,2025,1),
(2009,2101009,1009,2024,2),
(2010,2001010,1010,2024,3);

/*Table structure for table `mahasiswa` */

DROP TABLE IF EXISTS `mahasiswa`;

CREATE TABLE `mahasiswa` (
  `nim` int(11) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `jurusan` varchar(50) DEFAULT NULL,
  `angkatan` int(11) DEFAULT NULL,
  PRIMARY KEY (`nim`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `mahasiswa` */

insert  into `mahasiswa`(`nim`,`nama`,`jurusan`,`angkatan`) values 
(2001005,'Joan Arvinci','Golemologi',2020),
(2001010,'Davin Luciano','Psikomagika',2020),
(2101003,'Finch Hymen','Strategi Magis',2021),
(2101007,'Arion Cailean','Sihir Dimensional',2021),
(2101009,'Lievan Hwanjun','Druidisme',2021),
(2201001,'Vrandisa Zaneva','Sihir Elemental',2022),
(2201002,'Fawn Hymen','Sihir Transmutasi',2022),
(2201006,'Vabien Nicolas','Rune dan Enchanting',2022),
(2301004,'Serafina Vittoria','Ilusi & Cahaya',2023),
(2301008,'Ferion Cailean','Penyembuhan Magis',2023);

/*Table structure for table `matakuliah` */

DROP TABLE IF EXISTS `matakuliah`;

CREATE TABLE `matakuliah` (
  `kode_mk` int(11) NOT NULL,
  `nama_mk` varchar(50) DEFAULT NULL,
  `sks` int(11) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  `nip` int(11) DEFAULT NULL,
  PRIMARY KEY (`kode_mk`),
  KEY `nip` (`nip`),
  CONSTRAINT `matakuliah_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `dosen` (`nip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `matakuliah` */

insert  into `matakuliah`(`kode_mk`,`nama_mk`,`sks`,`semester`,`nip`) values 
(1001,'Pengendalian Unsur Dasar',3,1,14430031),
(1002,'Alkimia dan Transmutasi Benda',3,2,14420032),
(1003,'Taktik dan Strategi Perang Magis',2,3,14470063),
(1004,'Seni Ilusi & Manipulasi Cahaya',2,1,14490044),
(1005,'Rekayasa Artefak dan Golemologi',3,4,14430075),
(1006,'Rune Kuno dan Enchanting Dasar',2,2,14460086),
(1007,'Dimensi Paralel & Perjalanan Waktu',3,5,14410097),
(1008,'Penyembuhan Magis dan Rohani',2,1,14420068),
(1009,'Fauna Fantastis dan Druidisme',3,2,14450059),
(1010,'Psikomagika dan Sihir Sosial',2,3,14420040);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
