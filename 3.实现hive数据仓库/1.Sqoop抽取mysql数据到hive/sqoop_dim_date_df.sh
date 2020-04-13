# adventure_ods.ods_sales_order表导入

hive -e "drop table if exists ods.dim_date_df"
sqoop import \
--hive-import \
--connect "jdbc:mysql://106.15.121.232:3306/adventure_ods?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull&tinyInt1isBit=false&dontTrackOpenResources=true&defaultFetchSize=50000&useCursorFetch=true" \
--driver com.mysql.jdbc.Driver \
--username frogdata05 \
--password FrogMysql123 \
--query \
"select * from dim_date_df where "'$CONDITIONS'" " \
--fetch-size 50000 \
--hive-table ods.dim_date_df \
--hive-drop-import-delims \
--delete-target-dir \
--target-dir /user/hadoop/sqoop/dim_date_df \
-m 1
