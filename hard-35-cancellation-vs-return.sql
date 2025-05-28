-- You are given an orders table containing data about orders placed on an e-commerce website, with information on order date, delivery date, and cancel date. The task is to calculate both the cancellation rate and the return rate for each month based on the order date.
-- Definitions:
-- An order is considered cancelled if it is cancelled before delivery (i.e., cancel_date is not null, and delivery_date is null). If an order is cancelled, no delivery will take place.
-- An order is considered a return if it is cancelled after it has already been delivered (i.e., cancel_date is not null, and cancel_date > delivery_date).
-- Metrics to Calculate:
-- Cancel Rate = (Number of orders cancelled / Number of orders placed but not returned) * 100
-- Return Rate = (Number of orders returned / Number of orders placed but not cancelled) * 100
-- Write an SQL query to calculate the cancellation rate and return rate for each month (based on the order_date).Round the rates to 2 decimal places. Sort the output by year and month in increasing order.
 
-- Table: orders 
/*
+---------------+-----------+
| COLUMN_NAME   | DATA_TYPE |
+---------------+-----------+
| order_id      | int       |
| order_date    | date      |
| customer_id   | int       |
| delivery_date | date      |
| cancel_date   | date      |
+---------------+-----------+
*/

WITH cte AS (
  SELECT YEAR(order_date) AS order_year, MONTH(order_date) AS order_month,
COUNT(*) AS total_orders,
SUM(CASE WHEN cancel_date IS NOT NULL AND delivery_date IS NULL THEN 1 ELSE 0 END) AS cancelled_order,
SUM(CASE WHEN cancel_date IS NOT NULL AND cancel_date > delivery_date THEN 1 ELSE 0 END) AS returned_order
FROM orders
GROUP BY by 1,2)

SELECT order_year, order_month, ROUND(100.0*cancelled_order/(total_orders-returned_order),2) AS cancellation_rate,
ROUND(100.0*returned_order/(total_orders-cancelled_order),2) AS return_rate
FROM cte;
