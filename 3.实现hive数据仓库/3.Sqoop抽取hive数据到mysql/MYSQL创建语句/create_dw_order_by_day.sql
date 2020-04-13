CREATE TABLE `dw_order_by_day` (
   `create_date` date DEFAULT NULL,
   `sum_amount` double DEFAULT NULL,
   `sum_order` bigint(20) DEFAULT NULL,
   `amount_div_order` double DEFAULT NULL,
   `sum_amount_goal` double DEFAULT NULL,
   `sum_order_goal` double DEFAULT NULL,
   `is_current_year` int(11) DEFAULT NULL,
   `is_last_year` int(11) DEFAULT NULL,
   `is_yesterday` int(11) DEFAULT NULL,
   `is_today` int(11) DEFAULT NULL,
   `is_current_month` int(11) DEFAULT NULL,
   `is_current_quarter` int(11) DEFAULT NULL,
   `is_21_day` int(11) DEFAULT NULL,
   `amount_diff` double DEFAULT NULL
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci