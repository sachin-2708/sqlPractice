-- Myntra marketing team wants to measure the effectiveness of recent campaigns aimed at acquiring new customers. A new customer is defined as someone who made their first-ever purchase during a specific period, with no prior purchase history.
-- They have asked you to identify the new customers acquired in the last 3 months, excluding the current month. Output should display customer id and their first purchase date. Order the result by customer id.
--For example:
-- If today is March 15, 2025, the SQL should give customers whose first purchase falls in the range from December 1, 2024, to February 28, 2025, and should not include any new customers made in March 2025.
/*
Table: transactions
+---------------+------------+
| COLUMN_NAME     | DATA_TYPE|
+-----------------+----------+
| transaction_id  | int      |
| customer_id     | int      | 
| transaction_date| date     | 
| amount          | int      | 
+-----------------+----------+
*/


with cte as
(select customer_id, min(transaction_date) as first_purchase
from transactions
group by customer_id)

select * from cte
where month(first_purchase) <= month(curdate())-1
and month(first_purchase) >= month(curdate())-3

-- Alternate Solution

with cte as
(select customer_id, min(transaction_date) as first_purchase
from transactions
group by customer_id)

select *
from cte
where first_purchase between 
  date_sub(date_format(current_date, '%Y-%m-01'), interval 3 month) -- This will give me the first date of the 3rd month before today
  and 
  (date_format(current_date, '%Y-%m-01')) -- -- This will give me the first date of the 1st month before today
