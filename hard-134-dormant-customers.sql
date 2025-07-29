-- Imagine you are working for Swiggy (a food delivery service platform). As part of your role in the data analytics team, you're tasked with identifying dormant customers - those who have registered on the platform but have not placed any orders recently. Identifying dormant customers is crucial for targeted marketing efforts and customer re-engagement strategies.
-- A dormant customer is defined as a user who registered more than 6 months ago from today but has not placed any orders in the last 3 months. Your query should return the list of dormant customers and order amount of last order placed by them. If no order was placed by a customer then order amount should be 0. order the output by user id.
-- Note: All the dates are in UTC time zone.
/*
Table: users
+--------------+----------+
| COLUMN_NAME  | DATA_TYPE|
+--------------+----------+
| user_id      | int      |
| name         | varchar  | 
| email        | varchar  |
| signup_date  | date     |
+--------------+--------- +
Table: orders
+--------------+----------+
| COLUMN_NAME  | DATA_TYPE|
+--------------+----------+
| order_id     | int      |
| order_date   | date     | 
| user_id      | int      |
| order_amount | int      |
+--------------+----------+
*/

with cte as
(select *, row_number()over(partition by user_id order by order_date desc) as rn
from orders)

select u.user_id, coalesce(c.order_amount,0) as last_order_amount from users u
left join cte c on c.user_id = u.user_id and c.rn=1
where u.signup_date <= date_sub(current_date, interval 6 month)
and (c.order_date <= date_sub(current_date, interval 3 month) or c.order_date is null)
