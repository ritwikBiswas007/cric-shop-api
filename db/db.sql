-- MySQL dump 10.13  Distrib 5.6.38, for Linux (x86_64)
--
-- Host: localhost    Database: uscricke_db1
-- ------------------------------------------------------
-- Server version	5.6.38

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
-- Table structure for table `account_transactions`
--

DROP TABLE IF EXISTS `account_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `type` enum('debit','credit') COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_type` enum('opening_balance','fund_transfer','deposit') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(22,4) NOT NULL,
  `reff_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operation_date` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `transaction_payment_id` int(11) DEFAULT NULL,
  `transfer_transaction_id` int(11) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_transactions_account_id_index` (`account_id`),
  KEY `account_transactions_transaction_id_index` (`transaction_id`),
  KEY `account_transactions_transaction_payment_id_index` (`transaction_payment_id`),
  KEY `account_transactions_transfer_transaction_id_index` (`transfer_transaction_id`),
  KEY `account_transactions_created_by_index` (`created_by`),
  KEY `account_transactions_type_index` (`type`),
  KEY `account_transactions_sub_type_index` (`sub_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_transactions`
--

LOCK TABLES `account_transactions` WRITE;
/*!40000 ALTER TABLE `account_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_types`
--

DROP TABLE IF EXISTS `account_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_account_type_id` int(11) DEFAULT NULL,
  `business_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_types_parent_account_type_id_index` (`parent_account_type_id`),
  KEY `account_types_business_id_index` (`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_types`
--

LOCK TABLES `account_types` WRITE;
/*!40000 ALTER TABLE `account_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_details` text COLLATE utf8mb4_unicode_ci,
  `account_type_id` int(11) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_by` int(11) NOT NULL,
  `is_closed` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `accounts_business_id_index` (`business_id`),
  KEY `accounts_account_type_id_index` (`account_type_id`),
  KEY `accounts_created_by_index` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_log`
--

DROP TABLE IF EXISTS `activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `subject_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_id` int(11) DEFAULT NULL,
  `causer_id` int(11) DEFAULT NULL,
  `causer_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `properties` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_log_log_name_index` (`log_name`)
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_log`
--

LOCK TABLES `activity_log` WRITE;
/*!40000 ALTER TABLE `activity_log` DISABLE KEYS */;
INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_id`, `subject_type`, `business_id`, `causer_id`, `causer_type`, `properties`, `created_at`, `updated_at`) VALUES (1,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-06-12 08:06:12','2021-06-12 08:06:12'),(2,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-06-12 08:12:35','2021-06-12 08:12:35'),(3,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-06-12 08:14:40','2021-06-12 08:14:40'),(4,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-06-12 13:51:40','2021-06-12 13:51:40'),(5,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-06-21 05:21:00','2021-06-21 05:21:00'),(6,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-06-21 07:26:44','2021-06-21 07:26:44'),(7,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-06-21 07:26:48','2021-06-21 07:26:48'),(8,'default','added',4,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":125}}','2021-06-21 07:33:41','2021-06-21 07:33:41'),(9,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-06-21 07:38:04','2021-06-21 07:38:04'),(10,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-06-21 07:38:16','2021-06-21 07:38:16'),(11,'default','added',4,'App\\Contact',1,1,'App\\User','[]','2021-06-21 07:41:07','2021-06-21 07:41:07'),(12,'default','added',5,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":125}}','2021-06-21 07:41:22','2021-06-21 07:41:22'),(13,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-06-21 15:07:35','2021-06-21 15:07:35'),(14,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-06-23 04:45:31','2021-06-23 04:45:31'),(15,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-06-24 03:39:49','2021-06-24 03:39:49'),(16,'default','added',6,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":625}}','2021-06-24 03:45:39','2021-06-24 03:45:39'),(17,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-06-24 04:00:49','2021-06-24 04:00:49'),(18,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-06-24 16:30:12','2021-06-24 16:30:12'),(19,'default','added',7,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"due\",\"final_total\":500}}','2021-06-24 16:48:37','2021-06-24 16:48:37'),(20,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-06-24 16:51:12','2021-06-24 16:51:12'),(21,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-06-27 02:49:50','2021-06-27 02:49:50'),(22,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-06-27 04:13:12','2021-06-27 04:13:12'),(23,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-01 00:40:22','2021-07-01 00:40:22'),(24,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-07-01 02:51:00','2021-07-01 02:51:00'),(25,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-01 02:51:12','2021-07-01 02:51:12'),(26,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-02 08:15:42','2021-07-02 08:15:42'),(27,'default','added',677,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":48.39999999999999857891452847979962825775146484375}}','2021-07-02 08:18:00','2021-07-02 08:18:00'),(28,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-02 08:28:05','2021-07-02 08:28:05'),(29,'default','added',678,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":66}}','2021-07-02 08:29:45','2021-07-02 08:29:45'),(30,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-02 08:34:41','2021-07-02 08:34:41'),(31,'default','added',679,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":142}}','2021-07-02 08:35:40','2021-07-02 08:35:40'),(32,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-02 08:52:18','2021-07-02 08:52:18'),(33,'default','added',680,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":238}}','2021-07-02 08:53:22','2021-07-02 08:53:22'),(34,'default','added',681,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":32}}','2021-07-02 08:53:58','2021-07-02 08:53:58'),(35,'default','added',682,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":80}}','2021-07-02 08:55:08','2021-07-02 08:55:08'),(36,'default','added',683,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":32}}','2021-07-02 08:55:25','2021-07-02 08:55:25'),(37,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-02 12:34:02','2021-07-02 12:34:02'),(38,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-03 03:37:30','2021-07-03 03:37:30'),(39,'default','sell_deleted',7,'App\\Transaction',1,1,'App\\User','{\"id\":7,\"invoice_no\":\"0004\",\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"due\",\"final_total\":\"500.0000\"}}','2021-07-03 03:49:11','2021-07-03 03:49:11'),(40,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-03 18:54:01','2021-07-03 18:54:01'),(41,'default','added',684,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":20}}','2021-07-03 18:56:23','2021-07-03 18:56:23'),(42,'default','added',685,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":22.440000000000001278976924368180334568023681640625}}','2021-07-03 19:05:26','2021-07-03 19:05:26'),(43,'default','added',5,'App\\Contact',1,1,'App\\User','[]','2021-07-03 19:06:58','2021-07-03 19:06:58'),(44,'default','added',686,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"due\",\"final_total\":95}}','2021-07-03 19:07:01','2021-07-03 19:07:01'),(45,'default','added',687,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell_return\",\"final_total\":95}}','2021-07-03 19:18:54','2021-07-03 19:18:54'),(46,'default','added',6,'App\\Contact',1,1,'App\\User','[]','2021-07-03 19:24:04','2021-07-03 19:24:04'),(47,'default','added',688,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"purchase\",\"status\":\"received\",\"payment_status\":\"due\",\"final_total\":60}}','2021-07-03 19:24:12','2021-07-03 19:24:12'),(48,'default','added',689,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":24}}','2021-07-03 19:32:24','2021-07-03 19:32:24'),(49,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-04 10:38:01','2021-07-04 10:38:01'),(50,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-06 15:44:03','2021-07-06 15:44:03'),(51,'default','added',690,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":40}}','2021-07-06 15:45:55','2021-07-06 15:45:55'),(52,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-08 18:55:42','2021-07-08 18:55:42'),(53,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-09 03:15:30','2021-07-09 03:15:30'),(54,'default','added',691,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":48}}','2021-07-09 03:21:56','2021-07-09 03:21:56'),(55,'default','added',692,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":12}}','2021-07-09 03:48:44','2021-07-09 03:48:44'),(56,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-09 19:19:21','2021-07-09 19:19:21'),(57,'default','added',694,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":1920}}','2021-07-09 20:27:35','2021-07-09 20:27:35'),(58,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-10 03:45:01','2021-07-10 03:45:01'),(59,'default','added',695,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":20}}','2021-07-10 16:31:26','2021-07-10 16:31:26'),(60,'default','added',696,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":20}}','2021-07-10 16:32:33','2021-07-10 16:32:33'),(61,'default','added',698,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":88}}','2021-07-10 16:39:41','2021-07-10 16:39:41'),(62,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-10 18:45:20','2021-07-10 18:45:20'),(63,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-11 02:34:15','2021-07-11 02:34:15'),(64,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-11 04:07:01','2021-07-11 04:07:01'),(65,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-11 06:47:45','2021-07-11 06:47:45'),(66,'default','added',703,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":125}}','2021-07-11 12:23:00','2021-07-11 12:23:00'),(67,'default','added',704,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":125}}','2021-07-11 12:24:17','2021-07-11 12:24:17'),(68,'default','added',705,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":20}}','2021-07-11 13:39:31','2021-07-11 13:39:31'),(69,'default','added',706,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":20}}','2021-07-11 13:41:52','2021-07-11 13:41:52'),(70,'default','added',707,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":20}}','2021-07-11 14:17:53','2021-07-11 14:17:53'),(71,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-12 04:43:36','2021-07-12 04:43:36'),(72,'default','added',708,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":368}}','2021-07-13 06:51:44','2021-07-13 06:51:44'),(73,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-13 15:17:54','2021-07-13 15:17:54'),(74,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-14 15:13:48','2021-07-14 15:13:48'),(75,'default','added',709,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":37}}','2021-07-14 15:14:10','2021-07-14 15:14:10'),(76,'default','added',710,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":37}}','2021-07-14 15:16:49','2021-07-14 15:16:49'),(77,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-14 17:41:53','2021-07-14 17:41:53'),(78,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-31 08:24:58','2021-07-31 08:24:58'),(79,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-31 08:27:29','2021-07-31 08:27:29'),(80,'default','added',712,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"due\",\"final_total\":20}}','2021-07-31 08:34:48','2021-07-31 08:34:48'),(81,'default','added',713,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"draft\",\"sub_status\":\"quotation\",\"final_total\":20}}','2021-07-31 08:35:33','2021-07-31 08:35:33'),(82,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-31 14:00:11','2021-07-31 14:00:11'),(83,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-07-31 14:26:58','2021-07-31 14:26:58'),(84,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-08-06 18:12:25','2021-08-06 18:12:25'),(85,'default','added',714,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":20}}','2021-08-06 18:13:06','2021-08-06 18:13:06'),(86,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-08-17 08:26:30','2021-08-17 08:26:30'),(87,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-08-31 11:52:28','2021-08-31 11:52:28'),(88,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-08-31 16:49:02','2021-08-31 16:49:02'),(89,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-08-31 16:55:41','2021-08-31 16:55:41'),(90,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-09-01 09:59:57','2021-09-01 09:59:57'),(91,'default','added',7,'App\\Contact',1,1,'App\\User','[]','2021-09-01 10:20:53','2021-09-01 10:20:54'),(92,'default','edited',7,'App\\Contact',1,1,'App\\User','[]','2021-09-01 10:22:33','2021-09-01 10:22:33'),(93,'default','added',8,'App\\Contact',1,1,'App\\User','[]','2021-09-01 10:24:43','2021-09-01 10:24:43'),(94,'default','added',715,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"purchase\",\"status\":\"ordered\",\"payment_status\":\"due\",\"final_total\":800}}','2021-09-01 10:30:06','2021-09-01 10:30:06'),(95,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-09-13 11:01:17','2021-09-13 11:01:17'),(96,'default','added',716,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":20}}','2021-09-13 11:07:38','2021-09-13 11:07:38'),(97,'default','added',2,'App\\User',1,1,'App\\User','{\"name\":\"Mr Suvamoy Sarkar\"}','2021-09-13 11:10:57','2021-09-13 11:10:57'),(98,'default','added',717,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":20}}','2021-09-13 11:12:00','2021-09-13 11:12:00'),(99,'default','added',718,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":20}}','2021-09-13 11:14:56','2021-09-13 11:14:56'),(100,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-09-13 11:21:20','2021-09-13 11:21:20'),(101,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-09-14 06:43:02','2021-09-14 06:43:02'),(102,'default','added',719,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":248}}','2021-09-14 06:45:57','2021-09-14 06:45:57'),(103,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-09-14 07:53:42','2021-09-14 07:53:42'),(104,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-09-14 08:18:18','2021-09-14 08:18:18'),(105,'default','added',3,'App\\User',1,1,'App\\User','{\"name\":\"Test Sourav Dutta\"}','2021-09-14 09:13:30','2021-09-14 09:13:30'),(106,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-09-14 09:14:10','2021-09-14 09:14:10'),(107,'default','login',3,'App\\User',1,3,'App\\User','[]','2021-09-14 09:14:29','2021-09-14 09:14:29'),(108,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-09-14 09:15:25','2021-09-14 09:15:25'),(109,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-09-25 13:07:48','2021-09-25 13:07:48'),(110,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-09-25 13:19:52','2021-09-25 13:19:52'),(111,'default','login',4,'App\\User',2,4,'App\\User','[]','2021-09-25 13:22:17','2021-09-25 13:22:17'),(112,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-09-25 13:25:23','2021-09-25 13:25:23'),(113,'default','login',4,'App\\User',2,4,'App\\User','[]','2021-09-25 13:25:36','2021-09-25 13:25:36'),(114,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-09-27 07:30:25','2021-09-27 07:30:25'),(115,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-09-27 07:32:17','2021-09-27 07:32:17'),(116,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-09-27 15:29:22','2021-09-27 15:29:22'),(117,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-09-27 15:33:41','2021-09-27 15:33:41'),(118,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-09-28 15:23:39','2021-09-28 15:23:39'),(119,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-10-17 12:18:55','2021-10-17 12:18:55'),(120,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-10-18 14:24:57','2021-10-18 14:24:57'),(121,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-10-19 15:56:27','2021-10-19 15:56:27'),(122,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-10-22 15:55:26','2021-10-22 15:55:26'),(123,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-10-25 16:37:44','2021-10-25 16:37:44'),(124,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-10-26 12:52:05','2021-10-26 12:52:05'),(125,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-10-26 12:54:30','2021-10-26 12:54:30'),(126,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-10-26 13:44:44','2021-10-26 13:44:44'),(127,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-10-26 14:10:55','2021-10-26 14:10:55'),(128,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-10-27 13:51:27','2021-10-27 13:51:27'),(129,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-10-27 15:15:52','2021-10-27 15:15:52'),(130,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-10-27 16:47:30','2021-10-27 16:47:30'),(131,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-10-27 16:48:03','2021-10-27 16:48:03'),(132,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-10-28 11:23:36','2021-10-28 11:23:36'),(133,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-11-02 09:34:24','2021-11-02 09:34:25'),(134,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-11-03 15:35:10','2021-11-03 15:35:10'),(135,'default','added',720,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":48}}','2021-11-03 15:42:13','2021-11-03 15:42:13'),(136,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-11-04 07:16:45','2021-11-04 07:16:45'),(137,'default','added',723,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"draft\",\"final_total\":20}}','2021-11-05 15:19:22','2021-11-05 15:19:22'),(138,'default','added',724,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"draft\",\"sub_status\":\"quotation\",\"final_total\":20}}','2021-11-05 15:19:28','2021-11-05 15:19:28'),(139,'default','added',725,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":20}}','2021-11-05 15:52:36','2021-11-05 15:52:36'),(140,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-11-08 15:37:44','2021-11-08 15:37:44'),(141,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-11-08 15:45:55','2021-11-08 15:45:55'),(142,'default','edited',1,'App\\User',1,1,'App\\User','{\"name\":\" Souvik Palit\"}','2021-11-08 15:48:24','2021-11-08 15:48:24'),(143,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-11-08 15:52:04','2021-11-08 15:52:04'),(144,'default','added',5,'App\\User',1,1,'App\\User','{\"name\":\" USCRIC POS Admin\"}','2021-11-08 15:55:47','2021-11-08 15:55:47'),(145,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-11-08 15:56:11','2021-11-08 15:56:11'),(146,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-08 15:56:25','2021-11-08 15:56:25'),(147,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-11-08 16:39:10','2021-11-08 16:39:10'),(148,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-11-08 16:41:09','2021-11-08 16:41:09'),(149,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-11-08 16:41:22','2021-11-08 16:41:22'),(150,'default','edited',5,'App\\User',1,1,'App\\User','{\"name\":\" USCRIC POS Admin\"}','2021-11-08 16:43:29','2021-11-08 16:43:29'),(151,'default','edited',5,'App\\User',1,1,'App\\User','{\"name\":\" USCRIC POS Admin\"}','2021-11-08 16:44:40','2021-11-08 16:44:40'),(152,'default','edited',5,'App\\User',1,5,'App\\User','{\"name\":\" USCRIC POS Admin\"}','2021-11-08 16:47:08','2021-11-08 16:47:08'),(153,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-11-08 16:47:47','2021-11-08 16:47:47'),(154,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-11-08 16:52:50','2021-11-08 16:52:50'),(155,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-08 16:53:30','2021-11-08 16:53:30'),(156,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-08 16:55:35','2021-11-08 16:55:35'),(157,'default','added',727,'App\\Transaction',1,5,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":12}}','2021-11-08 17:06:54','2021-11-08 17:06:54'),(158,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-08 17:31:24','2021-11-08 17:31:24'),(159,'default','added',728,'App\\Transaction',1,5,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":24}}','2021-11-09 12:23:34','2021-11-09 12:23:34'),(160,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-09 16:11:32','2021-11-09 16:11:32'),(161,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-09 16:14:16','2021-11-09 16:14:16'),(162,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-11-09 16:25:42','2021-11-09 16:25:42'),(163,'default','added',729,'App\\Transaction',1,5,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":24}}','2021-11-10 12:08:13','2021-11-10 12:08:13'),(164,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-11 14:56:40','2021-11-11 14:56:40'),(165,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-12 03:20:50','2021-11-12 03:20:50'),(166,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-13 10:44:43','2021-11-13 10:44:43'),(167,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-13 10:53:50','2021-11-13 10:53:50'),(168,'default','contact_deleted',5,'App\\Contact',1,5,'App\\User','[]','2021-11-13 13:56:26','2021-11-13 13:56:26'),(169,'default','contact_deleted',4,'App\\Contact',1,5,'App\\User','[]','2021-11-13 13:56:36','2021-11-13 13:56:36'),(170,'default','deleted',2,'App\\User',1,5,'App\\User','{\"name\":\"Mr Suvamoy Sarkar\",\"id\":2}','2021-11-13 13:57:13','2021-11-13 13:57:13'),(171,'default','contact_deleted',6,'App\\Contact',1,5,'App\\User','[]','2021-11-13 14:03:24','2021-11-13 14:03:24'),(172,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-14 02:32:06','2021-11-14 02:32:06'),(173,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-14 02:41:05','2021-11-14 02:41:05'),(174,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-14 07:05:25','2021-11-14 07:05:25'),(175,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-14 09:46:48','2021-11-14 09:46:48'),(176,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-15 05:23:08','2021-11-15 05:23:08'),(177,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-15 14:10:33','2021-11-15 14:10:33'),(178,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-15 16:11:36','2021-11-15 16:11:36'),(179,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-15 16:19:50','2021-11-15 16:19:50'),(180,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-15 17:50:11','2021-11-15 17:50:11'),(181,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-15 17:56:21','2021-11-15 17:56:21'),(182,'default','logout',1,'App\\User',1,1,'App\\User','[]','2021-11-16 04:00:01','2021-11-16 04:00:01'),(183,'default','login',5,'App\\User',1,5,'App\\User','[]','2021-11-16 04:00:13','2021-11-16 04:00:13'),(184,'default','edited',1,'App\\User',1,5,'App\\User','{\"name\":\" USCRIC POS ADMIN\"}','2021-11-16 04:01:58','2021-11-16 04:01:58'),(185,'default','logout',5,'App\\User',1,5,'App\\User','[]','2021-11-16 04:02:12','2021-11-16 04:02:12'),(186,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-11-16 04:02:23','2021-11-16 04:02:23'),(187,'default','login',1,'App\\User',1,1,'App\\User','[]','2021-11-16 05:11:37','2021-11-16 05:11:37'),(188,'default','added',10,'App\\Contact',1,1,'App\\User','[]','2021-11-16 08:18:04','2021-11-16 08:18:04'),(189,'default','added',54,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":28}}','2021-11-16 08:18:27','2021-11-16 08:18:27');
/*!40000 ALTER TABLE `activity_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barcodes`
--

DROP TABLE IF EXISTS `barcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barcodes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `width` double(22,4) DEFAULT NULL,
  `height` double(22,4) DEFAULT NULL,
  `paper_width` double(22,4) DEFAULT NULL,
  `paper_height` double(22,4) DEFAULT NULL,
  `top_margin` double(22,4) DEFAULT NULL,
  `left_margin` double(22,4) DEFAULT NULL,
  `row_distance` double(22,4) DEFAULT NULL,
  `col_distance` double(22,4) DEFAULT NULL,
  `stickers_in_one_row` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_continuous` tinyint(1) NOT NULL DEFAULT '0',
  `stickers_in_one_sheet` int(11) DEFAULT NULL,
  `business_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `barcodes_business_id_foreign` (`business_id`),
  CONSTRAINT `barcodes_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barcodes`
--

LOCK TABLES `barcodes` WRITE;
/*!40000 ALTER TABLE `barcodes` DISABLE KEYS */;
INSERT INTO `barcodes` (`id`, `name`, `description`, `width`, `height`, `paper_width`, `paper_height`, `top_margin`, `left_margin`, `row_distance`, `col_distance`, `stickers_in_one_row`, `is_default`, `is_continuous`, `stickers_in_one_sheet`, `business_id`, `created_at`, `updated_at`) VALUES (1,'20 Labels per Sheet','Sheet Size: 8.5\" x 11\", Label Size: 4\" x 1\", Labels per sheet: 20',4.0000,1.0000,8.5000,11.0000,0.5000,0.1250,0.0000,0.1875,2,0,0,20,NULL,'2017-12-18 00:43:44','2017-12-18 00:43:44'),(2,'30 Labels per sheet','Sheet Size: 8.5\" x 11\", Label Size: 2.625\" x 1\", Labels per sheet: 30',2.6250,1.0000,8.5000,11.0000,0.5000,0.1880,0.0000,0.1250,3,0,0,30,NULL,'2017-12-18 00:34:39','2017-12-18 00:40:40'),(3,'32 Labels per sheet','Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1.25\", Labels per sheet: 32',2.0000,1.2500,8.5000,11.0000,0.5000,0.2500,0.0000,0.0000,4,0,0,32,NULL,'2017-12-18 00:25:40','2017-12-18 00:25:40'),(4,'40 Labels per sheet','Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1\", Labels per sheet: 40',2.0000,1.0000,8.5000,11.0000,0.5000,0.2500,0.0000,0.0000,4,0,0,40,NULL,'2017-12-18 00:28:40','2017-12-18 00:28:40'),(5,'50 Labels per Sheet','Sheet Size: 8.5\" x 11\", Label Size: 1.5\" x 1\", Labels per sheet: 50',1.5000,1.0000,8.5000,11.0000,0.5000,0.5000,0.0000,0.0000,5,0,0,50,NULL,'2017-12-18 00:21:10','2017-12-18 00:21:10'),(6,'Continuous Rolls - 31.75mm x 25.4mm','Label Size: 31.75mm x 25.4mm, Gap: 3.18mm',1.2500,1.0000,1.2500,0.0000,0.1250,0.0000,0.1250,0.0000,1,0,1,NULL,NULL,'2017-12-18 00:21:10','2017-12-18 00:21:10');
/*!40000 ALTER TABLE `barcodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) unsigned NOT NULL,
  `waiter_id` int(10) unsigned DEFAULT NULL,
  `table_id` int(10) unsigned DEFAULT NULL,
  `correspondent_id` int(11) DEFAULT NULL,
  `business_id` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `booking_start` datetime NOT NULL,
  `booking_end` datetime NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `booking_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_contact_id_foreign` (`contact_id`),
  KEY `bookings_business_id_foreign` (`business_id`),
  KEY `bookings_created_by_foreign` (`created_by`),
  KEY `bookings_table_id_index` (`table_id`),
  KEY `bookings_waiter_id_index` (`waiter_id`),
  KEY `bookings_location_id_index` (`location_id`),
  KEY `bookings_booking_status_index` (`booking_status`),
  KEY `bookings_correspondent_id_index` (`correspondent_id`),
  CONSTRAINT `bookings_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bookings_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bookings_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` (`id`, `contact_id`, `waiter_id`, `table_id`, `correspondent_id`, `business_id`, `location_id`, `booking_start`, `booking_end`, `created_by`, `booking_status`, `booking_note`, `created_at`, `updated_at`) VALUES (1,1,NULL,NULL,2,1,1,'2021-11-16 21:08:00','2021-11-16 21:50:00',1,'booked',NULL,'2021-11-03 15:38:51','2021-11-03 15:38:51');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brands` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_by` int(10) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `brands_business_id_foreign` (`business_id`),
  KEY `brands_created_by_foreign` (`created_by`),
  CONSTRAINT `brands_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `brands_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` (`id`, `business_id`, `name`, `description`, `created_by`, `deleted_at`, `created_at`, `updated_at`) VALUES (1,1,'Brush teeth','Unique',1,'2021-11-13 13:59:49','2021-09-14 09:06:49','2021-11-13 13:59:49'),(2,1,'Abc','Biryanis',3,'2021-11-13 13:59:53','2021-09-14 09:15:38','2021-11-13 13:59:53'),(3,1,'GM',NULL,5,NULL,'2021-11-15 16:20:01','2021-11-15 16:23:15'),(4,1,'KOOKABURRA',NULL,5,NULL,'2021-11-15 16:20:13','2021-11-15 16:23:29'),(5,1,'SHREY',NULL,5,NULL,'2021-11-15 16:24:53','2021-11-15 16:24:53'),(6,1,'SG',NULL,5,NULL,'2021-11-15 16:25:03','2021-11-15 16:25:03'),(7,1,'NEWBERRY',NULL,5,NULL,'2021-11-15 16:26:37','2021-11-15 16:26:37'),(8,1,'Addidas',NULL,5,NULL,'2021-11-15 16:26:46','2021-11-15 16:26:46'),(9,1,'SS',NULL,5,NULL,'2021-11-15 16:27:00','2021-11-15 16:27:00'),(10,1,'Aero',NULL,5,NULL,'2021-11-15 16:29:35','2021-11-15 16:29:35'),(11,1,'Masuri',NULL,5,NULL,'2021-11-15 16:29:43','2021-11-15 16:29:43'),(12,1,'New Balance',NULL,5,NULL,'2021-11-15 16:29:58','2021-11-15 16:29:58'),(13,1,'DSC',NULL,5,NULL,'2021-11-15 16:30:18','2021-11-15 16:30:18');
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business`
--

DROP TABLE IF EXISTS `business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_id` int(10) unsigned NOT NULL,
  `start_date` date DEFAULT NULL,
  `tax_number_1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_label_1` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_number_2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_label_2` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code_label_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code_label_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_sales_tax` int(10) unsigned DEFAULT NULL,
  `default_profit_percent` double(5,2) NOT NULL DEFAULT '0.00',
  `owner_id` int(10) unsigned NOT NULL,
  `time_zone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Asia/Kolkata',
  `fy_start_month` tinyint(4) NOT NULL DEFAULT '1',
  `accounting_method` enum('fifo','lifo','avco') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fifo',
  `default_sales_discount` decimal(5,2) DEFAULT NULL,
  `sell_price_tax` enum('includes','excludes') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'includes',
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku_prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_product_expiry` tinyint(1) NOT NULL DEFAULT '0',
  `expiry_type` enum('add_expiry','add_manufacturing') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'add_expiry',
  `on_product_expiry` enum('keep_selling','stop_selling','auto_delete') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'keep_selling',
  `stop_selling_before` int(11) NOT NULL COMMENT 'Stop selling expied item n days before expiry',
  `enable_tooltip` tinyint(1) NOT NULL DEFAULT '1',
  `purchase_in_diff_currency` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Allow purchase to be in different currency then the business currency',
  `purchase_currency_id` int(10) unsigned DEFAULT NULL,
  `p_exchange_rate` decimal(20,3) NOT NULL DEFAULT '1.000',
  `transaction_edit_days` int(10) unsigned NOT NULL DEFAULT '30',
  `stock_expiry_alert_days` int(10) unsigned NOT NULL DEFAULT '30',
  `keyboard_shortcuts` text COLLATE utf8mb4_unicode_ci,
  `pos_settings` text COLLATE utf8mb4_unicode_ci,
  `essentials_settings` longtext COLLATE utf8mb4_unicode_ci,
  `woocommerce_api_settings` text COLLATE utf8mb4_unicode_ci,
  `woocommerce_skipped_orders` text COLLATE utf8mb4_unicode_ci,
  `woocommerce_wh_oc_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `woocommerce_wh_ou_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `woocommerce_wh_od_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `woocommerce_wh_or_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weighing_scale_setting` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'used to store the configuration of weighing scale',
  `enable_brand` tinyint(1) NOT NULL DEFAULT '1',
  `enable_category` tinyint(1) NOT NULL DEFAULT '1',
  `enable_sub_category` tinyint(1) NOT NULL DEFAULT '1',
  `enable_price_tax` tinyint(1) NOT NULL DEFAULT '1',
  `enable_purchase_status` tinyint(1) DEFAULT '1',
  `enable_lot_number` tinyint(1) NOT NULL DEFAULT '0',
  `default_unit` int(11) DEFAULT NULL,
  `enable_sub_units` tinyint(1) NOT NULL DEFAULT '0',
  `enable_racks` tinyint(1) NOT NULL DEFAULT '0',
  `enable_row` tinyint(1) NOT NULL DEFAULT '0',
  `enable_position` tinyint(1) NOT NULL DEFAULT '0',
  `enable_editing_product_from_purchase` tinyint(1) NOT NULL DEFAULT '1',
  `sales_cmsn_agnt` enum('logged_in_user','user','cmsn_agnt') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_addition_method` tinyint(1) NOT NULL DEFAULT '1',
  `enable_inline_tax` tinyint(1) NOT NULL DEFAULT '1',
  `currency_symbol_placement` enum('before','after') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'before',
  `enabled_modules` text COLLATE utf8mb4_unicode_ci,
  `date_format` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'm/d/Y',
  `time_format` enum('12','24') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '24',
  `ref_no_prefixes` text COLLATE utf8mb4_unicode_ci,
  `theme_color` char(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `enable_rp` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'rp is the short form of reward points',
  `rp_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `amount_for_unit_rp` decimal(22,4) NOT NULL DEFAULT '1.0000' COMMENT 'rp is the short form of reward points',
  `min_order_total_for_rp` decimal(22,4) NOT NULL DEFAULT '1.0000' COMMENT 'rp is the short form of reward points',
  `max_rp_per_order` int(11) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `redeem_amount_per_unit_rp` decimal(22,4) NOT NULL DEFAULT '1.0000' COMMENT 'rp is the short form of reward points',
  `min_order_total_for_redeem` decimal(22,4) NOT NULL DEFAULT '1.0000' COMMENT 'rp is the short form of reward points',
  `min_redeem_point` int(11) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `max_redeem_point` int(11) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `rp_expiry_period` int(11) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `rp_expiry_type` enum('month','year') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'year' COMMENT 'rp is the short form of reward points',
  `email_settings` text COLLATE utf8mb4_unicode_ci,
  `sms_settings` text COLLATE utf8mb4_unicode_ci,
  `custom_labels` text COLLATE utf8mb4_unicode_ci,
  `common_settings` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `business_owner_id_foreign` (`owner_id`),
  KEY `business_currency_id_foreign` (`currency_id`),
  KEY `business_default_sales_tax_foreign` (`default_sales_tax`),
  CONSTRAINT `business_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `business_default_sales_tax_foreign` FOREIGN KEY (`default_sales_tax`) REFERENCES `tax_rates` (`id`),
  CONSTRAINT `business_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business`
--

LOCK TABLES `business` WRITE;
/*!40000 ALTER TABLE `business` DISABLE KEYS */;
INSERT INTO `business` (`id`, `name`, `currency_id`, `start_date`, `tax_number_1`, `tax_label_1`, `tax_number_2`, `tax_label_2`, `code_label_1`, `code_1`, `code_label_2`, `code_2`, `default_sales_tax`, `default_profit_percent`, `owner_id`, `time_zone`, `fy_start_month`, `accounting_method`, `default_sales_discount`, `sell_price_tax`, `logo`, `sku_prefix`, `enable_product_expiry`, `expiry_type`, `on_product_expiry`, `stop_selling_before`, `enable_tooltip`, `purchase_in_diff_currency`, `purchase_currency_id`, `p_exchange_rate`, `transaction_edit_days`, `stock_expiry_alert_days`, `keyboard_shortcuts`, `pos_settings`, `essentials_settings`, `woocommerce_api_settings`, `woocommerce_skipped_orders`, `woocommerce_wh_oc_secret`, `woocommerce_wh_ou_secret`, `woocommerce_wh_od_secret`, `woocommerce_wh_or_secret`, `weighing_scale_setting`, `enable_brand`, `enable_category`, `enable_sub_category`, `enable_price_tax`, `enable_purchase_status`, `enable_lot_number`, `default_unit`, `enable_sub_units`, `enable_racks`, `enable_row`, `enable_position`, `enable_editing_product_from_purchase`, `sales_cmsn_agnt`, `item_addition_method`, `enable_inline_tax`, `currency_symbol_placement`, `enabled_modules`, `date_format`, `time_format`, `ref_no_prefixes`, `theme_color`, `created_by`, `enable_rp`, `rp_name`, `amount_for_unit_rp`, `min_order_total_for_rp`, `max_rp_per_order`, `redeem_amount_per_unit_rp`, `min_order_total_for_redeem`, `min_redeem_point`, `max_redeem_point`, `rp_expiry_period`, `rp_expiry_type`, `email_settings`, `sms_settings`, `custom_labels`, `common_settings`, `is_active`, `created_at`, `updated_at`) VALUES (1,'US Cric Store POS',2,'2021-06-12',NULL,'GST',NULL,NULL,NULL,NULL,NULL,NULL,NULL,25.00,1,'Asia/Kolkata',1,'fifo',0.00,'includes',NULL,NULL,0,'add_expiry','keep_selling',0,1,0,NULL,1.000,30,30,'{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"recent_product_quantity\":\"f2\",\"weighing_scale\":null,\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"add_new_product\":\"f4\"}}','{\"amount_rounding_method\":\"1\",\"enable_msp\":\"1\",\"disable_order_tax\":\"1\",\"is_pos_subtotal_editable\":\"1\",\"enable_weighing_scale\":\"1\",\"show_pricing_on_product_sugesstion\":\"1\",\"cash_denominations\":null,\"disable_pay_checkout\":0,\"disable_draft\":0,\"disable_express_checkout\":0,\"hide_product_suggestion\":0,\"hide_recent_trans\":0,\"disable_discount\":0}',NULL,'{\"woocommerce_app_url\":\"https:\\/\\/medigrowmart.com\",\"woocommerce_consumer_key\":\"ck_25709ab0dbbe629bae5f219cfcff519b5d02ee51\",\"woocommerce_consumer_secret\":\"cs_6e350bb1e487a8210faea3732bcdeafe923d146a\",\"location_id\":\"1\",\"enable_auto_sync\":\"1\",\"default_tax_class\":\"standard\",\"product_tax_type\":\"exc\",\"default_selling_price_group\":null,\"sync_description_as\":\"both\",\"product_fields_for_create\":[\"category\",\"quantity\",\"weight\",\"description\"],\"manage_stock_for_create\":\"none\",\"in_stock_for_create\":\"none\",\"product_fields_for_update\":[\"name\",\"price\",\"category\",\"quantity\",\"weight\",\"description\"],\"manage_stock_for_update\":\"none\",\"in_stock_for_update\":\"none\",\"order_statuses\":{\"pending\":\"draft\",\"processing\":\"final\",\"on-hold\":\"draft\",\"completed\":\"final\",\"cancelled\":\"draft\",\"refunded\":\"draft\",\"failed\":\"draft\",\"shipped\":\"quotation\"},\"woocommerce_wh_oc_secret\":\"cs_6e350bb1e487a8210faea3732bcdeafe923d146a\",\"woocommerce_wh_ou_secret\":\"cs_6e350bb1e487a8210faea3732bcdeafe923d146a\",\"woocommerce_wh_od_secret\":\"cs_6e350bb1e487a8210faea3732bcdeafe923d146a\",\"woocommerce_wh_or_secret\":\"cs_6e350bb1e487a8210faea3732bcdeafe923d146a\"}',NULL,'cs_6e350bb1e487a8210faea3732bcdeafe923d146a','cs_6e350bb1e487a8210faea3732bcdeafe923d146a','cs_6e350bb1e487a8210faea3732bcdeafe923d146a','cs_6e350bb1e487a8210faea3732bcdeafe923d146a','{\"label_prefix\":null,\"product_sku_length\":\"4\",\"qty_length\":\"3\",\"qty_length_decimal\":\"2\"}',1,1,1,1,1,1,1,1,0,0,0,1,NULL,0,0,'before','[\"purchases\",\"add_sale\",\"pos_sale\",\"stock_transfers\",\"stock_adjustment\",\"expenses\",\"account\",\"tables\",\"service_staff\",\"booking\"]','d/m/Y','12','{\"purchase\":\"PO\",\"purchase_return\":null,\"purchase_order\":null,\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"expense_payment\":null,\"business_location\":\"BL\",\"username\":null,\"subscription\":null,\"draft\":null,\"sales_order\":null}','black',NULL,0,'Reward card',1.0000,1.0000,50000000,1.0000,1.0000,1,1000000000,1,'year','{\"mail_driver\":\"smtp\",\"mail_host\":null,\"mail_port\":null,\"mail_username\":null,\"mail_password\":null,\"mail_encryption\":null,\"mail_from_address\":null,\"mail_from_name\":null}','{\"sms_service\":\"twilio\",\"nexmo_key\":null,\"nexmo_secret\":null,\"nexmo_from\":null,\"twilio_sid\":null,\"twilio_token\":null,\"twilio_from\":null,\"url\":null,\"send_to_param_name\":\"to\",\"msg_param_name\":\"text\",\"request_method\":\"post\",\"header_1\":null,\"header_val_1\":null,\"header_2\":null,\"header_val_2\":null,\"header_3\":null,\"header_val_3\":null,\"param_1\":null,\"param_val_1\":null,\"param_2\":null,\"param_val_2\":null,\"param_3\":null,\"param_val_3\":null,\"param_4\":null,\"param_val_4\":null,\"param_5\":null,\"param_val_5\":null,\"param_6\":null,\"param_val_6\":null,\"param_7\":null,\"param_val_7\":null,\"param_8\":null,\"param_val_8\":null,\"param_9\":null,\"param_val_9\":null,\"param_10\":null,\"param_val_10\":null}','{\"payments\":{\"custom_pay_1\":\"Paytm \\/ PhonePe\",\"custom_pay_2\":null,\"custom_pay_3\":null,\"custom_pay_4\":null,\"custom_pay_5\":null,\"custom_pay_6\":null,\"custom_pay_7\":null},\"contact\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null,\"custom_field_5\":null,\"custom_field_6\":null,\"custom_field_7\":null,\"custom_field_8\":null,\"custom_field_9\":null,\"custom_field_10\":null},\"product\":{\"custom_field_1\":\"Old\\/new Stock\",\"custom_field_2\":\"MRP\",\"custom_field_3\":null,\"custom_field_4\":null},\"location\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"user\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"purchase\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"sell\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"shipping\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null,\"custom_field_5\":null},\"types_of_service\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null,\"custom_field_5\":null,\"custom_field_6\":null}}','{\"enable_product_warranty\":\"1\",\"default_credit_limit\":null,\"default_datatable_page_entries\":\"25\"}',1,'2021-06-12 08:05:38','2021-11-15 16:42:25');
/*!40000 ALTER TABLE `business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_locations`
--

DROP TABLE IF EXISTS `business_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_locations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `location_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `landmark` text COLLATE utf8mb4_unicode_ci,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zip_code` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_scheme_id` int(10) unsigned NOT NULL,
  `invoice_layout_id` int(10) unsigned NOT NULL,
  `sale_invoice_layout_id` int(11) DEFAULT NULL,
  `selling_price_group_id` int(11) DEFAULT NULL,
  `print_receipt_on_invoice` tinyint(1) DEFAULT '1',
  `receipt_printer_type` enum('browser','printer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'browser',
  `printer_id` int(11) DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternate_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `featured_products` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `default_payment_accounts` text COLLATE utf8mb4_unicode_ci,
  `custom_field1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `business_locations_business_id_index` (`business_id`),
  KEY `business_locations_invoice_scheme_id_foreign` (`invoice_scheme_id`),
  KEY `business_locations_invoice_layout_id_foreign` (`invoice_layout_id`),
  KEY `business_locations_sale_invoice_layout_id_index` (`sale_invoice_layout_id`),
  KEY `business_locations_selling_price_group_id_index` (`selling_price_group_id`),
  KEY `business_locations_receipt_printer_type_index` (`receipt_printer_type`),
  KEY `business_locations_printer_id_index` (`printer_id`),
  CONSTRAINT `business_locations_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `business_locations_invoice_layout_id_foreign` FOREIGN KEY (`invoice_layout_id`) REFERENCES `invoice_layouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `business_locations_invoice_scheme_id_foreign` FOREIGN KEY (`invoice_scheme_id`) REFERENCES `invoice_schemes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_locations`
--

LOCK TABLES `business_locations` WRITE;
/*!40000 ALTER TABLE `business_locations` DISABLE KEYS */;
INSERT INTO `business_locations` (`id`, `business_id`, `location_id`, `name`, `landmark`, `country`, `state`, `city`, `zip_code`, `invoice_scheme_id`, `invoice_layout_id`, `sale_invoice_layout_id`, `selling_price_group_id`, `print_receipt_on_invoice`, `receipt_printer_type`, `printer_id`, `mobile`, `alternate_number`, `email`, `website`, `featured_products`, `is_active`, `default_payment_accounts`, `custom_field1`, `custom_field2`, `custom_field3`, `custom_field4`, `deleted_at`, `created_at`, `updated_at`) VALUES (1,1,'BL0001','US Cricket Store','ABC','ABC','ABC','ABC','100000',1,1,1,NULL,1,'browser',NULL,NULL,NULL,NULL,'',NULL,1,'{\"cash\":{\"is_enabled\":\"1\",\"account\":null},\"card\":{\"is_enabled\":\"1\",\"account\":null},\"cheque\":{\"is_enabled\":\"1\",\"account\":null},\"bank_transfer\":{\"is_enabled\":\"1\",\"account\":null},\"other\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_1\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_2\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_3\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_4\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_5\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_6\":{\"is_enabled\":\"1\",\"account\":null},\"custom_pay_7\":{\"is_enabled\":\"1\",\"account\":null}}',NULL,NULL,NULL,NULL,NULL,'2021-06-12 08:05:38','2021-11-15 17:55:22');
/*!40000 ALTER TABLE `business_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_register_transactions`
--

DROP TABLE IF EXISTS `cash_register_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cash_register_transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cash_register_id` int(10) unsigned NOT NULL,
  `amount` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `pay_method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('debit','credit') COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_type` enum('initial','sell','transfer','refund') COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cash_register_transactions_cash_register_id_foreign` (`cash_register_id`),
  KEY `cash_register_transactions_transaction_id_index` (`transaction_id`),
  KEY `cash_register_transactions_type_index` (`type`),
  KEY `cash_register_transactions_transaction_type_index` (`transaction_type`),
  CONSTRAINT `cash_register_transactions_cash_register_id_foreign` FOREIGN KEY (`cash_register_id`) REFERENCES `cash_registers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_register_transactions`
--

LOCK TABLES `cash_register_transactions` WRITE;
/*!40000 ALTER TABLE `cash_register_transactions` DISABLE KEYS */;
INSERT INTO `cash_register_transactions` (`id`, `cash_register_id`, `amount`, `pay_method`, `type`, `transaction_type`, `transaction_id`, `created_at`, `updated_at`) VALUES (1,3,28.0000,'cash','credit','sell',54,'2021-11-16 08:18:27','2021-11-16 08:18:27'),(2,3,0.0000,'cash','credit','sell',54,'2021-11-16 08:18:27','2021-11-16 08:18:27');
/*!40000 ALTER TABLE `cash_register_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_registers`
--

DROP TABLE IF EXISTS `cash_registers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cash_registers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `status` enum('close','open') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `closed_at` datetime DEFAULT NULL,
  `closing_amount` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `total_card_slips` int(11) NOT NULL DEFAULT '0',
  `total_cheques` int(11) NOT NULL DEFAULT '0',
  `denominations` text COLLATE utf8mb4_unicode_ci,
  `closing_note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cash_registers_business_id_foreign` (`business_id`),
  KEY `cash_registers_user_id_foreign` (`user_id`),
  KEY `cash_registers_location_id_index` (`location_id`),
  CONSTRAINT `cash_registers_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cash_registers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_registers`
--

LOCK TABLES `cash_registers` WRITE;
/*!40000 ALTER TABLE `cash_registers` DISABLE KEYS */;
INSERT INTO `cash_registers` (`id`, `business_id`, `location_id`, `user_id`, `status`, `closed_at`, `closing_amount`, `total_card_slips`, `total_cheques`, `denominations`, `closing_note`, `created_at`, `updated_at`) VALUES (1,1,1,1,'close','2021-07-01 08:20:53',1375.0000,0,0,NULL,NULL,'2021-06-12 13:52:00','2021-07-01 02:50:53'),(2,1,1,1,'close','2021-07-04 00:50:06',1680.8400,0,0,NULL,NULL,'2021-07-02 08:16:00','2021-07-03 19:20:06'),(3,1,1,1,'open',NULL,0.0000,0,0,NULL,NULL,'2021-07-03 19:20:00','2021-07-03 19:20:18'),(4,1,1,3,'open',NULL,0.0000,0,0,NULL,NULL,'2021-09-14 09:19:00','2021-09-14 09:19:25'),(6,1,5,5,'open',NULL,0.0000,0,0,NULL,NULL,'2021-11-08 16:43:00','2021-11-08 16:43:45');
/*!40000 ALTER TABLE `cash_registers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) unsigned NOT NULL,
  `short_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `woocommerce_cat_id` int(11) DEFAULT NULL,
  `category_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_business_id_foreign` (`business_id`),
  KEY `categories_created_by_foreign` (`created_by`),
  KEY `categories_parent_id_index` (`parent_id`),
  KEY `categories_woocommerce_cat_id_index` (`woocommerce_cat_id`),
  CONSTRAINT `categories_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `name`, `business_id`, `short_code`, `parent_id`, `created_by`, `woocommerce_cat_id`, `category_type`, `description`, `slug`, `deleted_at`, `created_at`, `updated_at`) VALUES (1,'BAT',1,NULL,0,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:15:10','2021-11-15 16:15:10'),(2,'BALLS',1,NULL,0,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:15:38','2021-11-15 16:15:38'),(3,'BAT EQUIP',1,NULL,0,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:16:09','2021-11-15 16:16:09'),(4,'SHOES',1,NULL,0,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:16:24','2021-11-15 16:16:24'),(5,'KEEPERS',1,NULL,0,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:16:42','2021-11-15 16:16:42'),(6,'BAGS',1,NULL,0,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:16:57','2021-11-15 16:16:57'),(7,'ACCESSORIES',1,NULL,0,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:17:31','2021-11-15 16:17:31'),(8,'CLOTHING',1,NULL,0,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:17:45','2021-11-15 16:17:45'),(9,'Hats and Caps',1,NULL,8,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:18:55','2021-11-15 16:18:55'),(10,'Whites',1,NULL,8,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:19:19','2021-11-15 16:19:19'),(11,'Bat Care',1,NULL,7,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:20:47','2021-11-15 16:20:47'),(12,'Grips',1,NULL,7,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:21:00','2021-11-15 16:21:00'),(13,'Scoreboard',1,NULL,7,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:21:14','2021-11-15 16:21:14'),(14,'Umpiring Tools',1,NULL,7,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:21:56','2021-11-15 16:21:56'),(15,'Robo Arm',1,NULL,7,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:22:25','2021-11-15 16:22:25'),(16,'Training',1,NULL,8,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:22:42','2021-11-15 16:22:42'),(17,'Socks',1,NULL,7,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:22:57','2021-11-15 16:22:57'),(18,'Duffle Bags',1,NULL,6,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:24:00','2021-11-15 16:24:00'),(19,'Wheel Bags',1,NULL,6,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:24:18','2021-11-15 16:24:18'),(20,'Backpacks',1,NULL,6,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:24:38','2021-11-15 16:24:38'),(21,'Keeping Inners',1,NULL,5,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:26:01','2021-11-15 16:26:01'),(22,'Keeping Pads',1,NULL,5,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:26:14','2021-11-15 16:26:14'),(23,'Gloves',1,NULL,3,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:27:41','2021-11-15 16:27:41'),(24,'Batting Pads',1,NULL,3,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:27:53','2021-11-15 16:27:53'),(25,'Helmets',1,NULL,3,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:28:05','2021-11-15 16:28:05'),(26,'Protection',1,NULL,3,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 16:29:19','2021-11-15 16:29:19'),(27,'Adult',1,NULL,2,5,NULL,'product','Balls',NULL,'2021-11-15 16:36:43','2021-11-15 16:32:00','2021-11-15 16:36:43'),(28,'Kids',1,NULL,2,5,NULL,'product','Balls',NULL,'2021-11-15 16:37:16','2021-11-15 16:32:19','2021-11-15 16:37:16'),(29,'Bats',1,NULL,0,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 17:10:21','2021-11-15 17:10:21'),(30,'English Willow',1,NULL,29,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 17:10:21','2021-11-15 17:10:21'),(31,'Training Balls',1,NULL,2,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 17:40:10','2021-11-15 17:40:10'),(32,'Leather Balls',1,NULL,2,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 17:40:10','2021-11-15 17:40:10'),(33,'Batting Inners',1,NULL,0,5,NULL,'product',NULL,NULL,NULL,'2021-11-15 17:40:10','2021-11-15 17:40:10');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorizables`
--

DROP TABLE IF EXISTS `categorizables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorizables` (
  `category_id` int(11) NOT NULL,
  `categorizable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categorizable_id` bigint(20) unsigned NOT NULL,
  KEY `categorizables_categorizable_type_categorizable_id_index` (`categorizable_type`,`categorizable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorizables`
--

LOCK TABLES `categorizables` WRITE;
/*!40000 ALTER TABLE `categorizables` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorizables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_business_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `tax_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_line_1` text COLLATE utf8mb4_unicode_ci,
  `address_line_2` text COLLATE utf8mb4_unicode_ci,
  `zip_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `landline` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternate_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pay_term_number` int(11) DEFAULT NULL,
  `pay_term_type` enum('days','months') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit_limit` decimal(22,4) DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `balance` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `total_rp` int(11) NOT NULL DEFAULT '0' COMMENT 'rp is the short form of reward points',
  `total_rp_used` int(11) NOT NULL DEFAULT '0' COMMENT 'rp is the short form of reward points',
  `total_rp_expired` int(11) NOT NULL DEFAULT '0' COMMENT 'rp is the short form of reward points',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `shipping_address` text COLLATE utf8mb4_unicode_ci,
  `shipping_custom_field_details` longtext COLLATE utf8mb4_unicode_ci,
  `is_export` tinyint(1) NOT NULL DEFAULT '0',
  `export_custom_field_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `export_custom_field_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `export_custom_field_3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `export_custom_field_4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `export_custom_field_5` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `export_custom_field_6` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_group_id` int(11) DEFAULT NULL,
  `custom_field1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field5` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field6` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field7` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field8` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field9` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field10` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contacts_business_id_foreign` (`business_id`),
  KEY `contacts_created_by_foreign` (`created_by`),
  KEY `contacts_type_index` (`type`),
  KEY `contacts_contact_status_index` (`contact_status`),
  CONSTRAINT `contacts_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contacts_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` (`id`, `business_id`, `type`, `supplier_business_name`, `name`, `prefix`, `first_name`, `middle_name`, `last_name`, `email`, `contact_id`, `contact_status`, `tax_number`, `city`, `state`, `country`, `address_line_1`, `address_line_2`, `zip_code`, `dob`, `mobile`, `landline`, `alternate_number`, `pay_term_number`, `pay_term_type`, `credit_limit`, `created_by`, `balance`, `total_rp`, `total_rp_used`, `total_rp_expired`, `is_default`, `shipping_address`, `shipping_custom_field_details`, `is_export`, `export_custom_field_1`, `export_custom_field_2`, `export_custom_field_3`, `export_custom_field_4`, `export_custom_field_5`, `export_custom_field_6`, `position`, `customer_group_id`, `custom_field1`, `custom_field2`, `custom_field3`, `custom_field4`, `custom_field5`, `custom_field6`, `custom_field7`, `custom_field8`, `custom_field9`, `custom_field10`, `deleted_at`, `created_at`, `updated_at`) VALUES (1,1,'customer',NULL,'Walk-In Customer',NULL,NULL,NULL,NULL,NULL,'CO0001','active',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,0.0000,1,0.0000,0,0,0,1,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-06-12 08:05:38','2021-06-12 08:05:38'),(4,1,'customer',NULL,' Tias  Bera',NULL,'Tias',NULL,'Bera','tiasbera@gmail.com','CO0002','active',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'8622024378',NULL,NULL,NULL,NULL,NULL,1,0.0000,125,0,0,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-13 13:56:36','2021-06-21 07:41:07','2021-11-13 13:56:36'),(5,1,'customer',NULL,' Tias  ',NULL,'Tias',NULL,NULL,NULL,'CO0003','active',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'8622024378',NULL,NULL,NULL,NULL,NULL,1,0.0000,0,0,0,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-13 13:56:26','2021-07-03 19:06:58','2021-11-13 13:56:26'),(6,1,'supplier',NULL,' abc  ',NULL,'abc',NULL,NULL,NULL,'CO0004','active',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2525252525',NULL,NULL,NULL,NULL,NULL,1,0.0000,0,0,0,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-13 14:03:24','2021-07-03 19:24:04','2021-11-13 14:03:24'),(7,1,'supplier','Test Business',' Dev  Datta',NULL,'Dev',NULL,'Datta','business@hungrytop.com','Test Dev Supplier','active',NULL,'Kolkata','West Bengal','India','Golf Green','Jadavpur','700095',NULL,'8918525196',NULL,NULL,NULL,'months',NULL,1,0.0000,0,0,0,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-01 10:20:53','2021-09-01 10:22:33'),(8,1,'customer','Test Business','   ',NULL,NULL,NULL,NULL,NULL,'Test Sourav Customer','active',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'8240716064',NULL,NULL,NULL,NULL,NULL,1,0.0000,0,0,0,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-09-01 10:24:43','2021-09-01 10:24:43'),(10,1,'customer',NULL,' Tias  ',NULL,'Tias',NULL,NULL,NULL,'CO0007','active',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'123456789',NULL,NULL,NULL,NULL,NULL,1,0.0000,0,0,0,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-16 08:18:04','2021-11-16 08:18:04');
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currencies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `thousand_separator` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `decimal_separator` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` (`id`, `country`, `currency`, `code`, `symbol`, `thousand_separator`, `decimal_separator`, `created_at`, `updated_at`) VALUES (1,'Albania','Leke','ALL','Lek',',','.',NULL,NULL),(2,'America','Dollars','USD','$',',','.',NULL,NULL),(3,'Afghanistan','Afghanis','AF','؋',',','.',NULL,NULL),(4,'Argentina','Pesos','ARS','$',',','.',NULL,NULL),(5,'Aruba','Guilders','AWG','ƒ',',','.',NULL,NULL),(6,'Australia','Dollars','AUD','$',',','.',NULL,NULL),(7,'Azerbaijan','New Manats','AZ','ман',',','.',NULL,NULL),(8,'Bahamas','Dollars','BSD','$',',','.',NULL,NULL),(9,'Barbados','Dollars','BBD','$',',','.',NULL,NULL),(10,'Belarus','Rubles','BYR','p.',',','.',NULL,NULL),(11,'Belgium','Euro','EUR','€',',','.',NULL,NULL),(12,'Beliz','Dollars','BZD','BZ$',',','.',NULL,NULL),(13,'Bermuda','Dollars','BMD','$',',','.',NULL,NULL),(14,'Bolivia','Bolivianos','BOB','$b',',','.',NULL,NULL),(15,'Bosnia and Herzegovina','Convertible Marka','BAM','KM',',','.',NULL,NULL),(16,'Botswana','Pula\'s','BWP','P',',','.',NULL,NULL),(17,'Bulgaria','Leva','BG','лв',',','.',NULL,NULL),(18,'Brazil','Reais','BRL','R$',',','.',NULL,NULL),(19,'Britain [United Kingdom]','Pounds','GBP','£',',','.',NULL,NULL),(20,'Brunei Darussalam','Dollars','BND','$',',','.',NULL,NULL),(21,'Cambodia','Riels','KHR','៛',',','.',NULL,NULL),(22,'Canada','Dollars','CAD','$',',','.',NULL,NULL),(23,'Cayman Islands','Dollars','KYD','$',',','.',NULL,NULL),(24,'Chile','Pesos','CLP','$',',','.',NULL,NULL),(25,'China','Yuan Renminbi','CNY','¥',',','.',NULL,NULL),(26,'Colombia','Pesos','COP','$',',','.',NULL,NULL),(27,'Costa Rica','Colón','CRC','₡',',','.',NULL,NULL),(28,'Croatia','Kuna','HRK','kn',',','.',NULL,NULL),(29,'Cuba','Pesos','CUP','₱',',','.',NULL,NULL),(30,'Cyprus','Euro','EUR','€','.',',',NULL,NULL),(31,'Czech Republic','Koruny','CZK','Kč',',','.',NULL,NULL),(32,'Denmark','Kroner','DKK','kr',',','.',NULL,NULL),(33,'Dominican Republic','Pesos','DOP ','RD$',',','.',NULL,NULL),(34,'East Caribbean','Dollars','XCD','$',',','.',NULL,NULL),(35,'Egypt','Pounds','EGP','£',',','.',NULL,NULL),(36,'El Salvador','Colones','SVC','$',',','.',NULL,NULL),(37,'England [United Kingdom]','Pounds','GBP','£',',','.',NULL,NULL),(38,'Euro','Euro','EUR','€','.',',',NULL,NULL),(39,'Falkland Islands','Pounds','FKP','£',',','.',NULL,NULL),(40,'Fiji','Dollars','FJD','$',',','.',NULL,NULL),(41,'France','Euro','EUR','€','.',',',NULL,NULL),(42,'Ghana','Cedis','GHS','¢',',','.',NULL,NULL),(43,'Gibraltar','Pounds','GIP','£',',','.',NULL,NULL),(44,'Greece','Euro','EUR','€','.',',',NULL,NULL),(45,'Guatemala','Quetzales','GTQ','Q',',','.',NULL,NULL),(46,'Guernsey','Pounds','GGP','£',',','.',NULL,NULL),(47,'Guyana','Dollars','GYD','$',',','.',NULL,NULL),(48,'Holland [Netherlands]','Euro','EUR','€','.',',',NULL,NULL),(49,'Honduras','Lempiras','HNL','L',',','.',NULL,NULL),(50,'Hong Kong','Dollars','HKD','$',',','.',NULL,NULL),(51,'Hungary','Forint','HUF','Ft',',','.',NULL,NULL),(52,'Iceland','Kronur','ISK','kr',',','.',NULL,NULL),(53,'India','Rupees','INR','₹',',','.',NULL,NULL),(54,'Indonesia','Rupiahs','IDR','Rp',',','.',NULL,NULL),(55,'Iran','Rials','IRR','﷼',',','.',NULL,NULL),(56,'Ireland','Euro','EUR','€','.',',',NULL,NULL),(57,'Isle of Man','Pounds','IMP','£',',','.',NULL,NULL),(58,'Israel','New Shekels','ILS','₪',',','.',NULL,NULL),(59,'Italy','Euro','EUR','€','.',',',NULL,NULL),(60,'Jamaica','Dollars','JMD','J$',',','.',NULL,NULL),(61,'Japan','Yen','JPY','¥',',','.',NULL,NULL),(62,'Jersey','Pounds','JEP','£',',','.',NULL,NULL),(63,'Kazakhstan','Tenge','KZT','лв',',','.',NULL,NULL),(64,'Korea [North]','Won','KPW','₩',',','.',NULL,NULL),(65,'Korea [South]','Won','KRW','₩',',','.',NULL,NULL),(66,'Kyrgyzstan','Soms','KGS','лв',',','.',NULL,NULL),(67,'Laos','Kips','LAK','₭',',','.',NULL,NULL),(68,'Latvia','Lati','LVL','Ls',',','.',NULL,NULL),(69,'Lebanon','Pounds','LBP','£',',','.',NULL,NULL),(70,'Liberia','Dollars','LRD','$',',','.',NULL,NULL),(71,'Liechtenstein','Switzerland Francs','CHF','CHF',',','.',NULL,NULL),(72,'Lithuania','Litai','LTL','Lt',',','.',NULL,NULL),(73,'Luxembourg','Euro','EUR','€','.',',',NULL,NULL),(74,'Macedonia','Denars','MKD','ден',',','.',NULL,NULL),(75,'Malaysia','Ringgits','MYR','RM',',','.',NULL,NULL),(76,'Malta','Euro','EUR','€','.',',',NULL,NULL),(77,'Mauritius','Rupees','MUR','₨',',','.',NULL,NULL),(78,'Mexico','Pesos','MXN','$',',','.',NULL,NULL),(79,'Mongolia','Tugriks','MNT','₮',',','.',NULL,NULL),(80,'Mozambique','Meticais','MZ','MT',',','.',NULL,NULL),(81,'Namibia','Dollars','NAD','$',',','.',NULL,NULL),(82,'Nepal','Rupees','NPR','₨',',','.',NULL,NULL),(83,'Netherlands Antilles','Guilders','ANG','ƒ',',','.',NULL,NULL),(84,'Netherlands','Euro','EUR','€','.',',',NULL,NULL),(85,'New Zealand','Dollars','NZD','$',',','.',NULL,NULL),(86,'Nicaragua','Cordobas','NIO','C$',',','.',NULL,NULL),(87,'Nigeria','Nairas','NGN','₦',',','.',NULL,NULL),(88,'North Korea','Won','KPW','₩',',','.',NULL,NULL),(89,'Norway','Krone','NOK','kr',',','.',NULL,NULL),(90,'Oman','Rials','OMR','﷼',',','.',NULL,NULL),(91,'Pakistan','Rupees','PKR','₨',',','.',NULL,NULL),(92,'Panama','Balboa','PAB','B/.',',','.',NULL,NULL),(93,'Paraguay','Guarani','PYG','Gs',',','.',NULL,NULL),(94,'Peru','Nuevos Soles','PE','S/.',',','.',NULL,NULL),(95,'Philippines','Pesos','PHP','Php',',','.',NULL,NULL),(96,'Poland','Zlotych','PL','zł',',','.',NULL,NULL),(97,'Qatar','Rials','QAR','﷼',',','.',NULL,NULL),(98,'Romania','New Lei','RO','lei',',','.',NULL,NULL),(99,'Russia','Rubles','RUB','руб',',','.',NULL,NULL),(100,'Saint Helena','Pounds','SHP','£',',','.',NULL,NULL),(101,'Saudi Arabia','Riyals','SAR','﷼',',','.',NULL,NULL),(102,'Serbia','Dinars','RSD','Дин.',',','.',NULL,NULL),(103,'Seychelles','Rupees','SCR','₨',',','.',NULL,NULL),(104,'Singapore','Dollars','SGD','$',',','.',NULL,NULL),(105,'Slovenia','Euro','EUR','€','.',',',NULL,NULL),(106,'Solomon Islands','Dollars','SBD','$',',','.',NULL,NULL),(107,'Somalia','Shillings','SOS','S',',','.',NULL,NULL),(108,'South Africa','Rand','ZAR','R',',','.',NULL,NULL),(109,'South Korea','Won','KRW','₩',',','.',NULL,NULL),(110,'Spain','Euro','EUR','€','.',',',NULL,NULL),(111,'Sri Lanka','Rupees','LKR','₨',',','.',NULL,NULL),(112,'Sweden','Kronor','SEK','kr',',','.',NULL,NULL),(113,'Switzerland','Francs','CHF','CHF',',','.',NULL,NULL),(114,'Suriname','Dollars','SRD','$',',','.',NULL,NULL),(115,'Syria','Pounds','SYP','£',',','.',NULL,NULL),(116,'Taiwan','New Dollars','TWD','NT$',',','.',NULL,NULL),(117,'Thailand','Baht','THB','฿',',','.',NULL,NULL),(118,'Trinidad and Tobago','Dollars','TTD','TT$',',','.',NULL,NULL),(119,'Turkey','Lira','TRY','TL',',','.',NULL,NULL),(120,'Turkey','Liras','TRL','£',',','.',NULL,NULL),(121,'Tuvalu','Dollars','TVD','$',',','.',NULL,NULL),(122,'Ukraine','Hryvnia','UAH','₴',',','.',NULL,NULL),(123,'United Kingdom','Pounds','GBP','£',',','.',NULL,NULL),(124,'United States of America','Dollars','USD','$',',','.',NULL,NULL),(125,'Uruguay','Pesos','UYU','$U',',','.',NULL,NULL),(126,'Uzbekistan','Sums','UZS','лв',',','.',NULL,NULL),(127,'Vatican City','Euro','EUR','€','.',',',NULL,NULL),(128,'Venezuela','Bolivares Fuertes','VEF','Bs',',','.',NULL,NULL),(129,'Vietnam','Dong','VND','₫',',','.',NULL,NULL),(130,'Yemen','Rials','YER','﷼',',','.',NULL,NULL),(131,'Zimbabwe','Zimbabwe Dollars','ZWD','Z$',',','.',NULL,NULL),(132,'Iraq','Iraqi dinar','IQD','د.ع',',','.',NULL,NULL),(133,'Kenya','Kenyan shilling','KES','KSh',',','.',NULL,NULL),(134,'Bangladesh','Taka','BDT','৳',',','.',NULL,NULL),(135,'Algerie','Algerian dinar','DZD','د.ج',' ','.',NULL,NULL),(136,'United Arab Emirates','United Arab Emirates dirham','AED','د.إ',',','.',NULL,NULL),(137,'Uganda','Uganda shillings','UGX','USh',',','.',NULL,NULL),(138,'Tanzania','Tanzanian shilling','TZS','TSh',',','.',NULL,NULL),(139,'Angola','Kwanza','AOA','Kz',',','.',NULL,NULL),(140,'Kuwait','Kuwaiti dinar','KWD','KD',',','.',NULL,NULL),(141,'Bahrain','Bahraini dinar','BHD','BD',',','.',NULL,NULL);
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_groups`
--

DROP TABLE IF EXISTS `customer_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double(5,2) NOT NULL,
  `price_calculation_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'percentage',
  `selling_price_group_id` int(11) DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_groups_business_id_foreign` (`business_id`),
  KEY `customer_groups_created_by_index` (`created_by`),
  KEY `customer_groups_price_calculation_type_index` (`price_calculation_type`),
  KEY `customer_groups_selling_price_group_id_index` (`selling_price_group_id`),
  CONSTRAINT `customer_groups_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_groups`
--

LOCK TABLES `customer_groups` WRITE;
/*!40000 ALTER TABLE `customer_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_configurations`
--

DROP TABLE IF EXISTS `dashboard_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_configurations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `created_by` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `configuration` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dashboard_configurations_business_id_foreign` (`business_id`),
  CONSTRAINT `dashboard_configurations_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_configurations`
--

LOCK TABLES `dashboard_configurations` WRITE;
/*!40000 ALTER TABLE `dashboard_configurations` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount_variations`
--

DROP TABLE IF EXISTS `discount_variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discount_variations` (
  `discount_id` int(11) NOT NULL,
  `variation_id` int(11) NOT NULL,
  KEY `discount_variations_discount_id_index` (`discount_id`),
  KEY `discount_variations_variation_id_index` (`variation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount_variations`
--

LOCK TABLES `discount_variations` WRITE;
/*!40000 ALTER TABLE `discount_variations` DISABLE KEYS */;
/*!40000 ALTER TABLE `discount_variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(11) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `discount_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_amount` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `applicable_in_spg` tinyint(1) DEFAULT '0',
  `applicable_in_cg` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discounts_business_id_index` (`business_id`),
  KEY `discounts_brand_id_index` (`brand_id`),
  KEY `discounts_category_id_index` (`category_id`),
  KEY `discounts_location_id_index` (`location_id`),
  KEY `discounts_priority_index` (`priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_and_notes`
--

DROP TABLE IF EXISTS `document_and_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_and_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL,
  `notable_id` int(11) NOT NULL,
  `notable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `heading` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `document_and_notes_business_id_index` (`business_id`),
  KEY `document_and_notes_notable_id_index` (`notable_id`),
  KEY `document_and_notes_created_by_index` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_and_notes`
--

LOCK TABLES `document_and_notes` WRITE;
/*!40000 ALTER TABLE `document_and_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_and_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_allowances_and_deductions`
--

DROP TABLE IF EXISTS `essentials_allowances_and_deductions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_allowances_and_deductions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('allowance','deduction') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(22,4) NOT NULL,
  `amount_type` enum('fixed','percent') COLLATE utf8mb4_unicode_ci NOT NULL,
  `applicable_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `essentials_allowances_and_deductions_business_id_index` (`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_allowances_and_deductions`
--

LOCK TABLES `essentials_allowances_and_deductions` WRITE;
/*!40000 ALTER TABLE `essentials_allowances_and_deductions` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_allowances_and_deductions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_attendances`
--

DROP TABLE IF EXISTS `essentials_attendances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_attendances` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `clock_in_time` datetime DEFAULT NULL,
  `clock_out_time` datetime DEFAULT NULL,
  `essentials_shift_id` int(11) DEFAULT NULL,
  `ip_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clock_in_note` text COLLATE utf8mb4_unicode_ci,
  `clock_out_note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `essentials_attendances_user_id_index` (`user_id`),
  KEY `essentials_attendances_business_id_index` (`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_attendances`
--

LOCK TABLES `essentials_attendances` WRITE;
/*!40000 ALTER TABLE `essentials_attendances` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_attendances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_document_shares`
--

DROP TABLE IF EXISTS `essentials_document_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_document_shares` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `document_id` int(11) NOT NULL,
  `value_type` enum('user','role') COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_document_shares`
--

LOCK TABLES `essentials_document_shares` WRITE;
/*!40000 ALTER TABLE `essentials_document_shares` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_document_shares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_documents`
--

DROP TABLE IF EXISTS `essentials_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_documents`
--

LOCK TABLES `essentials_documents` WRITE;
/*!40000 ALTER TABLE `essentials_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_holidays`
--

DROP TABLE IF EXISTS `essentials_holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_holidays` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `business_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `essentials_holidays_business_id_index` (`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_holidays`
--

LOCK TABLES `essentials_holidays` WRITE;
/*!40000 ALTER TABLE `essentials_holidays` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_holidays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_kb`
--

DROP TABLE IF EXISTS `essentials_kb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_kb` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` bigint(20) unsigned NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kb_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` bigint(20) unsigned DEFAULT NULL COMMENT 'id from essentials_kb table',
  `share_with` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'public, private, only_with',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `essentials_kb_parent_id_foreign` (`parent_id`),
  CONSTRAINT `essentials_kb_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `essentials_kb` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_kb`
--

LOCK TABLES `essentials_kb` WRITE;
/*!40000 ALTER TABLE `essentials_kb` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_kb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_kb_users`
--

DROP TABLE IF EXISTS `essentials_kb_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_kb_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `kb_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_kb_users`
--

LOCK TABLES `essentials_kb_users` WRITE;
/*!40000 ALTER TABLE `essentials_kb_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_kb_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_leave_types`
--

DROP TABLE IF EXISTS `essentials_leave_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_leave_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leave_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_leave_count` int(11) DEFAULT NULL,
  `leave_count_interval` enum('month','year') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `essentials_leave_types_business_id_index` (`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_leave_types`
--

LOCK TABLES `essentials_leave_types` WRITE;
/*!40000 ALTER TABLE `essentials_leave_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_leave_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_leaves`
--

DROP TABLE IF EXISTS `essentials_leaves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_leaves` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `essentials_leave_type_id` int(11) DEFAULT NULL,
  `business_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `ref_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','approved','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci,
  `status_note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `essentials_leaves_essentials_leave_type_id_index` (`essentials_leave_type_id`),
  KEY `essentials_leaves_business_id_index` (`business_id`),
  KEY `essentials_leaves_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_leaves`
--

LOCK TABLES `essentials_leaves` WRITE;
/*!40000 ALTER TABLE `essentials_leaves` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_leaves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_messages`
--

DROP TABLE IF EXISTS `essentials_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_messages`
--

LOCK TABLES `essentials_messages` WRITE;
/*!40000 ALTER TABLE `essentials_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_reminders`
--

DROP TABLE IF EXISTS `essentials_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_reminders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `end_time` time DEFAULT NULL,
  `repeat` enum('one_time','every_day','every_week','every_month') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_reminders`
--

LOCK TABLES `essentials_reminders` WRITE;
/*!40000 ALTER TABLE `essentials_reminders` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_reminders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_shifts`
--

DROP TABLE IF EXISTS `essentials_shifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_shifts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('fixed_shift','flexible_shift') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fixed_shift',
  `business_id` int(11) NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `holidays` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_shifts`
--

LOCK TABLES `essentials_shifts` WRITE;
/*!40000 ALTER TABLE `essentials_shifts` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_shifts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_to_dos`
--

DROP TABLE IF EXISTS `essentials_to_dos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_to_dos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL,
  `task` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `task_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estimated_hours` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `essentials_to_dos_status_index` (`status`),
  KEY `essentials_to_dos_priority_index` (`priority`),
  KEY `essentials_to_dos_created_by_index` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_to_dos`
--

LOCK TABLES `essentials_to_dos` WRITE;
/*!40000 ALTER TABLE `essentials_to_dos` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_to_dos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_todo_comments`
--

DROP TABLE IF EXISTS `essentials_todo_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_todo_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `task_id` int(11) NOT NULL,
  `comment_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `essentials_todo_comments_task_id_index` (`task_id`),
  KEY `essentials_todo_comments_comment_by_index` (`comment_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_todo_comments`
--

LOCK TABLES `essentials_todo_comments` WRITE;
/*!40000 ALTER TABLE `essentials_todo_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_todo_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_todos_users`
--

DROP TABLE IF EXISTS `essentials_todos_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_todos_users` (
  `todo_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_todos_users`
--

LOCK TABLES `essentials_todos_users` WRITE;
/*!40000 ALTER TABLE `essentials_todos_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_todos_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_user_allowance_and_deductions`
--

DROP TABLE IF EXISTS `essentials_user_allowance_and_deductions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_user_allowance_and_deductions` (
  `user_id` int(11) NOT NULL,
  `allowance_deduction_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_user_allowance_and_deductions`
--

LOCK TABLES `essentials_user_allowance_and_deductions` WRITE;
/*!40000 ALTER TABLE `essentials_user_allowance_and_deductions` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_user_allowance_and_deductions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essentials_user_shifts`
--

DROP TABLE IF EXISTS `essentials_user_shifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `essentials_user_shifts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `essentials_shift_id` int(11) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essentials_user_shifts`
--

LOCK TABLES `essentials_user_shifts` WRITE;
/*!40000 ALTER TABLE `essentials_user_shifts` DISABLE KEYS */;
/*!40000 ALTER TABLE `essentials_user_shifts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_categories`
--

DROP TABLE IF EXISTS `expense_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expense_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) unsigned NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expense_categories_business_id_foreign` (`business_id`),
  CONSTRAINT `expense_categories_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_categories`
--

LOCK TABLES `expense_categories` WRITE;
/*!40000 ALTER TABLE `expense_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `expense_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_sub_taxes`
--

DROP TABLE IF EXISTS `group_sub_taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_sub_taxes` (
  `group_tax_id` int(10) unsigned NOT NULL,
  `tax_id` int(10) unsigned NOT NULL,
  KEY `group_sub_taxes_group_tax_id_foreign` (`group_tax_id`),
  KEY `group_sub_taxes_tax_id_foreign` (`tax_id`),
  CONSTRAINT `group_sub_taxes_group_tax_id_foreign` FOREIGN KEY (`group_tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE,
  CONSTRAINT `group_sub_taxes_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_sub_taxes`
--

LOCK TABLES `group_sub_taxes` WRITE;
/*!40000 ALTER TABLE `group_sub_taxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_sub_taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_layouts`
--

DROP TABLE IF EXISTS `invoice_layouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_layouts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `header_text` text COLLATE utf8mb4_unicode_ci,
  `invoice_no_prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quotation_no_prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_heading` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_heading_line1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_heading_line2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_heading_line3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_heading_line4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_heading_line5` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_heading_not_paid` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_heading_paid` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quotation_heading` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_total_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `round_off_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_due_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_client_id` tinyint(1) NOT NULL DEFAULT '0',
  `client_id_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_tax_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_time_format` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_time` tinyint(1) NOT NULL DEFAULT '1',
  `show_brand` tinyint(1) NOT NULL DEFAULT '0',
  `show_sku` tinyint(1) NOT NULL DEFAULT '1',
  `show_cat_code` tinyint(1) NOT NULL DEFAULT '1',
  `show_expiry` tinyint(1) NOT NULL DEFAULT '0',
  `show_lot` tinyint(1) NOT NULL DEFAULT '0',
  `show_image` tinyint(1) NOT NULL DEFAULT '0',
  `show_sale_description` tinyint(1) NOT NULL DEFAULT '0',
  `sales_person_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_sales_person` tinyint(1) NOT NULL DEFAULT '0',
  `table_product_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `table_qty_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `table_unit_price_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `table_subtotal_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cat_code_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_logo` tinyint(1) NOT NULL DEFAULT '0',
  `show_business_name` tinyint(1) NOT NULL DEFAULT '0',
  `show_location_name` tinyint(1) NOT NULL DEFAULT '1',
  `show_landmark` tinyint(1) NOT NULL DEFAULT '1',
  `show_city` tinyint(1) NOT NULL DEFAULT '1',
  `show_state` tinyint(1) NOT NULL DEFAULT '1',
  `show_zip_code` tinyint(1) NOT NULL DEFAULT '1',
  `show_country` tinyint(1) NOT NULL DEFAULT '1',
  `show_mobile_number` tinyint(1) NOT NULL DEFAULT '1',
  `show_alternate_number` tinyint(1) NOT NULL DEFAULT '0',
  `show_email` tinyint(1) NOT NULL DEFAULT '0',
  `show_tax_1` tinyint(1) NOT NULL DEFAULT '1',
  `show_tax_2` tinyint(1) NOT NULL DEFAULT '0',
  `show_barcode` tinyint(1) NOT NULL DEFAULT '0',
  `show_payments` tinyint(1) NOT NULL DEFAULT '0',
  `show_customer` tinyint(1) NOT NULL DEFAULT '0',
  `customer_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_reward_point` tinyint(1) NOT NULL DEFAULT '0',
  `highlight_color` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `footer_text` text COLLATE utf8mb4_unicode_ci,
  `module_info` text COLLATE utf8mb4_unicode_ci,
  `common_settings` text COLLATE utf8mb4_unicode_ci,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `business_id` int(10) unsigned NOT NULL,
  `design` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT 'classic',
  `cn_heading` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'cn = credit note',
  `cn_no_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cn_amount_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `table_tax_headings` text COLLATE utf8mb4_unicode_ci,
  `show_previous_bal` tinyint(1) NOT NULL DEFAULT '0',
  `prev_bal_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `change_return_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_custom_fields` text COLLATE utf8mb4_unicode_ci,
  `contact_custom_fields` text COLLATE utf8mb4_unicode_ci,
  `location_custom_fields` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_layouts_business_id_foreign` (`business_id`),
  CONSTRAINT `invoice_layouts_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_layouts`
--

LOCK TABLES `invoice_layouts` WRITE;
/*!40000 ALTER TABLE `invoice_layouts` DISABLE KEYS */;
INSERT INTO `invoice_layouts` (`id`, `name`, `header_text`, `invoice_no_prefix`, `quotation_no_prefix`, `invoice_heading`, `sub_heading_line1`, `sub_heading_line2`, `sub_heading_line3`, `sub_heading_line4`, `sub_heading_line5`, `invoice_heading_not_paid`, `invoice_heading_paid`, `quotation_heading`, `sub_total_label`, `discount_label`, `tax_label`, `total_label`, `round_off_label`, `total_due_label`, `paid_label`, `show_client_id`, `client_id_label`, `client_tax_label`, `date_label`, `date_time_format`, `show_time`, `show_brand`, `show_sku`, `show_cat_code`, `show_expiry`, `show_lot`, `show_image`, `show_sale_description`, `sales_person_label`, `show_sales_person`, `table_product_label`, `table_qty_label`, `table_unit_price_label`, `table_subtotal_label`, `cat_code_label`, `logo`, `show_logo`, `show_business_name`, `show_location_name`, `show_landmark`, `show_city`, `show_state`, `show_zip_code`, `show_country`, `show_mobile_number`, `show_alternate_number`, `show_email`, `show_tax_1`, `show_tax_2`, `show_barcode`, `show_payments`, `show_customer`, `customer_label`, `show_reward_point`, `highlight_color`, `footer_text`, `module_info`, `common_settings`, `is_default`, `business_id`, `design`, `cn_heading`, `cn_no_label`, `cn_amount_label`, `table_tax_headings`, `show_previous_bal`, `prev_bal_label`, `change_return_label`, `product_custom_fields`, `contact_custom_fields`, `location_custom_fields`, `created_at`, `updated_at`) VALUES (1,'Default',NULL,'Invoice No.',NULL,'Invoice',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Subtotal','Discount','Tax','Total',NULL,'Total Due','Total Paid',0,NULL,NULL,'Date',NULL,1,0,0,1,0,0,0,0,NULL,0,'Product','Quantity','Unit Price','Subtotal',NULL,NULL,0,0,1,1,1,1,1,1,1,0,0,1,0,0,1,1,'Customer',0,'#000000',NULL,NULL,'{\"due_date_label\":null,\"total_quantity_label\":null,\"item_discount_label\":null,\"num_to_word_format\":\"international\"}',1,1,'classic',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'2021-06-12 08:05:38','2021-07-11 13:43:27');
/*!40000 ALTER TABLE `invoice_layouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_schemes`
--

DROP TABLE IF EXISTS `invoice_schemes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_schemes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scheme_type` enum('blank','year') COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_number` int(11) DEFAULT NULL,
  `invoice_count` int(11) NOT NULL DEFAULT '0',
  `total_digits` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_schemes_business_id_foreign` (`business_id`),
  KEY `invoice_schemes_scheme_type_index` (`scheme_type`),
  CONSTRAINT `invoice_schemes_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_schemes`
--

LOCK TABLES `invoice_schemes` WRITE;
/*!40000 ALTER TABLE `invoice_schemes` DISABLE KEYS */;
INSERT INTO `invoice_schemes` (`id`, `business_id`, `name`, `scheme_type`, `prefix`, `start_number`, `invoice_count`, `total_digits`, `is_default`, `created_at`, `updated_at`) VALUES (1,1,'Default','blank','',1,42,4,1,'2021-06-12 08:05:38','2021-11-16 08:18:27');
/*!40000 ALTER TABLE `invoice_schemes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL,
  `file_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `uploaded_by` int(11) DEFAULT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `woocommerce_media_id` int(11) DEFAULT NULL,
  `model_media_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  KEY `media_business_id_index` (`business_id`),
  KEY `media_uploaded_by_index` (`uploaded_by`),
  KEY `media_woocommerce_media_id_index` (`woocommerce_media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=321 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2016_06_01_000001_create_oauth_auth_codes_table',1),(4,'2016_06_01_000002_create_oauth_access_tokens_table',1),(5,'2016_06_01_000003_create_oauth_refresh_tokens_table',1),(6,'2016_06_01_000004_create_oauth_clients_table',1),(7,'2016_06_01_000005_create_oauth_personal_access_clients_table',1),(8,'2017_07_05_071953_create_currencies_table',1),(9,'2017_07_05_073658_create_business_table',1),(10,'2017_07_22_075923_add_business_id_users_table',1),(11,'2017_07_23_113209_create_brands_table',1),(12,'2017_07_26_083429_create_permission_tables',1),(13,'2017_07_26_110000_create_tax_rates_table',1),(14,'2017_07_26_122313_create_units_table',1),(15,'2017_07_27_075706_create_contacts_table',1),(16,'2017_08_04_071038_create_categories_table',1),(17,'2017_08_08_115903_create_products_table',1),(18,'2017_08_09_061616_create_variation_templates_table',1),(19,'2017_08_09_061638_create_variation_value_templates_table',1),(20,'2017_08_10_061146_create_product_variations_table',1),(21,'2017_08_10_061216_create_variations_table',1),(22,'2017_08_19_054827_create_transactions_table',1),(23,'2017_08_31_073533_create_purchase_lines_table',1),(24,'2017_10_15_064638_create_transaction_payments_table',1),(25,'2017_10_31_065621_add_default_sales_tax_to_business_table',1),(26,'2017_11_20_051930_create_table_group_sub_taxes',1),(27,'2017_11_20_063603_create_transaction_sell_lines',1),(28,'2017_11_21_064540_create_barcodes_table',1),(29,'2017_11_23_181237_create_invoice_schemes_table',1),(30,'2017_12_25_122822_create_business_locations_table',1),(31,'2017_12_25_160253_add_location_id_to_transactions_table',1),(32,'2017_12_25_163227_create_variation_location_details_table',1),(33,'2018_01_04_115627_create_sessions_table',1),(34,'2018_01_05_112817_create_invoice_layouts_table',1),(35,'2018_01_06_112303_add_invoice_scheme_id_and_invoice_layout_id_to_business_locations',1),(36,'2018_01_08_104124_create_expense_categories_table',1),(37,'2018_01_08_123327_modify_transactions_table_for_expenses',1),(38,'2018_01_09_111005_modify_payment_status_in_transactions_table',1),(39,'2018_01_09_111109_add_paid_on_column_to_transaction_payments_table',1),(40,'2018_01_25_172439_add_printer_related_fields_to_business_locations_table',1),(41,'2018_01_27_184322_create_printers_table',1),(42,'2018_01_30_181442_create_cash_registers_table',1),(43,'2018_01_31_125836_create_cash_register_transactions_table',1),(44,'2018_02_07_173326_modify_business_table',1),(45,'2018_02_08_105425_add_enable_product_expiry_column_to_business_table',1),(46,'2018_02_08_111027_add_expiry_period_and_expiry_period_type_columns_to_products_table',1),(47,'2018_02_08_131118_add_mfg_date_and_exp_date_purchase_lines_table',1),(48,'2018_02_08_155348_add_exchange_rate_to_transactions_table',1),(49,'2018_02_09_124945_modify_transaction_payments_table_for_contact_payments',1),(50,'2018_02_12_113640_create_transaction_sell_lines_purchase_lines_table',1),(51,'2018_02_12_114605_add_quantity_sold_in_purchase_lines_table',1),(52,'2018_02_13_183323_alter_decimal_fields_size',1),(53,'2018_02_14_161928_add_transaction_edit_days_to_business_table',1),(54,'2018_02_15_161032_add_document_column_to_transactions_table',1),(55,'2018_02_17_124709_add_more_options_to_invoice_layouts',1),(56,'2018_02_19_111517_add_keyboard_shortcut_column_to_business_table',1),(57,'2018_02_19_121537_stock_adjustment_move_to_transaction_table',1),(58,'2018_02_20_165505_add_is_direct_sale_column_to_transactions_table',1),(59,'2018_02_21_105329_create_system_table',1),(60,'2018_02_23_100549_version_1_2',1),(61,'2018_02_23_125648_add_enable_editing_sp_from_purchase_column_to_business_table',1),(62,'2018_02_26_103612_add_sales_commission_agent_column_to_business_table',1),(63,'2018_02_26_130519_modify_users_table_for_sales_cmmsn_agnt',1),(64,'2018_02_26_134500_add_commission_agent_to_transactions_table',1),(65,'2018_02_27_121422_add_item_addition_method_to_business_table',1),(66,'2018_02_27_170232_modify_transactions_table_for_stock_transfer',1),(67,'2018_03_05_153510_add_enable_inline_tax_column_to_business_table',1),(68,'2018_03_06_210206_modify_product_barcode_types',1),(69,'2018_03_13_181541_add_expiry_type_to_business_table',1),(70,'2018_03_16_113446_product_expiry_setting_for_business',1),(71,'2018_03_19_113601_add_business_settings_options',1),(72,'2018_03_26_125334_add_pos_settings_to_business_table',1),(73,'2018_03_26_165350_create_customer_groups_table',1),(74,'2018_03_27_122720_customer_group_related_changes_in_tables',1),(75,'2018_03_29_110138_change_tax_field_to_nullable_in_business_table',1),(76,'2018_03_29_115502_add_changes_for_sr_number_in_products_and_sale_lines_table',1),(77,'2018_03_29_134340_add_inline_discount_fields_in_purchase_lines',1),(78,'2018_03_31_140921_update_transactions_table_exchange_rate',1),(79,'2018_04_03_103037_add_contact_id_to_contacts_table',1),(80,'2018_04_03_122709_add_changes_to_invoice_layouts_table',1),(81,'2018_04_09_135320_change_exchage_rate_size_in_business_table',1),(82,'2018_04_17_123122_add_lot_number_to_business',1),(83,'2018_04_17_160845_add_product_racks_table',1),(84,'2018_04_20_182015_create_res_tables_table',1),(85,'2018_04_24_105246_restaurant_fields_in_transaction_table',1),(86,'2018_04_24_114149_add_enabled_modules_business_table',1),(87,'2018_04_24_133704_add_modules_fields_in_invoice_layout_table',1),(88,'2018_04_27_132653_quotation_related_change',1),(89,'2018_05_02_104439_add_date_format_and_time_format_to_business',1),(90,'2018_05_02_111939_add_sell_return_to_transaction_payments',1),(91,'2018_05_14_114027_add_rows_positions_for_products',1),(92,'2018_05_14_125223_add_weight_to_products_table',1),(93,'2018_05_14_164754_add_opening_stock_permission',1),(94,'2018_05_15_134729_add_design_to_invoice_layouts',1),(95,'2018_05_16_183307_add_tax_fields_invoice_layout',1),(96,'2018_05_18_191956_add_sell_return_to_transaction_table',1),(97,'2018_05_21_131349_add_custom_fileds_to_contacts_table',1),(98,'2018_05_21_131607_invoice_layout_fields_for_sell_return',1),(99,'2018_05_21_131949_add_custom_fileds_and_website_to_business_locations_table',1),(100,'2018_05_22_123527_create_reference_counts_table',1),(101,'2018_05_22_154540_add_ref_no_prefixes_column_to_business_table',1),(102,'2018_05_24_132620_add_ref_no_column_to_transaction_payments_table',1),(103,'2018_05_24_161026_add_location_id_column_to_business_location_table',1),(104,'2018_05_25_180603_create_modifiers_related_table',1),(105,'2018_05_29_121714_add_purchase_line_id_to_stock_adjustment_line_table',1),(106,'2018_05_31_114645_add_res_order_status_column_to_transactions_table',1),(107,'2018_06_05_103530_rename_purchase_line_id_in_stock_adjustment_lines_table',1),(108,'2018_06_05_111905_modify_products_table_for_modifiers',1),(109,'2018_06_06_110524_add_parent_sell_line_id_column_to_transaction_sell_lines_table',1),(110,'2018_06_07_152443_add_is_service_staff_to_roles_table',1),(111,'2018_06_07_182258_add_image_field_to_products_table',1),(112,'2018_06_13_133705_create_bookings_table',1),(113,'2018_06_15_173636_add_email_column_to_contacts_table',1),(114,'2018_06_27_182835_add_superadmin_related_fields_business',1),(115,'2018_07_10_101913_add_custom_fields_to_products_table',1),(116,'2018_07_17_103434_add_sales_person_name_label_to_invoice_layouts_table',1),(117,'2018_07_17_163920_add_theme_skin_color_column_to_business_table',1),(118,'2018_07_24_160319_add_lot_no_line_id_to_transaction_sell_lines_table',1),(119,'2018_07_25_110004_add_show_expiry_and_show_lot_colums_to_invoice_layouts_table',1),(120,'2018_07_25_172004_add_discount_columns_to_transaction_sell_lines_table',1),(121,'2018_07_26_124720_change_design_column_type_in_invoice_layouts_table',1),(122,'2018_07_26_170424_add_unit_price_before_discount_column_to_transaction_sell_line_table',1),(123,'2018_07_28_103614_add_credit_limit_column_to_contacts_table',1),(124,'2018_08_08_110755_add_new_payment_methods_to_transaction_payments_table',1),(125,'2018_08_08_122225_modify_cash_register_transactions_table_for_new_payment_methods',1),(126,'2018_08_14_104036_add_opening_balance_type_to_transactions_table',1),(127,'2018_09_04_155900_create_accounts_table',1),(128,'2018_09_06_114438_create_selling_price_groups_table',1),(129,'2018_09_06_154057_create_variation_group_prices_table',1),(130,'2018_09_07_102413_add_permission_to_access_default_selling_price',1),(131,'2018_09_07_134858_add_selling_price_group_id_to_transactions_table',1),(132,'2018_09_10_112448_update_product_type_to_single_if_null_in_products_table',1),(133,'2018_09_10_152703_create_account_transactions_table',1),(134,'2018_09_10_173656_add_account_id_column_to_transaction_payments_table',1),(135,'2018_09_19_123914_create_notification_templates_table',1),(136,'2018_09_22_110504_add_sms_and_email_settings_columns_to_business_table',1),(137,'2018_09_24_134942_add_lot_no_line_id_to_stock_adjustment_lines_table',1),(138,'2018_09_26_105557_add_transaction_payments_for_existing_expenses',1),(139,'2018_09_27_111609_modify_transactions_table_for_purchase_return',1),(140,'2018_09_27_131154_add_quantity_returned_column_to_purchase_lines_table',1),(141,'2018_10_02_131401_add_return_quantity_column_to_transaction_sell_lines_table',1),(142,'2018_10_03_104918_add_qty_returned_column_to_transaction_sell_lines_purchase_lines_table',1),(143,'2018_10_03_185947_add_default_notification_templates_to_database',1),(144,'2018_10_09_153105_add_business_id_to_transaction_payments_table',1),(145,'2018_10_16_135229_create_permission_for_sells_and_purchase',1),(146,'2018_10_22_114441_add_columns_for_variable_product_modifications',1),(147,'2018_10_22_134428_modify_variable_product_data',1),(148,'2018_10_30_181558_add_table_tax_headings_to_invoice_layout',1),(149,'2018_10_31_122619_add_pay_terms_field_transactions_table',1),(150,'2018_10_31_161328_add_new_permissions_for_pos_screen',1),(151,'2018_10_31_174752_add_access_selected_contacts_only_to_users_table',1),(152,'2018_10_31_175627_add_user_contact_access',1),(153,'2018_10_31_180559_add_auto_send_sms_column_to_notification_templates_table',1),(154,'2018_11_02_171949_change_card_type_column_to_varchar_in_transaction_payments_table',1),(155,'2018_11_08_105621_add_role_permissions',1),(156,'2018_11_26_114135_add_is_suspend_column_to_transactions_table',1),(157,'2018_11_28_104410_modify_units_table_for_multi_unit',1),(158,'2018_11_28_170952_add_sub_unit_id_to_purchase_lines_and_sell_lines',1),(159,'2018_11_29_115918_add_primary_key_in_system_table',1),(160,'2018_12_03_185546_add_product_description_column_to_products_table',1),(161,'2018_12_06_114937_modify_system_table_and_users_table',1),(162,'2018_12_13_160007_add_custom_fields_display_options_to_invoice_layouts_table',1),(163,'2018_12_14_103307_modify_system_table',1),(164,'2018_12_18_133837_add_prev_balance_due_columns_to_invoice_layouts_table',1),(165,'2018_12_18_170656_add_invoice_token_column_to_transaction_table',1),(166,'2018_12_20_133639_add_date_time_format_column_to_invoice_layouts_table',1),(167,'2018_12_21_120659_add_recurring_invoice_fields_to_transactions_table',1),(168,'2018_12_24_154933_create_notifications_table',1),(169,'2019_01_08_112015_add_document_column_to_transaction_payments_table',1),(170,'2019_01_10_124645_add_account_permission',1),(171,'2019_01_16_125825_add_subscription_no_column_to_transactions_table',1),(172,'2019_01_28_111647_add_order_addresses_column_to_transactions_table',1),(173,'2019_02_13_173821_add_is_inactive_column_to_products_table',1),(174,'2019_02_19_103118_create_discounts_table',1),(175,'2019_02_21_120324_add_discount_id_column_to_transaction_sell_lines_table',1),(176,'2019_02_21_134324_add_permission_for_discount',1),(177,'2019_03_04_170832_add_service_staff_columns_to_transaction_sell_lines_table',1),(178,'2019_03_09_102425_add_sub_type_column_to_transactions_table',1),(179,'2019_03_09_124457_add_indexing_transaction_sell_lines_purchase_lines_table',1),(180,'2019_03_12_120336_create_activity_log_table',1),(181,'2019_03_15_132925_create_media_table',1),(182,'2019_05_08_130339_add_indexing_to_parent_id_in_transaction_payments_table',1),(183,'2019_05_10_132311_add_missing_column_indexing',1),(184,'2019_05_14_091812_add_show_image_column_to_invoice_layouts_table',1),(185,'2019_05_25_104922_add_view_purchase_price_permission',1),(186,'2019_06_17_103515_add_profile_informations_columns_to_users_table',1),(187,'2019_06_18_135524_add_permission_to_view_own_sales_only',1),(188,'2019_06_19_112058_add_database_changes_for_reward_points',1),(189,'2019_06_28_133732_change_type_column_to_string_in_transactions_table',1),(190,'2019_07_13_111420_add_is_created_from_api_column_to_transactions_table',1),(191,'2019_07_15_165136_add_fields_for_combo_product',1),(192,'2019_07_19_103446_add_mfg_quantity_used_column_to_purchase_lines_table',1),(193,'2019_07_22_152649_add_not_for_selling_in_product_table',1),(194,'2019_07_29_185351_add_show_reward_point_column_to_invoice_layouts_table',1),(195,'2019_08_08_162302_add_sub_units_related_fields',1),(196,'2019_08_26_133419_update_price_fields_decimal_point',1),(197,'2019_09_02_160054_remove_location_permissions_from_roles',1),(198,'2019_09_03_185259_add_permission_for_pos_screen',1),(199,'2019_09_04_163141_add_location_id_to_cash_registers_table',1),(200,'2019_09_04_184008_create_types_of_services_table',1),(201,'2019_09_06_131445_add_types_of_service_fields_to_transactions_table',1),(202,'2019_09_09_134810_add_default_selling_price_group_id_column_to_business_locations_table',1),(203,'2019_09_12_105616_create_product_locations_table',1),(204,'2019_09_17_122522_add_custom_labels_column_to_business_table',1),(205,'2019_09_18_164319_add_shipping_fields_to_transactions_table',1),(206,'2019_09_19_170927_close_all_active_registers',1),(207,'2019_09_23_161906_add_media_description_cloumn_to_media_table',1),(208,'2019_10_18_155633_create_account_types_table',1),(209,'2019_10_22_163335_add_common_settings_column_to_business_table',1),(210,'2019_10_29_132521_add_update_purchase_status_permission',1),(211,'2019_11_09_110522_add_indexing_to_lot_number',1),(212,'2019_11_19_170824_add_is_active_column_to_business_locations_table',1),(213,'2019_11_21_162913_change_quantity_field_types_to_decimal',1),(214,'2019_11_25_160340_modify_categories_table_for_polymerphic_relationship',1),(215,'2019_12_02_105025_create_warranties_table',1),(216,'2019_12_03_180342_add_common_settings_field_to_invoice_layouts_table',1),(217,'2019_12_05_183955_add_more_fields_to_users_table',1),(218,'2019_12_06_174904_add_change_return_label_column_to_invoice_layouts_table',1),(219,'2019_12_11_121307_add_draft_and_quotation_list_permissions',1),(220,'2019_12_12_180126_copy_expense_total_to_total_before_tax',1),(221,'2019_12_19_181412_make_alert_quantity_field_nullable_on_products_table',1),(222,'2019_12_25_173413_create_dashboard_configurations_table',1),(223,'2020_01_08_133506_create_document_and_notes_table',1),(224,'2020_01_09_113252_add_cc_bcc_column_to_notification_templates_table',1),(225,'2020_01_16_174818_add_round_off_amount_field_to_transactions_table',1),(226,'2020_01_28_162345_add_weighing_scale_settings_in_business_settings_table',1),(227,'2020_02_18_172447_add_import_fields_to_transactions_table',1),(228,'2020_03_13_135844_add_is_active_column_to_selling_price_groups_table',1),(229,'2020_03_16_115449_add_contact_status_field_to_contacts_table',1),(230,'2020_03_26_124736_add_allow_login_column_in_users_table',1),(231,'2020_04_13_154150_add_feature_products_column_to_business_loactions',1),(232,'2020_04_15_151802_add_user_type_to_users_table',1),(233,'2020_04_22_153905_add_subscription_repeat_on_column_to_transactions_table',1),(234,'2020_04_28_111436_add_shipping_address_to_contacts_table',1),(235,'2020_06_01_094654_add_max_sale_discount_column_to_users_table',1),(236,'2020_06_12_162245_modify_contacts_table',1),(237,'2020_06_22_103104_change_recur_interval_default_to_one',1),(238,'2020_07_09_174621_add_balance_field_to_contacts_table',1),(239,'2020_07_23_104933_change_status_column_to_varchar_in_transaction_table',1),(240,'2020_09_07_171059_change_completed_stock_transfer_status_to_final',1),(241,'2020_09_21_123224_modify_booking_status_column_in_bookings_table',1),(242,'2020_09_22_121639_create_discount_variations_table',1),(243,'2020_10_05_121550_modify_business_location_table_for_invoice_layout',1),(244,'2020_10_16_175726_set_status_as_received_for_opening_stock',1),(245,'2020_10_23_170823_add_for_group_tax_column_to_tax_rates_table',1),(246,'2020_11_04_130940_add_more_custom_fields_to_contacts_table',1),(247,'2020_11_10_152841_add_cash_register_permissions',1),(248,'2020_11_17_164041_modify_type_column_to_varchar_in_contacts_table',1),(249,'2020_12_18_181447_add_shipping_custom_fields_to_transactions_table',1),(250,'2020_12_22_164303_add_sub_status_column_to_transactions_table',1),(251,'2020_12_24_153050_add_custom_fields_to_transactions_table',1),(252,'2020_12_28_105403_add_whatsapp_text_column_to_notification_templates_table',1),(253,'2020_12_29_165925_add_model_document_type_to_media_table',1),(254,'2021_02_08_175632_add_contact_number_fields_to_users_table',1),(255,'2021_02_11_172217_add_indexing_for_multiple_columns',1),(256,'2021_02_23_122043_add_more_columns_to_customer_groups_table',1),(257,'2021_02_24_175551_add_print_invoice_permission_to_all_roles',1),(258,'2021_03_03_162021_add_purchase_order_columns_to_purchase_lines_and_transactions_table',1),(259,'2021_03_11_120229_add_sales_order_columns',1),(260,'2021_03_16_120705_add_business_id_to_activity_log_table',1),(261,'2021_03_16_153427_add_code_columns_to_business_table',1),(262,'2021_03_18_173308_add_account_details_column_to_accounts_table',1),(263,'2021_03_18_183119_add_prefer_payment_account_columns_to_transactions_table',1),(264,'2021_03_22_120810_add_more_types_of_service_custom_fields',1),(265,'2021_03_24_183132_add_shipping_export_custom_field_details_to_contacts_table',1),(266,'2021_03_25_170715_add_export_custom_fields_info_to_transactions_table',1),(267,'2021_04_15_063449_add_denominations_column_to_cash_registers_table',1),(268,'2018_10_10_110400_add_module_version_to_system_table',2),(269,'2018_10_10_122845_add_woocommerce_api_settings_to_business_table',2),(270,'2018_10_10_162041_add_woocommerce_category_id_to_categories_table',2),(271,'2018_10_11_173839_create_woocommerce_sync_logs_table',2),(272,'2018_10_16_123522_add_woocommerce_tax_rate_id_column_to_tax_rates_table',2),(273,'2018_10_23_111555_add_woocommerce_attr_id_column_to_variation_templates_table',2),(274,'2018_12_03_163945_add_woocommerce_permissions',2),(275,'2019_02_18_154414_change_woocommerce_sync_logs_table',2),(276,'2019_04_19_174129_add_disable_woocommerce_sync_column_to_products_table',2),(277,'2019_06_08_132440_add_woocommerce_wh_oc_secret_column_to_business_table',2),(278,'2019_10_01_171828_add_woocommerce_media_id_columns',2),(279,'2020_09_07_124952_add_woocommerce_skipped_orders_fields_to_business_table',3),(280,'2021_02_16_190608_add_woocommerce_module_indexing',4),(281,'2018_10_01_151252_create_documents_table',5),(282,'2018_10_02_151803_create_document_shares_table',5),(283,'2018_10_09_134558_create_reminders_table',5),(284,'2018_11_16_170756_create_to_dos_table',5),(285,'2019_02_22_120329_essentials_messages',5),(286,'2019_02_22_161513_add_message_permissions',5),(287,'2019_03_29_164339_add_essentials_version_to_system_table',5),(288,'2019_05_17_153306_create_essentials_leave_types_table',5),(289,'2019_05_17_175921_create_essentials_leaves_table',5),(290,'2019_05_21_154517_add_essentials_settings_columns_to_business_table',5),(291,'2019_05_21_181653_create_table_essentials_attendance',5),(292,'2019_05_30_110049_create_essentials_payrolls_table',5),(293,'2019_06_04_105723_create_essentials_holidays_table',5),(294,'2019_06_28_134217_add_payroll_columns_to_transactions_table',5),(295,'2019_08_26_103520_add_approve_leave_permission',5),(296,'2019_08_27_103724_create_essentials_allowance_and_deduction_table',5),(297,'2019_08_27_105236_create_essentials_user_allowances_and_deductions',5),(298,'2019_09_20_115906_add_more_columns_to_essentials_to_dos_table',5),(299,'2019_09_23_120439_create_essentials_todo_comments_table',5),(300,'2019_12_05_170724_add_hrm_columns_to_users_table',5),(301,'2019_12_09_105809_add_allowance_and_deductions_permission',5),(302,'2020_03_28_152838_create_essentials_shift_table',5),(303,'2020_03_30_162029_create_user_shifts_table',5),(304,'2020_03_31_134558_add_shift_id_to_attendance_table',5),(305,'2020_11_05_105157_modify_todos_date_column_type',5),(306,'2020_11_11_174852_add_end_time_column_to_essentials_reminders_table',5),(307,'2020_11_26_170527_create_essentials_kb_table',5),(308,'2020_11_30_112615_create_essentials_kb_users_table',5),(309,'2018_06_27_185405_create_packages_table',6),(310,'2018_06_28_182803_create_subscriptions_table',6),(311,'2018_07_17_182021_add_rows_to_system_table',6),(312,'2018_07_19_131721_add_options_to_packages_table',6),(313,'2018_08_17_155534_add_min_termination_alert_days',6),(314,'2018_08_28_105945_add_business_based_username_settings_to_system_table',6),(315,'2018_08_30_105906_add_superadmin_communicator_logs_table',6),(316,'2018_11_02_130636_add_custom_permissions_to_packages_table',6),(317,'2018_11_05_161848_add_more_fields_to_packages_table',6),(318,'2018_12_10_124621_modify_system_table_values_null_default',6),(319,'2019_05_10_135434_add_missing_database_column_indexes',6),(320,'2019_08_16_115300_create_superadmin_frontend_pages_table',6);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_type_model_id_index` (`model_type`,`model_id`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
INSERT INTO `model_has_permissions` (`permission_id`, `model_type`, `model_id`) VALUES (80,'App\\User',1),(80,'App\\User',2),(80,'App\\User',3),(82,'App\\User',5),(94,'App\\User',5),(97,'App\\User',5);
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_roles` (
  `role_id` int(10) unsigned NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_type_model_id_index` (`model_type`,`model_id`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES (1,'App\\User',1),(3,'App\\User',2),(1,'App\\User',3),(1,'App\\User',5);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_templates`
--

DROP TABLE IF EXISTS `notification_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL,
  `template_for` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_body` text COLLATE utf8mb4_unicode_ci,
  `sms_body` text COLLATE utf8mb4_unicode_ci,
  `whatsapp_text` text COLLATE utf8mb4_unicode_ci,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cc` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bcc` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auto_send` tinyint(1) NOT NULL DEFAULT '0',
  `auto_send_sms` tinyint(1) NOT NULL DEFAULT '0',
  `auto_send_wa_notif` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_templates`
--

LOCK TABLES `notification_templates` WRITE;
/*!40000 ALTER TABLE `notification_templates` DISABLE KEYS */;
INSERT INTO `notification_templates` (`id`, `business_id`, `template_for`, `email_body`, `sms_body`, `whatsapp_text`, `subject`, `cc`, `bcc`, `auto_send`, `auto_send_sms`, `auto_send_wa_notif`, `created_at`, `updated_at`) VALUES (1,1,'new_sale','<p>Dear {contact_name},</p>\n\n                    <p>Your invoice number is {invoice_number}<br />\n                    Total amount: {total_amount}<br />\n                    Paid amount: {received_amount}</p>\n\n                    <p>Thank you for shopping with us.</p>\n\n                    <p>{business_logo}</p>\n\n                    <p>&nbsp;</p>','Dear {contact_name}, Thank you for shopping with us. {business_name}',NULL,'Thank you from {business_name}',NULL,NULL,0,0,0,'2021-06-12 08:05:38','2021-06-12 08:05:38'),(2,1,'payment_received','<p>Dear {contact_name},</p>\n\n                <p>We have received a payment of {received_amount}</p>\n\n                <p>{business_logo}</p>','Dear {contact_name}, We have received a payment of {received_amount}. {business_name}',NULL,'Payment Received, from {business_name}',NULL,NULL,0,0,0,'2021-06-12 08:05:38','2021-06-12 08:05:38'),(3,1,'payment_reminder','<p>Dear {contact_name},</p>\n\n                    <p>This is to remind you that you have pending payment of {due_amount}. Kindly pay it as soon as possible.</p>\n\n                    <p>{business_logo}</p>','Dear {contact_name}, You have pending payment of {due_amount}. Kindly pay it as soon as possible. {business_name}',NULL,'Payment Reminder, from {business_name}',NULL,NULL,0,0,0,'2021-06-12 08:05:38','2021-06-12 08:05:38'),(4,1,'new_booking','<p>Dear {contact_name},</p>\n\n                    <p>Your booking is confirmed</p>\n\n                    <p>Date: {start_time} to {end_time}</p>\n\n                    <p>Table: {table}</p>\n\n                    <p>Location: {location}</p>\n\n                    <p>{business_logo}</p>','Dear {contact_name}, Your booking is confirmed. Date: {start_time} to {end_time}, Table: {table}, Location: {location}',NULL,'Booking Confirmed - {business_name}',NULL,NULL,0,0,0,'2021-06-12 08:05:38','2021-06-12 08:05:38'),(5,1,'new_order','<p>Dear {contact_name},</p>\n\n                    <p>We have a new order with reference number {order_ref_number}. Kindly process the products as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>','Dear {contact_name}, We have a new order with reference number {order_ref_number}. Kindly process the products as soon as possible. {business_name}',NULL,'New Order, from {business_name}',NULL,NULL,0,0,0,'2021-06-12 08:05:38','2021-06-12 08:05:38'),(6,1,'payment_paid','<p>Dear {contact_name},</p>\n\n                    <p>We have paid amount {paid_amount} again invoice number {order_ref_number}.<br />\n                    Kindly note it down.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>','We have paid amount {paid_amount} again invoice number {order_ref_number}.\n                    Kindly note it down. {business_name}',NULL,'Payment Paid, from {business_name}',NULL,NULL,0,0,0,'2021-06-12 08:05:38','2021-06-12 08:05:38'),(7,1,'items_received','<p>Dear {contact_name},</p>\n\n                    <p>We have received all items from invoice reference number {order_ref_number}. Thank you for processing it.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>','We have received all items from invoice reference number {order_ref_number}. Thank you for processing it. {business_name}',NULL,'Items received, from {business_name}',NULL,NULL,0,0,0,'2021-06-12 08:05:38','2021-06-12 08:05:38'),(8,1,'items_pending','<p>Dear {contact_name},<br />\n                    This is to remind you that we have not yet received some items from invoice reference number {order_ref_number}. Please process it as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>','This is to remind you that we have not yet received some items from invoice reference number {order_ref_number} . Please process it as soon as possible.{business_name}',NULL,'Items Pending, from {business_name}',NULL,NULL,0,0,0,'2021-06-12 08:05:38','2021-06-12 08:05:38'),(9,1,'new_quotation','<p>Dear {contact_name},</p>\n\n                    <p>Your quotation number is {invoice_number}<br />\n                    Total amount: {total_amount}</p>\n\n                    <p>Thank you for shopping with us.</p>\n\n                    <p>{business_logo}</p>\n\n                    <p>&nbsp;</p>','Dear {contact_name}, Thank you for shopping with us. {business_name}',NULL,'Thank you from {business_name}',NULL,NULL,0,0,0,'2021-06-12 08:05:38','2021-06-12 08:05:38'),(10,2,'new_sale','<p>Dear {contact_name},</p>\n\n                    <p>Your invoice number is {invoice_number}<br />\n                    Total amount: {total_amount}<br />\n                    Paid amount: {received_amount}</p>\n\n                    <p>Thank you for shopping with us.</p>\n\n                    <p>{business_logo}</p>\n\n                    <p>&nbsp;</p>','Dear {contact_name}, Thank you for shopping with us. {business_name}',NULL,'Thank you from {business_name}',NULL,NULL,0,0,0,'2021-09-25 13:21:19','2021-09-25 13:21:19'),(11,2,'payment_received','<p>Dear {contact_name},</p>\n\n                <p>We have received a payment of {received_amount}</p>\n\n                <p>{business_logo}</p>','Dear {contact_name}, We have received a payment of {received_amount}. {business_name}',NULL,'Payment Received, from {business_name}',NULL,NULL,0,0,0,'2021-09-25 13:21:19','2021-09-25 13:21:19'),(12,2,'payment_reminder','<p>Dear {contact_name},</p>\n\n                    <p>This is to remind you that you have pending payment of {due_amount}. Kindly pay it as soon as possible.</p>\n\n                    <p>{business_logo}</p>','Dear {contact_name}, You have pending payment of {due_amount}. Kindly pay it as soon as possible. {business_name}',NULL,'Payment Reminder, from {business_name}',NULL,NULL,0,0,0,'2021-09-25 13:21:19','2021-09-25 13:21:19'),(13,2,'new_booking','<p>Dear {contact_name},</p>\n\n                    <p>Your booking is confirmed</p>\n\n                    <p>Date: {start_time} to {end_time}</p>\n\n                    <p>Table: {table}</p>\n\n                    <p>Location: {location}</p>\n\n                    <p>{business_logo}</p>','Dear {contact_name}, Your booking is confirmed. Date: {start_time} to {end_time}, Table: {table}, Location: {location}',NULL,'Booking Confirmed - {business_name}',NULL,NULL,0,0,0,'2021-09-25 13:21:19','2021-09-25 13:21:19'),(14,2,'new_order','<p>Dear {contact_name},</p>\n\n                    <p>We have a new order with reference number {order_ref_number}. Kindly process the products as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>','Dear {contact_name}, We have a new order with reference number {order_ref_number}. Kindly process the products as soon as possible. {business_name}',NULL,'New Order, from {business_name}',NULL,NULL,0,0,0,'2021-09-25 13:21:19','2021-09-25 13:21:19'),(15,2,'payment_paid','<p>Dear {contact_name},</p>\n\n                    <p>We have paid amount {paid_amount} again invoice number {order_ref_number}.<br />\n                    Kindly note it down.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>','We have paid amount {paid_amount} again invoice number {order_ref_number}.\n                    Kindly note it down. {business_name}',NULL,'Payment Paid, from {business_name}',NULL,NULL,0,0,0,'2021-09-25 13:21:19','2021-09-25 13:21:19'),(16,2,'items_received','<p>Dear {contact_name},</p>\n\n                    <p>We have received all items from invoice reference number {order_ref_number}. Thank you for processing it.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>','We have received all items from invoice reference number {order_ref_number}. Thank you for processing it. {business_name}',NULL,'Items received, from {business_name}',NULL,NULL,0,0,0,'2021-09-25 13:21:19','2021-09-25 13:21:19'),(17,2,'items_pending','<p>Dear {contact_name},<br />\n                    This is to remind you that we have not yet received some items from invoice reference number {order_ref_number}. Please process it as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>','This is to remind you that we have not yet received some items from invoice reference number {order_ref_number} . Please process it as soon as possible.{business_name}',NULL,'Items Pending, from {business_name}',NULL,NULL,0,0,0,'2021-09-25 13:21:19','2021-09-25 13:21:19'),(18,2,'new_quotation','<p>Dear {contact_name},</p>\n\n                    <p>Your quotation number is {invoice_number}<br />\n                    Total amount: {total_amount}</p>\n\n                    <p>Thank you for shopping with us.</p>\n\n                    <p>{business_logo}</p>\n\n                    <p>&nbsp;</p>','Dear {contact_name}, Thank you for shopping with us. {business_name}',NULL,'Thank you from {business_name}',NULL,NULL,0,0,0,'2021-09-25 13:21:19','2021-09-25 13:21:19');
/*!40000 ALTER TABLE `notification_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_tokens`
--

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_auth_codes`
--

LOCK TABLES `oauth_auth_codes` WRITE;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_clients`
--

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_personal_access_clients`
--

LOCK TABLES `oauth_personal_access_clients` WRITE;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_tokens`
--

LOCK TABLES `oauth_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packages`
--

DROP TABLE IF EXISTS `packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `location_count` int(11) NOT NULL COMMENT 'No. of Business Locations, 0 = infinite option.',
  `user_count` int(11) NOT NULL,
  `product_count` int(11) NOT NULL,
  `bookings` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Enable/Disable bookings',
  `kitchen` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Enable/Disable kitchen',
  `order_screen` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Enable/Disable order_screen',
  `tables` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Enable/Disable tables',
  `invoice_count` int(11) NOT NULL,
  `interval` enum('days','months','years') COLLATE utf8mb4_unicode_ci NOT NULL,
  `interval_count` int(11) NOT NULL,
  `trial_days` int(11) NOT NULL,
  `price` decimal(22,4) NOT NULL,
  `custom_permissions` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int(11) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `is_one_time` tinyint(1) NOT NULL DEFAULT '0',
  `enable_custom_link` tinyint(1) NOT NULL DEFAULT '0',
  `custom_link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_link_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packages`
--

LOCK TABLES `packages` WRITE;
/*!40000 ALTER TABLE `packages` DISABLE KEYS */;
INSERT INTO `packages` (`id`, `name`, `description`, `location_count`, `user_count`, `product_count`, `bookings`, `kitchen`, `order_screen`, `tables`, `invoice_count`, `interval`, `interval_count`, `trial_days`, `price`, `custom_permissions`, `created_by`, `sort_order`, `is_active`, `is_private`, `is_one_time`, `enable_custom_link`, `custom_link`, `custom_link_text`, `deleted_at`, `created_at`, `updated_at`) VALUES (1,'Pack 1','0',0,0,0,0,0,0,0,0,'years',365,0,0.0000,'{\"essentials_module\":\"1\",\"woocommerce_module\":\"1\"}',1,1,1,0,1,0,'','',NULL,'2021-09-25 13:14:40','2021-09-25 13:14:40');
/*!40000 ALTER TABLE `packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES (1,'profit_loss_report.view','web','2021-06-12 08:02:48',NULL),(2,'direct_sell.access','web','2021-06-12 08:02:48',NULL),(3,'product.opening_stock','web','2021-06-12 08:02:48','2021-06-12 08:02:48'),(4,'crud_all_bookings','web','2021-06-12 08:02:48','2021-06-12 08:02:48'),(5,'crud_own_bookings','web','2021-06-12 08:02:48','2021-06-12 08:02:48'),(6,'access_default_selling_price','web','2021-06-12 08:02:48','2021-06-12 08:02:48'),(7,'purchase.payments','web','2021-06-12 08:02:48','2021-06-12 08:02:48'),(8,'sell.payments','web','2021-06-12 08:02:48','2021-06-12 08:02:48'),(9,'edit_product_price_from_sale_screen','web','2021-06-12 08:02:48','2021-06-12 08:02:48'),(10,'edit_product_discount_from_sale_screen','web','2021-06-12 08:02:48','2021-06-12 08:02:48'),(11,'roles.view','web','2021-06-12 08:02:48','2021-06-12 08:02:48'),(12,'roles.create','web','2021-06-12 08:02:48','2021-06-12 08:02:48'),(13,'roles.update','web','2021-06-12 08:02:48','2021-06-12 08:02:48'),(14,'roles.delete','web','2021-06-12 08:02:48','2021-06-12 08:02:48'),(15,'account.access','web','2021-06-12 08:02:48','2021-06-12 08:02:48'),(16,'discount.access','web','2021-06-12 08:02:48','2021-06-12 08:02:48'),(17,'view_purchase_price','web','2021-06-12 08:02:49','2021-06-12 08:02:49'),(18,'view_own_sell_only','web','2021-06-12 08:02:49','2021-06-12 08:02:49'),(19,'edit_product_discount_from_pos_screen','web','2021-06-12 08:02:49','2021-06-12 08:02:49'),(20,'edit_product_price_from_pos_screen','web','2021-06-12 08:02:49','2021-06-12 08:02:49'),(21,'access_shipping','web','2021-06-12 08:02:49','2021-06-12 08:02:49'),(22,'purchase.update_status','web','2021-06-12 08:02:49','2021-06-12 08:02:49'),(23,'list_drafts','web','2021-06-12 08:02:49','2021-06-12 08:02:49'),(24,'list_quotations','web','2021-06-12 08:02:49','2021-06-12 08:02:49'),(25,'view_cash_register','web','2021-06-12 08:02:49','2021-06-12 08:02:49'),(26,'close_cash_register','web','2021-06-12 08:02:49','2021-06-12 08:02:49'),(27,'print_invoice','web','2021-06-12 08:02:49','2021-06-12 08:02:49'),(28,'user.view','web','2021-06-12 08:02:49',NULL),(29,'user.create','web','2021-06-12 08:02:49',NULL),(30,'user.update','web','2021-06-12 08:02:49',NULL),(31,'user.delete','web','2021-06-12 08:02:49',NULL),(32,'supplier.view','web','2021-06-12 08:02:49',NULL),(33,'supplier.create','web','2021-06-12 08:02:49',NULL),(34,'supplier.update','web','2021-06-12 08:02:49',NULL),(35,'supplier.delete','web','2021-06-12 08:02:49',NULL),(36,'customer.view','web','2021-06-12 08:02:49',NULL),(37,'customer.create','web','2021-06-12 08:02:49',NULL),(38,'customer.update','web','2021-06-12 08:02:49',NULL),(39,'customer.delete','web','2021-06-12 08:02:49',NULL),(40,'product.view','web','2021-06-12 08:02:49',NULL),(41,'product.create','web','2021-06-12 08:02:49',NULL),(42,'product.update','web','2021-06-12 08:02:49',NULL),(43,'product.delete','web','2021-06-12 08:02:49',NULL),(44,'purchase.view','web','2021-06-12 08:02:49',NULL),(45,'purchase.create','web','2021-06-12 08:02:49',NULL),(46,'purchase.update','web','2021-06-12 08:02:49',NULL),(47,'purchase.delete','web','2021-06-12 08:02:49',NULL),(48,'sell.view','web','2021-06-12 08:02:49',NULL),(49,'sell.create','web','2021-06-12 08:02:49',NULL),(50,'sell.update','web','2021-06-12 08:02:49',NULL),(51,'sell.delete','web','2021-06-12 08:02:49',NULL),(52,'purchase_n_sell_report.view','web','2021-06-12 08:02:49',NULL),(53,'contacts_report.view','web','2021-06-12 08:02:49',NULL),(54,'stock_report.view','web','2021-06-12 08:02:49',NULL),(55,'tax_report.view','web','2021-06-12 08:02:49',NULL),(56,'trending_product_report.view','web','2021-06-12 08:02:49',NULL),(57,'register_report.view','web','2021-06-12 08:02:49',NULL),(58,'sales_representative.view','web','2021-06-12 08:02:49',NULL),(59,'expense_report.view','web','2021-06-12 08:02:49',NULL),(60,'business_settings.access','web','2021-06-12 08:02:49',NULL),(61,'barcode_settings.access','web','2021-06-12 08:02:49',NULL),(62,'invoice_settings.access','web','2021-06-12 08:02:49',NULL),(63,'brand.view','web','2021-06-12 08:02:49',NULL),(64,'brand.create','web','2021-06-12 08:02:49',NULL),(65,'brand.update','web','2021-06-12 08:02:49',NULL),(66,'brand.delete','web','2021-06-12 08:02:49',NULL),(67,'tax_rate.view','web','2021-06-12 08:02:49',NULL),(68,'tax_rate.create','web','2021-06-12 08:02:49',NULL),(69,'tax_rate.update','web','2021-06-12 08:02:49',NULL),(70,'tax_rate.delete','web','2021-06-12 08:02:49',NULL),(71,'unit.view','web','2021-06-12 08:02:49',NULL),(72,'unit.create','web','2021-06-12 08:02:49',NULL),(73,'unit.update','web','2021-06-12 08:02:49',NULL),(74,'unit.delete','web','2021-06-12 08:02:49',NULL),(75,'category.view','web','2021-06-12 08:02:49',NULL),(76,'category.create','web','2021-06-12 08:02:49',NULL),(77,'category.update','web','2021-06-12 08:02:49',NULL),(78,'category.delete','web','2021-06-12 08:02:49',NULL),(79,'expense.access','web','2021-06-12 08:02:49',NULL),(80,'access_all_locations','web','2021-06-12 08:02:49',NULL),(81,'dashboard.data','web','2021-06-12 08:02:49',NULL),(82,'location.1','web','2021-06-12 08:05:38','2021-06-12 08:05:38'),(83,'woocommerce.syc_categories','web','2021-06-12 08:18:25','2021-06-12 08:18:25'),(84,'woocommerce.sync_products','web','2021-06-12 08:18:25','2021-06-12 08:18:25'),(85,'woocommerce.sync_orders','web','2021-06-12 08:18:25','2021-06-12 08:18:25'),(86,'woocommerce.map_tax_rates','web','2021-06-12 08:18:25','2021-06-12 08:18:25'),(87,'woocommerce.access_woocommerce_api_settings','web','2021-06-12 08:18:25','2021-06-12 08:18:25'),(88,'selling_price_group.1','web','2021-06-21 07:52:13','2021-06-21 07:52:13'),(89,'essentials.create_message','web','2021-06-27 04:59:22','2021-06-27 04:59:22'),(90,'essentials.view_message','web','2021-06-27 04:59:22','2021-06-27 04:59:22'),(91,'essentials.approve_leave','web','2021-06-27 04:59:22','2021-06-27 04:59:22'),(92,'essentials.assign_todos','web','2021-06-27 04:59:22','2021-06-27 04:59:22'),(93,'essentials.add_allowance_and_deduction','web','2021-06-27 04:59:22','2021-06-27 04:59:22'),(94,'location.2','web','2021-09-25 13:17:38','2021-09-25 13:17:38'),(95,'location.3','web','2021-09-25 13:21:19','2021-09-25 13:21:19'),(96,'location.4','web','2021-09-25 13:23:52','2021-09-25 13:23:52'),(97,'location.5','web','2021-11-08 15:54:09','2021-11-08 15:54:09'),(98,'location.6','web','2021-11-15 17:35:54','2021-11-15 17:35:54');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `printers`
--

DROP TABLE IF EXISTS `printers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `printers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection_type` enum('network','windows','linux') COLLATE utf8mb4_unicode_ci NOT NULL,
  `capability_profile` enum('default','simple','SP2000','TEP-200M','P822D') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `char_per_line` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `port` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `printers_business_id_foreign` (`business_id`),
  CONSTRAINT `printers_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `printers`
--

LOCK TABLES `printers` WRITE;
/*!40000 ALTER TABLE `printers` DISABLE KEYS */;
/*!40000 ALTER TABLE `printers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_locations`
--

DROP TABLE IF EXISTS `product_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_locations` (
  `product_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  KEY `product_locations_product_id_index` (`product_id`),
  KEY `product_locations_location_id_index` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_locations`
--

LOCK TABLES `product_locations` WRITE;
/*!40000 ALTER TABLE `product_locations` DISABLE KEYS */;
INSERT INTO `product_locations` (`product_id`, `location_id`) VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,1),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1),(35,1),(36,1),(37,1),(38,1),(39,1),(40,1),(41,1),(42,1),(43,1),(44,1),(45,1),(46,1),(47,1),(48,1),(49,1),(50,1),(51,1),(52,1),(53,1);
/*!40000 ALTER TABLE `product_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_racks`
--

DROP TABLE IF EXISTS `product_racks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_racks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `rack` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `row` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_racks_business_id_index` (`business_id`),
  KEY `product_racks_location_id_index` (`location_id`),
  KEY `product_racks_product_id_index` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_racks`
--

LOCK TABLES `product_racks` WRITE;
/*!40000 ALTER TABLE `product_racks` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_racks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_variations`
--

DROP TABLE IF EXISTS `product_variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_variations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variation_template_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `is_dummy` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_variations_name_index` (`name`),
  KEY `product_variations_product_id_index` (`product_id`),
  CONSTRAINT `product_variations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_variations`
--

LOCK TABLES `product_variations` WRITE;
/*!40000 ALTER TABLE `product_variations` DISABLE KEYS */;
INSERT INTO `product_variations` (`id`, `variation_template_id`, `name`, `product_id`, `is_dummy`, `created_at`, `updated_at`) VALUES (1,NULL,'DUMMY',1,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(2,NULL,'DUMMY',2,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(3,NULL,'DUMMY',3,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(4,NULL,'DUMMY',4,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(5,NULL,'DUMMY',5,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(6,NULL,'DUMMY',6,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(7,NULL,'DUMMY',7,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(8,NULL,'DUMMY',8,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(9,NULL,'DUMMY',9,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(10,NULL,'DUMMY',10,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(11,NULL,'DUMMY',11,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(12,NULL,'DUMMY',12,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(13,NULL,'DUMMY',13,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(14,NULL,'DUMMY',14,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(15,NULL,'DUMMY',15,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(16,NULL,'DUMMY',16,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(17,NULL,'DUMMY',17,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(18,NULL,'DUMMY',18,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(19,NULL,'DUMMY',19,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(20,NULL,'DUMMY',20,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(21,NULL,'DUMMY',21,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(22,NULL,'DUMMY',22,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(23,NULL,'DUMMY',23,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(24,NULL,'DUMMY',24,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(25,NULL,'DUMMY',25,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(26,NULL,'DUMMY',26,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(27,NULL,'DUMMY',27,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(28,NULL,'DUMMY',28,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(29,NULL,'DUMMY',29,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(30,NULL,'DUMMY',30,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(31,NULL,'DUMMY',31,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(32,NULL,'DUMMY',32,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(33,NULL,'DUMMY',33,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(34,NULL,'DUMMY',34,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(35,NULL,'DUMMY',35,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(36,NULL,'DUMMY',36,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(37,NULL,'DUMMY',37,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(38,NULL,'DUMMY',38,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(39,NULL,'DUMMY',39,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(40,NULL,'DUMMY',40,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(41,NULL,'DUMMY',41,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(42,NULL,'DUMMY',42,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(43,NULL,'DUMMY',43,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(44,NULL,'DUMMY',44,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(45,NULL,'DUMMY',45,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(46,NULL,'DUMMY',46,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(47,NULL,'DUMMY',47,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(48,NULL,'DUMMY',48,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(49,NULL,'DUMMY',49,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(50,NULL,'DUMMY',50,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(51,NULL,'DUMMY',51,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(52,NULL,'DUMMY',52,1,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(53,1,'Stock',53,0,'2021-11-16 07:38:54','2021-11-16 07:38:54');
/*!40000 ALTER TABLE `product_variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) unsigned NOT NULL,
  `type` enum('single','variable','modifier','combo') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_id` int(11) unsigned DEFAULT NULL,
  `sub_unit_ids` text COLLATE utf8mb4_unicode_ci,
  `brand_id` int(10) unsigned DEFAULT NULL,
  `category_id` int(10) unsigned DEFAULT NULL,
  `sub_category_id` int(10) unsigned DEFAULT NULL,
  `tax` int(10) unsigned DEFAULT NULL,
  `tax_type` enum('inclusive','exclusive') COLLATE utf8mb4_unicode_ci NOT NULL,
  `enable_stock` tinyint(1) NOT NULL DEFAULT '0',
  `alert_quantity` decimal(22,4) DEFAULT NULL,
  `sku` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `barcode_type` enum('C39','C128','EAN13','EAN8','UPCA','UPCE') COLLATE utf8mb4_unicode_ci DEFAULT 'C128',
  `expiry_period` decimal(4,2) DEFAULT NULL,
  `expiry_period_type` enum('days','months') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_sr_no` tinyint(1) NOT NULL DEFAULT '0',
  `weight` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_custom_field1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_custom_field2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_custom_field3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_custom_field4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `woocommerce_media_id` int(11) DEFAULT NULL,
  `product_description` text COLLATE utf8mb4_unicode_ci,
  `created_by` int(10) unsigned NOT NULL,
  `woocommerce_product_id` int(11) DEFAULT NULL,
  `woocommerce_disable_sync` tinyint(1) NOT NULL DEFAULT '0',
  `warranty_id` int(11) DEFAULT NULL,
  `is_inactive` tinyint(1) NOT NULL DEFAULT '0',
  `not_for_selling` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_brand_id_foreign` (`brand_id`),
  KEY `products_category_id_foreign` (`category_id`),
  KEY `products_sub_category_id_foreign` (`sub_category_id`),
  KEY `products_tax_foreign` (`tax`),
  KEY `products_name_index` (`name`),
  KEY `products_business_id_index` (`business_id`),
  KEY `products_unit_id_index` (`unit_id`),
  KEY `products_created_by_index` (`created_by`),
  KEY `products_warranty_id_index` (`warranty_id`),
  KEY `products_type_index` (`type`),
  KEY `products_tax_type_index` (`tax_type`),
  KEY `products_barcode_type_index` (`barcode_type`),
  KEY `products_woocommerce_product_id_index` (`woocommerce_product_id`),
  KEY `products_woocommerce_media_id_index` (`woocommerce_media_id`),
  CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_tax_foreign` FOREIGN KEY (`tax`) REFERENCES `tax_rates` (`id`),
  CONSTRAINT `products_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`, `name`, `business_id`, `type`, `unit_id`, `sub_unit_ids`, `brand_id`, `category_id`, `sub_category_id`, `tax`, `tax_type`, `enable_stock`, `alert_quantity`, `sku`, `barcode_type`, `expiry_period`, `expiry_period_type`, `enable_sr_no`, `weight`, `product_custom_field1`, `product_custom_field2`, `product_custom_field3`, `product_custom_field4`, `image`, `woocommerce_media_id`, `product_description`, `created_by`, `woocommerce_product_id`, `woocommerce_disable_sync`, `warranty_id`, `is_inactive`, `not_for_selling`, `created_at`, `updated_at`) VALUES (1,'GM DIAMOND 707 SH',1,'single',1,NULL,NULL,29,30,NULL,'inclusive',1,0.0000,'0001','C128',NULL,NULL,0,'','','','','','',NULL,'1. MADE WITH BEST QUALITY ENGLISH WILLOW.  2.SHORTENED L540 BLADE DESIGN FOR DYNAMIC SWEETSPOT.\n3.POWERARC BOW FACE PROFILE TRADITIONAL FULL BLADE PROFILE\n4.FLOWING CONTOURED SPINE.        5.   MID SWELL POSITION FOR PERFECT STROKEPLAY \n',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(2,'GM CHROMA 909 (2021) SH',1,'single',1,NULL,NULL,29,30,NULL,'inclusive',1,0.0000,'0002','C128',NULL,NULL,0,'','','','','','',NULL,'1. Made with  Made from top of the line grade A English Willow. \n From the Chroma range of GM Cricket. Fuller profile specially re-designed for T-20 Cricket.\n Massive Edges .\n Flatter Face with Mid to Low Profile.\n 7-10 Grains.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(3,'GM DIAMOND 303 JUNIOR',1,'single',1,NULL,NULL,29,30,NULL,'inclusive',1,0.0000,'0003','C128',NULL,NULL,0,'','','','','','',NULL,'1. Made with English Willow\nShort Handle bat ( SH )\nPreferred playing with Leather Ball.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(4,'New Balance DC 590 English Willow Cricket Bat Size SH',1,'single',1,NULL,NULL,29,30,NULL,'inclusive',1,0.0000,'0004','C128',NULL,NULL,0,'','','','','','',NULL,'1. Made with Grade 3  English willow   2. 6piece Singapore cane handle.  3. Large Edges and sweet spot.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(5,'New Balance TC 550+ English Willow Cricket Bat Size SH',1,'single',1,NULL,NULL,29,30,NULL,'inclusive',1,0.0000,'0005','C128',NULL,NULL,0,'','','','','','',NULL,'1. Made with Grade 5 English willow.  2. 6piece Singapore cane handle.  3. Glass fibre tape on face. 4.  traditionally designed large edges.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(6,'GM ALL-WEATHER BALL',1,'single',1,NULL,3,2,31,NULL,'inclusive',1,0.0000,'0006','C128',NULL,NULL,0,'','','','','','',NULL,'Durable rubber ball for use in all conditions',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(7,'GM ALL-WEATHER BALL',1,'single',1,NULL,3,2,31,NULL,'inclusive',1,0.0000,'0007','C128',NULL,NULL,0,'','','','','','',NULL,'Durable rubber ball for use in all conditions',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(8,'SG LEAGUE Cricket Balls(Red)',1,'single',1,NULL,6,2,32,NULL,'inclusive',1,0.0000,'0008','C128',NULL,NULL,0,'','','','','','',NULL,'The League is a premium quality four-piece ball made from superior quality alum tanned leather. The League is ideally suited for club and school matches.\n\nWater-proofed\n\nHigh quality centre construction encased with layers of top quality Portuguese cork wound with 100% wool\n\nNaturally seasoned inner core',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(9,'DSC INTENSE PASSION BATTING GLOVES RH MEN',1,'single',1,NULL,13,23,NULL,NULL,'inclusive',1,0.0000,'0009','C128',NULL,NULL,0,'','','','','','',NULL,'Top quality glove with multi flex pre-curved construction\nHigh quality leather palm for superior grip and feel\nHigh quality PU and ultra light foam in the finger rolls for impact absorption\nAirflow gusset for ventilation and’dual’ sided sweatband for moisture absorption and player comfort\nFRP (Fibre Reinforced Protection) with fibre inserts across all fingers provide immense impact protection\nStrategically positioned flexpoints enable players’ unrestricted movement\nThree side bars for better protection and split thumb\nToweled wristband for comfort fit with velcro for perfect fit\nSplit thumb and single piece side bar protection in bottom hand\nNylon gusset for ventilation',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(10,'DSC Batting Gloves Condor Atmos Youth RH',1,'single',1,NULL,13,23,NULL,NULL,'inclusive',1,0.0000,'0010','C128',NULL,NULL,0,'','','','','','',NULL,'Pre-curved cotton filled finger rolls for protection, flexibility and comfort\nLightweight slim design ideal for club & junior players\nCotton palm with leather patch for superior grip and feel\nHigh Density Foam reinforced Fingers\nSweat Absorbing Wrist Grip\nDesigned for long innings\nCotton gusset for ventilation\nToweled wristband for comfort fit with velcro for perfect fit\nNylon gusset for ventilation\nSingle-piece sidebar on lead hand',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(11,'SG HILITE White RH Batting Gloves',1,'single',1,NULL,6,23,NULL,NULL,'inclusive',1,0.0000,'0011','C128',NULL,NULL,0,'','','','','','',NULL,'Palm made from premium quality leather manufactured by world?s best Pittards? of UK\nAdditional leather patch on hard-wearing areas of palm to minimise wear-and-tear\nNon-toxic imported polyurethane (PU) finger rolls with lightweight High Density (HD) EthyleneVinylAcetate (EVA) foam padding inserts\nSplit thumb for extra-flex; three-piece sidebar on bottom hand for extra protection from those wayward balls\nFirst two fingers have reinforced plastic inserts in bottom hand; all other fingers fibre protection in both hands\nFully ventilated finger construction with nylon gusset along sides that provides airing and sweat reduction over extended use\nAvailable in size Adult\nFavoured to use by professional cricketers',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(12,'SG HP LITE BATTING GLOVES RH YOUTH',1,'single',1,NULL,6,23,NULL,NULL,'inclusive',1,0.0000,'0012','C128',NULL,NULL,0,'','','','','','',NULL,'High quality sheep leather.Additional leather patch on hand-wearing area.Imported PU and cotton filled finger rolls.All finger rounded cover plastic in both hands.Split thumb top section with extra fiber protection.Three piece side bar protection in both hands.Sponge-padded spacer mesh back for better fit and comfort.Nylon gusset for ventilation.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(13,'SG HILITE RH Batting Legguards',1,'single',1,NULL,6,24,NULL,NULL,'inclusive',1,0.0000,'0013','C128',NULL,NULL,0,'','','','','','',NULL,'Made from premium quality imported polyurethane facing\nHigh density foam filled for traditional look\nExtra high density foam filling in the side wings\nExtra butterfly straps for the right fit\nThermoplastic polyurethane moulded knee socket for added protection',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(14,'SG CLUB YOUTH RH Batting Legguards',1,'single',1,NULL,6,24,NULL,NULL,'inclusive',1,0.0000,'0014','C128',NULL,NULL,0,'','','','','','',NULL,'Made from high quality, wipe cleanable PVC facing\nCashmilon filled cane reinforced construction\nLow density foam/cotton side wings\nCashmilon filled three cross bolsters\nHigh density sponge filled bolster',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(15,'NEW BALANCE TC 860 BATTING PADS LH SMALL MEN',1,'single',1,NULL,12,24,NULL,NULL,'inclusive',1,0.0000,'0015','C128',NULL,NULL,0,'','','','','','',NULL,'The ultimate protection, matched by the ultimate comfort. Developed with a traditional style player in mind, the TC pad range is the key to facing fast bowling with the upmost confidence.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(16,'SG ECOLITE JUNIOR Batting Legguards',1,'single',1,NULL,6,24,NULL,NULL,'inclusive',1,0.0000,'0016','C128',NULL,NULL,0,'','','','','','',NULL,'Made from PVC facing\nLow density foam padding for maximum protection and flexibility\nCashmilon and low density foam filled vertical bolster\nCan be used by both left-handed and right-handed batsmen\nWear resistant PVC instep with hard-wearing piping\nLow-density foam sheet reinforcement vertical bolster\nLayered dual density foam padded for optimum protection and flexibility\nCan be used by both left-handed and right-handed batsmen',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(17,'GM CRICKET HELMET – NEON GEO',1,'single',1,NULL,3,25,NULL,NULL,'inclusive',1,0.0000,'0017','C128',NULL,NULL,0,'','','','','','',NULL,'Specification for Head Protectors for Cricketers, British Standards Institute Improved peak strength and precisely fitted Geo steel grille greatly reduces the risk of the ball penetrating the gap between the two Fitted with a Geo steel grille as standard',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(18,'GM CRICKET HELMET – PURIST GEO II NVY JUNIOR',1,'single',1,NULL,3,25,NULL,NULL,'inclusive',1,0.0000,'0018','C128',NULL,NULL,0,'','','','','','',NULL,'Specification for Head Protectors for Cricketers, British Standards Institute Improved peak strength and precisely fitted Geo steel grille greatly reduces the risk of the ball penetrating the gap between the two Fitted with a Geo steel grille as standard',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(19,'MASURI T Line Titanium CRICKET HELMET',1,'single',1,NULL,11,25,NULL,NULL,'inclusive',1,0.0000,'0019','C128',NULL,NULL,0,'','','','','','',NULL,'Masuri T-Line Titanium Cricket Helmet has UK designed and manufactured single shell protection, providing an affordable, lightweight and traditional style helmet designed with patented Eye-line grille technology for greater facial safety.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(20,'MASURI C Line Junior CRICKET HELMET',1,'single',1,NULL,11,25,NULL,NULL,'inclusive',1,0.0000,'0020','C128',NULL,NULL,0,'','','','','','',NULL,'Masuri T-Line Titanium Cricket Helmet has UK designed and manufactured single shell protection, providing an affordable, lightweight and traditional style helmet designed with patented Eye-line grille technology for greater facial safety.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(21,'KB FINGERLESS BATTING INNER',1,'single',1,NULL,4,33,NULL,NULL,'inclusive',1,0.0000,'0021','C128',NULL,NULL,0,'','','','','','',NULL,'Kookaburra Fingerless Cricket Batting Inner Gloves Size OSA Adult Youth Junior.\nFull cotton with cotton & mesh back and gathered cotton wrist. MODEL: FINGERLESS Batting Inners, Batting Inners, Colour: Black-Green, Sizes: OSA, Adult, Youth & Junior.\nProfile Full cotton with cotton & mesh back, Pading NA, Wrist Gathered cotton.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(22,'KB FINGERLESS BATTING INNER',1,'single',1,NULL,4,33,NULL,NULL,'inclusive',1,0.0000,'0022','C128',NULL,NULL,0,'','','','','','',NULL,'Kookaburra Fingerless Cricket Batting Inner Gloves Size OSA Adult Youth Junior.\nFull cotton with cotton & mesh back and gathered cotton wrist. MODEL: FINGERLESS Batting Inners, Batting Inners, Colour: Black-Green, Sizes: OSA, Adult, Youth & Junior.\nProfile Full cotton with cotton & mesh back, Pading NA, Wrist Gathered cotton.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(23,'Aero Groin Protector Trunks',1,'single',1,NULL,10,26,NULL,NULL,'inclusive',1,0.0000,'0023','C128',NULL,NULL,0,'','','','','','',NULL,'Designed with the youth of today in mind and are sure to be very popular. Featuring compression materials and all the brilliant aspects of the briefs and the shorts',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(24,'SG Combo Test Pro White Thigh Pad',1,'single',1,NULL,6,26,NULL,NULL,'inclusive',1,0.0000,'0024','C128',NULL,NULL,0,'','','','','','',NULL,'Combination of Thigh pad and Inner thigh pad\nMade from imported PU facing\nConstructed from microweight UHDF with polycarbonate rainforcement.\nUsed by top international players\nSoft absorbent polyester back\nPremium quality elastic waist and thigh straps\nAvailable for both right and left-handed batsmen',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(25,'Aero Batmes Chestprotector P1 male',1,'single',1,NULL,10,26,NULL,NULL,'inclusive',1,0.0000,'0025','C128',NULL,NULL,0,'','','','','','',NULL,'Three layers of high quality closed cell foam gives superb shock resistance with a low profile.Innovative holster design stays in place and wont get in the way when palying shots.Adjustable straps for the perfect fit.Ambidextrous design, suitable for right and left handed batsmen.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(26,'Aero Batmes Forearm protector P3 Xsmall',1,'single',1,NULL,10,26,NULL,NULL,'inclusive',1,0.0000,'0026','C128',NULL,NULL,0,'','','','','','',NULL,'Our Forearm Protectors (BHPs) are designed to protect the entire forearm while not restricting movement or circulation. Using the same foams as our award-winning Strippers, they protect from the wrist to the elbow, and conform to the contours of the forearm.The sleeve design reduces circulation problems caused by a strap system and means, like the Strippers, once it is on you can forget about it and concentrate on scoring runs.The moisture wicking materials and closed cell foam construction means it can be washed time and again and the 3D moulded foam gives you the confidence that your forearm has the very best protection on the market.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(27,'KOOKABURRA KC 5.0 RUBBER CRICKET SHOE',1,'single',1,NULL,4,4,NULL,NULL,'inclusive',1,0.0000,'0027','C128',NULL,NULL,0,'','','','','','',NULL,'A functional cricket shoe perfect for cricketers. The Kookaburra KC 5.0 Rubber Cricket Shoes are suitable for indoor and outdoor training/matches containing a rubber sole  providing comfort, grip and durability.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(28,'KOOKABURRA KC 2.0 RUBBER JUNIOR CRICKET SHOE',1,'single',1,NULL,NULL,4,NULL,NULL,'inclusive',1,0.0000,'0028','C128',NULL,NULL,0,'','','','','','',NULL,'A combination of revolutionary design & traditional quality manufacture makes the new Kookaburra Footwear the only choice for discerning Cricketers at all levels.\n\nFeatures\n\n? Lightweight, streamlined low-profile design\n\n? Durable dual layer coated mesh upper featuring Action Leather, Mesh and PU to produce superb flexibility, durability and support\n\n? Rubber reinforced sections to the toe box & forefoot to enhance support and durability\n\n? PVC lateral motion control ensures a stable and secure fit\n\n? Integrated padded tongue for improved comfort and fit\n\n? Athletic style ?Slip Last? for comfort & support\n\n? Thermo-Plastic Heel Counter increases support\n\n? Reinforced Ankle & Heel for enhance stability\n\n? 3D moulded hexagonal EVA Insole providing superb shock absorbency & comfort\n\n? Ultra-Traction Outsole providing exceptional stability in play',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(29,'Newberry SPS Men Keeping gloves',1,'single',1,NULL,7,5,NULL,NULL,'inclusive',1,0.0000,'0029','C128',NULL,NULL,0,'','','','','','',NULL,'Unique double layer leather top, creating a perfect fit and breathable feel.\nDesigned by pro-keepers for you.\nMade from 2 styles of premium leather in a unique make up for exceptional flexibility and a snug fit.\nSoft cup, that moulds to your hand with large area octopus grip palm.\nMemory foam finger ends: moulds to your fingers.\nWebbing stitched to the back of the glove, then double stitched so it holds a nice cup and improves catching capabilities of the glove',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(30,'ADIDAS WICKET KEEPING GLOVES XT 1.0',1,'single',1,NULL,8,5,NULL,NULL,'inclusive',1,0.0000,'0030','C128',NULL,NULL,0,'','','','','','',NULL,'Durable PU back for lightweight feel, padded cuffs, reinforced finger section. Highest grade dimpled palm. Square cuffs.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(31,'SG RP 17 W.K. Gloves',1,'single',1,NULL,6,5,NULL,NULL,'inclusive',1,0.0000,'0031','C128',NULL,NULL,0,'','','','','','',NULL,'Premium quality pair of professional wicket keeping\n\nglove.\n\n• Made from the finest aniline leather and has all leather palm, cuffs and back.\n\n• Tricolor Octopus design rubber in palm facing.\n\n• White padded leather cuff.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(32,'SG SUPAKEEP W.K. Gloves',1,'single',1,NULL,6,5,NULL,NULL,'inclusive',1,0.0000,'0032','C128',NULL,NULL,0,'','','','','','',NULL,'Premium quality pair of professional wicket keeping glove\nMade from the finest aniline leather and has all-leather palm, cuffs and back\nTricolor Octopus rubber in palm facing\nWhite padded towel lining in the cuffs',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(33,'FULL CHAMI WK INNER A',1,'single',1,NULL,4,21,NULL,NULL,'inclusive',1,0.0000,'0033','C128',NULL,NULL,0,'','','','','','',NULL,'Full chamois construction for unrivalled freedom of movement and comfort\nOSA & A',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(34,'GM INNER GLOVES – FINGERLESS COTTON',1,'single',1,NULL,3,21,NULL,NULL,'inclusive',1,0.0000,'0034','C128',NULL,NULL,0,'','','','','','',NULL,'The Chamois Padded Inner has a lycra back of hand and double sided sweatband with velcro closure.\nSuperb Feel and Comfort\nTop Quality all Chamois Leather\nBreathable Fingers\nDouble Sided Sweatband with Velcro',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(35,'SS KEEPING INNER TEST KEEPING INNERS JUNIOR',1,'single',1,NULL,9,21,NULL,NULL,'inclusive',1,0.0000,'0035','C128',NULL,NULL,0,'','','','','','',NULL,'Made from highly absorbent fine cotton material',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(36,'SG MEGALITE Batting Legguards W.K',1,'single',1,NULL,9,22,NULL,NULL,'inclusive',1,0.0000,'0036','C128',NULL,NULL,0,'','','','','','',NULL,'Made from premium quality imported polyurethane facing\nHigh-density foam padded with thermoplastic polyurethane insert\nCompact and wrap around fit\nMesh instep with hard-wearing piping',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(37,'GM WICKET KEEPING PADS – 606 YOUTHS',1,'single',1,NULL,3,22,NULL,NULL,'inclusive',1,0.0000,'0037','C128',NULL,NULL,0,'','','','','','',NULL,'Weight per pair : 085 kgs\nFacing : pvc\nFace filling : dual layer foam\nVertical bolster : comfort foam\nStraps : 2\" & 1\"\nInstep : mesh',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(38,'SG ECOPAK Kit Bag',1,'single',1,NULL,6,6,18,NULL,'inclusive',1,0.0000,'0038','C128',NULL,NULL,0,'','','','','','',NULL,'Made from premium PU coated material.\nHigh quality zips for better durability.\nDurable base sheet.\nIdeal for carrying single kit.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(39,'SHREY PRO PREMIUM DUFFLE',1,'single',1,NULL,5,6,18,NULL,'inclusive',1,0.0000,'0039','C128',NULL,NULL,0,'','','','','','',NULL,'The Shrey Pro Premium Duffle Bag boasts an efficient design and compacts shape with maximum storage.\n6 padded bat pockets provide multi storage options.\nSeparate compartments for shoes, clothing, accessories and protective gear for better organization.\nDesigned to carry all your cricket gear with ease. \nTough, abrasion-resistant bottom panel. \nLargest front zip organization pocket.\nHeavy duty wheels with full length protective runners. \nAdjustable, padded shoulder strap for total comfort. ',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(40,'GM CRKT BAG – 707 WHEELIE',1,'single',1,NULL,3,6,19,NULL,'inclusive',1,0.0000,'0040','C128',NULL,NULL,0,'','','','','','',NULL,'Shoe tunnel\nIntegrated bat sleeves',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(41,'SHREY PRO WHEELIE',1,'single',1,NULL,5,6,19,NULL,'inclusive',1,0.0000,'0041','C128',NULL,NULL,0,'','','','','','',NULL,'✔Shrey Match Cricket Wheelie Bag delivers an element-battling, highly water-resistant finish.\n✔Separate cave for 3 bats at the bottom protecting the bats from damage.\n✔Separate compartments for shoes, clothing, accessories and protective gear for better organization.\n✔Heavy canvas materials provide ultimate durability.A tapered design for greater stability in use.\n✔Interior pockets for organization.Heavy duty wheels with full length protective runners.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(42,'GM CRKT BAG – STRIKER HOLDALL BLUE',1,'single',1,NULL,NULL,6,20,NULL,'inclusive',1,0.0000,'0042','C128',NULL,NULL,0,'','','','','','',NULL,'600 Denier Polyester Fabric\nEnd Panel Bat Handle Ring\nInternal Pouch\nPadded Handles\nCarry Strap\n8mm Heavy Duty ?D? Opening Zip\nRust Proof GM Designer Zip\nAnti-Scuff Corner Protection, Protection',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(43,'GM GM BAT SIZE GAUGE',1,'single',1,NULL,3,7,NULL,NULL,'inclusive',1,0.0000,'0043','C128',NULL,NULL,0,'','','','','','',NULL,'Precision moulded bat gauge\nSizing parameters conform strictly to new MCC Law 5 bat size regulations\nFor umpire use to uphold the balance of play between bat and ball',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(44,'GM CRICKET BAT REPAIR KIT',1,'single',1,NULL,3,7,NULL,NULL,'inclusive',1,0.0000,'0044','C128',NULL,NULL,0,'','','','','','',NULL,'Contains all the necessary and essential items for use in successfully preparing your cricket bat and ensuring that your cricket bat is maintained in a manner that makes it perform optimally throughout. The Kit comes in a neat travel bag that stores easily and beautifully into any standard cricket kit bag.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(45,'KB CHEVRON GRIP',1,'single',1,NULL,4,7,NULL,NULL,'inclusive',1,0.0000,'0045','C128',NULL,NULL,0,'','','','','','',NULL,'The Kookaburra Chevron Grip is a thin cricket bat grip that allows players to feel the handle for improved control.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(46,'PORTABLE SCOREBOARD LARGE',1,'single',1,NULL,4,7,NULL,NULL,'inclusive',1,0.0000,'0046','C128',NULL,NULL,0,'','','','','','',NULL,'Kookaburra Cricket Sports Portable Scoreboard – Large The Kookaburra Portable Scoreboard is perfect for Schools and Clubs and includes a carry case for easy storage and handling',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(47,'KB UMPIRES COUNTER',1,'single',1,NULL,4,7,NULL,NULL,'inclusive',1,0.0000,'0047','C128',NULL,NULL,0,'','','','','','',NULL,'The Kookaburra Umpire’s Counter features a compact design and allows umpires to easily keep track of balls and overs bowled during an innings.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(48,'ROBOARM',1,'single',1,NULL,NULL,7,NULL,NULL,'inclusive',1,0.0000,'0048','C128',NULL,NULL,0,'','','','','','',NULL,'The roboarm advanced is the most advanced and world\'s fastest ball throwing aid.\nThe roboarm advanced is the most advanced and world\'s fastest ball throwing aid.\nRevolutionary innovation in cricket skill development. Very easy to use and generate high speed deliveries with minimal effort.\nPatented ball thrower\nIn-Box Contents: 1 stem with 1 ball holder.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(49,'WW HANGING CRICKET BALLS',1,'single',1,NULL,NULL,7,NULL,NULL,'inclusive',1,0.0000,'0049','C128',NULL,NULL,0,'','','','','','',NULL,'Material: Leather Color: Leather Practice Ball Red & String White Color\nProduct Size: Standard Target Audience All for Cricket Pactice\nPackage Quantity: 1 Leather Practice Cricket Ball\nCricket Training ball with Cord Best for Batting Practice Sessions\nImproves hand-to-eye coordination Best for beginners who want to improve their batting skills',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(50,'KOOKABURRA CRICKET SOCK CREAM',1,'single',1,NULL,4,7,NULL,NULL,'inclusive',1,0.0000,'0050','C128',NULL,NULL,0,'','','','','','',NULL,'The Kookaburra Pro Players Ped Sock is a full terry cricket sock constructed from 75% wool and 25% nylon & lycra.',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(51,'GM CRICKET HAT – PANAMA WHITE',1,'single',1,NULL,3,8,NULL,NULL,'inclusive',1,0.0000,'0051','C128',NULL,NULL,0,'','','','','','',NULL,'100% cotton\nReinforced wide brim\nGM6079\nFully lined',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(52,'KB PRO PLAYER SWEATER',1,'single',1,NULL,4,8,NULL,NULL,'inclusive',1,0.0000,'0052','C128',NULL,NULL,0,'','','','','','',NULL,'Stretch fabric for ease of movement\nIntegrated stay cool technology\nRegular Fit ? Full, loose fit for enhanced range of movement, allowing room for protective gear to be worn underneath\n100% Polyester pin hole pique with 100% polyester basket weave inserts',5,NULL,0,NULL,0,0,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(53,'Sample product',1,'variable',1,NULL,8,6,NULL,NULL,'exclusive',1,10.0000,'0053','C128',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0,NULL,0,0,'2021-11-16 07:38:54','2021-11-16 08:13:50');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_lines`
--

DROP TABLE IF EXISTS `purchase_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_lines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `variation_id` int(10) unsigned NOT NULL,
  `quantity` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `pp_without_discount` decimal(22,4) NOT NULL DEFAULT '0.0000' COMMENT 'Purchase price before inline discounts',
  `discount_percent` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT 'Inline discount percentage',
  `purchase_price` decimal(22,4) NOT NULL,
  `purchase_price_inc_tax` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `item_tax` decimal(22,4) NOT NULL COMMENT 'Tax for one quantity',
  `tax_id` int(10) unsigned DEFAULT NULL,
  `purchase_order_line_id` int(11) DEFAULT NULL,
  `quantity_sold` decimal(22,4) NOT NULL DEFAULT '0.0000' COMMENT 'Quanity sold from this purchase line',
  `quantity_adjusted` decimal(22,4) NOT NULL DEFAULT '0.0000' COMMENT 'Quanity adjusted in stock adjustment from this purchase line',
  `quantity_returned` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `po_quantity_purchased` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `mfg_quantity_used` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `mfg_date` date DEFAULT NULL,
  `exp_date` date DEFAULT NULL,
  `lot_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_unit_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_lines_transaction_id_foreign` (`transaction_id`),
  KEY `purchase_lines_product_id_foreign` (`product_id`),
  KEY `purchase_lines_variation_id_foreign` (`variation_id`),
  KEY `purchase_lines_tax_id_foreign` (`tax_id`),
  KEY `purchase_lines_sub_unit_id_index` (`sub_unit_id`),
  KEY `purchase_lines_lot_number_index` (`lot_number`),
  CONSTRAINT `purchase_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_lines_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_lines_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_lines`
--

LOCK TABLES `purchase_lines` WRITE;
/*!40000 ALTER TABLE `purchase_lines` DISABLE KEYS */;
INSERT INTO `purchase_lines` (`id`, `transaction_id`, `product_id`, `variation_id`, `quantity`, `pp_without_discount`, `discount_percent`, `purchase_price`, `purchase_price_inc_tax`, `item_tax`, `tax_id`, `purchase_order_line_id`, `quantity_sold`, `quantity_adjusted`, `quantity_returned`, `po_quantity_purchased`, `mfg_quantity_used`, `mfg_date`, `exp_date`, `lot_number`, `sub_unit_id`, `created_at`, `updated_at`) VALUES (1,1,1,1,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(2,2,2,2,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(3,3,3,3,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(4,4,4,4,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(5,5,5,5,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(6,6,6,6,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(7,7,7,7,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(8,8,8,8,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(9,9,9,9,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(10,10,10,10,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(11,11,11,11,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(12,12,12,12,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(13,13,13,13,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(14,14,14,14,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(15,15,15,15,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(16,16,16,16,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(17,17,17,17,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(18,18,18,18,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(19,19,19,19,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(20,20,20,20,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(21,21,21,21,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(22,22,22,22,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(23,23,23,23,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(24,24,24,24,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(25,25,25,25,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(26,26,26,26,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(27,27,27,27,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(28,28,28,28,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(29,29,29,29,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(30,30,30,30,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(31,31,31,31,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(32,32,32,32,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(33,33,33,33,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(34,34,34,34,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(35,35,35,35,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(36,36,36,36,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(37,37,37,37,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(38,38,38,38,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(39,39,39,39,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(40,40,40,40,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(41,41,41,41,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(42,42,42,42,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(43,43,43,43,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(44,44,44,44,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(45,45,45,45,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(46,46,46,46,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(47,47,47,47,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(48,48,48,48,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(49,49,49,49,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(50,50,50,50,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(51,51,51,51,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(52,52,52,52,100.0000,110.0000,0.00,110.0000,100.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(53,53,53,53,10.0000,12.0000,0.00,12.0000,12.0000,0.0000,NULL,NULL,2.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-16 07:39:12','2021-11-16 08:18:27'),(54,53,53,54,10.0000,13.0000,0.00,13.0000,13.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-16 07:39:12','2021-11-16 07:39:12'),(55,53,53,55,10.0000,14.0000,0.00,14.0000,14.0000,0.0000,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2021-11-16 07:39:12','2021-11-16 07:39:12');
/*!40000 ALTER TABLE `purchase_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reference_counts`
--

DROP TABLE IF EXISTS `reference_counts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reference_counts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ref_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ref_count` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reference_counts_business_id_index` (`business_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reference_counts`
--

LOCK TABLES `reference_counts` WRITE;
/*!40000 ALTER TABLE `reference_counts` DISABLE KEYS */;
INSERT INTO `reference_counts` (`id`, `ref_type`, `ref_count`, `business_id`, `created_at`, `updated_at`) VALUES (1,'contacts',7,1,'2021-06-12 08:05:38','2021-11-16 08:18:04'),(2,'business_location',4,1,'2021-06-12 08:05:38','2021-11-15 17:35:54'),(3,'sell_payment',39,1,'2021-06-21 07:33:41','2021-11-16 08:18:27'),(4,'sell_return',1,1,'2021-07-03 19:18:54','2021-07-03 19:18:54'),(5,'purchase',2,1,'2021-07-03 19:24:11','2021-09-01 10:30:06'),(6,'draft',5,1,'2021-07-31 08:35:33','2021-11-05 15:19:28'),(7,'purchase_payment',1,1,'2021-09-01 10:30:06','2021-09-01 10:30:06'),(8,'username',2,1,'2021-09-14 09:13:30','2021-11-08 15:55:47'),(9,'contacts',1,2,'2021-09-25 13:21:19','2021-09-25 13:21:19'),(10,'business_location',2,2,'2021-09-25 13:21:19','2021-09-25 13:23:52');
/*!40000 ALTER TABLE `reference_counts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_product_modifier_sets`
--

DROP TABLE IF EXISTS `res_product_modifier_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `res_product_modifier_sets` (
  `modifier_set_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL COMMENT 'Table use to store the modifier sets applicable for a product',
  KEY `res_product_modifier_sets_modifier_set_id_foreign` (`modifier_set_id`),
  CONSTRAINT `res_product_modifier_sets_modifier_set_id_foreign` FOREIGN KEY (`modifier_set_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_product_modifier_sets`
--

LOCK TABLES `res_product_modifier_sets` WRITE;
/*!40000 ALTER TABLE `res_product_modifier_sets` DISABLE KEYS */;
/*!40000 ALTER TABLE `res_product_modifier_sets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_tables`
--

DROP TABLE IF EXISTS `res_tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `res_tables` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_by` int(10) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `res_tables_business_id_foreign` (`business_id`),
  CONSTRAINT `res_tables_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_tables`
--

LOCK TABLES `res_tables` WRITE;
/*!40000 ALTER TABLE `res_tables` DISABLE KEYS */;
INSERT INTO `res_tables` (`id`, `business_id`, `location_id`, `name`, `description`, `created_by`, `deleted_at`, `created_at`, `updated_at`) VALUES (1,1,1,'A1',NULL,1,NULL,'2021-09-13 11:11:35','2021-09-13 11:11:35'),(2,1,1,'A2',NULL,1,NULL,'2021-09-13 11:11:42','2021-09-13 11:11:42');
/*!40000 ALTER TABLE `res_tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (25,2),(26,2),(48,2),(49,2),(50,2),(51,2),(80,2),(6,3),(81,3);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) unsigned NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_service_staff` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roles_business_id_foreign` (`business_id`),
  CONSTRAINT `roles_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `name`, `guard_name`, `business_id`, `is_default`, `is_service_staff`, `created_at`, `updated_at`) VALUES (1,'Admin#1','web',1,1,0,'2021-06-12 08:05:38','2021-06-12 08:05:38'),(2,'Cashier#1','web',1,0,0,'2021-06-12 08:05:38','2021-06-12 08:05:38'),(3,'Service Staff#1','web',1,0,1,'2021-09-13 11:10:23','2021-09-13 11:10:23');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sell_line_warranties`
--

DROP TABLE IF EXISTS `sell_line_warranties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sell_line_warranties` (
  `sell_line_id` int(11) NOT NULL,
  `warranty_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sell_line_warranties`
--

LOCK TABLES `sell_line_warranties` WRITE;
/*!40000 ALTER TABLE `sell_line_warranties` DISABLE KEYS */;
/*!40000 ALTER TABLE `sell_line_warranties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `selling_price_groups`
--

DROP TABLE IF EXISTS `selling_price_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `selling_price_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `business_id` int(10) unsigned NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `selling_price_groups_business_id_foreign` (`business_id`),
  CONSTRAINT `selling_price_groups_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `selling_price_groups`
--

LOCK TABLES `selling_price_groups` WRITE;
/*!40000 ALTER TABLE `selling_price_groups` DISABLE KEYS */;
INSERT INTO `selling_price_groups` (`id`, `name`, `description`, `business_id`, `is_active`, `deleted_at`, `created_at`, `updated_at`) VALUES (1,'B2C',NULL,1,1,NULL,'2021-06-21 07:52:13','2021-07-03 19:18:07');
/*!40000 ALTER TABLE `selling_price_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL,
  UNIQUE KEY `sessions_id_unique` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_adjustment_lines`
--

DROP TABLE IF EXISTS `stock_adjustment_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_adjustment_lines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `variation_id` int(10) unsigned NOT NULL,
  `quantity` decimal(22,4) NOT NULL,
  `unit_price` decimal(22,4) DEFAULT NULL COMMENT 'Last purchase unit price',
  `removed_purchase_line` int(11) DEFAULT NULL,
  `lot_no_line_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_adjustment_lines_product_id_foreign` (`product_id`),
  KEY `stock_adjustment_lines_variation_id_foreign` (`variation_id`),
  KEY `stock_adjustment_lines_transaction_id_index` (`transaction_id`),
  KEY `stock_adjustment_lines_lot_no_line_id_index` (`lot_no_line_id`),
  CONSTRAINT `stock_adjustment_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stock_adjustment_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stock_adjustment_lines_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_adjustment_lines`
--

LOCK TABLES `stock_adjustment_lines` WRITE;
/*!40000 ALTER TABLE `stock_adjustment_lines` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_adjustment_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_adjustments_temp`
--

DROP TABLE IF EXISTS `stock_adjustments_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_adjustments_temp` (
  `id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_adjustments_temp`
--

LOCK TABLES `stock_adjustments_temp` WRITE;
/*!40000 ALTER TABLE `stock_adjustments_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_adjustments_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `package_id` int(10) unsigned NOT NULL,
  `start_date` date DEFAULT NULL,
  `trial_end_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `package_price` decimal(22,4) NOT NULL,
  `package_details` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_id` int(10) unsigned NOT NULL,
  `paid_via` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_transaction_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('approved','waiting','declined') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'waiting',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscriptions_business_id_foreign` (`business_id`),
  KEY `subscriptions_package_id_index` (`package_id`),
  KEY `subscriptions_created_id_index` (`created_id`),
  CONSTRAINT `subscriptions_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
INSERT INTO `subscriptions` (`id`, `business_id`, `package_id`, `start_date`, `trial_end_date`, `end_date`, `package_price`, `package_details`, `created_id`, `paid_via`, `payment_transaction_id`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES (1,1,1,'2021-09-25','2386-09-25','2386-09-25',0.0000,'{\"location_count\":0,\"user_count\":0,\"product_count\":0,\"invoice_count\":0,\"name\":\"Pack 1\",\"essentials_module\":\"1\",\"woocommerce_module\":\"1\"}',1,NULL,'FREE','approved',NULL,'2021-09-25 13:16:41','2021-09-25 13:16:41');
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `superadmin_communicator_logs`
--

DROP TABLE IF EXISTS `superadmin_communicator_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `superadmin_communicator_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_ids` text COLLATE utf8mb4_unicode_ci,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `superadmin_communicator_logs`
--

LOCK TABLES `superadmin_communicator_logs` WRITE;
/*!40000 ALTER TABLE `superadmin_communicator_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `superadmin_communicator_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `superadmin_frontend_pages`
--

DROP TABLE IF EXISTS `superadmin_frontend_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `superadmin_frontend_pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_shown` tinyint(1) NOT NULL,
  `menu_order` int(11) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `superadmin_frontend_pages`
--

LOCK TABLES `superadmin_frontend_pages` WRITE;
/*!40000 ALTER TABLE `superadmin_frontend_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `superadmin_frontend_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system`
--

DROP TABLE IF EXISTS `system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system`
--

LOCK TABLES `system` WRITE;
/*!40000 ALTER TABLE `system` DISABLE KEYS */;
INSERT INTO `system` (`id`, `key`, `value`) VALUES (1,'db_version','4.3'),(2,'default_business_active_status','1'),(5,'woocommerce_version','2.7'),(6,'essentials_version','2.3'),(7,'superadmin_version','2.7'),(8,'app_currency_id','2'),(9,'invoice_business_name','Medigrowmart POS'),(10,'invoice_business_landmark','Landmark'),(11,'invoice_business_zip','Zip'),(12,'invoice_business_state','State'),(13,'invoice_business_city','City'),(14,'invoice_business_country','Country'),(15,'email','superadmin@example.com'),(16,'package_expiry_alert_days','5'),(17,'enable_business_based_username','0'),(18,'superadmin_register_tc',NULL),(19,'welcome_email_subject',NULL),(20,'welcome_email_body',NULL),(21,'additional_js',NULL),(22,'additional_css',NULL),(23,'offline_payment_details',NULL),(24,'superadmin_enable_register_tc','0'),(25,'allow_email_settings_to_businesses','0'),(26,'enable_new_business_registration_notification','0'),(27,'enable_new_subscription_notification','0'),(28,'enable_welcome_email','0'),(29,'enable_offline_payment','0');
/*!40000 ALTER TABLE `system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_rates`
--

DROP TABLE IF EXISTS `tax_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double(22,4) NOT NULL,
  `is_tax_group` tinyint(1) NOT NULL DEFAULT '0',
  `for_tax_group` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int(10) unsigned NOT NULL,
  `woocommerce_tax_rate_id` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tax_rates_business_id_foreign` (`business_id`),
  KEY `tax_rates_created_by_foreign` (`created_by`),
  KEY `tax_rates_woocommerce_tax_rate_id_index` (`woocommerce_tax_rate_id`),
  CONSTRAINT `tax_rates_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tax_rates_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_rates`
--

LOCK TABLES `tax_rates` WRITE;
/*!40000 ALTER TABLE `tax_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_payments`
--

DROP TABLE IF EXISTS `transaction_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int(11) unsigned DEFAULT NULL,
  `business_id` int(11) DEFAULT NULL,
  `is_return` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Used during sales to return the change',
  `amount` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_transaction_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_holder_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_security` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cheque_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_on` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `is_advance` tinyint(1) NOT NULL DEFAULT '0',
  `payment_for` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_ref_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_payments_transaction_id_foreign` (`transaction_id`),
  KEY `transaction_payments_created_by_index` (`created_by`),
  KEY `transaction_payments_parent_id_index` (`parent_id`),
  CONSTRAINT `transaction_payments_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_payments`
--

LOCK TABLES `transaction_payments` WRITE;
/*!40000 ALTER TABLE `transaction_payments` DISABLE KEYS */;
INSERT INTO `transaction_payments` (`id`, `transaction_id`, `business_id`, `is_return`, `amount`, `method`, `transaction_no`, `card_transaction_number`, `card_number`, `card_type`, `card_holder_name`, `card_month`, `card_year`, `card_security`, `cheque_number`, `bank_account_number`, `paid_on`, `created_by`, `is_advance`, `payment_for`, `parent_id`, `note`, `document`, `payment_ref_no`, `account_id`, `created_at`, `updated_at`) VALUES (1,54,1,0,28.0000,'cash',NULL,NULL,NULL,'credit',NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-16 13:48:27',1,0,10,NULL,NULL,NULL,'SP2021/0039',NULL,'2021-11-16 08:18:27','2021-11-16 08:18:27');
/*!40000 ALTER TABLE `transaction_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_sell_lines`
--

DROP TABLE IF EXISTS `transaction_sell_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_sell_lines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `variation_id` int(10) unsigned NOT NULL,
  `quantity` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `quantity_returned` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `unit_price_before_discount` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `unit_price` decimal(22,4) DEFAULT NULL COMMENT 'Sell price excluding tax',
  `line_discount_type` enum('fixed','percentage') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_discount_amount` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `unit_price_inc_tax` decimal(22,4) DEFAULT NULL COMMENT 'Sell price including tax',
  `item_tax` decimal(22,4) NOT NULL COMMENT 'Tax for one quantity',
  `tax_id` int(10) unsigned DEFAULT NULL,
  `discount_id` int(11) DEFAULT NULL,
  `lot_no_line_id` int(11) DEFAULT NULL,
  `sell_line_note` text COLLATE utf8mb4_unicode_ci,
  `woocommerce_line_items_id` int(11) DEFAULT NULL,
  `so_line_id` int(11) DEFAULT NULL,
  `so_quantity_invoiced` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `res_service_staff_id` int(11) DEFAULT NULL,
  `res_line_order_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_sell_line_id` int(11) DEFAULT NULL,
  `children_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Type of children for the parent, like modifier or combo',
  `sub_unit_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_sell_lines_transaction_id_foreign` (`transaction_id`),
  KEY `transaction_sell_lines_product_id_foreign` (`product_id`),
  KEY `transaction_sell_lines_variation_id_foreign` (`variation_id`),
  KEY `transaction_sell_lines_tax_id_foreign` (`tax_id`),
  KEY `transaction_sell_lines_children_type_index` (`children_type`),
  KEY `transaction_sell_lines_parent_sell_line_id_index` (`parent_sell_line_id`),
  KEY `transaction_sell_lines_line_discount_type_index` (`line_discount_type`),
  KEY `transaction_sell_lines_discount_id_index` (`discount_id`),
  KEY `transaction_sell_lines_lot_no_line_id_index` (`lot_no_line_id`),
  KEY `transaction_sell_lines_sub_unit_id_index` (`sub_unit_id`),
  KEY `transaction_sell_lines_woocommerce_line_items_id_index` (`woocommerce_line_items_id`),
  CONSTRAINT `transaction_sell_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transaction_sell_lines_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transaction_sell_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transaction_sell_lines_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_sell_lines`
--

LOCK TABLES `transaction_sell_lines` WRITE;
/*!40000 ALTER TABLE `transaction_sell_lines` DISABLE KEYS */;
INSERT INTO `transaction_sell_lines` (`id`, `transaction_id`, `product_id`, `variation_id`, `quantity`, `quantity_returned`, `unit_price_before_discount`, `unit_price`, `line_discount_type`, `line_discount_amount`, `unit_price_inc_tax`, `item_tax`, `tax_id`, `discount_id`, `lot_no_line_id`, `sell_line_note`, `woocommerce_line_items_id`, `so_line_id`, `so_quantity_invoiced`, `res_service_staff_id`, `res_line_order_status`, `parent_sell_line_id`, `children_type`, `sub_unit_id`, `created_at`, `updated_at`) VALUES (1,54,53,53,2.0000,0.0000,13.7500,13.7500,'fixed',0.0000,13.7500,0.0000,NULL,NULL,NULL,'',NULL,NULL,0.0000,NULL,NULL,NULL,'',NULL,'2021-11-16 08:18:27','2021-11-16 08:18:27');
/*!40000 ALTER TABLE `transaction_sell_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_sell_lines_purchase_lines`
--

DROP TABLE IF EXISTS `transaction_sell_lines_purchase_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_sell_lines_purchase_lines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sell_line_id` int(10) unsigned DEFAULT NULL COMMENT 'id from transaction_sell_lines',
  `stock_adjustment_line_id` int(10) unsigned DEFAULT NULL COMMENT 'id from stock_adjustment_lines',
  `purchase_line_id` int(10) unsigned NOT NULL COMMENT 'id from purchase_lines',
  `quantity` decimal(22,4) NOT NULL,
  `qty_returned` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sell_line_id` (`sell_line_id`),
  KEY `stock_adjustment_line_id` (`stock_adjustment_line_id`),
  KEY `purchase_line_id` (`purchase_line_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_sell_lines_purchase_lines`
--

LOCK TABLES `transaction_sell_lines_purchase_lines` WRITE;
/*!40000 ALTER TABLE `transaction_sell_lines_purchase_lines` DISABLE KEYS */;
INSERT INTO `transaction_sell_lines_purchase_lines` (`id`, `sell_line_id`, `stock_adjustment_line_id`, `purchase_line_id`, `quantity`, `qty_returned`, `created_at`, `updated_at`) VALUES (1,1,NULL,53,2.0000,0.0000,'2021-11-16 08:18:27','2021-11-16 08:18:27');
/*!40000 ALTER TABLE `transaction_sell_lines_purchase_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned DEFAULT NULL,
  `res_table_id` int(10) unsigned DEFAULT NULL COMMENT 'fields to restaurant module',
  `res_waiter_id` int(10) unsigned DEFAULT NULL COMMENT 'fields to restaurant module',
  `res_order_status` enum('received','cooked','served') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_quotation` tinyint(1) NOT NULL DEFAULT '0',
  `payment_status` enum('paid','due','partial') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adjustment_type` enum('normal','abnormal') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` int(11) unsigned DEFAULT NULL,
  `customer_group_id` int(11) DEFAULT NULL COMMENT 'used to add customer group while selling',
  `invoice_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ref_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_repeat_on` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` datetime NOT NULL,
  `total_before_tax` decimal(22,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total before the purchase/invoice tax, this includeds the indivisual product tax',
  `tax_id` int(10) unsigned DEFAULT NULL,
  `tax_amount` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `discount_type` enum('fixed','percentage') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_amount` decimal(22,4) DEFAULT '0.0000',
  `rp_redeemed` int(11) NOT NULL DEFAULT '0' COMMENT 'rp is the short form of reward points',
  `rp_redeemed_amount` decimal(22,4) NOT NULL DEFAULT '0.0000' COMMENT 'rp is the short form of reward points',
  `shipping_details` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address` text COLLATE utf8mb4_unicode_ci,
  `shipping_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivered_to` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_charges` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `shipping_custom_field_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_custom_field_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_custom_field_3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_custom_field_4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_custom_field_5` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_notes` text COLLATE utf8mb4_unicode_ci,
  `staff_note` text COLLATE utf8mb4_unicode_ci,
  `is_export` tinyint(1) NOT NULL DEFAULT '0',
  `export_custom_fields_info` longtext COLLATE utf8mb4_unicode_ci,
  `round_off_amount` decimal(22,4) NOT NULL DEFAULT '0.0000' COMMENT 'Difference of rounded total and actual total',
  `final_total` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `expense_category_id` int(10) unsigned DEFAULT NULL,
  `expense_for` int(10) unsigned DEFAULT NULL,
  `commission_agent` int(11) DEFAULT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_direct_sale` tinyint(1) NOT NULL DEFAULT '0',
  `is_suspend` tinyint(1) NOT NULL DEFAULT '0',
  `exchange_rate` decimal(20,3) NOT NULL DEFAULT '1.000',
  `total_amount_recovered` decimal(22,4) DEFAULT NULL COMMENT 'Used for stock adjustment.',
  `transfer_parent_id` int(11) DEFAULT NULL,
  `return_parent_id` int(11) DEFAULT NULL,
  `opening_stock_product_id` int(11) DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `essentials_duration` decimal(8,2) NOT NULL,
  `essentials_duration_unit` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `essentials_amount_per_unit_duration` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `essentials_allowances` text COLLATE utf8mb4_unicode_ci,
  `essentials_deductions` text COLLATE utf8mb4_unicode_ci,
  `woocommerce_order_id` int(11) DEFAULT NULL,
  `prefer_payment_method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prefer_payment_account` int(11) DEFAULT NULL,
  `sales_order_ids` text COLLATE utf8mb4_unicode_ci,
  `purchase_order_ids` text COLLATE utf8mb4_unicode_ci,
  `custom_field_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `import_batch` int(11) DEFAULT NULL,
  `import_time` datetime DEFAULT NULL,
  `types_of_service_id` int(11) DEFAULT NULL,
  `packing_charge` decimal(22,4) DEFAULT NULL,
  `packing_charge_type` enum('fixed','percent') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_custom_field_1` text COLLATE utf8mb4_unicode_ci,
  `service_custom_field_2` text COLLATE utf8mb4_unicode_ci,
  `service_custom_field_3` text COLLATE utf8mb4_unicode_ci,
  `service_custom_field_4` text COLLATE utf8mb4_unicode_ci,
  `service_custom_field_5` text COLLATE utf8mb4_unicode_ci,
  `service_custom_field_6` text COLLATE utf8mb4_unicode_ci,
  `is_created_from_api` tinyint(1) NOT NULL DEFAULT '0',
  `rp_earned` int(11) NOT NULL DEFAULT '0' COMMENT 'rp is the short form of reward points',
  `order_addresses` text COLLATE utf8mb4_unicode_ci,
  `is_recurring` tinyint(1) NOT NULL DEFAULT '0',
  `recur_interval` double(22,4) DEFAULT NULL,
  `recur_interval_type` enum('days','months','years') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recur_repetitions` int(11) DEFAULT NULL,
  `recur_stopped_on` datetime DEFAULT NULL,
  `recur_parent_id` int(11) DEFAULT NULL,
  `invoice_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pay_term_number` int(11) DEFAULT NULL,
  `pay_term_type` enum('days','months') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selling_price_group_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transactions_tax_id_foreign` (`tax_id`),
  KEY `transactions_business_id_index` (`business_id`),
  KEY `transactions_type_index` (`type`),
  KEY `transactions_contact_id_index` (`contact_id`),
  KEY `transactions_transaction_date_index` (`transaction_date`),
  KEY `transactions_created_by_index` (`created_by`),
  KEY `transactions_location_id_index` (`location_id`),
  KEY `transactions_expense_for_foreign` (`expense_for`),
  KEY `transactions_expense_category_id_index` (`expense_category_id`),
  KEY `transactions_sub_type_index` (`sub_type`),
  KEY `transactions_return_parent_id_index` (`return_parent_id`),
  KEY `type` (`type`),
  KEY `transactions_status_index` (`status`),
  KEY `transactions_sub_status_index` (`sub_status`),
  KEY `transactions_res_table_id_index` (`res_table_id`),
  KEY `transactions_res_waiter_id_index` (`res_waiter_id`),
  KEY `transactions_res_order_status_index` (`res_order_status`),
  KEY `transactions_payment_status_index` (`payment_status`),
  KEY `transactions_discount_type_index` (`discount_type`),
  KEY `transactions_commission_agent_index` (`commission_agent`),
  KEY `transactions_transfer_parent_id_index` (`transfer_parent_id`),
  KEY `transactions_types_of_service_id_index` (`types_of_service_id`),
  KEY `transactions_packing_charge_type_index` (`packing_charge_type`),
  KEY `transactions_recur_parent_id_index` (`recur_parent_id`),
  KEY `transactions_selling_price_group_id_index` (`selling_price_group_id`),
  KEY `transactions_woocommerce_order_id_index` (`woocommerce_order_id`),
  CONSTRAINT `transactions_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_expense_category_id_foreign` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_expense_for_foreign` FOREIGN KEY (`expense_for`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `business_locations` (`id`),
  CONSTRAINT `transactions_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` (`id`, `business_id`, `location_id`, `res_table_id`, `res_waiter_id`, `res_order_status`, `type`, `sub_type`, `status`, `sub_status`, `is_quotation`, `payment_status`, `adjustment_type`, `contact_id`, `customer_group_id`, `invoice_no`, `ref_no`, `subscription_no`, `subscription_repeat_on`, `transaction_date`, `total_before_tax`, `tax_id`, `tax_amount`, `discount_type`, `discount_amount`, `rp_redeemed`, `rp_redeemed_amount`, `shipping_details`, `shipping_address`, `shipping_status`, `delivered_to`, `shipping_charges`, `shipping_custom_field_1`, `shipping_custom_field_2`, `shipping_custom_field_3`, `shipping_custom_field_4`, `shipping_custom_field_5`, `additional_notes`, `staff_note`, `is_export`, `export_custom_fields_info`, `round_off_amount`, `final_total`, `expense_category_id`, `expense_for`, `commission_agent`, `document`, `is_direct_sale`, `is_suspend`, `exchange_rate`, `total_amount_recovered`, `transfer_parent_id`, `return_parent_id`, `opening_stock_product_id`, `created_by`, `essentials_duration`, `essentials_duration_unit`, `essentials_amount_per_unit_duration`, `essentials_allowances`, `essentials_deductions`, `woocommerce_order_id`, `prefer_payment_method`, `prefer_payment_account`, `sales_order_ids`, `purchase_order_ids`, `custom_field_1`, `custom_field_2`, `custom_field_3`, `custom_field_4`, `import_batch`, `import_time`, `types_of_service_id`, `packing_charge`, `packing_charge_type`, `service_custom_field_1`, `service_custom_field_2`, `service_custom_field_3`, `service_custom_field_4`, `service_custom_field_5`, `service_custom_field_6`, `is_created_from_api`, `rp_earned`, `order_addresses`, `is_recurring`, `recur_interval`, `recur_interval_type`, `recur_repetitions`, `recur_stopped_on`, `recur_parent_id`, `invoice_token`, `pay_term_number`, `pay_term_type`, `selling_price_group_id`, `created_at`, `updated_at`) VALUES (1,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,1,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(2,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,2,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(3,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,3,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(4,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,4,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(5,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,5,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(6,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,6,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(7,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,7,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(8,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,8,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(9,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,9,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(10,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,10,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(11,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,11,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(12,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,12,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(13,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,13,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(14,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,14,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(15,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,15,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(16,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,16,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(17,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,17,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(18,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,18,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(19,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,19,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(20,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,20,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(21,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,21,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(22,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,22,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(23,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,23,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(24,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,24,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(25,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,25,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(26,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,26,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(27,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,27,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(28,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,28,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(29,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,29,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(30,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,30,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(31,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,31,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(32,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,32,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(33,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,33,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(34,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,34,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(35,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,35,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(36,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,36,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(37,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,37,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(38,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,38,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(39,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,39,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(40,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,40,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(41,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,41,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(42,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,42,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(43,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,43,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(44,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,44,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(45,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,45,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(46,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,46,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(47,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,47,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(48,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,48,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(49,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,49,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(50,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,50,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(51,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,51,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(52,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 23:18:23',10000.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,10000.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,52,5,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(53,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-01-01 13:09:12',390.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,390.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,53,1,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-11-16 07:39:12','2021-11-16 07:39:12'),(54,1,1,NULL,NULL,NULL,'sell',NULL,'final',NULL,0,'paid',NULL,10,NULL,'0042','',NULL,NULL,'2021-11-16 13:48:27',27.5000,NULL,0.0000,'percentage',0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.5000,28.0000,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,NULL,1,0.00,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,1.0000,'days',0,NULL,NULL,NULL,NULL,NULL,0,'2021-11-16 08:18:27','2021-11-16 08:18:27');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types_of_services`
--

DROP TABLE IF EXISTS `types_of_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `types_of_services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `business_id` int(11) NOT NULL,
  `location_price_group` text COLLATE utf8mb4_unicode_ci,
  `packing_charge` decimal(22,4) DEFAULT NULL,
  `packing_charge_type` enum('fixed','percent') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_custom_fields` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `types_of_services_business_id_index` (`business_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types_of_services`
--

LOCK TABLES `types_of_services` WRITE;
/*!40000 ALTER TABLE `types_of_services` DISABLE KEYS */;
INSERT INTO `types_of_services` (`id`, `name`, `description`, `business_id`, `location_price_group`, `packing_charge`, `packing_charge_type`, `enable_custom_fields`, `created_at`, `updated_at`) VALUES (1,'Dine In',NULL,1,'{\"1\":\"0\"}',0.0000,'fixed',0,'2021-09-13 11:05:20','2021-09-13 11:05:20'),(2,'Parcel',NULL,1,'{\"1\":\"0\"}',10.0000,'fixed',0,'2021-09-13 11:05:31','2021-09-13 11:05:31');
/*!40000 ALTER TABLE `types_of_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `units` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `actual_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `allow_decimal` tinyint(1) NOT NULL,
  `base_unit_id` int(11) DEFAULT NULL,
  `base_unit_multiplier` decimal(20,4) DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `units_business_id_foreign` (`business_id`),
  KEY `units_created_by_foreign` (`created_by`),
  KEY `units_base_unit_id_index` (`base_unit_id`),
  CONSTRAINT `units_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `units_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `units`
--

LOCK TABLES `units` WRITE;
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
INSERT INTO `units` (`id`, `business_id`, `actual_name`, `short_name`, `allow_decimal`, `base_unit_id`, `base_unit_multiplier`, `created_by`, `deleted_at`, `created_at`, `updated_at`) VALUES (1,1,'Piece','Pc(s)',1,NULL,NULL,1,NULL,'2021-06-12 08:05:38','2021-11-15 17:09:54'),(2,1,'Gram','G',1,NULL,NULL,1,NULL,'2021-06-21 07:56:17','2021-07-01 02:50:10'),(3,1,'Kilogram','KG',1,2,1000.0000,1,'2021-07-01 02:38:39','2021-06-21 07:58:07','2021-07-01 02:38:39'),(4,1,'Kilogram','KG',1,NULL,NULL,1,NULL,'2021-07-01 02:37:06','2021-07-03 19:04:08'),(5,1,'Chain','ch',0,NULL,NULL,1,NULL,'2021-07-11 02:58:46','2021-07-11 02:58:46');
/*!40000 ALTER TABLE `units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_contact_access`
--

DROP TABLE IF EXISTS `user_contact_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_contact_access` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_contact_access_user_id_index` (`user_id`),
  KEY `user_contact_access_contact_id_index` (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_contact_access`
--

LOCK TABLES `user_contact_access` WRITE;
/*!40000 ALTER TABLE `user_contact_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_contact_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `surname` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language` char(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `contact_no` char(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_id` int(10) unsigned DEFAULT NULL,
  `essentials_department_id` int(11) DEFAULT NULL,
  `essentials_designation_id` int(11) DEFAULT NULL,
  `max_sales_discount_percent` decimal(5,2) DEFAULT NULL,
  `allow_login` tinyint(1) NOT NULL DEFAULT '1',
  `status` enum('active','inactive','terminated') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `is_cmmsn_agnt` tinyint(1) NOT NULL DEFAULT '0',
  `cmmsn_percent` decimal(4,2) NOT NULL DEFAULT '0.00',
  `selected_contacts` tinyint(1) NOT NULL DEFAULT '0',
  `dob` date DEFAULT NULL,
  `gender` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marital_status` enum('married','unmarried','divorced') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blood_group` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` char(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alt_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `family_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fb_link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitter_link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `social_media_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `social_media_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permanent_address` text COLLATE utf8mb4_unicode_ci,
  `current_address` text COLLATE utf8mb4_unicode_ci,
  `guardian_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_details` longtext COLLATE utf8mb4_unicode_ci,
  `id_proof_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_proof_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  KEY `users_business_id_foreign` (`business_id`),
  KEY `users_user_type_index` (`user_type`),
  CONSTRAINT `users_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `user_type`, `surname`, `first_name`, `last_name`, `username`, `email`, `password`, `language`, `contact_no`, `address`, `remember_token`, `business_id`, `essentials_department_id`, `essentials_designation_id`, `max_sales_discount_percent`, `allow_login`, `status`, `is_cmmsn_agnt`, `cmmsn_percent`, `selected_contacts`, `dob`, `gender`, `marital_status`, `blood_group`, `contact_number`, `alt_number`, `family_number`, `fb_link`, `twitter_link`, `social_media_1`, `social_media_2`, `permanent_address`, `current_address`, `guardian_name`, `custom_field_1`, `custom_field_2`, `custom_field_3`, `custom_field_4`, `bank_details`, `id_proof_name`, `id_proof_number`, `deleted_at`, `created_at`, `updated_at`) VALUES (1,'user',NULL,'USCRIC POS','ADMIN','admin','admin@uscricketstore.com','$2y$10$H219G1jzBzmrXHgMFxsBQ.XG8sS18DMwW.0j.GLtovchT1zjAFPeG','en',NULL,NULL,'xGgkPuxuPhPjvx7vZOuSuqGP6MSpjv8n81KQXsch68UQXxhuQR1PWIDY1cYE',1,NULL,NULL,NULL,1,'active',0,0.00,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"account_holder_name\":null,\"account_number\":null,\"bank_name\":null,\"bank_code\":null,\"branch\":null,\"tax_payer_id\":null}',NULL,NULL,NULL,'2021-06-12 08:05:38','2021-11-16 04:01:58'),(2,'user','Mr','Suvamoy','Sarkar',NULL,'tiasbera@gmail.com',NULL,'en',NULL,NULL,NULL,1,NULL,NULL,NULL,0,'active',0,0.00,0,NULL,NULL,NULL,NULL,'+448622024378',NULL,NULL,NULL,NULL,NULL,NULL,'21/19 G.C Bose Sarani Konnagar Hooghly','21/19 G.C Bose Sarani Konnagar Hooghly',NULL,NULL,NULL,NULL,NULL,'{\"account_holder_name\":null,\"account_number\":null,\"bank_name\":null,\"bank_code\":null,\"branch\":null,\"tax_payer_id\":null}',NULL,NULL,'2021-11-13 13:57:13','2021-09-13 11:10:57','2021-11-13 13:57:13'),(3,'user','Test','Sourav','Dutta','Test1','s@gmail.com','$2y$10$35g9/3aJeUUGEFU/UdmWDugHKWOG2ZdIdBnVD/C.fDYBs8mcP4u1i','en',NULL,NULL,'okgMWqIbHWEFeOrpToq2l0klvq7j8vCiBYwP0HFqj7E3wRSA0YMzVS9YrKLn',1,NULL,NULL,NULL,1,'active',0,0.00,0,'1974-06-04','male','unmarried',NULL,'8240716064',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"account_holder_name\":\"Test1\",\"account_number\":\"12341234123\",\"bank_name\":\"Abc\",\"bank_code\":\"Abc0001405\",\"branch\":\"Kolkata\",\"tax_payer_id\":null}',NULL,NULL,NULL,'2021-09-14 09:13:30','2021-09-14 09:13:30'),(5,'user',NULL,'USCRIC','POS Admin','uscricketstore.ml','pos@uscricketstore.ml','$2y$10$wn04PIrXjC9J8LxPLZen5enUd0NWTk5kh4wSqGKNCdMSBr3jc8Ovq','en',NULL,NULL,'EUwWpI8J1LoWu2VxFr6Df8cMwDwOd0nYPYL6cHglqx7o45zXQz68nlIHabfl',1,NULL,NULL,NULL,1,'active',0,0.00,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"account_holder_name\":null,\"account_number\":null,\"bank_name\":null,\"bank_code\":null,\"branch\":null,\"tax_payer_id\":null}',NULL,NULL,NULL,'2021-11-08 15:55:47','2021-11-08 16:47:08');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variation_group_prices`
--

DROP TABLE IF EXISTS `variation_group_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variation_group_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variation_id` int(10) unsigned NOT NULL,
  `price_group_id` int(10) unsigned NOT NULL,
  `price_inc_tax` decimal(22,4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `variation_group_prices_variation_id_foreign` (`variation_id`),
  KEY `variation_group_prices_price_group_id_foreign` (`price_group_id`),
  CONSTRAINT `variation_group_prices_price_group_id_foreign` FOREIGN KEY (`price_group_id`) REFERENCES `selling_price_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `variation_group_prices_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variation_group_prices`
--

LOCK TABLES `variation_group_prices` WRITE;
/*!40000 ALTER TABLE `variation_group_prices` DISABLE KEYS */;
INSERT INTO `variation_group_prices` (`id`, `variation_id`, `price_group_id`, `price_inc_tax`, `created_at`, `updated_at`) VALUES (1,2850,1,0.0000,'2021-07-09 03:35:12','2021-07-09 03:35:12');
/*!40000 ALTER TABLE `variation_group_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variation_location_details`
--

DROP TABLE IF EXISTS `variation_location_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variation_location_details` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `product_variation_id` int(10) unsigned NOT NULL COMMENT 'id from product_variations table',
  `variation_id` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `qty_available` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `variation_location_details_location_id_foreign` (`location_id`),
  KEY `variation_location_details_product_id_index` (`product_id`),
  KEY `variation_location_details_product_variation_id_index` (`product_variation_id`),
  KEY `variation_location_details_variation_id_index` (`variation_id`),
  CONSTRAINT `variation_location_details_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `business_locations` (`id`),
  CONSTRAINT `variation_location_details_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variation_location_details`
--

LOCK TABLES `variation_location_details` WRITE;
/*!40000 ALTER TABLE `variation_location_details` DISABLE KEYS */;
INSERT INTO `variation_location_details` (`id`, `product_id`, `product_variation_id`, `variation_id`, `location_id`, `qty_available`, `created_at`, `updated_at`) VALUES (1,1,1,1,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(2,2,2,2,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(3,3,3,3,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(4,4,4,4,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(5,5,5,5,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(6,6,6,6,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(7,7,7,7,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(8,8,8,8,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(9,9,9,9,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(10,10,10,10,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(11,11,11,11,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(12,12,12,12,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(13,13,13,13,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(14,14,14,14,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(15,15,15,15,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(16,16,16,16,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(17,17,17,17,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(18,18,18,18,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(19,19,19,19,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(20,20,20,20,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(21,21,21,21,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(22,22,22,22,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(23,23,23,23,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(24,24,24,24,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(25,25,25,25,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(26,26,26,26,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(27,27,27,27,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(28,28,28,28,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(29,29,29,29,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(30,30,30,30,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(31,31,31,31,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(32,32,32,32,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(33,33,33,33,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(34,34,34,34,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(35,35,35,35,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(36,36,36,36,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(37,37,37,37,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(38,38,38,38,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(39,39,39,39,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(40,40,40,40,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(41,41,41,41,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(42,42,42,42,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(43,43,43,43,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(44,44,44,44,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(45,45,45,45,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(46,46,46,46,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(47,47,47,47,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(48,48,48,48,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(49,49,49,49,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(50,50,50,50,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(51,51,51,51,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(52,52,52,52,1,100.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23'),(53,53,53,53,1,8.0000,'2021-11-16 07:39:12','2021-11-16 08:18:27'),(54,53,53,54,1,10.0000,'2021-11-16 07:39:12','2021-11-16 07:39:12'),(55,53,53,55,1,10.0000,'2021-11-16 07:39:12','2021-11-16 07:39:12');
/*!40000 ALTER TABLE `variation_location_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variation_templates`
--

DROP TABLE IF EXISTS `variation_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variation_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) unsigned NOT NULL,
  `woocommerce_attr_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `variation_templates_business_id_foreign` (`business_id`),
  KEY `variation_templates_woocommerce_attr_id_index` (`woocommerce_attr_id`),
  CONSTRAINT `variation_templates_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variation_templates`
--

LOCK TABLES `variation_templates` WRITE;
/*!40000 ALTER TABLE `variation_templates` DISABLE KEYS */;
INSERT INTO `variation_templates` (`id`, `name`, `business_id`, `woocommerce_attr_id`, `created_at`, `updated_at`) VALUES (1,'Stock',1,NULL,'2021-07-10 16:36:50','2021-07-10 16:36:50'),(2,'Stock1',1,NULL,'2021-07-10 17:02:47','2021-07-10 17:02:47');
/*!40000 ALTER TABLE `variation_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variation_value_templates`
--

DROP TABLE IF EXISTS `variation_value_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variation_value_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `variation_template_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `variation_value_templates_name_index` (`name`),
  KEY `variation_value_templates_variation_template_id_index` (`variation_template_id`),
  CONSTRAINT `variation_value_templates_variation_template_id_foreign` FOREIGN KEY (`variation_template_id`) REFERENCES `variation_templates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variation_value_templates`
--

LOCK TABLES `variation_value_templates` WRITE;
/*!40000 ALTER TABLE `variation_value_templates` DISABLE KEYS */;
INSERT INTO `variation_value_templates` (`id`, `name`, `variation_template_id`, `created_at`, `updated_at`) VALUES (1,'1',1,'2021-07-10 16:36:51','2021-07-10 16:36:51'),(2,'2',1,'2021-07-10 16:36:51','2021-07-10 16:36:51'),(3,'3',1,'2021-07-10 16:43:17','2021-07-10 16:43:17'),(4,'1',2,'2021-07-10 17:02:47','2021-07-10 17:02:47');
/*!40000 ALTER TABLE `variation_value_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variations`
--

DROP TABLE IF EXISTS `variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `sub_sku` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_variation_id` int(10) unsigned NOT NULL,
  `woocommerce_variation_id` int(11) DEFAULT NULL,
  `variation_value_id` int(11) DEFAULT NULL,
  `default_purchase_price` decimal(22,4) DEFAULT NULL,
  `dpp_inc_tax` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `profit_percent` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `default_sell_price` decimal(22,4) DEFAULT NULL,
  `sell_price_inc_tax` decimal(22,4) DEFAULT NULL COMMENT 'Sell price including tax',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `combo_variations` text COLLATE utf8mb4_unicode_ci COMMENT 'Contains the combo variation details',
  PRIMARY KEY (`id`),
  KEY `variations_product_id_foreign` (`product_id`),
  KEY `variations_product_variation_id_foreign` (`product_variation_id`),
  KEY `variations_name_index` (`name`),
  KEY `variations_sub_sku_index` (`sub_sku`),
  KEY `variations_variation_value_id_index` (`variation_value_id`),
  KEY `variations_woocommerce_variation_id_index` (`woocommerce_variation_id`),
  CONSTRAINT `variations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `variations_product_variation_id_foreign` FOREIGN KEY (`product_variation_id`) REFERENCES `product_variations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variations`
--

LOCK TABLES `variations` WRITE;
/*!40000 ALTER TABLE `variations` DISABLE KEYS */;
INSERT INTO `variations` (`id`, `name`, `product_id`, `sub_sku`, `product_variation_id`, `woocommerce_variation_id`, `variation_value_id`, `default_purchase_price`, `dpp_inc_tax`, `profit_percent`, `default_sell_price`, `sell_price_inc_tax`, `created_at`, `updated_at`, `deleted_at`, `combo_variations`) VALUES (1,'DUMMY',1,'0001',1,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(2,'DUMMY',2,'0002',2,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(3,'DUMMY',3,'0003',3,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(4,'DUMMY',4,'0004',4,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(5,'DUMMY',5,'0005',5,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(6,'DUMMY',6,'0006',6,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(7,'DUMMY',7,'0007',7,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(8,'DUMMY',8,'0008',8,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(9,'DUMMY',9,'0009',9,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(10,'DUMMY',10,'0010',10,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(11,'DUMMY',11,'0011',11,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(12,'DUMMY',12,'0012',12,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(13,'DUMMY',13,'0013',13,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(14,'DUMMY',14,'0014',14,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(15,'DUMMY',15,'0015',15,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(16,'DUMMY',16,'0016',16,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(17,'DUMMY',17,'0017',17,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(18,'DUMMY',18,'0018',18,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(19,'DUMMY',19,'0019',19,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(20,'DUMMY',20,'0020',20,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(21,'DUMMY',21,'0021',21,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(22,'DUMMY',22,'0022',22,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(23,'DUMMY',23,'0023',23,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(24,'DUMMY',24,'0024',24,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(25,'DUMMY',25,'0025',25,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(26,'DUMMY',26,'0026',26,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(27,'DUMMY',27,'0027',27,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(28,'DUMMY',28,'0028',28,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(29,'DUMMY',29,'0029',29,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(30,'DUMMY',30,'0030',30,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(31,'DUMMY',31,'0031',31,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(32,'DUMMY',32,'0032',32,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(33,'DUMMY',33,'0033',33,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(34,'DUMMY',34,'0034',34,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(35,'DUMMY',35,'0035',35,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(36,'DUMMY',36,'0036',36,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(37,'DUMMY',37,'0037',37,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(38,'DUMMY',38,'0038',38,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(39,'DUMMY',39,'0039',39,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(40,'DUMMY',40,'0040',40,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(41,'DUMMY',41,'0041',41,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(42,'DUMMY',42,'0042',42,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(43,'DUMMY',43,'0043',43,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(44,'DUMMY',44,'0044',44,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(45,'DUMMY',45,'0045',45,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(46,'DUMMY',46,'0046',46,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(47,'DUMMY',47,'0047',47,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(48,'DUMMY',48,'0048',48,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(49,'DUMMY',49,'0049',49,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(50,'DUMMY',50,'0050',50,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(51,'DUMMY',51,'0051',51,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(52,'DUMMY',52,'0052',52,NULL,NULL,110.0000,100.0000,25.0000,120.0000,120.0000,'2021-11-15 17:48:23','2021-11-15 17:48:23',NULL,'[]'),(53,'1',53,'0053-1',53,NULL,1,11.0000,11.0000,25.0000,13.7500,13.7500,'2021-11-16 07:38:54','2021-11-16 08:13:50',NULL,NULL),(54,'2',53,'0053-2',53,NULL,2,13.0000,13.0000,25.0000,16.2500,16.2500,'2021-11-16 07:38:54','2021-11-16 08:13:50',NULL,NULL),(55,'3',53,'0053-3',53,NULL,3,14.0000,14.0000,25.0000,17.5000,17.5000,'2021-11-16 07:38:54','2021-11-16 08:13:50',NULL,NULL);
/*!40000 ALTER TABLE `variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warranties`
--

DROP TABLE IF EXISTS `warranties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warranties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(11) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `duration` int(11) NOT NULL,
  `duration_type` enum('days','months','years') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `warranties_business_id_index` (`business_id`),
  KEY `warranties_duration_type_index` (`duration_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warranties`
--

LOCK TABLES `warranties` WRITE;
/*!40000 ALTER TABLE `warranties` DISABLE KEYS */;
/*!40000 ALTER TABLE `warranties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `woocommerce_sync_logs`
--

DROP TABLE IF EXISTS `woocommerce_sync_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `woocommerce_sync_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL,
  `sync_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `operation_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci,
  `details` longtext COLLATE utf8mb4_unicode_ci,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=347 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `woocommerce_sync_logs`
--

LOCK TABLES `woocommerce_sync_logs` WRITE;
/*!40000 ALTER TABLE `woocommerce_sync_logs` DISABLE KEYS */;
INSERT INTO `woocommerce_sync_logs` (`id`, `business_id`, `sync_type`, `operation_type`, `data`, `details`, `created_by`, `created_at`, `updated_at`) VALUES (1,1,'categories',NULL,NULL,NULL,1,'2021-06-12 08:23:21','2021-06-12 08:23:21'),(2,1,'categories',NULL,NULL,NULL,1,'2021-06-12 08:23:26','2021-06-12 08:23:26'),(3,1,'all_products',NULL,NULL,NULL,1,'2021-06-12 08:23:26','2021-06-12 08:23:26'),(4,1,'categories',NULL,NULL,NULL,1,'2021-06-12 08:26:40','2021-06-12 08:26:40'),(5,1,'categories',NULL,NULL,NULL,1,'2021-06-12 08:28:23','2021-06-12 08:28:23'),(6,1,'categories',NULL,NULL,NULL,1,'2021-06-12 08:28:25','2021-06-12 08:28:25'),(7,1,'categories',NULL,NULL,NULL,1,'2021-06-12 13:56:28','2021-06-12 13:56:28'),(8,1,'categories',NULL,NULL,NULL,1,'2021-06-12 13:56:29','2021-06-12 13:56:29'),(9,1,'categories',NULL,NULL,NULL,1,'2021-06-12 13:56:31','2021-06-12 13:56:31'),(10,1,'categories',NULL,NULL,NULL,1,'2021-06-23 04:50:33','2021-06-23 04:50:33'),(11,1,'categories',NULL,NULL,NULL,1,'2021-06-23 04:50:40','2021-06-23 04:50:40'),(12,1,'categories',NULL,NULL,NULL,1,'2021-06-23 04:51:11','2021-06-23 04:51:11'),(13,1,'all_products','created','[\"123\"]',NULL,1,'2021-06-23 04:51:12','2021-06-23 04:51:12'),(14,1,'categories',NULL,NULL,NULL,1,'2021-06-23 04:52:31','2021-06-23 04:52:31'),(15,1,'orders',NULL,NULL,NULL,1,'2021-06-23 04:52:36','2021-06-23 04:52:36'),(16,1,'categories',NULL,NULL,NULL,1,'2021-06-23 04:54:02','2021-06-23 04:54:02'),(17,1,'categories',NULL,NULL,NULL,1,'2021-06-23 04:54:05','2021-06-23 04:54:05'),(18,1,'categories',NULL,NULL,NULL,1,'2021-06-23 04:55:46','2021-06-23 04:55:46'),(19,1,'categories',NULL,NULL,NULL,1,'2021-06-23 04:55:49','2021-06-23 04:55:49'),(20,1,'all_products','updated','[\"123\"]',NULL,1,'2021-06-23 04:55:50','2021-06-23 04:55:50'),(21,1,'categories',NULL,NULL,NULL,1,'2021-06-24 03:42:53','2021-06-24 03:42:53'),(22,1,'categories',NULL,NULL,NULL,1,'2021-06-24 03:43:05','2021-06-24 03:43:05'),(23,1,'categories',NULL,NULL,NULL,1,'2021-06-24 03:43:09','2021-06-24 03:43:09'),(24,1,'all_products',NULL,NULL,NULL,1,'2021-06-24 03:43:09','2021-06-24 03:43:09'),(25,1,'categories','reset',NULL,NULL,1,'2021-06-24 04:01:05','2021-06-24 04:01:05'),(26,1,'all_products','reset',NULL,NULL,1,'2021-06-24 04:01:10','2021-06-24 04:01:10'),(27,1,'categories',NULL,NULL,NULL,1,'2021-06-24 04:01:12','2021-06-24 04:01:12'),(28,1,'categories',NULL,NULL,NULL,1,'2021-06-24 04:01:16','2021-06-24 04:01:16'),(29,1,'all_products','created','[\"123\"]',NULL,1,'2021-06-24 04:01:16','2021-06-24 04:01:16'),(30,1,'categories','reset',NULL,NULL,1,'2021-06-24 04:07:47','2021-06-24 04:07:47'),(31,1,'all_products','reset',NULL,NULL,1,'2021-06-24 04:07:53','2021-06-24 04:07:53'),(32,1,'categories',NULL,NULL,NULL,1,'2021-06-24 04:07:57','2021-06-24 04:07:57'),(33,1,'categories',NULL,NULL,NULL,1,'2021-06-24 04:08:00','2021-06-24 04:08:00'),(34,1,'all_products','created','[\"123\"]',NULL,1,'2021-06-24 04:08:01','2021-06-24 04:08:01'),(35,1,'orders',NULL,NULL,NULL,1,'2021-06-24 04:08:05','2021-06-24 04:08:05'),(36,1,'categories',NULL,NULL,NULL,1,'2021-06-24 04:14:30','2021-06-24 04:14:30'),(40,1,'all_products','reset',NULL,NULL,1,'2021-06-24 04:14:43','2021-06-24 04:14:43'),(41,1,'categories','reset',NULL,NULL,1,'2021-06-24 04:14:49','2021-06-24 04:14:49'),(42,1,'categories',NULL,NULL,NULL,1,'2021-06-24 04:14:52','2021-06-24 04:14:52'),(45,1,'categories','reset',NULL,NULL,1,'2021-06-24 04:18:28','2021-06-24 04:18:28'),(46,1,'all_products','reset',NULL,NULL,1,'2021-06-24 04:18:33','2021-06-24 04:18:33'),(47,1,'categories',NULL,NULL,NULL,1,'2021-06-24 04:18:35','2021-06-24 04:18:35'),(49,1,'categories',NULL,NULL,NULL,1,'2021-06-24 04:20:11','2021-06-24 04:20:11'),(50,1,'categories',NULL,NULL,NULL,1,'2021-06-24 04:20:13','2021-06-24 04:20:13'),(51,1,'all_products','created','[\"123\"]',NULL,1,'2021-06-24 04:20:13','2021-06-24 04:20:13'),(52,1,'categories',NULL,NULL,NULL,1,'2021-06-24 04:20:18','2021-06-24 04:20:18'),(53,1,'new_products',NULL,NULL,NULL,1,'2021-06-24 04:20:18','2021-06-24 04:20:18'),(54,1,'categories',NULL,NULL,NULL,1,'2021-06-24 04:24:12','2021-06-24 04:24:12'),(55,1,'categories',NULL,NULL,NULL,1,'2021-06-24 04:24:14','2021-06-24 04:24:14'),(56,1,'all_products','updated','[\"123\"]',NULL,1,'2021-06-24 04:24:14','2021-06-24 04:24:14'),(57,1,'categories',NULL,NULL,NULL,1,'2021-06-27 02:51:08','2021-06-27 02:51:08'),(58,1,'categories',NULL,NULL,NULL,1,'2021-06-27 02:51:12','2021-06-27 02:51:12'),(59,1,'all_products','updated','[\"123\"]',NULL,1,'2021-06-27 02:51:12','2021-06-27 02:51:12'),(60,1,'categories',NULL,NULL,NULL,1,'2021-06-27 02:51:15','2021-06-27 02:51:15'),(61,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 02:51:15','2021-06-27 02:51:15'),(62,1,'categories',NULL,NULL,NULL,1,'2021-06-27 02:51:58','2021-06-27 02:51:58'),(63,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 02:51:58','2021-06-27 02:51:58'),(64,1,'categories',NULL,NULL,NULL,1,'2021-06-27 02:52:00','2021-06-27 02:52:00'),(65,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 02:52:00','2021-06-27 02:52:00'),(66,1,'categories',NULL,NULL,NULL,1,'2021-06-27 02:52:01','2021-06-27 02:52:01'),(67,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 02:52:01','2021-06-27 02:52:01'),(68,1,'categories',NULL,NULL,NULL,1,'2021-06-27 02:52:03','2021-06-27 02:52:03'),(69,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 02:52:03','2021-06-27 02:52:03'),(70,1,'categories',NULL,NULL,NULL,1,'2021-06-27 02:52:05','2021-06-27 02:52:05'),(71,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 02:52:05','2021-06-27 02:52:05'),(72,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:00:37','2021-06-27 03:00:37'),(73,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:00:37','2021-06-27 03:00:37'),(74,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:00:43','2021-06-27 03:00:43'),(75,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:00:43','2021-06-27 03:00:43'),(76,1,'orders',NULL,NULL,NULL,1,'2021-06-27 03:00:45','2021-06-27 03:00:45'),(77,1,'categories','reset',NULL,NULL,1,'2021-06-27 03:00:53','2021-06-27 03:00:53'),(78,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:00:54','2021-06-27 03:00:54'),(79,1,'categories','created','[\"DEF\"]',NULL,1,'2021-06-27 03:01:34','2021-06-27 03:01:34'),(80,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:01:34','2021-06-27 03:01:34'),(81,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:03:08','2021-06-27 03:03:08'),(82,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:03:08','2021-06-27 03:03:08'),(83,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:08:03','2021-06-27 03:08:03'),(84,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:08:03','2021-06-27 03:08:03'),(85,1,'orders',NULL,NULL,NULL,1,'2021-06-27 03:08:21','2021-06-27 03:08:21'),(86,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:11:17','2021-06-27 03:11:17'),(87,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:11:17','2021-06-27 03:11:17'),(88,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:16:40','2021-06-27 03:16:40'),(89,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:16:40','2021-06-27 03:16:40'),(90,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:16:42','2021-06-27 03:16:42'),(91,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:16:42','2021-06-27 03:16:42'),(92,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:16:53','2021-06-27 03:16:53'),(93,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 03:16:53','2021-06-27 03:16:53'),(94,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:17:16','2021-06-27 03:17:16'),(95,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 03:17:16','2021-06-27 03:17:16'),(96,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:17:18','2021-06-27 03:17:18'),(97,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:17:18','2021-06-27 03:17:18'),(98,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:17:20','2021-06-27 03:17:20'),(99,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:17:20','2021-06-27 03:17:20'),(100,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:17:21','2021-06-27 03:17:21'),(101,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:17:21','2021-06-27 03:17:21'),(102,1,'orders',NULL,NULL,NULL,1,'2021-06-27 03:17:24','2021-06-27 03:17:24'),(103,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:17:24','2021-06-27 03:17:24'),(104,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 03:17:24','2021-06-27 03:17:24'),(105,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:17:24','2021-06-27 03:17:24'),(106,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:17:24','2021-06-27 03:17:24'),(107,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:17:24','2021-06-27 03:17:24'),(108,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 03:17:24','2021-06-27 03:17:24'),(109,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:17:25','2021-06-27 03:17:25'),(110,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:17:25','2021-06-27 03:17:25'),(111,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:17:25','2021-06-27 03:17:25'),(112,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 03:17:25','2021-06-27 03:17:25'),(113,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:17:26','2021-06-27 03:17:26'),(114,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:17:26','2021-06-27 03:17:26'),(115,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:17:26','2021-06-27 03:17:26'),(116,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:17:26','2021-06-27 03:17:26'),(117,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:17:27','2021-06-27 03:17:27'),(118,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:17:27','2021-06-27 03:17:27'),(119,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:17:27','2021-06-27 03:17:27'),(120,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:17:27','2021-06-27 03:17:27'),(121,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:19:00','2021-06-27 03:19:00'),(122,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:19:00','2021-06-27 03:19:00'),(123,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:19:01','2021-06-27 03:19:01'),(124,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 03:19:01','2021-06-27 03:19:01'),(125,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:19:02','2021-06-27 03:19:02'),(126,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 03:19:02','2021-06-27 03:19:02'),(127,1,'categories',NULL,NULL,NULL,1,'2021-06-27 03:19:02','2021-06-27 03:19:02'),(128,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 03:19:02','2021-06-27 03:19:02'),(129,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:07:45','2021-06-27 04:07:45'),(130,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:07:45','2021-06-27 04:07:45'),(131,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:07:47','2021-06-27 04:07:47'),(132,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:07:47','2021-06-27 04:07:47'),(133,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:07:48','2021-06-27 04:07:48'),(134,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:07:48','2021-06-27 04:07:48'),(135,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:07:49','2021-06-27 04:07:49'),(136,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:07:49','2021-06-27 04:07:49'),(137,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:26:57','2021-06-27 04:26:57'),(138,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:26:57','2021-06-27 04:26:57'),(139,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:30:44','2021-06-27 04:30:44'),(140,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:30:44','2021-06-27 04:30:44'),(141,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:30:49','2021-06-27 04:30:49'),(142,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:30:49','2021-06-27 04:30:49'),(143,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:37:25','2021-06-27 04:37:25'),(144,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:37:27','2021-06-27 04:37:27'),(145,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:37:44','2021-06-27 04:37:44'),(146,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:37:44','2021-06-27 04:37:44'),(147,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:38:53','2021-06-27 04:38:53'),(148,1,'orders',NULL,NULL,NULL,1,'2021-06-27 04:39:15','2021-06-27 04:39:15'),(149,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:41:38','2021-06-27 04:41:38'),(150,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:41:44','2021-06-27 04:41:44'),(151,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:42:18','2021-06-27 04:42:18'),(152,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:42:19','2021-06-27 04:42:19'),(153,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:42:19','2021-06-27 04:42:19'),(154,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:42:21','2021-06-27 04:42:21'),(155,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:42:21','2021-06-27 04:42:21'),(156,1,'orders',NULL,NULL,NULL,1,'2021-06-27 04:42:23','2021-06-27 04:42:23'),(157,1,'categories','reset',NULL,NULL,1,'2021-06-27 04:44:16','2021-06-27 04:44:16'),(158,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:44:17','2021-06-27 04:44:17'),(159,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:46:07','2021-06-27 04:46:07'),(160,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:46:09','2021-06-27 04:46:09'),(161,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:26','2021-06-27 04:47:26'),(162,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:38','2021-06-27 04:47:38'),(163,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:47:38','2021-06-27 04:47:38'),(164,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:39','2021-06-27 04:47:39'),(165,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:47:39','2021-06-27 04:47:39'),(166,1,'orders',NULL,NULL,NULL,1,'2021-06-27 04:47:41','2021-06-27 04:47:41'),(167,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:41','2021-06-27 04:47:41'),(168,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:42','2021-06-27 04:47:42'),(169,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:47:42','2021-06-27 04:47:42'),(170,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:42','2021-06-27 04:47:42'),(171,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:47:42','2021-06-27 04:47:42'),(172,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:43','2021-06-27 04:47:43'),(173,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:47:43','2021-06-27 04:47:43'),(174,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:44','2021-06-27 04:47:44'),(175,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:47:44','2021-06-27 04:47:44'),(176,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:44','2021-06-27 04:47:44'),(177,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:47:44','2021-06-27 04:47:44'),(178,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:44','2021-06-27 04:47:44'),(179,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:47:44','2021-06-27 04:47:44'),(180,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:45','2021-06-27 04:47:45'),(181,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:47:45','2021-06-27 04:47:45'),(182,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:45','2021-06-27 04:47:45'),(183,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:47:45','2021-06-27 04:47:45'),(184,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:45','2021-06-27 04:47:45'),(185,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:47:46','2021-06-27 04:47:46'),(186,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:46','2021-06-27 04:47:46'),(187,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:47','2021-06-27 04:47:47'),(188,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:47','2021-06-27 04:47:47'),(189,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:47:48','2021-06-27 04:47:48'),(190,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:48:47','2021-06-27 04:48:47'),(191,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:48:47','2021-06-27 04:48:47'),(192,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:48:47','2021-06-27 04:48:47'),(193,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:48:47','2021-06-27 04:48:47'),(194,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:48:47','2021-06-27 04:48:47'),(195,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:48:48','2021-06-27 04:48:48'),(196,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:48:48','2021-06-27 04:48:48'),(197,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:48:48','2021-06-27 04:48:48'),(198,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:48:49','2021-06-27 04:48:49'),(199,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:48:59','2021-06-27 04:48:59'),(200,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:48:59','2021-06-27 04:48:59'),(201,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:48:59','2021-06-27 04:48:59'),(202,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:49:00','2021-06-27 04:49:00'),(203,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:49:00','2021-06-27 04:49:00'),(204,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:54:26','2021-06-27 04:54:26'),(205,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:54:40','2021-06-27 04:54:40'),(206,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:54:40','2021-06-27 04:54:40'),(207,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:54:41','2021-06-27 04:54:41'),(208,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:54:41','2021-06-27 04:54:41'),(209,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:54:42','2021-06-27 04:54:42'),(210,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:54:42','2021-06-27 04:54:42'),(211,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:54:42','2021-06-27 04:54:42'),(212,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:54:42','2021-06-27 04:54:42'),(213,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:54:43','2021-06-27 04:54:43'),(214,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:54:43','2021-06-27 04:54:43'),(215,1,'orders',NULL,NULL,NULL,1,'2021-06-27 04:54:44','2021-06-27 04:54:44'),(216,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:55:31','2021-06-27 04:55:31'),(217,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:55:35','2021-06-27 04:55:35'),(218,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:55:35','2021-06-27 04:55:35'),(219,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:55:35','2021-06-27 04:55:35'),(220,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:55:35','2021-06-27 04:55:35'),(221,1,'orders',NULL,NULL,NULL,1,'2021-06-27 04:55:36','2021-06-27 04:55:36'),(222,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:59:45','2021-06-27 04:59:45'),(223,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:59:47','2021-06-27 04:59:47'),(224,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:59:47','2021-06-27 04:59:47'),(225,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:59:48','2021-06-27 04:59:48'),(226,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 04:59:48','2021-06-27 04:59:48'),(227,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:59:48','2021-06-27 04:59:48'),(228,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 04:59:48','2021-06-27 04:59:48'),(229,1,'categories',NULL,NULL,NULL,1,'2021-06-27 04:59:49','2021-06-27 04:59:49'),(230,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:04:28','2021-06-27 05:04:28'),(231,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:04:29','2021-06-27 05:04:29'),(232,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 05:04:29','2021-06-27 05:04:29'),(233,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:04:29','2021-06-27 05:04:29'),(234,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 05:04:29','2021-06-27 05:04:29'),(235,1,'orders',NULL,NULL,NULL,1,'2021-06-27 05:04:30','2021-06-27 05:04:30'),(236,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:10:05','2021-06-27 05:10:05'),(237,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 05:10:05','2021-06-27 05:10:05'),(238,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:10:05','2021-06-27 05:10:05'),(239,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 05:10:05','2021-06-27 05:10:05'),(240,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:10:06','2021-06-27 05:10:06'),(241,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:10:09','2021-06-27 05:10:09'),(242,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:10:11','2021-06-27 05:10:11'),(243,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:10:19','2021-06-27 05:10:19'),(244,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 05:10:19','2021-06-27 05:10:19'),(245,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:10:20','2021-06-27 05:10:20'),(246,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 05:10:20','2021-06-27 05:10:20'),(247,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:11:32','2021-06-27 05:11:32'),(248,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 05:11:32','2021-06-27 05:11:32'),(249,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:11:32','2021-06-27 05:11:32'),(250,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 05:11:32','2021-06-27 05:11:32'),(251,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:11:33','2021-06-27 05:11:33'),(252,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:11:34','2021-06-27 05:11:34'),(253,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:11:35','2021-06-27 05:11:35'),(254,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:22:26','2021-06-27 05:22:26'),(255,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:22:49','2021-06-27 05:22:49'),(256,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:25:07','2021-06-27 05:25:07'),(257,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:25:15','2021-06-27 05:25:15'),(258,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 05:25:15','2021-06-27 05:25:15'),(259,1,'orders',NULL,NULL,NULL,1,'2021-06-27 05:25:17','2021-06-27 05:25:17'),(264,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:27:31','2021-06-27 05:27:31'),(268,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:28:02','2021-06-27 05:28:02'),(269,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:28:21','2021-06-27 05:28:21'),(270,1,'new_products',NULL,NULL,NULL,1,'2021-06-27 05:28:21','2021-06-27 05:28:21'),(271,1,'categories',NULL,NULL,NULL,1,'2021-06-27 05:28:22','2021-06-27 05:28:22'),(272,1,'all_products',NULL,NULL,NULL,1,'2021-06-27 05:28:22','2021-06-27 05:28:22'),(273,1,'categories',NULL,NULL,NULL,1,'2021-07-01 00:52:52','2021-07-01 00:52:52'),(274,1,'categories',NULL,NULL,NULL,1,'2021-07-01 00:55:14','2021-07-01 00:55:14'),(275,1,'categories',NULL,NULL,NULL,1,'2021-07-01 00:55:18','2021-07-01 00:55:18'),(276,1,'categories',NULL,NULL,NULL,1,'2021-07-01 01:18:29','2021-07-01 01:18:29'),(277,1,'orders',NULL,NULL,NULL,1,'2021-07-01 01:19:37','2021-07-01 01:19:37'),(278,1,'categories',NULL,NULL,NULL,1,'2021-07-01 01:37:50','2021-07-01 01:37:50'),(279,1,'categories',NULL,NULL,NULL,1,'2021-07-01 01:37:53','2021-07-01 01:37:53'),(280,1,'new_products',NULL,NULL,NULL,1,'2021-07-01 01:37:53','2021-07-01 01:37:53'),(281,1,'orders','created','[\"10516\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10516\",\"product\":\"Aman Atta(loose) SKU:\"}',1,'2021-07-01 02:34:20','2021-07-01 02:34:20'),(282,1,'orders','created','[\"10517\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10517\",\"product\":\"Close up 150g SKU:\"}',1,'2021-07-01 03:56:33','2021-07-01 03:56:33'),(283,1,'orders','created','[\"10519\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10519\",\"product\":\"Red Label 250g SKU:\"}',1,'2021-07-01 04:04:34','2021-07-01 04:04:34'),(284,1,'orders','created','[\"10521\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10521\",\"product\":\"Cookme Redchilli powder(50g) SKU:\"}',1,'2021-07-01 04:06:37','2021-07-01 04:06:37'),(285,1,'orders','created','[\"10523\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10523\",\"product\":\"Saffola Oats classic Rs.15 SKU:513594\"}',1,'2021-07-01 04:31:34','2021-07-01 04:31:34'),(286,1,'orders','created','[\"10525\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10525\",\"product\":\"Bengal Black Pheneol SKU:\"}',1,'2021-07-01 04:41:33','2021-07-01 04:41:33'),(287,1,'orders','created','[\"10527\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10527\",\"product\":\"Cornflour 500g(pouch) SKU:1622\"}',1,'2021-07-01 04:46:13','2021-07-01 04:46:13'),(288,1,'orders','created','[\"10531\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10531\",\"product\":\"Happy Night(mosquito killer) SKU:48247\"}',1,'2021-07-01 04:51:01','2021-07-01 04:51:01'),(289,1,'orders','created','[\"10533\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10533\",\"product\":\"Everest kasuri methi 50 gm SKU:\"}',1,'2021-07-01 05:03:36','2021-07-01 05:03:36'),(290,1,'orders','created','[\"10535\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10535\",\"product\":\"Horlicks 1kg pouch SKU:\"}',1,'2021-07-01 05:08:32','2021-07-01 05:08:32'),(291,1,'orders','created','[\"10537\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10537\",\"product\":\"Britania Thin 400Gm SKU:\"}',1,'2021-07-01 05:14:50','2021-07-01 05:14:50'),(292,1,'orders','created','[\"10539\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10539\",\"product\":\"Colgate Strong teeth 44g SKU:\"}',1,'2021-07-01 05:24:57','2021-07-01 05:24:57'),(293,1,'orders','created','[\"10541\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10541\",\"product\":\"Sparkel Diswash tub SKU:\"}',1,'2021-07-01 05:26:32','2021-07-01 05:26:32'),(294,1,'orders','created','[\"10544\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10544\",\"product\":\"Safed 1Kg SKU:9678819\"}',1,'2021-07-01 05:34:32','2021-07-01 05:34:32'),(295,1,'orders','created','[\"10546\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10546\",\"product\":\"Sparkel Dishwash pad SKU:\"}',1,'2021-07-01 05:40:04','2021-07-01 05:40:04'),(296,1,'orders','created','[\"10550\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10550\",\"product\":\"Colgate Cibaca Vedshakti 160g SKU:\"}',1,'2021-07-01 05:40:16','2021-07-01 05:40:16'),(297,1,'orders','created','[\"10552\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10552\",\"product\":\"Loose Postodana\\/khus khus\\/poppy seed SKU:\"}',1,'2021-07-01 05:49:53','2021-07-01 05:49:53'),(298,1,'orders','created','[\"10556\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10556\",\"product\":\"Uttam coconut oil 100ml SKU:\"}',1,'2021-07-01 06:09:07','2021-07-01 06:09:07'),(299,1,'orders','created','[\"10558\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10558\",\"product\":\"Tazza Tea 100g SKU:\"}',1,'2021-07-01 06:25:42','2021-07-01 06:25:42'),(300,1,'orders','created','[\"10562\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10562\",\"product\":\"Everest Jafran\\/Kesar(0.5g) SKU:4825827\"}',1,'2021-07-01 06:50:38','2021-07-01 06:50:38'),(301,1,'orders','created','[\"10565\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10565\",\"product\":\"All Out Liquid(set of 2) SKU:577233\"}',1,'2021-07-01 06:56:14','2021-07-01 06:56:14'),(302,1,'orders','created','[\"10568\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10568\",\"product\":\"Kishmis\\/Raisins SKU:2578343\"}',1,'2021-07-01 07:10:34','2021-07-01 07:10:34'),(303,1,'orders','created','[\"10570\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10570\",\"product\":\"Prill155ml Rs.20 SKU:42865\"}',1,'2021-07-01 07:46:38','2021-07-01 07:46:38'),(304,1,'orders','created','[\"10572\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10572\",\"product\":\"Pulse Jar(170p jar) SKU:4224658\"}',1,'2021-07-01 08:01:32','2021-07-01 08:01:32'),(305,1,'orders','created','[\"10577\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10577\",\"product\":\"Godrej RichCream 20g(black) SKU:\"}',1,'2021-07-01 18:43:51','2021-07-01 18:43:51'),(306,1,'orders','created','[\"10588\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10588\",\"product\":\"BIskFarm GOOGLY 200g SKU:\"}',1,'2021-07-02 06:25:00','2021-07-02 06:25:00'),(307,1,'orders','created','[\"10590\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10590\",\"product\":\"Maggi Rs.5(12pc) SKU:\"}',1,'2021-07-02 06:31:14','2021-07-02 06:31:14'),(308,1,'orders','created','[\"10594\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10594\",\"product\":\"Jharna Ghee 250g SKU:\"}',1,'2021-07-02 07:04:34','2021-07-02 07:04:34'),(309,1,'orders','created','[\"10596\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10596\",\"product\":\"Fruit Cocktail 850g SKU:6168\"}',1,'2021-07-02 07:21:21','2021-07-02 07:21:21'),(310,1,'orders','created','[\"10598\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10598\",\"product\":\"Nippo hyper(Blue) SKU:\"}',1,'2021-07-02 07:22:25','2021-07-02 07:22:25'),(311,1,'orders','created','[\"10600\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10600\",\"product\":\"Sunrise Musterd\\/sarso powder 40g SKU:\"}',1,'2021-07-02 07:48:35','2021-07-02 07:48:35'),(312,1,'orders','created','[\"10602\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10602\",\"product\":\"Dove Soap 28g SKU:\"}',1,'2021-07-02 08:06:34','2021-07-02 08:06:34'),(313,1,'orders','created','[\"10604\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10604\",\"product\":\"Britania Thin 400Gm SKU:\"}',1,'2021-07-02 08:18:12','2021-07-02 08:18:12'),(314,1,'orders','created','[\"10606\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10606\",\"product\":\"Everest kasuri methi 50 gm SKU:\"}',1,'2021-07-02 08:26:34','2021-07-02 08:26:34'),(315,1,'orders','created','[\"10608\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10608\",\"product\":\"ClinicPlus EggProtin SKU:\"}',1,'2021-07-02 08:27:34','2021-07-02 08:27:34'),(316,1,'orders','created','[\"10610\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10610\",\"product\":\"Ganesh Atta 1kg SKU:\"}',1,'2021-07-02 08:31:58','2021-07-02 08:31:58'),(317,1,'orders','created','[\"10612\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10612\",\"product\":\"Loose Matar Besan SKU:72142\"}',1,'2021-07-02 08:31:58','2021-07-02 08:31:58'),(318,1,'orders','created','[\"10614\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10614\",\"product\":\"Savlon glycerine rs.10 SKU:\"}',1,'2021-07-02 08:34:02','2021-07-02 08:34:02'),(319,1,'orders','created','[\"10616\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10616\",\"product\":\"Kissan Mixed Fruit 500g SKU:\"}',1,'2021-07-02 08:36:34','2021-07-02 08:36:34'),(320,1,'orders','created','[\"10618\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10618\",\"product\":\"Tazza Tea 100g SKU:\"}',1,'2021-07-02 09:09:29','2021-07-02 09:09:29'),(321,1,'orders','created','[\"10620\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10620\",\"product\":\"Babul 200g SKU:634828\"}',1,'2021-07-02 09:27:33','2021-07-02 09:27:33'),(322,1,'orders','created','[\"10622\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10622\",\"product\":\"Wheel 800g SKU:\"}',1,'2021-07-02 09:33:36','2021-07-02 09:33:36'),(323,1,'orders',NULL,NULL,NULL,1,'2021-07-02 12:35:26','2021-07-02 12:35:26'),(324,1,'orders',NULL,NULL,NULL,1,'2021-07-03 03:57:20','2021-07-03 03:57:20'),(325,1,'orders','created','[\"10624\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10624\",\"product\":\"Parachute coconut oil 175ml SKU:\"}',1,'2021-07-03 09:27:35','2021-07-03 09:27:35'),(326,1,'orders','created','[\"10626\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10626\",\"product\":\"Pulse Jar(170p jar) SKU:4224658\"}',1,'2021-07-03 09:37:06','2021-07-03 09:37:06'),(327,1,'orders','created','[\"10628\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10628\",\"product\":\"Serf excel Bar 100g SKU:\"}',1,'2021-07-03 19:48:33','2021-07-03 19:48:33'),(328,1,'orders','created','[\"10642\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10642\",\"product\":\"Ganesh Sattu 200g SKU:\"}',1,'2021-07-04 06:23:01','2021-07-04 06:23:01'),(329,1,'orders','created','[\"10644\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10644\",\"product\":\"Ganesh Sattu 500g SKU:\"}',1,'2021-07-04 06:25:34','2021-07-04 06:25:34'),(330,1,'orders','created','[\"10646\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10646\",\"product\":\"parle G Biscuit Rs.3(pack of 24) SKU:\"}',1,'2021-07-04 06:28:32','2021-07-04 06:28:32'),(331,1,'orders','created','[\"10648\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10648\",\"product\":\"Shalimar 100ml poly SKU:1873984\"}',1,'2021-07-04 06:31:32','2021-07-04 06:31:32'),(332,1,'orders','created','[\"10650\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10650\",\"product\":\"Everest kashmiri Mirch 50gm SKU:\"}',1,'2021-07-04 06:38:28','2021-07-04 06:38:28'),(333,1,'orders','created','[\"10654\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10654\",\"product\":\"Basumati Miniket SKU:19367\"}',1,'2021-07-04 06:52:34','2021-07-04 06:52:34'),(334,1,'orders','created','[\"10656\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10656\",\"product\":\"Lyzol flore cleaner 500ml+Harpic 200ml SKU:\"}',1,'2021-07-04 19:58:32','2021-07-04 19:58:32'),(335,1,'orders','created','[\"10660\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10660\",\"product\":\"Maggi Six pack SKU:\"}',1,'2021-07-05 05:38:07','2021-07-05 05:38:07'),(336,1,'orders','created','[\"10662\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10662\",\"product\":\"Lifebouy Sanitizer 500ml SKU:\"}',1,'2021-07-05 05:48:11','2021-07-05 05:48:11'),(337,1,'orders','created','[\"10664\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10664\",\"product\":\"Britania Thin 400Gm SKU:\"}',1,'2021-07-05 06:13:37','2021-07-05 06:13:37'),(338,1,'orders','created','[\"10666\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10666\",\"product\":\"Dabur chyawanprash 1kg SKU:\"}',1,'2021-07-05 06:27:47','2021-07-05 06:27:47'),(339,1,'orders','created','[\"10668\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10668\",\"product\":\"Everest kashmiri Mirch 50gm SKU:\"}',1,'2021-07-05 06:34:12','2021-07-05 06:34:12'),(340,1,'orders','created','[\"10670\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10670\",\"product\":\"Nihar 200ml SKU:\"}',1,'2021-07-05 07:08:44','2021-07-05 07:08:44'),(341,1,'orders','created','[\"10673\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10673\",\"product\":\"BiskFarm Marie 300gm SKU:\"}',1,'2021-07-05 07:50:49','2021-07-05 07:50:49'),(342,1,'orders','created','[\"10677\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10677\",\"product\":\"Happy Night(mosquito killer) SKU:48247\"}',1,'2021-07-05 20:32:35','2021-07-05 20:32:35'),(343,1,'orders','created','[\"10681\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10681\",\"product\":\"Vivel Aloe Vera Rs.10 SKU:\"}',1,'2021-07-05 20:36:24','2021-07-05 20:36:24'),(344,1,'orders','created','[\"10683\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10683\",\"product\":\"Sunlight 500g SKU:\"}',1,'2021-07-05 20:39:29','2021-07-05 20:39:29'),(345,1,'orders','created','[\"10703\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10703\",\"product\":\"Tata Gold Tea 100gm SKU:22745\"}',1,'2021-07-06 20:35:11','2021-07-06 20:35:11'),(346,1,'orders','created','[\"10709\"]','{\"error_type\":\"order_product_not_found\",\"order_number\":\"10709\",\"product\":\"Everest Chicken Masala Rs.5(pack of 10) SKU:\"}',1,'2021-07-21 08:00:13','2021-07-21 08:00:13');
/*!40000 ALTER TABLE `woocommerce_sync_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'uscricke_db1'
--

--
-- Dumping routines for database 'uscricke_db1'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-16 15:33:28
