-- You are tasked with analyzing the sales growth of products over the years 2022, 2023, and 2024. Your goal is to identify months where the sales for a product have consistently increased from 2022 to 2023 and from 2023 to 2024.
-- Your task is to write an SQL query to generate a report that includes the sales for each product at the month level for the years 2022, 2023, and 2024. However, you should only include product and months combination where the sales have consistently increased from 2022 to 2023 and from 2023 to 2024, display the output in ascending order of product_id.
/*
Table: orders
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| order_id    | int       |
| customer_id | int       |
| order_date  | date      |
| product_id  | int       |
| sales       | int       |
+-------------+-----------+
*/

with cte as
(select product_id, month(order_date) as order_month, year(order_date) as order_year, sum(sales) as total_sales
from orders
group by product_id, month(order_date), year(order_date))
, cte1 as
(select product_id, order_month,
sum(case when order_year = '2022' then total_sales end) as sales_2022,
sum(case when order_year = '2023' then total_sales end) as sales_2023,
sum(case when order_year = '2024' then total_sales end) as sales_2024
from cte
group by product_id, order_month)

select product_id, order_month, sales_2022, sales_2023, sales_2024
from cte1
where sales_2024 > sales_2023 and sales_2023 > sales_2022
order by product_id
