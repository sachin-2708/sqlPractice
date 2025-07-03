-- Amazon wants to find out the trending products for each month. Trending products are those for which any given month sales are more than the sum of previous 2 months sales for that product.
-- Please note that for first 2 months of operations this metrics does not make sense. So output should start from 3rd month only.  Assume that each product has at least 1 sale each month, display order month and product id. Sort by order month.
/*
Table: orders 
+-------------+------------+
| COLUMN_NAME | DATA_TYPE  |
+-------------+------------+
| order_month | varchar(6) |
| product_id  | varchar(5) |
| sales       | int        |
+-------------+------------+
*/

with cte as
(select order_month, product_id, sales,
lag(sales,1)over(partition by product_id order by order_month) as prev1,
lag(sales,2)over(partition by product_id order by order_month) as prev2,
row_number()over(partition by product_id order by order_month) as rn
from orders)

select order_month, product_id
from cte
where sales > prev1+prev2 and rn > 2
order by order_month

-- Alternate Solution

with cal_cte as
(select order_month,product_id, sales,
sum(sales)over(partition by product_id order by order_month rows between 2 preceding AND 1 preceding) as running_sum,
row_number()over(partition by product_id order by order_month) as rn
from orders)

select order_month, product_id
from cal_cte
where rn > 2 and sales > running_sum
order by order_month
