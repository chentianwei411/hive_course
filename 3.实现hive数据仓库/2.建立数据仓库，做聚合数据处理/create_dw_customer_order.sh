hive -e "drop table if exists ods.dw_customer_order"
hive -e "
CREATE TABLE ods.dw_customer_order(
  create_date string,
  product_name string,
  cpzl_zw string,
  cplb_zw string,
  order_num bigint,
  customer_num bigint,
  sum_amount double,
  is_current_year bigint,
  is_last_year bigint,
  is_yesterday bigint,
  is_today bigint,
  is_current_month bigint,
  is_current_quarter bigint,
  chinese_province string,
  chinese_city string,
  chinese_province_city string,
  chinese_territory string)
"
hive -e "
with dim_date as
(select create_date,
            is_current_year,
            is_last_year,
            is_yesterday,
            is_today,
            is_current_month,
            is_current_quarter
            from ods.dim_date_df),
sales_customer as (
select 
b.create_date,
b.chinese_province,
b.chinese_city ,
b.chinese_province_city ,
b.chinese_territory,
sum(a.unit_price) as sum_amount,
count(a.sales_order_key) as order_num,
count(a.customer_key) as customer_num ,
a.english_product_name,
a.cpzl_zw,
a.cplb_zw
from ods.ods_sales_orders as  a
join ods.ods_customer as b 
on a.customer_key=b.customer_key
group by b.create_date,
a.cpzl_zw,
a.cplb_zw,
a.english_product_name,
b.chinese_province,
b.chinese_city ,
b.chinese_province_city,
b.chinese_territory
)
insert into ods.dw_customer_order
	select b.create_date,
	b.is_current_year,
    b.is_last_year,
    b.is_yesterday,
    b.is_today,
    b.is_current_month,
    b.is_current_quarter,
	a.chinese_province,
	a.chinese_city ,
	a.chinese_province_city ,
	a.chinese_territory,
	a.sum_amount,
	a.customer_num,
	a.order_num, 
	a.english_product_name as product_name,
	a.cpzl_zw,
	a.cplb_zw
	from sales_customer as a 
	inner join dim_date as b
	on  a.create_date=b.create_date
"
