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
) ENGINE=InnoDB AUTO_INCREMENT=206152524 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=376264 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=554344 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=47904034 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=599635 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=4650458 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=248001 DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=54078349 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=92664450 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_line_items_01_08_bak`
--

DROP TABLE IF EXISTS `mpc_line_items_01_08_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_line_items_01_08_bak` (
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
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_price` decimal(15,2) DEFAULT NULL,
  `retail_price` decimal(15,2) DEFAULT '0.00',
  `invoice_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_in_seller_currency` decimal(15,2) DEFAULT '0.00',
  `retail_price_in_seller_currency` decimal(15,2) DEFAULT '0.00',
  `tax_amount` decimal(15,2) DEFAULT '0.00',
  `paid_price_in_seller_currency` decimal(15,2) DEFAULT '0.00',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_line_items_on_order_id` (`order_id`),
  KEY `index_mpc_line_items_on_product_id` (`product_id`),
  KEY `index_mpc_line_items_on_shipment_id` (`shipment_id`),
  KEY `index_mpc_line_items_on_smp_shipping_method_id` (`smp_shipping_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_line_items_3_06_18_tmp`
--

DROP TABLE IF EXISTS `mpc_line_items_3_06_18_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_line_items_3_06_18_tmp` (
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
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_line_items_on_order_id` (`order_id`),
  KEY `index_mpc_line_items_on_product_id` (`product_id`),
  KEY `index_mpc_line_items_on_shipment_id` (`shipment_id`),
  KEY `index_mpc_line_items_on_smp_shipping_method_id` (`smp_shipping_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_line_items_tmp_18_mar_18`
--

DROP TABLE IF EXISTS `mpc_line_items_tmp_18_mar_18`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_line_items_tmp_18_mar_18` (
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
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_line_items_on_order_id` (`order_id`),
  KEY `index_mpc_line_items_on_product_id` (`product_id`),
  KEY `index_mpc_line_items_on_shipment_id` (`shipment_id`),
  KEY `index_mpc_line_items_on_smp_shipping_method_id` (`smp_shipping_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=756200 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=129187 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=1471423 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=9074928 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=774288 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  PRIMARY KEY (`id`),
  KEY `index_mpc_marketplace_product_details_on_marketplace_product_id` (`marketplace_product_id`),
  KEY `index_mpc_marketplace_product_details_on_pickup_point_id` (`pickup_point_id`),
  CONSTRAINT `fk_rails_499f5045b2` FOREIGN KEY (`pickup_point_id`) REFERENCES `mpc_pickup_points` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=38664744 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=123862171 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=81579 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=123886795 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=146740966 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=43218 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=119122353 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_marketplace_products_11mar_bak2`
--

DROP TABLE IF EXISTS `mpc_marketplace_products_11mar_bak2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_marketplace_products_11mar_bak2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_marketplace_id` int NOT NULL,
  `product_id` int NOT NULL,
  `marketplace_id` int NOT NULL,
  `marketplace_code` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `taxon_id` int DEFAULT NULL,
  `brand_id` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `currency` varchar(5) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` decimal(15,2) DEFAULT '0.00',
  `selling_price` decimal(15,2) DEFAULT '0.00',
  `state` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `is_created` tinyint(1) DEFAULT NULL,
  `is_listed` tinyint(1) DEFAULT '0',
  `is_cloned` tinyint(1) DEFAULT '0',
  `is_sku_available` tinyint(1) DEFAULT '1',
  `allocated_stock` int DEFAULT '0',
  `prebooking_stock` tinyint(1) DEFAULT '0',
  `sync_stock` tinyint(1) DEFAULT '1',
  `mp_connected` tinyint(1) DEFAULT '1',
  `sale_start_date` datetime DEFAULT NULL,
  `sale_end_date` datetime DEFAULT NULL,
  `product_clone_history_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `image_updated` tinyint(1) DEFAULT '1',
  `parent_marketplace_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=10896 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=58391 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=55359701 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=27031376 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=178924472 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=46215720 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  KEY `seller_marketplace_id` (`seller_marketplace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56082067 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=504033 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2837695 DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=158888455 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=1642 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=26053933 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=75566569 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_orders_backup_12_mar_18`
--

DROP TABLE IF EXISTS `mpc_orders_backup_12_mar_18`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_orders_backup_12_mar_18` (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `state` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `bill_address_id` int DEFAULT NULL,
  `ship_address_id` int DEFAULT NULL,
  `payment_total` decimal(15,2) DEFAULT '0.00',
  `special_instructions` mediumtext COLLATE utf8_unicode_ci,
  `currency_id` int DEFAULT NULL,
  `send_as_gift` tinyint(1) DEFAULT NULL,
  `greeting_message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `market_place_order_number` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marketplace_order_state_id` int DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `cart_no` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `platform_user` tinyint(1) DEFAULT NULL,
  `payment_method_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `fulfilment_mode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_in_seller_currency` decimal(15,2) NOT NULL DEFAULT '0.00',
  `is_fetched` tinyint(1) DEFAULT '0',
  `sales_channel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_historical` tinyint(1) DEFAULT '0',
  `seller_subscription_id` int DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_mpc_orders_on_number_and_seller_marketplace_id` (`number`,`seller_marketplace_id`),
  KEY `index_mpc_orders_on_seller_marketplace_id` (`seller_marketplace_id`),
  KEY `index_mpc_orders_on_seller_id` (`seller_id`),
  KEY `index_mpc_orders_on_number` (`number`),
  KEY `index_mpc_orders_bill_address_id` (`bill_address_id`),
  KEY `index_mpc_orders_ship_address_id` (`ship_address_id`),
  KEY `mp_orders_state_index` (`state`),
  KEY `index_mpc_orders_bak_2_feb_18_on_seller_subscription_id` (`seller_subscription_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_orders_tmp_1`
--

DROP TABLE IF EXISTS `mpc_orders_tmp_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_orders_tmp_1` (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `state` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `bill_address_id` int DEFAULT NULL,
  `ship_address_id` int DEFAULT NULL,
  `payment_total` decimal(15,2) DEFAULT '0.00',
  `special_instructions` mediumtext COLLATE utf8_unicode_ci,
  `currency_id` int DEFAULT NULL,
  `send_as_gift` tinyint(1) DEFAULT NULL,
  `greeting_message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `market_place_order_number` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marketplace_order_status_id` int DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `cart_no` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `platform_user` tinyint(1) DEFAULT NULL,
  `payment_method_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `fulfilment_mode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_in_seller_currency` decimal(15,2) NOT NULL DEFAULT '0.00',
  `is_fetched` tinyint(1) DEFAULT '0',
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_orders_on_seller_marketplace_id` (`seller_marketplace_id`),
  KEY `index_mpc_orders_on_seller_id` (`seller_id`),
  KEY `index_mpc_orders_on_number` (`number`),
  KEY `index_mpc_orders_bill_address_id` (`bill_address_id`),
  KEY `index_mpc_orders_ship_address_id` (`ship_address_id`),
  KEY `mp_orders_state_index` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_orders_tmp_fresh`
--

DROP TABLE IF EXISTS `mpc_orders_tmp_fresh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_orders_tmp_fresh` (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `state` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `bill_address_id` int DEFAULT NULL,
  `ship_address_id` int DEFAULT NULL,
  `payment_total` decimal(15,2) DEFAULT '0.00',
  `special_instructions` mediumtext COLLATE utf8_unicode_ci,
  `currency_id` int DEFAULT NULL,
  `send_as_gift` tinyint(1) DEFAULT NULL,
  `greeting_message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `market_place_order_number` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marketplace_order_state_id` int DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `cart_no` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `platform_user` tinyint(1) DEFAULT NULL,
  `payment_method_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `fulfilment_mode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_in_seller_currency` decimal(15,2) NOT NULL DEFAULT '0.00',
  `is_fetched` tinyint(1) DEFAULT '0',
  `sales_channel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_mpc_orders_on_number_and_seller_marketplace_id` (`number`,`seller_marketplace_id`),
  KEY `index_mpc_orders_on_seller_marketplace_id` (`seller_marketplace_id`),
  KEY `index_mpc_orders_on_seller_id` (`seller_id`),
  KEY `index_mpc_orders_on_number` (`number`),
  KEY `index_mpc_orders_bill_address_id` (`bill_address_id`),
  KEY `index_mpc_orders_ship_address_id` (`ship_address_id`),
  KEY `mp_orders_state_index` (`state`),
  CONSTRAINT `fk_rails_ae7fc7516b` FOREIGN KEY (`bill_address_id`) REFERENCES `mpc_addresses_tmp` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_rails_bac4b72867` FOREIGN KEY (`ship_address_id`) REFERENCES `mpc_addresses_tmp` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16687 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=2826706 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=143405 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=2826750 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=485 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=1502 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=24297 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=149978 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=378042073 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=67883294 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_products_utf8mb4`
--

DROP TABLE IF EXISTS `mpc_products_utf8mb4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_products_utf8mb4` (
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
  KEY `uqix_products_seller_sku` (`seller_id`,`sku`) USING BTREE,
  KEY `nuix_products_seller` (`seller_id`) USING BTREE,
  KEY `nuix_products_sku` (`sku`) USING BTREE,
  KEY `nuix_products_inventory_product` (`inventory_product_id`) USING BTREE,
  KEY `nuix_products_collection` (`collection_id`) USING BTREE,
  KEY `mpc_p_permalink_x` (`permalink`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=8099842 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=29884 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3355 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=171097 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=175175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=10237 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=17422 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
  PRIMARY KEY (`id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=112845 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=48105 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_seller_marketplaces_26_oct`
--

DROP TABLE IF EXISTS `mpc_seller_marketplaces_26_oct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_seller_marketplaces_26_oct` (
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
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_seller_marketplaces_on_name` (`name`),
  KEY `index_mpc_seller_marketplaces_on_seller_id` (`seller_id`),
  KEY `index_mpc_seller_marketplaces_on_marketplace_id` (`marketplace_id`),
  KEY `index_mpc_seller_marketplaces_on_ss_code` (`ss_code`)
) ENGINE=InnoDB AUTO_INCREMENT=25192 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_seller_marketplaces_new`
--

DROP TABLE IF EXISTS `mpc_seller_marketplaces_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_seller_marketplaces_new` (
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
  PRIMARY KEY (`id`),
  KEY `index_mpc_seller_marketplaces_on_name` (`name`),
  KEY `index_mpc_seller_marketplaces_on_seller_id` (`seller_id`),
  KEY `index_mpc_seller_marketplaces_on_marketplace_id` (`marketplace_id`),
  KEY `index_mpc_seller_marketplaces_on_ss_code` (`ss_code`)
) ENGINE=InnoDB AUTO_INCREMENT=44180 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=134777 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=15840 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
  `seller_country` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mpc_sellers_on_name` (`name`),
  KEY `index_mpc_sellers_on_seller_type_id` (`seller_type_id`),
  KEY `index_mpc_sellers_on_fulfilment_type_id` (`fulfilment_type_id`),
  KEY `index_mpc_sellers_on_fulfilment_network_id` (`fulfilment_network_id`),
  KEY `index_mpc_sellers_on_language_id` (`language_id`),
  KEY `index_mpc_sellers_on_exclusive_group_id` (`exclusive_group_id`),
  KEY `mpc_sellers_shard_id` (`shard_id`),
  KEY `index_mpc_sellers_on_master_account_id` (`master_account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17421 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=1688 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=66700731 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=15123637 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_shipment_packing_lists_28_09`
--

DROP TABLE IF EXISTS `mpc_shipment_packing_lists_28_09`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_shipment_packing_lists_28_09` (
  `id` int NOT NULL AUTO_INCREMENT,
  `in_packing_at` datetime DEFAULT NULL,
  `print_at` datetime DEFAULT NULL,
  `packed_at` datetime DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `shipment_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ts_ver` timestamp NOT NULL DEFAULT '2019-01-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_mpc_packing_list_on_user_id` (`user_id`),
  KEY `index_mpc_packing_list_on_shipment_id` (`shipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=74765419 DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=61592085 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mpc_shipments_19_07_bak`
--

DROP TABLE IF EXISTS `mpc_shipments_19_07_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpc_shipments_19_07_bak` (
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
  KEY `index_mpc_shipments_on_seller_id` (`seller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=6065 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=24487 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=62859 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=25615 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=988842154 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=695710245 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=696392 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  KEY `mpc_stock_update_flags_iid_x` (`inventory_product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23108402 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=244 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9841 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=12818 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
  KEY `ix_taxons_parent` (`parent_id`),
  CONSTRAINT `fk_rails_b3d37e97ac` FOREIGN KEY (`taxonomy_id`) REFERENCES `mpc_taxonomies` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=574012 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=307898 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=1377166 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  KEY `index_mpc_users_on_master_account_id` (`master_account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17767 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=1383293 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=693280 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3337702746 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=226101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=49293 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=1112205 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=2106481 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=222605 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=356067 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3340428770 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3338628806 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3465692294 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3430817481 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3648714358 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3381885924 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3360346459 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3353256593 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3355031228 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3393782161 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3343590886 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=9881 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=5464069 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=1088 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=10436 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3291558725 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=949696 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3355425953 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3377727456 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3369569382 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3375305201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3540523837 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3359365797 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3321820084 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3352671499 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=41285468 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=2697794543 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3021253220 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3352692149 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3356779931 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3352408394 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3356316152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=566114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3355606754 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=864581 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=10852959 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3353910595 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=161117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3356092440 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3354561154 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3357734962 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3367552767 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=809083 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=3356438599 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=261216 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=672034 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
-- Table structure for table `table_stats`
--

DROP TABLE IF EXISTS `table_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `table_stats` (
  `table_name` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `table_size` decimal(23,0) DEFAULT NULL,
  `table_rank` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_orders_stats_fs`
--

DROP TABLE IF EXISTS `temp_orders_stats_fs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_orders_stats_fs` (
  `id` int NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `business_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `seller_state` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `base_currency` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `order_state` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `payment_total` decimal(15,2) DEFAULT '0.00',
  `currency` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `seller_marketplace_id` int DEFAULT NULL,
  `order_month` varchar(37) CHARACTER SET utf8 DEFAULT NULL,
  `total_in_seller_currency` decimal(15,2) NOT NULL DEFAULT '0.00',
  `sales_channel` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tmp_seller_product_summary`
--

DROP TABLE IF EXISTS `tmp_seller_product_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tmp_seller_product_summary` (
  `seller_id` int NOT NULL DEFAULT '0',
  `total_skus` bigint DEFAULT '0',
  `base_currency` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `current_shard_id` int DEFAULT NULL,
  `new_shard_id` int NOT NULL DEFAULT '0',
  `migrated` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `v_ati_accounting_tool_confs`
--

DROP TABLE IF EXISTS `v_ati_accounting_tool_confs`;
/*!50001 DROP VIEW IF EXISTS `v_ati_accounting_tool_confs`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_ati_accounting_tool_confs` (
  `id` tinyint NOT NULL,
  `accounting_tool_id` tinyint NOT NULL,
  `key_name` tinyint NOT NULL,
  `key_display_name` tinyint NOT NULL,
  `key_position` tinyint NOT NULL,
  `is_input_required` tinyint NOT NULL,
  `is_ui_visible` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `are_all_products_pushed` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_ati_accounting_tools`
--

DROP TABLE IF EXISTS `v_ati_accounting_tools`;
/*!50001 DROP VIEW IF EXISTS `v_ati_accounting_tools`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_ati_accounting_tools` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `code` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `country_code` tinyint NOT NULL,
  `domain_url` tinyint NOT NULL,
  `api_url` tinyint NOT NULL,
  `is_active` tinyint NOT NULL,
  `deactivated_at` tinyint NOT NULL,
  `default_session_time` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_cs_logistics_confs`
--

DROP TABLE IF EXISTS `v_cs_logistics_confs`;
/*!50001 DROP VIEW IF EXISTS `v_cs_logistics_confs`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_cs_logistics_confs` (
  `id` tinyint NOT NULL,
  `logistics_partner_id` tinyint NOT NULL,
  `key_name` tinyint NOT NULL,
  `key_diplay_name` tinyint NOT NULL,
  `key_position` tinyint NOT NULL,
  `is_input_required` tinyint NOT NULL,
  `is_ui_visible` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_cs_logistics_partners`
--

DROP TABLE IF EXISTS `v_cs_logistics_partners`;
/*!50001 DROP VIEW IF EXISTS `v_cs_logistics_partners`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_cs_logistics_partners` (
  `id` tinyint NOT NULL,
  `partner_name` tinyint NOT NULL,
  `partner_code` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `country_code` tinyint NOT NULL,
  `domain_url` tinyint NOT NULL,
  `tracking_url` tinyint NOT NULL,
  `api_url` tinyint NOT NULL,
  `is_active` tinyint NOT NULL,
  `is_global` tinyint NOT NULL,
  `deactivated_at` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_account_types`
--

DROP TABLE IF EXISTS `v_mpc_account_types`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_account_types`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_account_types` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `privilage_level` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_assets`
--

DROP TABLE IF EXISTS `v_mpc_assets`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_assets`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_assets` (
  `id` tinyint NOT NULL,
  `viewable_id` tinyint NOT NULL,
  `viewable_type` tinyint NOT NULL,
  `attachment_width` tinyint NOT NULL,
  `attachment_height` tinyint NOT NULL,
  `attachment_file_size` tinyint NOT NULL,
  `attachment_content_type` tinyint NOT NULL,
  `attachment_file_name` tinyint NOT NULL,
  `attachment_updated_at` tinyint NOT NULL,
  `alt` tinyint NOT NULL,
  `attachment_type` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_base_categories`
--

DROP TABLE IF EXISTS `v_mpc_base_categories`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_base_categories`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_base_categories` (
  `id` tinyint NOT NULL,
  `regional_id` tinyint NOT NULL,
  `display_name` tinyint NOT NULL,
  `is_leaf` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_braintree_callbacks`
--

DROP TABLE IF EXISTS `v_mpc_braintree_callbacks`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_braintree_callbacks`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_braintree_callbacks` (
  `id` tinyint NOT NULL,
  `seller_id` tinyint NOT NULL,
  `subscription_id` tinyint NOT NULL,
  `response` tinyint NOT NULL,
  `callback_type` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_brands`
--

DROP TABLE IF EXISTS `v_mpc_brands`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_brands`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_brands` (
  `id` tinyint NOT NULL,
  `marketplace_id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `code` tinyint NOT NULL,
  `presentation` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `active` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_bulk_import_versions`
--

DROP TABLE IF EXISTS `v_mpc_bulk_import_versions`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_bulk_import_versions`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_bulk_import_versions` (
  `id` tinyint NOT NULL,
  `original_file_file_name` tinyint NOT NULL,
  `original_file_content_type` tinyint NOT NULL,
  `original_file_file_size` tinyint NOT NULL,
  `original_file_updated_at` tinyint NOT NULL,
  `sample_file_file_name` tinyint NOT NULL,
  `sample_file_content_type` tinyint NOT NULL,
  `sample_file_file_size` tinyint NOT NULL,
  `sample_file_updated_at` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `display_name` tinyint NOT NULL,
  `current_version` tinyint NOT NULL,
  `user_id` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_capabilities`
--

DROP TABLE IF EXISTS `v_mpc_capabilities`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_capabilities`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_capabilities` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `display_name` tinyint NOT NULL,
  `is_module` tinyint NOT NULL,
  `based_on` tinyint NOT NULL,
  `action` tinyint NOT NULL,
  `subject_class` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `rule_class` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_category_commissions`
--

DROP TABLE IF EXISTS `v_mpc_category_commissions`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_category_commissions`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_category_commissions` (
  `id` tinyint NOT NULL,
  `commission` tinyint NOT NULL,
  `payment_fees` tinyint NOT NULL,
  `payoneer_fees` tinyint NOT NULL,
  `taxon_id` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_city_lookups`
--

DROP TABLE IF EXISTS `v_mpc_city_lookups`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_city_lookups`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_city_lookups` (
  `id` tinyint NOT NULL,
  `address_code` tinyint NOT NULL,
  `parent_code` tinyint NOT NULL,
  `address_name` tinyint NOT NULL,
  `country_id` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_customer_types`
--

DROP TABLE IF EXISTS `v_mpc_customer_types`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_customer_types`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_customer_types` (
  `id` tinyint NOT NULL,
  `card_type` tinyint NOT NULL,
  `customer_type` tinyint NOT NULL,
  `ss_customer_type` tinyint NOT NULL,
  `magento_customer_type` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_email_events`
--

DROP TABLE IF EXISTS `v_mpc_email_events`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_email_events`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_email_events` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `active` tinyint NOT NULL,
  `seller` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_exclusive_groups`
--

DROP TABLE IF EXISTS `v_mpc_exclusive_groups`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_exclusive_groups`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_exclusive_groups` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `code` tinyint NOT NULL,
  `exclusivity_duration` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_field_groups`
--

DROP TABLE IF EXISTS `v_mpc_field_groups`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_field_groups`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_field_groups` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `display_name` tinyint NOT NULL,
  `marketplace_id` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_field_instructions`
--

DROP TABLE IF EXISTS `v_mpc_field_instructions`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_field_instructions`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_field_instructions` (
  `id` tinyint NOT NULL,
  `marketplace_id` tinyint NOT NULL,
  `field_name` tinyint NOT NULL,
  `length` tinyint NOT NULL,
  `message` tinyint NOT NULL,
  `allow_creation` tinyint NOT NULL,
  `allow_updation` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_field_values`
--

DROP TABLE IF EXISTS `v_mpc_field_values`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_field_values`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_field_values` (
  `id` tinyint NOT NULL,
  `field_id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `value` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_fields`
--

DROP TABLE IF EXISTS `v_mpc_fields`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_fields`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_fields` (
  `id` tinyint NOT NULL,
  `marketplace_id` tinyint NOT NULL,
  `field_type` tinyint NOT NULL,
  `data_type` tinyint NOT NULL,
  `mandatory` tinyint NOT NULL,
  `free_text` tinyint NOT NULL,
  `taxon_id` tinyint NOT NULL,
  `field_name` tinyint NOT NULL,
  `field_code` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `option_type` tinyint NOT NULL,
  `parent_id` tinyint NOT NULL,
  `criteria` tinyint NOT NULL,
  `ss_field_code` tinyint NOT NULL,
  `field_group_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_fulfilment_networks`
--

DROP TABLE IF EXISTS `v_mpc_fulfilment_networks`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_fulfilment_networks`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_fulfilment_networks` (
  `id` tinyint NOT NULL,
  `domain_url` tinyint NOT NULL,
  `order_create_path` tinyint NOT NULL,
  `product_create_path` tinyint NOT NULL,
  `product_update_path` tinyint NOT NULL,
  `fetch_stock_path` tinyint NOT NULL,
  `order_status_update_path` tinyint NOT NULL,
  `order_cancel_path` tinyint NOT NULL,
  `order_item_cancel_path` tinyint NOT NULL,
  `consignment_path` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `update_invoice_path` tinyint NOT NULL,
  `update_manifest_path` tinyint NOT NULL,
  `update_tracking_number_path` tinyint NOT NULL,
  `fetch_merchant_path` tinyint NOT NULL,
  `create_merchant_path` tinyint NOT NULL,
  `fetch_product_path` tinyint NOT NULL,
  `authorize_ewms_connection_path` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_fulfilment_order_states`
--

DROP TABLE IF EXISTS `v_mpc_fulfilment_order_states`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_fulfilment_order_states`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_fulfilment_order_states` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `code` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_fulfilment_types`
--

DROP TABLE IF EXISTS `v_mpc_fulfilment_types`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_fulfilment_types`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_fulfilment_types` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `presentation` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_languages`
--

DROP TABLE IF EXISTS `v_mpc_languages`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_languages`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_languages` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `presentation` tinyint NOT NULL,
  `active` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `code` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_map_taxons`
--

DROP TABLE IF EXISTS `v_mpc_map_taxons`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_map_taxons`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_map_taxons` (
  `id` tinyint NOT NULL,
  `taxon_id` tinyint NOT NULL,
  `base_category_id` tinyint NOT NULL,
  `seller_id` tinyint NOT NULL,
  `status` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_marketplace_keys`
--

DROP TABLE IF EXISTS `v_mpc_marketplace_keys`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_marketplace_keys`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_marketplace_keys` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `presenation` tinyint NOT NULL,
  `marketplace_id` tinyint NOT NULL,
  `sequence` tinyint NOT NULL,
  `input_required` tinyint NOT NULL,
  `visible_on_ui` tinyint NOT NULL,
  `help_text` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_marketplace_setting_fields`
--

DROP TABLE IF EXISTS `v_mpc_marketplace_setting_fields`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_marketplace_setting_fields`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_marketplace_setting_fields` (
  `id` tinyint NOT NULL,
  `marketplace_id` tinyint NOT NULL,
  `field_type` tinyint NOT NULL,
  `data_type` tinyint NOT NULL,
  `mandatory` tinyint NOT NULL,
  `field_name` tinyint NOT NULL,
  `field_code` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `position` tinyint NOT NULL,
  `visible_on_ui` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_marketplaces`
--

DROP TABLE IF EXISTS `v_mpc_marketplaces`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_marketplaces`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_marketplaces` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `code` tinyint NOT NULL,
  `domain_url` tinyint NOT NULL,
  `country_id` tinyint NOT NULL,
  `currency_id` tinyint NOT NULL,
  `active` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `registration_domain` tinyint NOT NULL,
  `activation_date` tinyint NOT NULL,
  `is_prefered` tinyint NOT NULL,
  `is_webstore` tinyint NOT NULL,
  `help_link` tinyint NOT NULL,
  `onboarding_position` tinyint NOT NULL,
  `is_deleted` tinyint NOT NULL,
  `support_ss_category` tinyint NOT NULL,
  `seller_tag` tinyint NOT NULL,
  `lock_stock_update` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL,
  `is_global_marketplace` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_marketplaces_operations`
--

DROP TABLE IF EXISTS `v_mpc_marketplaces_operations`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_marketplaces_operations`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_marketplaces_operations` (
  `marketplace_id` tinyint NOT NULL,
  `operation_id` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_masters`
--

DROP TABLE IF EXISTS `v_mpc_masters`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_masters`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_masters` (
  `id` tinyint NOT NULL,
  `critical_limit` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_notifications`
--

DROP TABLE IF EXISTS `v_mpc_notifications`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_notifications`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_notifications` (
  `id` tinyint NOT NULL,
  `event_type` tinyint NOT NULL,
  `notification_channel` tinyint NOT NULL,
  `event` tinyint NOT NULL,
  `level` tinyint NOT NULL,
  `template` tinyint NOT NULL,
  `action` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `new_action` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_notify_subscribe_users`
--

DROP TABLE IF EXISTS `v_mpc_notify_subscribe_users`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_notify_subscribe_users`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_notify_subscribe_users` (
  `id` tinyint NOT NULL,
  `marketplace_id` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_onboard_details`
--

DROP TABLE IF EXISTS `v_mpc_onboard_details`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_onboard_details`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_onboard_details` (
  `id` tinyint NOT NULL,
  `country_id` tinyint NOT NULL,
  `call_url` tinyint NOT NULL,
  `phone_number` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_order_failure_reasons`
--

DROP TABLE IF EXISTS `v_mpc_order_failure_reasons`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_order_failure_reasons`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_order_failure_reasons` (
  `id` tinyint NOT NULL,
  `reason_code` tinyint NOT NULL,
  `reason` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `marketplace_id` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_payment_merchants`
--

DROP TABLE IF EXISTS `v_mpc_payment_merchants`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_payment_merchants`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_payment_merchants` (
  `id` tinyint NOT NULL,
  `merchant_id` tinyint NOT NULL,
  `mpc_country_id` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `active` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_promocode_marketplaces`
--

DROP TABLE IF EXISTS `v_mpc_promocode_marketplaces`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_promocode_marketplaces`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_promocode_marketplaces` (
  `id` tinyint NOT NULL,
  `promocode_id` tinyint NOT NULL,
  `marketplace_id` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_promocode_plans`
--

DROP TABLE IF EXISTS `v_mpc_promocode_plans`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_promocode_plans`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_promocode_plans` (
  `id` tinyint NOT NULL,
  `promocode_id` tinyint NOT NULL,
  `subscription_id` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_promotion_closing_rules`
--

DROP TABLE IF EXISTS `v_mpc_promotion_closing_rules`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_promotion_closing_rules`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_promotion_closing_rules` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `default` tinyint NOT NULL,
  `active` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `code` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_promotion_closing_rules_types`
--

DROP TABLE IF EXISTS `v_mpc_promotion_closing_rules_types`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_promotion_closing_rules_types`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_promotion_closing_rules_types` (
  `promotion_type_id` tinyint NOT NULL,
  `promotion_closing_rule_id` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_promotion_rules`
--

DROP TABLE IF EXISTS `v_mpc_promotion_rules`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_promotion_rules`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_promotion_rules` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `default` tinyint NOT NULL,
  `active` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `code` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_reports`
--

DROP TABLE IF EXISTS `v_mpc_reports`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_reports`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_reports` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `code` tinyint NOT NULL,
  `active` tinyint NOT NULL,
  `date_range_required` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `report_type` tinyint NOT NULL,
  `report_model` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL,
  `is_master_account` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_roles`
--

DROP TABLE IF EXISTS `v_mpc_roles`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_roles`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_roles` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `presentation` tinyint NOT NULL,
  `platform_user` tinyint NOT NULL,
  `role_type` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_seller_types`
--

DROP TABLE IF EXISTS `v_mpc_seller_types`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_seller_types`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_seller_types` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `code` tinyint NOT NULL,
  `presentation` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_setup_details`
--

DROP TABLE IF EXISTS `v_mpc_setup_details`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_setup_details`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_setup_details` (
  `id` tinyint NOT NULL,
  `instruction` tinyint NOT NULL,
  `attachable_id` tinyint NOT NULL,
  `attachable_type` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_shipping_types`
--

DROP TABLE IF EXISTS `v_mpc_shipping_types`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_shipping_types`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_shipping_types` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `presentation` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_states`
--

DROP TABLE IF EXISTS `v_mpc_states`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_states`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_states` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `abbr` tinyint NOT NULL,
  `country_id` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_subscriptions`
--

DROP TABLE IF EXISTS `v_mpc_subscriptions`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_subscriptions`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_subscriptions` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `price` tinyint NOT NULL,
  `no_of_orders` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `country` tinyint NOT NULL,
  `active` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `permalink` tinyint NOT NULL,
  `subscription_type` tinyint NOT NULL,
  `valid_for` tinyint NOT NULL,
  `related_id` tinyint NOT NULL,
  `braintree_subscription_id` tinyint NOT NULL,
  `plan_id` tinyint NOT NULL,
  `plan_type` tinyint NOT NULL,
  `payment_frequency` tinyint NOT NULL,
  `usual_price` tinyint NOT NULL,
  `account_type_id` tinyint NOT NULL,
  `buyable` tinyint NOT NULL,
  `threshold` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL,
  `gst_in_percent` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_taxonomies`
--

DROP TABLE IF EXISTS `v_mpc_taxonomies`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_taxonomies`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_taxonomies` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `presentation` tinyint NOT NULL,
  `metakeywords` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `marketplace_id` tinyint NOT NULL,
  `marketplace_type` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_mpc_taxons`
--

DROP TABLE IF EXISTS `v_mpc_taxons`;
/*!50001 DROP VIEW IF EXISTS `v_mpc_taxons`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_mpc_taxons` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `presentation` tinyint NOT NULL,
  `parent_id` tinyint NOT NULL,
  `position` tinyint NOT NULL,
  `taxonomy_id` tinyint NOT NULL,
  `lft` tinyint NOT NULL,
  `rgt` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `code` tinyint NOT NULL,
  `permalink` tinyint NOT NULL,
  `display_name` tinyint NOT NULL,
  `base_category_id` tinyint NOT NULL,
  `active` tinyint NOT NULL,
  `variation` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_schema_migrations`
--

DROP TABLE IF EXISTS `v_schema_migrations`;
/*!50001 DROP VIEW IF EXISTS `v_schema_migrations`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_schema_migrations` (
  `version` tinyint NOT NULL,
  `ts_ver` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

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
) ENGINE=InnoDB AUTO_INCREMENT=512551767 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `v_ati_accounting_tool_confs`
--

/*!50001 DROP TABLE IF EXISTS `v_ati_accounting_tool_confs`*/;
/*!50001 DROP VIEW IF EXISTS `v_ati_accounting_tool_confs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_ati_accounting_tool_confs` AS select `ati_accounting_tool_confs`.`id` AS `id`,`ati_accounting_tool_confs`.`accounting_tool_id` AS `accounting_tool_id`,`ati_accounting_tool_confs`.`key_name` AS `key_name`,`ati_accounting_tool_confs`.`key_display_name` AS `key_display_name`,`ati_accounting_tool_confs`.`key_position` AS `key_position`,`ati_accounting_tool_confs`.`is_input_required` AS `is_input_required`,`ati_accounting_tool_confs`.`is_ui_visible` AS `is_ui_visible`,`ati_accounting_tool_confs`.`created_at` AS `created_at`,`ati_accounting_tool_confs`.`updated_at` AS `updated_at`,`ati_accounting_tool_confs`.`are_all_products_pushed` AS `are_all_products_pushed`,`ati_accounting_tool_confs`.`ts_ver` AS `ts_ver` from `ati_accounting_tool_confs` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_ati_accounting_tools`
--

/*!50001 DROP TABLE IF EXISTS `v_ati_accounting_tools`*/;
/*!50001 DROP VIEW IF EXISTS `v_ati_accounting_tools`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_ati_accounting_tools` AS select `ati_accounting_tools`.`id` AS `id`,`ati_accounting_tools`.`name` AS `name`,`ati_accounting_tools`.`code` AS`code`,`ati_accounting_tools`.`description` AS `description`,`ati_accounting_tools`.`country_code` AS `country_code`,`ati_accounting_tools`.`domain_url` AS `domain_url`,`ati_accounting_tools`.`api_url` AS `api_url`,`ati_accounting_tools`.`is_active` AS `is_active`,`ati_accounting_tools`.`deactivated_at` AS `deactivated_at`,`ati_accounting_tools`.`default_session_time` AS `default_session_time`,`ati_accounting_tools`.`created_at` AS `created_at`,`ati_accounting_tools`.`updated_at` AS `updated_at`,`ati_accounting_tools`.`ts_ver` AS `ts_ver` from `ati_accounting_tools` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_cs_logistics_confs`
--

/*!50001 DROP TABLE IF EXISTS `v_cs_logistics_confs`*/;
/*!50001 DROP VIEW IF EXISTS `v_cs_logistics_confs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_cs_logistics_confs` AS select `cs_logistics_confs`.`id` AS `id`,`cs_logistics_confs`.`logistics_partner_id` AS `logistics_partner_id`,`cs_logistics_confs`.`key_name` AS `key_name`,`cs_logistics_confs`.`key_diplay_name` AS `key_diplay_name`,`cs_logistics_confs`.`key_position` AS `key_position`,`cs_logistics_confs`.`is_input_required` AS `is_input_required`,`cs_logistics_confs`.`is_ui_visible` AS `is_ui_visible`,`cs_logistics_confs`.`created_at` AS `created_at`,`cs_logistics_confs`.`updated_at` AS `updated_at`,`cs_logistics_confs`.`ts_ver` AS `ts_ver` from `cs_logistics_confs` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_cs_logistics_partners`
--

/*!50001 DROP TABLE IF EXISTS `v_cs_logistics_partners`*/;
/*!50001 DROP VIEW IF EXISTS `v_cs_logistics_partners`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_cs_logistics_partners` AS select `cs_logistics_partners`.`id` AS `id`,`cs_logistics_partners`.`partner_name` AS `partner_name`,`cs_logistics_partners`.`partner_code` AS `partner_code`,`cs_logistics_partners`.`description` AS `description`,`cs_logistics_partners`.`country_code` AS `country_code`,`cs_logistics_partners`.`domain_url` AS `domain_url`,`cs_logistics_partners`.`tracking_url` AS `tracking_url`,`cs_logistics_partners`.`api_url` AS `api_url`,`cs_logistics_partners`.`is_active` AS `is_active`,`cs_logistics_partners`.`is_global` AS `is_global`,`cs_logistics_partners`.`deactivated_at` AS `deactivated_at`,`cs_logistics_partners`.`created_at` AS `created_at`,`cs_logistics_partners`.`updated_at` AS `updated_at`,`cs_logistics_partners`.`ts_ver` AS `ts_ver` from `cs_logistics_partners` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_account_types`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_account_types`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_account_types`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_account_types` AS select `mpc_account_types`.`id` AS `id`,`mpc_account_types`.`name` AS `name`,`mpc_account_types`.`description` AS `description`,`mpc_account_types`.`created_at` AS `created_at`,`mpc_account_types`.`updated_at` AS `updated_at`,`mpc_account_types`.`privilage_level` AS `privilage_level`,`mpc_account_types`.`ts_ver` AS `ts_ver` from `mpc_account_types` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_assets`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_assets`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_assets`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_assets` AS select `mpc_assets`.`id` AS `id`,`mpc_assets`.`viewable_id` AS `viewable_id`,`mpc_assets`.`viewable_type` AS `viewable_type`,`mpc_assets`.`attachment_width` AS `attachment_width`,`mpc_assets`.`attachment_height` AS `attachment_height`,`mpc_assets`.`attachment_file_size` AS `attachment_file_size`,`mpc_assets`.`attachment_content_type` AS `attachment_content_type`,`mpc_assets`.`attachment_file_name` AS `attachment_file_name`,`mpc_assets`.`attachment_updated_at` AS `attachment_updated_at`,`mpc_assets`.`alt` AS `alt`,`mpc_assets`.`attachment_type` AS `attachment_type`,`mpc_assets`.`ts_ver` AS `ts_ver` from `mpc_assets` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_base_categories`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_base_categories`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_base_categories`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_base_categories` AS select `mpc_base_categories`.`id` AS `id`,`mpc_base_categories`.`regional_id` AS `regional_id`,`mpc_base_categories`.`display_name` AS `display_name`,`mpc_base_categories`.`is_leaf` AS `is_leaf`,`mpc_base_categories`.`created_at` AS `created_at`,`mpc_base_categories`.`updated_at` AS `updated_at`,`mpc_base_categories`.`ts_ver` AS `ts_ver` from `mpc_base_categories` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_braintree_callbacks`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_braintree_callbacks`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_braintree_callbacks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_braintree_callbacks` AS select `mpc_braintree_callbacks`.`id` AS `id`,`mpc_braintree_callbacks`.`seller_id` AS `seller_id`,`mpc_braintree_callbacks`.`subscription_id` AS `subscription_id`,`mpc_braintree_callbacks`.`response` AS `response`,`mpc_braintree_callbacks`.`callback_type` AS `callback_type`,`mpc_braintree_callbacks`.`created_at` AS `created_at`,`mpc_braintree_callbacks`.`updated_at` AS `updated_at`,`mpc_braintree_callbacks`.`ts_ver` AS `ts_ver` from `mpc_braintree_callbacks` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_brands`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_brands`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_brands`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_brands` AS select `mpc_brands`.`id` AS `id`,`mpc_brands`.`marketplace_id` AS `marketplace_id`,`mpc_brands`.`name` AS `name`,`mpc_brands`.`code` AS `code`,`mpc_brands`.`presentation` AS `presentation`,`mpc_brands`.`created_at` AS `created_at`,`mpc_brands`.`updated_at` AS `updated_at`,`mpc_brands`.`active` AS `active`,`mpc_brands`.`ts_ver` AS `ts_ver` from `mpc_brands` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_bulk_import_versions`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_bulk_import_versions`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_bulk_import_versions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_bulk_import_versions` AS select `mpc_bulk_import_versions`.`id` AS `id`,`mpc_bulk_import_versions`.`original_file_file_name` AS `original_file_file_name`,`mpc_bulk_import_versions`.`original_file_content_type` AS `original_file_content_type`,`mpc_bulk_import_versions`.`original_file_file_size`AS `original_file_file_size`,`mpc_bulk_import_versions`.`original_file_updated_at` AS `original_file_updated_at`,`mpc_bulk_import_versions`.`sample_file_file_name` AS `sample_file_file_name`,`mpc_bulk_import_versions`.`sample_file_content_type` AS `sample_file_content_type`,`mpc_bulk_import_versions`.`sample_file_file_size` AS `sample_file_file_size`,`mpc_bulk_import_versions`.`sample_file_updated_at` AS `sample_file_updated_at`,`mpc_bulk_import_versions`.`name` AS `name`,`mpc_bulk_import_versions`.`display_name` AS `display_name`,`mpc_bulk_import_versions`.`current_version` AS `current_version`,`mpc_bulk_import_versions`.`user_id` AS `user_id`,`mpc_bulk_import_versions`.`created_at` AS `created_at`,`mpc_bulk_import_versions`.`updated_at` AS `updated_at`,`mpc_bulk_import_versions`.`ts_ver` AS `ts_ver` from `mpc_bulk_import_versions` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_capabilities`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_capabilities`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_capabilities`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_capabilities` AS select `mpc_capabilities`.`id` AS `id`,`mpc_capabilities`.`name` AS `name`,`mpc_capabilities`.`display_name` AS `display_name`,`mpc_capabilities`.`is_module` AS `is_module`,`mpc_capabilities`.`based_on` AS `based_on`,`mpc_capabilities`.`action` AS `action`,`mpc_capabilities`.`subject_class` AS `subject_class`,`mpc_capabilities`.`created_at` AS `created_at`,`mpc_capabilities`.`updated_at` AS `updated_at`,`mpc_capabilities`.`rule_class` AS `rule_class`,`mpc_capabilities`.`ts_ver` AS `ts_ver` from `mpc_capabilities` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_category_commissions`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_category_commissions`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_category_commissions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_category_commissions` AS select `mpc_category_commissions`.`id` AS `id`,`mpc_category_commissions`.`commission` AS `commission`,`mpc_category_commissions`.`payment_fees` AS `payment_fees`,`mpc_category_commissions`.`payoneer_fees` AS `payoneer_fees`,`mpc_category_commissions`.`taxon_id` AS `taxon_id`,`mpc_category_commissions`.`created_at` AS `created_at`,`mpc_category_commissions`.`updated_at` AS `updated_at`,`mpc_category_commissions`.`ts_ver` AS`ts_ver` from `mpc_category_commissions` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_city_lookups`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_city_lookups`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_city_lookups`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_city_lookups` AS select `mpc_city_lookups`.`id` AS `id`,`mpc_city_lookups`.`address_code` AS `address_code`,`mpc_city_lookups`.`parent_code` AS `parent_code`,`mpc_city_lookups`.`address_name` AS `address_name`,`mpc_city_lookups`.`country_id` AS `country_id`,`mpc_city_lookups`.`ts_ver` AS `ts_ver` from `mpc_city_lookups` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_customer_types`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_customer_types`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_customer_types`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_customer_types` AS select `mpc_customer_types`.`id` AS `id`,`mpc_customer_types`.`card_type` AS `card_type`,`mpc_customer_types`.`customer_type` AS `customer_type`,`mpc_customer_types`.`ss_customer_type` AS `ss_customer_type`,`mpc_customer_types`.`magento_customer_type` AS `magento_customer_type`,`mpc_customer_types`.`created_at` AS `created_at`,`mpc_customer_types`.`updated_at` AS `updated_at`,`mpc_customer_types`.`ts_ver` AS `ts_ver` from `mpc_customer_types` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_email_events`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_email_events`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_email_events`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_email_events` AS select `mpc_email_events`.`id` AS `id`,`mpc_email_events`.`name` AS `name`,`mpc_email_events`.`description` AS `description`,`mpc_email_events`.`active` AS `active`,`mpc_email_events`.`seller` AS `seller`,`mpc_email_events`.`created_at` AS `created_at`,`mpc_email_events`.`updated_at` AS `updated_at`,`mpc_email_events`.`ts_ver` AS `ts_ver` from `mpc_email_events` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_exclusive_groups`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_exclusive_groups`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_exclusive_groups`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_exclusive_groups` AS select `mpc_exclusive_groups`.`id` AS `id`,`mpc_exclusive_groups`.`name` AS `name`,`mpc_exclusive_groups`.`description` AS `description`,`mpc_exclusive_groups`.`code` AS `code`,`mpc_exclusive_groups`.`exclusivity_duration` AS `exclusivity_duration`,`mpc_exclusive_groups`.`created_at` AS `created_at`,`mpc_exclusive_groups`.`updated_at` AS `updated_at`,`mpc_exclusive_groups`.`ts_ver` AS `ts_ver` from `mpc_exclusive_groups` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_field_groups`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_field_groups`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_field_groups`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_field_groups` AS select `mpc_field_groups`.`id` AS `id`,`mpc_field_groups`.`name` AS `name`,`mpc_field_groups`.`display_name` AS `display_name`,`mpc_field_groups`.`marketplace_id` AS `marketplace_id`,`mpc_field_groups`.`created_at` AS `created_at`,`mpc_field_groups`.`updated_at` AS `updated_at`,`mpc_field_groups`.`ts_ver` AS `ts_ver` from `mpc_field_groups` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_field_instructions`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_field_instructions`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_field_instructions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_field_instructions` AS select `mpc_field_instructions`.`id` AS `id`,`mpc_field_instructions`.`marketplace_id` AS `marketplace_id`,`mpc_field_instructions`.`field_name` AS `field_name`,`mpc_field_instructions`.`length` AS `length`,`mpc_field_instructions`.`message` AS `message`,`mpc_field_instructions`.`allow_creation` AS `allow_creation`,`mpc_field_instructions`.`allow_updation` AS `allow_updation`,`mpc_field_instructions`.`created_at` AS `created_at`,`mpc_field_instructions`.`updated_at` AS `updated_at`,`mpc_field_instructions`.`ts_ver` AS `ts_ver` from `mpc_field_instructions` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_field_values`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_field_values`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_field_values`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_field_values` AS select `mpc_field_values`.`id` AS `id`,`mpc_field_values`.`field_id` AS `field_id`,`mpc_field_values`.`name` AS `name`,`mpc_field_values`.`value` AS `value`,`mpc_field_values`.`created_at` AS `created_at`,`mpc_field_values`.`updated_at` AS `updated_at`,`mpc_field_values`.`ts_ver` AS `ts_ver` from `mpc_field_values` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_fields`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_fields`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_fields`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_fields` AS select `mpc_fields`.`id` AS `id`,`mpc_fields`.`marketplace_id` AS `marketplace_id`,`mpc_fields`.`field_type` AS `field_type`,`mpc_fields`.`data_type` AS `data_type`,`mpc_fields`.`mandatory` AS `mandatory`,`mpc_fields`.`free_text` AS `free_text`,`mpc_fields`.`taxon_id` AS `taxon_id`,`mpc_fields`.`field_name` AS `field_name`,`mpc_fields`.`field_code` AS `field_code`,`mpc_fields`.`created_at` AS `created_at`,`mpc_fields`.`updated_at` AS `updated_at`,`mpc_fields`.`option_type` AS `option_type`,`mpc_fields`.`parent_id` AS `parent_id`,`mpc_fields`.`criteria` AS `criteria`,`mpc_fields`.`ss_field_code` AS `ss_field_code`,`mpc_fields`.`field_group_id` AS `field_group_id` from `mpc_fields` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_fulfilment_networks`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_fulfilment_networks`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_fulfilment_networks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_fulfilment_networks` AS select `mpc_fulfilment_networks`.`id` AS `id`,`mpc_fulfilment_networks`.`domain_url` AS `domain_url`,`mpc_fulfilment_networks`.`order_create_path` AS `order_create_path`,`mpc_fulfilment_networks`.`product_create_path` AS `product_create_path`,`mpc_fulfilment_networks`.`product_update_path` AS `product_update_path`,`mpc_fulfilment_networks`.`fetch_stock_path` AS `fetch_stock_path`,`mpc_fulfilment_networks`.`order_status_update_path` AS `order_status_update_path`,`mpc_fulfilment_networks`.`order_cancel_path` AS `order_cancel_path`,`mpc_fulfilment_networks`.`order_item_cancel_path` AS `order_item_cancel_path`,`mpc_fulfilment_networks`.`consignment_path` AS `consignment_path`,`mpc_fulfilment_networks`.`created_at` AS `created_at`,`mpc_fulfilment_networks`.`updated_at` AS `updated_at`,`mpc_fulfilment_networks`.`name` AS `name`,`mpc_fulfilment_networks`.`update_invoice_path` AS `update_invoice_path`,`mpc_fulfilment_networks`.`update_manifest_path` AS `update_manifest_path`,`mpc_fulfilment_networks`.`update_tracking_number_path` AS `update_tracking_number_path`,`mpc_fulfilment_networks`.`fetch_merchant_path` AS `fetch_merchant_path`,`mpc_fulfilment_networks`.`create_merchant_path` AS `create_merchant_path`,`mpc_fulfilment_networks`.`fetch_product_path` AS `fetch_product_path`,`mpc_fulfilment_networks`.`authorize_ewms_connection_path` AS `authorize_ewms_connection_path`,`mpc_fulfilment_networks`.`ts_ver` AS `ts_ver` from `mpc_fulfilment_networks` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_fulfilment_order_states`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_fulfilment_order_states`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_fulfilment_order_states`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_fulfilment_order_states` AS select `mpc_fulfilment_order_states`.`id` AS `id`,`mpc_fulfilment_order_states`.`name` AS `name`,`mpc_fulfilment_order_states`.`code` AS `code`,`mpc_fulfilment_order_states`.`created_at` AS `created_at`,`mpc_fulfilment_order_states`.`updated_at` AS `updated_at`,`mpc_fulfilment_order_states`.`ts_ver` AS `ts_ver` from `mpc_fulfilment_order_states` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_fulfilment_types`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_fulfilment_types`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_fulfilment_types`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_fulfilment_types` AS select `mpc_fulfilment_types`.`id` AS `id`,`mpc_fulfilment_types`.`name` AS `name`,`mpc_fulfilment_types`.`presentation` AS `presentation`,`mpc_fulfilment_types`.`created_at` AS `created_at`,`mpc_fulfilment_types`.`updated_at` AS `updated_at`,`mpc_fulfilment_types`.`ts_ver` AS `ts_ver` from `mpc_fulfilment_types` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_languages`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_languages`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_languages`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_languages` AS select `mpc_languages`.`id` AS `id`,`mpc_languages`.`name` AS `name`,`mpc_languages`.`presentation` AS `presentation`,`mpc_languages`.`active` AS `active`,`mpc_languages`.`created_at` AS `created_at`,`mpc_languages`.`updated_at` AS `updated_at`,`mpc_languages`.`code` AS `code`,`mpc_languages`.`ts_ver` AS `ts_ver` from `mpc_languages` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_map_taxons`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_map_taxons`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_map_taxons`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_map_taxons` AS select `mpc_map_taxons`.`id` AS `id`,`mpc_map_taxons`.`taxon_id` AS `taxon_id`,`mpc_map_taxons`.`base_category_id` AS `base_category_id`,`mpc_map_taxons`.`seller_id` AS `seller_id`,`mpc_map_taxons`.`status` AS `status`,`mpc_map_taxons`.`ts_ver` AS `ts_ver` from `mpc_map_taxons` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_marketplace_keys`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_marketplace_keys`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_marketplace_keys`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_marketplace_keys` AS select `mpc_marketplace_keys`.`id` AS `id`,`mpc_marketplace_keys`.`name` AS `name`,`mpc_marketplace_keys`.`presenation` AS `presenation`,`mpc_marketplace_keys`.`marketplace_id` AS `marketplace_id`,`mpc_marketplace_keys`.`sequence` AS `sequence`,`mpc_marketplace_keys`.`input_required` AS `input_required`,`mpc_marketplace_keys`.`visible_on_ui` AS `visible_on_ui`,`mpc_marketplace_keys`.`help_text` AS `help_text`,`mpc_marketplace_keys`.`ts_ver` AS `ts_ver` from `mpc_marketplace_keys` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_marketplace_setting_fields`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_marketplace_setting_fields`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_marketplace_setting_fields`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_marketplace_setting_fields` AS select `mpc_marketplace_setting_fields`.`id` AS `id`,`mpc_marketplace_setting_fields`.`marketplace_id` AS`marketplace_id`,`mpc_marketplace_setting_fields`.`field_type` AS `field_type`,`mpc_marketplace_setting_fields`.`data_type` AS `data_type`,`mpc_marketplace_setting_fields`.`mandatory` AS `mandatory`,`mpc_marketplace_setting_fields`.`field_name` AS `field_name`,`mpc_marketplace_setting_fields`.`field_code` AS `field_code`,`mpc_marketplace_setting_fields`.`created_at` AS `created_at`,`mpc_marketplace_setting_fields`.`updated_at` AS `updated_at`,`mpc_marketplace_setting_fields`.`position` AS `position`,`mpc_marketplace_setting_fields`.`visible_on_ui` AS `visible_on_ui`,`mpc_marketplace_setting_fields`.`ts_ver` AS `ts_ver` from`mpc_marketplace_setting_fields` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_marketplaces`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_marketplaces`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_marketplaces`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_marketplaces` AS select `mpc_marketplaces`.`id` AS `id`,`mpc_marketplaces`.`name` AS `name`,`mpc_marketplaces`.`code` AS `code`,`mpc_marketplaces`.`domain_url` AS `domain_url`,`mpc_marketplaces`.`country_id` AS `country_id`,`mpc_marketplaces`.`currency_id` AS `currency_id`,`mpc_marketplaces`.`active` AS `active`,`mpc_marketplaces`.`created_at` AS `created_at`,`mpc_marketplaces`.`updated_at` AS `updated_at`,`mpc_marketplaces`.`registration_domain` AS `registration_domain`,`mpc_marketplaces`.`activation_date` AS `activation_date`,`mpc_marketplaces`.`is_prefered` AS `is_prefered`,`mpc_marketplaces`.`is_webstore` AS `is_webstore`,`mpc_marketplaces`.`help_link` AS `help_link`,`mpc_marketplaces`.`onboarding_position` AS `onboarding_position`,`mpc_marketplaces`.`is_deleted` AS `is_deleted`,`mpc_marketplaces`.`support_ss_category` AS `support_ss_category`,`mpc_marketplaces`.`seller_tag` AS `seller_tag`,`mpc_marketplaces`.`lock_stock_update` AS `lock_stock_update`,`mpc_marketplaces`.`ts_ver` AS `ts_ver`,`mpc_marketplaces`.`is_global_marketplace` AS `is_global_marketplace` from`mpc_marketplaces` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_marketplaces_operations`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_marketplaces_operations`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_marketplaces_operations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_marketplaces_operations` AS select `mpc_marketplaces_operations`.`marketplace_id` AS `marketplace_id`,`mpc_marketplaces_operations`.`operation_id` AS `operation_id`,`mpc_marketplaces_operations`.`ts_ver` AS `ts_ver` from `mpc_marketplaces_operations` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_masters`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_masters`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_masters`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_masters` AS select `mpc_masters`.`id` AS `id`,`mpc_masters`.`critical_limit` AS `critical_limit`,`mpc_masters`.`created_at` AS `created_at`,`mpc_masters`.`updated_at` AS `updated_at`,`mpc_masters`.`ts_ver` AS `ts_ver` from `mpc_masters` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_notifications`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_notifications`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_notifications`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_notifications` AS select `mpc_notifications`.`id` AS `id`,`mpc_notifications`.`event_type` AS `event_type`,`mpc_notifications`.`notification_channel` AS `notification_channel`,`mpc_notifications`.`event` AS `event`,`mpc_notifications`.`level` AS `level`,`mpc_notifications`.`template` AS `template`,`mpc_notifications`.`action` AS `action`,`mpc_notifications`.`created_at` AS `created_at`,`mpc_notifications`.`updated_at` AS `updated_at`,`mpc_notifications`.`new_action` AS `new_action`,`mpc_notifications`.`ts_ver` AS `ts_ver` from `mpc_notifications` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_notify_subscribe_users`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_notify_subscribe_users`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_notify_subscribe_users`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_notify_subscribe_users` AS select `mpc_notify_subscribe_users`.`id` AS `id`,`mpc_notify_subscribe_users`.`marketplace_id` AS `marketplace_id`,`mpc_notify_subscribe_users`.`email` AS `email`,`mpc_notify_subscribe_users`.`created_at` AS `created_at`,`mpc_notify_subscribe_users`.`updated_at` AS `updated_at`,`mpc_notify_subscribe_users`.`ts_ver` AS `ts_ver` from `mpc_notify_subscribe_users` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_onboard_details`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_onboard_details`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_onboard_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_onboard_details` AS select `mpc_onboard_details`.`id` AS `id`,`mpc_onboard_details`.`country_id` AS `country_id`,`mpc_onboard_details`.`call_url` AS `call_url`,`mpc_onboard_details`.`phone_number` AS `phone_number`,`mpc_onboard_details`.`email` AS `email`,`mpc_onboard_details`.`created_at` AS `created_at`,`mpc_onboard_details`.`updated_at` AS `updated_at`,`mpc_onboard_details`.`ts_ver` AS `ts_ver` from `mpc_onboard_details` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_order_failure_reasons`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_order_failure_reasons`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_order_failure_reasons`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_order_failure_reasons` AS select `mpc_order_failure_reasons`.`id` AS `id`,`mpc_order_failure_reasons`.`reason_code` AS `reason_code`,`mpc_order_failure_reasons`.`reason` AS `reason`,`mpc_order_failure_reasons`.`type` AS `type`,`mpc_order_failure_reasons`.`marketplace_id` AS `marketplace_id`,`mpc_order_failure_reasons`.`created_at` AS `created_at`,`mpc_order_failure_reasons`.`updated_at` AS `updated_at`,`mpc_order_failure_reasons`.`ts_ver` AS `ts_ver` from `mpc_order_failure_reasons` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_payment_merchants`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_payment_merchants`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_payment_merchants`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_payment_merchants` AS select `mpc_payment_merchants`.`id` AS `id`,`mpc_payment_merchants`.`merchant_id` AS `merchant_id`,`mpc_payment_merchants`.`mpc_country_id` AS `mpc_country_id`,`mpc_payment_merchants`.`created_at` AS `created_at`,`mpc_payment_merchants`.`updated_at` AS `updated_at`,`mpc_payment_merchants`.`active` AS `active`,`mpc_payment_merchants`.`ts_ver` AS `ts_ver` from `mpc_payment_merchants` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_promocode_marketplaces`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_promocode_marketplaces`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_promocode_marketplaces`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_promocode_marketplaces` AS select `mpc_promocode_marketplaces`.`id` AS `id`,`mpc_promocode_marketplaces`.`promocode_id` AS `promocode_id`,`mpc_promocode_marketplaces`.`marketplace_id` AS `marketplace_id`,`mpc_promocode_marketplaces`.`created_at` AS `created_at`,`mpc_promocode_marketplaces`.`updated_at` AS `updated_at`,`mpc_promocode_marketplaces`.`ts_ver` AS `ts_ver` from `mpc_promocode_marketplaces` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_promocode_plans`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_promocode_plans`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_promocode_plans`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_promocode_plans` AS select `mpc_promocode_plans`.`id` AS `id`,`mpc_promocode_plans`.`promocode_id` AS `promocode_id`,`mpc_promocode_plans`.`subscription_id` AS `subscription_id`,`mpc_promocode_plans`.`created_at` AS `created_at`,`mpc_promocode_plans`.`updated_at` AS `updated_at`,`mpc_promocode_plans`.`ts_ver` AS `ts_ver` from `mpc_promocode_plans` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_promotion_closing_rules`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_promotion_closing_rules`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_promotion_closing_rules`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_promotion_closing_rules` AS select `mpc_promotion_closing_rules`.`id` AS `id`,`mpc_promotion_closing_rules`.`name` AS `name`,`mpc_promotion_closing_rules`.`default` AS `default`,`mpc_promotion_closing_rules`.`active` AS `active`,`mpc_promotion_closing_rules`.`created_at` AS `created_at`,`mpc_promotion_closing_rules`.`updated_at` AS `updated_at`,`mpc_promotion_closing_rules`.`code` AS `code`,`mpc_promotion_closing_rules`.`ts_ver` AS `ts_ver` from `mpc_promotion_closing_rules` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_promotion_closing_rules_types`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_promotion_closing_rules_types`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_promotion_closing_rules_types`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_promotion_closing_rules_types` AS select `mpc_promotion_closing_rules_types`.`promotion_type_id` AS `promotion_type_id`,`mpc_promotion_closing_rules_types`.`promotion_closing_rule_id` AS `promotion_closing_rule_id`,`mpc_promotion_closing_rules_types`.`created_at` AS `created_at`,`mpc_promotion_closing_rules_types`.`updated_at` AS `updated_at`,`mpc_promotion_closing_rules_types`.`ts_ver` AS `ts_ver` from `mpc_promotion_closing_rules_types` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_promotion_rules`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_promotion_rules`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_promotion_rules`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_promotion_rules` AS select `mpc_promotion_rules`.`id` AS `id`,`mpc_promotion_rules`.`name` AS `name`,`mpc_promotion_rules`.`default` AS `default`,`mpc_promotion_rules`.`active` AS `active`,`mpc_promotion_rules`.`created_at` AS `created_at`,`mpc_promotion_rules`.`updated_at` AS `updated_at`,`mpc_promotion_rules`.`code` AS `code`,`mpc_promotion_rules`.`ts_ver` AS `ts_ver` from `mpc_promotion_rules` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_reports`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_reports`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_reports`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_reports` AS select `mpc_reports`.`id` AS `id`,`mpc_reports`.`name` AS `name`,`mpc_reports`.`code` AS `code`,`mpc_reports`.`active` AS `active`,`mpc_reports`.`date_range_required` AS `date_range_required`,`mpc_reports`.`created_at` AS `created_at`,`mpc_reports`.`updated_at` AS `updated_at`,`mpc_reports`.`report_type` AS `report_type`,`mpc_reports`.`report_model` AS `report_model`,`mpc_reports`.`ts_ver` AS `ts_ver`,`mpc_reports`.`is_master_account` AS `is_master_account` from `mpc_reports` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_roles`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_roles`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_roles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_roles` AS select `mpc_roles`.`id` AS `id`,`mpc_roles`.`name` AS `name`,`mpc_roles`.`created_at` AS `created_at`,`mpc_roles`.`updated_at`AS `updated_at`,`mpc_roles`.`presentation` AS `presentation`,`mpc_roles`.`platform_user` AS `platform_user`,`mpc_roles`.`role_type` AS `role_type`,`mpc_roles`.`ts_ver` AS `ts_ver` from `mpc_roles` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_seller_types`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_seller_types`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_seller_types`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_seller_types` AS select `mpc_seller_types`.`id` AS `id`,`mpc_seller_types`.`name` AS `name`,`mpc_seller_types`.`code` AS `code`,`mpc_seller_types`.`presentation` AS `presentation`,`mpc_seller_types`.`created_at` AS `created_at`,`mpc_seller_types`.`updated_at` AS `updated_at`,`mpc_seller_types`.`ts_ver` AS `ts_ver` from `mpc_seller_types` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_setup_details`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_setup_details`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_setup_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_setup_details` AS select `mpc_setup_details`.`id` AS `id`,`mpc_setup_details`.`instruction` AS `instruction`,`mpc_setup_details`.`attachable_id` AS `attachable_id`,`mpc_setup_details`.`attachable_type` AS `attachable_type`,`mpc_setup_details`.`created_at` AS `created_at`,`mpc_setup_details`.`updated_at` AS `updated_at`,`mpc_setup_details`.`ts_ver` AS `ts_ver` from `mpc_setup_details` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_shipping_types`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_shipping_types`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_shipping_types`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_shipping_types` AS select `mpc_shipping_types`.`id` AS `id`,`mpc_shipping_types`.`name` AS `name`,`mpc_shipping_types`.`presentation` AS`presentation`,`mpc_shipping_types`.`created_at` AS `created_at`,`mpc_shipping_types`.`updated_at` AS `updated_at`,`mpc_shipping_types`.`ts_ver` AS `ts_ver` from `mpc_shipping_types` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_states`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_states`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_states`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_states` AS select `mpc_states`.`id` AS `id`,`mpc_states`.`name` AS `name`,`mpc_states`.`abbr` AS `abbr`,`mpc_states`.`country_id` AS `country_id`,`mpc_states`.`created_at` AS `created_at`,`mpc_states`.`updated_at` AS `updated_at`,`mpc_states`.`ts_ver` AS `ts_ver` from `mpc_states` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_subscriptions`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_subscriptions`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_subscriptions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_subscriptions` AS select `mpc_subscriptions`.`id` AS `id`,`mpc_subscriptions`.`name` AS `name`,`mpc_subscriptions`.`price` AS `price`,`mpc_subscriptions`.`no_of_orders` AS `no_of_orders`,`mpc_subscriptions`.`description` AS `description`,`mpc_subscriptions`.`country` AS `country`,`mpc_subscriptions`.`active` AS `active`,`mpc_subscriptions`.`created_at` AS `created_at`,`mpc_subscriptions`.`updated_at` AS `updated_at`,`mpc_subscriptions`.`permalink` AS `permalink`,`mpc_subscriptions`.`subscription_type` AS `subscription_type`,`mpc_subscriptions`.`valid_for` AS `valid_for`,`mpc_subscriptions`.`related_id` AS `related_id`,`mpc_subscriptions`.`braintree_subscription_id` AS `braintree_subscription_id`,`mpc_subscriptions`.`plan_id` AS `plan_id`,`mpc_subscriptions`.`plan_type` AS `plan_type`,`mpc_subscriptions`.`payment_frequency` AS `payment_frequency`,`mpc_subscriptions`.`usual_price` AS `usual_price`,`mpc_subscriptions`.`account_type_id` AS `account_type_id`,`mpc_subscriptions`.`buyable` AS `buyable`,`mpc_subscriptions`.`threshold` AS `threshold`,`mpc_subscriptions`.`ts_ver` AS `ts_ver`,`mpc_subscriptions`.`gst_in_percent` AS `gst_in_percent` from `mpc_subscriptions` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_taxonomies`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_taxonomies`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_taxonomies`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_taxonomies` AS select `mpc_taxonomies`.`id` AS `id`,`mpc_taxonomies`.`name` AS `name`,`mpc_taxonomies`.`presentation` AS `presentation`,`mpc_taxonomies`.`metakeywords` AS `metakeywords`,`mpc_taxonomies`.`created_at` AS `created_at`,`mpc_taxonomies`.`updated_at` AS `updated_at`,`mpc_taxonomies`.`marketplace_id` AS `marketplace_id`,`mpc_taxonomies`.`marketplace_type` AS `marketplace_type`,`mpc_taxonomies`.`ts_ver` AS `ts_ver` from `mpc_taxonomies` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_mpc_taxons`
--

/*!50001 DROP TABLE IF EXISTS `v_mpc_taxons`*/;
/*!50001 DROP VIEW IF EXISTS `v_mpc_taxons`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_mpc_taxons` AS select `mpc_taxons`.`id` AS `id`,`mpc_taxons`.`name` AS `name`,`mpc_taxons`.`presentation` AS `presentation`,`mpc_taxons`.`parent_id` AS `parent_id`,`mpc_taxons`.`position` AS `position`,`mpc_taxons`.`taxonomy_id` AS `taxonomy_id`,`mpc_taxons`.`lft` AS `lft`,`mpc_taxons`.`rgt` AS `rgt`,`mpc_taxons`.`created_at` AS `created_at`,`mpc_taxons`.`updated_at` AS `updated_at`,`mpc_taxons`.`code` AS `code`,`mpc_taxons`.`permalink` AS `permalink`,`mpc_taxons`.`display_name` AS `display_name`,`mpc_taxons`.`base_category_id` AS `base_category_id`,`mpc_taxons`.`active` AS `active`,`mpc_taxons`.`variation`AS `variation` from `mpc_taxons` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_schema_migrations`
--

/*!50001 DROP TABLE IF EXISTS `v_schema_migrations`*/;
/*!50001 DROP VIEW IF EXISTS `v_schema_migrations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_schema_migrations` AS select `schema_migrations`.`version` AS `version`,`schema_migrations`.`ts_ver` AS `ts_ver` from `schema_migrations` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-05 11:03:28
