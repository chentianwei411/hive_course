hive -e "drop table if exists ods.dw_amount_diff"
hive -e"
CREATE TABLE ods.dw_amount_diff(
  d_amount   double,
  d_order    double,
  d_avg      double
  )
"
hive -e "
insert into ods.dw_amount_diff
	select 
	a.d_amount,
	a.d_order,
	a.d_avg
	from(
    select
	((sum(a.sum_amount) / sum(b.sum_amount)) -1) as d_amount,
	((sum(a.order_count) / sum(b.order_count)) -1) as d_order,
	((sum(a.sum_amount) / sum(a.order_count))/ (sum(b.sum_amount) /sum(b.order_count)) -1) as d_avg
	from (select *,add_months(from_unixtime(unix_timestamp(create_date, 'yyyy-MM-dd'), 'yyyy-MM-dd'), -12) as before_lastyear_date
	from ods.dw_order_by_day
	where
	is_today =1 or
	is_yesterday =1 or
	is_current_month=1 or
	is_current_quarter=1)
	as a
	left join ods.dw_order_by_day as b
	on a.before_lastyear_date=b.create_date
	group by
	a.is_today,
	a.is_yesterday,
	a.is_current_month,
	a.is_current_quarter
	union all
	select
	((sum(a.sum_amount) / sum(b.sum_amount)) -1) as d_amount,
	((sum(a.order_count) / sum(b.order_count)) -1) as d_order,
	((sum(a.sum_amount) / sum(a.order_count))/ (sum(b.sum_amount) /sum(b.order_count)) -1) as d_avg
	from (select *,add_months(from_unixtime(unix_timestamp(create_date,'yyyy-MM-dd'), 'yyyy-MM-dd'), -12) as before_lastyear_date
	from ods.dw_order_by_day
	where is_current_year =1) as a
	left join ods.dw_order_by_day as b
	on a.before_lastyear_date=b.create_date
	) as a 
"
