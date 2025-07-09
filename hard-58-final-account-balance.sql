-- You are given history of your bank account for the year 2020. Each transaction is either a credit card payment or incoming transfer. There is a fee of holding a credit card which you have to pay every month, Fee is 5 per month. However, you are not charged for a given month if you made at least 2 credit card payments for a total cost of at least 100 within that month. Note that this fee is not included in the supplied history of transactions.
-- Each row in the table contains information about a single transaction. If the amount value is negative, it is a credit card payment otherwise it is an incoming transfer. At the beginning of the year, the balance of your account was 0 . Your task is to compute the balance at the end of the year. 
/*
Table : Transactions 
+------------------+-----------+
| COLUMN_NAME      | DATA_TYPE |
+------------------+-----------+
| amount           | int       |
| transaction_date | date      |
+------------------+-----------+
*/

with cte as
(select month(transaction_date) as transaction_month,
sum(amount) as net_amount,
count(case when amount < 0 then amount end) as month_credit_payment,
sum(case when amount < 0 then amount end) as month_credit_amount
from transactions
group by month(transaction_date))

select sum(net_amount) -
sum(case when month_credit_payment >= 2 and -(month_credit_amount) >= 100 then 0 else 5 end) 
- 5*(12-count(distinct transaction_month)) as final_balance
from cte
