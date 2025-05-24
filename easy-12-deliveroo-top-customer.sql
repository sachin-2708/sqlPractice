-- You are provided with data from a food delivery service called Deliveroo. Each order has details about the delivery time, the rating given by the customer, and the total cost of the order. 
-- Write an SQL to find customer with highest total expenditure. Display customer id and total expense by him/her.
/*
Tables: orders
+---------------+-----------+
| COLUMN_NAME   | DATA_TYPE |
+---------------+-----------+
| customer_id   | int       |
| delivery_time | int       |
| order_id      | int       |
| restaurant_id | int       |
| total_cost    | int       |
+---------------+-----------+
*/

SELECT customer_id,
	sum(total_cost) AS total_expense 
FROM orders
GROUP BY customer_id
ORDER BY total_expense DESC
LIMIT 1;
