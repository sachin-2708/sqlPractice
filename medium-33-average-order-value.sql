-- Write an SQL query to determine the transaction date with the lowest average order value (AOV) among all dates recorded in the transaction table. Display the transaction date, its corresponding AOV, and the difference between the AOV for that date and the highest AOV for any day in the dataset. Round the result to 2 decimal places.

-- Table: transactions 
/*
+--------------------+--------------+
| COLUMN_NAME        | DATA_TYPE    |
+--------------------+--------------+
| order_id           | int          |
| transaction_amount | decimal(5,2) |
| transaction_date   | date         |
| user_id            | int          |
+--------------------+--------------+
*/

WITH cte AS(
SELECT transaction_date, AVG(transaction_amount) AS average,
ROW_NUMBER() OVER(ORDER BY AVG(transaction_amount)) AS rnk,
MAX(AVG(transaction_amount)) OVER() AS maximum
FROM transactions
GROUP BY transaction_date
)

SELECT transaction_date, ROUND(average,2) AS aov, ROUND(maximum-average,2) AS diff_from_highest_aov
FROM cte
WHERE rnk=1
