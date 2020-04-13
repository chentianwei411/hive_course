hive -e "
sqoop export \
--connect
jdbc:mysql://106.13.128.83:3306/adventure_ods?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull&tinyInt1isBit=false&dontTrackOpenResources=true&defaultFetchSize=50000&useCursorFetch=true" \
--username root \
--password FrogMysql@123 \
--table dw_customer_order\
--export-dir /user/hive /ods.db /dw_customer_order \
--columns create_date ,product_name ,cpzl_zw ,cplb_zw ,order_num ,sum_amount ,is_current_year ,is_last_year,is_yesterday,is_today,is_current_month,is_current_quarter  ,chinese_province , chinese_city ,chinese_province_citychinese_territory \
--fields-terminated-by '\t' \
"

