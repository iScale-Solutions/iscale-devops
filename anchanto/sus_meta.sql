-- MySQL dump 10.13  Distrib 5.7.32, for Linux (x86_64)
--
-- Host: dbselluseller-carina-prod-2tb.cbudzbiqnbgm.ap-southeast-1.rds.amazonaws.com    Database: dbSelluSeller
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `trackable_id` int DEFAULT NULL,
  `trackable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `owner_id` int DEFAULT NULL,
  `owner_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parameters` mediumtext COLLATE utf8_unicode_ci,
  `recipient_id` int DEFAULT NULL,
  `recipient_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_activities_on_trackable_id_and_trackable_type` (`trackable_id`,`trackable_type`),
  KEY `index_activities_on_owner_id_and_owner_type` (`owner_id`,`owner_type`),
  KEY `index_activities_on_recipient_id_and_recipient_type` (`recipient_id`,`recipient_type`)
) ENGINE=InnoDB AUTO_INCREMENT=17279711 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ati_accounting_tool_confs`
--

DROP TABLE IF EXISTS `ati_accounting_tool_confs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ati_accounting_tool_confs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accounting_tool_id` int NOT NULL,
  `key_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key_display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key_position` int DEFAULT NULL,
  `is_input_required` tinyint(1) DEFAULT '1',
  `is_ui_visible` tinyint(1) DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `are_all_products_pushed` tinyint(1) DEFAULT '1',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_ati_accounting_tool_confs_on_accounting_tool_id` (`accounting_tool_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ati_accounting_tools`
--

DROP TABLE IF EXISTS `ati_accounting_tools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ati_accounting_tools` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `domain_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `deactivated_at` datetime DEFAULT NULL,
  `default_session_time` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_ati_accounting_tools_on_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ati_contact_details`
--

DROP TABLE IF EXISTS `ati_contact_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ati_contact_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sat_id` int DEFAULT NULL,
  `error_message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3209 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ati_item_assets`
--

DROP TABLE IF EXISTS `ati_item_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ati_item_assets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sat_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1002135 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ati_order_assets`
--

DROP TABLE IF EXISTS `ati_order_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ati_order_assets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tracking_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `invoice_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sat_id` int DEFAULT NULL,
  `is_paid` tinyint(1) NOT NULL DEFAULT '1',
  `canceled_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `invoice_ref_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `scope_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_invoice` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `index_ati_order_assets_on_number` (`number`),
  KEY `index_ati_order_assets_on_sat_id` (`sat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1185109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ati_po_assets`
--

DROP TABLE IF EXISTS `ati_po_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ati_po_assets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `po_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_accounting_tool_id` int DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `canceled_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_ati_po_assets_on_number` (`number`),
  KEY `index_ati_po_assets_on_seller_accounting_tool_id` (`seller_accounting_tool_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ati_seller_accounting_credentials`
--

DROP TABLE IF EXISTS `ati_seller_accounting_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ati_seller_accounting_credentials` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accounting_tool_conf_id` int DEFAULT NULL,
  `seller_accounting_tool_id` int DEFAULT NULL,
  `value` varchar(3072) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ati_sat_id_crdentials_x` (`seller_accounting_tool_id`),
  KEY `ati_acc_id_crdentials_x` (`accounting_tool_conf_id`)
) ENGINE=InnoDB AUTO_INCREMENT=637 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ati_seller_accounting_settings`
--

DROP TABLE IF EXISTS `ati_seller_accounting_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ati_seller_accounting_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_accounting_tool_id` int NOT NULL,
  `setting_field_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ati_sat_id_settings` (`seller_accounting_tool_id`),
  KEY `index_ati_seller_accounting_settings_on_setting_field_id` (`setting_field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2900 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ati_seller_accounting_tools`
--

DROP TABLE IF EXISTS `ati_seller_accounting_tools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ati_seller_accounting_tools` (
  `id` int NOT NULL AUTO_INCREMENT,
  `partner_mp_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accounting_tool_id` int NOT NULL,
  `seller_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_source` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `connected_at` datetime DEFAULT NULL,
  `deactivated_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `hidden` tinyint(1) DEFAULT '1',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `advance_setting_enable` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_ati_seller_accounting_tools_on_accounting_tool_id` (`accounting_tool_id`),
  KEY `index_ati_seller_accounting_tools_on_seller_code` (`seller_code`)
) ENGINE=InnoDB AUTO_INCREMENT=412 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ati_setting_field_values`
--

DROP TABLE IF EXISTS `ati_setting_field_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ati_setting_field_values` (
  `id` int NOT NULL AUTO_INCREMENT,
  `setting_field_id` int DEFAULT NULL,
  `seller_accounting_tool_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_ati_setting_field_values_on_setting_field_id` (`setting_field_id`),
  KEY `index_ati_setting_field_values_on_seller_accounting_tool_id` (`seller_accounting_tool_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ati_setting_fields`
--

DROP TABLE IF EXISTS `ati_setting_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ati_setting_fields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accounting_tool_id` int DEFAULT NULL,
  `field_type` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_type` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mandatory` tinyint(1) NOT NULL DEFAULT '0',
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` int DEFAULT '0',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scope` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_advance_settings` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_ati_setting_fields_on_accounting_tool_id` (`accounting_tool_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ati_smp_accounting_settings`
--

DROP TABLE IF EXISTS `ati_smp_accounting_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ati_smp_accounting_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_accounting_tool_id` int NOT NULL,
  `setting_field_id` int NOT NULL,
  `scope_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scope_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=325 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ati_terms_and_conditions`
--

DROP TABLE IF EXISTS `ati_terms_and_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ati_terms_and_conditions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accounting_tool_id` int DEFAULT NULL,
  `terms_and_condition` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_ati_terms_and_conditions_on_accounting_tool_id` (`accounting_tool_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cs_logistics_assets`
--

DROP TABLE IF EXISTS `cs_logistics_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cs_logistics_assets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `logistics_partner_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `province_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `data_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `barangay` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cs_logistics_assets_on_logistics_partner_id` (`logistics_partner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64323 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cs_logistics_confs`
--

DROP TABLE IF EXISTS `cs_logistics_confs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cs_logistics_confs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `logistics_partner_id` int NOT NULL,
  `key_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `key_diplay_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `key_position` int DEFAULT NULL,
  `is_input_required` tinyint(1) DEFAULT '1',
  `is_ui_visible` tinyint(1) DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_cs_logistics_confs_on_logistics_partner_id` (`logistics_partner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cs_logistics_partners`
--

DROP TABLE IF EXISTS `cs_logistics_partners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cs_logistics_partners` (
  `id` int NOT NULL AUTO_INCREMENT,
  `partner_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `partner_code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `domain_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tracking_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `api_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_global` tinyint(1) NOT NULL DEFAULT '0',
  `deactivated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `partner_code` (`partner_code`(191))
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cs_order_logistics_assets`
--

DROP TABLE IF EXISTS `cs_order_logistics_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cs_order_logistics_assets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shipment_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `consignment_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tracking_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipment_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `seller_logistics_partner_id` int DEFAULT NULL,
  `order_lable_file_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `order_lable_content_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `order_lable_file_size` int DEFAULT NULL,
  `order_lable_updated_at` datetime DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `cs_slp_id_assets_x` (`seller_logistics_partner_id`),
  KEY `shipment_id` (`shipment_id`(191)),
  KEY `shipment_number` (`shipment_number`(191)),
  KEY `seller_logistics_partner_id` (`seller_logistics_partner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55328 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cs_seller_logistics_credentials`
--

DROP TABLE IF EXISTS `cs_seller_logistics_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cs_seller_logistics_credentials` (
  `id` int NOT NULL AUTO_INCREMENT,
  `logistics_conf_id` int DEFAULT NULL,
  `seller_logistics_partner_id` int DEFAULT NULL,
  `value` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `has_own_acc` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `cs_slp_id_crdentials_x` (`seller_logistics_partner_id`),
  KEY `cs_conf_id_crdentials_x` (`logistics_conf_id`)
) ENGINE=InnoDB AUTO_INCREMENT=424 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cs_seller_logistics_partners`
--

DROP TABLE IF EXISTS `cs_seller_logistics_partners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cs_seller_logistics_partners` (
  `id` int NOT NULL AUTO_INCREMENT,
  `partner_mp_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `logistics_partner_id` int NOT NULL,
  `seller_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `connected_at` datetime DEFAULT NULL,
  `deactivated_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `use_admin_credentials` tinyint(1) DEFAULT '0',
  `seller_source` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_cs_seller_logistics_partners_on_logistics_partner_id` (`logistics_partner_id`),
  KEY `logistics_partner_id` (`logistics_partner_id`),
  KEY `seller_code` (`seller_code`(191))
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `delayed_jobs`
--

DROP TABLE IF EXISTS `delayed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delayed_jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB AUTO_INCREMENT=25309346 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dj_processor10s`
--

DROP TABLE IF EXISTS `dj_processor10s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dj_processor10s` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB AUTO_INCREMENT=24125505 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dj_processor11s`
--

DROP TABLE IF EXISTS `dj_processor11s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dj_processor11s` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB AUTO_INCREMENT=24303719 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dj_processor12s`
--

DROP TABLE IF EXISTS `dj_processor12s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dj_processor12s` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB AUTO_INCREMENT=364203 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dj_processor13s`
--

DROP TABLE IF EXISTS `dj_processor13s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dj_processor13s` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB AUTO_INCREMENT=83688 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dj_processor14s`
--

DROP TABLE IF EXISTS `dj_processor14s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dj_processor14s` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB AUTO_INCREMENT=49344 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dj_processor15s`
--

DROP TABLE IF EXISTS `dj_processor15s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dj_processor15s` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB AUTO_INCREMENT=61972 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dj_processor1s`
--

DROP TABLE IF EXISTS `dj_processor1s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dj_processor1s` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dj_processor2s`
--

DROP TABLE IF EXISTS `dj_processor2s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dj_processor2s` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB AUTO_INCREMENT=24316151 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dj_processor3s`
--

DROP TABLE IF EXISTS `dj_processor3s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dj_processor3s` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB AUTO_INCREMENT=24133344 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dj_processor4s`
--

DROP TABLE IF EXISTS `dj_processor4s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dj_processor4s` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB AUTO_INCREMENT=407 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dj_processor5s`
--

DROP TABLE IF EXISTS `dj_processor5s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dj_processor5s` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB AUTO_INCREMENT=24232034 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dj_processor6s`
--

DROP TABLE IF EXISTS `dj_processor6s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dj_processor6s` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB AUTO_INCREMENT=977 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dj_processor7s`
--

DROP TABLE IF EXISTS `dj_processor7s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dj_processor7s` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB AUTO_INCREMENT=24154058 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dj_processor8s`
--

DROP TABLE IF EXISTS `dj_processor8s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dj_processor8s` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB AUTO_INCREMENT=24284346 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dj_processor9s`
--

DROP TABLE IF EXISTS `dj_processor9s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dj_processor9s` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB AUTO_INCREMENT=24185373 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_events_users`
--

DROP TABLE IF EXISTS `email_events_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_events_users` (
  `user_id` int NOT NULL,
  `email_event_id` int NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `image_delayed_jobs`
--

DROP TABLE IF EXISTS `image_delayed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_delayed_jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `priority` int NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `handler` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `last_error` mediumtext COLLATE utf8_unicode_ci,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_account_types`
--

DROP TABLE IF EXISTS `mpc_account_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_account_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `privilage_level` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_addons`
--

DROP TABLE IF EXISTS `mpc_addons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_addons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(15,2) DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `addon_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `braintree_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_frequency` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_addresses`
--

DROP TABLE IF EXISTS `mpc_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zipcode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternative_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_id` int DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_addresses_firstname` (`firstname`),
  KEY `ix_addresses_lastname` (`lastname`),
  KEY `ix_addresses_phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=145923317 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_applied_promocodes`
--

DROP TABLE IF EXISTS `mpc_applied_promocodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_applied_promocodes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `promocode_id` int NOT NULL,
  `seller_id` int NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `subscribed` tinyint(1) DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_applied_promocodes_on_promocode_id` (`promocode_id`),
  KEY `index_mpc_applied_promocodes_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1099 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_assets`
--

DROP TABLE IF EXISTS `mpc_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_assets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `viewable_id` int DEFAULT NULL,
  `viewable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment_width` int DEFAULT NULL,
  `attachment_height` int DEFAULT NULL,
  `attachment_file_size` int DEFAULT NULL,
  `attachment_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment_updated_at` datetime DEFAULT NULL,
  `alt` mediumtext COLLATE utf8_unicode_ci,
  `attachment_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_assets_on_viewable_id` (`viewable_id`),
  KEY `index_assets_on_viewable_type_and_type` (`viewable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=330 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_assigned_item_lists`
--

DROP TABLE IF EXISTS `mpc_assigned_item_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_assigned_item_lists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shipment_id` int DEFAULT NULL,
  `assign_user_id` int DEFAULT NULL,
  `assign_by_user_id` int DEFAULT NULL,
  `line_item_id` int DEFAULT NULL,
  `picked_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_assigned_item_lists_on_shipment_id` (`shipment_id`),
  KEY `index_mpc_assigned_item_lists_on_assign_user_id` (`assign_user_id`),
  KEY `index_mpc_assigned_item_lists_on_assign_by_user_id` (`assign_by_user_id`),
  KEY `index_mpc_assigned_item_lists_on_line_item_id` (`line_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4887 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_authorizations`
--

DROP TABLE IF EXISTS `mpc_authorizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_authorizations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `oauth_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_authorization_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1142 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_awb_numbers`
--

DROP TABLE IF EXISTS `mpc_awb_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_awb_numbers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tracking_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `awb_series_id` int DEFAULT NULL,
  `shipment_id` int DEFAULT NULL,
  `is_allocated` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_awb_numbers_on_id` (`id`),
  KEY `awb_number_shipment_id_x` (`shipment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3379 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_awb_series`
--

DROP TABLE IF EXISTS `mpc_awb_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_awb_series` (
  `id` int NOT NULL AUTO_INCREMENT,
  `series_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `deactivated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_awb_series_on_id` (`id`),
  KEY `index_mpc_awb_series_on_seller_id` (`seller_id`),
  KEY `index_mpc_awb_series_on_country_id` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_awb_series_shipping_methods`
--

DROP TABLE IF EXISTS `mpc_awb_series_shipping_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_awb_series_shipping_methods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shipping_method_id` int DEFAULT NULL,
  `awb_series_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_awb_series_shipping_methods_on_id` (`id`),
  KEY `index_mpc_awb_series_shipping_methods_on_shipping_method_id` (`shipping_method_id`),
  KEY `index_mpc_awb_series_shipping_methods_on_awb_series_id` (`awb_series_id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_awb_uploads`
--

DROP TABLE IF EXISTS `mpc_awb_uploads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_awb_uploads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `awb_series_id` int DEFAULT NULL,
  `attachment_file_size` int DEFAULT NULL,
  `attachment_content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment_file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_awb_uploads_on_awb_series_id` (`awb_series_id`),
  KEY `index_mpc_awb_uploads_on_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_base_categories`
--

DROP TABLE IF EXISTS `mpc_base_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_base_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `regional_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_leaf` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29167 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_billing_infos`
--

DROP TABLE IF EXISTS `mpc_billing_infos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_billing_infos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_id` int DEFAULT NULL,
  `credit_card_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preferred_account` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `payment_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_gateway_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_billing_infos_seller_id` (`seller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_bin_shipments`
--

DROP TABLE IF EXISTS `mpc_bin_shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_bin_shipments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bin_id` int DEFAULT NULL,
  `shipment_id` int DEFAULT NULL,
  `line_item_id` int DEFAULT NULL,
  `released_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_bin_shipments_on_bin_id` (`bin_id`),
  KEY `index_mpc_bin_shipments_on_shipment_id` (`shipment_id`),
  KEY `index_mpc_bin_shipments_on_line_item_id` (`line_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_bins`
--

DROP TABLE IF EXISTS `mpc_bins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_bins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `warehouse_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_bins_on_warehouse_id` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_braintree_callbacks`
--

DROP TABLE IF EXISTS `mpc_braintree_callbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_braintree_callbacks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_id` int DEFAULT NULL,
  `subscription_id` int DEFAULT NULL,
  `response` text COLLATE utf8mb4_unicode_ci,
  `callback_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_braintree_callbacks_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3521 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_brands`
--

DROP TABLE IF EXISTS `mpc_brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_brands` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `presentation` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `active` tinyint(1) DEFAULT '0',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_brands_on_marketplace_id` (`marketplace_id`),
  KEY `brands_name_x` (`name`),
  KEY `brands_marketplace_id_x` (`marketplace_id`),
  KEY `mpc_brands_name_marketplace_id` (`name`,`marketplace_id`),
  CONSTRAINT `fk_rails_ad13f7ea9b` FOREIGN KEY (`marketplace_id`) REFERENCES `mpc_marketplaces` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1692784 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_bulk_activities`
--

DROP TABLE IF EXISTS `mpc_bulk_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_bulk_activities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `activity_id` int DEFAULT NULL,
  `activity_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_records` int DEFAULT '0',
  `failed_records` int DEFAULT NULL,
  `successful_records` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `job_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activity_model` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `master_account_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `x_blk_imprt_activity_id` (`activity_id`),
  KEY `x_blk_imprt_activity_type` (`activity_type`),
  KEY `index_mpc_bulk_activities_on_master_account_id` (`master_account_id`),
  KEY `ix_bulk_activities_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=395118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_bulk_import_records`
--

DROP TABLE IF EXISTS `mpc_bulk_import_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_bulk_import_records` (
  `id` int NOT NULL AUTO_INCREMENT,
  `record_id` int NOT NULL,
  `record_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bulk_activity_id` int DEFAULT NULL,
  `success` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `message` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `seller_marketplace_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `x_blk_activ_recrd_id` (`bulk_activity_id`),
  KEY `index_mpc_bulk_import_records_on_seller_marketplace_id` (`seller_marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2434183 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_bulk_import_versions`
--

DROP TABLE IF EXISTS `mpc_bulk_import_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_bulk_import_versions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `original_file_file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `original_file_content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `original_file_file_size` int DEFAULT NULL,
  `original_file_updated_at` datetime DEFAULT NULL,
  `sample_file_file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sample_file_content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sample_file_file_size` int DEFAULT NULL,
  `sample_file_updated_at` datetime DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_version` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_bulk_imports`
--

DROP TABLE IF EXISTS `mpc_bulk_imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_bulk_imports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attachement_file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachement_content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachement_file_size` int DEFAULT NULL,
  `attachement_updated_at` datetime DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `import_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `error_attachement_file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `error_attachement_content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `error_attachement_file_size` int DEFAULT NULL,
  `error_attachement_updated_at` datetime DEFAULT NULL,
  `job_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `payload` varchar(1500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_clone_history_id` int DEFAULT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_bulk_imports_on_seller_marketplace_id` (`seller_marketplace_id`),
  KEY `ix_bulk_imports_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=84176 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_callback_settings`
--

DROP TABLE IF EXISTS `mpc_callback_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_callback_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_callback_settings_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_cancellation_reasons`
--

DROP TABLE IF EXISTS `mpc_cancellation_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_cancellation_reasons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attachable_id` int DEFAULT NULL,
  `attachable_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `cancel_attachable_type_id_x` (`attachable_type`(191),`attachable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22326861 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_capabilities`
--

DROP TABLE IF EXISTS `mpc_capabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_capabilities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_module` tinyint(1) NOT NULL,
  `based_on` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `rule_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_carts`
--

DROP TABLE IF EXISTS `mpc_carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_carts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `market_place_order_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int DEFAULT NULL,
  `master_account_id` int DEFAULT NULL,
  `number_of_orders` int DEFAULT '1',
  `number_of_tenants` int DEFAULT '1',
  `number_of_products` int DEFAULT '0',
  `number_of_fulfilled_orders` int DEFAULT '0',
  `number_of_non_fulfilled_orders` int DEFAULT '0',
  `shipping_provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=856 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_category_commissions`
--

DROP TABLE IF EXISTS `mpc_category_commissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_category_commissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `commission` float NOT NULL,
  `payment_fees` float NOT NULL,
  `payoneer_fees` float NOT NULL,
  `taxon_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_category_commissions_taxon_id` (`taxon_id`),
  CONSTRAINT `fk_rails_b43d94a1da` FOREIGN KEY (`taxon_id`) REFERENCES `mpc_taxons_131220` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5150 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_child_orders`
--

DROP TABLE IF EXISTS `mpc_child_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_child_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `source_order_id` int DEFAULT NULL,
  `destination_order_id` int DEFAULT NULL,
  `destination_order_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_city_lookups`
--

DROP TABLE IF EXISTS `mpc_city_lookups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_city_lookups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16834 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_clone_history_taxon_mappings`
--

DROP TABLE IF EXISTS `mpc_clone_history_taxon_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_clone_history_taxon_mappings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_clone_history_id` int DEFAULT NULL,
  `source_taxon_id` int DEFAULT NULL,
  `destination_taxon_id` int DEFAULT NULL,
  `is_fields_updated` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `mpc_x_history_id` (`product_clone_history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28268 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_clone_product_details`
--

DROP TABLE IF EXISTS `mpc_clone_product_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_clone_product_details` (
  `product_clone_history_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  KEY `index_mpc_clone_product_details_on_product_clone_history_id` (`product_clone_history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_collections`
--

DROP TABLE IF EXISTS `mpc_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_collections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `presentation` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metakeywords` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `permalink` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `attachment_file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment_file_size` int DEFAULT NULL,
  `attachment_content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment_updated_at` datetime DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_collections_on_seller_id` (`seller_id`),
  KEY `index_mpc_collections_on_seller_marketplace_id` (`seller_marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8426 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_consignment_products`
--

DROP TABLE IF EXISTS `mpc_consignment_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_consignment_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `entry_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `quantity` int NOT NULL,
  `price` decimal(15,2) DEFAULT '0.00',
  `inventory_product_id` int NOT NULL,
  `consignment_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_consignment_products_on_inventory_product_id` (`inventory_product_id`),
  KEY `index_mpc_consignment_products_on_consignment_id` (`consignment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=643 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_consignments`
--

DROP TABLE IF EXISTS `mpc_consignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_consignments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fulflmnt_state` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_id` int NOT NULL,
  `created_by` int NOT NULL,
  `ship_date` date DEFAULT NULL,
  `warehouse_code` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `merchant_code` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_consignments_on_seller_id` (`seller_id`),
  KEY `index_mpc_consignments_on_created_by` (`created_by`),
  KEY `index_mpc_consignments_on_number` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_countries`
--

DROP TABLE IF EXISTS `mpc_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_countries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `iso_name` text COLLATE utf8_unicode_ci NOT NULL,
  `iso` text COLLATE utf8_unicode_ci NOT NULL,
  `iso3` text COLLATE utf8_unicode_ci NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `numcode` int NOT NULL,
  `states_required` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `iso4` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `onboarding_position` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=225 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_credential_keys`
--

DROP TABLE IF EXISTS `mpc_credential_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_credential_keys` (
  `id` int NOT NULL AUTO_INCREMENT,
  `value` varchar(3072) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_marketplace_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `marketplace_key_id` int NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_credential_keys_on_seller_marketplace_id` (`seller_marketplace_id`),
  KEY `mpc_credential_keys` (`marketplace_key_id`)
) ENGINE=InnoDB AUTO_INCREMENT=212523 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_currencies`
--

DROP TABLE IF EXISTS `mpc_currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_currencies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `country_id` int NOT NULL,
  `priority` int NOT NULL,
  `iso_code` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `iso_numeric` int NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `symbol` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `subunit` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `subunit_to_unit` int NOT NULL,
  `separator` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `delimiter` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_currencies_on_country_id` (`country_id`),
  KEY `index_mpc_currencies_on_priority_and_iso_code` (`priority`,`iso_code`),
  KEY `index_mpc_currencies_on_iso_numeric_and_name_and_symbol` (`iso_numeric`,`name`,`symbol`),
  CONSTRAINT `fk_rails_34ea3608f0` FOREIGN KEY (`country_id`) REFERENCES `mpc_countries` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_custom_plan_details`
--

DROP TABLE IF EXISTS `mpc_custom_plan_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_custom_plan_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `payment_currency` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fixed_price` decimal(8,2) NOT NULL DEFAULT '0.00',
  `per_order_price` decimal(8,2) NOT NULL DEFAULT '0.00',
  `free_orders_count` int DEFAULT NULL,
  `account_manager_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `send_billing_on_email` tinyint(1) DEFAULT '0',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2166 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_customer_addresses`
--

DROP TABLE IF EXISTS `mpc_customer_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_customer_addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `address_type` varchar(255) DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_customer_addresses_customer_id` (`customer_id`),
  KEY `index_customer_addresses_adddress_id` (`address_id`),
  CONSTRAINT `fk_rails_24b7194e94` FOREIGN KEY (`customer_id`) REFERENCES `mpc_customers` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=143806650 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_customer_types`
--

DROP TABLE IF EXISTS `mpc_customer_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_customer_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `card_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ss_customer_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `magento_customer_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_customers`
--

DROP TABLE IF EXISTS `mpc_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `seller_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_customers_on_nfname` (`first_name`),
  KEY `index_mpc_customer_orders_on_lname` (`last_name`),
  KEY `mpc_customers_email` (`email`),
  KEY `ix_customers_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61118453 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_dashboard_kpi_data`
--

DROP TABLE IF EXISTS `mpc_dashboard_kpi_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_dashboard_kpi_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_id` int DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `kpi_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_order_count` int DEFAULT NULL,
  `total_sales_in_base_currency` decimal(10,0) DEFAULT NULL,
  `total_cancel_order_count` int DEFAULT NULL,
  `cancel_orders_amount` decimal(10,0) DEFAULT NULL,
  `discount_amount` decimal(10,0) DEFAULT NULL,
  `discount_order_processed` int DEFAULT NULL,
  `total_units_sold` int DEFAULT NULL,
  `inventory_stock_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `kpi_name` (`kpi_name`(191)),
  KEY `seller_marketplace_id` (`seller_marketplace_id`),
  KEY `seller_id` (`seller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_dashboard_summaries`
--

DROP TABLE IF EXISTS `mpc_dashboard_summaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_dashboard_summaries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_id` int DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `day` int DEFAULT NULL,
  `total_order_count` int DEFAULT NULL,
  `total_sales_in_base_currency` decimal(15,2) DEFAULT NULL,
  `total_cancel_order_count` int DEFAULT NULL,
  `cancel_orders_amount` decimal(15,2) DEFAULT NULL,
  `discount_amount` decimal(15,2) DEFAULT NULL,
  `discount_order_processed` int DEFAULT NULL,
  `total_units_sold` int DEFAULT NULL,
  `inventory_stock_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `cancel_orders_amount_in_mp_currency` decimal(15,2) DEFAULT NULL,
  `discount_amount_in_mp_currency` decimal(15,2) DEFAULT NULL,
  `total_sales_in_mp_currency` decimal(15,2) DEFAULT NULL,
  `promotion_sales` int DEFAULT NULL,
  `active_promotions_count` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_dashboard_summaries_on_day` (`day`),
  KEY `index_mpc_dashboard_summaries_on_seller_marketplace_id` (`seller_marketplace_id`),
  KEY `index_mpc_dashboard_summaries_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16349991 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_dashboard_summaries_22_11`
--

DROP TABLE IF EXISTS `mpc_dashboard_summaries_22_11`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_dashboard_summaries_22_11` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_id` int DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `day` int DEFAULT NULL,
  `total_order_count` int DEFAULT NULL,
  `total_sales_in_base_currency` decimal(10,0) DEFAULT NULL,
  `total_cancel_order_count` int DEFAULT NULL,
  `cancel_orders_amount` decimal(10,0) DEFAULT NULL,
  `discount_amount` decimal(10,0) DEFAULT NULL,
  `discount_order_processed` int DEFAULT NULL,
  `total_units_sold` int DEFAULT NULL,
  `inventory_stock_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_dashboard_summaries_on_day` (`day`),
  KEY `index_mpc_dashboard_summaries_on_seller_marketplace_id` (`seller_marketplace_id`),
  KEY `index_mpc_dashboard_summaries_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1340287 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_document_templates`
--

DROP TABLE IF EXISTS `mpc_document_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_document_templates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `document_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `marketplace_id` int DEFAULT NULL,
  `shipping_method_id` int DEFAULT NULL,
  `paper_size` int DEFAULT NULL,
  `template_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `template` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_document_templates_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=333 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_email_events`
--

DROP TABLE IF EXISTS `mpc_email_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_email_events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) DEFAULT '0',
  `seller` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_email_verification_details`
--

DROP TABLE IF EXISTS `mpc_email_verification_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_email_verification_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changed_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `times_genrated` int DEFAULT NULL,
  `verfied_at` datetime DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_email_verification_details_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1889 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_error_messages`
--

DROP TABLE IF EXISTS `mpc_error_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_error_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_id` int DEFAULT NULL,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` int DEFAULT NULL,
  `operation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_error_messages_on_marketplace_id` (`marketplace_id`),
  KEY `index_mpc_error_messages_on_category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=58762 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_error_reports`
--

DROP TABLE IF EXISTS `mpc_error_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_error_reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_marketplace_id` int DEFAULT NULL,
  `error_message` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `error_hash` text COLLATE utf8mb4_general_ci,
  `source_api` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `error_report_smp_id` (`seller_marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=237606595 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_event_logs`
--

DROP TABLE IF EXISTS `mpc_event_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_event_logs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `event_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `event_time` datetime NOT NULL,
  `event_source` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `event_env` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `event_log` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_event_logs_on_event_type` (`event_type`),
  KEY `index_mpc_event_logs_on_event_source` (`event_source`),
  KEY `index_mpc_event_logs_on_event_env` (`event_env`),
  KEY `event_logs_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=47840777 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_ewms_tenants`
--

DROP TABLE IF EXISTS `mpc_ewms_tenants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_ewms_tenants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `api_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signature` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fulfilment_network_id` int DEFAULT NULL,
  `shard_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `only_ewms_tenant_flag` tinyint(1) DEFAULT '0',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `x_ewms_tenants_api_key` (`api_key`),
  KEY `x_ewms_tenants_shard_id` (`shard_id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_exchange_rates`
--

DROP TABLE IF EXISTS `mpc_exchange_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_exchange_rates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `base_currency` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `to_currency` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rate` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_exclusive_groups`
--

DROP TABLE IF EXISTS `mpc_exclusive_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_exclusive_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `code` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exclusivity_duration` int NOT NULL DEFAULT '30',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_exclusive_groups_marketplaces`
--

DROP TABLE IF EXISTS `mpc_exclusive_groups_marketplaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_exclusive_groups_marketplaces` (
  `id` int NOT NULL AUTO_INCREMENT,
  `exclusive_group_id` int DEFAULT NULL,
  `marketplace_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=393 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_extra_address_details`
--

DROP TABLE IF EXISTS `mpc_extra_address_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_extra_address_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address_id` int DEFAULT NULL,
  `locality` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_extra_address_details_on_address_id` (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14449899 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_feed_details`
--

DROP TABLE IF EXISTS `mpc_feed_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_feed_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `feed_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `status` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `error_message` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `marketplace_product_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_feed_details_feed_id` (`feed_id`),
  KEY `idx_feed_details_product_id` (`product_id`),
  KEY `idx_feed_details_mp_product_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=224375488 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_feeds`
--

DROP TABLE IF EXISTS `mpc_feeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_feeds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_marketplace_id` int DEFAULT NULL,
  `marketplace_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `request_type` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `feed_response` mediumtext COLLATE utf8_unicode_ci,
  `seller_id` int DEFAULT NULL,
  `attempts` int NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_feeds_on_seller_marketplace_id` (`seller_marketplace_id`),
  KEY `index_mpc_feeds_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=207528334 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_fetch_product_log_details`
--

DROP TABLE IF EXISTS `mpc_fetch_product_log_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_fetch_product_log_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_id` int DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_fetch_product_log_details_on_seller_id` (`seller_id`),
  KEY `index_mpc_fetch_product_log_details_on_seller_marketplace_id` (`seller_marketplace_id`),
  KEY `index_mpc_fetch_product_log_details_on_sku` (`sku`),
  KEY `index_mpc_fetch_product_log_details_on_item_code` (`item_code`),
  KEY `index_mpc_fetch_product_log_details_on_product_type` (`product_type`)
) ENGINE=InnoDB AUTO_INCREMENT=746786 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_field_groups`
--

DROP TABLE IF EXISTS `mpc_field_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_field_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marketplace_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_field_instructions`
--

DROP TABLE IF EXISTS `mpc_field_instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_field_instructions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_id` int DEFAULT NULL,
  `field_name` int DEFAULT NULL,
  `length` int DEFAULT NULL,
  `message` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allow_creation` tinyint(1) DEFAULT NULL,
  `allow_updation` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_field_instructions_marketplace_id` (`marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_field_values`
--

DROP TABLE IF EXISTS `mpc_field_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_field_values` (
  `id` int NOT NULL AUTO_INCREMENT,
  `field_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(176) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_field_values_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=233256644 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_field_values_marketplace_products`
--

DROP TABLE IF EXISTS `mpc_field_values_marketplace_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_field_values_marketplace_products` (
  `marketplace_product_id` int DEFAULT NULL,
  `field_value_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  KEY `index_mp_op_value_id` (`marketplace_product_id`),
  KEY `index_field_op_value_id` (`field_value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_fields`
--

DROP TABLE IF EXISTS `mpc_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_fields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_id` int DEFAULT NULL,
  `field_type` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_type` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mandatory` tinyint(1) NOT NULL DEFAULT '0',
  `free_text` tinyint(1) NOT NULL DEFAULT '0',
  `taxon_id` int DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `option_type` tinyint(1) DEFAULT '0',
  `parent_id` int DEFAULT NULL,
  `criteria` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ss_field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_group_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_fields_marketplace_id` (`marketplace_id`),
  KEY `index_fields_taxon_id` (`taxon_id`),
  KEY `field_code_uniq_x` (`field_code`),
  KEY `mpc_field_m_id_t_id_fc_x` (`taxon_id`,`marketplace_id`,`field_code`),
  KEY `mpc_fields_parent_id` (`parent_id`),
  KEY `index_mpc_fields_cp_19_dec_on_ss_field_code` (`ss_field_code`)
) ENGINE=InnoDB AUTO_INCREMENT=5948912 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_fields_marketplace_products`
--

DROP TABLE IF EXISTS `mpc_fields_marketplace_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_fields_marketplace_products` (
  `marketplace_product_id` int DEFAULT NULL,
  `field_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  KEY `index_mpc_fields_marketplace_products_on_marketplace_product_id` (`marketplace_product_id`),
  KEY `index_mpc_fields_marketplace_products_on_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_ftp_attachments`
--

DROP TABLE IF EXISTS `mpc_ftp_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_ftp_attachments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ftp_interface_in_out_id` int DEFAULT NULL,
  `data_file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_file_size` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_alt_text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `log_level` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39967 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_ftp_details`
--

DROP TABLE IF EXISTS `mpc_ftp_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_ftp_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `host` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `directory_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `interface_enabled` tinyint(1) DEFAULT NULL,
  `order_export_dir_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_confirmation_dir_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inventory_update_dir_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_update_dir_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `port` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_ftp_directories`
--

DROP TABLE IF EXISTS `mpc_ftp_directories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_ftp_directories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ftp_detail_id` int DEFAULT NULL,
  `directory_type` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_ftp_interface_in_outs`
--

DROP TABLE IF EXISTS `mpc_ftp_interface_in_outs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_ftp_interface_in_outs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `operation_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operation_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_ftp_interface_in_outs_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1768 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_fulfilment_centers`
--

DROP TABLE IF EXISTS `mpc_fulfilment_centers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_fulfilment_centers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address_id` int NOT NULL,
  `seller_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_fulfilment_centers_address_id` (`address_id`),
  KEY `index_mpc_fulfilment_centers_seller_id` (`seller_id`),
  CONSTRAINT `fk_rails_0f30a44e89` FOREIGN KEY (`address_id`) REFERENCES `dbssJunkYard`.`mpc_addresses_tmp` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_rails_7d4ab197c3` FOREIGN KEY (`seller_id`) REFERENCES `mpc_sellers` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_fulfilment_centers_sellers`
--

DROP TABLE IF EXISTS `mpc_fulfilment_centers_sellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_fulfilment_centers_sellers` (
  `fulfilment_center_id` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  KEY `index_mpc_fulfilment_centers_sellers_on_fulfilment_center_id` (`fulfilment_center_id`),
  KEY `index_mpc_fulfilment_centers_sellers_on_seller_id` (`seller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_fulfilment_configurations`
--

DROP TABLE IF EXISTS `mpc_fulfilment_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_fulfilment_configurations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `api_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `signature` mediumtext COLLATE utf8mb4_unicode_ci,
  `seller_id` int NOT NULL,
  `retailer_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ewms_tenant_id` int DEFAULT NULL,
  `fulfilment_configurable_id` int DEFAULT NULL,
  `fulfilment_configurable_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `only_ewms_tenant_flag` tinyint(1) DEFAULT '0',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `companyname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_fulfilment_configurations_on_seller_id` (`seller_id`),
  KEY `x_fc_ewms_tenant_id` (`ewms_tenant_id`),
  KEY `mpc_fulfil_config_id` (`fulfilment_configurable_id`),
  KEY `mpc_fulfil_config_type` (`fulfilment_configurable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=774 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_fulfilment_networks`
--

DROP TABLE IF EXISTS `mpc_fulfilment_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_fulfilment_networks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `domain_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_create_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_create_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_update_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fetch_stock_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_status_update_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_cancel_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_item_cancel_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `consignment_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `update_invoice_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_manifest_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_tracking_number_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fetch_merchant_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_merchant_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fetch_product_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authorize_ewms_connection_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_fulfilment_order_states`
--

DROP TABLE IF EXISTS `mpc_fulfilment_order_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_fulfilment_order_states` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_fulfilment_types`
--

DROP TABLE IF EXISTS `mpc_fulfilment_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_fulfilment_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `presentation` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_genders`
--

DROP TABLE IF EXISTS `mpc_genders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_genders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_id` int DEFAULT NULL,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `presentation` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_genders_on_marketplace_id` (`marketplace_id`),
  CONSTRAINT `fk_rails_c3e9be93c8` FOREIGN KEY (`marketplace_id`) REFERENCES `mpc_marketplaces` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=361 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_generated_invoices`
--

DROP TABLE IF EXISTS `mpc_generated_invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_generated_invoices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoice_setting_id` int DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_generated_invoices_on_invoice_setting_id` (`invoice_setting_id`),
  KEY `index_mpc_generated_invoices_on_order_id` (`order_id`),
  KEY `ix_generated_invoices_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=71052 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_attribute_values_mappings`
--

DROP TABLE IF EXISTS `mpc_global_attribute_values_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_attribute_values_mappings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `feature_value` text COLLATE utf8mb4_unicode_ci,
  `feature_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feature_id` int DEFAULT NULL,
  `field_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_id` int DEFAULT NULL,
  `master_account_id` int DEFAULT NULL,
  `taxon_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `marketplace_id` int DEFAULT NULL,
  `formula` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `marketplace_id_on_avms` (`master_account_id`,`marketplace_id`) USING BTREE,
  KEY `category_id_on_avms` (`master_account_id`,`category_id`) USING BTREE,
  KEY `taxon_id_on_avms` (`master_account_id`,`taxon_id`) USING BTREE,
  KEY `feature_id_on_avms` (`master_account_id`,`feature_id`) USING BTREE,
  KEY `field_id_on_avms` (`master_account_id`,`field_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18032 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_attributes_mappings`
--

DROP TABLE IF EXISTS `mpc_global_attributes_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_attributes_mappings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `feature_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feature_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feature_id` int DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_id` int DEFAULT NULL,
  `master_account_id` int DEFAULT NULL,
  `taxon_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `marketplace_id` int DEFAULT NULL,
  `conversion_factor` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conversion_operator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key_definition` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rule` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `marketplace_id_on_attributes` (`master_account_id`,`marketplace_id`) USING BTREE,
  KEY `category_id_on_attributes` (`master_account_id`,`category_id`) USING BTREE,
  KEY `taxon_id_on_attributes` (`master_account_id`,`taxon_id`) USING BTREE,
  KEY `x_features_on_attributes` (`master_account_id`,`feature_id`) USING BTREE,
  KEY `index_on_attributes_fields` (`master_account_id`,`field_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4409 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_available_product_ids`
--

DROP TABLE IF EXISTS `mpc_global_available_product_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_available_product_ids` (
  `id` int NOT NULL AUTO_INCREMENT,
  `master_account_id` int DEFAULT NULL,
  `product_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Prod_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_approved` tinyint(1) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `date_of_added` datetime DEFAULT NULL,
  `ean_upc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_global_available_product_ids_on_master_account_id` (`master_account_id`),
  KEY `index_mpc_global_available_product_ids_on_product_id` (`product_id`),
  KEY `index_mpc_global_available_product_ids_on_ean_upc` (`ean_upc`),
  KEY `index_mpc_global_available_product_ids_on_supplier_id` (`supplier_id`),
  KEY `index_mpc_global_available_product_ids_on_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=437266 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_bulletpoints`
--

DROP TABLE IF EXISTS `mpc_global_bulletpoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_bulletpoints` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bullet_point` text COLLATE utf8mb4_unicode_ci,
  `product_id` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `x_bulletpoints_on_product_id` (`product_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=86090 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_categories`
--

DROP TABLE IF EXISTS `mpc_global_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_category_id` int DEFAULT NULL,
  `position` int DEFAULT '0',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permalink` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_set_id` int DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uncatid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_leaf` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hp_only` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_categories_on_name` (`name`) USING BTREE,
  KEY `index_categories_on_parent_id` (`parent_category_id`) USING BTREE,
  KEY `index_categories_on_permalink` (`permalink`) USING BTREE,
  KEY `index_mpc_categories_on_position` (`position`) USING BTREE,
  KEY `index_categories_on_category_set_id` (`category_set_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7541 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_category_feature_mappings`
--

DROP TABLE IF EXISTS `mpc_global_category_feature_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_category_feature_mappings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `feature_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int DEFAULT NULL,
  `supress_column` tinyint(1) DEFAULT NULL,
  `truncate_partial_value` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `prefix_text` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `separator` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '/',
  `value_to_read` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_to_read_for_truncation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supress_order` int DEFAULT NULL,
  `scope` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'title',
  PRIMARY KEY (`id`),
  KEY `index_mpc_global_category_feature_mappings_on_category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=663 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_category_mappings`
--

DROP TABLE IF EXISTS `mpc_global_category_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_category_mappings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `master_account_id` int DEFAULT NULL,
  `destination_marketplace_id` int NOT NULL,
  `destination_taxon_id` int DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `key_defination` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `formula` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `x_category_mapping_master_account_id` (`master_account_id`) USING BTREE,
  KEY `x_category_mapping_category_id` (`category_id`) USING BTREE,
  KEY `x_category_mapping_destination_marketplace_id` (`destination_marketplace_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_category_sets`
--

DROP TABLE IF EXISTS `mpc_global_category_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_category_sets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_feature_group_categories`
--

DROP TABLE IF EXISTS `mpc_global_feature_group_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_feature_group_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `feature_group_id` int DEFAULT NULL,
  `category_feature_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_set_id_and_category_id` (`feature_group_id`,`category_id`) USING BTREE,
  KEY `index_mpc_category_id` (`category_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_feature_groups`
--

DROP TABLE IF EXISTS `mpc_global_feature_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_feature_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `presentation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` int DEFAULT NULL,
  `sort_no` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=863 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_feature_values`
--

DROP TABLE IF EXISTS `mpc_global_feature_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_feature_values` (
  `id` int NOT NULL AUTO_INCREMENT,
  `position` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `presentation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feature_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `x_global_mpc_option_values_on_name` (`name`) USING BTREE,
  KEY `index_mpc_feature_id` (`feature_id`) USING BTREE,
  KEY `index_mpc_option_values_on_position` (`position`) USING BTREE,
  FULLTEXT KEY `name` (`name`,`presentation`)
) ENGINE=InnoDB AUTO_INCREMENT=53799 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_features`
--

DROP TABLE IF EXISTS `mpc_global_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_features` (
  `id` int NOT NULL AUTO_INCREMENT,
  `feature_group_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feature_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selluseller_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `datatype` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `mandatory` tinyint(1) DEFAULT NULL,
  `field_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `x_features_set_id_and_category_id` (`feature_group_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14886 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_marketplace_value_rules`
--

DROP TABLE IF EXISTS `mpc_global_marketplace_value_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_marketplace_value_rules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `value_to_read` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `formula` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exceptional_cases` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marketplace_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_feature_mapping_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `applicable` tinyint(1) DEFAULT '1',
  `static` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `separator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `separator_rule` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=846 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_multimedia`
--

DROP TABLE IF EXISTS `mpc_global_multimedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_multimedia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attachment_file_file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment_file_content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment_file_file_size` int DEFAULT NULL,
  `attachment_file_updated_at` datetime DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_private` tinyint(1) DEFAULT NULL,
  `media_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keep_as_url` int DEFAULT NULL,
  `is_video` int DEFAULT NULL,
  `variant_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `x_multimedia_on_product_id` (`product_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_option_types`
--

DROP TABLE IF EXISTS `mpc_global_option_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_option_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `presentation` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_option_types_on_name` (`name`) USING BTREE,
  KEY `index_mpc_option_types_on_position` (`position`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_option_value_variants`
--

DROP TABLE IF EXISTS `mpc_global_option_value_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_option_value_variants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `variant_id` int DEFAULT NULL,
  `option_value_id` int DEFAULT NULL,
  `option_type_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_variants_on_option_value_id` (`option_value_id`) USING BTREE,
  KEY `index_on_variant_id_and_option_value_id` (`variant_id`,`option_value_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_option_values`
--

DROP TABLE IF EXISTS `mpc_global_option_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_option_values` (
  `id` int NOT NULL AUTO_INCREMENT,
  `position` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `presentation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `option_type_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_option_values_on_name` (`name`) USING BTREE,
  KEY `index_mpc_option_values_on_option_type_id` (`option_type_id`) USING BTREE,
  KEY `x_mpc_option_values_on_position` (`position`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_product_categories`
--

DROP TABLE IF EXISTS `mpc_global_product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_product_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_products_taxons_on_position` (`position`) USING BTREE,
  KEY `index_mpc_products_taxons_on_product_id` (`product_id`) USING BTREE,
  KEY `index_mpc_products_taxons_on_category_id` (`category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=44284 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_product_descriptions`
--

DROP TABLE IF EXISTS `mpc_global_product_descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_product_descriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` text COLLATE utf8mb4_unicode_ci,
  `product_id` int DEFAULT NULL,
  `description_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `x_descriptions_product_id` (`product_id`),
  KEY `x_descriptions_variant_id` (`variant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40013 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_product_families`
--

DROP TABLE IF EXISTS `mpc_global_product_families`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_product_families` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_family_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_on_product_family_code` (`product_family_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_product_features`
--

DROP TABLE IF EXISTS `mpc_global_product_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_product_features` (
  `id` int NOT NULL AUTO_INCREMENT,
  `value` text COLLATE utf8mb4_unicode_ci,
  `raw_value` text COLLATE utf8mb4_unicode_ci,
  `presentation_value` text COLLATE utf8mb4_unicode_ci,
  `product_id` int DEFAULT NULL,
  `global_feature_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `position` int DEFAULT '0',
  `sign` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `x_mpc_product_product_features_on_position` (`position`) USING BTREE,
  KEY `x_product_product_features_on_product_id` (`product_id`) USING BTREE,
  KEY `x_mpc_product_product_features_on_feature_id` (`global_feature_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=376754 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_product_images`
--

DROP TABLE IF EXISTS `mpc_global_product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_product_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attachment_file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment_content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment_file_size` int DEFAULT NULL,
  `attachment_updated_at` datetime DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `variation_id` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  `is_main` tinyint(1) DEFAULT NULL,
  `is_private` tinyint(1) DEFAULT NULL,
  `image_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cdn_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `x_images_product_id` (`product_id`),
  KEY `x_images_variation_id` (`variation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52745 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_product_option_types`
--

DROP TABLE IF EXISTS `mpc_global_product_option_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_product_option_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `position` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `option_type_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_product_option_types_on_option_type_id` (`option_type_id`) USING BTREE,
  KEY `index_mpc_product_option_types_on_position` (`position`) USING BTREE,
  KEY `index_mpc_product_option_types_on_product_id` (`product_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_product_series`
--

DROP TABLE IF EXISTS `mpc_global_product_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_product_series` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_series_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_on_product_series_code` (`product_series_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_product_shipping_methods`
--

DROP TABLE IF EXISTS `mpc_global_product_shipping_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_product_shipping_methods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `global_product_id` int DEFAULT NULL,
  `shipping_method_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `x_gp_product_id` (`global_product_id`),
  KEY `x_gp_shipping_method_id` (`shipping_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_products`
--

DROP TABLE IF EXISTS `mpc_global_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `master_sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `available_on` datetime DEFAULT NULL,
  `discontinue_on` datetime DEFAULT NULL,
  `brand_part_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` text COLLATE utf8mb4_unicode_ci,
  `brand` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `permalink` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_category_id` int DEFAULT NULL,
  `promotionable` tinyint(1) DEFAULT '1',
  `data_level` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `master_account_id` int DEFAULT NULL,
  `version` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_of_variants` int DEFAULT NULL,
  `product_family_id` int DEFAULT NULL,
  `product_series_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `mp_title` text COLLATE utf8mb4_unicode_ci,
  `long_product_name` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_mpc_products_on_permalink` (`permalink`) USING BTREE,
  KEY `index_mpc_products_on_available_on` (`available_on`) USING BTREE,
  KEY `index_mpc_products_on_deleted_at` (`deleted_at`) USING BTREE,
  KEY `index_mpc_products_on_discontinue_on` (`discontinue_on`) USING BTREE,
  KEY `index_mpc_products_on_name` (`name`) USING BTREE,
  KEY `index_mpc_products_on_shipping_category_id` (`shipping_category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5992 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_purchase_reasons`
--

DROP TABLE IF EXISTS `mpc_global_purchase_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_purchase_reasons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attachment_file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment_content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment_file_size` int DEFAULT NULL,
  `attachment_updated_at` datetime DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_private` tinyint(1) DEFAULT NULL,
  `origin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `reason_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cdn_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `x_mpc_purchase_reasons_on_position` (`position`) USING BTREE,
  KEY `x_purchase_reasons_on_product_id` (`product_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=54850 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_seller_mp_products`
--

DROP TABLE IF EXISTS `mpc_global_seller_mp_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_seller_mp_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_id` int DEFAULT NULL,
  `variant_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `marketplace_product_id` int DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `is_manual_mapping` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_mpc_global_seller_mp_products_on_seller_id` (`seller_id`),
  KEY `index_mpc_global_seller_mp_products_on_product_id` (`product_id`),
  KEY `index_mpc_global_seller_mp_products_on_variant_id` (`variant_id`),
  KEY `index_mpc_global_seller_mp_products_on_marketplace_product_id` (`marketplace_product_id`),
  KEY `index_mpc_global_seller_mp_products_on_seller_marketplace_id` (`seller_marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=440 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_update_cycles`
--

DROP TABLE IF EXISTS `mpc_global_update_cycles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_update_cycles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `master_account_id` int DEFAULT NULL,
  `version` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_used` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_global_update_cycles_on_master_account_id` (`master_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_variant_prices`
--

DROP TABLE IF EXISTS `mpc_global_variant_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_variant_prices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `variant_id` int NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `special_price` decimal(10,2) DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_prices_on_deleted_at` (`deleted_at`) USING BTREE,
  KEY `index_mpc_prices_on_variant_id_and_currency` (`variant_id`,`currency`) USING BTREE,
  KEY `index_mpc_prices_on_variant_id` (`variant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_variants`
--

DROP TABLE IF EXISTS `mpc_global_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_variants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `brand_product_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gtin_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weight` decimal(8,2) DEFAULT '0.00',
  `height` decimal(8,2) DEFAULT NULL,
  `width` decimal(8,2) DEFAULT NULL,
  `depth` decimal(8,2) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `discontinue_on` datetime DEFAULT NULL,
  `is_master` tinyint(1) DEFAULT '0',
  `product_id` int DEFAULT NULL,
  `cost_price` decimal(10,2) DEFAULT NULL,
  `cost_currency` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int DEFAULT NULL,
  `master_account_id` int DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_variants_on_deleted_at` (`deleted_at`) USING BTREE,
  KEY `index_mpc_variants_on_discontinue_on` (`discontinue_on`) USING BTREE,
  KEY `index_mpc_variants_on_is_master` (`is_master`) USING BTREE,
  KEY `index_mpc_variants_on_position` (`position`) USING BTREE,
  KEY `index_mpc_variants_on_product_id` (`product_id`) USING BTREE,
  KEY `index_mpc_variants_on_sku` (`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24777 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_global_versions`
--

DROP TABLE IF EXISTS `mpc_global_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_global_versions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `versioned_id` int DEFAULT NULL,
  `versioned_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `user_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modifications` text COLLATE utf8mb4_unicode_ci,
  `number` int DEFAULT NULL,
  `reverted_from` int DEFAULT NULL,
  `tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_global_versions_on_versioned_id_and_versioned_type` (`versioned_id`,`versioned_type`),
  KEY `index_mpc_global_versions_on_user_id_and_user_type` (`user_id`,`user_type`),
  KEY `index_mpc_global_versions_on_user_name` (`user_name`),
  KEY `index_mpc_global_versions_on_number` (`number`),
  KEY `index_mpc_global_versions_on_tag` (`tag`),
  KEY `index_mpc_global_versions_on_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=581610 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_group_products`
--

DROP TABLE IF EXISTS `mpc_group_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_group_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int DEFAULT NULL,
  `master_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_history_details`
--

DROP TABLE IF EXISTS `mpc_history_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_history_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` tinyint(1) DEFAULT '0',
  `product_clone_history_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_clon_hs_on_id` (`product_clone_history_id`),
  CONSTRAINT `fk_rails_e265f69cc6` FOREIGN KEY (`product_clone_history_id`) REFERENCES `mpc_product_clone_histories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=25042012 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_images`
--

DROP TABLE IF EXISTS `mpc_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attachment_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment_file_size` int DEFAULT NULL,
  `attachment_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment_updated_at` datetime DEFAULT NULL,
  `attachment_alt_text` mediumtext COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `reference_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cdn_url` text COLLATE utf8_unicode_ci,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `mpc_images_reference_code` (`reference_code`)
) ENGINE=InnoDB AUTO_INCREMENT=207980961 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_inventory_assets`
--

DROP TABLE IF EXISTS `mpc_inventory_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_inventory_assets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `inventory_product_id` int DEFAULT NULL,
  `brand` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uom` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `inventory_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `lot_control` tinyint(1) DEFAULT '0',
  `is_expiry_date` tinyint(1) DEFAULT '0',
  `shelf_life_in_day` int DEFAULT '0',
  `uom_value` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inventory_control` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_inventory_assets_on_inventory_product_id` (`inventory_product_id`),
  KEY `index_mpc_inventory_assets_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=440970 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_inventory_fields`
--

DROP TABLE IF EXISTS `mpc_inventory_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_inventory_fields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inventory_product_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `x_ip_fields_iproduct_id` (`inventory_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=555087 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_inventory_products`
--

DROP TABLE IF EXISTS `mpc_inventory_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_inventory_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `inventory_sku` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `in_hand` int NOT NULL DEFAULT '0',
  `sellable` int NOT NULL DEFAULT '0',
  `reserve` int NOT NULL DEFAULT '0',
  `in_process` int NOT NULL DEFAULT '0',
  `sold` int NOT NULL DEFAULT '0',
  `damaged` int NOT NULL DEFAULT '0',
  `low_inventory_threshold` int DEFAULT '0',
  `seller_id` int NOT NULL,
  `created_on_fba` datetime DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cost_price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `height` decimal(10,2) NOT NULL,
  `width` decimal(10,2) NOT NULL,
  `length` decimal(10,2) NOT NULL,
  `weight` decimal(10,2) NOT NULL,
  `sr_number_required` tinyint(1) NOT NULL DEFAULT '0',
  `upc` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage_type` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'standard',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `oos` int DEFAULT NULL,
  `permalink` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_mpc_inventory_products_seller_id` (`seller_id`),
  KEY `idx_mpc_inventory_products_inventory_sku_seller_id` (`inventory_sku`,`seller_id`),
  KEY `ix_inventory_products_active_seller` (`active`,`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48171815 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_invoice_setting_seller_marketplaces`
--

DROP TABLE IF EXISTS `mpc_invoice_setting_seller_marketplaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_invoice_setting_seller_marketplaces` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoice_setting_id` int DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `marketplace_id` int DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_setting_smp_on_smp_id` (`seller_marketplace_id`),
  KEY `index_setting_smp_on_mp_id` (`marketplace_id`),
  KEY `index_setting_smp_on_country_id` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_invoice_settings`
--

DROP TABLE IF EXISTS `mpc_invoice_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_invoice_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prefix` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number_of_digits` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_invoice_settings_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_item_putaway_statuses`
--

DROP TABLE IF EXISTS `mpc_item_putaway_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_item_putaway_statuses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `line_item_id` int DEFAULT NULL,
  `received_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_item_putaway_statuses_on_line_item_id` (`line_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=722343 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_job_configs`
--

DROP TABLE IF EXISTS `mpc_job_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_job_configs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `worker_count` int DEFAULT NULL,
  `queue_count` int DEFAULT NULL,
  `worker_payload` text COLLATE utf8mb4_unicode_ci,
  `queue_consumer_count` int DEFAULT NULL,
  `sync_queue_count` int DEFAULT NULL,
  `sync_queue_consumer_count` int DEFAULT NULL,
  `config_uid` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_job_configs_on_seller_id` (`seller_id`),
  KEY `index_mpc_job_configs_on_id` (`id`),
  CONSTRAINT `fk_rails_55abcd7c78` FOREIGN KEY (`seller_id`) REFERENCES `mpc_sellers` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_jobs`
--

DROP TABLE IF EXISTS `mpc_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `config_uid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fetch_count` int DEFAULT NULL,
  `sync_count` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `limit` int DEFAULT NULL,
  `offset` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_jobs_on_seller_id` (`seller_id`),
  KEY `index_mpc_jobs_on_id` (`id`),
  CONSTRAINT `fk_rails_49a7fbc0b7` FOREIGN KEY (`seller_id`) REFERENCES `mpc_sellers` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_kit_details`
--

DROP TABLE IF EXISTS `mpc_kit_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_kit_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `line_item_id` int DEFAULT NULL,
  `inventory_product_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `isku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit` int DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `paid_price` decimal(10,0) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `special_price` decimal(15,2) DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `index_mpc_kit_details_on_line_item_id` (`line_item_id`),
  KEY `index_mpc_kit_details_on_inventory_product_id` (`inventory_product_id`),
  KEY `index_mpc_kit_details_on_product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5619561 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_kit_products`
--

DROP TABLE IF EXISTS `mpc_kit_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_kit_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity` int DEFAULT '0',
  `inventory_product_id` int NOT NULL,
  `product_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `price` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_kit_products_on_inventory_product_id` (`inventory_product_id`),
  KEY `index_mpc_kit_products_on_product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=255483 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_languages`
--

DROP TABLE IF EXISTS `mpc_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `presentation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_line_item_details`
--

DROP TABLE IF EXISTS `mpc_line_item_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_line_item_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `master_sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `master_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_original_price` decimal(15,2) DEFAULT NULL,
  `item_paid_price` decimal(15,2) DEFAULT NULL,
  `seller_voucher_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_voucher_amount` decimal(15,2) DEFAULT NULL,
  `details` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_item_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `item_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `shipment_id` int DEFAULT NULL,
  `mp_tracking_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `voucher_platform` decimal(15,2) DEFAULT NULL,
  `tax_amount` decimal(15,2) DEFAULT NULL,
  `digital_delivery_info` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancel_return_initiator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sla_timestamp` datetime DEFAULT NULL,
  `stage_pay_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tracking_code_pre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason_detail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_flag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `package_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `promised_shipping_time` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_line_item_details_on_line_item_id` (`line_item_id`),
  KEY `index_mpc_line_item_details_on_order_id` (`order_id`),
  KEY `index_mpc_line_item_details_on_shipment_id` (`shipment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58899638 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_line_items`
--

DROP TABLE IF EXISTS `mpc_line_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_line_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `price` decimal(15,2) DEFAULT '0.00',
  `pick_at_store` tinyint(1) DEFAULT '0',
  `shipping_charges` decimal(8,2) DEFAULT '0.00',
  `shipment_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `smp_shipping_method_id` int DEFAULT NULL,
  `shipping_type_id` int DEFAULT NULL,
  `promotion_id` int DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `paid_price` decimal(15,2) DEFAULT NULL,
  `retail_price` decimal(15,2) DEFAULT '0.00',
  `invoice_number` varchar(255) DEFAULT NULL,
  `price_in_seller_currency` decimal(15,2) DEFAULT '0.00',
  `retail_price_in_seller_currency` decimal(15,2) DEFAULT '0.00',
  `tax_amount` decimal(15,2) DEFAULT '0.00',
  `paid_price_in_seller_currency` decimal(15,2) DEFAULT '0.00',
  `selling_price` decimal(15,2) DEFAULT '0.00',
  `selling_price_in_seller_currency` decimal(15,2) DEFAULT '0.00',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_line_items_on_order_id` (`order_id`),
  KEY `index_mpc_line_items_on_product_id` (`product_id`),
  KEY `index_mpc_line_items_on_shipment_id` (`shipment_id`),
  KEY `index_mpc_line_items_on_smp_shipping_method_id` (`smp_shipping_method_id`),
  KEY `ix_line_items_promotion_id` (`promotion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=97319084 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_locations`
--

DROP TABLE IF EXISTS `mpc_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_locations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage_type` int DEFAULT NULL,
  `height` decimal(10,2) DEFAULT NULL,
  `width` decimal(10,2) DEFAULT NULL,
  `length` decimal(10,2) DEFAULT NULL,
  `section_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_locations_on_section_id` (`section_id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_manifests`
--

DROP TABLE IF EXISTS `mpc_manifests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_manifests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fba_dispatch_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_on_fba` datetime DEFAULT NULL,
  `system_generated` tinyint(1) DEFAULT '0',
  `created_by` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_manifests_number` (`number`),
  KEY `fk_rails_01eb10246e` (`seller_id`),
  KEY `fk_rails_655b2a41c0` (`seller_marketplace_id`),
  CONSTRAINT `fk_rails_655b2a41c0` FOREIGN KEY (`seller_marketplace_id`) REFERENCES `mpc_seller_marketplaces` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=832753 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_map_taxons`
--

DROP TABLE IF EXISTS `mpc_map_taxons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_map_taxons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `taxon_id` int DEFAULT NULL,
  `base_category_id` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'draft',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_base_category_id` (`base_category_id`),
  KEY `idx_seller_id` (`seller_id`),
  KEY `idx_taxon_id` (`taxon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=132541 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplace_image_assets`
--

DROP TABLE IF EXISTS `mpc_marketplace_image_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplace_image_assets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_id` int DEFAULT NULL,
  `marketplace_product_id` int DEFAULT NULL,
  `version` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `x_image_assets_image_id` (`image_id`),
  KEY `x_image_assets_mp_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1677290 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplace_keys`
--

DROP TABLE IF EXISTS `mpc_marketplace_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplace_keys` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `presenation` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `marketplace_id` int NOT NULL,
  `sequence` int NOT NULL,
  `input_required` tinyint(1) DEFAULT '1',
  `visible_on_ui` tinyint(1) DEFAULT '1',
  `help_text` varchar(5000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_marketplace_keys_on_name` (`name`),
  KEY `index_mpc_marketplace_keys_on_marketplace_id` (`marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=580 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplace_languages`
--

DROP TABLE IF EXISTS `mpc_marketplace_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplace_languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_id` int DEFAULT NULL,
  `language_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplace_order_states`
--

DROP TABLE IF EXISTS `mpc_marketplace_order_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplace_order_states` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_id` int DEFAULT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `presentation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fulfilment_order_state_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_marketplace_order_states_on_marketplace_id` (`marketplace_id`),
  KEY `index_mpc_marketplace_order_states_on_fulfilment_order_state_id` (`fulfilment_order_state_id`),
  CONSTRAINT `fk_rails_319acabfc3` FOREIGN KEY (`marketplace_id`) REFERENCES `mpc_marketplaces` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_rails_f086ba83b7` FOREIGN KEY (`fulfilment_order_state_id`) REFERENCES `mpc_fulfilment_order_states` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=9075124 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplace_product_collections`
--

DROP TABLE IF EXISTS `mpc_marketplace_product_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplace_product_collections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int DEFAULT NULL,
  `collection_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mp_collections_on_marketplace_product_id` (`marketplace_product_id`),
  KEY `index_mpc_marketplace_product_collections_on_collection_id` (`collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=792613 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplace_product_details`
--

DROP TABLE IF EXISTS `mpc_marketplace_product_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplace_product_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int DEFAULT NULL,
  `pickup_point_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `parent_marketplace_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '',
  `marketplace_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_marketplace_product_details_on_marketplace_product_id` (`marketplace_product_id`),
  KEY `index_mpc_marketplace_product_details_on_pickup_point_id` (`pickup_point_id`),
  CONSTRAINT `fk_rails_499f5045b2` FOREIGN KEY (`pickup_point_id`) REFERENCES `mpc_pickup_points` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=39179525 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplace_product_extras`
--

DROP TABLE IF EXISTS `mpc_marketplace_product_extras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplace_product_extras` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int unsigned NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_mpc_marketplace_product_extras_marketplace_product_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=124508085 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplace_product_fields`
--

DROP TABLE IF EXISTS `mpc_marketplace_product_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplace_product_fields` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplace_product_foc_details`
--

DROP TABLE IF EXISTS `mpc_marketplace_product_foc_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplace_product_foc_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int DEFAULT NULL,
  `foc_info` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=155121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplace_product_sales`
--

DROP TABLE IF EXISTS `mpc_marketplace_product_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplace_product_sales` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int unsigned NOT NULL,
  `price` decimal(15,2) DEFAULT '0.00',
  `selling_price` decimal(15,2) DEFAULT '0.00',
  `sale_start_date` datetime DEFAULT NULL,
  `sale_end_date` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_mpc_marketplace_sales_mp_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=124532683 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplace_product_stocks`
--

DROP TABLE IF EXISTS `mpc_marketplace_product_stocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplace_product_stocks` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int unsigned NOT NULL,
  `allocated_stock` int DEFAULT '0',
  `prebooking_stock` tinyint(1) DEFAULT '0',
  `sync_stock` tinyint(1) DEFAULT '1',
  `allocated_stock_on_mp` int DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_mpc_marketplace_product_mp_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=147386858 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplace_product_types`
--

DROP TABLE IF EXISTS `mpc_marketplace_product_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplace_product_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int DEFAULT NULL,
  `product_type` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_marketplace_product_id` (`marketplace_product_id`),
  KEY `index_mpc_marketplace_product_type` (`product_type`)
) ENGINE=InnoDB AUTO_INCREMENT=43637 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplace_products`
--

DROP TABLE IF EXISTS `mpc_marketplace_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplace_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_id` int NOT NULL,
  `product_id` int NOT NULL,
  `seller_marketplace_id` int NOT NULL,
  `marketplace_code` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_listed` tinyint(1) DEFAULT '0',
  `taxon_id` int DEFAULT NULL,
  `brand_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `is_created` tinyint(1) DEFAULT NULL,
  `is_sku_available` tinyint(1) DEFAULT '1',
  `active` int NOT NULL DEFAULT '0',
  `mp_connected` tinyint(1) DEFAULT '1',
  `is_cloned` tinyint(1) DEFAULT '0',
  `image_updated` tinyint(1) DEFAULT '1',
  `product_clone_history_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `delivery_sla` int unsigned NOT NULL DEFAULT '0',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_marketplace_products_smp_id` (`seller_marketplace_id`),
  KEY `ix_marketplace_products_parent_id` (`parent_id`),
  KEY `ix_marketplace_products_product_id` (`product_id`),
  KEY `ix_marketplace_products_product_id_smp_id` (`product_id`,`seller_marketplace_id`),
  KEY `ix_marketplace_products_marketplace_idd` (`marketplace_id`),
  KEY `ix_marketplace_products_state` (`state`),
  KEY `ix_marketplace_products_taxon_id` (`taxon_id`),
  KEY `ix_marketplace_products_brand_id` (`brand_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119768238 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplace_setting_fields`
--

DROP TABLE IF EXISTS `mpc_marketplace_setting_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplace_setting_fields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_id` int DEFAULT NULL,
  `field_type` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `data_type` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `mandatory` tinyint(1) NOT NULL DEFAULT '0',
  `field_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` int DEFAULT '0',
  `visible_on_ui` tinyint(1) DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_marketplace_setting_fields_on_marketplace_id` (`marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplaces`
--

DROP TABLE IF EXISTS `mpc_marketplaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplaces` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `domain_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `country_id` int NOT NULL,
  `currency_id` int NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `registration_domain` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `activation_date` date DEFAULT NULL,
  `is_prefered` tinyint(1) DEFAULT '0',
  `is_webstore` tinyint(1) DEFAULT '0',
  `help_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `onboarding_position` int DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `support_ss_category` tinyint(1) DEFAULT '0',
  `seller_tag` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lock_stock_update` tinyint(1) DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `is_global_marketplace` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_mpc_marketplaces_on_country_id` (`country_id`),
  KEY `index_mpc_marketplaces_on_currency_id` (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplaces_operations`
--

DROP TABLE IF EXISTS `mpc_marketplaces_operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplaces_operations` (
  `marketplace_id` int DEFAULT NULL,
  `operation_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  KEY `index_mpc_marketplaces_operations_on_marketplace_id` (`marketplace_id`),
  KEY `index_mpc_marketplaces_operations_on_operation_id` (`operation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_master_accounts`
--

DROP TABLE IF EXISTS `mpc_master_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_master_accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `ewms_tenant_id` int DEFAULT NULL,
  `short_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `fulfilment_network_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_master_accounts_on_ewms_tenant_id` (`ewms_tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_master_dashboard_summaries`
--

DROP TABLE IF EXISTS `mpc_master_dashboard_summaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_master_dashboard_summaries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `master_account_id` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `day` int DEFAULT NULL,
  `total_order_count` int DEFAULT NULL,
  `total_sales_in_base_currency` decimal(15,2) DEFAULT NULL,
  `total_sales_in_mp_currency` decimal(15,2) DEFAULT NULL,
  `order_total_by_product_in_base_currency` decimal(15,2) DEFAULT NULL,
  `order_total_by_product_in_mp_currency` decimal(15,2) DEFAULT NULL,
  `total_cancel_order_count` int DEFAULT NULL,
  `cancel_orders_amount` decimal(15,2) DEFAULT NULL,
  `cancel_orders_amount_in_mp_currency` decimal(15,2) DEFAULT NULL,
  `discount_order_processed` int DEFAULT NULL,
  `discount_amount` decimal(15,2) DEFAULT NULL,
  `discount_amount_in_mp_currency` decimal(15,2) DEFAULT NULL,
  `cancel_total_by_product_in_mp_currency` decimal(15,2) DEFAULT NULL,
  `cancel_total_by_product_in_base` decimal(15,2) DEFAULT NULL,
  `promotion_sales` int DEFAULT NULL,
  `active_promotions_count` int DEFAULT NULL,
  `total_units_sold` int DEFAULT NULL,
  `inventory_stock_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_master_dashboard_summaries_on_day` (`day`) USING BTREE,
  KEY `index_master_dashboard_summaries_on_seller_id` (`seller_id`) USING BTREE,
  KEY `index_master_dashboard_summaries_on_seller_marketplace_id` (`seller_marketplace_id`) USING BTREE,
  KEY `index_master_dashboard_summaries_on_master_account_id` (`master_account_id`) USING BTREE,
  KEY `index_master_dashboard_summaries_on_country_id` (`country_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12666 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_masters`
--

DROP TABLE IF EXISTS `mpc_masters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_masters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `critical_limit` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_mp_currency_wise_prices`
--

DROP TABLE IF EXISTS `mpc_mp_currency_wise_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_mp_currency_wise_prices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `price` decimal(15,2) DEFAULT '0.00',
  `selling_price` decimal(15,2) DEFAULT '0.00',
  `special_start_date` datetime DEFAULT NULL,
  `special_end_date` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_mp_currency_wise_prices_on_marketplace_product_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60077 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_mp_line_items`
--

DROP TABLE IF EXISTS `mpc_mp_line_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_mp_line_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `line_item_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `shipment_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `mp_tracking_number` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mp_line_items_code` (`line_item_id`),
  KEY `index_mp_line_items_order_id` (`order_id`),
  KEY `index_mp_line_items_shipment_id` (`shipment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57992983 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_mydin_category_mappings`
--

DROP TABLE IF EXISTS `mpc_mydin_category_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_mydin_category_mappings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `level1_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level1_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level2_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level2_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level2_parent_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level3_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level3_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level3_parent_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level4_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level4_Name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level4_parent_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_marketplace_id` int DEFAULT NULL,
  `dest_marketplace_id` int DEFAULT NULL,
  `taxon_id` int DEFAULT NULL,
  `taxon_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_category_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_catgeory_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=711 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_notification_inbox`
--

DROP TABLE IF EXISTS `mpc_notification_inbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_notification_inbox` (
  `id` int NOT NULL AUTO_INCREMENT,
  `notification_id` int NOT NULL,
  `seller_id` int NOT NULL,
  `template_params` text COLLATE utf8mb4_general_ci NOT NULL,
  `status` int DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_notification_inbox_on_notification_id` (`notification_id`),
  KEY `index_mpc_notification_inbox_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28343155 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_notification_user_statuses`
--

DROP TABLE IF EXISTS `mpc_notification_user_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_notification_user_statuses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `notification_inbox_id` int NOT NULL,
  `user_id` int NOT NULL,
  `status` int DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_notification_user_statuses_on_notification_inbox_id` (`notification_inbox_id`),
  KEY `index_mpc_notification_user_statuses_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=194694509 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_notifications`
--

DROP TABLE IF EXISTS `mpc_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_type` int NOT NULL,
  `notification_channel` int NOT NULL,
  `event` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `level` int NOT NULL,
  `template` text COLLATE utf8mb4_general_ci NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `new_action` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_notify_subscribe_users`
--

DROP TABLE IF EXISTS `mpc_notify_subscribe_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_notify_subscribe_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_id` int DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_notify_subscribe_users_on_marketplace_id` (`marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_onboard_details`
--

DROP TABLE IF EXISTS `mpc_onboard_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_onboard_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `country_id` int DEFAULT NULL,
  `call_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_operations`
--

DROP TABLE IF EXISTS `mpc_operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_operations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `presentation` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `mpc_operations_name_index` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_order_adjustments`
--

DROP TABLE IF EXISTS `mpc_order_adjustments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_order_adjustments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_discount` decimal(15,2) DEFAULT '0.00',
  `seller_discount` decimal(15,2) DEFAULT '0.00',
  `marketplace_wallet` decimal(15,2) DEFAULT '0.00',
  `adjustments` text COLLATE utf8mb4_general_ci,
  `order_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_order_adjustments_on_id` (`id`),
  KEY `index_mpc_order_adjustments_on_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48993942 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_order_conciliations`
--

DROP TABLE IF EXISTS `mpc_order_conciliations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_order_conciliations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `fetched_at_in_selluseller` datetime DEFAULT NULL,
  `created_at_in_selluseller` datetime DEFAULT NULL,
  `created_at_in_ewms` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_order_conciliations_on_order_id` (`order_id`),
  KEY `order_number` (`order_number`(191)),
  KEY `seller_marketplace_id` (`seller_marketplace_id`),
  KEY `ix_order_conciliations_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58982798 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_order_details`
--

DROP TABLE IF EXISTS `mpc_order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_order_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `master_account_id` int DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `brand` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thrird_party_address_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `market_place_order_number` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_confirm` tinyint(1) DEFAULT NULL,
  `sap_order_number` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sap_delivery_order_number` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sap_invoice_number` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `goods_issue_status` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_label_status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_order_details_on_order_id` (`order_id`),
  KEY `index_mpc_order_details_on_master_account_id` (`master_account_id`),
  KEY `index_mpc_order_details_on_market_place_order_number` (`market_place_order_number`)
) ENGINE=InnoDB AUTO_INCREMENT=700144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_order_failure_reasons`
--

DROP TABLE IF EXISTS `mpc_order_failure_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_order_failure_reasons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reason_code` int DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marketplace_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_order_failure_reasons_on_marketplace_id` (`marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_order_histories`
--

DROP TABLE IF EXISTS `mpc_order_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_order_histories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_subscription_id` int DEFAULT NULL,
  `available_order_count` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `subscription_paid` tinyint(1) DEFAULT '1',
  `unprocess_order_count` int DEFAULT NULL,
  `got_order_count` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_order_histories_seller_subsc_id` (`seller_subscription_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2837981 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_order_labels`
--

DROP TABLE IF EXISTS `mpc_order_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_order_labels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attachment_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment_file_size` int DEFAULT NULL,
  `attachment_updated_at` datetime DEFAULT NULL,
  `shipment_id` int NOT NULL,
  `type` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_order_labels_on_shipment_id` (`shipment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=179047052 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_order_sync_logs`
--

DROP TABLE IF EXISTS `mpc_order_sync_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_order_sync_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_marketplace_id` int DEFAULT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=289862251 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_order_taggings`
--

DROP TABLE IF EXISTS `mpc_order_taggings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_order_taggings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parcel_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bag_tag_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipment_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_order_taggings_on_shipment_id` (`shipment_id`),
  KEY `index_mpc_order_taggings_on_parcel_id` (`parcel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3534 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_order_tax_details`
--

DROP TABLE IF EXISTS `mpc_order_tax_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_order_tax_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `branch_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tax_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `national_registration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `total_tax_amount` decimal(15,2) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_order_tax_details_on_order_id1` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27304468 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_orders`
--

DROP TABLE IF EXISTS `mpc_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `state` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `bill_address_id` int DEFAULT NULL,
  `ship_address_id` int DEFAULT NULL,
  `payment_total` decimal(15,2) DEFAULT '0.00',
  `special_instructions` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `currency_id` int DEFAULT NULL,
  `send_as_gift` tinyint(1) DEFAULT NULL,
  `greeting_message` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `market_place_order_number` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `marketplace_order_state_id` int DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `cart_no` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `platform_user` tinyint(1) DEFAULT NULL,
  `payment_method_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `fulfilment_mode` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_in_seller_currency` decimal(15,2) NOT NULL DEFAULT '0.00',
  `is_fetched` tinyint(1) DEFAULT '0',
  `sales_channel` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_historical` tinyint(1) DEFAULT '0',
  `seller_subscription_id` int DEFAULT NULL,
  `fulfil_by_mp` tinyint(1) DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_mpc_orders_number_smp_id` (`number`,`seller_marketplace_id`),
  KEY `ix_mpc_orders_smp_id` (`seller_marketplace_id`),
  KEY `ix_mpc_orders_seller_id` (`seller_id`),
  KEY `ix_mpc_orders_number` (`number`),
  KEY `ix_mpc_orders_bill_address_id` (`bill_address_id`),
  KEY `ix_mpc_orders_ship_address_id` (`ship_address_id`),
  KEY `ix_mpc_orders_state` (`state`),
  KEY `ix_mpc_orders_seller_subscription_id` (`seller_subscription_id`),
  KEY `ix_mpc_orders_market_place_order_number` (`market_place_order_number`),
  KEY `ix_orders_order_date` (`order_date`),
  KEY `ix_orders_seller_state` (`seller_id`,`state`)
) ENGINE=InnoDB AUTO_INCREMENT=79353514 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_otp_details`
--

DROP TABLE IF EXISTS `mpc_otp_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_otp_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `times_genrated` int DEFAULT NULL,
  `verfied_at` datetime DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `send_at` datetime DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `enabled_on` datetime DEFAULT NULL,
  `disabled_on` datetime DEFAULT NULL,
  `mfa_enabled` tinyint(1) DEFAULT NULL,
  `mfa_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_otp_details_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16940 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_payment_gateways`
--

DROP TABLE IF EXISTS `mpc_payment_gateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_payment_gateways` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_payment_histories`
--

DROP TABLE IF EXISTS `mpc_payment_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_payment_histories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_subscription_id` int DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `permalink` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payment_id` int DEFAULT NULL,
  `invoice_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment_file_size` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_payment_histories_on_seller_subscription_id` (`seller_subscription_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2826746 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_payment_merchants`
--

DROP TABLE IF EXISTS `mpc_payment_merchants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_payment_merchants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `merchant_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mpc_country_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_payment_methods`
--

DROP TABLE IF EXISTS `mpc_payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_payment_methods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `payment_method_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `presentation` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `cod` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=146066 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_payments`
--

DROP TABLE IF EXISTS `mpc_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_subscription_id` int DEFAULT NULL,
  `payment_gateway_id` int DEFAULT NULL,
  `error_response` mediumtext COLLATE utf8_unicode_ci,
  `response` mediumtext COLLATE utf8_unicode_ci,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `order_history_id` int DEFAULT NULL,
  `total_amount_paid` decimal(15,2) DEFAULT NULL,
  `payment_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `custom_currency` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `description` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `duration` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_payments_on_seller_subscription_id` (`seller_subscription_id`),
  KEY `index_mpc_payments_on_payment_gateway_id` (`payment_gateway_id`),
  KEY `index_mpc_payments_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2826790 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_payouts`
--

DROP TABLE IF EXISTS `mpc_payouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_payouts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_id` int DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `subtotal2` decimal(15,2) DEFAULT '0.00',
  `subtotal1` decimal(15,2) DEFAULT '0.00',
  `shipment_fee_credit` decimal(15,2) DEFAULT '0.00',
  `item_revenue` decimal(15,2) DEFAULT '0.00',
  `payout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `other_revenue_total` decimal(15,2) DEFAULT '0.00',
  `fees_total` decimal(15,2) DEFAULT '0.00',
  `refunds` decimal(15,2) DEFAULT '0.00',
  `guarantee_deposit` decimal(10,0) DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  `fees_on_refunds_total` decimal(15,2) DEFAULT '0.00',
  `closing_balance` decimal(15,2) DEFAULT '0.00',
  `paid` int DEFAULT NULL,
  `opening_balance` decimal(15,2) DEFAULT '0.00',
  `statement_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipment_fee` decimal(15,2) DEFAULT '0.00',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_payouts_on_seller_id` (`seller_id`),
  KEY `index_mpc_payouts_on_seller_marketplace_id` (`seller_marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=488 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_pickup_points`
--

DROP TABLE IF EXISTS `mpc_pickup_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_pickup_points` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `marketplace_code` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `display_name` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `seller_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_pickup_points_on_seller_id` (`seller_id`),
  CONSTRAINT `fk_rails_71e634d11a` FOREIGN KEY (`seller_id`) REFERENCES `mpc_sellers` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_price_tiers`
--

DROP TABLE IF EXISTS `mpc_price_tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_price_tiers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `price` decimal(10,0) DEFAULT NULL,
  `item_limit` int DEFAULT NULL,
  `price_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preq_quantity` int DEFAULT NULL,
  `customer_type_id` int DEFAULT NULL,
  `promotion_product_id` int DEFAULT NULL,
  `marketplace_product_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `marketplace_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `push_to_matketplace_at` datetime DEFAULT NULL,
  `scheme` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `item_value` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1516 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_privilages`
--

DROP TABLE IF EXISTS `mpc_privilages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_privilages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_capability_id` int NOT NULL,
  `attachable_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `attachable_id` int NOT NULL,
  `permitted` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_privilages_on_account_capability_id` (`account_capability_id`),
  KEY `privilage_attachable_type_idx` (`attachable_type`(191),`attachable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_process_orders`
--

DROP TABLE IF EXISTS `mpc_process_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_process_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_history_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3261 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_product_clone_histories`
--

DROP TABLE IF EXISTS `mpc_product_clone_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_product_clone_histories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `process_count` int DEFAULT NULL,
  `total_count` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `source_marketplace_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `cloning_jid` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `listing_jid` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_activate` tinyint(1) DEFAULT '1',
  `total_failed` int DEFAULT '0',
  `total_ready_to_go` int DEFAULT '0',
  `total_drafted` int DEFAULT '0',
  `state` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `taxon_count` int DEFAULT NULL,
  `clone_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'product',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_sellers_on_id` (`seller_id`),
  KEY `index_mpc_sellers_mp_on_id` (`seller_marketplace_id`),
  KEY `index_mpc_sc_sellers_mp_on_id` (`source_marketplace_id`),
  CONSTRAINT `fk_rails_62bb64cdd4` FOREIGN KEY (`source_marketplace_id`) REFERENCES `mpc_seller_marketplaces` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_rails_71aefacaf5` FOREIGN KEY (`seller_marketplace_id`) REFERENCES `mpc_seller_marketplaces` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_rails_d723ce8992` FOREIGN KEY (`seller_id`) REFERENCES `mpc_sellers` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=26237 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_product_fetch_histories`
--

DROP TABLE IF EXISTS `mpc_product_fetch_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_product_fetch_histories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `process_count` int DEFAULT NULL,
  `total_count` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_product_fetch_histories_on_seller_id` (`seller_id`),
  KEY `index_mpc_product_fetch_histories_on_seller_marketplace_id` (`seller_marketplace_id`),
  KEY `index_mpc_product_fetch_histories_on_id` (`seller_id`),
  KEY `index_mpc_product_fetch_histories_seller_mp_on_id` (`seller_marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=155594 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_product_images`
--

DROP TABLE IF EXISTS `mpc_product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_product_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attachable_id` int DEFAULT NULL,
  `attachable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int DEFAULT '0',
  `master` tinyint(1) DEFAULT '0',
  `image_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_product_images_on_attachable_id_and_attachable_type` (`attachable_id`,`attachable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=380956459 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_product_links`
--

DROP TABLE IF EXISTS `mpc_product_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_product_links` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `marketplace_product_id` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_product_links_on_parent_id` (`parent_id`),
  KEY `index_mpc_product_links_on_marketplace_product_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_products`
--

DROP TABLE IF EXISTS `mpc_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_id` int DEFAULT NULL,
  `sku` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `inventory_product_id` int DEFAULT NULL,
  `collection_id` int DEFAULT NULL,
  `available_on` datetime DEFAULT NULL,
  `product_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) DEFAULT '0',
  `permalink` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_currency` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(15,2) DEFAULT '0.00',
  `selling_price` decimal(15,2) DEFAULT '0.00',
  `number_of_marketplaces` int DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_mpc_products_permalink` (`permalink`),
  KEY `idx_mpc_products_collection_id` (`collection_id`),
  KEY `idx_mpc_products_inventory_product_id` (`inventory_product_id`),
  KEY `idx_mpc_products_seller_id` (`seller_id`),
  KEY `idx_mpc_products_sku` (`sku`),
  KEY `idx_mpc_products_seller_id_sku` (`seller_id`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=68170165 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_promocode_marketplaces`
--

DROP TABLE IF EXISTS `mpc_promocode_marketplaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_promocode_marketplaces` (
  `id` int NOT NULL AUTO_INCREMENT,
  `promocode_id` int NOT NULL,
  `marketplace_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_promocode_marketplaces_on_marketplace_id` (`marketplace_id`),
  KEY `index_mpc_promocode_marketplaces_on_promocode_id` (`promocode_id`)
) ENGINE=InnoDB AUTO_INCREMENT=481 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_promocode_plans`
--

DROP TABLE IF EXISTS `mpc_promocode_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_promocode_plans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `promocode_id` int NOT NULL,
  `subscription_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_promocode_plans_on_promocode_id` (`promocode_id`),
  KEY `index_mpc_promocode_plans_on_subscription_id` (`subscription_id`)
) ENGINE=InnoDB AUTO_INCREMENT=631 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_promocode_users`
--

DROP TABLE IF EXISTS `mpc_promocode_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_promocode_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `promocode_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_promocode_users_on_user_id` (`user_id`),
  KEY `index_mpc_promocode_users_on_promocode_id` (`promocode_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_promocodes`
--

DROP TABLE IF EXISTS `mpc_promocodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_promocodes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `promocode` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `discount_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `discount_value` decimal(8,2) NOT NULL DEFAULT '0.00',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `validity` int DEFAULT NULL,
  `validity_unit` int DEFAULT NULL,
  `user_type` int DEFAULT NULL,
  `redemption_limit` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `currency` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `subscription_types` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `braintree_discount_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deactivated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_promotion_assets`
--

DROP TABLE IF EXISTS `mpc_promotion_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_promotion_assets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `promotion_id` int DEFAULT NULL,
  `site_selection` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_type_included` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `campaign` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condition` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `customer_type_id` int DEFAULT NULL,
  `header_limit` int DEFAULT NULL,
  `third_party_promotion_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `discount_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_promotion_closing_rules`
--

DROP TABLE IF EXISTS `mpc_promotion_closing_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_promotion_closing_rules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_promotion_closing_rules_types`
--

DROP TABLE IF EXISTS `mpc_promotion_closing_rules_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_promotion_closing_rules_types` (
  `promotion_type_id` int DEFAULT NULL,
  `promotion_closing_rule_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_promotion_products`
--

DROP TABLE IF EXISTS `mpc_promotion_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_promotion_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int DEFAULT NULL,
  `promotion_id` int DEFAULT NULL,
  `value` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `promotion_action_product` tinyint(1) DEFAULT '0',
  `alert` text COLLATE utf8mb4_general_ci,
  `active` tinyint(1) DEFAULT '0',
  `details` text COLLATE utf8mb4_general_ci,
  `stock_limit` int DEFAULT NULL,
  `total_sold` int DEFAULT '0',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `current_mrp` decimal(15,2) DEFAULT NULL,
  `changed_mrp` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_promotion_products_on_marketplace_product_id` (`marketplace_product_id`),
  KEY `index_mpc_promotion_products_on_promotion_id` (`promotion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8728073 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_promotion_rules`
--

DROP TABLE IF EXISTS `mpc_promotion_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_promotion_rules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_promotion_rules_types`
--

DROP TABLE IF EXISTS `mpc_promotion_rules_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_promotion_rules_types` (
  `promotion_type_id` int DEFAULT NULL,
  `promotion_rule_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_promotion_sub_rules`
--

DROP TABLE IF EXISTS `mpc_promotion_sub_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_promotion_sub_rules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_promotion_sub_rules_types`
--

DROP TABLE IF EXISTS `mpc_promotion_sub_rules_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_promotion_sub_rules_types` (
  `promotion_sub_rule_id` int DEFAULT NULL,
  `promotion_type_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_promotion_tiers`
--

DROP TABLE IF EXISTS `mpc_promotion_tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_promotion_tiers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `min_range` decimal(15,2) DEFAULT '0.00',
  `max_range` decimal(15,2) DEFAULT '0.00',
  `promotion_product_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_promotion_tiers_on_promotion_product_id` (`promotion_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_promotion_types`
--

DROP TABLE IF EXISTS `mpc_promotion_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_promotion_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `promotion_action` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `promotion_group_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_promotions`
--

DROP TABLE IF EXISTS `mpc_promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_promotions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `start_at` datetime NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `promotion_rule_id` int DEFAULT NULL,
  `promotion_type_id` int DEFAULT NULL,
  `promotion_closing_rule_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `state` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `promotion_sub_rule_id` int DEFAULT NULL,
  `report_history_id` int DEFAULT NULL,
  `job_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `promotion_group_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_readonly` tinyint(1) DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `clone_id` int DEFAULT NULL,
  `is_stackable` tinyint(1) DEFAULT '0',
  `combo_type` int DEFAULT NULL,
  `marketplace_promotion_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_promotions_on_seller_marketplace_id` (`seller_marketplace_id`),
  KEY `index_mpc_promotions_on_promotion_rule_id` (`promotion_rule_id`),
  KEY `index_mpc_promotions_on_promotion_type_id` (`promotion_type_id`),
  KEY `index_mpc_promotions_on_promotion_closing_rule_id` (`promotion_closing_rule_id`),
  KEY `index_mpc_promotions_on_report_history_id` (`report_history_id`),
  KEY `index_mpc_promotions_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31570 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_rc_referrals`
--

DROP TABLE IF EXISTS `mpc_rc_referrals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_rc_referrals` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_id` int DEFAULT NULL,
  `referrer_seller_id` int DEFAULT NULL,
  `own_referal_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referrer_aic_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_rc_referrals_on_referrer_aic_code` (`referrer_aic_code`),
  KEY `index_mpc_rc_referrals_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_receipts`
--

DROP TABLE IF EXISTS `mpc_receipts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_receipts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `attachment_file_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `attachment_file_size` int DEFAULT NULL,
  `attachment_content_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `attachment_updated_at` datetime DEFAULT NULL,
  `attachment_alt_text` text COLLATE utf8mb4_general_ci,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_report_attachments`
--

DROP TABLE IF EXISTS `mpc_report_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_report_attachments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `report_file_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `report_content_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `report_file_size` int DEFAULT NULL,
  `report_updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=185131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_report_histories`
--

DROP TABLE IF EXISTS `mpc_report_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_report_histories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `report_id` int NOT NULL,
  `report_attachment_id` int NOT NULL,
  `user_id` int NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `logged_time` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `taxon_id` int DEFAULT NULL,
  `job_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `product_clone_history_id` int DEFAULT NULL,
  `bulk_import_id` int DEFAULT NULL,
  `payload` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_report_histories_on_report_attachment_id` (`report_attachment_id`),
  KEY `index_mpc_report_histories_on_report_id` (`report_id`),
  KEY `index_mpc_report_histories_on_user_id` (`user_id`),
  KEY `index_mpc_report_histories_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=189701 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_reports`
--

DROP TABLE IF EXISTS `mpc_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `date_range_required` int NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `report_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'report',
  `report_model` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `is_master_account` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_roles`
--

DROP TABLE IF EXISTS `mpc_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `presentation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `platform_user` tinyint(1) DEFAULT '0',
  `role_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_roles_users`
--

DROP TABLE IF EXISTS `mpc_roles_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_roles_users` (
  `user_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  KEY `index_mpc_roles_users_on_user_id` (`user_id`),
  KEY `index_mpc_roles_users_on_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_sections`
--

DROP TABLE IF EXISTS `mpc_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_sections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_sections_on_warehouse_id` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10245 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_seller_businesses`
--

DROP TABLE IF EXISTS `mpc_seller_businesses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_seller_businesses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `seller_id` int NOT NULL,
  `image_id` int DEFAULT NULL,
  `address_id` int NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci,
  `company_registration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_seller_businesses_on_seller_id` (`seller_id`),
  KEY `index_mpc_seller_businesses_on_image_id` (`image_id`),
  KEY `index_mpc_seller_businesses_on_address_id` (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17656 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_seller_configurations`
--

DROP TABLE IF EXISTS `mpc_seller_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_seller_configurations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_marketplace_id` int NOT NULL,
  `order_fetch_interval` decimal(10,0) DEFAULT NULL,
  `product_fetch_interval` decimal(10,0) DEFAULT NULL,
  `order_interval_unit` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `product_interval_unit` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `target_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `target_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_seller_configurations_on_seller_marketplace_id` (`seller_marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=413 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_seller_details`
--

DROP TABLE IF EXISTS `mpc_seller_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_seller_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `origin` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `marketplace_id` int DEFAULT NULL,
  `live_skus` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_seller_details_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4135 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_seller_marketplace_field_values`
--

DROP TABLE IF EXISTS `mpc_seller_marketplace_field_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_seller_marketplace_field_values` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_marketplace_id` int NOT NULL,
  `field_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `smfv_seller_marketplace_id` (`seller_marketplace_id`),
  KEY `smfv_smp_id` (`seller_marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24406 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_seller_marketplace_fields`
--

DROP TABLE IF EXISTS `mpc_seller_marketplace_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_seller_marketplace_fields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_marketplace_id` int DEFAULT NULL,
  `field_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_smp_fields_on_smp_id` (`seller_marketplace_id`),
  KEY `index_mpc_smp_fields_on_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=116892 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_seller_marketplace_settings`
--

DROP TABLE IF EXISTS `mpc_seller_marketplace_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_seller_marketplace_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `value` varchar(3000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `seller_marketplace_id` int NOT NULL,
  `marketplace_setting_field_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `mpc_smp_set_smp_id` (`seller_marketplace_id`),
  KEY `mpc_smp_set_mpf_id` (`marketplace_setting_field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_seller_marketplace_taxons`
--

DROP TABLE IF EXISTS `mpc_seller_marketplace_taxons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_seller_marketplace_taxons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_marketplace_id` int NOT NULL,
  `taxon_id` int NOT NULL,
  `taxonomy_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `presentation` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  `lft` int DEFAULT NULL,
  `rgt` int DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `smt_seller_marketplace_id` (`seller_marketplace_id`),
  KEY `index_mpc_seller_marketplace_taxons_on_taxon_id` (`taxon_id`),
  KEY `index_mpc_seller_marketplace_taxons_on_taxonomy_id` (`taxonomy_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5646 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_seller_marketplaces`
--

DROP TABLE IF EXISTS `mpc_seller_marketplaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_seller_marketplaces` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `seller_id` int NOT NULL,
  `marketplace_id` int NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `inventory_sync` datetime DEFAULT NULL,
  `product_sync` datetime DEFAULT NULL,
  `order_sync` datetime DEFAULT NULL,
  `deactivated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ss_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sync_status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cancel_order_sync` datetime DEFAULT NULL,
  `mp_timezone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `currency_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `warehouse_id` int DEFAULT NULL,
  `auth_expiry_date` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `store_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `integration_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_seller_marketplaces_on_name` (`name`),
  KEY `index_mpc_seller_marketplaces_on_seller_id` (`seller_id`),
  KEY `index_mpc_seller_marketplaces_on_marketplace_id` (`marketplace_id`),
  KEY `index_mpc_seller_marketplaces_on_ss_code` (`ss_code`)
) ENGINE=InnoDB AUTO_INCREMENT=48778 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_seller_notifications`
--

DROP TABLE IF EXISTS `mpc_seller_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_seller_notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `notification_id` int NOT NULL,
  `seller_id` int NOT NULL,
  `subscribed` int DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_seller_notifications_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=136649 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_seller_order_details`
--

DROP TABLE IF EXISTS `mpc_seller_order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_seller_order_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_seller_order_details_on_order_id` (`order_id`),
  KEY `index_mpc_seller_order_details_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_seller_status_mappings`
--

DROP TABLE IF EXISTS `mpc_seller_status_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_seller_status_mappings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_marketplace_id` int DEFAULT NULL,
  `selluseller_status` int DEFAULT NULL,
  `marketplace_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_seller_subscriptions`
--

DROP TABLE IF EXISTS `mpc_seller_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_seller_subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_id` int DEFAULT NULL,
  `subscription_id` int DEFAULT NULL,
  `deactivate_from` date DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `permalink` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `subscription_expire` tinyint(1) DEFAULT '0',
  `braintree_subscription_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `custom_plan_detail_id` int DEFAULT NULL,
  `payment_received_date` datetime DEFAULT NULL,
  `applied_promocode_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `mobile_expiry_date` datetime DEFAULT NULL,
  `addon_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_seller_subscriptions_on_seller_id` (`seller_id`),
  KEY `index_mpc_seller_subscriptions_on_subscription_id` (`subscription_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16090 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_seller_types`
--

DROP TABLE IF EXISTS `mpc_seller_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_seller_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `presentation` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_sellers`
--

DROP TABLE IF EXISTS `mpc_sellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_sellers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `business_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `seller_type_id` int NOT NULL,
  `fulfilment_type_id` int NOT NULL,
  `accept_agreement` tinyint(1) DEFAULT '0',
  `platform_user` tinyint(1) DEFAULT '1',
  `fba_fulfilment` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `language_id` int NOT NULL,
  `fulfilment_network_id` int NOT NULL,
  `deactivated_at` datetime DEFAULT NULL,
  `establishment_date` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `auto_deduct_amount` tinyint(1) DEFAULT '1',
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `exclusivity_expires_at` datetime DEFAULT NULL,
  `exclusive_group_id` int DEFAULT NULL,
  `customer_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payment_method_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ftp_detail_id` int DEFAULT NULL,
  `lgs_enabled` tinyint(1) DEFAULT '0',
  `is_stock_enabled` tinyint(1) DEFAULT '1',
  `base_currency` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `old_seller_id` int DEFAULT NULL,
  `last_accessed_at` datetime DEFAULT NULL,
  `test_seller` tinyint(1) DEFAULT '0',
  `account_type_id` int DEFAULT NULL,
  `ws_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shard_id` int DEFAULT NULL,
  `is_multiwarehousing` tinyint(1) DEFAULT '0',
  `ss_new_version` tinyint(1) DEFAULT '0',
  `refresh_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `master_account_id` int DEFAULT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller_tag` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `control_overselling` tinyint(1) DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `service_provider` tinyint(1) DEFAULT '0',
  `multi_brand` tinyint(1) DEFAULT NULL,
  `picking_flow` tinyint(1) DEFAULT '0',
  `auto_invoice_number_generation` tinyint(1) DEFAULT '0',
  `enable_order_sync` tinyint(1) DEFAULT '1',
  `is_inprocess_qty_deduct` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_mpc_sellers_on_name` (`name`),
  KEY `index_mpc_sellers_on_seller_type_id` (`seller_type_id`),
  KEY `index_mpc_sellers_on_fulfilment_type_id` (`fulfilment_type_id`),
  KEY `index_mpc_sellers_on_fulfilment_network_id` (`fulfilment_network_id`),
  KEY `index_mpc_sellers_on_language_id` (`language_id`),
  KEY `index_mpc_sellers_on_exclusive_group_id` (`exclusive_group_id`),
  KEY `mpc_sellers_shard_id` (`shard_id`),
  KEY `index_mpc_sellers_on_master_account_id` (`master_account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17655 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_serial_numbers`
--

DROP TABLE IF EXISTS `mpc_serial_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_serial_numbers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `line_item_id` int DEFAULT NULL,
  `number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `seller_id` int DEFAULT NULL,
  `inventory_sku` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_serial_numbers_on_seller_id` (`seller_id`),
  KEY `index_serial_numbers_on_line_item_id` (`line_item_id`),
  KEY `index_serial_numbers_on_number` (`number`),
  KEY `index_serial_numbers_on_inventory_sku` (`inventory_sku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_setting_field_values`
--

DROP TABLE IF EXISTS `mpc_setting_field_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_setting_field_values` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_setting_field_id` int DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1000) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_setting_field_values_on_marketplace_setting_field_id` (`marketplace_setting_field_id`),
  KEY `index_mpc_setting_field_values_on_seller_marketplace_id` (`seller_marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=469 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_setup_details`
--

DROP TABLE IF EXISTS `mpc_setup_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_setup_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `instruction` text COLLATE utf8mb4_unicode_ci,
  `attachable_id` int DEFAULT NULL,
  `attachable_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_setup_details_on_attachable_type_and_attachable_id` (`attachable_type`,`attachable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_shipment_assigned_lists`
--

DROP TABLE IF EXISTS `mpc_shipment_assigned_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_shipment_assigned_lists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shipment_id` int DEFAULT NULL,
  `assign_user_id` int DEFAULT NULL,
  `assign_by_user_id` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `picked_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_shipment_assigned_lists_on_shipment_id` (`shipment_id`),
  KEY `index_mpc_shipment_assigned_lists_on_assign_user_id` (`assign_user_id`),
  KEY `index_mpc_shipment_assigned_lists_on_assign_by_user_id` (`assign_by_user_id`),
  KEY `index_mpc_shipment_assigned_lists_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3587 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_shipment_delivery_lists`
--

DROP TABLE IF EXISTS `mpc_shipment_delivery_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_shipment_delivery_lists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `delivered_at` datetime DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `shipment_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `cancel_at` datetime DEFAULT NULL,
  `cancel_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cancel_on_fba_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_delivery_list_on_user_id` (`user_id`),
  KEY `index_mpc_delivery_list_on_shipment_id` (`shipment_id`),
  CONSTRAINT `fk_rails_53f9982832` FOREIGN KEY (`user_id`) REFERENCES `mpc_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=71070328 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_shipment_packing_lists`
--

DROP TABLE IF EXISTS `mpc_shipment_packing_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_shipment_packing_lists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `in_packing_at` datetime DEFAULT NULL,
  `print_at` datetime DEFAULT NULL,
  `packed_at` datetime DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `shipment_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `error_message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logistic_action` int DEFAULT NULL,
  `picking_generated_at` datetime DEFAULT NULL,
  `picked_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_packing_list_on_user_id` (`user_id`),
  KEY `index_mpc_packing_list_on_shipment_id` (`shipment_id`),
  CONSTRAINT `fk_rails_f0d34c0b0d` FOREIGN KEY (`user_id`) REFERENCES `mpc_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=16825329 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_shipment_shipping_lists`
--

DROP TABLE IF EXISTS `mpc_shipment_shipping_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_shipment_shipping_lists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rts_at` datetime DEFAULT NULL,
  `shipped_at` datetime DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `shipment_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_shipping_list_on_user_id` (`user_id`),
  KEY `index_mpc_shipping_list_on_shipment_id` (`shipment_id`),
  CONSTRAINT `fk_rails_0106db4d60` FOREIGN KEY (`user_id`) REFERENCES `mpc_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=84159724 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_shipments`
--

DROP TABLE IF EXISTS `mpc_shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_shipments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tracking_number` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cost` decimal(15,2) DEFAULT NULL,
  `shipped_at` datetime DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `state` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fulflmnt_order_state` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `manifest_id` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `invoice_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marketplace_order_state_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_shipments_on_number` (`number`),
  KEY `fk_rails_1e7f20d2ab` (`order_id`),
  KEY `mp_orders_state_index` (`state`),
  KEY `mpc_shipments_marketplace_order_state_id` (`marketplace_order_state_id`),
  KEY `index_mpc_shipments_on_seller_id` (`seller_id`),
  KEY `ix_shipments_manifest_id` (`manifest_id`),
  KEY `ix_shipments_tracking_number` (`tracking_number`)
) ENGINE=InnoDB AUTO_INCREMENT=64474446 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_shipping_methods`
--

DROP TABLE IF EXISTS `mpc_shipping_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_shipping_methods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `display_on` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tracking_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marketplace_id` int NOT NULL,
  `country_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `shipping_type_id` int DEFAULT NULL,
  `fulfilment_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `update_status` tinyint(1) DEFAULT '1',
  `is_self_service` tinyint(1) DEFAULT '0',
  `combined_with_invoice` tinyint(1) DEFAULT '0',
  `marketplace_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `logistics_partner_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logistic_action` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_shipping_methods_on_marketplace_id` (`marketplace_id`),
  KEY `index_mpc_shipping_methods_on_country_id` (`country_id`),
  KEY `index_mpc_shipping_methods_on_shipping_type_id` (`shipping_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6245 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_shipping_methods_bak`
--

DROP TABLE IF EXISTS `mpc_shipping_methods_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_shipping_methods_bak` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `display_on` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tracking_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marketplace_id` int NOT NULL,
  `country_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `shipping_type_id` int DEFAULT NULL,
  `fulfilment_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `update_status` tinyint(1) DEFAULT '1',
  `is_self_service` tinyint(1) DEFAULT '0',
  `combined_with_invoice` tinyint(1) DEFAULT '0',
  `marketplace_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_shipping_methods_on_marketplace_id` (`marketplace_id`),
  KEY `index_mpc_shipping_methods_on_country_id` (`country_id`),
  KEY `index_mpc_shipping_methods_on_shipping_type_id` (`shipping_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=839 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_shipping_rate_cards`
--

DROP TABLE IF EXISTS `mpc_shipping_rate_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_shipping_rate_cards` (
  `id` int NOT NULL AUTO_INCREMENT,
  `weight` float NOT NULL,
  `general_rate` float NOT NULL,
  `sensitive_rate` float DEFAULT NULL,
  `marketplace_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_shipping_rate_card_marketplace_id` (`marketplace_id`),
  CONSTRAINT `fk_rails_794c68159a` FOREIGN KEY (`marketplace_id`) REFERENCES `mpc_marketplaces` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1181 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_shipping_types`
--

DROP TABLE IF EXISTS `mpc_shipping_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_shipping_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `presentation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_signatures`
--

DROP TABLE IF EXISTS `mpc_signatures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_signatures` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `signature` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_smp_field_values`
--

DROP TABLE IF EXISTS `mpc_smp_field_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_smp_field_values` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_marketplace_id` int DEFAULT NULL,
  `field_value_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26319 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_smp_shipping_methods`
--

DROP TABLE IF EXISTS `mpc_smp_shipping_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_smp_shipping_methods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shipping_method_id` int NOT NULL,
  `seller_marketplace_id` int NOT NULL,
  `marketplace_shipping_code` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `default` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `payment_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'all',
  `awb_series_id` int DEFAULT NULL,
  `seller_logistics_partner_id` int DEFAULT NULL,
  `ewms_carrier_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logistic_action` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `document_template_id` int DEFAULT NULL,
  `invoice_template_id` int DEFAULT NULL,
  `tracking_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_smp_shipping_methods_on_shipping_method_id` (`shipping_method_id`),
  KEY `index_mpc_smp_shipping_methods_on_seller_marketplace_id` (`seller_marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64584 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_smp_sync_details`
--

DROP TABLE IF EXISTS `mpc_smp_sync_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_smp_sync_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `last_inventory_sync_at` datetime DEFAULT NULL,
  `inventory_sync_started` datetime DEFAULT NULL,
  `inventory_sync_job_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `last_cancel_orders_sync_at` datetime DEFAULT NULL,
  `manual_order_sync` tinyint(1) DEFAULT NULL,
  `auth_failure_at` datetime DEFAULT NULL,
  `auto_disconection` tinyint(1) DEFAULT NULL,
  `product_sync_job_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_product_sync_at` datetime DEFAULT NULL,
  `product_sync_started` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_smp_sync_details_on_id` (`id`),
  KEY `index_mpc_smp_sync_details_on_seller_marketplace_id` (`seller_marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26164 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_state_changes`
--

DROP TABLE IF EXISTS `mpc_state_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_state_changes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `from_state` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `to_state` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stateful_id` int DEFAULT NULL,
  `stateful_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_state_change_user_id` (`user_id`),
  KEY `state_changes_id_type_x` (`stateful_id`,`stateful_type`),
  KEY `ix_state_changes_name` (`name`),
  KEY `ix_state_changes_created_at` (`created_at`),
  CONSTRAINT `fk_rails_a4594aea97` FOREIGN KEY (`user_id`) REFERENCES `mpc_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1034246627 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_states`
--

DROP TABLE IF EXISTS `mpc_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_states` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `abbr` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `country_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_states_on_country_id` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_stock_histories`
--

DROP TABLE IF EXISTS `mpc_stock_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_stock_histories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `auditable_id` int NOT NULL,
  `auditable_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `new_stock` int DEFAULT NULL,
  `old_stock` int DEFAULT NULL,
  `new_on_hold` int DEFAULT NULL,
  `old_on_hold` int DEFAULT NULL,
  `sync_type` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `associated_id` int DEFAULT NULL,
  `associated_type` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_mpc_stock_histories_associated_id_type` (`associated_id`,`associated_type`),
  KEY `ix_mpc_stock_histories_auditable_id_type` (`auditable_id`,`auditable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=777115071 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_stock_locations`
--

DROP TABLE IF EXISTS `mpc_stock_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_stock_locations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity` int DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `version` int DEFAULT '1',
  `location_id` int DEFAULT NULL,
  `inventory_product_id` int DEFAULT NULL,
  `warehouse_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `is_usable` tinyint(1) DEFAULT '1',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_stock_locations_on_location_id` (`location_id`),
  KEY `index_mpc_stock_locations_on_inventory_product_id` (`inventory_product_id`),
  KEY `index_mpc_stock_locations_on_warehouse_id` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=701641 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_stock_update_details`
--

DROP TABLE IF EXISTS `mpc_stock_update_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_stock_update_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stock_in_selluseller` int NOT NULL,
  `before_update_stock_in_ss` int NOT NULL,
  `stock_on_marketplace` int DEFAULT NULL,
  `updated_quantity_on_mp` int DEFAULT NULL,
  `open_update_request` tinyint(1) NOT NULL,
  `marketplace_product_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `marketplace_id` int DEFAULT NULL,
  `attempts` int DEFAULT '0',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_stock_update_details_on_marketplace_product_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=212717 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_stock_update_flags`
--

DROP TABLE IF EXISTS `mpc_stock_update_flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_stock_update_flags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `inventory_product_id` int DEFAULT NULL,
  `is_stock_updated` tinyint(1) DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `is_request_sent` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mpc_stock_update_flags_iid_x` (`inventory_product_id`),
  KEY `ix_stock_update_flags_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23330602 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_subscriptions`
--

DROP TABLE IF EXISTS `mpc_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` decimal(15,2) DEFAULT '0.00',
  `no_of_orders` int DEFAULT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `permalink` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subscription_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Normal',
  `valid_for` int DEFAULT NULL,
  `related_id` int DEFAULT NULL,
  `braintree_subscription_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `plan_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `plan_type` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payment_frequency` int DEFAULT NULL,
  `usual_price` decimal(15,2) DEFAULT '0.00',
  `account_type_id` int DEFAULT NULL,
  `buyable` tinyint(1) DEFAULT '1',
  `threshold` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `gst_in_percent` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_support_bulk_imports`
--

DROP TABLE IF EXISTS `mpc_support_bulk_imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_support_bulk_imports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attachment_file_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `attachment_content_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `attachment_file_size` int DEFAULT NULL,
  `attachment_updated_at` datetime DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `action_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_support_bulk_imports_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10154 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_tasks`
--

DROP TABLE IF EXISTS `mpc_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_tasks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL,
  `task_uid` int DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `complete_count` int DEFAULT NULL,
  `fail_count` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_tasks_on_id` (`id`),
  KEY `fk_rails_bcf313a064` (`seller_id`),
  CONSTRAINT `fk_rails_bcf313a064` FOREIGN KEY (`seller_id`) REFERENCES `mpc_sellers` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_taxon_assets`
--

DROP TABLE IF EXISTS `mpc_taxon_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_taxon_assets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_id` int DEFAULT NULL,
  `taxon_id` int DEFAULT NULL,
  `attachment_file_size` int DEFAULT NULL,
  `attachment_content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment_file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment_updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_taxonomies`
--

DROP TABLE IF EXISTS `mpc_taxonomies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_taxonomies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `presentation` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `metakeywords` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `marketplace_id` int DEFAULT NULL,
  `marketplace_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_taxonomies_on_marketplace_id` (`marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12858 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_taxons`
--

DROP TABLE IF EXISTS `mpc_taxons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_taxons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `presentation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `position` int DEFAULT '0',
  `taxonomy_id` int DEFAULT NULL,
  `lft` int DEFAULT NULL,
  `rgt` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permalink` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `base_category_id` int DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `variation` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_mpc_taxons_on_taxonomy_id` (`taxonomy_id`),
  KEY `fk_rails_361f2b7b8b` (`lft`),
  KEY `fk_rails_17d825e161` (`rgt`),
  KEY `mpc_p_code_taxonomy_id_x` (`code`),
  KEY `mpc_taxons_tny_id_cat_id` (`taxonomy_id`,`base_category_id`),
  KEY `ix_taxons_parent` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=575285 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_taxons_131220`
--

DROP TABLE IF EXISTS `mpc_taxons_131220`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_taxons_131220` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `presentation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `position` int DEFAULT '0',
  `taxonomy_id` int DEFAULT NULL,
  `lft` int DEFAULT NULL,
  `rgt` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permalink` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `base_category_id` int DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `variation` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_mpc_taxons_on_taxonomy_id` (`taxonomy_id`),
  KEY `fk_rails_361f2b7b8b` (`lft`),
  KEY `fk_rails_17d825e161` (`rgt`),
  KEY `mpc_p_code_taxonomy_id_x` (`code`),
  KEY `mpc_taxons_tny_id_cat_id` (`taxonomy_id`,`base_category_id`),
  KEY `ix_taxons_parent` (`parent_id`),
  CONSTRAINT `fk_rails_b3d37e97ac` FOREIGN KEY (`taxonomy_id`) REFERENCES `mpc_taxonomies` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=574802 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_track_changes`
--

DROP TABLE IF EXISTS `mpc_track_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_track_changes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_marketplace_id` int DEFAULT NULL,
  `marketplace_product_id` int DEFAULT NULL,
  `name` tinyint(1) DEFAULT NULL,
  `description` tinyint(1) DEFAULT NULL,
  `image1` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `height` tinyint(1) DEFAULT NULL,
  `length` tinyint(1) DEFAULT NULL,
  `width` tinyint(1) DEFAULT NULL,
  `weight` tinyint(1) DEFAULT NULL,
  `field_names` text COLLATE utf8mb4_unicode_ci,
  `image2` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `image3` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `image4` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `image5` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `image6` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `image7` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `image8` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_mpc_track_on_seller_marketplace_id` (`seller_marketplace_id`),
  KEY `index_mpc_track_on_marketplace_product_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=379806 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_transaction_details`
--

DROP TABLE IF EXISTS `mpc_transaction_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_transaction_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `line_item_id` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `order_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT '0.00',
  `paid_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wht_included_in_amount` tinyint(1) DEFAULT NULL,
  `payment_ref_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marketplace_sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_item_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_item_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fee_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_speed` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wht_amount` decimal(15,2) DEFAULT '0.00',
  `transaction_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `statement` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `vat_in_amount` decimal(15,2) DEFAULT '0.00',
  `shipment_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_at` date DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_transaction_details_on_transaction_number` (`transaction_number`),
  KEY `index_mpc_transaction_details_on_order_id` (`order_id`),
  KEY `index_mpc_transaction_details_on_line_item_id` (`line_item_id`),
  KEY `index_mpc_transaction_details_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1506004 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_user_email_events`
--

DROP TABLE IF EXISTS `mpc_user_email_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_user_email_events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `email_event_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_users`
--

DROP TABLE IF EXISTS `mpc_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `api_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `seller_id` int DEFAULT NULL,
  `firstname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `platform_user` tinyint(1) DEFAULT '0',
  `active` tinyint(1) DEFAULT '1',
  `language_id` int NOT NULL,
  `country_id` int DEFAULT NULL,
  `email_confirmed` tinyint(1) DEFAULT '0',
  `confirm_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shard_id` int DEFAULT NULL,
  `client_auth_validity_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `master_account_id` int DEFAULT NULL,
  `is_system_automation_user` tinyint(1) DEFAULT '0',
  `phone_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `otp_secret_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `mask_info` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_users_on_email` (`email`),
  KEY `index_mpc_users_on_reset_password_token` (`reset_password_token`),
  KEY `mpc_users_shard_id` (`shard_id`),
  KEY `index_mpc_users_on_master_account_id` (`master_account_id`),
  KEY `ix_users_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18143 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_warehouse_products`
--

DROP TABLE IF EXISTS `mpc_warehouse_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_warehouse_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `buffer_stock` int DEFAULT NULL,
  `on_hold_stock` int DEFAULT NULL,
  `sold_stock` int DEFAULT NULL,
  `virtual_oos` int DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `version` int DEFAULT '1',
  `warehouse_id` int DEFAULT NULL,
  `inventory_product_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `created_on_fba` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_warehouse_products_on_warehouse_id` (`warehouse_id`),
  KEY `index_mpc_warehouse_products_on_inventory_product_id` (`inventory_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1388543 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_warehouse_stock_update_flags`
--

DROP TABLE IF EXISTS `mpc_warehouse_stock_update_flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_warehouse_stock_update_flags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `warehouse_product_id` int DEFAULT NULL,
  `is_stock_updated` tinyint(1) DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `is_request_sent` tinyint(1) DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_warehouse_stock_update_flags_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=698519 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_warehouses`
--

DROP TABLE IF EXISTS `mpc_warehouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_warehouses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `address_id` int DEFAULT NULL,
  `fulfilment_network_id` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_warehouses_on_seller_id` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_field_zalora_rows`
--

DROP TABLE IF EXISTS `ss_marketplace_product_field_zalora_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_field_zalora_rows` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int DEFAULT NULL,
  `field_id` int DEFAULT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT NULL,
  `version` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ss_field_mp_product_id_x` (`marketplace_product_id`),
  KEY `ss_field_field_id_x` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_amazon`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_amazon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_amazon` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_amazon_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_amazon_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3346427285 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_amazon_au`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_amazon_au`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_amazon_au` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_sg_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_amazon_ca`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_amazon_ca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_amazon_ca` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_sg_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_amazon_de`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_amazon_de`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_amazon_de` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_sg_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_amazon_es`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_amazon_es`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_amazon_es` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_sg_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_amazon_fr`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_amazon_fr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_amazon_fr` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_sg_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4772 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_amazon_gb`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_amazon_gb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_amazon_gb` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_sg_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_amazon_in`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_amazon_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_amazon_in` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_sg_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7499641 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_amazon_it`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_amazon_it`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_amazon_it` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_sg_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_amazon_jp`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_amazon_jp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_amazon_jp` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_id_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=445 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_amazon_us`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_amazon_us`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_amazon_us` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_sg_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_blibli`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_blibli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_blibli` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_blibli_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_blibli_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_blibli_id`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_blibli_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_blibli_id` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_blibli_id_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_blibli_id_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3337774381 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_bukalapak_id`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_bukalapak_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_bukalapak_id` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int DEFAULT NULL,
  `field_id` int DEFAULT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `version` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=443998 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_demandware`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_demandware`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_demandware` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int DEFAULT NULL,
  `field_id` int DEFAULT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `version` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53493 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_demandwares`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_demandwares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_demandwares` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int DEFAULT NULL,
  `field_id` int DEFAULT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `version` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_ebay`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_ebay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_ebay` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_ebay_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_ebay_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_ebay_au`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_ebay_au`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_ebay_au` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_amazon_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_amazon_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1112363 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_ebay_ca`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_ebay_ca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_ebay_ca` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_amazon_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_amazon_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5501 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_ebay_de`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_ebay_de`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_ebay_de` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_amazon_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_amazon_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_ebay_es`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_ebay_es`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_ebay_es` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_amazon_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_amazon_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_ebay_fr`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_ebay_fr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_ebay_fr` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_amazon_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_amazon_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_ebay_gb`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_ebay_gb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_ebay_gb` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_amazon_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_amazon_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1621496 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_ebay_it`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_ebay_it`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_ebay_it` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_amazon_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_amazon_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_ebay_my`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_ebay_my`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_ebay_my` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_ebay_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_ebay_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2106514 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_ebay_ph`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_ebay_ph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_ebay_ph` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_ph_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=148018 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_ebay_sg`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_ebay_sg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_ebay_sg` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_id_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=222933 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_ebay_us`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_ebay_us`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_ebay_us` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_amazon_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_amazon_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=356135 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_flipkart`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_flipkart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_flipkart` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_flipkart_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_flipkart_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3290706768 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_gmas`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_gmas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_gmas` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_gmas_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_gmas_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3337289522 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_hotdeal_vt`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_hotdeal_vt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_hotdeal_vt` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_hotdeal_vt_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_hotdeal_vt_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_iconic_au`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_iconic_au`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_iconic_au` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_iconic_au_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_iconic_au_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3355381411 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_jabong`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_jabong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_jabong` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_jabong_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_jabong_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_jd_id`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_jd_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_jd_id` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_jd_id_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_jd_id_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3340683628 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_jdth`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_jdth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_jdth` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_jdth_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_jdth_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3338654156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_jumia`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_jumia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_jumia` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_jumia_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_jumia_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3337564377 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_jumia_ke`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_jumia_ke`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_jumia_ke` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_sg_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14187 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_jumia_ma`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_jumia_ma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_jumia_ma` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_my_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36215 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_lazada_id`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_lazada_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_lazada_id` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_id_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3466503383 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_lazada_my`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_lazada_my`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_lazada_my` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_my_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3431354367 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_lazada_ph`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_lazada_ph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_lazada_ph` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_ph_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3654958060 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_lazada_sg`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_lazada_sg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_lazada_sg` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_sg_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3382246451 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_lazada_th`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_lazada_th`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_lazada_th` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_th_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3360402141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_lazada_vn`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_lazada_vn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_lazada_vn` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_vn_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3353263727 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_lazada_zalora_row`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_lazada_zalora_row`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_lazada_zalora_row` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_my_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_lelong_my`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_lelong_my`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_lelong_my` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lelong_my_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_lelong_my_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3355032272 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_linio_ar`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_linio_ar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_linio_ar` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_zalora_vn_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_zalora_vn_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_linio_cl`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_linio_cl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_linio_cl` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_zalora_vn_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_zalora_vn_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=600 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_linio_co`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_linio_co`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_linio_co` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_zalora_vn_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_zalora_vn_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=845 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_linio_mx`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_linio_mx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_linio_mx` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_zalora_vn_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_zalora_vn_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_linio_pe`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_linio_pe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_linio_pe` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_id_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_looksi`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_looksi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_looksi` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_looksi_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_looksi_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3353979883 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3393811037 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento1`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento1` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento1_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento1_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3343591061 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento1_au`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento1_au`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento1_au` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento1_au_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento1_au_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=880090979 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento1_hk`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento1_hk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento1_hk` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento1_hk_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento1_hk_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento1_id`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento1_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento1_id` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento1_id_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento1_id_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2615090568 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento1_in`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento1_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento1_in` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento1_in_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento1_in_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento1_jp`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento1_jp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento1_jp` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento1_jp_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento1_jp_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento1_my`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento1_my`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento1_my` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento1_my_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento1_my_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3290146979 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento1_ph`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento1_ph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento1_ph` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento1_ph_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento1_ph_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3099220497 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento1_th`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento1_th`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento1_th` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento1_th_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento1_th_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento1_vn`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento1_vn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento1_vn` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento1_vn_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento1_vn_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento_au`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento_au`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento_au` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento_au_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento_au_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento_hk`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento_hk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento_hk` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento_hk_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento_hk_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento_id`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento_id` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento_id_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento_id_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento_in`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento_in` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento_in_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento_in_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento_jp`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento_jp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento_jp` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento_jp_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento_jp_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento_multistore`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento_multistore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento_multistore` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int DEFAULT NULL,
  `field_id` int DEFAULT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `version` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10665 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento_my`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento_my`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento_my` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento_my_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento_my_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3290165519 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento_ph`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento_ph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento_ph` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento_ph_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento_ph_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3290002328 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento_th`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento_th`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento_th` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento_th_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento_th_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1857914540 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_magento_vn`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_magento_vn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_magento_vn` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_magento_vn_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_magento_vn_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_martjack`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_martjack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_martjack` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_my_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_matahari_id`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_matahari_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_matahari_id` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_matahari_id_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_matahari_id_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2905672728 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_matahari_mall`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_matahari_mall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_matahari_mall` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_matahari_mall_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_matahari_mall_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_mei_cn`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_mei_cn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_mei_cn` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_mei_cn_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_mei_cn_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=817141574 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_metrodeal_th`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_metrodeal_th`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_metrodeal_th` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_metrodeal_th_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_metrodeal_th_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_mydin`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_mydin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_mydin` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_my_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5538093 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_mystore`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_mystore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_mystore` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_mystore_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_mystore_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2593 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_mystore_hk`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_mystore_hk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_mystore_hk` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_amazon_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_amazon_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_opencart`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_opencart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_opencart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int DEFAULT NULL,
  `field_id` int DEFAULT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `version` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10456 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_opencarts`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_opencarts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_opencarts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int DEFAULT NULL,
  `field_id` int DEFAULT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `version` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_pgmall_my`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_pgmall_my`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_pgmall_my` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_pgmall_my_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_pgmall_my_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3291581784 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_prestashop`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_prestashop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_prestashop` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_amazon_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_amazon_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=953827 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_prestashop_my`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_prestashop_my`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_prestashop_my` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_prestashop_my_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_prestashop_my_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3337182978 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_prestashop_ph`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_prestashop_ph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_prestashop_ph` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_prestashop_ph_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_prestashop_ph_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2725115819 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_prestashop_sg`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_prestashop_sg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_prestashop_sg` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_prestashop_sg_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_prestashop_sg_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3043720904 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_qoo10_hk`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_qoo10_hk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_qoo10_hk` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_sg_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_qoo10_id`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_qoo10_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_qoo10_id` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_qoo10_id_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_qoo10_id_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3337668896 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_qoo10_jp`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_qoo10_jp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_qoo10_jp` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_qoo10_jp_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_qoo10_jp_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=169504875 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_qoo10_my`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_qoo10_my`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_qoo10_my` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_qoo10_my_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_qoo10_my_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3355432686 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_qoo10_sg`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_qoo10_sg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_qoo10_sg` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_qoo10_sg_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_qoo10_sg_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3377944962 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopclues`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopclues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopclues` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopclues_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopclues_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2249173237 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopee_id`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopee_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopee_id` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopee_id_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopee_id_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3370688825 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopee_my`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopee_my`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopee_my` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopee_my_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopee_my_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3376505984 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopee_ph`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopee_ph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopee_ph` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopee_ph_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopee_ph_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3546390129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopee_sg`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopee_sg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopee_sg` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopee_sg_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopee_sg_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3359671119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopee_th`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopee_th`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopee_th` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopee_th_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopee_th_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3322095342 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopee_tw`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopee_tw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopee_tw` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopee_tw_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopee_tw_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3080567119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopee_vn`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopee_vn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopee_vn` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopee_vn_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopee_vn_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3352686368 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopify`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopify` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_amazon_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_amazon_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47053254 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopify_au`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopify_au`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopify_au` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopify_au_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopify_au_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2697794553 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopify_hk`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopify_hk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopify_hk` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopify_hk_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopify_hk_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2726933485 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopify_id`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopify_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopify_id` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopify_id_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopify_id_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2577648137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopify_ind`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopify_ind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopify_ind` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopify_ind_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopify_ind_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3021253232 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopify_my`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopify_my`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopify_my` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopify_my_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopify_my_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3352692661 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopify_ph`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopify_ph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopify_ph` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopify_ph_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopify_ph_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3356945090 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopify_rest_of_world`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopify_rest_of_world`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopify_rest_of_world` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopify_rest_of_world_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopify_rest_of_world_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3352408484 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopify_sg`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopify_sg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopify_sg` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopify_sg_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopify_sg_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3356319992 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopify_th`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopify_th`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopify_th` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopify_th_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopify_th_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_shopify_vn`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_shopify_vn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_shopify_vn` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_shopify_vn_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_shopify_vn_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=149702 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_smretailshop_ph`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_smretailshop_ph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_smretailshop_ph` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_ph_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1745 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_smvm`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_smvm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_smvm` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int DEFAULT NULL,
  `field_id` int DEFAULT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `version` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1046686 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_snapdeal`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_snapdeal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_snapdeal` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_snapdeal_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_snapdeal_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2179275318 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_street11`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_street11`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_street11` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_street11_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_street11_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3355608405 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_tiki_vn`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_tiki_vn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_tiki_vn` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_blibli_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_blibli_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_tmall_via_mei_cn`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_tmall_via_mei_cn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_tmall_via_mei_cn` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_tmall_via_mei_cn_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_tmall_via_mei_cn_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=881284385 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_tokopedia_id`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_tokopedia_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_tokopedia_id` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_tokopedia_id_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_tokopedia_id_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1138859 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_wocommerce`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_wocommerce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_wocommerce` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_wocommerce_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_wocommerce_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_woocommerce`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_woocommerce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_woocommerce` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int DEFAULT NULL,
  `field_id` int DEFAULT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `version` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ss_field_mp_product_id_x` (`marketplace_product_id`),
  KEY `ss_field_field_id_x` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11020666 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_woocommerce_au`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_woocommerce_au`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_woocommerce_au` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_woocommerce_au_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_woocommerce_au_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=426 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_woocommerce_hk`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_woocommerce_hk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_woocommerce_hk` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_woocommerce_hk_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_woocommerce_hk_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_woocommerce_id`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_woocommerce_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_woocommerce_id` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_woocommerce_id_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_woocommerce_id_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3337181493 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_woocommerce_ind`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_woocommerce_ind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_woocommerce_ind` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_woocommerce_ind_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_woocommerce_ind_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3077799512 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_woocommerce_my`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_woocommerce_my`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_woocommerce_my` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_woocommerce_my_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_woocommerce_my_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3353912975 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_woocommerce_ph`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_woocommerce_ph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_woocommerce_ph` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_woocommerce_ph_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_woocommerce_ph_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3352441018 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_woocommerce_rest_of_world`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_woocommerce_rest_of_world`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_woocommerce_rest_of_world` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_woocom_rofw_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_woocomm_rfw_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3070054278 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_woocommerce_sg`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_woocommerce_sg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_woocommerce_sg` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_woocommerce_sg_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_woocommerce_sg_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3355349622 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_woocommerce_th`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_woocommerce_th`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_woocommerce_th` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_woocommerce_th_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_woocommerce_th_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=835 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_woocommerce_vn`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_woocommerce_vn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_woocommerce_vn` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_woocommerce_vn_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_woocommerce_vn_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_youbeli_my`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_youbeli_my`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_youbeli_my` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_my_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=162354 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zalora_hk`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zalora_hk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zalora_hk` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_zalora_hk_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_zalora_hk_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3356166309 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zalora_id`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zalora_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zalora_id` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_zalora_id_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_zalora_id_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3354638325 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zalora_my`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zalora_my`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zalora_my` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_zalora_my_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_zalora_my_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3357834892 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zalora_ph`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zalora_ph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zalora_ph` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_zalora_ph_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_zalora_ph_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3368403984 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zalora_row`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zalora_row`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zalora_row` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_lazada_id_mp_prod_id` (`marketplace_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=830417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zalora_sg`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zalora_sg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zalora_sg` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_zalora_sg_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_zalora_sg_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3356440941 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zalora_tw`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zalora_tw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zalora_tw` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_zalora_tw_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_zalora_tw_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3355304394 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zalora_vn`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zalora_vn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zalora_vn` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_zalora_vn_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_zalora_vn_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3339007434 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zilingo_cn`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zilingo_cn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zilingo_cn` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_blibli_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_blibli_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9681 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zilingo_id`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zilingo_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zilingo_id` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_blibli_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_blibli_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=261246 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zilingo_jp`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zilingo_jp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zilingo_jp` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_blibli_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_blibli_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4917 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zilingo_kr`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zilingo_kr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zilingo_kr` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_blibli_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_blibli_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2630 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zilingo_my`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zilingo_my`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zilingo_my` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_blibli_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_blibli_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11719 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zilingo_ph`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zilingo_ph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zilingo_ph` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_blibli_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_blibli_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=679796 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zilingo_rest_of_world`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zilingo_rest_of_world`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zilingo_rest_of_world` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_blibli_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_blibli_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zilingo_sg`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zilingo_sg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zilingo_sg` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_blibli_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_blibli_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=88330 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zilingo_th`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zilingo_th`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zilingo_th` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_blibli_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_blibli_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61520 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ss_marketplace_product_fields_zilingo_us`
--

DROP TABLE IF EXISTS `ss_marketplace_product_fields_zilingo_us`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ss_marketplace_product_fields_zilingo_us` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `marketplace_product_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_product_fields_blibli_mp_prod_id` (`marketplace_product_id`),
  KEY `idx_marketplace_product_fields_blibli_field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `versions`
--

DROP TABLE IF EXISTS `versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `versions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `versioned_id` int DEFAULT NULL,
  `versioned_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `user_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `modifications` text COLLATE utf8mb4_general_ci,
  `number` int DEFAULT NULL,
  `reverted_from` int DEFAULT NULL,
  `tag` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_versions_on_number` (`number`) USING BTREE,
  KEY `index_versions_on_created_at` (`created_at`) USING BTREE,
  KEY `version_id_x` (`versioned_id`),
  KEY `index_versions_on_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=535467295 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'dbSelluSeller'
--

--
-- Dumping routines for database 'dbSelluSeller'
--
/*!50003 DROP PROCEDURE IF EXISTS `deleteCatalogueFields` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `deleteCatalogueFields`(IN storeId INT)
BEGIN
    DECLARE tableName VARCHAR(256);
    DECLARE finished INT DEFAULT FALSE;
    DECLARE curTablesList CURSOR FOR 
        SELECT table_name
        FROM information_schema.TABLES
        WHERE table_schema = 'dbSelluSeller'
            AND upper(table_name) LIKE 'SS_%';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = TRUE;

    OPEN curTablesList;

    iterate_tables: LOOP
        FETCH curTablesList INTO tableName;

        IF finished THEN
            LEAVE iterate_tables;
        END IF;

        SELECT tableName;
    END LOOP;
    
    CLOSE curTablesList;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteInactiveSellers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `deleteInactiveSellers`()
BEGIN
    DECLARE sellerId INT DEFAULT 0;
    DECLARE finished INT DEFAULT FALSE;
    DECLARE curInactiveSellers CURSOR FOR SELECT seller_id FROM inactive_sellers;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = TRUE;

    OPEN curInactiveSellers;

    iterate_sellers: LOOP
        FETCH curInactiveSellers INTO sellerId;

        IF finished THEN
            LEAVE iterate_sellers;
        END IF;

        SELECT sellerId;
    END LOOP;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `split_marketplace_products` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `split_marketplace_products`()
BEGIN
  declare max_id, current_id int(16) unsigned default 0;
  declare first_id, last_id  int(16) unsigned default 0;
  declare rows_inserted int(16) unsigned default 0;

  SELECT max(id) INTO max_id
  FROM mpc_marketplace_products_BAK;

  SELECT concat('max_id: ', max_id) MAX_ID;

  SET current_id = 0;

  WHILE (current_id <= max_id) DO
    SET first_id = current_id;
    SET last_id = current_id + 200000;

    
    INSERT INTO mpc_marketplace_products
    (
      id, marketplace_id, product_id, seller_marketplace_id, marketplace_code, currency, is_listed,
      taxon_id, brand_id, name, state, parent_id, is_created, is_sku_available, active,
      mp_connected, is_cloned, image_updated, product_clone_history_id, delivery_sla, created_at, updated_at
    )
    SELECT id, marketplace_id, product_id, seller_marketplace_id, marketplace_code, currency, is_listed,
      taxon_id, brand_id, name, state, parent_id, is_created, is_sku_available, 1 as active,
      mp_connected, is_cloned, image_updated, product_clone_history_id, 0, created_at, updated_at
    FROM mpc_marketplace_products_BAK
    WHERE id > first_id AND id <= last_id;

    
    INSERT INTO mpc_marketplace_product_extras
    (
      marketplace_product_id, description, created_at, updated_at
    )
    SELECT id, description, created_at, updated_at
    FROM mpc_marketplace_products_BAK
    WHERE id > first_id AND id <= last_id;

    
    INSERT INTO mpc_marketplace_product_stocks
    (
      marketplace_product_id, allocated_stock, prebooking_stock, sync_stock,
      allocated_stock_on_mp, created_at, updated_at
    )
    SELECT id, allocated_stock, prebooking_stock, sync_stock,
      allocated_stock, created_at, updated_at
    FROM mpc_marketplace_products_BAK
    WHERE id > first_id AND id <= last_id;

    
    INSERT INTO mpc_marketplace_product_sales
    (
      marketplace_product_id, price, selling_price,
      sale_start_date, sale_end_date, created_at, updated_at
    )
    SELECT id, price, selling_price, sale_start_date, sale_end_date, created_at, updated_at
    FROM mpc_marketplace_products_BAK
    WHERE id > first_id AND id <= last_id;

    SET current_id = current_id + 200000;
    SET rows_inserted = rows_inserted + ROW_COUNT();

    COMMIT;

    SELECT concat('first_id: ', first_id, ' | last_id: ', last_id, ' | rows_inserted: ', rows_inserted);

    SELECT sleep(1);

    SET current_id = current_id + 200000;
  END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `split_marketplace_products2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `split_marketplace_products2`()
BEGIN
  declare max_id, current_id int(16) unsigned default 0;
  declare first_id, last_id  int(16) unsigned default 0;
  declare rows_inserted int(16) unsigned default 0;

  SELECT max(id) INTO max_id
  FROM mpc_marketplace_products_BAK;

  SELECT concat('max_id: ', max_id) MAX_ID;

  SET current_id = 600000;
  SET max_id = 71000000;
  WHILE (current_id < max_id) DO
    SET first_id = current_id;
    SET last_id = current_id + 200000;

    
    INSERT INTO mpc_marketplace_products
    (
      id, marketplace_id, product_id, seller_marketplace_id, marketplace_code, currency, is_listed,
      taxon_id, brand_id, name, state, parent_id, is_created, is_sku_available, active,
      mp_connected, is_cloned, image_updated, product_clone_history_id, delivery_sla, created_at, updated_at
    )
    SELECT id, marketplace_id, product_id, seller_marketplace_id, marketplace_code, currency, is_listed,
      taxon_id, brand_id, name, state, parent_id, is_created, is_sku_available, 1 as active,
      mp_connected, is_cloned, image_updated, product_clone_history_id, 0, created_at, updated_at
    FROM mpc_marketplace_products_BAK
    WHERE id > first_id AND id <= last_id;

    SET current_id = current_id + 200000;
    SET rows_inserted = rows_inserted + ROW_COUNT();

    COMMIT;

    SELECT concat('first_id: ', first_id, ' | last_id: ', last_id, ' | rows_inserted: ', rows_inserted);

    SELECT sleep(1);

    SET current_id = current_id + 200000;
  END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `split_marketplace_products3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `split_marketplace_products3`()
BEGIN
  declare max_id, current_id int(16) unsigned default 0;
  declare first_id, last_id  int(16) unsigned default 0;
  declare rows_inserted int(16) unsigned default 0;

  SET current_id = 600000;
  SET max_id = 71000000;

  WHILE (current_id <= max_id) DO
    SET first_id = current_id;
    SET last_id = current_id + 200000;

    
    INSERT INTO mpc_marketplace_product_extras
    (
      marketplace_product_id, description, created_at, updated_at
    )
    SELECT id, description, created_at, updated_at
    FROM mpc_marketplace_products_BAK
    WHERE id > first_id AND id <= last_id;
  
    SET current_id = current_id + 200000;
    SET rows_inserted = rows_inserted + ROW_COUNT();

    COMMIT;

    SELECT concat('first_id: ', first_id, ' | last_id: ', last_id, ' | rows_inserted: ', rows_inserted);

    SELECT sleep(1);

    SET current_id = current_id + 200000;
  END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `split_marketplace_products4` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `split_marketplace_products4`()
BEGIN
  declare max_id, current_id int(16) unsigned default 0;
  declare first_id, last_id  int(16) unsigned default 0;
  declare rows_inserted int(16) unsigned default 0;

  SET current_id = 40800000;
  SET max_id = 71000000;

  WHILE (current_id <= max_id) DO
    SET first_id = current_id;
    SET last_id = current_id + 200000;

    
    INSERT INTO mpc_marketplace_product_stocks
    (
      marketplace_product_id, allocated_stock, prebooking_stock, sync_stock,
      allocated_stock_on_mp, created_at, updated_at
    )
    SELECT id, allocated_stock, prebooking_stock, sync_stock,
      allocated_stock, created_at, updated_at
    FROM mpc_marketplace_products_BAK
    WHERE id > first_id AND id <= last_id;

    SET current_id = current_id + 200000;
    SET rows_inserted = rows_inserted + ROW_COUNT();

    COMMIT;

    SELECT concat('first_id: ', first_id, ' | last_id: ', last_id, ' | rows_inserted: ', rows_inserted);

    SELECT sleep(1);

    SET current_id = current_id + 200000;
  END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `split_marketplace_products5` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `split_marketplace_products5`()
BEGIN
  declare max_id, current_id int(16) unsigned default 0;
  declare first_id, last_id  int(16) unsigned default 0;
  declare rows_inserted int(16) unsigned default 0;

  SET current_id = 600000;
  SET max_id = 71000000;

  WHILE (current_id <= max_id) DO
    SET first_id = current_id;
    SET last_id = current_id + 200000;

    
    INSERT INTO mpc_marketplace_product_sales
    (
      marketplace_product_id, price, selling_price,
      sale_start_date, sale_end_date, created_at, updated_at
    )
    SELECT id, price, selling_price, sale_start_date, sale_end_date, created_at, updated_at
    FROM mpc_marketplace_products_BAK
    WHERE id > first_id AND id <= last_id;

    SET current_id = current_id + 200000;
    SET rows_inserted = rows_inserted + ROW_COUNT();

    COMMIT;

    SELECT concat('first_id: ', first_id, ' | last_id: ', last_id, ' | rows_inserted: ', rows_inserted);

    SELECT sleep(1);

    SET current_id = current_id + 200000;
  END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateAddesses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `updateAddesses`()
BEGIN
  DECLARE startId INT DEFAULT 0;
  DECLARE stopId INT DEFAULT 0;
  DECLARE lastId INT DEFAULT 0;

  SELECT MAX(id) INTO lastId
  FROM mpc_addresses;

  SET startId = 1;

  copy_addess: LOOP
    SET stopId = startId + 9999;

    INSERT INTO mpc_addresses_08NOV20
      SELECT `id`, `firstname`, `lastname`, `address1`, `address2`, NULL `address3`, NULL `locality`,
        `city`, `zipcode`, `phone`,`state_name`,`alternative_phone`,`company`,`state_id`,
        `country_id`,`created_at`,`updated_at`,`ts_ver`
      FROM mpc_addresses
      WHERE id >= startId AND id <= stopId;

    SET startId = stopId+1;

    IF startId >= lastId THEN
      LEAVE copy_addess;
    ELSE
      ITERATE copy_addess;
    END IF;
  END LOOP;

  SELECT 'completed!!!';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-26  5:37:30
