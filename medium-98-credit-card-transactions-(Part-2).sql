-- You are given a history of credit card transaction data for the people of India across cities as below.
-- Your task is to find out highest spend card type and lowest spent card type for each city, display the output in ascending order of city.
/*
Table: credit_card_transactions
+------------------+-------------+
| COLUMN_NAME      | DATA_TYPE   |
+------------------+-------------+
| transaction_id   | int         |
| city             | varchar(10) |
| transaction_date | date        |
| card_type        | varchar(12) |
| gender           | varchar(1)  |
| amount           | int         |
+------------------+-------------+
*/

with cte as
(select city, card_type, 
rank()over(partition by city order by sum(amount) desc) as high_rnk,
rank()over(partition by city order by sum(amount)) as low_rnk
from credit_card_transactions
group by city, card_type)

select city,
max(case when high_rnk = 1 then card_type else 0 end) as 'highest_expense_type',
max(case when low_rnk = 1 then card_type else 0 end) as 'lowest_expense_type'
from cte
group by city
