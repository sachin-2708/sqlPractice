-- You are given a history of credit card transaction data for the people of India across cities . Write an SQL to find how many days each city took to reach cumulative spend of 1500 from its first day of transactions. 
-- Display city, first transaction date , date of 1500 spend and # of days in the ascending order of city.
/*
Table: credit_card_transactions
+------------------+-------------+
| COLUMN_NAME      | DATA_TYPE   |
+------------------+-------------+
| transaction_id   | int         |
| transaction_date | date        |
| amount           | int         |
| card_type        | varchar(12) |
| city             | varchar(20) |
| gender           | varchar(1)  |
+------------------+-------------+
*/

with cte as
(select city, 
min(transaction_date)over(partition by city) as first_transaction_date, transaction_date, 
sum(amount)over(partition by city order by transaction_date rows between unbounded preceding and current row) as total
from credit_card_transactions)
, cte2 as
(select city, min(first_transaction_date) as first_transaction_date,
min(case when total >= 1500 then transaction_date end) as tran_date_1500
from cte
group by city)

select city, first_transaction_date, tran_date_1500, datediff(tran_date_1500,first_transaction_date) as no_of_days
from cte2
order by city
