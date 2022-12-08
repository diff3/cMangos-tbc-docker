-- MariaDB dump 10.19  Distrib 10.10.2-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: tbcrealmd
-- ------------------------------------------------------
-- Server version	10.10.2-MariaDB-1:10.10.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `realmlist`
--

DROP TABLE IF EXISTS `realmlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `realmlist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  `address` varchar(32) NOT NULL DEFAULT '127.0.0.1',
  `port` int(11) NOT NULL DEFAULT 8085,
  `icon` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `realmflags` tinyint(3) unsigned NOT NULL DEFAULT 2 COMMENT 'Supported masks: 0x1 (invalid, not show in realm list), 0x2 (offline, set by mangosd), 0x4 (show version and build), 0x20 (new players), 0x40 (recommended)',
  `timezone` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `allowedSecurityLevel` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `population` float unsigned NOT NULL DEFAULT 0,
  `realmbuilds` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC COMMENT='Realm System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `realmlist`
--

LOCK TABLES `realmlist` WRITE;
/*!40000 ALTER TABLE `realmlist` DISABLE KEYS */;
INSERT INTO `realmlist` VALUES
(1,'Path of Glory','5.152.152.56',8085,6,0,8,0,0,'8606 ');
/*!40000 ALTER TABLE `realmlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `username` varchar(32) NOT NULL DEFAULT '',
  `gmlevel` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `sessionkey` longtext DEFAULT NULL,
  `v` longtext DEFAULT NULL,
  `s` longtext DEFAULT NULL,
  `email` text DEFAULT NULL,
  `joindate` timestamp NOT NULL DEFAULT current_timestamp(),
  `lockedIp` varchar(30) NOT NULL DEFAULT '0.0.0.0',
  `failed_logins` int(11) unsigned NOT NULL DEFAULT 0,
  `locked` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `last_module` char(32) DEFAULT '',
  `module_day` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `active_realm_id` int(11) unsigned NOT NULL DEFAULT 0,
  `expansion` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `mutetime` bigint(40) unsigned NOT NULL DEFAULT 0,
  `locale` varchar(4) NOT NULL DEFAULT '',
  `os` varchar(4) NOT NULL DEFAULT '0',
  `platform` varchar(4) NOT NULL DEFAULT '0',
  `token` text DEFAULT NULL,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`),
  KEY `idx_gmlevel` (`gmlevel`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC COMMENT='Account System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES
(9,'ANDRé',0,NULL,'44BA3E6E5C81BF9CFA89F4628BC9FD4BAAC3F5034AB7FACF695B8976DFA142C8','A386995A3BDD945098D6B09B1A80CA4EB02C452F843C0CC15246ED3F1CE6CBED',NULL,'2022-11-25 20:01:46','0.0.0.0',0,0,'',0,0,1,0,'','0','0',NULL,0),
(7,'DAVID',3,'D53EE2732DE159A7E36D87F46490D2F19955DC87EADCBC6771C5BBEBF6F7731DD703B18117A4C3E1','51A0C556D235572DAF98B70F1DCB748F3D71DB5543D35454BE7630892DBADB4F','E78C242773CBE6181522AF811DFD07C099A2399415062233521D6B9E38AC2643',NULL,'2022-11-21 20:13:34','0.0.0.0',0,0,'',0,0,1,0,'enUS','Win','x86',NULL,0),
(6,'PETRI',3,'C646A31789D9A916823469E93D1926D17262CD9D8DB8B88644E179A7993E788D53AF7B455E9720C5','0B59D3C7DD2875C9B5533AD616A6684A0F3F067AC7D603063393C2E76BA70463','EB45EB52A04959D07596B5EF7A645A915E90383D59894AFD1EA3A191182ED843',NULL,'2022-11-21 20:13:28','0.0.0.0',0,0,'',0,0,1,0,'enUS','Win','x86',NULL,0),
(5,'MAPE',4,'D6BF02C51D8A99325204E2B0F5C70D19489AB2801176C1B40CB0DD25E7B1524F93B270DA1F8CBDC9','598439E55FF93613E12E89B23A1348D38BDCEA98C77347C2A84EE1CC210C3BDE','B09701BDE2AAEF7E068438E831BAA8A2FF8301338C4F6420D26CCF4EA2683A47',NULL,'2022-11-21 14:51:57','0.0.0.0',0,0,'',0,0,1,0,'enUS','Win','x86',NULL,0),
(8,'CHRISTIAN',3,'DB724474EAB9A890EF0FFC45A4B96B5A0DCE4A557CD334ADF40DC93C3CC4C357DB0E9D154EAC3E5C','0180D5D35EBE6C603B37EFED76A6AC8F468A176BF490A5F45F6AC4CC5332A66D','B22B64DDEE94AC037B0614DE930AFA4C9F78EC3FA20B9383CB305ED9EE00DA83',NULL,'2022-11-25 12:50:26','0.0.0.0',0,0,'',0,0,1,0,'enUS','Win','x86',NULL,0),
(10,'BOSS',0,'E8DBB70CC7B9CBFD01420DEE3FD59F46A02FD18B315E9BF1181BB40854B3A1DD4853B7C713D1BED6','2E728D4EEE667CDAE5FBFB7D7FE9A46FE024AFA854CB31870EB3504F333CA647','9305700CA48A85C75D621CCC208D5BFEC40A194FD45440902E4007CE67A2565F',NULL,'2022-11-25 20:03:58','0.0.0.0',0,0,'',0,0,1,0,'enUS','Win','x86',NULL,0);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `realmcharacters`
--

DROP TABLE IF EXISTS `realmcharacters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `realmcharacters` (
  `realmid` int(11) unsigned NOT NULL DEFAULT 0,
  `acctid` bigint(20) unsigned NOT NULL,
  `numchars` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`realmid`,`acctid`),
  KEY `acctid` (`acctid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC COMMENT='Realm Character Tracker';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `realmcharacters`
--

LOCK TABLES `realmcharacters` WRITE;
/*!40000 ALTER TABLE `realmcharacters` DISABLE KEYS */;
INSERT INTO `realmcharacters` VALUES
(1,5,4),
(1,1,0),
(1,6,4),
(1,7,0),
(1,8,3),
(1,9,0),
(1,10,1);
/*!40000 ALTER TABLE `realmcharacters` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-06 11:06:35
