-- You are analyzing sales data from an e-commerce platform, which includes information about orders placed for various products across different categories. Each order contains details such as the order ID, order date, product ID, category, and amount.
-- Write an SQL to identify the top 3 products within the top-selling category based on total sales. The top-selling category is determined by the sum of the amounts sold for all products within that category. Sort the output by products sales in descending order.
/*
Table: orders
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| amount      | int         |
| category    | varchar(20) |
| order_date  | date        |
| order_id    | int         |
| product_id  | int         |
+-------------+-------------+
*/

select product_id, category, sum(amount) as total_sales
from orders
where category = (select category
                  from orders
                  group by category
                  order by sum(amount) desc
                  limit 1) -- subquery to find the top category
group by product_id, category
order by total_sales desc
limit 3

-- Alternate Solution

with category_sales as
(select category, sum(amount) as category_sales_total
from orders
group by category)
, category_rank as
(select category, category_sales_total,
rank()over(order by category_sales_total desc) as rn
from category_sales)
select o.product_id, o.category, sum(o.amount) as total_sales
from orders o
where category = (select category
                  from category_rank
                  where rn = 1)
group by o.product_id, o.category
order by total_sales desc
limit 3
