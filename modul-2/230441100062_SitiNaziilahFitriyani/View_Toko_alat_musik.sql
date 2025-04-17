/*
SQLyog Community v13.2.1 (64 bit)
MySQL - 10.4.32-MariaDB : Database - toko_alat_musik
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`toko_alat_musik` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `toko_alat_musik`;

/*Table structure for table `detailpenjualan` */

DROP TABLE IF EXISTS `detailpenjualan`;

CREATE TABLE `detailpenjualan` (
  `ID_detail` varchar(10) NOT NULL,
  `ID_penjualan` int(11) DEFAULT NULL,
  `ID_produk` int(11) DEFAULT NULL,
  `Jumlah` int(11) DEFAULT NULL,
  `Harga` varchar(50) DEFAULT NULL,
  `Subtotal` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_detail`),
  KEY `ID_penjualan` (`ID_penjualan`),
  KEY `ID_produk` (`ID_produk`),
  CONSTRAINT `detailpenjualan_ibfk_1` FOREIGN KEY (`ID_penjualan`) REFERENCES `penjualan` (`ID_penjualan`),
  CONSTRAINT `detailpenjualan_ibfk_2` FOREIGN KEY (`ID_produk`) REFERENCES `produk` (`ID_produk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `detailpenjualan` */

insert  into `detailpenjualan`(`ID_detail`,`ID_penjualan`,`ID_produk`,`Jumlah`,`Harga`,`Subtotal`) values 
('D001',1,1,1,'1500000','1500000'),
('D002',2,2,1,'2500000','2500000'),
('D003',3,3,1,'5000000','5000000'),
('D004',4,4,1,'3000000','3000000'),
('D005',5,5,1,'2000000','2000000'),
('D006',6,6,1,'3500000','3500000'),
('D007',7,7,1,'2300000','2300000');

/*Table structure for table `karyawan` */

DROP TABLE IF EXISTS `karyawan`;

CREATE TABLE `karyawan` (
  `ID_karyawan` int(11) NOT NULL,
  `Nama_karyawan` varchar(50) DEFAULT NULL,
  `Alamat` varchar(50) DEFAULT NULL,
  `No_telp` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`ID_karyawan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `karyawan` */

insert  into `karyawan`(`ID_karyawan`,`Nama_karyawan`,`Alamat`,`No_telp`) values 
(1,'Andi Setiawan','Jl. Melati No. 10','081234567890'),
(2,'Budi Santoso','Jl. Kenanga No. 20','082345678901'),
(3,'Citra Dewi','Jl. Mawar No. 30','083456789012'),
(4,'Doni Prasetyo','Jl. Anggrek No. 40','084567890123'),
(5,'Eka Putri','Jl. Cempaka No. 50','085678901234'),
(6,'Fajar Hidayat','Jl. Flamboyan No. 60','086789012345'),
(7,'Gina Lestari','Jl. Bougenville No. 70','087890123456');

/*Table structure for table `kategori` */

DROP TABLE IF EXISTS `kategori`;

CREATE TABLE `kategori` (
  `ID_kategori` varchar(10) NOT NULL,
  `Kategori` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ID_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `kategori` */

insert  into `kategori`(`ID_kategori`,`Kategori`) values 
('K001','Alat musik petik'),
('K002','Alat musik tekan'),
('K003','Alat musik pukul'),
('K004','alat musik gesek'),
('K005','Alat musik tiup'),
('K006','Peralatan DJ'),
('K007','Aksesoris musik');

/*Table structure for table `pelanggan` */

DROP TABLE IF EXISTS `pelanggan`;

CREATE TABLE `pelanggan` (
  `ID_pelanggan` int(11) NOT NULL,
  `Nama_pelanggan` varchar(50) DEFAULT NULL,
  `No_Telp` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`ID_pelanggan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pelanggan` */

insert  into `pelanggan`(`ID_pelanggan`,`Nama_pelanggan`,`No_Telp`) values 
(1,'Rudi Hartono','089012345678'),
(2,'Siti Rahayu','088123456789'),
(3,'Ahmad Sudrajat','087234567890'),
(4,'Dewi Lestari','086345678901'),
(5,'Joko Widodo','085456789012'),
(6,'Lina Marlina','084567890123'),
(7,'Tina Sari','083678901234');

/*Table structure for table `penjualan` */

DROP TABLE IF EXISTS `penjualan`;

CREATE TABLE `penjualan` (
  `ID_penjualan` int(11) NOT NULL,
  `ID_pelanggan` int(11) DEFAULT NULL,
  `ID_karyawan` int(11) DEFAULT NULL,
  `Tanggal_penjualan` varchar(20) DEFAULT NULL,
  `Total_harga` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_penjualan`),
  KEY `ID_pelanggan` (`ID_pelanggan`),
  KEY `ID_karyawan` (`ID_karyawan`),
  CONSTRAINT `penjualan_ibfk_1` FOREIGN KEY (`ID_pelanggan`) REFERENCES `pelanggan` (`ID_pelanggan`),
  CONSTRAINT `penjualan_ibfk_2` FOREIGN KEY (`ID_karyawan`) REFERENCES `karyawan` (`ID_karyawan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `penjualan` */

insert  into `penjualan`(`ID_penjualan`,`ID_pelanggan`,`ID_karyawan`,`Tanggal_penjualan`,`Total_harga`) values 
(1,1,NULL,'2021-05-01','1500000'),
(2,2,NULL,'2022-06-02','2500000'),
(3,3,NULL,'2022-09-06','5000000'),
(4,4,NULL,'2023-09-20','3000000'),
(5,5,NULL,'2023-10-07','2000000'),
(6,6,NULL,'2024-10-19','3500000'),
(7,7,NULL,'2024-12-30','4000000');

/*Table structure for table `produk` */

DROP TABLE IF EXISTS `produk`;

CREATE TABLE `produk` (
  `ID_produk` int(11) NOT NULL,
  `ID_kategori` varchar(10) DEFAULT NULL,
  `Nama_produk` varchar(50) DEFAULT NULL,
  `Harga` varchar(50) DEFAULT NULL,
  `Stok` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_produk`),
  KEY `ID_kategori` (`ID_kategori`),
  CONSTRAINT `produk_ibfk_1` FOREIGN KEY (`ID_kategori`) REFERENCES `kategori` (`ID_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `produk` */

insert  into `produk`(`ID_produk`,`ID_kategori`,`Nama_produk`,`Harga`,`Stok`) values 
(1,'K001','Gitar Akustik','1500000',10),
(2,'K001','Gitar Elektrik','2500000',5),
(3,'K002','Piano Digital','5000000',3),
(4,'K003','Drum Set','3000000',4),
(5,'K004','Biola','2000000',6),
(6,'K005','Saxophone','3500000',2),
(7,'K006','Mixer DJ','4000000',3);

/*Table structure for table `view_avg_harga_produk` */

DROP TABLE IF EXISTS `view_avg_harga_produk`;

/*!50001 DROP VIEW IF EXISTS `view_avg_harga_produk` */;
/*!50001 DROP TABLE IF EXISTS `view_avg_harga_produk` */;

/*!50001 CREATE TABLE  `view_avg_harga_produk`(
 `Kategori` varchar(30) ,
 `Rata_rata_Harga` double 
)*/;

/*Table structure for table `view_detail_penjualan` */

DROP TABLE IF EXISTS `view_detail_penjualan`;

/*!50001 DROP VIEW IF EXISTS `view_detail_penjualan` */;
/*!50001 DROP TABLE IF EXISTS `view_detail_penjualan` */;

/*!50001 CREATE TABLE  `view_detail_penjualan`(
 `ID_penjualan` int(11) ,
 `Nama_pelanggan` varchar(50) ,
 `Nama_produk` varchar(50) ,
 `Jumlah` int(11) ,
 `Harga` varchar(50) ,
 `Subtotal` varchar(50) 
)*/;

/*Table structure for table `view_kategori_produk` */

DROP TABLE IF EXISTS `view_kategori_produk`;

/*!50001 DROP VIEW IF EXISTS `view_kategori_produk` */;
/*!50001 DROP TABLE IF EXISTS `view_kategori_produk` */;

/*!50001 CREATE TABLE  `view_kategori_produk`(
 `ID_produk` int(11) ,
 `Nama_produk` varchar(50) ,
 `Kategori` varchar(30) ,
 `Harga` varchar(50) ,
 `Stok` int(11) 
)*/;

/*Table structure for table `view_pelanggan` */

DROP TABLE IF EXISTS `view_pelanggan`;

/*!50001 DROP VIEW IF EXISTS `view_pelanggan` */;
/*!50001 DROP TABLE IF EXISTS `view_pelanggan` */;

/*!50001 CREATE TABLE  `view_pelanggan`(
 `Nama_pelanggan` varchar(50) ,
 `Total_harga` varchar(50) 
)*/;

/*Table structure for table `view_stok` */

DROP TABLE IF EXISTS `view_stok`;

/*!50001 DROP VIEW IF EXISTS `view_stok` */;
/*!50001 DROP TABLE IF EXISTS `view_stok` */;

/*!50001 CREATE TABLE  `view_stok`(
 `Nama_produk` varchar(50) ,
 `Stok` int(11) 
)*/;

/*View structure for view view_avg_harga_produk */

/*!50001 DROP TABLE IF EXISTS `view_avg_harga_produk` */;
/*!50001 DROP VIEW IF EXISTS `view_avg_harga_produk` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `view_avg_harga_produk` AS select `k`.`Kategori` AS `Kategori`,avg(`p`.`Harga`) AS `Rata_rata_Harga` from (`produk` `p` join `kategori` `k` on(`p`.`ID_kategori` = `k`.`ID_kategori`)) group by `k`.`Kategori` */;

/*View structure for view view_detail_penjualan */

/*!50001 DROP TABLE IF EXISTS `view_detail_penjualan` */;
/*!50001 DROP VIEW IF EXISTS `view_detail_penjualan` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `view_detail_penjualan` AS select `j`.`ID_penjualan` AS `ID_penjualan`,`b`.`Nama_pelanggan` AS `Nama_pelanggan`,`p`.`Nama_produk` AS `Nama_produk`,`d`.`Jumlah` AS `Jumlah`,`d`.`Harga` AS `Harga`,`d`.`Subtotal` AS `Subtotal` from (((`penjualan` `j` join `pelanggan` `b` on(`j`.`ID_pelanggan` = `b`.`ID_pelanggan`)) join `detailpenjualan` `d` on(`j`.`ID_penjualan` = `d`.`ID_penjualan`)) join `produk` `p` on(`d`.`ID_produk` = `p`.`ID_produk`)) */;

/*View structure for view view_kategori_produk */

/*!50001 DROP TABLE IF EXISTS `view_kategori_produk` */;
/*!50001 DROP VIEW IF EXISTS `view_kategori_produk` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `view_kategori_produk` AS select `p`.`ID_produk` AS `ID_produk`,`p`.`Nama_produk` AS `Nama_produk`,`k`.`Kategori` AS `Kategori`,`p`.`Harga` AS `Harga`,`p`.`Stok` AS `Stok` from (`produk` `p` join `kategori` `k` on(`p`.`ID_kategori` = `k`.`ID_kategori`)) */;

/*View structure for view view_pelanggan */

/*!50001 DROP TABLE IF EXISTS `view_pelanggan` */;
/*!50001 DROP VIEW IF EXISTS `view_pelanggan` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `view_pelanggan` AS select `b`.`Nama_pelanggan` AS `Nama_pelanggan`,`j`.`Total_harga` AS `Total_harga` from (`pelanggan` `b` join `penjualan` `j` on(`b`.`ID_pelanggan` = `j`.`ID_pelanggan`)) where `j`.`Total_harga` > '2000000' */;

/*View structure for view view_stok */

/*!50001 DROP TABLE IF EXISTS `view_stok` */;
/*!50001 DROP VIEW IF EXISTS `view_stok` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `view_stok` AS select `p`.`Nama_produk` AS `Nama_produk`,`p`.`Stok` AS `Stok` from `produk` `p` where `p`.`Stok` < 3 */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
