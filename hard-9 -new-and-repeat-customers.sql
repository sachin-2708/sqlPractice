-- Flipkart wants to build a very important business metrics where they want to track on daily basis how many new and repeat customers are purchasing products from their website. A new customer is defined when he purchased anything for the first time from the website and repeat customer is someone who has done at least one purchase in the past.
-- Display order date , new customers , repeat customers  in ascending order of repeat customers.
/*
Table: customer_orders
+--------------+-----------+
| COLUMN_NAME  | DATA_TYPE |
+--------------+-----------+
| order_id     | int       |
| customer_id  | int       |
| order_date   | date      |
| order_amount | int       |
+--------------+-----------+
*/

with first_order_cte as
(select order_id, customer_id, order_date,
min(order_date)over(partition by customer_id) as first_order_date
from customer_orders)

select order_date,
sum(case when order_date = first_order_date then 1 else 0 end) as new_customers,
sum(case when order_date > first_order_date then 1 else 0 end) as repeat_customers
from first_order_cte
group by order_date
order by repeat_customers 

-- Alternate Solution

with first_order_cte as
(select customer_id,
min(order_date) as first_order_date
from customer_orders
group by customer_id)

select c.order_date,
sum(case when c.order_date = f.first_order_date then 1 else 0 end) as new_customers,
sum(case when c.order_date > f.first_order_date then 1 else 0 end) as repeat_customers
from customer_orders c
inner join first_order_cte f on f.customer_id = c.customer_id
group by c.order_date
order by repeat_customers 
