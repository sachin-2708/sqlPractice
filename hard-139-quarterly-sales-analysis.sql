-- Given a sales dataset that records daily transactions for various products, write an SQL query to calculate last quarter's total sales and quarter-to-date (QTD) sales for each product, helping analyze past performance and current trends.
/*
Table: sales
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| id          | int      |
| product_id  | int      | 
| sale_date   | date     | 
| sale_amount | int      | 
+-------------+----------+
*/

with cte as
(select *,
case when extract(quarter from sale_date) = extract(quarter from current_date) then 'current_qtr'
when extract(quarter from sale_date) = extract(quarter from current_date)-1 then 'last_qtr'
else 'other' end as qtr
from sales
where year(sale_date) = year(current_date) or year(sale_date) = year(current_date)+1)

select product_id, sum(case when qtr =  'last_qtr' then sales_amount else 0 end) as last_quarter_sales,
sum(case when qtr =  'current_qtr' then sales_amount else 0 end) as qtd_sales
from cte
group by product_id
order by product_id

-- Alternate Solution

with qtd_start as
(select date_format(date_sub(curdate(),interval (month(curdate())-1)%3 month), '%Y-%m-01') as current_qtr_start)
, daterange as
(select current_qtr_start - interval 3 month as last_qtr_start, current_qtr_start - interval 1 day as last_qtr_end
from qtd_start)

select product_id,
sum(case when sale_date between (select last_qtr_start from daterange) and 
(select last_qtr_end from daterange) then sales_amount else 0 end) as last_quarter_sales,
sum(case when sale_date >= (select current_qtr_start from qtd_start) and sale_date <= curdate() then sales_amount else 0 end) as qtd_sales 
from sales
group by product_id
order by product_id
