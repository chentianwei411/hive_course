CREATE TABLE `dw_amount_diff` (
   `today_diff` double DEFAULT NULL,
   `yesterday_diff` double DEFAULT NULL,
   `month_diff` double DEFAULT NULL,
   `quarter_diff` double DEFAULT NULL,
   `year_diff` double DEFAULT NULL,
   `flag` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci