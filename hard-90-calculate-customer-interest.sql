-- You are tasked with analyzing the interest earned by customers based on their account balances and transaction history. Each customer's account accrues interest based on their balance and prevailing interest rates. The interest is calculated for the ending balance on each day. Your goal is to determine the total interest earned by each customer for the month of March-2024. The interest rates (per day) are given in the interest table as per the balance amount range. 
-- Please assume that the account balance for each customer was 0 at the start of March 2024.  Write an SQL to calculate interest earned by each customer from March 1st 2024 to March 31st 2024, display the output in ascending order of customer id.
/*
Table: transactions
+------------------+-----------+
| COLUMN_NAME      | DATA_TYPE |
+------------------+-----------+
| transaction_id   | int       |
| customer_id      | int       |
| transaction_date | date      |
| amount           | int       |
+------------------+-----------+
Table: interestrates
+---------------+--------------+
| COLUMN_NAME   | DATA_TYPE    |
+---------------+--------------+
| rate_id       | int          |
| max_balance   | int          |
| min_balance   | int          |
| interest_rate | decimal(5,4) |
+---------------+--------------+
*/

with cte as
(select customer_id, transaction_date,
sum(sum(amount))over(partition by customer_id order by transaction_date) as net_amount 
from transactions
group by customer_id, transaction_date)
, cte2 as
(select *,
lead(transaction_date,1,'2024-04-01')over(partition by customer_id order by transaction_date) as next_transaction_date
from cte)

select c.customer_id,
sum(datediff(c.next_transaction_date,c.transaction_date)*c.net_amount*ir.interest_rate) as interest
from cte2 c
inner join interestrates ir on c.net_amount between ir.min_balance and ir.max_balance
group by c.customer_id
order by c.customer_id
