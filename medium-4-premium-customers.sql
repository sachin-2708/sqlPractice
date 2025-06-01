-- An e-commerce company want to start special reward program for their premium customers. 
-- The customers who have placed a greater number of orders than the average number of orders placed by customers are considered as premium customers.
-- Write an SQL to find the list of premium customers along with the number of orders placed by each of them, display the results in highest to lowest no of orders.

/*Table: orders (primary key : order_id)
+---------------+-------------+
| COLUMN_NAME   | DATA_TYPE   |
+---------------+-------------+
| order_id      | int         |
| order_date    | date        |
| customer_name | varchar(20) |
| sales         | int         |
+---------------+-------------+
*/


SELECT customer_name, COUNT(*) AS no_of_orders
FROM orders
GROUP BY customer_name
HAVING COUNT(*) > (SELECT COUNT(*)/COUNT(DISTINCT customer_name) FROM orders);

-- Alternate Solution

WITH cte AS(
SELECT customer_name, COUNT(*) AS total_orders,
AVG(count(*))OVER() AS avg_orders
FROM orders
GROUP BY customer_name)

SELECT customer_name, total_orders
FROM cte
WHERE total_orders > avg_orders

