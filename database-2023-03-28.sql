-- MySQL dump 10.13  Distrib 8.0.31, for macos12.6 (x86_64)
--
-- Host: localhost    Database: ultimatepos
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_transactions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `type` enum('debit','credit') COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_type` enum('opening_balance','fund_transfer','deposit') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(22,4) NOT NULL,
  `reff_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operation_date` datetime NOT NULL,
  `created_by` int NOT NULL,
  `transaction_id` int DEFAULT NULL,
  `transaction_payment_id` int DEFAULT NULL,
  `transfer_transaction_id` int DEFAULT NULL,
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
  KEY `account_transactions_sub_type_index` (`sub_type`),
  KEY `account_transactions_operation_date_index` (`operation_date`)
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_account_type_id` int DEFAULT NULL,
  `business_id` int NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_details` text COLLATE utf8mb4_unicode_ci,
  `account_type_id` int DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_by` int NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `log_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_id` int DEFAULT NULL,
  `subject_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_id` int DEFAULT NULL,
  `causer_id` int DEFAULT NULL,
  `causer_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `properties` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_log_log_name_index` (`log_name`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_log`
--

LOCK TABLES `activity_log` WRITE;
/*!40000 ALTER TABLE `activity_log` DISABLE KEYS */;
INSERT INTO `activity_log` VALUES (1,'default','login',1,'App\\User',1,1,'App\\User','[]','2022-11-21 16:46:30','2022-11-21 16:46:30'),(2,'default','login',1,'App\\User',1,1,'App\\User','[]','2022-11-21 21:16:43','2022-11-21 21:16:43'),(3,'default','added',2,'App\\Contact',1,1,'App\\User','[]','2022-11-21 21:18:18','2022-11-21 21:18:18'),(4,'default','login',1,'App\\User',1,1,'App\\User','[]','2022-11-22 01:06:23','2022-11-22 01:06:23'),(5,'default','login',1,'App\\User',1,1,'App\\User','[]','2022-11-22 13:25:38','2022-11-22 13:25:38'),(6,'default','login',1,'App\\User',1,1,'App\\User','[]','2022-11-22 13:29:02','2022-11-22 13:29:02'),(7,'default','added',1,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":0}}','2022-11-23 00:05:53','2022-11-23 00:05:53'),(8,'default','added',2,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":0}}','2022-11-23 00:19:04','2022-11-23 00:19:04'),(9,'default','added',3,'App\\Contact',1,1,'App\\User','[]','2022-11-23 02:50:44','2022-11-23 02:50:44'),(10,'default','login',1,'App\\User',1,1,'App\\User','[]','2022-11-23 13:09:22','2022-11-23 13:09:22'),(11,'default','login',1,'App\\User',1,1,'App\\User','[]','2022-11-24 12:59:16','2022-11-24 12:59:16'),(12,'default','edited',2,'App\\Contact',1,1,'App\\User','[]','2022-11-24 13:46:22','2022-11-24 13:46:22'),(13,'default','added',4,'App\\Contact',1,1,'App\\User','[]','2022-11-24 13:57:53','2022-11-24 13:57:53'),(14,'default','added',5,'App\\Contact',1,1,'App\\User','[]','2022-11-24 14:05:55','2022-11-24 14:05:55'),(15,'default','login',1,'App\\User',1,1,'App\\User','[]','2022-11-24 20:54:45','2022-11-24 20:54:45'),(16,'default','login',1,'App\\User',1,1,'App\\User','[]','2022-11-25 13:01:18','2022-11-25 13:01:18'),(17,'default','login',1,'App\\User',1,1,'App\\User','[]','2022-11-25 15:22:16','2022-11-25 15:22:16'),(18,'default','added',6,'App\\Contact',1,1,'App\\User','[]','2022-11-25 16:39:50','2022-11-25 16:39:50'),(19,'default','login',1,'App\\User',1,1,'App\\User','[]','2022-12-09 23:06:15','2022-12-09 23:06:15'),(20,'default','login',1,'App\\User',1,1,'App\\User','[]','2022-12-10 11:09:47','2022-12-10 11:09:47'),(21,'default','login',1,'App\\User',1,1,'App\\User','[]','2022-12-12 03:45:37','2022-12-12 03:45:37'),(22,'default','login',1,'App\\User',1,1,'App\\User','[]','2023-01-06 13:32:51','2023-01-06 13:32:51'),(23,'default','login',1,'App\\User',1,1,'App\\User','[]','2023-01-06 13:49:04','2023-01-06 13:49:04'),(24,'default','login',1,'App\\User',1,1,'App\\User','[]','2023-01-06 13:49:50','2023-01-06 13:49:50'),(25,'default','added',7,'App\\Contact',1,1,'App\\User','[]','2023-01-06 13:52:18','2023-01-06 13:52:18'),(26,'default','added',8,'App\\Contact',1,1,'App\\User','[]','2023-01-06 13:58:33','2023-01-06 13:58:34'),(27,'default','added',4,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":25}}','2023-01-06 15:01:11','2023-01-06 15:01:11'),(28,'default','added',5,'App\\Transaction',1,1,'App\\User','{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":25}}','2023-01-06 15:02:10','2023-01-06 15:02:10'),(29,'default','login',1,'App\\User',1,1,'App\\User','[]','2023-01-11 16:20:47','2023-01-11 16:20:47'),(30,'default','login',1,'App\\User',1,1,'App\\User','[]','2023-01-16 19:12:12','2023-01-16 19:12:12'),(31,'default','login',1,'App\\User',1,1,'App\\User','[]','2023-01-16 20:36:36','2023-01-16 20:36:36'),(32,'default','login',1,'App\\User',1,1,'App\\User','[]','2023-01-17 00:54:34','2023-01-17 00:54:34'),(33,'default','login',1,'App\\User',1,1,'App\\User','[]','2023-01-17 14:54:39','2023-01-17 14:54:39'),(34,'default','login',1,'App\\User',1,1,'App\\User','[]','2023-01-18 18:09:40','2023-01-18 18:09:41'),(35,'default','login',1,'App\\User',1,1,'App\\User','[]','2023-01-19 18:51:40','2023-01-19 18:51:40'),(36,'default','login',1,'App\\User',1,1,'App\\User','[]','2023-01-20 18:27:48','2023-01-20 18:27:48'),(37,'default','login',1,'App\\User',1,1,'App\\User','[]','2023-01-25 22:20:49','2023-01-25 22:20:49'),(38,'default','login',1,'App\\User',1,1,'App\\User','[]','2023-03-23 13:55:01','2023-03-23 13:55:01'),(39,'default','login',1,'App\\User',1,1,'App\\User','[]','2023-03-28 18:29:49','2023-03-28 18:29:49');
/*!40000 ALTER TABLE `activity_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barcodes`
--

DROP TABLE IF EXISTS `barcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barcodes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
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
  `stickers_in_one_row` int DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_continuous` tinyint(1) NOT NULL DEFAULT '0',
  `stickers_in_one_sheet` int DEFAULT NULL,
  `business_id` int unsigned DEFAULT NULL,
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
INSERT INTO `barcodes` VALUES (1,'20 Labels per Sheet','Sheet Size: 8.5\" x 11\", Label Size: 4\" x 1\", Labels per sheet: 20',4.0000,1.0000,8.5000,11.0000,0.5000,0.1250,0.0000,0.1875,2,0,0,20,NULL,'2017-12-18 10:13:44','2017-12-18 10:13:44'),(2,'30 Labels per sheet','Sheet Size: 8.5\" x 11\", Label Size: 2.625\" x 1\", Labels per sheet: 30',2.6250,1.0000,8.5000,11.0000,0.5000,0.1880,0.0000,0.1250,3,0,0,30,NULL,'2017-12-18 10:04:39','2017-12-18 10:10:40'),(3,'32 Labels per sheet','Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1.25\", Labels per sheet: 32',2.0000,1.2500,8.5000,11.0000,0.5000,0.2500,0.0000,0.0000,4,0,0,32,NULL,'2017-12-18 09:55:40','2017-12-18 09:55:40'),(4,'40 Labels per sheet','Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1\", Labels per sheet: 40',2.0000,1.0000,8.5000,11.0000,0.5000,0.2500,0.0000,0.0000,4,0,0,40,NULL,'2017-12-18 09:58:40','2017-12-18 09:58:40'),(5,'50 Labels per Sheet','Sheet Size: 8.5\" x 11\", Label Size: 1.5\" x 1\", Labels per sheet: 50',1.5000,1.0000,8.5000,11.0000,0.5000,0.5000,0.0000,0.0000,5,0,0,50,NULL,'2017-12-18 09:51:10','2017-12-18 09:51:10'),(6,'Continuous Rolls - 31.75mm x 25.4mm','Label Size: 31.75mm x 25.4mm, Gap: 3.18mm',1.2500,1.0000,1.2500,0.0000,0.1250,0.0000,0.1250,0.0000,1,0,1,NULL,NULL,'2017-12-18 09:51:10','2017-12-18 09:51:10');
/*!40000 ALTER TABLE `barcodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `contact_id` int unsigned NOT NULL,
  `waiter_id` int unsigned DEFAULT NULL,
  `table_id` int unsigned DEFAULT NULL,
  `correspondent_id` int DEFAULT NULL,
  `business_id` int unsigned NOT NULL,
  `location_id` int unsigned NOT NULL,
  `booking_start` datetime NOT NULL,
  `booking_end` datetime NOT NULL,
  `created_by` int unsigned NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_by` int unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `brands_business_id_foreign` (`business_id`),
  KEY `brands_created_by_foreign` (`created_by`),
  CONSTRAINT `brands_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `brands_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business`
--

DROP TABLE IF EXISTS `business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_id` int unsigned NOT NULL,
  `start_date` date DEFAULT NULL,
  `tax_number_1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_label_1` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_number_2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_label_2` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code_label_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code_label_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_sales_tax` int unsigned DEFAULT NULL,
  `default_profit_percent` double(5,2) NOT NULL DEFAULT '0.00',
  `owner_id` int unsigned NOT NULL,
  `time_zone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Asia/Kolkata',
  `fy_start_month` tinyint NOT NULL DEFAULT '1',
  `accounting_method` enum('fifo','lifo','avco') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fifo',
  `default_sales_discount` decimal(5,2) DEFAULT NULL,
  `sell_price_tax` enum('includes','excludes') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'includes',
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku_prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_product_expiry` tinyint(1) NOT NULL DEFAULT '0',
  `expiry_type` enum('add_expiry','add_manufacturing') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'add_expiry',
  `on_product_expiry` enum('keep_selling','stop_selling','auto_delete') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'keep_selling',
  `stop_selling_before` int NOT NULL COMMENT 'Stop selling expied item n days before expiry',
  `enable_tooltip` tinyint(1) NOT NULL DEFAULT '1',
  `purchase_in_diff_currency` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Allow purchase to be in different currency then the business currency',
  `purchase_currency_id` int unsigned DEFAULT NULL,
  `p_exchange_rate` decimal(20,3) NOT NULL DEFAULT '1.000',
  `transaction_edit_days` int unsigned NOT NULL DEFAULT '30',
  `stock_expiry_alert_days` int unsigned NOT NULL DEFAULT '30',
  `keyboard_shortcuts` text COLLATE utf8mb4_unicode_ci,
  `pos_settings` text COLLATE utf8mb4_unicode_ci,
  `weighing_scale_setting` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'used to store the configuration of weighing scale',
  `enable_brand` tinyint(1) NOT NULL DEFAULT '1',
  `enable_category` tinyint(1) NOT NULL DEFAULT '1',
  `enable_sub_category` tinyint(1) NOT NULL DEFAULT '1',
  `enable_price_tax` tinyint(1) NOT NULL DEFAULT '1',
  `enable_purchase_status` tinyint(1) DEFAULT '1',
  `enable_lot_number` tinyint(1) NOT NULL DEFAULT '0',
  `default_unit` int DEFAULT NULL,
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
  `created_by` int DEFAULT NULL,
  `enable_rp` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'rp is the short form of reward points',
  `rp_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `amount_for_unit_rp` decimal(22,4) NOT NULL DEFAULT '1.0000' COMMENT 'rp is the short form of reward points',
  `min_order_total_for_rp` decimal(22,4) NOT NULL DEFAULT '1.0000' COMMENT 'rp is the short form of reward points',
  `max_rp_per_order` int DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `redeem_amount_per_unit_rp` decimal(22,4) NOT NULL DEFAULT '1.0000' COMMENT 'rp is the short form of reward points',
  `min_order_total_for_redeem` decimal(22,4) NOT NULL DEFAULT '1.0000' COMMENT 'rp is the short form of reward points',
  `min_redeem_point` int DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `max_redeem_point` int DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `rp_expiry_period` int DEFAULT NULL COMMENT 'rp is the short form of reward points',
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business`
--

LOCK TABLES `business` WRITE;
/*!40000 ALTER TABLE `business` DISABLE KEYS */;
INSERT INTO `business` VALUES (1,'Sintic Bolivia',14,'2022-11-21',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,25.00,1,'America/La_Paz',1,'fifo',0.00,'includes',NULL,NULL,0,'add_expiry','keep_selling',0,1,0,NULL,1.000,30,30,'{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"recent_product_quantity\":\"f2\",\"weighing_scale\":null,\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"add_new_product\":\"f4\"}}','{\"amount_rounding_method\":null,\"cmmsn_calculation_type\":\"invoice_value\",\"razor_pay_key_id\":null,\"razor_pay_key_secret\":null,\"stripe_public_key\":null,\"stripe_secret_key\":null,\"cash_denominations\":null,\"disable_pay_checkout\":0,\"disable_draft\":0,\"disable_express_checkout\":0,\"hide_product_suggestion\":0,\"hide_recent_trans\":0,\"disable_discount\":0,\"disable_order_tax\":0,\"is_pos_subtotal_editable\":0}','{\"label_prefix\":null,\"product_sku_length\":\"4\",\"qty_length\":\"3\",\"qty_length_decimal\":\"2\"}',1,1,1,1,1,0,NULL,0,0,0,0,1,NULL,1,0,'before','[\"purchases\",\"add_sale\",\"pos_sale\",\"stock_transfers\",\"stock_adjustment\",\"expenses\"]','d-m-Y','24','{\"purchase\":\"PO\",\"purchase_return\":null,\"purchase_order\":null,\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"expense_payment\":null,\"business_location\":\"BL\",\"username\":null,\"subscription\":null,\"draft\":null,\"sales_order\":null}',NULL,NULL,0,NULL,1.0000,1.0000,NULL,1.0000,1.0000,NULL,NULL,NULL,'year','{\"mail_driver\":\"smtp\",\"mail_host\":null,\"mail_port\":null,\"mail_username\":\"admin\",\"mail_password\":\"admin\",\"mail_encryption\":null,\"mail_from_address\":null,\"mail_from_name\":null}','{\"sms_service\":\"other\",\"nexmo_key\":null,\"nexmo_secret\":null,\"nexmo_from\":null,\"twilio_sid\":null,\"twilio_token\":null,\"twilio_from\":null,\"url\":null,\"send_to_param_name\":\"to\",\"msg_param_name\":\"text\",\"request_method\":\"post\",\"header_1\":null,\"header_val_1\":null,\"header_2\":null,\"header_val_2\":null,\"header_3\":null,\"header_val_3\":null,\"param_1\":null,\"param_val_1\":null,\"param_2\":null,\"param_val_2\":null,\"param_3\":null,\"param_val_3\":null,\"param_4\":null,\"param_val_4\":null,\"param_5\":null,\"param_val_5\":null,\"param_6\":null,\"param_val_6\":null,\"param_7\":null,\"param_val_7\":null,\"param_8\":null,\"param_val_8\":null,\"param_9\":null,\"param_val_9\":null,\"param_10\":null,\"param_val_10\":null}','{\"payments\":{\"custom_pay_1\":null,\"custom_pay_2\":null,\"custom_pay_3\":null,\"custom_pay_4\":null,\"custom_pay_5\":null,\"custom_pay_6\":null,\"custom_pay_7\":null},\"contact\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null,\"custom_field_5\":null,\"custom_field_6\":null,\"custom_field_7\":null,\"custom_field_8\":null,\"custom_field_9\":null,\"custom_field_10\":null},\"product\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"location\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"user\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"purchase\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"purchase_shipping\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null,\"custom_field_5\":null},\"sell\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"shipping\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null,\"custom_field_5\":null},\"types_of_service\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null,\"custom_field_5\":null,\"custom_field_6\":null}}','{\"default_credit_limit\":null,\"default_datatable_page_entries\":\"25\"}',1,'2022-11-21 16:46:25','2023-01-18 18:15:42');
/*!40000 ALTER TABLE `business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_locations`
--

DROP TABLE IF EXISTS `business_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business_locations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int unsigned NOT NULL,
  `location_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `landmark` text COLLATE utf8mb4_unicode_ci,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zip_code` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_scheme_id` int unsigned NOT NULL,
  `invoice_layout_id` int unsigned NOT NULL,
  `sale_invoice_layout_id` int DEFAULT NULL,
  `selling_price_group_id` int DEFAULT NULL,
  `print_receipt_on_invoice` tinyint(1) DEFAULT '1',
  `receipt_printer_type` enum('browser','printer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'browser',
  `printer_id` int DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_locations`
--

LOCK TABLES `business_locations` WRITE;
/*!40000 ALTER TABLE `business_locations` DISABLE KEYS */;
INSERT INTO `business_locations` VALUES (1,1,'BL0001','TerraPuerto','LandMark','Bolivia','Murillo','La Paz','00000',1,1,1,NULL,1,'browser',NULL,'21434','234234','','',NULL,1,'{\"cash\":{\"is_enabled\":1,\"account\":null},\"card\":{\"is_enabled\":1,\"account\":null},\"cheque\":{\"is_enabled\":1,\"account\":null},\"bank_transfer\":{\"is_enabled\":1,\"account\":null},\"other\":{\"is_enabled\":1,\"account\":null},\"custom_pay_1\":{\"is_enabled\":1,\"account\":null},\"custom_pay_2\":{\"is_enabled\":1,\"account\":null},\"custom_pay_3\":{\"is_enabled\":1,\"account\":null},\"custom_pay_4\":{\"is_enabled\":1,\"account\":null},\"custom_pay_5\":{\"is_enabled\":1,\"account\":null},\"custom_pay_6\":{\"is_enabled\":1,\"account\":null},\"custom_pay_7\":{\"is_enabled\":1,\"account\":null}}',NULL,NULL,NULL,NULL,NULL,'2022-11-21 16:46:25','2022-11-21 16:46:25');
/*!40000 ALTER TABLE `business_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_register_transactions`
--

DROP TABLE IF EXISTS `cash_register_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cash_register_transactions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `cash_register_id` int unsigned NOT NULL,
  `amount` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `pay_method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('debit','credit') COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cash_register_transactions_cash_register_id_foreign` (`cash_register_id`),
  KEY `cash_register_transactions_transaction_id_index` (`transaction_id`),
  KEY `cash_register_transactions_type_index` (`type`),
  KEY `cash_register_transactions_transaction_type_index` (`transaction_type`),
  CONSTRAINT `cash_register_transactions_cash_register_id_foreign` FOREIGN KEY (`cash_register_id`) REFERENCES `cash_registers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_register_transactions`
--

LOCK TABLES `cash_register_transactions` WRITE;
/*!40000 ALTER TABLE `cash_register_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `cash_register_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_registers`
--

DROP TABLE IF EXISTS `cash_registers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cash_registers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int unsigned NOT NULL,
  `location_id` int DEFAULT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `status` enum('close','open') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `closed_at` datetime DEFAULT NULL,
  `closing_amount` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `total_card_slips` int NOT NULL DEFAULT '0',
  `total_cheques` int NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_registers`
--

LOCK TABLES `cash_registers` WRITE;
/*!40000 ALTER TABLE `cash_registers` DISABLE KEYS */;
INSERT INTO `cash_registers` VALUES (1,1,1,1,'open',NULL,0.0000,0,0,NULL,NULL,'2022-11-23 00:04:00','2022-11-23 00:04:21');
/*!40000 ALTER TABLE `cash_registers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int unsigned NOT NULL,
  `short_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int NOT NULL,
  `created_by` int unsigned NOT NULL,
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
  CONSTRAINT `categories_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorizables`
--

DROP TABLE IF EXISTS `categorizables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorizables` (
  `category_id` int NOT NULL,
  `categorizable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categorizable_id` bigint unsigned NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int unsigned NOT NULL,
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
  `pay_term_number` int DEFAULT NULL,
  `pay_term_type` enum('days','months') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit_limit` decimal(22,4) DEFAULT NULL,
  `created_by` int unsigned NOT NULL,
  `balance` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `total_rp` int NOT NULL DEFAULT '0' COMMENT 'rp is the short form of reward points',
  `total_rp_used` int NOT NULL DEFAULT '0' COMMENT 'rp is the short form of reward points',
  `total_rp_expired` int NOT NULL DEFAULT '0' COMMENT 'rp is the short form of reward points',
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
  `customer_group_id` int DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (1,1,'customer',NULL,'Walk-In Customer',NULL,NULL,NULL,NULL,NULL,'CO0001','active',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,0.0000,1,0.0000,0,0,0,1,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2022-11-21 16:46:25','2022-11-21 16:46:25'),(2,1,'customer',NULL,'Mr Marcelo Aviles','Mr','Marcelo',NULL,'Aviles','marcenickg@gmail.com','CO0002','active','3301256',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'77739265',NULL,NULL,NULL,NULL,NULL,1,0.0000,0,0,0,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2022-11-21 21:18:18','2022-11-24 13:46:22'),(3,1,'customer',NULL,'S/N',NULL,'S/N',NULL,NULL,'marcenickg@gmail.com','CO0003','active',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'77712342',NULL,NULL,NULL,NULL,NULL,1,0.0000,0,0,0,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2022-11-23 02:50:44','2022-11-23 02:50:44'),(4,1,'customer',NULL,'Pepito Perez',NULL,'Pepito',NULL,'Perez','pepito@mailinator.com','CO0004','active',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'345435',NULL,NULL,NULL,NULL,NULL,1,0.0000,0,0,0,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2022-11-24 13:57:53','2022-11-24 13:57:53'),(5,1,'customer',NULL,'ddd eeee',NULL,'ddd',NULL,'eeee','m@mailinator.com','CO0007','active','1212',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,1,0.0000,0,0,0,0,'sdfsdf',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2022-11-24 14:05:55','2022-11-24 14:05:55'),(6,1,'customer',NULL,'Textiles SRL',NULL,NULL,NULL,'Textiles SRL','marcenickg@gmail.com','CO0008','active','2123123',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,1,0.0000,0,0,0,0,'direccion',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2022-11-25 16:39:50','2022-11-25 16:39:50'),(7,1,'customer',NULL,'Pepito Perez',NULL,'Pepito',NULL,'Perez','pepito@mailinator.com','CO0009','active','45435345',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,1,0.0000,0,0,0,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2023-01-06 13:52:18','2023-01-06 13:52:18'),(8,1,'customer',NULL,'Juan Perez',NULL,'Juan',NULL,'Perez',NULL,'CO0010','active','8457845',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,1,0.0000,0,0,0,0,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2023-01-06 13:58:33','2023-01-06 13:58:33');
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencies` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
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
INSERT INTO `currencies` VALUES (1,'Albania','Leke','ALL','Lek',',','.',NULL,NULL),(2,'America','Dollars','USD','$',',','.',NULL,NULL),(3,'Afghanistan','Afghanis','AF','؋',',','.',NULL,NULL),(4,'Argentina','Pesos','ARS','$',',','.',NULL,NULL),(5,'Aruba','Guilders','AWG','ƒ',',','.',NULL,NULL),(6,'Australia','Dollars','AUD','$',',','.',NULL,NULL),(7,'Azerbaijan','New Manats','AZ','ман',',','.',NULL,NULL),(8,'Bahamas','Dollars','BSD','$',',','.',NULL,NULL),(9,'Barbados','Dollars','BBD','$',',','.',NULL,NULL),(10,'Belarus','Rubles','BYR','p.',',','.',NULL,NULL),(11,'Belgium','Euro','EUR','€',',','.',NULL,NULL),(12,'Beliz','Dollars','BZD','BZ$',',','.',NULL,NULL),(13,'Bermuda','Dollars','BMD','$',',','.',NULL,NULL),(14,'Bolivia','Bolivianos','BOB','$b',',','.',NULL,NULL),(15,'Bosnia and Herzegovina','Convertible Marka','BAM','KM',',','.',NULL,NULL),(16,'Botswana','Pula\'s','BWP','P',',','.',NULL,NULL),(17,'Bulgaria','Leva','BG','лв',',','.',NULL,NULL),(18,'Brazil','Reais','BRL','R$',',','.',NULL,NULL),(19,'Britain [United Kingdom]','Pounds','GBP','£',',','.',NULL,NULL),(20,'Brunei Darussalam','Dollars','BND','$',',','.',NULL,NULL),(21,'Cambodia','Riels','KHR','៛',',','.',NULL,NULL),(22,'Canada','Dollars','CAD','$',',','.',NULL,NULL),(23,'Cayman Islands','Dollars','KYD','$',',','.',NULL,NULL),(24,'Chile','Pesos','CLP','$',',','.',NULL,NULL),(25,'China','Yuan Renminbi','CNY','¥',',','.',NULL,NULL),(26,'Colombia','Pesos','COP','$',',','.',NULL,NULL),(27,'Costa Rica','Colón','CRC','₡',',','.',NULL,NULL),(28,'Croatia','Kuna','HRK','kn',',','.',NULL,NULL),(29,'Cuba','Pesos','CUP','₱',',','.',NULL,NULL),(30,'Cyprus','Euro','EUR','€','.',',',NULL,NULL),(31,'Czech Republic','Koruny','CZK','Kč',',','.',NULL,NULL),(32,'Denmark','Kroner','DKK','kr',',','.',NULL,NULL),(33,'Dominican Republic','Pesos','DOP ','RD$',',','.',NULL,NULL),(34,'East Caribbean','Dollars','XCD','$',',','.',NULL,NULL),(35,'Egypt','Pounds','EGP','£',',','.',NULL,NULL),(36,'El Salvador','Colones','SVC','$',',','.',NULL,NULL),(37,'England [United Kingdom]','Pounds','GBP','£',',','.',NULL,NULL),(38,'Euro','Euro','EUR','€','.',',',NULL,NULL),(39,'Falkland Islands','Pounds','FKP','£',',','.',NULL,NULL),(40,'Fiji','Dollars','FJD','$',',','.',NULL,NULL),(41,'France','Euro','EUR','€','.',',',NULL,NULL),(42,'Ghana','Cedis','GHS','¢',',','.',NULL,NULL),(43,'Gibraltar','Pounds','GIP','£',',','.',NULL,NULL),(44,'Greece','Euro','EUR','€','.',',',NULL,NULL),(45,'Guatemala','Quetzales','GTQ','Q',',','.',NULL,NULL),(46,'Guernsey','Pounds','GGP','£',',','.',NULL,NULL),(47,'Guyana','Dollars','GYD','$',',','.',NULL,NULL),(48,'Holland [Netherlands]','Euro','EUR','€','.',',',NULL,NULL),(49,'Honduras','Lempiras','HNL','L',',','.',NULL,NULL),(50,'Hong Kong','Dollars','HKD','$',',','.',NULL,NULL),(51,'Hungary','Forint','HUF','Ft',',','.',NULL,NULL),(52,'Iceland','Kronur','ISK','kr',',','.',NULL,NULL),(53,'India','Rupees','INR','₹',',','.',NULL,NULL),(54,'Indonesia','Rupiahs','IDR','Rp',',','.',NULL,NULL),(55,'Iran','Rials','IRR','﷼',',','.',NULL,NULL),(56,'Ireland','Euro','EUR','€','.',',',NULL,NULL),(57,'Isle of Man','Pounds','IMP','£',',','.',NULL,NULL),(58,'Israel','New Shekels','ILS','₪',',','.',NULL,NULL),(59,'Italy','Euro','EUR','€','.',',',NULL,NULL),(60,'Jamaica','Dollars','JMD','J$',',','.',NULL,NULL),(61,'Japan','Yen','JPY','¥',',','.',NULL,NULL),(62,'Jersey','Pounds','JEP','£',',','.',NULL,NULL),(63,'Kazakhstan','Tenge','KZT','лв',',','.',NULL,NULL),(64,'Korea [North]','Won','KPW','₩',',','.',NULL,NULL),(65,'Korea [South]','Won','KRW','₩',',','.',NULL,NULL),(66,'Kyrgyzstan','Soms','KGS','лв',',','.',NULL,NULL),(67,'Laos','Kips','LAK','₭',',','.',NULL,NULL),(68,'Latvia','Lati','LVL','Ls',',','.',NULL,NULL),(69,'Lebanon','Pounds','LBP','£',',','.',NULL,NULL),(70,'Liberia','Dollars','LRD','$',',','.',NULL,NULL),(71,'Liechtenstein','Switzerland Francs','CHF','CHF',',','.',NULL,NULL),(72,'Lithuania','Litai','LTL','Lt',',','.',NULL,NULL),(73,'Luxembourg','Euro','EUR','€','.',',',NULL,NULL),(74,'Macedonia','Denars','MKD','ден',',','.',NULL,NULL),(75,'Malaysia','Ringgits','MYR','RM',',','.',NULL,NULL),(76,'Malta','Euro','EUR','€','.',',',NULL,NULL),(77,'Mauritius','Rupees','MUR','₨',',','.',NULL,NULL),(78,'Mexico','Pesos','MXN','$',',','.',NULL,NULL),(79,'Mongolia','Tugriks','MNT','₮',',','.',NULL,NULL),(80,'Mozambique','Meticais','MZ','MT',',','.',NULL,NULL),(81,'Namibia','Dollars','NAD','$',',','.',NULL,NULL),(82,'Nepal','Rupees','NPR','₨',',','.',NULL,NULL),(83,'Netherlands Antilles','Guilders','ANG','ƒ',',','.',NULL,NULL),(84,'Netherlands','Euro','EUR','€','.',',',NULL,NULL),(85,'New Zealand','Dollars','NZD','$',',','.',NULL,NULL),(86,'Nicaragua','Cordobas','NIO','C$',',','.',NULL,NULL),(87,'Nigeria','Nairas','NGN','₦',',','.',NULL,NULL),(88,'North Korea','Won','KPW','₩',',','.',NULL,NULL),(89,'Norway','Krone','NOK','kr',',','.',NULL,NULL),(90,'Oman','Rials','OMR','﷼',',','.',NULL,NULL),(91,'Pakistan','Rupees','PKR','₨',',','.',NULL,NULL),(92,'Panama','Balboa','PAB','B/.',',','.',NULL,NULL),(93,'Paraguay','Guarani','PYG','Gs',',','.',NULL,NULL),(94,'Peru','Nuevos Soles','PE','S/.',',','.',NULL,NULL),(95,'Philippines','Pesos','PHP','Php',',','.',NULL,NULL),(96,'Poland','Zlotych','PL','zł',',','.',NULL,NULL),(97,'Qatar','Rials','QAR','﷼',',','.',NULL,NULL),(98,'Romania','New Lei','RO','lei',',','.',NULL,NULL),(99,'Russia','Rubles','RUB','руб',',','.',NULL,NULL),(100,'Saint Helena','Pounds','SHP','£',',','.',NULL,NULL),(101,'Saudi Arabia','Riyals','SAR','﷼',',','.',NULL,NULL),(102,'Serbia','Dinars','RSD','Дин.',',','.',NULL,NULL),(103,'Seychelles','Rupees','SCR','₨',',','.',NULL,NULL),(104,'Singapore','Dollars','SGD','$',',','.',NULL,NULL),(105,'Slovenia','Euro','EUR','€','.',',',NULL,NULL),(106,'Solomon Islands','Dollars','SBD','$',',','.',NULL,NULL),(107,'Somalia','Shillings','SOS','S',',','.',NULL,NULL),(108,'South Africa','Rand','ZAR','R',',','.',NULL,NULL),(109,'South Korea','Won','KRW','₩',',','.',NULL,NULL),(110,'Spain','Euro','EUR','€','.',',',NULL,NULL),(111,'Sri Lanka','Rupees','LKR','₨',',','.',NULL,NULL),(112,'Sweden','Kronor','SEK','kr',',','.',NULL,NULL),(113,'Switzerland','Francs','CHF','CHF',',','.',NULL,NULL),(114,'Suriname','Dollars','SRD','$',',','.',NULL,NULL),(115,'Syria','Pounds','SYP','£',',','.',NULL,NULL),(116,'Taiwan','New Dollars','TWD','NT$',',','.',NULL,NULL),(117,'Thailand','Baht','THB','฿',',','.',NULL,NULL),(118,'Trinidad and Tobago','Dollars','TTD','TT$',',','.',NULL,NULL),(119,'Turkey','Lira','TRY','TL',',','.',NULL,NULL),(120,'Turkey','Liras','TRL','£',',','.',NULL,NULL),(121,'Tuvalu','Dollars','TVD','$',',','.',NULL,NULL),(122,'Ukraine','Hryvnia','UAH','₴',',','.',NULL,NULL),(123,'United Kingdom','Pounds','GBP','£',',','.',NULL,NULL),(124,'United States of America','Dollars','USD','$',',','.',NULL,NULL),(125,'Uruguay','Pesos','UYU','$U',',','.',NULL,NULL),(126,'Uzbekistan','Sums','UZS','лв',',','.',NULL,NULL),(127,'Vatican City','Euro','EUR','€','.',',',NULL,NULL),(128,'Venezuela','Bolivares Fuertes','VEF','Bs',',','.',NULL,NULL),(129,'Vietnam','Dong','VND','₫',',','.',NULL,NULL),(130,'Yemen','Rials','YER','﷼',',','.',NULL,NULL),(131,'Zimbabwe','Zimbabwe Dollars','ZWD','Z$',',','.',NULL,NULL),(132,'Iraq','Iraqi dinar','IQD','د.ع',',','.',NULL,NULL),(133,'Kenya','Kenyan shilling','KES','KSh',',','.',NULL,NULL),(134,'Bangladesh','Taka','BDT','৳',',','.',NULL,NULL),(135,'Algerie','Algerian dinar','DZD','د.ج',' ','.',NULL,NULL),(136,'United Arab Emirates','United Arab Emirates dirham','AED','د.إ',',','.',NULL,NULL),(137,'Uganda','Uganda shillings','UGX','USh',',','.',NULL,NULL),(138,'Tanzania','Tanzanian shilling','TZS','TSh',',','.',NULL,NULL),(139,'Angola','Kwanza','AOA','Kz',',','.',NULL,NULL),(140,'Kuwait','Kuwaiti dinar','KWD','KD',',','.',NULL,NULL),(141,'Bahrain','Bahraini dinar','BHD','BD',',','.',NULL,NULL);
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_groups`
--

DROP TABLE IF EXISTS `customer_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double(5,2) NOT NULL,
  `price_calculation_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'percentage',
  `selling_price_group_id` int DEFAULT NULL,
  `created_by` int unsigned NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_configurations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int unsigned NOT NULL,
  `created_by` int NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount_variations` (
  `discount_id` int NOT NULL,
  `variation_id` int NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int NOT NULL,
  `brand_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `priority` int DEFAULT NULL,
  `discount_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_amount` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `spg` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Applicable in specified selling price group only. Use of applicable_in_spg column is discontinued',
  `applicable_in_cg` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discounts_business_id_index` (`business_id`),
  KEY `discounts_brand_id_index` (`brand_id`),
  KEY `discounts_category_id_index` (`category_id`),
  KEY `discounts_location_id_index` (`location_id`),
  KEY `discounts_priority_index` (`priority`),
  KEY `discounts_spg_index` (`spg`)
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_and_notes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int NOT NULL,
  `notable_id` int NOT NULL,
  `notable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `heading` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int NOT NULL,
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
-- Table structure for table `expense_categories`
--

DROP TABLE IF EXISTS `expense_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expense_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int unsigned NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_sub_taxes` (
  `group_tax_id` int unsigned NOT NULL,
  `tax_id` int unsigned NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_layouts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
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
  `commission_agent_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_commission_agent` tinyint(1) NOT NULL DEFAULT '0',
  `show_reward_point` tinyint(1) NOT NULL DEFAULT '0',
  `highlight_color` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `footer_text` text COLLATE utf8mb4_unicode_ci,
  `module_info` text COLLATE utf8mb4_unicode_ci,
  `common_settings` text COLLATE utf8mb4_unicode_ci,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `business_id` int unsigned NOT NULL,
  `show_qr_code` tinyint(1) NOT NULL DEFAULT '0',
  `qr_code_fields` text COLLATE utf8mb4_unicode_ci,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_layouts`
--

LOCK TABLES `invoice_layouts` WRITE;
/*!40000 ALTER TABLE `invoice_layouts` DISABLE KEYS */;
INSERT INTO `invoice_layouts` VALUES (1,'Default',NULL,'Invoice No.',NULL,'Invoice',NULL,NULL,NULL,NULL,NULL,'','',NULL,'Subtotal','Discount','Tax','Total',NULL,'Total Due','Total Paid',0,NULL,NULL,'Date',NULL,1,0,1,1,0,0,0,0,NULL,0,'Product','Quantity','Unit Price','Subtotal',NULL,NULL,0,0,1,1,1,1,1,1,1,0,0,1,0,0,1,1,'Customer',NULL,0,0,'#000000','',NULL,NULL,1,1,0,NULL,'classic',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'2022-11-21 16:46:25','2022-11-21 16:46:25');
/*!40000 ALTER TABLE `invoice_layouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_schemes`
--

DROP TABLE IF EXISTS `invoice_schemes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_schemes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scheme_type` enum('blank','year') COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_number` int DEFAULT NULL,
  `invoice_count` int NOT NULL DEFAULT '0',
  `total_digits` int DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_schemes_business_id_foreign` (`business_id`),
  KEY `invoice_schemes_scheme_type_index` (`scheme_type`),
  CONSTRAINT `invoice_schemes_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_schemes`
--

LOCK TABLES `invoice_schemes` WRITE;
/*!40000 ALTER TABLE `invoice_schemes` DISABLE KEYS */;
INSERT INTO `invoice_schemes` VALUES (1,1,'Default','blank','',1,2,4,1,'2022-11-21 16:46:25','2022-11-23 00:19:04');
/*!40000 ALTER TABLE `invoice_schemes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mb_customers`
--

DROP TABLE IF EXISTS `mb_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mb_customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `external_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identity_document` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nit_ruc_nif` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mb_customers`
--

LOCK TABLES `mb_customers` WRITE;
/*!40000 ALTER TABLE `mb_customers` DISABLE KEYS */;
INSERT INTO `mb_customers` VALUES (1,NULL,1,'','Marcelo','Aviles','','3301256','null','marcenickg@gmail.com','','','2023-01-17 01:08:15','2023-01-17 15:08:20'),(2,NULL,1,'','Pepito','Perez','','43534554','','pepito@mailinator.com','Direccion 01','','2023-01-17 15:08:43','2023-01-17 15:08:43'),(3,NULL,1,'','Av23432','saf','','324234','','mar@mailinator.com','asdasd','','2023-01-17 15:10:12','2023-01-17 15:14:23'),(4,NULL,1,'','uuuuu','yyyy','','3523','','sdfsdf@gmail.com','dgdg','','2023-01-17 15:14:50','2023-01-17 15:17:10');
/*!40000 ALTER TABLE `mb_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mb_invoice_items`
--

DROP TABLE IF EXISTS `mb_invoice_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mb_invoice_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `product_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` decimal(8,2) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `subtotal` decimal(8,2) NOT NULL,
  `discount` decimal(8,2) NOT NULL,
  `total` decimal(8,2) NOT NULL,
  `codigo_actividad` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_producto_sin` bigint NOT NULL,
  `unidad_medida` bigint NOT NULL,
  `imei` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero_serie` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mb_invoice_items`
--

LOCK TABLES `mb_invoice_items` WRITE;
/*!40000 ALTER TABLE `mb_invoice_items` DISABLE KEYS */;
INSERT INTO `mb_invoice_items` VALUES (1,4,0,'P001','Producto 01',1.00,123.00,0.00,0.00,123.00,'522000',67410,58,NULL,NULL,'Array','2022-11-22 15:57:30','2022-11-22 15:57:30'),(2,5,0,'P001','Producto 01',1.00,123.00,0.00,0.00,123.00,'522000',67410,58,NULL,NULL,'Array','2022-11-22 16:15:30','2022-11-22 16:15:30'),(3,6,0,'P001','Producto 01',1.00,543.00,0.00,0.00,543.00,'522000',67410,58,NULL,NULL,'Array','2022-11-22 16:27:08','2022-11-22 16:27:08'),(4,7,0,'P002','Producto 002',1.00,12.00,0.00,0.00,12.00,'522000',67410,58,NULL,NULL,'Array','2022-11-23 04:00:46','2022-11-23 04:00:46'),(5,8,0,'001','Prouc',1.00,12.00,0.00,0.00,12.00,'522000',67410,58,NULL,NULL,'Array','2022-11-23 04:02:35','2022-11-23 04:02:35'),(6,9,0,'21','pro',1.00,12.00,0.00,0.00,12.00,'522000',674109,58,NULL,NULL,'Array','2022-11-23 04:07:09','2022-11-23 04:07:09'),(7,10,0,'12','slmkas',1.00,22.00,0.00,0.00,22.00,'522000',674109,58,NULL,NULL,'Array','2022-11-23 04:11:57','2022-11-23 04:11:57'),(8,11,0,'12','slmkas',1.00,22.00,0.00,0.00,22.00,'522000',674109,58,NULL,NULL,'Array','2022-11-23 04:12:08','2022-11-23 04:12:08'),(9,12,0,'12','slmkas',1.00,22.00,0.00,0.00,22.00,'522000',674109,58,NULL,NULL,'Array','2022-11-23 04:13:00','2022-11-23 04:13:00'),(10,13,0,'P001','producto 01',1.00,23.00,0.00,0.00,23.00,'522000',67410,58,NULL,NULL,'Array','2022-11-23 14:58:29','2022-11-23 14:58:29'),(11,14,0,'P001','product 01',1.00,12.00,0.00,0.00,12.00,'522000',67410,58,NULL,NULL,'Array','2022-11-23 17:13:59','2022-11-23 17:13:59'),(12,15,0,'AL001','Alquiler Edificio',1.00,12000.00,0.00,0.00,12000.00,'522000',67410,58,NULL,NULL,'Array','2022-11-23 18:01:17','2022-11-23 18:01:17'),(13,16,0,'P001','procto',1.00,12.00,0.00,0.00,12.00,'522000',674209,58,NULL,NULL,'{\"custom_fields\":[]}','2022-11-24 20:55:38','2022-11-24 20:55:38'),(14,17,0,'AL001','Alquiler',1.00,12.00,0.00,0.00,12.00,'522000',674409,48,NULL,NULL,'{\"custom_fields\":[]}','2022-11-24 20:57:53','2022-11-24 20:57:53'),(15,18,0,'P001','producto',1.00,12.00,0.00,0.00,12.00,'522000',67440,58,NULL,NULL,'{\"custom_fields\":[]}','2022-11-25 15:37:11','2022-11-25 15:37:11'),(16,19,0,'1','proucto',1.00,123.00,0.00,0.00,123.00,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-11-25 15:59:53','2022-11-25 15:59:53'),(17,20,1,'P001','Producto de Prueba',1.00,18.75,0.00,0.00,18.75,'522000',99100,58,NULL,NULL,'{\"custom_fields\":[]}','2022-11-25 16:25:43','2022-11-25 16:25:43'),(18,21,1,'P001','Producto de Prueba',1.00,18.75,0.00,0.00,18.75,'522000',99100,58,NULL,NULL,'{\"custom_fields\":[]}','2022-11-25 17:01:50','2022-11-25 17:01:50'),(19,22,1,'P001','Producto de Prueba',1.00,18.75,0.00,0.00,18.75,'522000',99100,58,NULL,NULL,'{\"custom_fields\":[]}','2022-11-25 17:01:59','2022-11-25 17:01:59'),(20,23,1,'P001','Producto de Prueba',1.00,18.75,0.00,0.00,18.75,'522000',99100,58,NULL,NULL,'{\"custom_fields\":[]}','2022-11-25 17:04:53','2022-11-25 17:04:53'),(21,24,1,'P001','Producto de Prueba',1.00,18.75,0.00,0.00,18.75,'522000',99100,58,NULL,NULL,'{\"custom_fields\":[]}','2022-11-25 17:06:41','2022-11-25 17:06:41'),(22,25,1,'P001','Producto de Prueba',1.00,18.75,0.00,0.00,18.75,'522000',99100,58,NULL,NULL,'{\"custom_fields\":[]}','2022-11-25 17:10:55','2022-11-25 17:10:55'),(23,26,1,'P001','Producto de Prueba',1.00,18.75,0.00,0.00,18.75,'522000',99100,58,NULL,NULL,'{\"custom_fields\":[]}','2022-11-25 17:12:00','2022-11-25 17:12:00'),(24,27,1,'P001','Producto de Prueba',1.00,18.75,0.00,0.00,18.75,'522000',99100,58,NULL,NULL,'{\"custom_fields\":[]}','2022-11-25 18:00:39','2022-11-25 18:00:39'),(26,29,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 11:22:51','2022-12-10 11:22:51'),(27,30,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 11:22:51','2022-12-10 11:22:51'),(28,31,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 11:22:51','2022-12-10 11:22:51'),(29,32,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 11:22:51','2022-12-10 11:22:51'),(30,33,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 11:22:51','2022-12-10 11:22:51'),(31,34,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 11:22:51','2022-12-10 11:22:51'),(32,35,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 11:22:51','2022-12-10 11:22:51'),(33,36,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 11:22:51','2022-12-10 11:22:51'),(34,37,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 11:22:51','2022-12-10 11:22:51'),(35,38,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 11:22:51','2022-12-10 11:22:51'),(61,64,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 11:42:39','2022-12-10 11:42:39'),(62,65,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 11:42:39','2022-12-10 11:42:39'),(63,66,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 11:42:39','2022-12-10 11:42:39'),(64,67,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 11:42:39','2022-12-10 11:42:39'),(65,68,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 11:42:39','2022-12-10 11:42:39'),(66,69,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 12:23:50','2022-12-10 12:23:50'),(67,70,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 12:25:05','2022-12-10 12:25:05'),(68,71,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 12:28:03','2022-12-10 12:28:03'),(69,72,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 12:28:25','2022-12-10 12:28:25'),(70,73,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 12:28:25','2022-12-10 12:28:25'),(71,74,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 12:28:26','2022-12-10 12:28:26'),(72,75,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 12:28:26','2022-12-10 12:28:26'),(73,76,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 12:28:26','2022-12-10 12:28:26'),(74,77,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 12:28:26','2022-12-10 12:28:26'),(75,78,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 12:28:26','2022-12-10 12:28:26'),(76,79,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 12:28:26','2022-12-10 12:28:26'),(77,80,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 12:28:26','2022-12-10 12:28:26'),(78,81,2,'T001','Uso de terminal',1.00,2.50,0.00,0.00,2.50,'522000',67410,58,NULL,NULL,'{\"custom_fields\":[]}','2022-12-10 12:28:26','2022-12-10 12:28:26'),(80,83,3,'SIS-HDB-P001','SIS-HDB Prueba 01',1.00,85.00,0.00,0.00,85.00,'841130',83221,57,NULL,NULL,'{\"custom_fields\":[]}','2023-01-06 13:41:12','2023-01-06 13:41:12'),(81,84,3,'SIS-HDB-P001','SIS-HDB Prueba 01',1.00,85.00,0.00,0.00,85.00,'841130',83221,57,NULL,NULL,'{\"custom_fields\":[]}','2023-01-06 14:19:13','2023-01-06 14:19:13'),(82,85,3,'SIS-HDB-P001','SIS-HDB Prueba 01',1.00,85.00,0.00,0.00,85.00,'841130',83221,57,NULL,NULL,'{\"custom_fields\":[]}','2023-01-06 14:31:51','2023-01-06 14:31:51'),(83,86,3,'SIS-HDB-P001','SIS-HDB Prueba 01',1.00,85.00,0.00,0.00,85.00,'841130',83221,57,NULL,NULL,'{\"custom_fields\":[]}','2023-01-06 14:35:55','2023-01-06 14:35:55'),(84,87,4,'123','consulta emergencia',1.00,12.50,0.00,0.00,12.50,'841130',832229,58,NULL,NULL,'{\"custom_fields\":[]}','2023-01-06 14:37:52','2023-01-06 14:37:52'),(85,87,3,'SIS-HDB-P001','SIS-HDB Prueba 01',1.00,85.00,0.00,0.00,85.00,'841130',83221,57,NULL,NULL,'{\"custom_fields\":[]}','2023-01-06 14:37:52','2023-01-06 14:37:52'),(86,88,3,'SIS-HDB-P001','SIS-HDB Prueba 01',1.00,85.00,0.00,0.00,85.00,'841130',83221,57,NULL,NULL,'{\"custom_fields\":[]}','2023-01-06 14:40:36','2023-01-06 14:40:36'),(87,89,4,'123','consulta emergencia',1.00,12.50,0.00,0.00,12.50,'841130',832229,58,NULL,NULL,'{\"custom_fields\":[]}','2023-01-06 14:43:18','2023-01-06 14:43:18'),(88,90,3,'SIS-HDB-P001','SIS-HDB Prueba 01',1.00,85.00,0.00,0.00,85.00,'841130',83221,57,NULL,NULL,'{\"custom_fields\":[]}','2023-01-06 14:44:41','2023-01-06 14:44:41'),(89,91,3,'SIS-HDB-P001','SIS-HDB Prueba 01',1.00,85.00,0.00,0.00,85.00,'841130',83221,57,NULL,NULL,'{\"custom_fields\":[]}','2023-01-06 14:45:06','2023-01-06 14:45:06'),(90,92,3,'SIS-HDB-P001','SIS-HDB Prueba 01',1.00,85.00,0.00,0.00,85.00,'841130',83221,57,NULL,NULL,'{\"custom_fields\":[]}','2023-01-06 14:45:20','2023-01-06 14:45:20'),(91,93,3,'SIS-HDB-P001','SIS-HDB Prueba 01',1.00,85.00,0.00,0.00,85.00,'841130',83221,57,NULL,NULL,'{\"custom_fields\":[]}','2023-01-06 14:52:48','2023-01-06 14:52:48'),(92,94,3,'SIS-HDB-P001','SIS-HDB Prueba 01',1.00,85.00,0.00,0.00,85.00,'841130',83221,57,NULL,NULL,'{\"custom_fields\":[]}','2023-01-06 14:56:36','2023-01-06 14:56:36'),(93,95,3,'SIS-HDB-P001','SIS-HDB Prueba 01',1.00,85.00,0.00,0.00,85.00,'841130',83221,57,NULL,NULL,'{\"custom_fields\":[]}','2023-01-06 15:01:48','2023-01-06 15:01:48');
/*!40000 ALTER TABLE `mb_invoice_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mb_invoice_products`
--

DROP TABLE IF EXISTS `mb_invoice_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mb_invoice_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `billing_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `barcode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serialnumber` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imei` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codigo_sin` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_actividad` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unidad_medida` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mb_invoice_products`
--

LOCK TABLES `mb_invoice_products` WRITE;
/*!40000 ALTER TABLE `mb_invoice_products` DISABLE KEYS */;
INSERT INTO `mb_invoice_products` VALUES (1,0,'P001','Producto prueba',NULL,'ff',123.00,NULL,NULL,NULL,'83221','841130',57,'2023-01-16 19:40:28','2023-01-16 19:54:05');
/*!40000 ALTER TABLE `mb_invoice_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mb_invoices`
--

DROP TABLE IF EXISTS `mb_invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mb_invoices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint NOT NULL,
  `event_id` bigint NOT NULL,
  `package_id` bigint NOT NULL,
  `codigo_sucursal` int NOT NULL,
  `codigo_puntoventa` int NOT NULL,
  `codigo_documento_sector` int NOT NULL,
  `tipo_emision` int NOT NULL,
  `tipo_factura_documento` int NOT NULL,
  `tipo_documento_identidad` int NOT NULL,
  `codigo_metodo_pago` int NOT NULL,
  `codigo_moneda` int NOT NULL,
  `nit_emisor` bigint NOT NULL,
  `customer` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit_ruc_nif` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `complemento` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtotal` double NOT NULL,
  `discount` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `giftcard_amount` double NOT NULL,
  `invoice_number` bigint NOT NULL,
  `invoice_number_cafc` bigint NOT NULL,
  `control_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cuf` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cufd` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cafc` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero_tarjeta` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_datetime` datetime NOT NULL,
  `tipo_cambio` double NOT NULL,
  `siat_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `leyenda` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `excepcion` tinyint NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cafc_numero` tinyint NOT NULL,
  `ambiente` tinyint NOT NULL,
  `user_id` bigint NOT NULL,
  `batch_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mb_invoices`
--

LOCK TABLES `mb_invoices` WRITE;
/*!40000 ALTER TABLE `mb_invoices` DISABLE KEYS */;
INSERT INTO `mb_invoices` VALUES (1,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles (CO0002)','3301256',NULL,123,0,0,123,0,1,0,'93647680E007D74','4603EBEC034DD69010E65083F1FF46F95CEB9E06A293647680E007D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qnxwa2hMWExXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-22 11:46:59',1,'e6b20ae9-6a7c-11ed-add5-ef37c7c3ad3b','Ley N° 453: Los servicios deben suministrarse en condiciones de inocuidad, calidad y seguridad.',0,'Array','ISSUED','2022-11-22 15:46:59','2022-11-22 15:46:59',0,0,1,NULL),(2,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles (CO0002)','3301256',NULL,123,0,15.99,123,0,2,0,'93647680E007D74','4603EBEC034DD6901A97DB39D170C7B014EB9F8D4293647680E007D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qnxwa2hMWExXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-22 11:54:27',1,'f1b5c11f-6a7d-11ed-831e-a385e2554fc4','Ley N° 453: La interrupción del servicio debe comunicarse con anterioridad a las Autoridades que correspondan y a los usuarios afectados.',0,'Array','ISSUED','2022-11-22 15:54:28','2022-11-22 15:54:28',0,2,1,NULL),(3,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles (CO0002)','3301256',NULL,123,0,15.99,123,0,3,0,'93647680E007D74','4603EBEC034DD6901D2152876AEB7C5FE713A113E293647680E007D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qnxwa2hMWExXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-22 11:56:28',1,'39d3844c-6a7e-11ed-8352-5ff489e55913','Ley N° 453: Tienes derecho a un trato equitativo sin discriminación en la oferta de productos.',0,'Array','ISSUED','2022-11-22 15:56:28','2022-11-22 15:56:28',0,2,1,NULL),(4,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles (CO0002)','3301256',NULL,123,0,15.99,123,0,4,0,'93647680E007D74','4603EBEC034DD6901E6AE6F392988F782B83A29A8993647680E007D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qnxwa2hMWExXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-22 11:57:30',1,'5efc748b-6a7e-11ed-a5eb-a3f60fc1540d','Ley N° 453: En caso de incumplimiento a lo ofertado o convenido, el proveedor debe reparar o sustituir el producto..',0,'Array','ISSUED','2022-11-22 15:57:30','2022-11-22 15:57:30',0,2,1,NULL),(5,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles (CO0002)','3301256',NULL,123,0,15.99,123,0,5,0,'93647680E007D74','4603EBEC034DD690679FB681176468DC13C3A4212593647680E007D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qnxwa2hMWExXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-22 12:15:30',1,'e260185c-6a80-11ed-87e2-7d933b1f5f7e','Ley N° 453: En caso de incumplimiento a lo ofertado o convenido, el proveedor debe reparar o sustituir el producto..',0,'Array','ISSUED','2022-11-22 16:15:30','2022-11-22 16:15:30',0,2,1,NULL),(6,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles (CO0002)','3301256',NULL,543,0,70.59,543,0,6,0,'93647680E007D74','4603EBEC034DD690767ACE15D22A06741A6BA5A7C193647680E007D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qnxwa2hMWExXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-22 12:27:07',1,'826456d4-6a82-11ed-a08d-fdd13db9d662','Ley N° 453: Está prohibido importar, distribuir o comercializar productos expirados o prontos a expirar.',0,'Array','ISSUED','2022-11-22 16:27:08','2022-11-22 16:27:08',0,2,1,NULL),(7,3,0,0,0,0,23,1,1,5,1,1,1023275028,'S/N','0',NULL,12,0,1.56,12,0,7,0,'6DE7EC27E007D74','4603EBEC034DD6BBB8078B2921EA6078A73CB62E616DE7EC27E007D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QnxhSXhXWExXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-23 00:00:44',1,'6866c81f-6ae3-11ed-8e45-0fd6ace41939','Ley N° 453: Los alimentos declarados de primera necesidad deben ser suministrados de manera adecuada, oportuna, continua y a precio justo.',0,'{\"excepcion\":0,\"custom_fields\":{\"cantidad\":1}}','ISSUED','2022-11-23 04:00:46','2022-11-23 04:00:46',0,2,1,NULL),(8,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles (CO0002)','3301256',NULL,12,0,1.56,12,0,8,0,'6DE7EC27E007D74','4603EBEC034DD6BBBA6D777A2086D17CF943A8B5026DE7EC27E007D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QnxhSXhXWExXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-23 00:02:34',1,'a99507de-6ae3-11ed-9914-1369eea70fed','Ley N° 453: Está prohibido importar, distribuir o comercializar productos prohibidos o retirados en el país de origen por atentar a la integridad física y a la salud.',0,'{\"excepcion\":0,\"custom_fields\":[]}','ISSUED','2022-11-23 04:02:35','2022-11-23 04:02:35',0,2,1,NULL),(9,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles (CO0002)','3301256',NULL,12,0,1.56,12,0,9,0,'6DE7EC27E007D74','4603EBEC034DD6BBC06C46449D0EAF6DFBBBAA3BA16DE7EC27E007D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QnxhSXhXWExXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-23 00:07:09',1,'4d1765d1-6ae4-11ed-add5-ef37c7c3ad3b','Ley N° 453: Los servicios deben suministrarse en condiciones de inocuidad, calidad y seguridad.',0,'{\"excepcion\":0,\"custom_fields\":[]}','ISSUED','2022-11-23 04:07:09','2022-11-23 04:07:09',0,2,1,NULL),(10,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles (CO0002)','12321',NULL,22,0,2.8600000000000003,22,0,10,0,'6DE7EC27E007D74','4603EBEC034DD6BBC6109C00781BBF5854D3ABC2426DE7EC27E007D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QnxhSXhXWExXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-23 00:11:56',1,'f883fa47-6ae4-11ed-a5eb-a3f60fc1540d','Ley N° 453: Tienes derecho a recibir información sobre las características y contenidos de los productos que consumes.',0,'{\"excepcion\":0,\"custom_fields\":[]}','ISSUED','2022-11-23 04:11:57','2022-11-23 04:11:57',0,2,1,NULL),(11,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles (CO0002)','12321',NULL,22,0,2.8600000000000003,22,0,11,0,'6DE7EC27E007D74','4603EBEC034DD6BBC6B8A164C8921964B3F3AD48E86DE7EC27E007D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QnxhSXhXWExXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-23 00:12:08',1,'ff609225-6ae4-11ed-8ee5-e5c8e83a5de6','Ley N° 453: El proveedor deberá suministrar el servicio en las modalidades y términos ofertados o convenidos.',0,'{\"excepcion\":0,\"custom_fields\":[]}','ISSUED','2022-11-23 04:12:08','2022-11-23 04:12:08',0,2,1,NULL),(12,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles (CO0002)','12321',NULL,22,0,2.8600000000000003,22,0,12,0,'6DE7EC27E007D74','4603EBEC034DD6BBC7E1E6029201077A9753AECF816DE7EC27E007D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QnxhSXhXWExXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-23 00:13:00',1,'1e544f05-6ae5-11ed-add5-ef37c7c3ad3b','Ley N° 453: En caso de incumplimiento a lo ofertado o convenido, el proveedor debe reparar o sustituir el producto..',0,'{\"excepcion\":0,\"custom_fields\":[]}','ISSUED','2022-11-23 04:13:00','2022-11-23 04:13:00',0,2,1,NULL),(13,2,2,1,0,0,1,2,1,1,1,1,1023275028,'Mr Marcelo Aviles (CO0002)','3301256',NULL,23,0,2.99,23,0,13,0,'6DE7EC27E007D74','4603EBEC034DD6C0EF39504274EC41D650631456206DE7EC27E007D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QnxhSXhXWExXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-23 10:58:29',1,NULL,'Ley N° 453: El proveedor de servicios debe habilitar medios e instrumentos para efectuar consultas y reclamaciones.',0,'{\"excepcion\":0,\"custom_fields\":[]}','ISSUED','2022-11-23 14:58:29','2022-11-23 14:58:29',0,2,1,NULL),(14,2,3,2,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles (CO0002)','3301256',NULL,12,0,1.56,12,0,14,0,'3175FDBC1107D74','4603EBEC034DD6C23175314C4EAB569048F315DCC93175FDBC1107D74','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhX0drTVlMV1VIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-23 13:13:59',1,'4a7a1b5d-6b52-11ed-b96b-c381dc50aa5c','Ley N° 453: Está prohibido importar, distribuir o comercializar productos expirados o prontos a expirar.',0,'{\"excepcion\":0,\"custom_fields\":[]}','VOID','2022-11-23 17:13:59','2022-11-24 13:22:09',0,2,1,NULL),(15,2,0,0,0,0,2,1,1,1,1,1,1023275028,'Mr Marcelo Aviles (CO0002)','3301256',NULL,12000,0,1560,12000,0,15,0,'5200553D1107D74','4603EBEC034DD6C29FFFD11A52047C8ABCE079E3635200553D1107D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QjkoY09OWUxXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-23 14:01:17',1,'d3e24a57-6b58-11ed-adc5-b79bdb379538','Ley N° 453: Tienes derecho a un trato equitativo sin discriminación en la oferta de productos.',0,'{\"excepcion\":0,\"custom_fields\":{\"periodoFacturado\":\"Octubre\"}}','ISSUED','2022-11-23 18:01:17','2022-11-23 18:01:17',0,2,1,NULL),(16,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles','3301256',NULL,12,0,1.56,12,0,16,0,'0CE738DA5107D74','4603EBEC034DD6F52EA1C401EEF088785203B4EA040CE738DA5107D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm9ZUDRRWkxXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-24 16:55:38',1,'59f22e08-6c3a-11ed-ac3b-352695b136be','Ley N° 453: Los servicios deben suministrarse en condiciones de inocuidad, calidad y seguridad.',0,'{\"excepcion\":0,\"custom_fields\":[]}','VOID','2022-11-24 20:55:38','2022-11-24 21:08:42',0,2,1,NULL),(17,2,0,0,0,0,2,1,1,1,1,1,1023275028,'Mr Marcelo Aviles','3301256',NULL,12,0,1.56,12,0,17,0,'0CE738DA5107D74','4603EBEC034DD6F531553CA89C88D738BA987CF0A50CE738DA5107D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm9ZUDRRWkxXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-24 16:57:52',1,'a9f17587-6c3a-11ed-a1ef-1173f698aa41','Ley N° 453: Los servicios deben suministrarse en condiciones de inocuidad, calidad y seguridad.',0,'{\"excepcion\":0,\"custom_fields\":{\"periodoFacturado\":\"Octubre\"},\"cantidad\":1}','ISSUED','2022-11-24 20:57:53','2022-11-24 20:57:53',0,2,1,NULL),(18,2,0,0,0,0,1,1,1,5,1,1,1023275028,'Mr Marcelo Aviles','3301256',NULL,12,0,1.56,12,0,18,0,'0638D5439107D74','4603EBEC034DD723EE3B8097B299CF2875FBB7F7490638D5439107D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qj4rWFdMYUxXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-25 11:37:09',1,'06c4c35b-6cd7-11ed-8fd6-7721d5cf8891','Ley N° 453: El proveedor deberá suministrar el servicio en las modalidades y términos ofertados o convenidos.',1,'{\"excepcion\":1,\"custom_fields\":[]}','ISSUED','2022-11-25 15:37:11','2022-11-25 15:37:11',0,2,1,NULL),(19,2,0,0,0,0,1,1,1,1,2,1,1023275028,'Mr Marcelo Aviles','3301256',NULL,123,0,15.99,123,0,19,0,'0638D5439107D74','4603EBEC034DD7240A8E41E31B79733E579BB97DE90638D5439107D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qj4rWFdMYUxXVUFIzNkFBQzA0NjI0M',NULL,'2335580707026267','2022-11-25 11:59:53',1,'333a6ae4-6cda-11ed-b2ce-7de4790aa1ff','Ley N° 453: El proveedor deberá suministrar el servicio en las modalidades y términos ofertados o convenidos.',0,'{\"excepcion\":0,\"custom_fields\":[]}','VOID','2022-11-25 15:59:53','2022-11-25 16:02:50',0,2,1,NULL),(20,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles','3301256',NULL,18.75,0,2.4375,18.75,0,20,0,'0638D5439107D74','4603EBEC034DD7245DBBB21FB572B85E33CBBB04880638D5439107D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qj4rWFdMYUxXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-25 12:25:43',1,'cf24f0a3-6cdd-11ed-b2ce-7de4790aa1ff','Ley N° 453: El proveedor de servicios debe habilitar medios e instrumentos para efectuar consultas y reclamaciones.',0,'{\"excepcion\":0,\"custom_fields\":[]}','ISSUED','2022-11-25 16:25:43','2022-11-25 16:25:43',0,2,1,NULL),(21,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles','3301256',NULL,18.75,0,2.4375,18.75,0,21,0,'0638D5439107D74','4603EBEC034DD724BDBC01DCE9AF7A6FC8BBBC8B280638D5439107D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qj4rWFdMYUxXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-25 13:01:49',1,'da74595f-6ce2-11ed-b2ce-7de4790aa1ff','Ley N° 453: La interrupción del servicio debe comunicarse con anterioridad a las Autoridades que correspondan y a los usuarios afectados.',0,'{\"excepcion\":0,\"custom_fields\":[]}','VOID','2022-11-25 17:01:50','2022-12-09 23:48:54',0,2,1,NULL),(22,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles','3301256',NULL,18.75,0,2.4375,18.75,0,22,0,'0638D5439107D74','4603EBEC034DD724BDDC51AB47ED9F7229CBBE11C80638D5439107D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qj4rWFdMYUxXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-25 13:01:59',1,'e0461047-6ce2-11ed-8662-cdeb100e83e6','Ley N° 453: En caso de incumplimiento a lo ofertado o convenido, el proveedor debe reparar o sustituir el servicio.',0,'{\"excepcion\":0,\"custom_fields\":[]}','VOID','2022-11-25 17:01:59','2022-12-09 23:48:15',0,2,1,NULL),(23,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles','3301256',NULL,18.75,0,2.4375,18.75,0,23,0,'0416FB549107D74','4603EBEC034DD724C18F0D96AAD74237DF53BF98640416FB549107D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QlV0eUVOYUxXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-25 13:04:52',1,'478f1a90-6ce3-11ed-8662-cdeb100e83e6','Ley N° 453: Tienes derecho a un trato equitativo sin discriminación en la oferta de servicios.',0,'{\"excepcion\":0,\"custom_fields\":[]}','ISSUED','2022-11-25 17:04:53','2022-11-25 17:04:53',0,2,1,NULL),(24,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles','3301256',NULL,18.75,0,2.4375,18.75,0,24,0,'0416FB549107D74','4603EBEC034DD724C3EB485CF3948FE45CCBC11F070416FB549107D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QlV0eUVOYUxXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-25 13:06:39',1,'8767405e-6ce3-11ed-a1c7-dd21fdd001a1','Ley N° 453: En caso de incumplimiento a lo ofertado o convenido, el proveedor debe reparar o sustituir el servicio.',0,'{\"excepcion\":0,\"custom_fields\":[]}','VOID','2022-11-25 17:06:41','2022-12-09 23:47:12',0,2,1,NULL),(25,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles','3301256',NULL,18.75,0,2.4375,18.75,0,25,0,'0416FB549107D74','4603EBEC034DD724C92838513AA78FC718E3C2A5A70416FB549107D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QlV0eUVOYUxXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-25 13:10:54',1,'1f3ba813-6ce4-11ed-aae6-a5c0689f7fbf','Ley N° 453: El proveedor debe exhibir certificaciones de habilitación o documentos que acrediten las capacidades u ofertas de servicios especializados.',0,'{\"excepcion\":0,\"custom_fields\":[]}','VOID','2022-11-25 17:10:55','2022-12-09 23:46:08',0,2,1,NULL),(26,2,0,0,0,0,1,1,1,1,1,1,1023275028,'Mr Marcelo Aviles','3301256',NULL,18.75,0,2.4375,18.75,0,26,0,'0416FB549107D74','4603EBEC034DD724CAFFF8AFCDCC78E9D533C42C460416FB549107D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QlV0eUVOYUxXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-25 13:12:00',1,'465b1145-6ce4-11ed-b2ce-7de4790aa1ff','Ley N° 453: El proveedor deberá suministrar el servicio en las modalidades y términos ofertados o convenidos.',0,'{\"excepcion\":0,\"custom_fields\":[]}','VOID','2022-11-25 17:12:00','2022-12-09 23:42:17',0,2,1,NULL),(27,2,6,0,0,0,23,2,1,1,1,1,1023275028,'S/N','0',NULL,18.75,0,2.4375,18.75,0,27,0,'4AF02EA49107D74','4603EBEC034DD7253A90521EFFD2A380595C38B2E14AF02EA49107D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QjltajdOYUxXVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-11-25 14:00:39',1,NULL,'Ley N° 453: Tienes derecho a un trato equitativo sin discriminación en la oferta de servicios.',0,'{\"excepcion\":0,\"custom_fields\":{\"periodoFacturado\":null},\"cantidad\":1}','ISSUED','2022-11-25 18:00:39','2022-11-25 18:00:39',0,2,1,NULL),(29,2,0,0,0,0,23,3,1,1,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,28,0,'2FB17CB62517D74','4603EBEC034DE780B5C7029586BA81F1593B9E39852FB17CB62517D74','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhXVpHVEtNV1VIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 07:22:50',1,NULL,'Ley N° 453: La interrupción del servicio debe comunicarse con anterioridad a las Autoridades que correspondan y a los usuarios afectados.',0,'{\"excepcion\":0,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 11:22:50','2022-12-10 11:22:50',0,2,1,3),(30,2,0,0,0,0,23,3,1,1,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,29,0,'2FB17CB62517D74','4603EBEC034DE780B5CA3DC3C35A527196239FC0242FB17CB62517D74','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhXVpHVEtNV1VIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 07:22:51',1,NULL,'Ley N° 453: Tienes derecho a un trato equitativo sin discriminación en la oferta de servicios.',0,'{\"excepcion\":0,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 11:22:51','2022-12-10 11:22:51',0,2,1,3),(31,2,0,0,0,0,23,3,1,1,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,30,0,'2FB17CB62517D74','4603EBEC034DE780B5CA3DC3C35A52719623A146C12FB17CB62517D74','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhXVpHVEtNV1VIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 07:22:51',1,NULL,'Ley N° 453: En caso de incumplimiento a lo ofertado o convenido, el proveedor debe reparar o sustituir el servicio.',0,'{\"excepcion\":0,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 11:22:51','2022-12-10 11:22:51',0,2,1,3),(32,2,0,0,0,0,23,3,1,1,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,31,0,'2FB17CB62517D74','4603EBEC034DE780B5CA3DC3C35A52719623A2CD672FB17CB62517D74','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhXVpHVEtNV1VIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 07:22:51',1,NULL,'Ley N° 453: La interrupción del servicio debe comunicarse con anterioridad a las Autoridades que correspondan y a los usuarios afectados.',0,'{\"excepcion\":0,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 11:22:51','2022-12-10 11:22:51',0,2,1,3),(33,2,0,0,0,0,23,3,1,1,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,32,0,'2FB17CB62517D74','4603EBEC034DE780B5CA3DC3C35A52719623A454022FB17CB62517D74','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhXVpHVEtNV1VIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 07:22:51',1,NULL,'Ley N° 453: Tienes derecho a un trato equitativo sin discriminación en la oferta de servicios.',0,'{\"excepcion\":0,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 11:22:51','2022-12-10 11:22:51',0,2,1,3),(34,2,0,0,0,0,23,3,1,1,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,33,0,'2FB17CB62517D74','4603EBEC034DE780B5CA3DC3C35A52719623A5DAA82FB17CB62517D74','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhXVpHVEtNV1VIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 07:22:51',1,NULL,'Ley N° 453: Tienes derecho a recibir información sobre las características y contenidos de los servicios que utilices.',0,'{\"excepcion\":0,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 11:22:51','2022-12-10 11:22:51',0,2,1,3),(35,2,0,0,0,0,23,3,1,1,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,34,0,'2FB17CB62517D74','4603EBEC034DE780B5CA3DC3C35A52719623A761432FB17CB62517D74','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhXVpHVEtNV1VIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 07:22:51',1,NULL,'Ley N° 453: El proveedor de servicios debe habilitar medios e instrumentos para efectuar consultas y reclamaciones.',0,'{\"excepcion\":0,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 11:22:51','2022-12-10 11:22:51',0,2,1,3),(36,2,0,0,0,0,23,3,1,1,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,35,0,'2FB17CB62517D74','4603EBEC034DE780B5CA3DC3C35A52719623A8E7E92FB17CB62517D74','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhXVpHVEtNV1VIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 07:22:51',1,NULL,'Ley N° 453: La interrupción del servicio debe comunicarse con anterioridad a las Autoridades que correspondan y a los usuarios afectados.',0,'{\"excepcion\":0,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 11:22:51','2022-12-10 11:22:51',0,2,1,3),(37,2,0,0,0,0,23,3,1,1,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,36,0,'2FB17CB62517D74','4603EBEC034DE780B5CA3DC3C35A52719623AA6E842FB17CB62517D74','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhXVpHVEtNV1VIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 07:22:51',1,NULL,'Ley N° 453: El proveedor de servicios debe habilitar medios e instrumentos para efectuar consultas y reclamaciones.',0,'{\"excepcion\":0,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 11:22:51','2022-12-10 11:22:51',0,2,1,3),(38,2,0,0,0,0,23,3,1,1,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,37,0,'2FB17CB62517D74','4603EBEC034DE780B5CA3DC3C35A52719623ABF5212FB17CB62517D74','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhXVpHVEtNV1VIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 07:22:51',1,NULL,'Ley N° 453: Los servicios deben suministrarse en condiciones de inocuidad, calidad y seguridad.',0,'{\"excepcion\":0,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 11:22:51','2022-12-10 11:22:51',0,2,1,3),(64,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,38,0,'2FB17CB62517D74','4603EBEC034DE780CEE1D0D28C69764A8FC3AD7BC82FB17CB62517D74','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhXVpHVEtNV1VIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 07:42:39',1,'c0018ca8-787f-11ed-b8dc-8f90d701015a','Ley N° 453: El proveedor de servicios debe habilitar medios e instrumentos para efectuar consultas y reclamaciones.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":\"5\"}','ISSUED','2022-12-10 11:42:39','2022-12-10 11:42:39',0,2,1,10),(65,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,39,0,'2FB17CB62517D74','4603EBEC034DE780CEE1D0D28C69764A8FC3AF02632FB17CB62517D74','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhXVpHVEtNV1VIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 07:42:39',1,'c0018ca8-787f-11ed-b8dc-8f90d701015a','Ley N° 453: La interrupción del servicio debe comunicarse con anterioridad a las Autoridades que correspondan y a los usuarios afectados.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":\"5\"}','ISSUED','2022-12-10 11:42:39','2022-12-10 11:42:39',0,2,1,10),(66,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,40,0,'2FB17CB62517D74','4603EBEC034DE780CEE1D0D28C69764A8FC3B089002FB17CB62517D74','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhXVpHVEtNV1VIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 07:42:39',1,'c0018ca8-787f-11ed-b8dc-8f90d701015a','Ley N° 453: Los servicios deben suministrarse en condiciones de inocuidad, calidad y seguridad.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":\"5\"}','ISSUED','2022-12-10 11:42:39','2022-12-10 11:42:39',0,2,1,10),(67,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,41,0,'2FB17CB62517D74','4603EBEC034DE780CEE1D0D28C69764A8FC3B20FA62FB17CB62517D74','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhXVpHVEtNV1VIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 07:42:39',1,'c0018ca8-787f-11ed-b8dc-8f90d701015a','Ley N° 453: En caso de incumplimiento a lo ofertado o convenido, el proveedor debe reparar o sustituir el servicio.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":\"5\"}','ISSUED','2022-12-10 11:42:39','2022-12-10 11:42:39',0,2,1,10),(68,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,42,0,'2FB17CB62517D74','4603EBEC034DE780CEE1D0D28C69764A8FC3B396412FB17CB62517D74','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhXVpHVEtNV1VIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 07:42:39',1,'c0018ca8-787f-11ed-b8dc-8f90d701015a','Ley N° 453: El proveedor deberá suministrar el servicio en las modalidades y términos ofertados o convenidos.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":\"5\"}','ISSUED','2022-12-10 11:42:39','2022-12-10 11:42:39',0,2,1,10),(69,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,43,0,'760A8EDB5517D74','4603EBEC034DE7813541DEC557E885544A5BB51CE3760A8EDB5517D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm8wMVVJTE1XVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 08:23:50',1,NULL,'Ley N° 453: El proveedor de servicios debe habilitar medios e instrumentos para efectuar consultas y reclamaciones.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":1}','ISSUED','2022-12-10 12:23:50','2022-12-10 12:23:50',0,2,1,NULL),(70,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,44,0,'760A8EDB5517D74','4603EBEC034DE7813736B3C40CABC2F92AD3B6A385760A8EDB5517D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm8wMVVJTE1XVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 08:25:05',1,NULL,'Ley N° 453: La interrupción del servicio debe comunicarse con anterioridad a las Autoridades que correspondan y a los usuarios afectados.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":\"1\"}','ISSUED','2022-12-10 12:25:05','2022-12-10 12:25:05',0,2,1,NULL),(71,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,45,0,'760A8EDB5517D74','4603EBEC034DE7813AF997969EB4784010E3B82A21760A8EDB5517D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm8wMVVJTE1XVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 08:28:03',1,NULL,'Ley N° 453: El proveedor deberá suministrar el servicio en las modalidades y términos ofertados o convenidos.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":1}','ISSUED','2022-12-10 12:28:03','2022-12-10 12:28:03',0,2,1,NULL),(72,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,46,0,'760A8EDB5517D74','4603EBEC034DE7813B40AD8FD47063454CD3B9B0C1760A8EDB5517D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm8wMVVJTE1XVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 08:28:25',1,'2561cb1f-7886-11ed-ba19-69381e5a890f','Ley N° 453: El proveedor deberá suministrar el servicio en las modalidades y términos ofertados o convenidos.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 12:28:25','2022-12-10 12:28:26',0,2,1,12),(73,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,47,0,'760A8EDB5517D74','4603EBEC034DE7813B40AD8FD47063454CD3BB3767760A8EDB5517D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm8wMVVJTE1XVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 08:28:25',1,'2561cb1f-7886-11ed-ba19-69381e5a890f','Ley N° 453: En caso de incumplimiento a lo ofertado o convenido, el proveedor debe reparar o sustituir el servicio.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 12:28:25','2022-12-10 12:28:26',0,2,1,12),(74,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,48,0,'760A8EDB5517D74','4603EBEC034DE7813B40AD8FD47063454CD3BCBE02760A8EDB5517D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm8wMVVJTE1XVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 08:28:25',1,'2561cb1f-7886-11ed-ba19-69381e5a890f','Ley N° 453: Tienes derecho a un trato equitativo sin discriminación en la oferta de servicios.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 12:28:26','2022-12-10 12:28:26',0,2,1,12),(75,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,49,0,'760A8EDB5517D74','4603EBEC034DE7813B43E8BE111033C589BBBE44A1760A8EDB5517D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm8wMVVJTE1XVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 08:28:26',1,'2561cb1f-7886-11ed-ba19-69381e5a890f','Ley N° 453: En caso de incumplimiento a lo ofertado o convenido, el proveedor debe reparar o sustituir el servicio.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 12:28:26','2022-12-10 12:28:26',0,2,1,12),(76,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,50,0,'760A8EDB5517D74','4603EBEC034DE7813B43E8BE111033C589BBBFCB49760A8EDB5517D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm8wMVVJTE1XVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 08:28:26',1,'2561cb1f-7886-11ed-ba19-69381e5a890f','Ley N° 453: La interrupción del servicio debe comunicarse con anterioridad a las Autoridades que correspondan y a los usuarios afectados.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 12:28:26','2022-12-10 12:28:26',0,2,1,12),(77,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,51,0,'760A8EDB5517D74','4603EBEC034DE7813B43E8BE111033C589BBC151E4760A8EDB5517D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm8wMVVJTE1XVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 08:28:26',1,'2561cb1f-7886-11ed-ba19-69381e5a890f','Ley N° 453: Tienes derecho a un trato equitativo sin discriminación en la oferta de servicios.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 12:28:26','2022-12-10 12:28:26',0,2,1,12),(78,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,52,0,'760A8EDB5517D74','4603EBEC034DE7813B43E8BE111033C589BBC2D881760A8EDB5517D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm8wMVVJTE1XVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 08:28:26',1,'2561cb1f-7886-11ed-ba19-69381e5a890f','Ley N° 453: El proveedor de servicios debe habilitar medios e instrumentos para efectuar consultas y reclamaciones.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 12:28:26','2022-12-10 12:28:26',0,2,1,12),(79,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,53,0,'760A8EDB5517D74','4603EBEC034DE7813B43E8BE111033C589BBC45F25760A8EDB5517D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm8wMVVJTE1XVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 08:28:26',1,'2561cb1f-7886-11ed-ba19-69381e5a890f','Ley N° 453: En caso de incumplimiento a lo ofertado o convenido, el proveedor debe reparar o sustituir el servicio.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 12:28:26','2022-12-10 12:28:26',0,2,1,12),(80,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,54,0,'760A8EDB5517D74','4603EBEC034DE7813B43E8BE111033C589BBC5E5C0760A8EDB5517D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm8wMVVJTE1XVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 08:28:26',1,'2561cb1f-7886-11ed-ba19-69381e5a890f','Ley N° 453: El proveedor debe exhibir certificaciones de habilitación o documentos que acrediten las capacidades u ofertas de servicios especializados.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 12:28:26','2022-12-10 12:28:26',0,2,1,12),(81,2,0,0,0,0,23,3,1,5,1,1,1023275028,'S/N','0',NULL,2.5,0,0.325,2.5,0,55,0,'760A8EDB5517D74','4603EBEC034DE7813B43E8BE111033C589BBC76C66760A8EDB5517D74','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm8wMVVJTE1XVUFIzNkFBQzA0NjI0M',NULL,NULL,'2022-12-10 08:28:26',1,'2561cb1f-7886-11ed-ba19-69381e5a890f','Ley N° 453: Tienes derecho a recibir información sobre las características y contenidos de los servicios que utilices.',1,'{\"excepcion\":1,\"custom_fields\":[],\"cantidad\":\"10\"}','ISSUED','2022-12-10 12:28:26','2022-12-10 12:28:26',0,2,1,12),(83,2,0,0,0,0,1,1,1,1,1,1,176614027,'Mr Marcelo Aviles','3301256',NULL,85,0,11.05,85,0,1,0,'5046E57F9C2FD74','C159CB03511D66CAF2E99EB4B51E150E0BD8606A65046E57F9C2FD74','BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Qz4kUGhKSEJYVUFI1Q0E2QkVGMkJCR',NULL,NULL,'2023-01-06 09:41:12',1,'c8e20feb-8dc7-11ed-a327-835bced00083','Ley N° 453: El proveedor de productos debe habilitar medios e instrumentos para efectuar consultas y reclamaciones.',0,'{\"excepcion\":0,\"custom_fields\":[]}','VOID','2023-01-06 13:41:12','2023-01-06 13:56:33',0,2,1,NULL),(84,8,0,0,0,0,1,1,1,1,1,1,176614027,'Juan Perez','8457845',NULL,85,0,11.05,85,0,2,0,'5046E57F9C2FD74','C159CB03511D66D11A4FDE0AD4A7510DA65878D425046E57F9C2FD74','BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Qz4kUGhKSEJYVUFI1Q0E2QkVGMkJCR',NULL,NULL,'2023-01-06 10:19:13',1,'187e84b2-8dcd-11ed-95b1-1152ea22f6d1','Ley N° 453: Tienes derecho a recibir información que te proteja de la publicidad engañosa.',0,'{\"excepcion\":0,\"custom_fields\":[]}','ISSUED','2023-01-06 14:19:13','2023-01-06 14:19:13',0,2,1,NULL),(85,2,0,0,0,0,1,1,1,1,1,1,176614027,'Mr Marcelo Aviles','3301256',NULL,85,0,11.05,85,0,3,0,'5046E57F9C2FD74','C159CB03511D66D21452F79DA24C13764558913E85046E57F9C2FD74','BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Qz4kUGhKSEJYVUFI1Q0E2QkVGMkJCR',NULL,NULL,'2023-01-06 10:31:51',1,'dc986e87-8dce-11ed-b76a-efca1bb5d89d','Ley N° 453: El proveedor deberá dar cumplimiento a las condiciones ofertadas.',0,'{\"excepcion\":0,\"custom_fields\":[]}','VOID','2023-01-06 14:31:51','2023-01-06 14:32:22',0,2,1,NULL),(86,2,0,0,0,0,1,1,1,1,1,1,176614027,'Mr Marcelo Aviles','3301256',NULL,85,0,11.05,85,0,4,0,'5046E57F9C2FD74','C159CB03511D66D265E94718659CB9782758A9A815046E57F9C2FD74','BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Qz4kUGhKSEJYVUFI1Q0E2QkVGMkJCR',NULL,NULL,'2023-01-06 10:35:55',1,'6dea94ae-8dcf-11ed-9282-83d88e63c3f6','Ley N° 453: Tienes derecho a recibir información que te proteja de la publicidad engañosa.',0,'{\"excepcion\":0,\"custom_fields\":[]}','VOID','2023-01-06 14:35:55','2023-01-06 14:36:41',0,2,1,NULL),(87,8,0,0,0,0,1,1,1,1,1,1,176614027,'Juan Perez','8457845',NULL,97.5,0,12.675,97.5,0,5,0,'5046E57F9C2FD74','C159CB03511D66D28D7E3D7F0B56DC624158C21215046E57F9C2FD74','BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Qz4kUGhKSEJYVUFI1Q0E2QkVGMkJCR',NULL,NULL,'2023-01-06 10:37:51',1,'b340fa8e-8dcf-11ed-9f3b-81b92bf18c0f','Ley N° 453: Están prohibidas las prácticas comerciales abusivas, tienes derecho a denunciarlas.',0,'{\"excepcion\":0,\"custom_fields\":[]}','ISSUED','2023-01-06 14:37:52','2023-01-06 14:37:52',0,2,1,NULL),(88,2,0,0,0,0,1,1,1,1,1,1,176614027,'Mr Marcelo Aviles','3301256',NULL,85,0,11.05,85,0,6,0,'5046E57F9C2FD74','C159CB03511D66D2C70C6516EA08C89F25D8DA7C45046E57F9C2FD74','BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Qz4kUGhKSEJYVUFI1Q0E2QkVGMkJCR',NULL,NULL,'2023-01-06 10:40:36',1,'15125449-8dd0-11ed-9366-736696aadd7a','Ley N° 453: Puedes acceder a la reclamación cuando tus derechos han sido vulnerados. ',0,'{\"excepcion\":0,\"custom_fields\":[]}','ISSUED','2023-01-06 14:40:36','2023-01-06 14:40:36',0,2,1,NULL),(89,8,0,0,0,0,1,1,1,1,1,1,176614027,'Juan Perez','8457845',NULL,12.5,0,1.625,12.5,0,7,0,'5046E57F9C2FD74','C159CB03511D66D2FFFF74036AC39CD09ED8F2E645046E57F9C2FD74','BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Qz4kUGhKSEJYVUFI1Q0E2QkVGMkJCR',NULL,NULL,'2023-01-06 10:43:18',1,'75d1eff3-8dd0-11ed-b76a-efca1bb5d89d','Ley N° 453: El proveedor de productos debe habilitar medios e instrumentos para efectuar consultas y reclamaciones.',1,'{\"excepcion\":1,\"custom_fields\":[]}','ISSUED','2023-01-06 14:43:18','2023-01-06 14:43:18',0,2,1,NULL),(90,2,7,3,0,0,1,1,1,1,1,1,176614027,'Mr Marcelo Aviles','3301256',NULL,85,0,11.05,85,0,8,0,'5046E57F9C2FD74','C159CB03511D66D318D667757834821010CF4B5065046E57F9C2FD74','BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Qz4kUGhKSEJYVUFI1Q0E2QkVGMkJCR',NULL,NULL,'2023-01-06 10:44:41',1,'a342f994-8dd1-11ed-a4b3-bb9034f4d315','Ley N° 453: Tienes derecho a recibir información que te proteja de la publicidad engañosa.',0,'{\"excepcion\":0,\"custom_fields\":[]}','ISSUED','2023-01-06 14:44:41','2023-01-06 14:44:41',0,2,1,NULL),(91,8,7,3,0,0,1,1,1,1,1,1,176614027,'Juan Perez','8457845',NULL,85,0,11.05,85,0,9,0,'5046E57F9C2FD74','C159CB03511D66D325F6D34BC1738B077F4F63BA75046E57F9C2FD74','BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Qz4kUGhKSEJYVUFI1Q0E2QkVGMkJCR',NULL,NULL,'2023-01-06 10:45:06',1,'a342f994-8dd1-11ed-a4b3-bb9034f4d315','Ley N° 453: El proveedor debe brindar atención sin discriminación, con respeto, calidez y cordialidad a los usuarios y consumidores.',0,'{\"excepcion\":0,\"custom_fields\":[]}','ISSUED','2023-01-06 14:45:06','2023-01-06 14:45:06',0,2,1,NULL),(92,8,7,3,0,0,1,1,1,1,1,1,176614027,'Juan Perez','8457845',NULL,85,0,11.05,85,0,10,0,'5046E57F9C2FD74','C159CB03511D66D328CA9BC0CD49FB3CCA4F7C2415046E57F9C2FD74','BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Qz4kUGhKSEJYVUFI1Q0E2QkVGMkJCR',NULL,NULL,'2023-01-06 10:45:20',1,'a342f994-8dd1-11ed-a4b3-bb9034f4d315','Ley N° 453: Los contratos de adhesión deben redactarse en términos claros, comprensibles, legibles y deben informar todas las facilidades y limitaciones.',0,'{\"excepcion\":0,\"custom_fields\":[]}','ISSUED','2023-01-06 14:45:20','2023-01-06 14:45:20',0,2,1,NULL),(93,2,0,0,0,0,1,1,1,1,1,1,176614027,'Mr Marcelo Aviles','3301256',NULL,85,0,11.05,85,0,11,0,'72A26A20AC2FD74','C159CB03511D66D3BBCF538733FABAA4CBD9548E272A26A20AC2FD74','QUHCoUNPJlJBQQ==RjQxMEYxNDA3NTY=Q0HDgXJ6S0hCWFVBNzI1Q0E2QkVGMkJC',NULL,NULL,'2023-01-06 10:52:48',1,'c976f12b-8dd1-11ed-8fe9-e38781a32c23','Ley N° 453: El proveedor de productos debe habilitar medios e instrumentos para efectuar consultas y reclamaciones.',0,'{\"excepcion\":0,\"custom_fields\":[]}','ISSUED','2023-01-06 14:52:48','2023-01-06 14:52:48',0,2,1,NULL),(94,2,0,0,0,0,1,1,1,1,1,1,176614027,'Mr Marcelo Aviles','3301256',NULL,85,0,11.05,85,0,12,0,'72A26A20AC2FD74','C159CB03511D66D40A2A74C5577AE069C5D96CF8872A26A20AC2FD74','QUHCoUNPJlJBQQ==RjQxMEYxNDA3NTY=Q0HDgXJ6S0hCWFVBNzI1Q0E2QkVGMkJC',NULL,NULL,'2023-01-06 10:56:36',1,'51971da0-8dd2-11ed-a327-835bced00083','Ley N° 453: Se debe promover el consumo solidario, justo, en armonía con la Madre Tierra y precautelando el hábitat, en el marco del Vivir Bien.',0,'{\"excepcion\":0,\"custom_fields\":[]}','VOID','2023-01-06 14:56:36','2023-01-06 14:56:57',0,2,1,NULL),(95,2,8,4,0,0,1,1,1,1,1,1,176614027,'Mr Marcelo Aviles','3301256',NULL,85,0,11.05,85,0,13,0,'72A26A20AC2FD74','C159CB03511D66D7995B638D64062EEC904FC562672A26A20AC2FD74','QUHCoUNPJlJBQQ==RjQxMEYxNDA3NTY=Q0HDgXJ6S0hCWFVBNzI1Q0E2QkVGMkJC',NULL,NULL,'2023-01-06 11:01:48',1,'3666194e-8dd3-11ed-ba6d-a5b244e50544','Ley N° 453: Se debe promover el consumo solidario, justo, en armonía con la Madre Tierra y precautelando el hábitat, en el marco del Vivir Bien.',0,'{\"excepcion\":0,\"custom_fields\":[]}','ISSUED','2023-01-06 15:01:48','2023-01-06 15:01:48',0,2,1,NULL);
/*!40000 ALTER TABLE `mb_invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mb_massive_batches`
--

DROP TABLE IF EXISTS `mb_massive_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mb_massive_batches` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `codigo_sucursal` bigint NOT NULL,
  `codigo_puntoventa` bigint NOT NULL,
  `codigo_documento_sector` bigint NOT NULL,
  `tipo_factura_documento` bigint NOT NULL,
  `cantidad` bigint NOT NULL,
  `codigo_recepcion` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado_recepcion` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mb_massive_batches`
--

LOCK TABLES `mb_massive_batches` WRITE;
/*!40000 ALTER TABLE `mb_massive_batches` DISABLE KEYS */;
INSERT INTO `mb_massive_batches` VALUES (1,0,0,23,0,0,NULL,NULL,'PROCESSING',NULL,'2022-12-10 11:12:33','2022-12-10 11:12:33'),(3,0,0,23,1,10,NULL,NULL,'PROCESSING',NULL,'2022-12-10 11:22:50','2022-12-10 11:22:50'),(10,0,0,23,1,5,'c0018ca8-787f-11ed-b8dc-8f90d701015a','VALIDADA','COMPLETED',NULL,'2022-12-10 11:42:39','2022-12-10 11:42:39'),(12,0,0,23,1,10,'2561cb1f-7886-11ed-ba19-69381e5a890f','VALIDADA','COMPLETED',NULL,'2022-12-10 12:28:25','2022-12-10 12:28:26');
/*!40000 ALTER TABLE `mb_massive_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mb_siat_cufd`
--

DROP TABLE IF EXISTS `mb_siat_cufd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mb_siat_cufd` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_control` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_sucursal` int NOT NULL,
  `codigo_puntoventa` int NOT NULL,
  `fecha_vigencia` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mb_siat_cufd`
--

LOCK TABLES `mb_siat_cufd` WRITE;
/*!40000 ALTER TABLE `mb_siat_cufd` DISABLE KEYS */;
INSERT INTO `mb_siat_cufd` VALUES (1,'BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QlU4WE1OV0xXVUFIzNkFBQzA0NjI0M','982A9CF5A007D74','AVENIDA AYACUCHO ESQUINA TARATA    NRO.S/N ZONA SUD',0,0,'2022-11-22 13:12:23','2022-11-21 17:12:23','2022-11-21 17:12:23'),(2,'BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QnzDjVBkWFdMV1VIzNkFBQzA0NjI0M','0F1E4C0CA007D74','AVENIDA AYACUCHO ESQUINA TARATA    NRO.S/N ZONA SUD',0,0,'2022-11-22 23:29:15','2022-11-22 03:29:16','2022-11-22 03:29:16'),(3,'QUFBPkNAZ0NCQQ==MzBBRDQ5QTYxQjY=QsKhwqFTZFhXTFdVNzIzNkFBQzA0NjI0','43B85C0CA007D74','AVENIDA AYACUCHO ESQUINA TARATA    NRO.S/N ZONA SUD',0,0,'2022-11-22 23:29:18','2022-11-22 03:29:18','2022-11-22 03:29:18'),(4,'BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QjlWVWRYV0xXVUFIzNkFBQzA0NjI0M','089E5C0CA007D74','AVENIDA AYACUCHO ESQUINA TARATA    NRO.S/N ZONA SUD',0,0,'2022-11-22 23:29:20','2022-11-22 03:29:20','2022-11-22 03:29:20'),(5,'BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qnxwa2hMWExXVUFIzNkFBQzA0NjI0M','93647680E007D74','AVENIDA AYACUCHO ESQUINA TARATA    NRO.S/N ZONA SUD',0,0,'2022-11-23 11:33:36','2022-11-22 15:33:36','2022-11-22 15:33:36'),(6,'BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QnxhSXhXWExXVUFIzNkFBQzA0NjI0M','6DE7EC27E007D74','AVENIDA AYACUCHO ESQUINA TARATA    NRO.S/N ZONA SUD',0,0,'2022-11-23 22:49:08','2022-11-23 02:49:08','2022-11-23 02:49:08'),(7,'BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhX0drTVlMV1VIzNkFBQzA0NjI0M','3175FDBC1107D74','AVENIDA AYACUCHO ESQUINA TARATA    NRO.S/N ZONA SUD',0,0,'2022-11-24 12:36:06','2022-11-23 16:36:07','2022-11-23 16:36:07'),(8,'BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QjkoY09OWUxXVUFIzNkFBQzA0NjI0M','5200553D1107D74','AVENIDA AYACUCHO ESQUINA TARATA    NRO.S/N ZONA SUD',0,0,'2022-11-24 13:14:28','2022-11-23 17:14:28','2022-11-23 17:14:28'),(9,'BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QlU8WFRKWkxXVUFIzNkFBQzA0NjI0M','246D45765107D74','AVENIDA AYACUCHO ESQUINA TARATA    NRO.S/N ZONA SUD',0,0,'2022-11-25 09:19:23','2022-11-24 13:19:23','2022-11-24 13:19:23'),(10,'BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qj48NjNRWkxXVUFIzNkFBQzA0NjI0M','2A9757DA5107D74','AVENIDA AYACUCHO ESQUINA TARATA    NRO.S/N ZONA SUD',0,0,'2022-11-25 16:54:57','2022-11-24 20:54:57','2022-11-24 20:54:57'),(11,'BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm9ZUDRRWkxXVUFIzNkFBQzA0NjI0M','0CE738DA5107D74','AVENIDA AYACUCHO ESQUINA TARATA    NRO.S/N ZONA SUD',0,0,'2022-11-25 16:55:15','2022-11-24 20:55:15','2022-11-24 20:55:15'),(12,'BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qj4rWFdMYUxXVUFIzNkFBQzA0NjI0M','0638D5439107D74','AVENIDA AYACUCHO ESQUINA TARATA    NRO.S/N ZONA SUD',0,0,'2022-11-26 11:22:23','2022-11-25 15:22:24','2022-11-25 15:22:24'),(13,'BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QlV0eUVOYUxXVUFIzNkFBQzA0NjI0M','0416FB549107D74','AVENIDA AYACUCHO ESQUINA TARATA    NRO.S/N ZONA SUD',0,0,'2022-11-26 13:04:50','2022-11-25 17:04:50','2022-11-25 17:04:50'),(14,'BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QjltajdOYUxXVUFIzNkFBQzA0NjI0M','4AF02EA49107D74','AVENIDA AYACUCHO ESQUINA TARATA    NRO.S/N ZONA SUD',0,0,'2022-11-26 13:58:35','2022-11-25 17:58:35','2022-11-25 17:58:35'),(15,'BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhXVpHVEtNV1VIzNkFBQzA0NjI0M','2FB17CB62517D74','AVENIDA AYACUCHO ESQUINA TARATA    NRO.S/N ZONA SUD',0,0,'2022-12-10 19:06:25','2022-12-09 23:06:29','2022-12-09 23:06:29'),(16,'BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm8wMVVJTE1XVUFIzNkFBQzA0NjI0M','760A8EDB5517D74','AVENIDA AYACUCHO ESQUINA TARATA    NRO.S/N ZONA SUD',0,0,'2022-12-11 08:20:52','2022-12-10 12:20:52','2022-12-10 12:20:52'),(17,'BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Qz4kUGhKSEJYVUFI1Q0E2QkVGMkJCR','5046E57F9C2FD74','PLAZA 10 DE NOVIEMBRE NRO.S/N ZONA CENTRAL',0,0,'2023-01-07 09:33:15','2023-01-06 13:33:15','2023-01-06 13:33:15'),(18,'QUHCoUNPJlJBQQ==RjQxMEYxNDA3NTY=Q0HDgXJ6S0hCWFVBNzI1Q0E2QkVGMkJC','72A26A20AC2FD74','PLAZA 10 DE NOVIEMBRE NRO.S/N ZONA CENTRAL',0,0,'2023-01-07 10:51:43','2023-01-06 14:51:43','2023-01-06 14:51:43'),(19,'BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Q1VvQURMSEJYVUFI1Q0E2QkVGMkJCR','22F01970AC2FD74','PLAZA 10 DE NOVIEMBRE NRO.S/N ZONA CENTRAL',0,0,'2023-01-07 11:03:00','2023-01-06 15:03:00','2023-01-06 15:03:00'),(20,'BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Q1U4MWdQUkJYVUFI1Q0E2QkVGMkJCR','40FA5417FE2FD74','PLAZA 10 DE NOVIEMBRE NRO.S/N ZONA CENTRAL',0,0,'2023-01-17 15:32:52','2023-01-16 19:32:52','2023-01-16 19:32:52'),(21,'BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Q0FvNXpPVUJYVUFI1Q0E2QkVGMkJCR','603F2969AF2FD74','PLAZA 10 DE NOVIEMBRE NRO.S/N ZONA CENTRAL',0,0,'2023-01-20 14:51:56','2023-01-19 18:51:56','2023-01-19 18:51:56'),(22,'BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Q3wjbWNPVkJYVUFI1Q0E2QkVGMkJCR','8F6B90E4EF2FD74','PLAZA 10 DE NOVIEMBRE NRO.S/N ZONA CENTRAL',0,0,'2023-01-21 14:28:38','2023-01-20 18:28:38','2023-01-20 18:28:38');
/*!40000 ALTER TABLE `mb_siat_cufd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mb_siat_event_packages`
--

DROP TABLE IF EXISTS `mb_siat_event_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mb_siat_event_packages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `event_id` bigint NOT NULL,
  `invoice_type` bigint NOT NULL,
  `sector_document` int NOT NULL,
  `reception_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reception_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reception_date` datetime NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mb_siat_event_packages`
--

LOCK TABLES `mb_siat_event_packages` WRITE;
/*!40000 ALTER TABLE `mb_siat_event_packages` DISABLE KEYS */;
INSERT INTO `mb_siat_event_packages` VALUES (1,2,1,1,'f3bcc8fd-6b4e-11ed-a5f2-8f1b1a44d020','PENDIENTE','2022-11-23 12:50:35','{\"envio\":{\"RespuestaServicioFacturacion\":{\"codigoDescripcion\":\"PENDIENTE\",\"codigoEstado\":901,\"codigoRecepcion\":\"f3bcc8fd-6b4e-11ed-a5f2-8f1b1a44d020\",\"transaccion\":true}},\"error_envio\":null,\"recepcion\":null,\"error_recepcion\":null}','2022-11-23 16:46:20','2022-11-23 16:50:35'),(2,3,1,1,'4a7a1b5d-6b52-11ed-b96b-c381dc50aa5c','VALIDADA','2022-11-23 13:14:29','{\"recepcion\":{\"RespuestaServicioFacturacion\":{\"codigoDescripcion\":\"VALIDADA\",\"codigoEstado\":908,\"codigoRecepcion\":\"4a7a1b5d-6b52-11ed-b96b-c381dc50aa5c\",\"transaccion\":true}}}','2022-11-23 17:14:29','2022-11-23 17:14:30'),(3,7,1,1,'a342f994-8dd1-11ed-a4b3-bb9034f4d315','VALIDADA','2023-01-06 10:51:44','{\"envio\":{\"RespuestaServicioFacturacion\":{\"codigoDescripcion\":\"PENDIENTE\",\"codigoEstado\":901,\"codigoRecepcion\":\"a342f994-8dd1-11ed-a4b3-bb9034f4d315\",\"transaccion\":true}},\"error_envio\":null,\"recepcion\":{\"RespuestaServicioFacturacion\":{\"codigoDescripcion\":\"VALIDADA\",\"codigoEstado\":908,\"codigoRecepcion\":\"a342f994-8dd1-11ed-a4b3-bb9034f4d315\",\"transaccion\":true}},\"error_recepcion\":null}','2023-01-06 14:51:44','2023-01-06 14:51:44'),(4,8,1,1,'3666194e-8dd3-11ed-ba6d-a5b244e50544','VALIDADA','2023-01-06 11:03:00','{\"envio\":{\"RespuestaServicioFacturacion\":{\"codigoDescripcion\":\"PENDIENTE\",\"codigoEstado\":901,\"codigoRecepcion\":\"3666194e-8dd3-11ed-ba6d-a5b244e50544\",\"transaccion\":true}},\"error_envio\":null,\"recepcion\":{\"RespuestaServicioFacturacion\":{\"codigoDescripcion\":\"VALIDADA\",\"codigoEstado\":908,\"codigoRecepcion\":\"3666194e-8dd3-11ed-ba6d-a5b244e50544\",\"transaccion\":true}},\"error_recepcion\":null}','2023-01-06 15:03:00','2023-01-06 15:03:00');
/*!40000 ALTER TABLE `mb_siat_event_packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mb_siat_events`
--

DROP TABLE IF EXISTS `mb_siat_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mb_siat_events` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `evento_id` bigint NOT NULL,
  `codigo_sucursal` int NOT NULL,
  `codigo_puntoventa` int NOT NULL,
  `codigo_recepcion` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `cufd` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cufd_evento` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_recepcion_paquete` varchar(26) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado_recepcion` varchar(26) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` varchar(26) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mb_siat_events`
--

LOCK TABLES `mb_siat_events` WRITE;
/*!40000 ALTER TABLE `mb_siat_events` DISABLE KEYS */;
INSERT INTO `mb_siat_events` VALUES (2,1,2,0,0,'1033742','INACCESIBILIDAD AL SERVICIO WEB DE LA ADMINISTRACIÓN TRIBUTARIA','2022-11-23 10:28:05','2022-11-23 12:44:43',NULL,'BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QnxhSXhXWExXVUFIzNkFBQzA0NjI0M',NULL,NULL,'CLOSED','','2022-11-23 14:28:05','2022-11-23 17:11:14'),(3,1,4,0,0,'1033845','VENTA EN LUGARES SIN INTERNET','2022-11-23 13:12:17','2022-11-23 13:14:28','BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QjkoY09OWUxXVUFIzNkFBQzA0NjI0M','BQUE+Q0BnQ0JBNzzBBRDQ5QTYxQjY=QsKhX0drTVlMV1VIzNkFBQzA0NjI0M',NULL,NULL,'CLOSED','','2022-11-23 17:12:17','2022-11-23 17:14:30'),(4,1,2,0,0,NULL,'INACCESIBILIDAD AL SERVICIO WEB DE LA ADMINISTRACIÓN TRIBUTARIA','2022-11-23 13:43:00',NULL,NULL,'BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QjkoY09OWUxXVUFIzNkFBQzA0NjI0M',NULL,NULL,'CLOSED','','2022-11-23 17:43:00','2022-11-23 17:47:39'),(5,1,2,0,0,NULL,'INACCESIBILIDAD AL SERVICIO WEB DE LA ADMINISTRACIÓN TRIBUTARIA','2022-11-24 17:01:57',NULL,NULL,'BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=Qm9ZUDRRWkxXVUFIzNkFBQzA0NjI0M',NULL,NULL,'CLOSED','','2022-11-24 21:01:58','2022-11-25 15:22:34'),(6,1,2,0,0,NULL,'INACCESIBILIDAD AL SERVICIO WEB DE LA ADMINISTRACIÓN TRIBUTARIA','2022-11-25 13:58:41','2022-12-09 19:23:28',NULL,'BQT5DQGdDQkE=NzzBBRDQ5QTYxQjY=QjltajdOYUxXVUFIzNkFBQzA0NjI0M',NULL,NULL,'CLOSED','','2022-11-25 17:58:41','2022-12-09 23:23:39'),(7,1,1,0,0,'1767199','CORTE DEL SERVICIO DE INTERNET','2023-01-06 10:44:37','2023-01-06 10:51:43','QUHCoUNPJlJBQQ==RjQxMEYxNDA3NTY=Q0HDgXJ6S0hCWFVBNzI1Q0E2QkVGMkJC','BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Qz4kUGhKSEJYVUFI1Q0E2QkVGMkJCR',NULL,NULL,'CLOSED','','2023-01-06 14:44:37','2023-01-06 14:51:44'),(8,1,2,0,0,'1767760','INACCESIBILIDAD AL SERVICIO WEB DE LA ADMINISTRACIÓN TRIBUTARIA','2023-01-06 11:01:39','2023-01-06 11:02:59','BQcKhQ08mUkFBNzjQxMEYxNDA3NTY=Q1VvQURMSEJYVUFI1Q0E2QkVGMkJCR','QUHCoUNPJlJBQQ==RjQxMEYxNDA3NTY=Q0HDgXJ6S0hCWFVBNzI1Q0E2QkVGMkJC',NULL,NULL,'CLOSED','','2023-01-06 15:01:39','2023-01-06 15:03:00');
/*!40000 ALTER TABLE `mb_siat_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mb_siat_puntos_venta`
--

DROP TABLE IF EXISTS `mb_siat_puntos_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mb_siat_puntos_venta` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `codigo` int NOT NULL,
  `codigo_sucursal` int NOT NULL,
  `nombre` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_id` int NOT NULL,
  `tipo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mb_siat_puntos_venta`
--

LOCK TABLES `mb_siat_puntos_venta` WRITE;
/*!40000 ALTER TABLE `mb_siat_puntos_venta` DISABLE KEYS */;
INSERT INTO `mb_siat_puntos_venta` VALUES (2,1,0,'Punto Venta 01',5,'PUNTO DE VENTA CAJEROS','2023-01-25 22:48:56','2023-01-25 22:48:56');
/*!40000 ALTER TABLE `mb_siat_puntos_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mb_siat_sucursales`
--

DROP TABLE IF EXISTS `mb_siat_sucursales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mb_siat_sucursales` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` int NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mb_siat_sucursales`
--

LOCK TABLES `mb_siat_sucursales` WRITE;
/*!40000 ALTER TABLE `mb_siat_sucursales` DISABLE KEYS */;
INSERT INTO `mb_siat_sucursales` VALUES (2,1,'Sucursal 01','direccion','La Paz','2023-01-20 19:49:46','2023-01-20 19:49:46');
/*!40000 ALTER TABLE `mb_siat_sucursales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int NOT NULL,
  `file_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `uploaded_by` int DEFAULT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_media_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  KEY `media_business_id_index` (`business_id`),
  KEY `media_uploaded_by_index` (`uploaded_by`)
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=292 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2016_06_01_000001_create_oauth_auth_codes_table',1),(4,'2016_06_01_000002_create_oauth_access_tokens_table',1),(5,'2016_06_01_000003_create_oauth_refresh_tokens_table',1),(6,'2016_06_01_000004_create_oauth_clients_table',1),(7,'2016_06_01_000005_create_oauth_personal_access_clients_table',1),(8,'2017_07_05_071953_create_currencies_table',1),(9,'2017_07_05_073658_create_business_table',1),(10,'2017_07_22_075923_add_business_id_users_table',1),(11,'2017_07_23_113209_create_brands_table',1),(12,'2017_07_26_083429_create_permission_tables',1),(13,'2017_07_26_110000_create_tax_rates_table',1),(14,'2017_07_26_122313_create_units_table',1),(15,'2017_07_27_075706_create_contacts_table',1),(16,'2017_08_04_071038_create_categories_table',1),(17,'2017_08_08_115903_create_products_table',1),(18,'2017_08_09_061616_create_variation_templates_table',1),(19,'2017_08_09_061638_create_variation_value_templates_table',1),(20,'2017_08_10_061146_create_product_variations_table',1),(21,'2017_08_10_061216_create_variations_table',1),(22,'2017_08_19_054827_create_transactions_table',1),(23,'2017_08_31_073533_create_purchase_lines_table',1),(24,'2017_10_15_064638_create_transaction_payments_table',1),(25,'2017_10_31_065621_add_default_sales_tax_to_business_table',1),(26,'2017_11_20_051930_create_table_group_sub_taxes',1),(27,'2017_11_20_063603_create_transaction_sell_lines',1),(28,'2017_11_21_064540_create_barcodes_table',1),(29,'2017_11_23_181237_create_invoice_schemes_table',1),(30,'2017_12_25_122822_create_business_locations_table',1),(31,'2017_12_25_160253_add_location_id_to_transactions_table',1),(32,'2017_12_25_163227_create_variation_location_details_table',1),(33,'2018_01_04_115627_create_sessions_table',1),(34,'2018_01_05_112817_create_invoice_layouts_table',1),(35,'2018_01_06_112303_add_invoice_scheme_id_and_invoice_layout_id_to_business_locations',1),(36,'2018_01_08_104124_create_expense_categories_table',1),(37,'2018_01_08_123327_modify_transactions_table_for_expenses',1),(38,'2018_01_09_111005_modify_payment_status_in_transactions_table',1),(39,'2018_01_09_111109_add_paid_on_column_to_transaction_payments_table',1),(40,'2018_01_25_172439_add_printer_related_fields_to_business_locations_table',1),(41,'2018_01_27_184322_create_printers_table',1),(42,'2018_01_30_181442_create_cash_registers_table',1),(43,'2018_01_31_125836_create_cash_register_transactions_table',1),(44,'2018_02_07_173326_modify_business_table',1),(45,'2018_02_08_105425_add_enable_product_expiry_column_to_business_table',1),(46,'2018_02_08_111027_add_expiry_period_and_expiry_period_type_columns_to_products_table',1),(47,'2018_02_08_131118_add_mfg_date_and_exp_date_purchase_lines_table',1),(48,'2018_02_08_155348_add_exchange_rate_to_transactions_table',1),(49,'2018_02_09_124945_modify_transaction_payments_table_for_contact_payments',1),(50,'2018_02_12_113640_create_transaction_sell_lines_purchase_lines_table',1),(51,'2018_02_12_114605_add_quantity_sold_in_purchase_lines_table',1),(52,'2018_02_13_183323_alter_decimal_fields_size',1),(53,'2018_02_14_161928_add_transaction_edit_days_to_business_table',1),(54,'2018_02_15_161032_add_document_column_to_transactions_table',1),(55,'2018_02_17_124709_add_more_options_to_invoice_layouts',1),(56,'2018_02_19_111517_add_keyboard_shortcut_column_to_business_table',1),(57,'2018_02_19_121537_stock_adjustment_move_to_transaction_table',1),(58,'2018_02_20_165505_add_is_direct_sale_column_to_transactions_table',1),(59,'2018_02_21_105329_create_system_table',1),(60,'2018_02_23_100549_version_1_2',1),(61,'2018_02_23_125648_add_enable_editing_sp_from_purchase_column_to_business_table',1),(62,'2018_02_26_103612_add_sales_commission_agent_column_to_business_table',1),(63,'2018_02_26_130519_modify_users_table_for_sales_cmmsn_agnt',1),(64,'2018_02_26_134500_add_commission_agent_to_transactions_table',1),(65,'2018_02_27_121422_add_item_addition_method_to_business_table',1),(66,'2018_02_27_170232_modify_transactions_table_for_stock_transfer',1),(67,'2018_03_05_153510_add_enable_inline_tax_column_to_business_table',1),(68,'2018_03_06_210206_modify_product_barcode_types',1),(69,'2018_03_13_181541_add_expiry_type_to_business_table',1),(70,'2018_03_16_113446_product_expiry_setting_for_business',1),(71,'2018_03_19_113601_add_business_settings_options',1),(72,'2018_03_26_125334_add_pos_settings_to_business_table',1),(73,'2018_03_26_165350_create_customer_groups_table',1),(74,'2018_03_27_122720_customer_group_related_changes_in_tables',1),(75,'2018_03_29_110138_change_tax_field_to_nullable_in_business_table',1),(76,'2018_03_29_115502_add_changes_for_sr_number_in_products_and_sale_lines_table',1),(77,'2018_03_29_134340_add_inline_discount_fields_in_purchase_lines',1),(78,'2018_03_31_140921_update_transactions_table_exchange_rate',1),(79,'2018_04_03_103037_add_contact_id_to_contacts_table',1),(80,'2018_04_03_122709_add_changes_to_invoice_layouts_table',1),(81,'2018_04_09_135320_change_exchage_rate_size_in_business_table',1),(82,'2018_04_17_123122_add_lot_number_to_business',1),(83,'2018_04_17_160845_add_product_racks_table',1),(84,'2018_04_20_182015_create_res_tables_table',1),(85,'2018_04_24_105246_restaurant_fields_in_transaction_table',1),(86,'2018_04_24_114149_add_enabled_modules_business_table',1),(87,'2018_04_24_133704_add_modules_fields_in_invoice_layout_table',1),(88,'2018_04_27_132653_quotation_related_change',1),(89,'2018_05_02_104439_add_date_format_and_time_format_to_business',1),(90,'2018_05_02_111939_add_sell_return_to_transaction_payments',1),(91,'2018_05_14_114027_add_rows_positions_for_products',1),(92,'2018_05_14_125223_add_weight_to_products_table',1),(93,'2018_05_14_164754_add_opening_stock_permission',1),(94,'2018_05_15_134729_add_design_to_invoice_layouts',1),(95,'2018_05_16_183307_add_tax_fields_invoice_layout',1),(96,'2018_05_18_191956_add_sell_return_to_transaction_table',1),(97,'2018_05_21_131349_add_custom_fileds_to_contacts_table',1),(98,'2018_05_21_131607_invoice_layout_fields_for_sell_return',1),(99,'2018_05_21_131949_add_custom_fileds_and_website_to_business_locations_table',1),(100,'2018_05_22_123527_create_reference_counts_table',1),(101,'2018_05_22_154540_add_ref_no_prefixes_column_to_business_table',1),(102,'2018_05_24_132620_add_ref_no_column_to_transaction_payments_table',1),(103,'2018_05_24_161026_add_location_id_column_to_business_location_table',1),(104,'2018_05_25_180603_create_modifiers_related_table',1),(105,'2018_05_29_121714_add_purchase_line_id_to_stock_adjustment_line_table',1),(106,'2018_05_31_114645_add_res_order_status_column_to_transactions_table',1),(107,'2018_06_05_103530_rename_purchase_line_id_in_stock_adjustment_lines_table',1),(108,'2018_06_05_111905_modify_products_table_for_modifiers',1),(109,'2018_06_06_110524_add_parent_sell_line_id_column_to_transaction_sell_lines_table',1),(110,'2018_06_07_152443_add_is_service_staff_to_roles_table',1),(111,'2018_06_07_182258_add_image_field_to_products_table',1),(112,'2018_06_13_133705_create_bookings_table',1),(113,'2018_06_15_173636_add_email_column_to_contacts_table',1),(114,'2018_06_27_182835_add_superadmin_related_fields_business',1),(115,'2018_07_10_101913_add_custom_fields_to_products_table',1),(116,'2018_07_17_103434_add_sales_person_name_label_to_invoice_layouts_table',1),(117,'2018_07_17_163920_add_theme_skin_color_column_to_business_table',1),(118,'2018_07_24_160319_add_lot_no_line_id_to_transaction_sell_lines_table',1),(119,'2018_07_25_110004_add_show_expiry_and_show_lot_colums_to_invoice_layouts_table',1),(120,'2018_07_25_172004_add_discount_columns_to_transaction_sell_lines_table',1),(121,'2018_07_26_124720_change_design_column_type_in_invoice_layouts_table',1),(122,'2018_07_26_170424_add_unit_price_before_discount_column_to_transaction_sell_line_table',1),(123,'2018_07_28_103614_add_credit_limit_column_to_contacts_table',1),(124,'2018_08_08_110755_add_new_payment_methods_to_transaction_payments_table',1),(125,'2018_08_08_122225_modify_cash_register_transactions_table_for_new_payment_methods',1),(126,'2018_08_14_104036_add_opening_balance_type_to_transactions_table',1),(127,'2018_09_04_155900_create_accounts_table',1),(128,'2018_09_06_114438_create_selling_price_groups_table',1),(129,'2018_09_06_154057_create_variation_group_prices_table',1),(130,'2018_09_07_102413_add_permission_to_access_default_selling_price',1),(131,'2018_09_07_134858_add_selling_price_group_id_to_transactions_table',1),(132,'2018_09_10_112448_update_product_type_to_single_if_null_in_products_table',1),(133,'2018_09_10_152703_create_account_transactions_table',1),(134,'2018_09_10_173656_add_account_id_column_to_transaction_payments_table',1),(135,'2018_09_19_123914_create_notification_templates_table',1),(136,'2018_09_22_110504_add_sms_and_email_settings_columns_to_business_table',1),(137,'2018_09_24_134942_add_lot_no_line_id_to_stock_adjustment_lines_table',1),(138,'2018_09_26_105557_add_transaction_payments_for_existing_expenses',1),(139,'2018_09_27_111609_modify_transactions_table_for_purchase_return',1),(140,'2018_09_27_131154_add_quantity_returned_column_to_purchase_lines_table',1),(141,'2018_10_02_131401_add_return_quantity_column_to_transaction_sell_lines_table',1),(142,'2018_10_03_104918_add_qty_returned_column_to_transaction_sell_lines_purchase_lines_table',1),(143,'2018_10_03_185947_add_default_notification_templates_to_database',1),(144,'2018_10_09_153105_add_business_id_to_transaction_payments_table',1),(145,'2018_10_16_135229_create_permission_for_sells_and_purchase',1),(146,'2018_10_22_114441_add_columns_for_variable_product_modifications',1),(147,'2018_10_22_134428_modify_variable_product_data',1),(148,'2018_10_30_181558_add_table_tax_headings_to_invoice_layout',1),(149,'2018_10_31_122619_add_pay_terms_field_transactions_table',1),(150,'2018_10_31_161328_add_new_permissions_for_pos_screen',1),(151,'2018_10_31_174752_add_access_selected_contacts_only_to_users_table',1),(152,'2018_10_31_175627_add_user_contact_access',1),(153,'2018_10_31_180559_add_auto_send_sms_column_to_notification_templates_table',1),(154,'2018_11_02_171949_change_card_type_column_to_varchar_in_transaction_payments_table',1),(155,'2018_11_08_105621_add_role_permissions',1),(156,'2018_11_26_114135_add_is_suspend_column_to_transactions_table',1),(157,'2018_11_28_104410_modify_units_table_for_multi_unit',1),(158,'2018_11_28_170952_add_sub_unit_id_to_purchase_lines_and_sell_lines',1),(159,'2018_11_29_115918_add_primary_key_in_system_table',1),(160,'2018_12_03_185546_add_product_description_column_to_products_table',1),(161,'2018_12_06_114937_modify_system_table_and_users_table',1),(162,'2018_12_13_160007_add_custom_fields_display_options_to_invoice_layouts_table',1),(163,'2018_12_14_103307_modify_system_table',1),(164,'2018_12_18_133837_add_prev_balance_due_columns_to_invoice_layouts_table',1),(165,'2018_12_18_170656_add_invoice_token_column_to_transaction_table',1),(166,'2018_12_20_133639_add_date_time_format_column_to_invoice_layouts_table',1),(167,'2018_12_21_120659_add_recurring_invoice_fields_to_transactions_table',1),(168,'2018_12_24_154933_create_notifications_table',1),(169,'2019_01_08_112015_add_document_column_to_transaction_payments_table',1),(170,'2019_01_10_124645_add_account_permission',1),(171,'2019_01_16_125825_add_subscription_no_column_to_transactions_table',1),(172,'2019_01_28_111647_add_order_addresses_column_to_transactions_table',1),(173,'2019_02_13_173821_add_is_inactive_column_to_products_table',1),(174,'2019_02_19_103118_create_discounts_table',1),(175,'2019_02_21_120324_add_discount_id_column_to_transaction_sell_lines_table',1),(176,'2019_02_21_134324_add_permission_for_discount',1),(177,'2019_03_04_170832_add_service_staff_columns_to_transaction_sell_lines_table',1),(178,'2019_03_09_102425_add_sub_type_column_to_transactions_table',1),(179,'2019_03_09_124457_add_indexing_transaction_sell_lines_purchase_lines_table',1),(180,'2019_03_12_120336_create_activity_log_table',1),(181,'2019_03_15_132925_create_media_table',1),(182,'2019_05_08_130339_add_indexing_to_parent_id_in_transaction_payments_table',1),(183,'2019_05_10_132311_add_missing_column_indexing',1),(184,'2019_05_14_091812_add_show_image_column_to_invoice_layouts_table',1),(185,'2019_05_25_104922_add_view_purchase_price_permission',1),(186,'2019_06_17_103515_add_profile_informations_columns_to_users_table',1),(187,'2019_06_18_135524_add_permission_to_view_own_sales_only',1),(188,'2019_06_19_112058_add_database_changes_for_reward_points',1),(189,'2019_06_28_133732_change_type_column_to_string_in_transactions_table',1),(190,'2019_07_13_111420_add_is_created_from_api_column_to_transactions_table',1),(191,'2019_07_15_165136_add_fields_for_combo_product',1),(192,'2019_07_19_103446_add_mfg_quantity_used_column_to_purchase_lines_table',1),(193,'2019_07_22_152649_add_not_for_selling_in_product_table',1),(194,'2019_07_29_185351_add_show_reward_point_column_to_invoice_layouts_table',1),(195,'2019_08_08_162302_add_sub_units_related_fields',1),(196,'2019_08_26_133419_update_price_fields_decimal_point',1),(197,'2019_09_02_160054_remove_location_permissions_from_roles',1),(198,'2019_09_03_185259_add_permission_for_pos_screen',1),(199,'2019_09_04_163141_add_location_id_to_cash_registers_table',1),(200,'2019_09_04_184008_create_types_of_services_table',1),(201,'2019_09_06_131445_add_types_of_service_fields_to_transactions_table',1),(202,'2019_09_09_134810_add_default_selling_price_group_id_column_to_business_locations_table',1),(203,'2019_09_12_105616_create_product_locations_table',1),(204,'2019_09_17_122522_add_custom_labels_column_to_business_table',1),(205,'2019_09_18_164319_add_shipping_fields_to_transactions_table',1),(206,'2019_09_19_170927_close_all_active_registers',1),(207,'2019_09_23_161906_add_media_description_cloumn_to_media_table',1),(208,'2019_10_18_155633_create_account_types_table',1),(209,'2019_10_22_163335_add_common_settings_column_to_business_table',1),(210,'2019_10_29_132521_add_update_purchase_status_permission',1),(211,'2019_11_09_110522_add_indexing_to_lot_number',1),(212,'2019_11_19_170824_add_is_active_column_to_business_locations_table',1),(213,'2019_11_21_162913_change_quantity_field_types_to_decimal',1),(214,'2019_11_25_160340_modify_categories_table_for_polymerphic_relationship',1),(215,'2019_12_02_105025_create_warranties_table',1),(216,'2019_12_03_180342_add_common_settings_field_to_invoice_layouts_table',1),(217,'2019_12_05_183955_add_more_fields_to_users_table',1),(218,'2019_12_06_174904_add_change_return_label_column_to_invoice_layouts_table',1),(219,'2019_12_11_121307_add_draft_and_quotation_list_permissions',1),(220,'2019_12_12_180126_copy_expense_total_to_total_before_tax',1),(221,'2019_12_19_181412_make_alert_quantity_field_nullable_on_products_table',1),(222,'2019_12_25_173413_create_dashboard_configurations_table',1),(223,'2020_01_08_133506_create_document_and_notes_table',1),(224,'2020_01_09_113252_add_cc_bcc_column_to_notification_templates_table',1),(225,'2020_01_16_174818_add_round_off_amount_field_to_transactions_table',1),(226,'2020_01_28_162345_add_weighing_scale_settings_in_business_settings_table',1),(227,'2020_02_18_172447_add_import_fields_to_transactions_table',1),(228,'2020_03_13_135844_add_is_active_column_to_selling_price_groups_table',1),(229,'2020_03_16_115449_add_contact_status_field_to_contacts_table',1),(230,'2020_03_26_124736_add_allow_login_column_in_users_table',1),(231,'2020_04_13_154150_add_feature_products_column_to_business_loactions',1),(232,'2020_04_15_151802_add_user_type_to_users_table',1),(233,'2020_04_22_153905_add_subscription_repeat_on_column_to_transactions_table',1),(234,'2020_04_28_111436_add_shipping_address_to_contacts_table',1),(235,'2020_06_01_094654_add_max_sale_discount_column_to_users_table',1),(236,'2020_06_12_162245_modify_contacts_table',1),(237,'2020_06_22_103104_change_recur_interval_default_to_one',1),(238,'2020_07_09_174621_add_balance_field_to_contacts_table',1),(239,'2020_07_23_104933_change_status_column_to_varchar_in_transaction_table',1),(240,'2020_09_07_171059_change_completed_stock_transfer_status_to_final',1),(241,'2020_09_21_123224_modify_booking_status_column_in_bookings_table',1),(242,'2020_09_22_121639_create_discount_variations_table',1),(243,'2020_10_05_121550_modify_business_location_table_for_invoice_layout',1),(244,'2020_10_16_175726_set_status_as_received_for_opening_stock',1),(245,'2020_10_23_170823_add_for_group_tax_column_to_tax_rates_table',1),(246,'2020_11_04_130940_add_more_custom_fields_to_contacts_table',1),(247,'2020_11_10_152841_add_cash_register_permissions',1),(248,'2020_11_17_164041_modify_type_column_to_varchar_in_contacts_table',1),(249,'2020_12_18_181447_add_shipping_custom_fields_to_transactions_table',1),(250,'2020_12_22_164303_add_sub_status_column_to_transactions_table',1),(251,'2020_12_24_153050_add_custom_fields_to_transactions_table',1),(252,'2020_12_28_105403_add_whatsapp_text_column_to_notification_templates_table',1),(253,'2020_12_29_165925_add_model_document_type_to_media_table',1),(254,'2021_02_08_175632_add_contact_number_fields_to_users_table',1),(255,'2021_02_11_172217_add_indexing_for_multiple_columns',1),(256,'2021_02_23_122043_add_more_columns_to_customer_groups_table',1),(257,'2021_02_24_175551_add_print_invoice_permission_to_all_roles',1),(258,'2021_03_03_162021_add_purchase_order_columns_to_purchase_lines_and_transactions_table',1),(259,'2021_03_11_120229_add_sales_order_columns',1),(260,'2021_03_16_120705_add_business_id_to_activity_log_table',1),(261,'2021_03_16_153427_add_code_columns_to_business_table',1),(262,'2021_03_18_173308_add_account_details_column_to_accounts_table',1),(263,'2021_03_18_183119_add_prefer_payment_account_columns_to_transactions_table',1),(264,'2021_03_22_120810_add_more_types_of_service_custom_fields',1),(265,'2021_03_24_183132_add_shipping_export_custom_field_details_to_contacts_table',1),(266,'2021_03_25_170715_add_export_custom_fields_info_to_transactions_table',1),(267,'2021_04_15_063449_add_denominations_column_to_cash_registers_table',1),(268,'2021_05_22_083426_add_indexing_to_account_transactions_table',1),(269,'2021_07_08_065808_add_additional_expense_columns_to_transaction_table',1),(270,'2021_07_13_082918_add_qr_code_columns_to_invoice_layouts_table',1),(271,'2021_07_21_061615_add_fields_to_show_commission_agent_in_invoice_layout',1),(272,'2021_08_13_105549_add_crm_contact_id_to_users_table',1),(273,'2021_08_25_114932_add_payment_link_fields_to_transaction_payments_table',1),(274,'2021_09_01_063110_add_spg_column_to_discounts_table',1),(275,'2021_09_03_061528_modify_cash_register_transactions_table',1),(276,'2021_10_05_061658_add_source_column_to_transactions_table',1),(277,'2021_12_16_121851_add_parent_id_column_to_expense_categories_table',1),(278,'2022_10_13_134351_invoices',2),(279,'2022_10_13_140502_invoice_items',2),(280,'2022_10_13_140537_siat_events',2),(281,'2022_10_13_140605_siat_event_packages',2),(282,'2022_10_13_140643_siat_cufd',2),(283,'2022_10_13_140715_siat_puntos_venta',2),(285,'2022_11_10_123135_invoice_env',2),(286,'2022_11_22_174827_product_fields',3),(287,'2022_11_29_140602_invoices_massive',4),(288,'2022_11_29_140643_massive_batches',4),(289,'2023_01_06_114820_customers',5),(290,'2023_01_06_114848_products',5),(291,'2022_10_13_140742_siat_sucursales',6);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` int unsigned NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
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
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` int unsigned NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
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
INSERT INTO `model_has_roles` VALUES (1,'App\\User',1);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_templates`
--

DROP TABLE IF EXISTS `notification_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_templates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_templates`
--

LOCK TABLES `notification_templates` WRITE;
/*!40000 ALTER TABLE `notification_templates` DISABLE KEYS */;
INSERT INTO `notification_templates` VALUES (1,1,'new_sale','<p>Dear {contact_name},</p>\n\n                    <p>Your invoice number is {invoice_number}<br />\n                    Total amount: {total_amount}<br />\n                    Paid amount: {received_amount}</p>\n\n                    <p>Thank you for shopping with us.</p>\n\n                    <p>{business_logo}</p>\n\n                    <p>&nbsp;</p>','Dear {contact_name}, Thank you for shopping with us. {business_name}',NULL,'Thank you from {business_name}',NULL,NULL,0,0,0,'2022-11-21 16:46:25','2022-11-21 16:46:25'),(2,1,'payment_received','<p>Dear {contact_name},</p>\n\n                <p>We have received a payment of {received_amount}</p>\n\n                <p>{business_logo}</p>','Dear {contact_name}, We have received a payment of {received_amount}. {business_name}',NULL,'Payment Received, from {business_name}',NULL,NULL,0,0,0,'2022-11-21 16:46:25','2022-11-21 16:46:25'),(3,1,'payment_reminder','<p>Dear {contact_name},</p>\n\n                    <p>This is to remind you that you have pending payment of {due_amount}. Kindly pay it as soon as possible.</p>\n\n                    <p>{business_logo}</p>','Dear {contact_name}, You have pending payment of {due_amount}. Kindly pay it as soon as possible. {business_name}',NULL,'Payment Reminder, from {business_name}',NULL,NULL,0,0,0,'2022-11-21 16:46:25','2022-11-21 16:46:25'),(4,1,'new_booking','<p>Dear {contact_name},</p>\n\n                    <p>Your booking is confirmed</p>\n\n                    <p>Date: {start_time} to {end_time}</p>\n\n                    <p>Table: {table}</p>\n\n                    <p>Location: {location}</p>\n\n                    <p>{business_logo}</p>','Dear {contact_name}, Your booking is confirmed. Date: {start_time} to {end_time}, Table: {table}, Location: {location}',NULL,'Booking Confirmed - {business_name}',NULL,NULL,0,0,0,'2022-11-21 16:46:25','2022-11-21 16:46:25'),(5,1,'new_order','<p>Dear {contact_name},</p>\n\n                    <p>We have a new order with reference number {order_ref_number}. Kindly process the products as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>','Dear {contact_name}, We have a new order with reference number {order_ref_number}. Kindly process the products as soon as possible. {business_name}',NULL,'New Order, from {business_name}',NULL,NULL,0,0,0,'2022-11-21 16:46:25','2022-11-21 16:46:25'),(6,1,'payment_paid','<p>Dear {contact_name},</p>\n\n                    <p>We have paid amount {paid_amount} again invoice number {order_ref_number}.<br />\n                    Kindly note it down.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>','We have paid amount {paid_amount} again invoice number {order_ref_number}.\n                    Kindly note it down. {business_name}',NULL,'Payment Paid, from {business_name}',NULL,NULL,0,0,0,'2022-11-21 16:46:25','2022-11-21 16:46:25'),(7,1,'items_received','<p>Dear {contact_name},</p>\n\n                    <p>We have received all items from invoice reference number {order_ref_number}. Thank you for processing it.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>','We have received all items from invoice reference number {order_ref_number}. Thank you for processing it. {business_name}',NULL,'Items received, from {business_name}',NULL,NULL,0,0,0,'2022-11-21 16:46:25','2022-11-21 16:46:25'),(8,1,'items_pending','<p>Dear {contact_name},<br />\n                    This is to remind you that we have not yet received some items from invoice reference number {order_ref_number}. Please process it as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>','This is to remind you that we have not yet received some items from invoice reference number {order_ref_number} . Please process it as soon as possible.{business_name}',NULL,'Items Pending, from {business_name}',NULL,NULL,0,0,0,'2022-11-21 16:46:25','2022-11-21 16:46:25'),(9,1,'new_quotation','<p>Dear {contact_name},</p>\n\n                    <p>Your quotation number is {invoice_number}<br />\n                    Total amount: {total_amount}</p>\n\n                    <p>Thank you for shopping with us.</p>\n\n                    <p>{business_logo}</p>\n\n                    <p>&nbsp;</p>','Dear {contact_name}, Thank you for shopping with us. {business_name}',NULL,'Thank you from {business_name}',NULL,NULL,0,0,0,'2022-11-21 16:46:25','2022-11-21 16:46:25');
/*!40000 ALTER TABLE `notification_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `client_id` int unsigned NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint NOT NULL,
  `client_id` int unsigned NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_clients` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int unsigned NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
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
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'profit_loss_report.view','web','2022-11-21 16:43:47',NULL),(2,'direct_sell.access','web','2022-11-21 16:43:47',NULL),(3,'product.opening_stock','web','2022-11-21 16:43:49','2022-11-21 16:43:49'),(4,'crud_all_bookings','web','2022-11-21 16:43:50','2022-11-21 16:43:50'),(5,'crud_own_bookings','web','2022-11-21 16:43:50','2022-11-21 16:43:50'),(6,'access_default_selling_price','web','2022-11-21 16:43:51','2022-11-21 16:43:51'),(7,'purchase.payments','web','2022-11-21 16:43:51','2022-11-21 16:43:51'),(8,'sell.payments','web','2022-11-21 16:43:51','2022-11-21 16:43:51'),(9,'edit_product_price_from_sale_screen','web','2022-11-21 16:43:52','2022-11-21 16:43:52'),(10,'edit_product_discount_from_sale_screen','web','2022-11-21 16:43:52','2022-11-21 16:43:52'),(11,'roles.view','web','2022-11-21 16:43:52','2022-11-21 16:43:52'),(12,'roles.create','web','2022-11-21 16:43:52','2022-11-21 16:43:52'),(13,'roles.update','web','2022-11-21 16:43:52','2022-11-21 16:43:52'),(14,'roles.delete','web','2022-11-21 16:43:52','2022-11-21 16:43:52'),(15,'account.access','web','2022-11-21 16:43:52','2022-11-21 16:43:52'),(16,'discount.access','web','2022-11-21 16:43:53','2022-11-21 16:43:53'),(17,'view_purchase_price','web','2022-11-21 16:43:53','2022-11-21 16:43:53'),(18,'view_own_sell_only','web','2022-11-21 16:43:53','2022-11-21 16:43:53'),(19,'edit_product_discount_from_pos_screen','web','2022-11-21 16:43:54','2022-11-21 16:43:54'),(20,'edit_product_price_from_pos_screen','web','2022-11-21 16:43:54','2022-11-21 16:43:54'),(21,'access_shipping','web','2022-11-21 16:43:55','2022-11-21 16:43:55'),(22,'purchase.update_status','web','2022-11-21 16:43:55','2022-11-21 16:43:55'),(23,'list_drafts','web','2022-11-21 16:43:55','2022-11-21 16:43:55'),(24,'list_quotations','web','2022-11-21 16:43:55','2022-11-21 16:43:55'),(25,'view_cash_register','web','2022-11-21 16:43:57','2022-11-21 16:43:57'),(26,'close_cash_register','web','2022-11-21 16:43:58','2022-11-21 16:43:58'),(27,'print_invoice','web','2022-11-21 16:43:59','2022-11-21 16:43:59'),(28,'user.view','web','2022-11-21 16:44:01',NULL),(29,'user.create','web','2022-11-21 16:44:01',NULL),(30,'user.update','web','2022-11-21 16:44:01',NULL),(31,'user.delete','web','2022-11-21 16:44:01',NULL),(32,'supplier.view','web','2022-11-21 16:44:01',NULL),(33,'supplier.create','web','2022-11-21 16:44:01',NULL),(34,'supplier.update','web','2022-11-21 16:44:01',NULL),(35,'supplier.delete','web','2022-11-21 16:44:01',NULL),(36,'customer.view','web','2022-11-21 16:44:01',NULL),(37,'customer.create','web','2022-11-21 16:44:01',NULL),(38,'customer.update','web','2022-11-21 16:44:01',NULL),(39,'customer.delete','web','2022-11-21 16:44:01',NULL),(40,'product.view','web','2022-11-21 16:44:01',NULL),(41,'product.create','web','2022-11-21 16:44:01',NULL),(42,'product.update','web','2022-11-21 16:44:01',NULL),(43,'product.delete','web','2022-11-21 16:44:01',NULL),(44,'purchase.view','web','2022-11-21 16:44:01',NULL),(45,'purchase.create','web','2022-11-21 16:44:01',NULL),(46,'purchase.update','web','2022-11-21 16:44:01',NULL),(47,'purchase.delete','web','2022-11-21 16:44:01',NULL),(48,'sell.view','web','2022-11-21 16:44:01',NULL),(49,'sell.create','web','2022-11-21 16:44:01',NULL),(50,'sell.update','web','2022-11-21 16:44:01',NULL),(51,'sell.delete','web','2022-11-21 16:44:01',NULL),(52,'purchase_n_sell_report.view','web','2022-11-21 16:44:01',NULL),(53,'contacts_report.view','web','2022-11-21 16:44:01',NULL),(54,'stock_report.view','web','2022-11-21 16:44:01',NULL),(55,'tax_report.view','web','2022-11-21 16:44:01',NULL),(56,'trending_product_report.view','web','2022-11-21 16:44:01',NULL),(57,'register_report.view','web','2022-11-21 16:44:01',NULL),(58,'sales_representative.view','web','2022-11-21 16:44:01',NULL),(59,'expense_report.view','web','2022-11-21 16:44:01',NULL),(60,'business_settings.access','web','2022-11-21 16:44:01',NULL),(61,'barcode_settings.access','web','2022-11-21 16:44:01',NULL),(62,'invoice_settings.access','web','2022-11-21 16:44:01',NULL),(63,'brand.view','web','2022-11-21 16:44:01',NULL),(64,'brand.create','web','2022-11-21 16:44:01',NULL),(65,'brand.update','web','2022-11-21 16:44:01',NULL),(66,'brand.delete','web','2022-11-21 16:44:01',NULL),(67,'tax_rate.view','web','2022-11-21 16:44:01',NULL),(68,'tax_rate.create','web','2022-11-21 16:44:01',NULL),(69,'tax_rate.update','web','2022-11-21 16:44:01',NULL),(70,'tax_rate.delete','web','2022-11-21 16:44:01',NULL),(71,'unit.view','web','2022-11-21 16:44:01',NULL),(72,'unit.create','web','2022-11-21 16:44:01',NULL),(73,'unit.update','web','2022-11-21 16:44:01',NULL),(74,'unit.delete','web','2022-11-21 16:44:01',NULL),(75,'category.view','web','2022-11-21 16:44:01',NULL),(76,'category.create','web','2022-11-21 16:44:01',NULL),(77,'category.update','web','2022-11-21 16:44:01',NULL),(78,'category.delete','web','2022-11-21 16:44:01',NULL),(79,'expense.access','web','2022-11-21 16:44:01',NULL),(80,'access_all_locations','web','2022-11-21 16:44:01',NULL),(81,'dashboard.data','web','2022-11-21 16:44:01',NULL),(82,'manage_modules','web','2022-11-21 16:44:01',NULL),(83,'location.1','web','2022-11-21 16:46:25','2022-11-21 16:46:25');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `printers`
--

DROP TABLE IF EXISTS `printers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `printers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection_type` enum('network','windows','linux') COLLATE utf8mb4_unicode_ci NOT NULL,
  `capability_profile` enum('default','simple','SP2000','TEP-200M','P822D') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `char_per_line` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `port` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int unsigned NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_locations` (
  `product_id` int NOT NULL,
  `location_id` int NOT NULL,
  KEY `product_locations_product_id_index` (`product_id`),
  KEY `product_locations_location_id_index` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_locations`
--

LOCK TABLES `product_locations` WRITE;
/*!40000 ALTER TABLE `product_locations` DISABLE KEYS */;
INSERT INTO `product_locations` VALUES (1,1),(2,1),(3,1),(4,1);
/*!40000 ALTER TABLE `product_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_racks`
--

DROP TABLE IF EXISTS `product_racks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_racks` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int unsigned NOT NULL,
  `location_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_variations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `variation_template_id` int DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int unsigned NOT NULL,
  `is_dummy` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_variations_name_index` (`name`),
  KEY `product_variations_product_id_index` (`product_id`),
  CONSTRAINT `product_variations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_variations`
--

LOCK TABLES `product_variations` WRITE;
/*!40000 ALTER TABLE `product_variations` DISABLE KEYS */;
INSERT INTO `product_variations` VALUES (1,NULL,'DUMMY',1,1,'2022-11-22 22:05:48','2022-11-22 22:05:48'),(2,NULL,'DUMMY',2,1,'2022-12-09 23:26:52','2022-12-09 23:26:52'),(3,NULL,'DUMMY',3,1,'2023-01-06 13:39:39','2023-01-06 13:39:39'),(4,NULL,'DUMMY',4,1,'2023-01-06 14:36:08','2023-01-06 14:36:08');
/*!40000 ALTER TABLE `product_variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int unsigned NOT NULL,
  `type` enum('single','variable','modifier','combo') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_id` int unsigned DEFAULT NULL,
  `sub_unit_ids` text COLLATE utf8mb4_unicode_ci,
  `brand_id` int unsigned DEFAULT NULL,
  `category_id` int unsigned DEFAULT NULL,
  `sub_category_id` int unsigned DEFAULT NULL,
  `tax` int unsigned DEFAULT NULL,
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
  `product_description` text COLLATE utf8mb4_unicode_ci,
  `created_by` int unsigned NOT NULL,
  `warranty_id` int DEFAULT NULL,
  `is_inactive` tinyint(1) NOT NULL DEFAULT '0',
  `not_for_selling` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `unidad_medida` bigint NOT NULL,
  `actividad_economica` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_producto_sin` bigint NOT NULL,
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
  CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_tax_foreign` FOREIGN KEY (`tax`) REFERENCES `tax_rates` (`id`),
  CONSTRAINT `products_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Producto de Prueba',1,'single',1,NULL,NULL,NULL,NULL,NULL,'exclusive',0,0.0000,'P001','C128',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0,0,'2022-11-22 22:05:48','2022-11-25 16:12:08',58,'522000',99100),(2,'Uso de terminal',1,'single',1,NULL,NULL,NULL,NULL,NULL,'exclusive',0,0.0000,'T001','C128',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0,0,'2022-12-09 23:26:52','2022-12-09 23:26:52',58,'522000',67410),(3,'SIS-HDB Prueba 01',1,'single',1,NULL,NULL,NULL,NULL,NULL,'exclusive',1,NULL,'SIS-HDB-P001','C128',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0,0,'2023-01-06 13:39:39','2023-01-06 13:39:39',57,'841130',83221),(4,'consulta emergencia',1,'single',2,NULL,NULL,NULL,NULL,NULL,'exclusive',1,NULL,'123','C128',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0,0,'2023-01-06 14:36:08','2023-01-06 14:36:08',58,'841130',832229);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_lines`
--

DROP TABLE IF EXISTS `purchase_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_lines` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  `variation_id` int unsigned NOT NULL,
  `quantity` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `pp_without_discount` decimal(22,4) NOT NULL DEFAULT '0.0000' COMMENT 'Purchase price before inline discounts',
  `discount_percent` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT 'Inline discount percentage',
  `purchase_price` decimal(22,4) NOT NULL,
  `purchase_price_inc_tax` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `item_tax` decimal(22,4) NOT NULL COMMENT 'Tax for one quantity',
  `tax_id` int unsigned DEFAULT NULL,
  `purchase_order_line_id` int DEFAULT NULL,
  `quantity_sold` decimal(22,4) NOT NULL DEFAULT '0.0000' COMMENT 'Quanity sold from this purchase line',
  `quantity_adjusted` decimal(22,4) NOT NULL DEFAULT '0.0000' COMMENT 'Quanity adjusted in stock adjustment from this purchase line',
  `quantity_returned` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `po_quantity_purchased` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `mfg_quantity_used` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `mfg_date` date DEFAULT NULL,
  `exp_date` date DEFAULT NULL,
  `lot_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_unit_id` int DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_lines`
--

LOCK TABLES `purchase_lines` WRITE;
/*!40000 ALTER TABLE `purchase_lines` DISABLE KEYS */;
INSERT INTO `purchase_lines` VALUES (1,3,4,4,50.0000,10.0000,0.00,10.0000,10.0000,0.0000,NULL,NULL,4.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,NULL,NULL,'2023-01-06 15:00:35','2023-01-06 15:02:10');
/*!40000 ALTER TABLE `purchase_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reference_counts`
--

DROP TABLE IF EXISTS `reference_counts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reference_counts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ref_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ref_count` int NOT NULL,
  `business_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reference_counts_business_id_index` (`business_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reference_counts`
--

LOCK TABLES `reference_counts` WRITE;
/*!40000 ALTER TABLE `reference_counts` DISABLE KEYS */;
INSERT INTO `reference_counts` VALUES (1,'contacts',10,1,'2022-11-21 16:46:25','2023-01-06 13:58:33'),(2,'business_location',1,1,'2022-11-21 16:46:25','2022-11-21 16:46:25'),(3,'sell_payment',2,1,'2023-01-06 15:01:10','2023-01-06 15:02:10');
/*!40000 ALTER TABLE `reference_counts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_product_modifier_sets`
--

DROP TABLE IF EXISTS `res_product_modifier_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_product_modifier_sets` (
  `modifier_set_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL COMMENT 'Table use to store the modifier sets applicable for a product',
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_tables` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int unsigned NOT NULL,
  `location_id` int unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_by` int unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `res_tables_business_id_foreign` (`business_id`),
  CONSTRAINT `res_tables_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_tables`
--

LOCK TABLES `res_tables` WRITE;
/*!40000 ALTER TABLE `res_tables` DISABLE KEYS */;
/*!40000 ALTER TABLE `res_tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` int unsigned NOT NULL,
  `role_id` int unsigned NOT NULL,
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
INSERT INTO `role_has_permissions` VALUES (25,2),(26,2),(48,2),(49,2),(50,2),(51,2),(80,2);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int unsigned NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_service_staff` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roles_business_id_foreign` (`business_id`),
  CONSTRAINT `roles_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin#1','web',1,1,0,'2022-11-21 16:46:25','2022-11-21 16:46:25'),(2,'Cashier#1','web',1,0,0,'2022-11-21 16:46:25','2022-11-21 16:46:25');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sell_line_warranties`
--

DROP TABLE IF EXISTS `sell_line_warranties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sell_line_warranties` (
  `sell_line_id` int NOT NULL,
  `warranty_id` int NOT NULL
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `selling_price_groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `business_id` int unsigned NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `selling_price_groups_business_id_foreign` (`business_id`),
  CONSTRAINT `selling_price_groups_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `selling_price_groups`
--

LOCK TABLES `selling_price_groups` WRITE;
/*!40000 ALTER TABLE `selling_price_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `selling_price_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_adjustment_lines` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  `variation_id` int unsigned NOT NULL,
  `quantity` decimal(22,4) NOT NULL,
  `unit_price` decimal(22,4) DEFAULT NULL COMMENT 'Last purchase unit price',
  `removed_purchase_line` int DEFAULT NULL,
  `lot_no_line_id` int DEFAULT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_adjustments_temp` (
  `id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_adjustments_temp`
--

LOCK TABLES `stock_adjustments_temp` WRITE;
/*!40000 ALTER TABLE `stock_adjustments_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_adjustments_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system`
--

DROP TABLE IF EXISTS `system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system`
--

LOCK TABLES `system` WRITE;
/*!40000 ALTER TABLE `system` DISABLE KEYS */;
INSERT INTO `system` VALUES (1,'db_version','4.7.7'),(2,'default_business_active_status','1');
/*!40000 ALTER TABLE `system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_rates`
--

DROP TABLE IF EXISTS `tax_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax_rates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double(22,4) NOT NULL,
  `is_tax_group` tinyint(1) NOT NULL DEFAULT '0',
  `for_tax_group` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tax_rates_business_id_foreign` (`business_id`),
  KEY `tax_rates_created_by_foreign` (`created_by`),
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_payments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int unsigned DEFAULT NULL,
  `business_id` int DEFAULT NULL,
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
  `created_by` int DEFAULT NULL,
  `paid_through_link` tinyint(1) NOT NULL DEFAULT '0',
  `gateway` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_advance` tinyint(1) NOT NULL DEFAULT '0',
  `payment_for` int DEFAULT NULL COMMENT 'stores the contact id',
  `parent_id` int DEFAULT NULL,
  `note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_ref_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_payments_transaction_id_foreign` (`transaction_id`),
  KEY `transaction_payments_created_by_index` (`created_by`),
  KEY `transaction_payments_parent_id_index` (`parent_id`),
  CONSTRAINT `transaction_payments_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_payments`
--

LOCK TABLES `transaction_payments` WRITE;
/*!40000 ALTER TABLE `transaction_payments` DISABLE KEYS */;
INSERT INTO `transaction_payments` VALUES (1,4,1,0,25.0000,'cash',NULL,NULL,NULL,'credit',NULL,NULL,NULL,NULL,NULL,NULL,'2023-01-06 10:53:00',1,0,NULL,0,8,NULL,NULL,NULL,'SP2023/0001',NULL,'2023-01-06 15:01:10','2023-01-06 15:01:10'),(2,5,1,0,25.0000,'cash',NULL,NULL,NULL,'credit',NULL,NULL,NULL,NULL,NULL,NULL,'2023-01-06 10:53:00',1,0,NULL,0,2,NULL,NULL,NULL,'SP2023/0002',NULL,'2023-01-06 15:02:10','2023-01-06 15:02:10');
/*!40000 ALTER TABLE `transaction_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_sell_lines`
--

DROP TABLE IF EXISTS `transaction_sell_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_sell_lines` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  `variation_id` int unsigned NOT NULL,
  `quantity` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `quantity_returned` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `unit_price_before_discount` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `unit_price` decimal(22,4) DEFAULT NULL COMMENT 'Sell price excluding tax',
  `line_discount_type` enum('fixed','percentage') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_discount_amount` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `unit_price_inc_tax` decimal(22,4) DEFAULT NULL COMMENT 'Sell price including tax',
  `item_tax` decimal(22,4) NOT NULL COMMENT 'Tax for one quantity',
  `tax_id` int unsigned DEFAULT NULL,
  `discount_id` int DEFAULT NULL,
  `lot_no_line_id` int DEFAULT NULL,
  `sell_line_note` text COLLATE utf8mb4_unicode_ci,
  `so_line_id` int DEFAULT NULL,
  `so_quantity_invoiced` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `res_service_staff_id` int DEFAULT NULL,
  `res_line_order_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_sell_line_id` int DEFAULT NULL,
  `children_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Type of children for the parent, like modifier or combo',
  `sub_unit_id` int DEFAULT NULL,
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
  CONSTRAINT `transaction_sell_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transaction_sell_lines_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transaction_sell_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transaction_sell_lines_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_sell_lines`
--

LOCK TABLES `transaction_sell_lines` WRITE;
/*!40000 ALTER TABLE `transaction_sell_lines` DISABLE KEYS */;
INSERT INTO `transaction_sell_lines` VALUES (1,1,1,1,10.0000,0.0000,0.0000,0.0000,'fixed',0.0000,0.0000,0.0000,NULL,NULL,NULL,'',NULL,0.0000,NULL,NULL,NULL,'',NULL,'2022-11-23 00:05:53','2022-11-23 00:05:53'),(2,2,1,1,2.0000,0.0000,0.0000,0.0000,'fixed',0.0000,0.0000,0.0000,NULL,NULL,NULL,'',NULL,0.0000,NULL,NULL,NULL,'',NULL,'2022-11-23 00:19:04','2022-11-23 00:19:04'),(3,4,4,4,2.0000,0.0000,12.5000,12.5000,'fixed',0.0000,12.5000,0.0000,NULL,NULL,NULL,'',NULL,0.0000,NULL,NULL,NULL,'',NULL,'2023-01-06 15:01:10','2023-01-06 15:01:10'),(4,5,4,4,2.0000,0.0000,12.5000,12.5000,'fixed',0.0000,12.5000,0.0000,NULL,NULL,NULL,'',NULL,0.0000,NULL,NULL,NULL,'',NULL,'2023-01-06 15:02:10','2023-01-06 15:02:10');
/*!40000 ALTER TABLE `transaction_sell_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_sell_lines_purchase_lines`
--

DROP TABLE IF EXISTS `transaction_sell_lines_purchase_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_sell_lines_purchase_lines` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sell_line_id` int unsigned DEFAULT NULL COMMENT 'id from transaction_sell_lines',
  `stock_adjustment_line_id` int unsigned DEFAULT NULL COMMENT 'id from stock_adjustment_lines',
  `purchase_line_id` int unsigned NOT NULL COMMENT 'id from purchase_lines',
  `quantity` decimal(22,4) NOT NULL,
  `qty_returned` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sell_line_id` (`sell_line_id`),
  KEY `stock_adjustment_line_id` (`stock_adjustment_line_id`),
  KEY `purchase_line_id` (`purchase_line_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_sell_lines_purchase_lines`
--

LOCK TABLES `transaction_sell_lines_purchase_lines` WRITE;
/*!40000 ALTER TABLE `transaction_sell_lines_purchase_lines` DISABLE KEYS */;
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (1,3,NULL,1,2.0000,0.0000,'2023-01-06 15:01:11','2023-01-06 15:01:11'),(2,4,NULL,1,2.0000,0.0000,'2023-01-06 15:02:10','2023-01-06 15:02:10');
/*!40000 ALTER TABLE `transaction_sell_lines_purchase_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int unsigned NOT NULL,
  `location_id` int unsigned DEFAULT NULL,
  `res_table_id` int unsigned DEFAULT NULL COMMENT 'fields to restaurant module',
  `res_waiter_id` int unsigned DEFAULT NULL COMMENT 'fields to restaurant module',
  `res_order_status` enum('received','cooked','served') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_quotation` tinyint(1) NOT NULL DEFAULT '0',
  `payment_status` enum('paid','due','partial') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adjustment_type` enum('normal','abnormal') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` int unsigned DEFAULT NULL,
  `customer_group_id` int DEFAULT NULL COMMENT 'used to add customer group while selling',
  `invoice_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ref_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_repeat_on` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` datetime NOT NULL,
  `total_before_tax` decimal(22,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total before the purchase/invoice tax, this includeds the indivisual product tax',
  `tax_id` int unsigned DEFAULT NULL,
  `tax_amount` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `discount_type` enum('fixed','percentage') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_amount` decimal(22,4) DEFAULT '0.0000',
  `rp_redeemed` int NOT NULL DEFAULT '0' COMMENT 'rp is the short form of reward points',
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
  `additional_expense_key_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_expense_value_1` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `additional_expense_key_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_expense_value_2` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `additional_expense_key_3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_expense_value_3` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `additional_expense_key_4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_expense_value_4` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `final_total` decimal(22,4) NOT NULL DEFAULT '0.0000',
  `expense_category_id` int unsigned DEFAULT NULL,
  `expense_sub_category_id` int DEFAULT NULL,
  `expense_for` int unsigned DEFAULT NULL,
  `commission_agent` int DEFAULT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_direct_sale` tinyint(1) NOT NULL DEFAULT '0',
  `is_suspend` tinyint(1) NOT NULL DEFAULT '0',
  `exchange_rate` decimal(20,3) NOT NULL DEFAULT '1.000',
  `total_amount_recovered` decimal(22,4) DEFAULT NULL COMMENT 'Used for stock adjustment.',
  `transfer_parent_id` int DEFAULT NULL,
  `return_parent_id` int DEFAULT NULL,
  `opening_stock_product_id` int DEFAULT NULL,
  `created_by` int unsigned NOT NULL,
  `prefer_payment_method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prefer_payment_account` int DEFAULT NULL,
  `sales_order_ids` text COLLATE utf8mb4_unicode_ci,
  `purchase_order_ids` text COLLATE utf8mb4_unicode_ci,
  `custom_field_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `import_batch` int DEFAULT NULL,
  `import_time` datetime DEFAULT NULL,
  `types_of_service_id` int DEFAULT NULL,
  `packing_charge` decimal(22,4) DEFAULT NULL,
  `packing_charge_type` enum('fixed','percent') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_custom_field_1` text COLLATE utf8mb4_unicode_ci,
  `service_custom_field_2` text COLLATE utf8mb4_unicode_ci,
  `service_custom_field_3` text COLLATE utf8mb4_unicode_ci,
  `service_custom_field_4` text COLLATE utf8mb4_unicode_ci,
  `service_custom_field_5` text COLLATE utf8mb4_unicode_ci,
  `service_custom_field_6` text COLLATE utf8mb4_unicode_ci,
  `is_created_from_api` tinyint(1) NOT NULL DEFAULT '0',
  `rp_earned` int NOT NULL DEFAULT '0' COMMENT 'rp is the short form of reward points',
  `order_addresses` text COLLATE utf8mb4_unicode_ci,
  `is_recurring` tinyint(1) NOT NULL DEFAULT '0',
  `recur_interval` double(22,4) DEFAULT NULL,
  `recur_interval_type` enum('days','months','years') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recur_repetitions` int DEFAULT NULL,
  `recur_stopped_on` datetime DEFAULT NULL,
  `recur_parent_id` int DEFAULT NULL,
  `invoice_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pay_term_number` int DEFAULT NULL,
  `pay_term_type` enum('days','months') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selling_price_group_id` int DEFAULT NULL,
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
  CONSTRAINT `transactions_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_expense_category_id_foreign` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_expense_for_foreign` FOREIGN KEY (`expense_for`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `business_locations` (`id`),
  CONSTRAINT `transactions_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,1,1,NULL,NULL,NULL,'sell',NULL,'final',NULL,0,'paid',NULL,1,NULL,'0001','',NULL,NULL,NULL,'2022-11-22 20:05:53',0.0000,NULL,0.0000,'percentage',0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,NULL,0.0000,NULL,0.0000,NULL,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,1.0000,'days',0,NULL,NULL,NULL,NULL,NULL,0,'2022-11-23 00:05:53','2022-11-23 00:05:53'),(2,1,1,NULL,NULL,NULL,'sell',NULL,'final',NULL,0,'paid',NULL,1,NULL,'0002','',NULL,NULL,NULL,'2022-11-22 20:19:03',0.0000,NULL,0.0000,'percentage',0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,NULL,0.0000,NULL,0.0000,NULL,0.0000,NULL,0.0000,0.0000,NULL,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,1.0000,'days',0,NULL,NULL,NULL,NULL,NULL,0,'2022-11-23 00:19:04','2022-11-23 00:19:04'),(3,1,1,NULL,NULL,NULL,'opening_stock',NULL,'received',NULL,0,'paid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2023-01-01 11:00:35',10.0000,NULL,0.0000,NULL,0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,NULL,0.0000,NULL,0.0000,NULL,0.0000,NULL,0.0000,500.0000,NULL,NULL,NULL,NULL,NULL,0,0,1.000,NULL,NULL,NULL,4,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2023-01-06 15:00:35','2023-01-06 15:00:35'),(4,1,1,NULL,NULL,NULL,'sell',NULL,'final',NULL,0,'paid',NULL,8,NULL,'9','',NULL,NULL,NULL,'2023-01-06 10:53:00',25.0000,NULL,0.0000,'percentage',0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,NULL,0.0000,NULL,0.0000,NULL,0.0000,NULL,0.0000,25.0000,NULL,NULL,NULL,NULL,NULL,1,0,1.000,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,1.0000,'days',0,NULL,NULL,NULL,1,NULL,NULL,'2023-01-06 15:01:10','2023-01-06 15:01:11'),(5,1,1,NULL,NULL,NULL,'sell',NULL,'final',NULL,0,'paid',NULL,2,NULL,'9','',NULL,NULL,NULL,'2023-01-06 10:53:00',25.0000,NULL,0.0000,'percentage',0.0000,0,0.0000,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0.0000,NULL,0.0000,NULL,0.0000,NULL,0.0000,NULL,0.0000,25.0000,NULL,NULL,NULL,NULL,NULL,1,0,1.000,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,0,1.0000,'days',0,NULL,NULL,NULL,1,'days',NULL,'2023-01-06 15:02:10','2023-01-06 15:02:10');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types_of_services`
--

DROP TABLE IF EXISTS `types_of_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `types_of_services` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `business_id` int NOT NULL,
  `location_price_group` text COLLATE utf8mb4_unicode_ci,
  `packing_charge` decimal(22,4) DEFAULT NULL,
  `packing_charge_type` enum('fixed','percent') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_custom_fields` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `types_of_services_business_id_index` (`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types_of_services`
--

LOCK TABLES `types_of_services` WRITE;
/*!40000 ALTER TABLE `types_of_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `types_of_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `units` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int unsigned NOT NULL,
  `actual_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `allow_decimal` tinyint(1) NOT NULL,
  `base_unit_id` int DEFAULT NULL,
  `base_unit_multiplier` decimal(20,4) DEFAULT NULL,
  `created_by` int unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `units_business_id_foreign` (`business_id`),
  KEY `units_created_by_foreign` (`created_by`),
  KEY `units_base_unit_id_index` (`base_unit_id`),
  CONSTRAINT `units_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `units_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `units`
--

LOCK TABLES `units` WRITE;
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
INSERT INTO `units` VALUES (1,1,'Pieces','Pc(s)',0,NULL,NULL,1,NULL,'2022-11-21 16:46:25','2022-11-21 16:46:25'),(2,1,'unidad','Unid',1,NULL,NULL,1,NULL,'2023-01-06 14:34:07','2023-01-06 14:34:07');
/*!40000 ALTER TABLE `units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_contact_access`
--

DROP TABLE IF EXISTS `user_contact_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_contact_access` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `contact_id` int NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
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
  `business_id` int unsigned DEFAULT NULL,
  `max_sales_discount_percent` decimal(5,2) DEFAULT NULL,
  `allow_login` tinyint(1) NOT NULL DEFAULT '1',
  `status` enum('active','inactive','terminated') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `crm_contact_id` int unsigned DEFAULT NULL,
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
  KEY `users_crm_contact_id_foreign` (`crm_contact_id`),
  CONSTRAINT `users_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_crm_contact_id_foreign` FOREIGN KEY (`crm_contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'user','Mr','Marcelo','Aviles','admin','info@sinticbolivia.net','$2y$10$EoCYmTb927Hh.tFlsqdtOu52lurZbIo4tvnJ.zlCjHiWN3zh82a2u','en',NULL,NULL,NULL,1,NULL,1,'active',NULL,0,0.00,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2022-11-21 16:46:25','2022-11-21 16:46:25');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variation_group_prices`
--

DROP TABLE IF EXISTS `variation_group_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `variation_group_prices` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `variation_id` int unsigned NOT NULL,
  `price_group_id` int unsigned NOT NULL,
  `price_inc_tax` decimal(22,4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `variation_group_prices_variation_id_foreign` (`variation_id`),
  KEY `variation_group_prices_price_group_id_foreign` (`price_group_id`),
  CONSTRAINT `variation_group_prices_price_group_id_foreign` FOREIGN KEY (`price_group_id`) REFERENCES `selling_price_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `variation_group_prices_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variation_group_prices`
--

LOCK TABLES `variation_group_prices` WRITE;
/*!40000 ALTER TABLE `variation_group_prices` DISABLE KEYS */;
/*!40000 ALTER TABLE `variation_group_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variation_location_details`
--

DROP TABLE IF EXISTS `variation_location_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `variation_location_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `product_variation_id` int unsigned NOT NULL COMMENT 'id from product_variations table',
  `variation_id` int unsigned NOT NULL,
  `location_id` int unsigned NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variation_location_details`
--

LOCK TABLES `variation_location_details` WRITE;
/*!40000 ALTER TABLE `variation_location_details` DISABLE KEYS */;
INSERT INTO `variation_location_details` VALUES (1,4,4,4,1,46.0000,'2023-01-06 15:00:35','2023-01-06 15:02:10');
/*!40000 ALTER TABLE `variation_location_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variation_templates`
--

DROP TABLE IF EXISTS `variation_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `variation_templates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `variation_templates_business_id_foreign` (`business_id`),
  CONSTRAINT `variation_templates_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variation_templates`
--

LOCK TABLES `variation_templates` WRITE;
/*!40000 ALTER TABLE `variation_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `variation_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variation_value_templates`
--

DROP TABLE IF EXISTS `variation_value_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `variation_value_templates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `variation_template_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `variation_value_templates_name_index` (`name`),
  KEY `variation_value_templates_variation_template_id_index` (`variation_template_id`),
  CONSTRAINT `variation_value_templates_variation_template_id_foreign` FOREIGN KEY (`variation_template_id`) REFERENCES `variation_templates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variation_value_templates`
--

LOCK TABLES `variation_value_templates` WRITE;
/*!40000 ALTER TABLE `variation_value_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `variation_value_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variations`
--

DROP TABLE IF EXISTS `variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `variations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int unsigned NOT NULL,
  `sub_sku` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_variation_id` int unsigned NOT NULL,
  `variation_value_id` int DEFAULT NULL,
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
  CONSTRAINT `variations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `variations_product_variation_id_foreign` FOREIGN KEY (`product_variation_id`) REFERENCES `product_variations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variations`
--

LOCK TABLES `variations` WRITE;
/*!40000 ALTER TABLE `variations` DISABLE KEYS */;
INSERT INTO `variations` VALUES (1,'DUMMY',1,'P001',1,NULL,15.0000,15.0000,25.0000,18.7500,18.7500,'2022-11-22 22:05:48','2022-11-25 16:12:08',NULL,'[]'),(2,'DUMMY',2,'T001',2,NULL,2.0000,2.0000,25.0000,2.5000,2.5000,'2022-12-09 23:26:52','2022-12-09 23:26:52',NULL,'[]'),(3,'DUMMY',3,'SIS-HDB-P001',3,NULL,68.0000,68.0000,25.0000,85.0000,85.0000,'2023-01-06 13:39:39','2023-01-06 13:39:39',NULL,'[]'),(4,'DUMMY',4,'123',4,NULL,10.0000,10.0000,25.0000,12.5000,12.5000,'2023-01-06 14:36:08','2023-01-06 14:36:08',NULL,'[]');
/*!40000 ALTER TABLE `variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warranties`
--

DROP TABLE IF EXISTS `warranties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warranties` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `duration` int NOT NULL,
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-28 14:31:11
