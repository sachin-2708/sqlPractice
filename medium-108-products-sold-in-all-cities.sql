-- A technology company operates in several major cities across India, selling a variety of tech products. The company wants to analyze its sales data to understand which products have been successfully sold in all the cities where they operate(available in cities table).
-- Write an SQL query to identify the product names that have been sold at least 2 times in every city where the company operates.
/*
Table: products
+-------------+------------+
| COLUMN_NAME | DATA_TYPE  |
+-------------+------------+
| product_id  | int        |
| product_name| VARCHAR(12)|
+-------------+------------+
Table: cities
+-------------+------------+
| COLUMN_NAME | DATA_TYPE  |
+-------------+------------+
| city_id     | int        |
| city_name   | VARCHAR(10)|
+-------------+------------+
Table: sales
+-------------+------------+
| COLUMN_NAME | DATA_TYPE  |
+-------------+------------+
| sale_id     | int        |
| product_id  | int        |
| city_id     | int        |
| sale_date   | VARCHAR(12)|
| quantity    | int        |
+-------------+------------+
*/

with cte as
(select city_id, product_id
from sales
group by city_id, product_id
having count(*) >= 2)

select p.product_name
from cte c
join products p on c.product_id = p.product_id
group by p.product_name
having count(distinct c.city_id) = (select count(*) from cities)

-- Alternate Solution

with cte as
(select city_id, product_id
from sales
group by city_id, product_id
having count(*) >= 2)
, cte2 as
(select product_id, count(distinct city_id) as city_count
from cte
group by product_id)

select p.product_name
from cte2 c
join products p on c.product_id = p.product_id
where city_count = (select count(*) from cities)
order by product_name
