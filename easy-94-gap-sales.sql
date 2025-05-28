-- You have a table called gap_sales. Write an SQL query to find the total sales for each category in each store for the Q2(April-June) of  2023. 
-- Return the store ID, category name, and total sales for each category in each store. Sort the result by total sales in ascending order.
-- Tables: gap_sales
/*
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| sale_id     | int         |
| store_id    | int         |
| sale_date   | date        |
| category    | varchar(10) |
| total_sales | int         |
+-------------+-------------+ */

SELECT store_id, category, SUM(total_sales) AS total_sales 
FROM gap_sales
WHERE sale_date BETWEEN '2023-04-01' AND '2023-06-30'
GROUP BY store_id, category
ORDER BY total_sales;
