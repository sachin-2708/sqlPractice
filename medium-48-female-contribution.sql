-- You are given a history of credit card transaction data for the people of India across cities. Write an SQL to find percentage contribution of spends by females in each city.  
-- Round the percentage to 2 decimal places. Display city, total spend , female spend and female contribution in ascending order of city.

/*Table: credit_card_transactions
+------------------+-------------+
| COLUMN_NAME      | DATA_TYPE   |
+------------------+-------------+
| amount           | int         |
| card_type        | varchar(10) |
| city             | varchar(10) |
| gender           | varchar(1)  |
| transaction_date | date        |
| transaction_id   | int         |
+------------------+-------------+
*/

WITH gender_spending AS
(SELECT city, sum(amount) AS total_spend,
SUM(CASE WHEN gender = 'F' THEN amount ELSE 0 END) AS female_spend,
SUM(CASE WHEN gender = 'M' THEN amount ELSE 0 END) AS male_spend
FROM credit_card_transactions
GROUP BY city)

SELECT city, total_spend,
female_spend, 
ROUND(100.0*(female_spend/total_spend),2) AS female_contribution
FROM gender_spending
ORDER BY city
