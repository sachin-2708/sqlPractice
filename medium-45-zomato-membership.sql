-- Zomato is planning to offer a premium membership to customers who have placed multiple orders in a single day.
--Your task is to write a SQL to find those customers who have placed multiple orders in a single day at least once , total order value generate by those customers and order value generated only by those orders, display the results in ascending order of total order value.
-- Table: orders (primary key : order_id)
/*+---------------+-------------+
| COLUMN_NAME   | DATA_TYPE   |
+---------------+-------------+
| customer_name | varchar(20) |
| order_date    | datetime    |
| order_id      | int         |
| order_value   | int         |
+---------------+-------------+
*/

WITH cte1 AS(
SELECT customer_name, sum(total_order_value) AS total_order_value
FROM
(SELECT customer_name, DATE(order_date) AS o_date, SUM(order_value) AS total_order_value
FROM orders
GROUP BY customer_name, DATE(order_date)
HAVING COUNT(*)>1)A
GROUP BY customer_name)
,
cte2 AS(
SELECT customer_name, sum(order_value) as order_value
FROM orders
GROUP BY customer_name
)

SELECT c1.customer_name, c2.order_value, c1.total_order_value 
FROM cte1 c1
JOIN cte2 c2 ON c1.customer_name  = c2.customer_name 
ORDER BY c1.total_order_value
