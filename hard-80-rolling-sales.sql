-- You are tasked with analysing the sales data for products during the month of January 2024. Your goal is to calculate the rolling sum of sales for each product and each day of Jan 2024, considering the sales for the current day and the two previous days. Note that for some days, there might not be any sales for certain products, and you need to consider these days as having sales of 0.
-- You can make use of the calendar table which has the all the dates for Jan-2024.
/*
Tables: orders
+-------------+------------+
| COLUMN_NAME | DATA_TYPE  |
+-------------+------------+
| amount      | int        |
| order_date  | date       |
| order_id    | int        |
| product_id  | varchar(5) |
+-------------+------------+
Tables: calendar_dim
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| cal_date    | date      |
+-------------+-----------+
*/

with sales_cte as
(select 
 	product_id, 
 	order_date, 
 	sum(amount) as sales
from orders
group by product_id, order_date
order by product_id)

, all_product_dates as
(select 
 	distinct(o.product_id), 
 	cd.cal_date
from calendar_dim cd
cross join orders o
order by product_id, cd.cal_date)

select 
	a.product_id, 
	a.cal_date as order_date, 
	coalesce(s.sales,0) as sales, 
	sum(coalesce(s.sales,0))over(partition by c.product_id order by c.cal_date rows between 2 preceding and current row) as rolling3_sum
from all_product_dates a
left join sales_cte s 
	on s.product_id = a.product_id and s.order_date = a.cal_date
