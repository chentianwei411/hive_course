CREATE TABLE `dw_customer_order` 
(
   `create_date` date DEFAULT NULL,
  
    `product_name` text COLLATE utf8_unicode_ci,
  
    `cpzl_zw` text COLLATE utf8_unicode_ci,
  
 `cplb_zw` text COLLATE utf8_unicode_ci,
  
 `order_num` bigint(20) DEFAULT NULL,
  
 `customer_num` bigint(20) DEFAULT NULL,
  
 `sum_amount` double DEFAULT NULL,
   `is_current_year` text COLLATE utf8_unicode_ci,
   `is_last_year` text COLLATE utf8_unicode_ci,
   `is_yesterday` text COLLATE utf8_unicode_ci,
   `is_today` text COLLATE utf8_unicode_ci,
   `is_current_month` text COLLATE utf8_unicode_ci,
   `is_current_quarter` text COLLATE utf8_unicode_ci,
   `chinese_province` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
   `chinese_city` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
   `chinese_territory` varchar(100) CHARACTER SET utf8 DEFAULT NULL
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci