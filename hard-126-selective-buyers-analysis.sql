-- You are given an orders table that contains information about customer purchases, including the products they bought. 
-- Write a query to find all customers who have purchased both "Laptop" and "Mouse", but have never purchased "Phone Case". 
-- Additionally, include the total number of distinct products purchased by these customers. Sort the result by customer id.
/*
Table: orders 
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| customer_id | int      |
| order_id    | int      |
| product_name| varchar  |
+-------------+----------+
*/

with cte as
(select 
    customer_id, 
    count(distinct product_name) as total_distinct_products, 
    group_concat(distinct product_name separator ',') as products
from orders
where customer_id not in (select customer_id
                          from orders
                          where product_name = 'Phone Case')
group by customer_id)

select 
    customer_id, 
    total_distinct_products 
from cte
where products like '%laptop%' and products like '%mouse%' 

-- alternate solution

select 
  customer_id, 
  count(distinct product_name) as total_distinct_products
from orders
where customer_id not in (select distinct customer_id
                          from orders 
                          where product_name = 'Phone Case')
group by customer_id
having 
  count(distinct case when product_name in ('Laptop','Mouse') then product_name end) = 2

-- Alternate Solution

with cte as
(select *
from orders
where customer_id not in (select distinct customer_id
                          from orders
                          where product_name = 'Phone Case'))

select 
  customer_id, 
  count(distinct product_name) as total_distinct_products
from cte
where customer_id in (select distinct customer_id
                      from orders
                      where product_name in ("Laptop","Mouse"))
group by customer_id
having count(distinct product_name) >=2 
