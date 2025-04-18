/*
SQLyog Community v13.3.0 (64 bit)
MySQL - 10.4.32-MariaDB : Database - db_perlengkapan_bayi
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_perlengkapan_bayi` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `db_perlengkapan_bayi`;

/*Table structure for table `detail_transaksi` */

DROP TABLE IF EXISTS `detail_transaksi`;

CREATE TABLE `detail_transaksi` (
  `id_detail` int(11) NOT NULL,
  `id_transaksi` int(11) DEFAULT NULL,
  `id_produk` int(11) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `subtotal` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_detail`),
  KEY `id_transaksi` (`id_transaksi`),
  KEY `id_produk` (`id_produk`),
  CONSTRAINT `detail_transaksi_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`),
  CONSTRAINT `detail_transaksi_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `detail_transaksi` */

insert  into `detail_transaksi`(`id_detail`,`id_transaksi`,`id_produk`,`jumlah`,`subtotal`) values 
(404,301,1001,1,75000),
(405,301,1003,2,90000),
(406,302,1002,1,120000),
(407,302,1004,1,80000),
(408,303,1002,1,120000),
(409,304,1003,1,45000),
(410,304,1001,1,75000);

/*Table structure for table `kategori_produk` */

DROP TABLE IF EXISTS `kategori_produk`;

CREATE TABLE `kategori_produk` (
  `id_kategori` int(11) NOT NULL,
  `nama_kategori` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `kategori_produk` */

insert  into `kategori_produk`(`id_kategori`,`nama_kategori`) values 
(101,'Pakaian Bayi'),
(102,'Makanan Bayi'),
(103,'Perlengkapan Mandi'),
(104,'Mainan Bayi');

/*Table structure for table `pelanggan` */

DROP TABLE IF EXISTS `pelanggan`;

CREATE TABLE `pelanggan` (
  `id_pelanggan` int(11) NOT NULL,
  `nama_pelanggan` varchar(50) DEFAULT NULL,
  `no_hp` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_pelanggan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pelanggan` */

insert  into `pelanggan`(`id_pelanggan`,`nama_pelanggan`,`no_hp`) values 
(201,'Ivory','081234567890'),
(202,'Dawin','089876543210'),
(203,'Vranza','082112334455'),
(204,'Liona','087712345678');

/*Table structure for table `produk` */

DROP TABLE IF EXISTS `produk`;

CREATE TABLE `produk` (
  `id_produk` int(11) NOT NULL,
  `nama_produk` varchar(50) DEFAULT NULL,
  `id_kategori` int(11) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL,
  `merek` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_produk`),
  KEY `id_kategori` (`id_kategori`),
  CONSTRAINT `produk_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategori_produk` (`id_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `produk` */

insert  into `produk`(`id_produk`,`nama_produk`,`id_kategori`,`harga`,`stok`,`merek`) values 
(1001,'Baju Bayi Katun',101,75000,30,'BabySoft'),
(1002,'Susu Formula A+',102,120000,50,'NutriBaby'),
(1003,'Shampoo Bayi Aloe Vera',103,45000,5,'FreshyBaby'),
(1004,'Mainan Gantung Musik',104,80000,3,'HappyBaby');

/*Table structure for table `transaksi` */

DROP TABLE IF EXISTS `transaksi`;

CREATE TABLE `transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `tanggal` date DEFAULT NULL,
  `id_pelanggan` int(11) DEFAULT NULL,
  `total_harga` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_transaksi`),
  KEY `id_pelanggan` (`id_pelanggan`),
  CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `transaksi` */

insert  into `transaksi`(`id_transaksi`,`tanggal`,`id_pelanggan`,`total_harga`) values 
(301,'2025-04-10',201,165000),
(302,'2025-04-11',202,200000),
(303,'2025-04-12',203,120000),
(304,'2025-04-13',204,130000);

/*Table structure for table `view_produk_dan_kategori` */

DROP TABLE IF EXISTS `view_produk_dan_kategori`;

/*!50001 DROP VIEW IF EXISTS `view_produk_dan_kategori` */;
/*!50001 DROP TABLE IF EXISTS `view_produk_dan_kategori` */;

/*!50001 CREATE TABLE  `view_produk_dan_kategori`(
 `nama_produk` varchar(50) ,
 `harga` int(11) ,
 `nama_kategori` varchar(50) 
)*/;

/*Table structure for table `view_produk_stok_rendah` */

DROP TABLE IF EXISTS `view_produk_stok_rendah`;

/*!50001 DROP VIEW IF EXISTS `view_produk_stok_rendah` */;
/*!50001 DROP TABLE IF EXISTS `view_produk_stok_rendah` */;

/*!50001 CREATE TABLE  `view_produk_stok_rendah`(
 `nama_produk` varchar(50) ,
 `stok` int(11) ,
 `nama_kategori` varchar(50) 
)*/;

/*Table structure for table `view_produk_terlaris` */

DROP TABLE IF EXISTS `view_produk_terlaris`;

/*!50001 DROP VIEW IF EXISTS `view_produk_terlaris` */;
/*!50001 DROP TABLE IF EXISTS `view_produk_terlaris` */;

/*!50001 CREATE TABLE  `view_produk_terlaris`(
 `nama_produk` varchar(50) ,
 `total_terjual` decimal(32,0) 
)*/;

/*Table structure for table `view_total_belanja_pelanggan` */

DROP TABLE IF EXISTS `view_total_belanja_pelanggan`;

/*!50001 DROP VIEW IF EXISTS `view_total_belanja_pelanggan` */;
/*!50001 DROP TABLE IF EXISTS `view_total_belanja_pelanggan` */;

/*!50001 CREATE TABLE  `view_total_belanja_pelanggan`(
 `nama_pelanggan` varchar(50) ,
 `jumlah_transaksi` bigint(21) ,
 `total_belanja` decimal(32,0) 
)*/;

/*Table structure for table `view_transaksi_lengkap` */

DROP TABLE IF EXISTS `view_transaksi_lengkap`;

/*!50001 DROP VIEW IF EXISTS `view_transaksi_lengkap` */;
/*!50001 DROP TABLE IF EXISTS `view_transaksi_lengkap` */;

/*!50001 CREATE TABLE  `view_transaksi_lengkap`(
 `id_transaksi` int(11) ,
 `tanggal` date ,
 `nama_pelanggan` varchar(50) ,
 `nama_produk` varchar(50) ,
 `jumlah` int(11) ,
 `subtotal` int(11) 
)*/;

/*View structure for view view_produk_dan_kategori */

/*!50001 DROP TABLE IF EXISTS `view_produk_dan_kategori` */;
/*!50001 DROP VIEW IF EXISTS `view_produk_dan_kategori` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_produk_dan_kategori` AS select `p`.`nama_produk` AS `nama_produk`,`p`.`harga` AS `harga`,`k`.`nama_kategori` AS `nama_kategori` from (`produk` `p` join `kategori_produk` `k` on(`p`.`id_kategori` = `k`.`id_kategori`)) */;

/*View structure for view view_produk_stok_rendah */

/*!50001 DROP TABLE IF EXISTS `view_produk_stok_rendah` */;
/*!50001 DROP VIEW IF EXISTS `view_produk_stok_rendah` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_produk_stok_rendah` AS select `p`.`nama_produk` AS `nama_produk`,`p`.`stok` AS `stok`,`k`.`nama_kategori` AS `nama_kategori` from (`produk` `p` join `kategori_produk` `k` on(`p`.`id_kategori` = `k`.`id_kategori`)) where `p`.`stok` < 10 */;

/*View structure for view view_produk_terlaris */

/*!50001 DROP TABLE IF EXISTS `view_produk_terlaris` */;
/*!50001 DROP VIEW IF EXISTS `view_produk_terlaris` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_produk_terlaris` AS select `p`.`nama_produk` AS `nama_produk`,sum(`dt`.`jumlah`) AS `total_terjual` from (`detail_transaksi` `dt` join `produk` `p` on(`dt`.`id_produk` = `p`.`id_produk`)) group by `p`.`id_produk` order by sum(`dt`.`jumlah`) desc */;

/*View structure for view view_total_belanja_pelanggan */

/*!50001 DROP TABLE IF EXISTS `view_total_belanja_pelanggan` */;
/*!50001 DROP VIEW IF EXISTS `view_total_belanja_pelanggan` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_total_belanja_pelanggan` AS select `pl`.`nama_pelanggan` AS `nama_pelanggan`,count(`t`.`id_transaksi`) AS `jumlah_transaksi`,sum(`t`.`total_harga`) AS `total_belanja` from (`pelanggan` `pl` join `transaksi` `t` on(`pl`.`id_pelanggan` = `t`.`id_pelanggan`)) group by `pl`.`id_pelanggan` */;

/*View structure for view view_transaksi_lengkap */

/*!50001 DROP TABLE IF EXISTS `view_transaksi_lengkap` */;
/*!50001 DROP VIEW IF EXISTS `view_transaksi_lengkap` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_transaksi_lengkap` AS select `t`.`id_transaksi` AS `id_transaksi`,`t`.`tanggal` AS `tanggal`,`pl`.`nama_pelanggan` AS `nama_pelanggan`,`pr`.`nama_produk` AS `nama_produk`,`dt`.`jumlah` AS `jumlah`,`dt`.`subtotal` AS `subtotal` from (((`transaksi` `t` join `pelanggan` `pl` on(`t`.`id_pelanggan` = `pl`.`id_pelanggan`)) join `detail_transaksi` `dt` on(`t`.`id_transaksi` = `dt`.`id_transaksi`)) join `produk` `pr` on(`dt`.`id_produk` = `pr`.`id_produk`)) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
