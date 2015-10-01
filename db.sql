-- MySQL dump 10.13  Distrib 5.5.29, for Win32 (x86)
--
-- Host: localhost    Database: grdigital_db
-- ------------------------------------------------------
-- Server version	5.5.29-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_client_notes`
--

DROP TABLE IF EXISTS `admin_client_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_client_notes` (
  `note_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `admin_id` bigint(20) NOT NULL,
  `note` varchar(255) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  PRIMARY KEY (`note_id`),
  KEY `admin_client_notes_ibfk_1` (`admin_id`),
  CONSTRAINT `admin_client_notes_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `administrators` (`admin_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_client_notes`
--

LOCK TABLES `admin_client_notes` WRITE;
/*!40000 ALTER TABLE `admin_client_notes` DISABLE KEYS */;
INSERT INTO `admin_client_notes` VALUES (74,24,52,'werwerewr','2014-07-26 11:59:53'),(75,24,52,'sdfsdfsdf','2014-07-26 12:00:26'),(76,20,52,'qwe','2014-07-26 12:00:36'),(77,23,52,'345345','2014-07-27 05:21:46'),(78,22,52,'345345','2014-07-27 05:21:55'),(81,28,52,'how are you','2014-07-27 08:32:49'),(82,29,52,'ertert','2014-07-27 08:48:36'),(83,32,52,'123','2014-07-30 21:34:32'),(84,32,52,'123','2014-07-30 21:34:34');
/*!40000 ALTER TABLE `admin_client_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_permissions`
--

DROP TABLE IF EXISTS `admin_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_permissions` (
  `admin_id` bigint(20) NOT NULL,
  `permission` varchar(50) DEFAULT NULL COMMENT 'investor: Investor, financing: Financing, reporting: Reporting',
  KEY `FK_admin_permissions_administrators` (`admin_id`),
  CONSTRAINT `FK_admin_permissions_administrators` FOREIGN KEY (`admin_id`) REFERENCES `administrators` (`admin_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_permissions`
--

LOCK TABLES `admin_permissions` WRITE;
/*!40000 ALTER TABLE `admin_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `administrators`
--

