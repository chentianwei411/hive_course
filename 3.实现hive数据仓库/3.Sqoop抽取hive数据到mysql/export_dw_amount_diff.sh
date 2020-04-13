sqoop export \
--connect "jdbc:mysql://106.13.128.83:3306/adventure_dw?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull&tinyInt1isBit=false&dontTrackOpenResources=true&defaultfetchSize=50000&useCursorfetch=true" \
--username root \
--password FrogMysql@123 \
--table dw_amount_diff \
--export-dir /user/hive/warehouse/ods.db/dw_amount_diff \
--columns  \
--fields-terminated-by '\001' \
