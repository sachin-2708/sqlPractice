-- The marketing team at a retail company wants to analyze customer purchasing behavior. They are particularly interested in understanding how many customers who bought a laptop later went on to purchase a laptop bag, with no intermediate purchases in between. Write an SQL to get number of customer in each country who bought laptop and number of customers who bought laptop bag just after buying a laptop. Order the result by country.
/*
Table: transactions
+----------------------+------------+
| COLUMN_NAME          | DATA_TYPE  |
+----------------------+------------+
| transaction_id       | int        |
| customer_id          | date       |
| product_name         | varchar(10)|
| transaction_timestamp| datetime   |
| country              | varchar(5) |
+----------------------+------------+
*/

with cte as
(select 
	customer_id, 
    country, 
    product_name,
  	lead(product_name,1,product_name)over(partition by customer_id order by transaction_timestamp) as next_product
from transactions)

select 
	country,
    count(distinct case when product_name = 'Laptop' then customer_id end) as laptop_customers,
    count(distinct case when product_name = 'Laptop' and next_product = 'Laptop Bag' then customer_id end) as laptop_bag_customers
from cte
group by country
order by country
