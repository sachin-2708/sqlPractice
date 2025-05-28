-- Suppose you are a data analyst working for Zomato (a online food delivery company) . Zomato is interested in analysing customer food ordering behavior and wants to identify customers who have exhibited inconsistent patterns over time.
-- Your task is to write an SQL query to identify customers who have placed orders on both weekdays and weekends, but with a significant difference in the average order amount between weekdays and weekends. Specifically, you need to identify customers who have a minimum of 3 orders placed both on weekdays and weekends each, and where the average order amount on weekends is at least 20% higher than the average order amount on weekdays.
-- Your query should return the customer id, the average order amount on weekends, the average order amount on weekdays, and the percentage difference in average order amount between weekends and weekdays for each customer meeting the criteria.
/*
Table: orders
+--------------+---------------+
| COLUMN_NAME  | DATA_TYPE     |
+--------------+---------------+
| order_id     | int           |
| customer_id  | int           |
| order_amount | decimal(10,2) |
| order_date   | date          |
+--------------+---------------+*/

WITH dow_cte AS(
  SELECT customer_id, order_amount, 
  CASE WHEN (DAYOFWEEK(order_date) IN (1,7)) THEN 'weekend'
  ELSE 'weekday' END AS dow
  FROM orders
  ),
dow_cal AS (
SELECT customer_id, 
SUM(CASE WHEN dow = 'weekend' THEN 1 ELSE 0 END) AS weekend_orders,
SUM(CASE WHEN dow = 'weekday' THEN 1 ELSE 0 END) AS weekday_orders,
AVG(CASE WHEN dow = 'weekend' THEN order_amount END) AS weekend_avg_amount,
AVG(CASE WHEN dow = 'weekday' THEN order_amount END) AS weekday_avg_amount
FROM dow_cte
GROUP BY customer_id
)
SELECT customer_id, weekend_avg_amount, weekday_avg_amount,
100.0*(weekend_avg_amount/weekday_avg_amount-1) AS percent_diff
FROM dow_cal
WHERE weekend_orders >= 3 AND weekday_orders >= 3
AND weekend_avg_amount >= (0.2*weekday_avg_amount) + weekday_avg_amount
