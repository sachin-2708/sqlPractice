-- In a quick commerce business, Analyzing the frequency and timing of purchases can help the company identify engaged customers and tailor promotions accordingly.
-- You are tasked to identify customers who have made a minimum of three purchases, ensuring that each purchase occurred in a different month. This information will assist in targeting marketing efforts towards customers who show consistent buying behavior over time.
-- Write an SQL to display customer id and no of orders placed by them.
/*
Table: orders 
+---------------+-----------+
| COLUMN_NAME   | DATA_TYPE |
+---------------+-----------+
| customer_id   | int       |
| order_id      | int       |
| order_date    | date      |
+---------------+-----------+
*/

with cte as
(select *, month(order_date) as o_month
from orders)

select customer_id, count(order_id) as order_count
from cte 
group by customer_id
having count(order_id)>2
and count(distinct o_month) >= count(order_id)

-- Alternate Solution

select customer_id, count(order_id) as order_count
from orders
group by customer_id
having count(order_id)>2
and count(distinct month(order_date)) >= count(order_id)


