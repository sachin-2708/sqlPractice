-- You are tasked with analyzing the sales data of a Walmart chain with multiple stores across different locations.
-- The company wants to identify the highest and lowest sales months for each location for the year 2023 to gain insights into their sales patterns, display the output in ascending order of location. 
-- In case of a tie display the latest month.

--Table: stores
/*+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| store_id    | int         |
| store_name  | varchar(20) |
| location    | varchar(20) |
+-------------+-------------+
--Table: transactions 
+------------------+-----------+
| COLUMN_NAME      | DATA_TYPE |
+------------------+-----------+
| customer_id      | int       |
| store_id         | int       |
| amount           | int       |
| transaction_date | date      |
| transaction_id   | int       |
+------------------+-----------+ */

WITH cte1 AS(
SELECT s.location, MONTH(t.transaction_date) AS mnth, SUM(t.amount) AS total_sale
FROM transactions t
JOIN stores s on t.store_id = s.store_id
WHERE YEAR(t.transaction_date) = 2023
GROUP BY s.location, MONTH(t.transaction_date)
),
cte2 AS(
SELECT location, mnth, total_sale,
RANK()OVER(PARTITION BY location ORDER BY total_sale ASC, mnth DESC) AS low_sale_rank,
RANK()OVER(PARTITION BY location ORDER BY total_sale DESC, mnth DESC) AS high_sale_rank
FROM cte1)

SELECT location,
MAX(CASE WHEN high_sale_rank = 1 THEN mnth END) as highest_sales_month,
MAX(CASE WHEN low_sale_rank = 1 THEN mnth END) as lowest_sales_month
FROM cte2
GROUP BY location
ORDER BY location
