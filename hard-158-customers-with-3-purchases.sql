/*
Find users who have made exactly three purchases, such that:
1. Their second purchase occurred within 7 days of the first, 
2. Their third purchase occurred at least 30 days after the second, and
3. There is no more purchase after that

Return all user_ids that match the above pattern along with their first_order_date, second_order_date, and third_order_date.

Table: orders
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| order_id    | INT      |
| user_id     | INT      | 
| order_date  | DATE     |
+-------------+----------+
*/

with ranked_orders as
(select *, row_number()over(partition by user_id order by order_date) as rn
from orders)
, pivoted as
(select user_id,
max(case when rn = 1 then order_date end) as first_order_date,
max(case when rn = 2 then order_date end) as second_order_date,
max(case when rn = 3 then order_date end) as third_order_date,
count(*) as total_orders
from ranked_orders
group by user_id)

select user_id, first_order_date, second_order_date, third_order_date
from pivoted
where second_order_date <= first_order_date + interval 7 day
and third_order_date >= first_order_date + interval 30 day
and total_orders = 3
