-- Write an SQL to retrieve the top 5 customers who have spent the most on their single purchase. Sort the result by max single purchase in descending order.
/*
Table: purchase
+-------------+------------+
|COLUMN_NAME  | DATA_TYPE  |
+-------------+------------+
|customer_id  | int        |
|purchase_date| date       |
|amount       | int        |
+-------------+------------+
*/

select customer_id, max(amount) as max_amount
from purchase
group by customer_id
order by max_amount desc
limit 5

-- Alternate Solution

with rnking as
(select customer_id, amount,
rank()over(partition by customer_id order by amount desc) as rn
from purchase
order by amount desc)

select customer_id, amount
from rnking
where rn = 1
limit 5