DROP TABLE IF EXISTS `administrators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `administrators` (
  `admin_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary',
  `username` varchar(100) NOT NULL COMMENT 'User name',
  `first_name` varbinary(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `passwd` varchar(100) NOT NULL,
  `company_id` int(11) NOT NULL COMMENT 'Primary of admin_companies',
  `email_addr` varchar(100) NOT NULL,
  `email_addr2` varchar(100) NOT NULL COMMENT 'Second email address',
  `created_time` datetime DEFAULT NULL,
  `is_super` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'if 1, super admin, else normal admin',
  `last_login_time` datetime NOT NULL,
  PRIMARY KEY (`admin_id`),
  KEY `administrators_ibfk_1` (`company_id`),
  CONSTRAINT `administrators_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrators`
--

LOCK TABLES `administrators` WRITE;
/*!40000 ALTER TABLE `administrators` DISABLE KEYS */;
INSERT INTO `administrators` VALUES (52,'admin','kim','daechol','202cb962ac59075b964b07152d234b70',1,'qwe@wr.com','','2014-07-24 20:33:10',1,'2014-07-31 10:58:29'),(55,'123','123','123','202cb962ac59075b964b07152d234b70',2,'123@123','','2014-07-30 08:55:56',0,'2014-07-30 21:35:38'),(56,'123123','123','123','202cb962ac59075b964b07152d234b70',1,'123@123','','2014-07-30 08:56:18',0,'0000-00-00 00:00:00'),(60,'eee@eee','eee','eee','d2f2297d6e829cd3493aa7de4416a18f',4,'eee@eee','','2014-07-30 09:04:30',0,'0000-00-00 00:00:00');
/*!40000 ALTER TABLE `administrators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_exit_strategies`
--

DROP TABLE IF EXISTS `client_exit_strategies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_exit_strategies` (
  `client_id` bigint(11) NOT NULL,
  `strategy_key` varchar(50) NOT NULL COMMENT 'flip: FLIP, buy_hold: Buy & Hold',
  KEY `client_id` (`client_id`),
  CONSTRAINT `client_exit_strategies_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Preferred Exit Strategy';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_exit_strategies`
--

LOCK TABLES `client_exit_strategies` WRITE;
/*!40000 ALTER TABLE `client_exit_strategies` DISABLE KEYS */;
INSERT INTO `client_exit_strategies` VALUES (29,'flip');
/*!40000 ALTER TABLE `client_exit_strategies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_feedbacks`
--

DROP TABLE IF EXISTS `client_feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_feedbacks` (
  `feedback_d` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `admin_id` bigint(20) NOT NULL,
  `feedback` varchar(255) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  PRIMARY KEY (`feedback_d`),
  KEY `client_id` (`client_id`),
  KEY `client_feedbacks_ibfk_1` (`admin_id`),
  CONSTRAINT `client_feedbacks_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `administrators` (`admin_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `client_feedbacks_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_feedbacks`
--

LOCK TABLES `client_feedbacks` WRITE;
/*!40000 ALTER TABLE `client_feedbacks` DISABLE KEYS */;
INSERT INTO `client_feedbacks` VALUES (1,32,52,'123123','2014-07-30 21:34:33'),(2,32,52,'123','2014-07-30 21:34:35');
/*!40000 ALTER TABLE `client_feedbacks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_financing_methods`
--

DROP TABLE IF EXISTS `client_financing_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_financing_methods` (
  `client_id` bigint(20) NOT NULL,
  `method_key` varchar(50) NOT NULL COMMENT 'cash: Cash, hard_money: Hard Money Loan, conventional: Conventional Loan',
  KEY `client_id` (`client_id`),
  CONSTRAINT `client_financing_methods_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_financing_methods`
--

LOCK TABLES `client_financing_methods` WRITE;
/*!40000 ALTER TABLE `client_financing_methods` DISABLE KEYS */;
INSERT INTO `client_financing_methods` VALUES (29,'cash');
/*!40000 ALTER TABLE `client_financing_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_interested_areas`
--

DROP TABLE IF EXISTS `client_interested_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_interested_areas` (
  `client_id` bigint(20) NOT NULL,
  `state` varchar(30) DEFAULT NULL COMMENT 'State code',
  `county` varbinary(50) NOT NULL COMMENT 'County name',
  KEY `client_interested_areas_ibfk_1` (`client_id`),
  CONSTRAINT `client_interested_areas_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='areas of interest for each client';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_interested_areas`
--

LOCK TABLES `client_interested_areas` WRITE;
/*!40000 ALTER TABLE `client_interested_areas` DISABLE KEYS */;
INSERT INTO `client_interested_areas` VALUES (29,'CA_N','Alameda'),(29,'CA_S','Imperial'),(29,'NM','ALL'),(29,'WA','Adams'),(32,'CA_N','Colusa'),(32,'CA_N','Fresno'),(32,'CA_N','Inyo');
/*!40000 ALTER TABLE `client_interested_areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_property_types`
--

DROP TABLE IF EXISTS `client_property_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_property_types` (
  `client_id` bigint(20) NOT NULL,
  `type_key` varchar(50) NOT NULL COMMENT 'commercial: Commercial, single_family: Single Family, multi_family: Multi Family',
  KEY `client_id` (`client_id`),
  CONSTRAINT `client_property_types_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_property_types`
--

LOCK TABLES `client_property_types` WRITE;
/*!40000 ALTER TABLE `client_property_types` DISABLE KEYS */;
INSERT INTO `client_property_types` VALUES (29,'single_family');
/*!40000 ALTER TABLE `client_property_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `client_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `username` varchar(100) NOT NULL,
  `passwd` varchar(100) NOT NULL COMMENT 'MD5',
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email_addr` varchar(100) NOT NULL,
  `business_entity` varchar(150) DEFAULT NULL COMMENT 'Business Entity',
  `business_address` varchar(150) DEFAULT NULL COMMENT 'Business Address',
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  `work_phone` varchar(50) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL COMMENT 'Fax Address',
  `mobile_phone` varchar(50) DEFAULT NULL,
  `company_name` varchar(150) NOT NULL,
  `financing_method` enum('cash','hard_money','conventional') DEFAULT 'cash' COMMENT 'cash: Cash, hard_money: Hard Money Loan, conventional: Conventional Loan',
  `property_type` enum('single_family','multi_family','commercial') DEFAULT 'single_family' COMMENT 'commercial: Commercial, single_family: Single Family, multi_family: Multi Family',
  `exit_strategy` enum('flip','buy_hold') DEFAULT 'flip' COMMENT 'Preferred Exit Strategy flip: FLIP, buy_hold: Buy & Hold',
  `available_assets` double NOT NULL COMMENT 'available assets for purchase',
  `last_purchased_investment_numbers` varchar(255) DEFAULT NULL COMMENT 'Numbers of investment properties purchased in the last 24 hours',
  `purchase_price_range_from` double DEFAULT NULL COMMENT 'Purchase Price Range (from)',
  `purchase_price_range_to` double DEFAULT NULL COMMENT 'Purchase Price Range To',
  `actived` tinyint(1) DEFAULT '1',
  `comments` varchar(250) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL COMMENT 'last login time',
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (29,'3456','def7924e3199be5e18060bb3e1d547a7','1','1','1@1',NULL,NULL,'1','1',1,'','1','','134567','cash','single_family','flip',100,'1r',100,100,1,'14','2014-07-27 08:46:29','2014-07-27 19:43:35'),(31,'user','0cc175b9c0f1b6a831c399e269772661','123','123','jinpung@hotmail.com',NULL,NULL,'123','123',123,'123','123','123','123','cash','single_family','flip',0,'',NULL,NULL,1,'','2014-07-27 19:21:21','2014-07-28 09:19:30'),(32,'123','282e45d5d10a9f79682739dc959bb5ac','111','11','1@12',NULL,NULL,'1','1',1,'1','1','1','1','cash','single_family','flip',0,'',NULL,NULL,1,'','2014-07-28 07:15:42',NULL);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(50) NOT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies`
--

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` VALUES (1,'CIVIC Home Loans'),(2,'HMC Assets'),(3,'TITAN Capital'),(4,'MAXIM Properties'),(5,'Wedgewood');
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_favorites`
--

DROP TABLE IF EXISTS `property_favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_favorites` (
  `property_id` bigint(20) NOT NULL COMMENT 'Primary of property_listings',
  `client_id` bigint(20) NOT NULL COMMENT 'Primary of clients',
  `created_time` datetime DEFAULT NULL,
  KEY `FK_property_favorites_clients` (`client_id`),
  KEY `FK_property_favorites_property_listings` (`property_id`),
  CONSTRAINT `FK_property_favorites_clients` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_property_favorites_property_listings` FOREIGN KEY (`property_id`) REFERENCES `property_listings` (`property_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_favorites`
--

LOCK TABLES `property_favorites` WRITE;
/*!40000 ALTER TABLE `property_favorites` DISABLE KEYS */;
INSERT INTO `property_favorites` VALUES (1879,29,'2014-07-27 19:43:51'),(1878,29,'2014-07-27 19:44:10');
/*!40000 ALTER TABLE `property_favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_listings`
--

DROP TABLE IF EXISTS `property_listings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_listings` (
  `property_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `npn_id` int(11) NOT NULL COMMENT 'NPN_ID',
  `sales_type` varchar(50) NOT NULL COMMENT 'Short Sales, Standard Sales, REO',
  `listing_status` varchar(50) NOT NULL COMMENT 'ListingStatus',
  `strike_price` double NOT NULL COMMENT 'StrikePrice',
  `property_status` varchar(50) DEFAULT NULL COMMENT 'PropertyStatus special, sold, new',
  `marketing_message` varchar(150) DEFAULT NULL COMMENT 'MarketingMessage',
  `street` varchar(50) NOT NULL COMMENT 'Street',
  `street_number` varchar(50) DEFAULT NULL COMMENT 'Street_Number',
  `city` varchar(30) NOT NULL COMMENT 'City',
  `state` varchar(30) NOT NULL COMMENT 'State',
  `county` varchar(50) NOT NULL COMMENT 'County',
  `zip` int(11) NOT NULL COMMENT 'Zip',
  `fcl_action_start_date` date DEFAULT NULL COMMENT 'Daily Extract 3::FCL Action Start Date',
  `date_ts` date DEFAULT NULL COMMENT 'Date_TS',
  `beds` int(11) DEFAULT NULL COMMENT 'Beds',
  `baths` int(11) DEFAULT NULL COMMENT 'Baths',
  `sqft` int(11) DEFAULT NULL COMMENT 'SQFT',
  `lot` double DEFAULT NULL,
  `pool_swim` int(11) DEFAULT NULL,
  `property_type` varchar(30) DEFAULT NULL COMMENT 'Property Type',
  `yearbuilt` int(11) DEFAULT NULL COMMENT 'YearBuilt',
  `occupancy` varchar(30) DEFAULT NULL COMMENT 'Occupancy',
  `ss_agent` varchar(50) DEFAULT NULL COMMENT 'SS Agent',
  `ss_email` varchar(50) DEFAULT NULL COMMENT 'SS Email',
  `ss_list_date` date DEFAULT NULL COMMENT 'SS List Date',
  `ss_phone` varbinary(50) DEFAULT NULL COMMENT 'SS Phone',
  `mls_id` varchar(50) DEFAULT NULL COMMENT 'MLS_ID#',
  `created_time` datetime NOT NULL,
  PRIMARY KEY (`property_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1999 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_listings`
--

LOCK TABLES `property_listings` WRITE;
/*!40000 ALTER TABLE `property_listings` DISABLE KEYS */;
INSERT INTO `property_listings` VALUES (1865,100721,'Short Sale','SS-Listed',345,NULL,NULL,'Gruen St','14058','Arleta (Pacoima)','CA','Los Angeles',1000,'2014-04-18',NULL,2,2,1530,0.15,0,'SFR',1943,'Occupied','Gilbert Ayala','ayalagilbert@gmail.com','2014-06-20','562-645-4040','DW14130700','2014-07-27 11:23:32'),(1866,100684,'Short Sale','SS-Listed',345,NULL,NULL,'East 44th Street','231','San Bernardino','CA','San Bernardino',92404,'2013-12-26','2014-07-22',2,1,1013,6750,0,'SFR',1950,'Occupied','Martha Lozano','oc.homes@hotmail.com','2014-05-27','949-525-5754','OC14118615','2014-07-27 11:23:32'),(1867,100976,'Short Sale','SS-Listed',345,NULL,NULL,'Plymouth Street','5792','Chino','CA','San Bernardino',91710,'2013-12-18','2014-08-01',4,2,1452,0.19,0,'SFR',1963,'Occupied','Eric Brown','eric@skyrealtyservices.com','2014-06-11','866-931-0107','IG14122075','2014-07-27 11:23:32'),(1868,100977,'Short Sale','SS-Listed',345,NULL,NULL,'Greenfield Avenue','5943','Riverside','CA','Riverside',92506,'2014-03-12','2014-07-25',2,1,1182,20908,0,'SFR',1949,'Occupied','Ricardo Diaz','Rick@mainstreetgroup.com','2014-02-10','951-532-7071','CV14029658','2014-07-27 11:23:32'),(1869,101018,'Short Sale','SS-Listed',345,NULL,NULL,'Gaviota Ct','15275','Victorville','CA','San Bernardino',92394,'2013-11-27','2014-07-25',4,3,1642,0.71,0,'SFR',2007,'Occupied','Gracie Velazquez','graciehomeexpert@yahoo.com','2013-09-13','760-842-6732','CV13188474','2014-07-27 11:23:32'),(1870,100984,'Short Sale','SS-Listed',345,NULL,NULL,'Quimby Avenue','7909','West Hills','CA','Los Angeles',91304,'2013-12-04','2014-07-24',3,2,1669,0.16,0,'SFR',1958,'Occupied','Jessica Griffith','jessica@ocdrealty.com','2014-01-27','714-603-8010','OC14018615','2014-07-27 11:23:32'),(1871,100721,'Short Sale Negotiating','SS-Negotiating',0,'','','Gruen St','14058','Arleta (Pacoima)','CA','Los Angeles',91331,'2014-04-18','2014-08-19',2,2,1530,0.15,0,'SFR',1943,'Occupied','Gilbert Ayala','ayalagilbert@gmail.com','2014-06-20','562-645-4040','DW14130700','2014-07-27 11:24:41'),(1872,100684,'Short Sale','SS-Listed',0,'','','East 44th Street','231','San Bernardino','CA','San Bernardino',92404,'2013-12-26','2014-08-06',2,1,1013,6750,0,'SFR',1950,'Occupied','Martha Lozano','oc.homes@hotmail.com','2014-05-27','949-525-5754','OC14118615','2014-07-27 11:24:41'),(1873,100976,'Short Sale','SS-Listed',345,NULL,NULL,'Plymouth Street','5792','Chino','CA','San Bernardino',91710,'2013-12-18','2014-08-01',4,2,1452,0.19,0,'SFR',1963,'Occupied','Eric Brown','eric@skyrealtyservices.com','2014-06-11','866-931-0107','IG14122075','2014-07-27 11:24:41'),(1874,100977,'Short Sale','SS-Listed',0,'','','Greenfield Avenue','5943','Riverside','CA','Riverside',92506,'2014-03-12','2014-08-08',1,1,1182,20908,0,'SFR',1949,'Occupied','Ricardo Diaz','Rick@mainstreetgroup.com','2014-02-10','951-532-7071','CV14029658','2014-07-27 11:24:41'),(1875,101018,'Short Sale','SS-Listed',0,'','','Gaviota Ct','15275','Victorville','CA','San Bernardino',92394,'2013-11-27','2014-08-15',4,3,1642,0.71,0,'SFR',2007,'Occupied','Gracie Velazquez','graciehomeexpert@yahoo.com','2013-09-13','760-842-6732','CV13188474','2014-07-27 11:24:41'),(1876,100984,'Short Sale','SS-Listed',345,NULL,NULL,'Quimby Avenue','7909','West Hills','CA','Los Angeles',91304,'2013-12-04','2014-07-24',3,2,1669,0.16,0,'SFR',1958,'Occupied','Jessica Griffith','jessica@ocdrealty.com','2014-01-27','714-603-8010','OC14018615','2014-07-27 11:24:41'),(1877,3,'Short Sale','SS-Listed',345,NULL,NULL,'Quimby Avenue','-6823','West Hills','CA','Los Angeles',89124,'2013-12-18','2014-07-22',1,0,1723,-0.94,0,'SFR',1860,'Occupied','Jessica Griffith','jessica@ocdrealty.com','2014-10-26','714-603-8011','OC14018616','2014-07-27 11:27:56'),(1878,12,'Short Sale','SS-Listed',345,NULL,NULL,'Gaviota Ct','-14189','Victorville','CA','San Bernardino',88034,'2013-12-25','2014-07-21',0,-1,1750,-1.49,0,'SFR',1811,'Occupied','Gracie Velazquez','graciehomeexpert@yahoo.com','2015-03-11','760-842-6734','CV13188476','2014-07-27 11:27:56'),(1879,1,'Short Sale','SS-Listed',345,NULL,NULL,'Quimby Avenue','-21555','West Hills','CA','Los Angeles',86944,'2014-01-01','2014-07-20',-1,-2,1777,-2.04,0,'SFR',1762,'Occupied','Jessica Griffith','ertertert','2015-07-25','714-603-8012','OC14018617','2014-07-27 11:27:56'),(1880,101044,'Short Sale','SS-Listed',0,'','','Larabee Court 2','27423','Murrieta','CA','Riverside',92562,'2014-06-23',NULL,3,3,1428,400,0,'Condo',2007,'Occupied','Ryan Stein','ryan@ryanjstein.com','2012-11-20','619-276-1177','120057750','2014-07-30 18:19:11'),(1881,101407,'Short Sale','SS-Listed',0,'','','N Sloan Ave #ABCD','814','Compton','CA','Los Angeles',90221,'2014-01-30','2014-08-06',4,4,2408,7065,0,'4 Plex',1955,'Occupied','Graciela Farnsworth','gracifarns@gmail.com','2012-10-22','626.484.4113','P839079','2014-07-30 18:19:11'),(1882,101143,'Short Sale','SS-Listed',0,'','','S Pacific Coast Hwy # C','706','Redondo Beach','CA','Los Angeles',90277,'2014-03-27','2014-07-31',3,3,1600,0,0,'Condo',2007,'Occupied','Dinorah Carmenate','dinorah@pbdconsultants.com','2014-07-11','714.928.4001','PW14146862','2014-07-30 18:19:11'),(1883,101175,'Short Sale','SS-Listed',0,'','','Via San Carlo','3000','Montebello','CA','Los Angeles',90640,'2013-12-26','2014-08-05',4,4,2628,5062,0,'SFR',1940,'Occupied','Vu Ly & Karen','karyn.au@gmail.com','2014-04-16','323-997-0786 & 626-625-3911','AR14078162','2014-07-30 18:19:11'),(1884,101132,'Short Sale','SS-Listed',0,'','','East 55th St','52','Long Beach','CA','Los Angeles',90805,'2014-02-13','2014-08-12',2,1,671,6244,0,'SFR',1923,'Occupied','Adela Olivares','aocasas@yahoo.com','2013-12-02','714-619-8817','PW13240903','2014-07-30 18:19:11'),(1885,101416,'Short Sale','SS-Listed',0,'','','Valley View Road #112','1313','Glendale','CA','Los Angeles',91202,'2014-01-30','2014-08-22',2,2,1167,0,0,'Condo',1981,'Occupied','Kory Jackson','KoryJackson@gmail.com','2014-05-29','310-717-3720','14-765041','2014-07-30 18:19:11'),(1886,101460,'Short Sale','SS-Listed',0,'','','Dyer St','13394','Los Angeles','CA','Los Angeles',91342,'2014-01-30','2014-09-03',4,2,1197,0.17,0,'SFR',1955,'Occupied','Maggie Carnot','','2014-07-06','818-630-0324','214026067','2014-07-30 18:19:11'),(1887,101474,'Short Sale','SS-Listed',0,'','','Ramona Ave','22192','Apple Valley','CA','San Bernardino',92307,'2014-01-30','2014-08-07',3,2,1473,0.37,0,'SFR',1987,'vacant','Tony Smith','tony.s@century21fairway.com','2014-01-17','909.772.6633','IV14006869','2014-07-30 18:19:11'),(1888,101414,'Short Sale','SS-Listed',0,'','','West 26th St','1086','San Bernardino','CA','San Bernardino',92405,'2014-03-31','2014-09-03',4,2,1456,8120,0,'SFR',1943,'Occupied','Karla Mendoza','karla0342@gmail.com','2014-07-08','(909)549-3751','CV14144229','2014-07-30 18:19:11'),(1889,101145,'Short Sale','SS-Listed',0,'','','Volande Court','859','Perris','CA','Riverside',92571,'2014-01-07','2014-08-15',4,4,3461,9583,0,'SFR',2007,'Occupied','Lawrence E. Haynes, Goshen Properties','lhaynes@goshenproperties.net','2014-07-07','(619) 306-4267','14-775121','2014-07-30 18:19:11'),(1890,101419,'Short Sale','SS-Listed',0,'','','Western Village Drive','1424','San Jacinto','CA','Riverside',92583,'2014-02-04','2014-08-06',3,2,1597,0.17,0,'SFR',1988,'Vacant','Dinorah Carmenate','dinorah@pbdconsultants.com','2014-07-14','714-928-4001','','2014-07-30 18:19:11'),(1891,101774,'Short Sale','SS-Listed',0,'','','COASTSITE DR #205','32700','PALOS VERDES ESTATES','CA','Los Angeles',90275,'2014-07-21',NULL,2,2,1565,0,0,'Condo',1964,'Vacant','Kory Jackson','koryjackson@gmail.com','2014-05-22','310-717-3720','14-762857','2014-07-30 18:19:11'),(1892,101558,'Short Sale','SS-Listed',0,'','','MARGUERITE DRIVE','55','SAN PABLO','CA','Contra Costa',94806,'2014-06-17',NULL,4,2,1439,0.17,0,'SFR',1954,'Occupied','Evelia Hernandez','evy_hernandez@yahoo.com','2014-07-16','510-798-6107','','2014-07-30 18:19:11'),(1893,101502,'Short Sale','SS-Listed',0,'','','GEORGE AVENUE','4229','OLIVEHURST','CA','Yuba',95961,'2014-07-25',NULL,3,2,1351,0.23,0,'SFR',1990,'Vacant','Anne Dailey','anneedailey@yahoo.com','2014-06-13','916.548.1358','14036589','2014-07-30 18:19:11'),(1894,101567,'Short Sale','SS-Listed',0,'','','SARDINIA ROAD','82355','INDIO','CA','Riverside',92203,'2014-07-02',NULL,4,3,2439,8276,0,'SFR',2006,'Occupied','Ray Jones','ridealmkr@msn.com','2014-06-07','(760)391-8109','214022229','2014-07-30 18:19:11'),(1895,101562,'Short Sale','SS-Listed',0,'','','MARIPOSA AVENUE #802','22919','TORRANCE','CA','Los Angeles',90502,NULL,NULL,3,3,1380,0,0,'Condo',2009,'Occupied','william awty','sandyawty@yahoo.com','2014-07-15','310-316-3295','WS14148838','2014-07-30 18:19:11'),(1896,101589,'Short Sale','SS-Listed',0,'','','MOON CIRCLE #538','500','FOLSOM','CA','Sacramento',95630,'2014-06-03',NULL,2,2,1018,0,0,'Condo',2007,'Occupied','Heret A Arnaz','heret@kw.com','2013-10-06','916-496-2556','13059630','2014-07-30 18:19:11'),(1897,101545,'Short Sale','SS-Listed',0,'','','BASSWOOD DRIVE','13660','CORONA','CA','Riverside',92883,'2014-07-02',NULL,3,2,1639,0.17,0,'SFR',1996,'Occupied','Jose Cortez','Cotrez951@hotmail.com','2014-06-26','9519076955','SW14132964','2014-07-30 18:19:11'),(1898,101541,'Short Sale','SS-Listed',0,'','','MARCH WAY','13176','AREA OF CORONA','CA','Riverside',92879,'2014-06-26','2014-08-06',3,2,1611,6534,0,'SFR',1988,'Occupied','Pablo Vasquez','pablo.vazquez@primetimerealtor.com','2014-06-05','909-257-8467','CV14118421','2014-07-30 18:19:11'),(1899,102044,'Short Sale','SS-Listed',0,'','','JERRY LANE','25409','HEMET','CA','Riverside',92544,'2014-05-23',NULL,2,2,1610,0.17,0,'Other: mobile Home',1976,'Occupied','Dinorah Carmenate','dinorah@pbdconsultants.com','2014-04-25','714.928.4001','PW14092524','2014-07-30 18:19:11'),(1900,101824,'Short Sale','SS-Listed',0,'','','CAMANCHE PARKWAY NORTH','4150','IONE','CA','Amador',95640,'2014-06-27',NULL,2,2,1922,0.3,0,'SFR',1999,'Vacant','James Sharpe','jsharpe@interogateway.com','2014-06-01','916-500-1197','14036419','2014-07-30 18:19:11'),(1901,101823,'Short Sale','SS-Listed',0,'','','TUMBLEWEED WAY','1619','MARYSVILLE','CA','Yuba',95901,'2014-07-01',NULL,4,2,1491,0.13,0,'SFR',1991,'Vacant','Anne Daily','annedaily@yahoo.com','2014-07-10','916.880.9817','14043646','2014-07-30 18:19:11'),(1902,101826,'Short Sale','SS-Listed',0,'','','SEBASTIAN WAY','1324','SACRAMENTO','CA','Sacramento',95864,'2014-06-27',NULL,3,1,1081,0.14,0,'SFR',1952,'Occupied','Anne Dailey','offers@annedaily.com','2014-07-10','916.880.9817','O1RMXG66','2014-07-30 18:19:11'),(1903,101903,'Short Sale','SS-Listed',0,'','','BELLE VISTA DRIVE #193','475','CHULA VISTA','CA','San Diego',91910,'2014-06-27',NULL,2,2,920,0,0,'SFR',1995,'Vacant','John Altman','jtaltman@cox.net','2014-05-23','619-890-2581','140026494','2014-07-30 18:19:11'),(1904,101938,'Short Sale','SS-Listed',0,'','','WEST 21ST STREET','909','MERCED','CA','Merced',95340,'2014-07-08',NULL,2,1,1025,7500,0,'SFR',1920,'Vacant','Ryan Ramirez','ryan@ryanramirez.net','2014-05-27','559.978.2693','MC14109209','2014-07-30 18:19:11'),(1905,102068,'Short Sale','SS-Listed',0,'','','HEALEY DRIVE','9122','GARDEN GROVE','CA','Orange',92841,NULL,NULL,3,2,1055,7405,0,'SFR',1956,'Occupied','Adele Olivares','aocasas@yahoo.com','2014-07-17','(714) 667-2123','PW14148230','2014-07-30 18:19:11'),(1906,102071,'Short Sale','SS-Listed',0,'','','PASEO BRAVO','140','PALM DESERT','CA','Riverside',92211,'2014-07-01',NULL,2,2,1465,0,0,'Condo',2008,'Occupied','Debbie Dimmagio','debbiedimaggio@gmail.com','2014-05-05','760-396-8358','214017316','2014-07-30 18:19:11'),(1907,101847,'Short Sale','SS-Listed',0,'','','32ND STREET','2642','SACRAMENTO','CA','Sacramento',95817,'2014-06-24',NULL,3,1,1021,0.046,0,'SFR',1946,'Vacant','KC Davis','kdavis@gmail.com','2013-08-19','9167944276','14028547','2014-07-30 18:19:11'),(1908,101971,'Short Sale','SS-Listed',0,'','','SHOEMAKER AVENUE','2367','MERCED','CA','Merced',95348,'2014-02-18','2014-08-29',3,2,1381,5000,0,'SFR',2006,'Occupied','Travis C Azevedo','travis@travisazevedo.com','2014-07-02','209-575-0231','14038935','2014-07-30 18:19:11'),(1909,102088,'Short Sale','SS-Listed',0,'','','WEST WOODCREST STREET','844','RIALTO','CA','San Bernardino',92316,NULL,NULL,4,3,1875,0.11,0,'SFR',1999,'Occupied','Ariel Carmona','realdealc21@aol.com','2014-06-01','626-290-7854','DW14113535','2014-07-30 18:19:11'),(1910,102098,'Short Sale','SS-Listed',0,'','','REMINGTON STREET','10996','ADELANTO','CA','San Bernardino',92301,NULL,NULL,3,2,1492,7446,0,'SFR',2012,'Occupied','Nancy Fenn','nfenn@gmail.com','2014-02-18','(760) 952-2520','439393','2014-07-30 18:19:11'),(1911,102090,'Short Sale','SS-Listed',0,'','','SPRUCE LANE','267','SUGARLOAF','CA','San Bernardino',92386,'2014-06-26',NULL,2,1,774,2500,0,'SFR',1985,'Vacant','Stacy McQueen','smcqueen760@gmail.com','2014-05-20','760-985-2108','IV14106526','2014-07-30 18:19:11'),(1912,102515,'Short Sale','SS-Listed',0,'','','GOLDENSTAR STREET','3613','PLUMAS LAKE','CA','Yuba',95961,'2014-06-25',NULL,4,3,3081,0.2,0,'SFR',2008,'Occupied','Tallie Sengwong','yshomesforsale@gmail.com','2014-07-25','530-218-0604','201402418','2014-07-30 18:19:11'),(1913,101908,'Short Sale','SS-Listed',0,'','','SKYLINE ST','1012','CALEXICO','CA','Imperial',92231,'2014-07-01',NULL,3,2,1458,0.14,0,'SFR',1993,'Occupied','Luz Garcia','prizila.flowersrealty@ymail.com','2013-10-23','7603577111','35806','2014-07-30 18:19:11'),(1914,101952,'Short Sale','SS-Listed',0,'','','JAGUAR CT','6231','RIVERBANK','CA','Stanislaus',95367,'2014-07-21',NULL,3,2,1794,6244,0,'SFR',1993,'Vacant','Travis Azevedo','Travis@travisazevedo.com','2014-05-22','310-746-6232','14031023','2014-07-30 18:19:11'),(1915,102057,'Short Sale','SS-Listed',0,'','','BERRYWOOD DRIVE','19785','LAKE ELSINORE','CA','Riverside',92530,NULL,NULL,4,2,2823,6534,0,'SFR',2008,'Occupied','Dinorah Carmenate','dinorah@pbdconsultants.com','2014-07-07','714.928.4001','PW14144586','2014-07-30 18:19:11'),(1916,102478,'Short Sale','SS-Listed',0,'','','FIGWOOD DRIVE','14374','FONTANA','CA','San Bernardino',92337,'2014-07-03',NULL,3,2,1171,0.09,0,'SFR',1984,'Occupied','Dinorah Carmenate','dinorah@pbdconsultants.com','2014-07-04','714.928.4001','PW14145575','2014-07-30 18:19:11'),(1917,102107,'Short Sale','SS-Listed',0,'','','CALDARO','28102','LAGUNA NIGUEL','CA','Orange',92677,'2014-06-25',NULL,2,2,1100,0,0,'Condo',1989,'Occupied','Michael Plummer','pacificcoastpartners@gmail.com','2014-04-15','949.478.1660','PW14078127','2014-07-30 18:19:11'),(1918,102109,'Short Sale','SS-Listed',0,'','','COMSTOCK ROAD','10363','CORONA','CA','Riverside',92883,'2014-07-18',NULL,3,2,1440,0.1,0,'Manuf. Home',1985,'Occupied','Scott Chappell','scottlouischappell@gmail.com','2014-04-20','951-313-4350','K12050899','2014-07-30 18:19:11'),(1919,101803,'Short Sale','SS-Listed',0,'','','LARCH WAY','2608','ANTIOCH','CA','Contra Costa',94509,NULL,NULL,5,3,2534,5814,0,'SFR',1992,'Occupied','Tami Gosselin','tgosselin@c21mm.com','2014-07-20','209-557-2609','81426483','2014-07-30 18:19:11'),(1920,102442,'Short Sale','SS-Listed',0,'','','CEDAR DRIVE','7535','CITRUS HEIGHTS','CA','Sacramento',95610,'2014-06-24',NULL,4,2,1824,0.23,0,'SFR',1946,'Occupied','Lisa Sampson','lsampson@golyon.com','2014-05-07','(916)261-4969','14027946','2014-07-30 18:19:11'),(1921,102113,'Short Sale','SS-Listed',0,'','','AUGUST CIRCLE','13051','RIVERSIDE','CA','Riverside',92503,'2014-07-03',NULL,3,2,1928,8276,0,'SFR',1988,'Occupied','Mohammad Tweini','ryan@quick-fund.com','2014-06-30','(909)606-6100','PW14151476','2014-07-30 18:19:11'),(1922,101917,'Short Sale','SS-Listed',0,'','','BUENA ROSA COURT','2621','FALLBROOK','CA','San Diego',92028,'2014-07-03',NULL,3,2,1320,0.22,0,'SFR',1978,'Occupied','Mike Richards','mike@mrmiker.com','2014-07-21','(760)518-9031','140040086','2014-07-30 18:19:11'),(1923,102198,'Short Sale','SS-Listed',0,'','','MASON AVENUE #B','8241','WINNETKA','CA','Los Angeles',91306,NULL,NULL,3,3,1424,0,0,'Condo',1979,'Occupied','Lanita Morgan','Lanitalanita@sbcglobal.net','2014-07-08','(310)386-5432','14-776009','2014-07-30 18:19:11'),(1924,102444,'Short Sale','SS-Listed',0,'','','EAST SPRING STREET #11E','7890','LONG BEACH','CA','Los Angeles',90815,'2014-07-01',NULL,2,2,1101,0,0,'Condo',1974,'Vacant','RUTH QUEIJA','RUTHQUEIJA@gmail.com','2014-03-16','626-893-1072','CV14048319','2014-07-30 18:19:11'),(1925,102333,'Short Sale','SS-Listed',0,'','','JAN COURT','5572','REDDING','CA','Shasta',96003,'2014-07-03',NULL,3,2,2244,0.17,0,'SFR',2004,'Vacant','Micheal Staplecamp','mms@sbcglobal.net','2014-06-02','(530) 949-9683Ê','14-2491','2014-07-30 18:19:11'),(1926,102137,'Short Sale','SS-Listed',0,'','','AVENIDA MONTEFLORA','15496','DESERT HOT SPRINGS','CA','Riverside',92240,'2014-07-02',NULL,4,2,1692,7405,0,'SFR',2007,'Occupied','Jesus Martinez','jmtzgroup@aol.com','2014-06-20','760-347-3303','214027950','2014-07-30 18:19:11'),(1927,102208,'Short Sale','SS-Listed',0,'','','ABINGDON STREET','12103','NORWALK','CA','Los Angeles',90650,'2014-07-15',NULL,3,2,1414,5467,0,'SFR',1948,'Vacant','Dinorah Carmenate','dinorah@pbdconsultants.com','2014-07-25','714-928-4001','PW14157036','2014-07-30 18:19:11'),(1928,101998,'Short Sale','SS-Listed',0,'','','SOUTH SABRE AVENUE','2333','FRESNO','CA','Fresno',93727,'2014-07-03',NULL,4,2,1486,0.165,0,'SFR',2008,'Vacant','Ryan Ramirez','ryan@ryanramirez.net','2014-07-11','559.978.2693','429120','2014-07-30 18:19:11'),(1929,101870,'Short Sale','SS-Listed',0,'','','LEADER AVE','5415','SACRAMENTO','CA','Sacramento',95841,'2014-07-01',NULL,3,2,1246,0.15,0,'SFR',1957,'Occupied','Victoria Leas','victoria@victoriasproperties.com','2013-06-20','916-955-4744','13035539','2014-07-30 18:19:11'),(1930,102121,'Short Sale','SS-Listed',0,'','','DATE STREET','34940','YUCAIPA','CA','San Bernardino',92399,'2014-07-09',NULL,3,2,1792,7405,0,'SFR',1965,'Occupied','Tony Arauz','tony@interorc.com','2014-07-01','714-390-8270','CV14137984','2014-07-30 18:19:11'),(1931,102124,'Short Sale','SS-Listed',0,'','','BRENTWORTH ST','31753','MENIFEE','CA','Riverside',92584,'2014-06-25',NULL,6,4,3986,0.17,0,'SFR',2009,'Occupied','STEVEN RUGG','','2014-04-16','(909) 261-6629','IV14156633','2014-07-30 18:19:11'),(1932,102308,'Short Sale','SS-Listed',0,'','','BRENTWORTH ST','31893','MENIFEE','CA','Riverside',92584,'2014-07-15',NULL,4,3,2369,0.2,0,'SFR',2009,'Occupied','Denise Macfarland','denise@deniserealtors.com','2014-04-08','951.551.4169','SW14071329','2014-07-30 18:19:11'),(1933,102470,'Short Sale','SS-Listed',0,'','','EAST ANAHEIM ST NO 221','4835','LONG BEACH','CA','Los Angeles',90804,'2014-07-02',NULL,2,2,1263,0,0,'Condo',1976,'Occupied','Penelope Woodside','penelopewoodside@verizon.net','2014-04-24','562.264.5902','PW14084604','2014-07-30 18:19:11'),(1934,102014,'Short Sale','SS-Listed',0,'','','NORTH MCCAFFREY AVENUE','6044','FRESNO','CA','Fresno',93722,'2014-07-03',NULL,3,2,1584,7800,0,'SFR',1991,'Occupied','Jose L Martinez','josejooj@aol.com','2014-06-19','559-341-9447','428019','2014-07-30 18:19:11'),(1935,102138,'Short Sale','SS-Listed',0,'','','ETHAN ST','12822','VICTORVILLE','CA','San Bernardino',92392,'2014-07-16',NULL,6,3,3447,7317,0,'SFR',2009,'Occupied','Jose Rodiguez','jose@gorlty.com','2014-07-09','760-792-0292','CV14145097','2014-07-30 18:19:11'),(1936,102143,'Short Sale','SS-Listed',0,'','','SHADY VIEW DRIVE, #408','17871','CHINO HILLS','CA','San Bernardino',91709,'2014-06-24',NULL,2,2,1059,871,0,'Condo',2010,'Vacant','Nicole Nelson','nicole@realbeachliving.com','2014-06-24','714-362-1929','OC14121712','2014-07-30 18:19:11'),(1937,102146,'Short Sale','SS-Listed',0,'','','QUARTZ LANE','320','BARSTOW','CA','San Bernardino',92311,'2014-06-23',NULL,4,2,1818,7068,0,'SFR',1981,'Occupied','Andrew Rodriguez','arloanpro@aol.com','2014-06-27','9094843165','IV14133034','2014-07-30 18:19:11'),(1938,102219,'Short Sale','SS-Listed',0,'','','COCINA LANE','4834','PALMDALE','CA','Los Angeles',93551,'2014-07-02',NULL,5,3,2522,7583,0,'SFR',1988,'Occupied','Robert L. Holmes','robert@ssrav.com','2014-04-29','661.816.9600','1404787','2014-07-30 18:19:11'),(1939,101927,'Short Sale','SS-Listed',0,'','','CALLE DEL GRECO','4676','OCEANSIDE','CA','San Diego',92056,'2014-06-23',NULL,3,3,1904,4357,0,'SFR',1995,'Occupied','Dinorah Carmenate','dinorah@pbdconsultants.com','2014-05-09','714.928.4001','140029680','2014-07-30 18:19:11'),(1940,102218,'Short Sale','SS-Listed',0,'','','VIA ONDULANDO','637','VENTURA','CA','Ventura',93003,'2014-06-27',NULL,3,2,2756,12210,0,'SFR',1959,'Occupied','Dinorah Carmenate','dinorah@pbdconsultants.com','2014-07-16','714.928.4001','','2014-07-30 18:19:11'),(1941,102147,'Short Sale','SS-Listed',0,'','','TURTLE MOUNTAIN CIR','7672','CORONA','CA','Riverside',92880,'2014-07-01',NULL,4,3,2791,8276,0,'SFR',2007,'Occupied','Debbie Dimaggio','debbiedimaggio@gmail.com','2014-06-12','760-396-8358','2140022850','2014-07-30 18:19:11'),(1942,102027,'Short Sale','SS-Listed',0,'','','W BOSTON AVE','1212','RIDGECREST','CA','Kern',93555,'2014-07-07',NULL,3,1,936,0.14,0,'SFR',1976,'Vacant','Dru Hawkins','dru@bestrealty.net','2014-05-01','760-375-3855','1914778','2014-07-30 18:19:11'),(1943,102319,'Short Sale','SS-Listed',0,'','','NEWCASTLE WAY','2760','SAN JACINTO','CA','Riverside',92582,'2014-07-02',NULL,5,4,3148,0.17,0,'SFR',2005,'Occupied','Steve Loera','steve@thefreedomgrp.com','2013-04-21','626-590-9257','CV14081633','2014-07-30 18:19:11'),(1944,102366,'Short Sale','SS-Listed',0,'','','NORTH ACACIA AVENUE','700704','COMPTON','CA','Los Angeles',90220,'2014-07-02',NULL,8,4,1704,4997,0,'Duplex',1948,'Occupied','David Holstein','david@theholsteingroup.com','2014-06-02','310-345-9994','SB14115102','2014-07-30 18:19:11'),(1945,101898,'Short Sale','SS-Listed',0,'','','WASATCH DRIVE','3765','REDDING','CA','Shasta',96001,'2014-07-02',NULL,3,2,1460,0.26,0,'SFR',1979,'Occupied','Darren Stevens','dstevens@reddingrealty.com','2014-06-23','530.227.1755','14-3054','2014-07-30 18:19:11'),(1946,102222,'Short Sale','SS-Listed',0,'','','WINDMILL LANE','7003','PARAMOUNT','CA','Los Angeles',90723,'2014-07-16',NULL,3,3,1390,0,0,'Condo',2011,'Occupied','Dinorah Carmenate','dinorah@pbdconsultants.com','2014-07-15','714.928.4001','','2014-07-30 18:19:11'),(1947,102413,'Short Sale','SS-Listed',0,'','','PLATTE AVENUE','1323','VENTURA','CA','Ventura',93004,'2014-06-26',NULL,3,2,1328,6350,0,'SFR',1964,'Occupied','','',NULL,'','','2014-07-30 18:19:11'),(1948,102493,'Short Sale','SS-Listed',0,'','','TRUMBLE CT','41396','INDIO','CA','Riverside',92203,'2014-07-17',NULL,2,2,1524,9148,0,'SFR',2005,'Occupied','Tennley taylor','realestate@tennleytaylor.com','2014-02-21','760-578-3418','214007807','2014-07-30 18:19:11'),(1949,101498,'Short Sale','SS-Listed (Investor)',0,'','','S. ELM STREET','985','PIXLEY','CA','Tulare',93256,NULL,NULL,2,1,1130,0.22,0,'SFR',1951,'Vacant','Margo Visalia','margopierce.visalia@gmail.com','2014-05-12','559-799-2397','109218','2014-07-30 18:19:11'),(1950,101546,'Short Sale','SS-Listed (Investor)',0,'','','LASSELLE STREET #101','15647','MORENO VALLEY','CA','Riverside',92551,'2014-06-03',NULL,2,3,1444,0,0,'Condo',2008,'Vacant','Dinorah Carmenate','dinorah@pbdconsultants.com','2014-05-01','(714)928-4001','PW14092485','2014-07-30 18:19:11'),(1951,102056,'Short Sale','SS-Listed (Investor)',0,'','','SAGE STREET','16701','HESPERIA','CA','San Bernardino',92345,'2014-07-01',NULL,3,1,1415,0.45,0,'SFR',1959,'Occupied','Colleen Couse','couse2house@aol.com','2014-05-30','760-963-4615','386103','2014-07-30 18:19:11'),(1952,102425,'Short Sale','SS-Listed (Investor)',0,'','','EL MIRADOR BOULEVARD','9845','DESERT HOT SPRINGS','CA','Riverside',92240,NULL,NULL,2,2,1488,6970,0,'SFR',1984,'Vacant','Debbie Dimaggio','debbiedimaggio@gmail.com','2014-06-06','760-396-8358','214022868','2014-07-30 18:19:11'),(1953,102417,'Short Sale','SS-Listed (Investor)',0,'','','MORIAH WAY','4144','NORTH HIGHLANDS','CA','Sacramento',95660,'2014-07-02',NULL,3,1,1013,0.14,0,'SFR',1960,'Occupied','Anne Daily','anneedaily@yahoo.com','2014-07-11','916.548.1358','','2014-07-30 18:19:11'),(1954,102446,'Short Sale','SS-Listed (Investor)',0,'','','VIA LOMAS #211','25841','LAGUNA HILLS','CA','Orange',92653,'2014-07-01',NULL,2,2,897,0,0,'Condo',1981,'Occupied','Dinorah Carmenate','dinorah@pbdconsultants.com','2014-04-23','714.928.4001','','2014-07-30 18:19:11'),(1955,102087,'Short Sale','SS-Listed (Investor)',0,'','','NORTH E STREET','4468','SAN BERNARDINO','CA','San Bernardino',92407,'2014-06-27',NULL,3,1,1326,8400,0,'SFR',1947,'Vacant','','',NULL,'','','2014-07-30 18:19:11'),(1956,101864,'Short Sale','SS-Listed (Investor)',0,'','','SKYLARK LANE','2611','CAMINO','CA','El Dorado',95709,'2014-07-02',NULL,3,3,2997,2.03,0,'SFR',1986,'Vacant','Samuel Weiner','sweiner@golyon.com','2014-06-17','(916)765-1250','14037635','2014-07-30 18:19:11'),(1957,102247,'Short Sale','SS-Listed (Investor)',0,'','','MORGAN HILL ROAD','1390','HAYFORK','CA','Trinity',96041,'2014-07-02',NULL,1,1,800,0.33,0,'SFR',1960,'Occupied','Summer Bashore','sbashore@gmail.com','2014-01-14','530-209-6536','2107253','2014-07-30 18:19:11'),(1958,102519,'Short Sale','SS-Listed (Investor)',0,'','','MCGEE DRIVE','13929','WHITTIER AREA','CA','Los Angeles',90605,NULL,NULL,3,2,1396,6081,0,'SFR',1952,'Vacant','Kelli Duenas(Coldwell Banker)','kellilynnduenas@yahoo.com','2013-09-05','562-587-0559','PW13182317','2014-07-30 18:19:11'),(1959,101895,'Short Sale','SS-Listed (Investor)',0,'','','SLAYTON DRIVE','1290','MANTECA','CA','San Joaquin',95336,'2014-06-27',NULL,3,2,1430,0.14,0,'SFR',1964,'Vacant','Donell Snyder/ CO List VIncent Denny','donell@snyderres.com/ donell@snyderRes.com','2014-04-09','209-483-5112','14021880','2014-07-30 18:19:11'),(1960,101062,'Standard Sale','Standard Sale',0,'','','Bella Vista','39030','Temecula','CA','Riverside',92592,'2014-05-07',NULL,3,4,3689,101059,0,'SFR',1990,'Occupied','Janett Lewis','janeetsd@gmail.com','2014-04-17','8587170070','SW14077762','2014-07-30 18:19:11'),(1961,101192,'Standard Sale','Standard Sale',0,'','','Abbott Rd','4971','Lynwood','CA','Los Angeles',90262,'2014-07-24',NULL,2,1,796,4417,0,'SFR',1944,'Occupied','Kory Jackson','koryjackson@gmail.com','2014-07-03','(310)717-3720','14-774551','2014-07-30 18:19:11'),(1962,101530,'Standard Sale','Standard Sale',0,'','','N PHILLIP AVE','4235','FRESNO','CA','Fresno',93727,'2014-06-18',NULL,3,2,1104,0.183,0,'SFR',1962,'Occupied','Jim Graydon','jim.graydon@reoexperts.com','2014-04-18','925.584.9886','425438','2014-07-30 18:19:11'),(1963,101580,'Standard Sale','Standard Sale',0,'','','SORREL DRIVE','2414','TURLOCK','CA','Stanislaus',95380,'2014-07-14',NULL,3,2,1646,0.13,0,'SFR',2001,'Occupied','Marcus Brown','marcus@jp-realtors.com','2014-07-14','209-552-1818','14044049','2014-07-30 18:19:11'),(1964,101536,'Standard Sale','Standard Sale',0,'','','BARRYMORE AVENUE','45503','LANCASTER','CA','Los Angeles',93534,'2014-05-19',NULL,4,3,2569,6878,0,'SFR',1999,'Vacant','Oscar Duarte','realtor@oduarte.com','2014-05-30','661-810-9086','406003','2014-07-30 18:19:11'),(1965,102306,'Standard Sale','Standard Sale',0,'','','STANFORD AVENUE','10138','SOUTH GATE','CA','Los Angeles',90280,'2014-07-21',NULL,3,1,1070,4641,0,'SFR',1941,'Occupied','Dinorah Carmenate','dinorah@pbdconsultants.com','2014-05-14','714.928.4001','PW14103338','2014-07-30 18:19:11'),(1966,101840,'Standard Sale','Standard Sale',0,'','','W. SANTA CRUZ WAY','240','MOUNTAIN HOUSE','CA','San Joaquin',95391,NULL,NULL,2,2,1347,0.0683,0,'SFR',2008,'Occupied','Gordon E. Guenter','gco***@sbcglobal.net','2014-06-20','(916) 204-8644','14031696','2014-07-30 18:19:11'),(1967,101833,'Standard Sale','Standard Sale',0,'','','PARC EAST DRIVE','1544','YUBA CITY','CA','Sutter',95993,'2014-07-02',NULL,3,2,1675,0.18,0,'SFR',2002,'Occupied','Cindy Carr','cindyrcarr@aol.com','2014-07-11','(530) 844-3322','201402351','2014-07-30 18:19:11'),(1968,102294,'Standard Sale','Standard Sale',0,'','','HEMLOCK AVENUE','11168','HESPERIA','CA','San Bernardino',92345,'2010-11-02','2014-08-01',3,2,1038,0.38,0,'SFR',1972,'Occupied','Lasonya Siler','lasonyasiler@hotmail.com','2013-11-22','909-648-1118','IV13237391','2014-07-30 18:19:11'),(1969,102276,'Standard Sale','Standard Sale',0,'','','STETSON DRIVE','541','OAKDALE','CA','Stanislaus',95361,'2014-06-26',NULL,4,3,2841,5838,0,'SFR',2005,'Occupied','Travis Azevedo','travis@travisazevedo.com','2014-06-24','(209)552-9677','14039102','2014-07-30 18:19:11'),(1970,102339,'Standard Sale','Standard Sale',0,'','','KODIAK ISLAND PLACE','3450','WEST SACRAMENTO','CA','Yolo',95691,'2014-07-18',NULL,3,2,1474,0.2,0,'SFR',2000,'Occupied','Jaclyn Little','','2014-06-20','916-412-1623','14038542','2014-07-30 18:19:11'),(1971,102329,'Standard Sale','Standard Sale',0,'','','SAPUNOR WAY','5605','CARMICHAEL','CA','Sacramento',95608,'2014-07-02',NULL,3,2,1078,0.14,0,'SFR',1958,'Occupied','peter parker & alex miller','alex@peterparkerteam.com','2014-06-17','916)585-3636','14037703','2014-07-30 18:19:11'),(1972,102285,'Standard Sale','Standard Sale',0,'','','THRUSH WAY','3134','PERRIS','CA','Riverside',92571,'2014-06-17',NULL,3,3,2991,0.15,0,'SFR',2006,'Occupied','Kelli Vanevenhoven','info@VTeamHomes.com','2014-05-15','909-980-1818','CV14101371','2014-07-30 18:19:11'),(1973,102359,'Standard Sale','Standard Sale',0,'','','ALBIZIA COURT','746','PERRIS','CA','Riverside',92571,'2014-07-03',NULL,5,3,3115,0.21,0,'SFR',2007,'Occupied','Zane Shaker','zane.shaker@gmail.com','2014-02-07','7149448965','SR14109035','2014-07-30 18:19:11'),(1974,101811,'Standard Sale','Standard Sale',0,'','','CROW CANYON ROAD','3763','SAN RAMON','CA','Contra Costa',94582,'2014-07-03',NULL,2,2,1107,0,0,'Condo',1989,'Occupied','Elena Riazanova','ahernmda@aol.com','2014-05-05','9258382201','40620160','2014-07-30 18:19:11'),(1975,102293,'Standard Sale','Standard Sale',0,'','','CALTHA WAY','1930','PERRIS','CA','Riverside',92571,'2014-07-01',NULL,4,2,1925,5663,0,'SFR',2009,'Occupied','Debbie Dimaggio','debbiedimaggio@gmail.com','2014-07-28','760-396-8358','','2014-07-30 18:19:11'),(1976,102498,'Standard Sale','Standard Sale',0,'','','AVENIDA DE CALMA','15700','MORENO VALLEY','CA','Riverside',92555,'2014-07-02',NULL,5,3,3771,6970,0,'SFR',2004,'Occupied','DOLLY ANDRE - BROKER','dolly.andre@gmail.com','2014-05-30','951-278-8755/ 95-500-0550','IV13242513','2014-07-30 18:19:11'),(1977,102518,'Standard Sale','Standard Sale',0,'','','CEDAR LN','86','SAN JOSE','CA','Santa Clara',95127,'2014-06-27',NULL,3,1,1523,8100,0,'SFR',1947,'Vacant','Greg Wang','gregwang168@gmail.com','2014-07-05','(408)828-6366','81423912','2014-07-30 18:19:11'),(1978,102411,'Standard Sale','Standard Sale',0,'','','RAINBOW RIDGE STREET','2105','CORONA','CA','Riverside',92882,NULL,NULL,4,2,1337,0.17,0,'SFR',1966,'Vacant','Vickie Covey','vcovey@sbcglobal.net','2014-05-19','714-313-3417','PW14092008','2014-07-30 18:19:11'),(1979,102372,'Standard Sale','Standard Sale',0,'','','CATAWBA AVENUE','6877','FONTANA','CA','San Bernardino',92336,NULL,NULL,3,2,1111,0.29,0,'SFR',1981,'Occupied','VIDAL CORONA','VCorona@VESTAFINANCIALCAPITAL.com','2014-06-25','714-757-4283','CV14134818','2014-07-30 18:19:11'),(1980,101205,'Short Sale Negotiating','SS-Negotiating',0,'','','Flight Ave','8437','Chino','CA','San Bernardino',91708,'2014-04-16',NULL,3,3,1852,0,0,'Condo',2008,'Occupied','Kathy Chocek','kathychocek@sbcglobal.net','2014-03-31','714-240-5383','OC14060467','2014-07-30 18:19:11'),(1981,101293,'Short Sale Negotiating','SS-Negotiating',0,'','','Middlebury St','37544','Palmdale','CA','Los Angeles',93550,'2014-04-02','2014-08-08',4,3,1779,6986,0,'SFR',1987,'Occupied','Manny Gonzalez','manng.realty@gmail.com','2014-04-09','661.860.7292','SR14073049','2014-07-30 18:19:11'),(1982,101590,'Short Sale Negotiating','SS-Negotiating',0,'','','GRAMERCY DRIVE UNIT #287','9150','SAN DIEGO','CA','San Diego',92123,'2014-06-10',NULL,2,2,1044,0,0,'Condo',1980,'Vacant','Lori Gomez','lorigomezpru@yahoo.com','2013-01-10','858.717.0867','1400005634','2014-07-30 18:19:11'),(1983,101929,'Short Sale Negotiating','SS-Negotiating',0,'','','EAST ROOSEVELT COURT','1839','VISALIA','CA','Tulare',93292,NULL,NULL,3,2,1075,0.14,0,'SFR',1993,'Vacant','Margo Pierce','margopierce.visalia@gmail.com',NULL,'559-805-7373','','2014-07-30 18:19:11'),(1984,102094,'Short Sale Negotiating','SS-Negotiating',0,'','','HILLSBOROUGH DRIVE','14423','VICTORVILLE','CA','San Bernardino',92392,'2014-06-27',NULL,3,2,1768,8320,0,'SFR',1990,'Occupied','Melville E Campbell (','showbiz1121@msn.com','2014-07-19','760-486-4947','444498','2014-07-30 18:19:11'),(1985,102083,'Short Sale Negotiating','SS-Negotiating',0,'','','TARA LANE','34753','YUCAIPA','CA','San Bernardino',92399,'2014-07-03',NULL,3,2,1250,1600,0,'SFR',1994,'Occupied','Debbie Dimaggio','debbiedimaggio@gmail.com','2014-04-23','760-396-8358','214015751','2014-07-30 18:19:11'),(1986,102062,'Short Sale Negotiating','SS-Negotiating',0,'','','HIGH RIDGE ST','11336','ADELANTO','CA','San Bernardino',92301,NULL,NULL,3,2,1466,8400,0,'SFR',2004,'Occupied','Stacy McQueen','smcqueen@gmail.com','2014-05-24','909-980-5000','443072','2014-07-30 18:19:11'),(1987,102191,'Short Sale Negotiating','SS-Negotiating',0,'','','RAMONA AVE','13439','HAWTHORNE','CA','Los Angeles',90250,'2014-06-26',NULL,2,1,900,6190,0,'SFR',1942,'Occupied','Susana Calvillo','rosie@remaxtimerealty.com','2014-05-30','909-702-8972','CV14113158','2014-07-30 18:19:11'),(1988,102118,'Short Sale Negotiating','SS-Negotiating',0,'','','MAPLE LANE','420','CRESTLINE','CA','San Bernardino',92325,'2014-06-24',NULL,2,1,1008,5400,0,'SFR',1945,'Occupied','Marion Ramirez','marionadvantagerealty@aol.com','2014-07-11','909-815-3939','IG14150757','2014-07-30 18:19:11'),(1989,102404,'Short Sale Negotiating','SS-Negotiating',0,'','','BRIDGES COURT','83930','INDIO','CA','Riverside',92203,NULL,NULL,3,3,2273,7841,0,'SFR',2006,'Occupied','Trent Teigen','trentteigen@yahoo.com','2014-05-01','760-641-0075','692420001','2014-07-30 18:19:11'),(1990,102527,'Short Sale Negotiating','SS-Negotiating',0,'','','SOUTH 31ST STREET','345347','SAN DIEGO','CA','San Diego',92113,'2014-07-01',NULL,4,2,1459,0.09,0,'Duplex',2003,'Occupied','Joel Perez','home.invemting@yahoo.com','2014-06-05','619-361-2417','140030559','2014-07-30 18:19:11'),(1991,102134,'Short Sale Negotiating','SS-Negotiating',0,'','','DANDELION WAY','12471','VICTORVILLE','CA','San Bernardino',92392,'2014-07-21',NULL,3,3,2590,8715,0,'SFR',2007,'Occupied','Antonina Erbst','ninaerbst@kw.com','2014-06-03','(909) 793-2100','EV14114521','2014-07-30 18:19:11'),(1992,102511,'Short Sale Negotiating','SS-Negotiating',0,'','','BLACKBURN DRIVE','960','CORONA','CA','Riverside',92880,NULL,NULL,3,3,2040,0,0,'Condo',2007,'Occupied','Alberto Silva','alsilvarealtor@verizon.net','2014-06-12','(909) 772-6633','CV14124517','2014-07-30 18:19:11'),(1993,101896,'Short Sale Negotiating','SS-Negotiating',0,'','','LAKEHILLS DRIVE','1599','EL DORADO HILLS','CA','El Dorado',95762,'2014-07-15',NULL,3,2,1568,12092,0,'SFR',1978,'Occupied','RALPH OSBORNE','bosbourne@myinsightre.com','2014-05-23','916-941-1123','14026433','2014-07-30 18:19:11'),(1994,101764,'Short Sale','SS-Listed',0,'','','BEL AIRE DR','1000','ROSWELL','NM','Chaves',88201,NULL,NULL,4,3,2910,9200,0,'SFR',1975,'Occupied','Rocky Langley','rlangley14@gmail.com','2014-06-14','575-622-0875','101214','2014-07-30 18:19:11'),(1995,101769,'Short Sale','SS-Listed',0,'','','PAINTED PONY DR NW','5914','ALBUQUERQUE','NM','Bernalillo',87120,'2013-07-17',NULL,3,2,1920,0.16,0,'SFR',1990,'Vacant','Ron Campbell','realtor3@ix.netcom.com','2014-05-23','505-991-3124','','2014-07-30 18:19:11'),(1996,101752,'Short Sale Negotiating','SS-Negotiating',0,'','','WALNUT CANYON ROAD SW','10705','ALBUQUERQUE','NM','Bernalillo',87121,'2014-06-25',NULL,3,2,1900,0.12,0,'SFR',2007,'Occupied','Jeremy Martinez- Virtue Realty Group','trujose@aol.com','2014-04-06','505-401-0504','','2014-07-30 18:19:11'),(1997,102673,'Short Sale Negotiating','SS-Negotiating',0,'','','SHELTIE COURT NORTHEAST','7005','RIO RANCHO','NM','Sandoval',87144,'2014-07-15',NULL,2,2,1096,0.13,0,'SFR',2003,'Vacant','Cathy Andersen','cathy@homelandnm.com','2014-06-04','505-450-2168','816315','2014-07-30 18:19:11'),(1998,101126,'Short Sale','SS-Listed',0,'','','135th Court SE','32938','Auburn','WA','King',98092,'2014-04-10','2014-09-19',3,3,3820,0.51,0,'SFR',2004,'Vacant','Kai Rainey','team@aliseroberts.com','2013-10-10','206-965-8896','554002','2014-07-30 18:19:11');
/*!40000 ALTER TABLE `property_listings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_notes`
--

DROP TABLE IF EXISTS `property_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_notes` (
  `note_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `property_id` bigint(20) DEFAULT NULL COMMENT 'Primary of property_listings If null, personal note',
  `client_id` bigint(20) NOT NULL COMMENT 'Primary of clients',
  `note` text NOT NULL COMMENT 'Note text',
  `created_time` datetime NOT NULL,
  PRIMARY KEY (`note_id`),
  KEY `FK_property_notes_clients` (`client_id`),
  KEY `FK_property_notes_property_listings` (`property_id`),
  CONSTRAINT `FK_property_notes_clients` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_property_notes_property_listings` FOREIGN KEY (`property_id`) REFERENCES `property_listings` (`property_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_notes`
--

LOCK TABLES `property_notes` WRITE;
/*!40000 ALTER TABLE `property_notes` DISABLE KEYS */;
INSERT INTO `property_notes` VALUES (34,1869,29,'435345345','0000-00-00 00:00:00'),(35,1879,29,'234234234','2014-07-27 19:43:49'),(36,1878,29,'2342342342342333333333333333333333333333333333333333333333333333333','2014-07-27 19:44:09'),(37,1871,29,'fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff','2014-07-27 19:46:51'),(38,1871,29,'fqwe\nqwe\nqwe\nqwe\nqw\ne\nqwe','2014-07-27 19:48:53');
/*!40000 ALTER TABLE `property_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `propertyview_tracks`
--

DROP TABLE IF EXISTS `propertyview_tracks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `propertyview_tracks` (
  `property_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  `last_view_time` datetime DEFAULT NULL,
  KEY `propertyview_tracks_ibfk_1` (`property_id`),
  KEY `propertyview_tracks_ibfk_2` (`client_id`),
  CONSTRAINT `propertyview_tracks_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `property_listings` (`property_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `propertyview_tracks_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propertyview_tracks`
--

LOCK TABLES `propertyview_tracks` WRITE;
/*!40000 ALTER TABLE `propertyview_tracks` DISABLE KEYS */;
INSERT INTO `propertyview_tracks` VALUES (1879,29,'2014-07-27 19:43:46'),(1878,29,'2014-07-27 19:44:03'),(1871,29,'2014-07-27 19:46:35');
/*!40000 ALTER TABLE `propertyview_tracks` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-08-03 23:32:41
