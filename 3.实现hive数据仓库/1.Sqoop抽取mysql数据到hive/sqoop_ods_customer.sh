# adventure_ods.ods_sales_order表导入

hive -e "truncate table ods.ods_customer"
sqoop import \
--hive-import \
--connect "jdbc:mysql://106.15.121.232:3306/adventure_ods?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull&tinyInt1isBit=false&dontTrackOpenResources=true&defaultFetchSize=50000&useCursorFetch=true" \
--driver com.mysql.jdbc.Driver \
--username frogdata05 \
--password FrogMysql123 \
--query \
"select * from ods_customer where "'$CONDITIONS'" " \
--fetch-size 50000 \
--hive-table ods.ods_customer \
--hive-drop-import-delims \
--delete-target-dir \
--target-dir /user/hadoop/sqoop/ods_customer \
-m 1
