-- Customer retention can be defined as number of customers who continue to make purchases over a certain period compared to the total number of customers. Here's a step-by-step approach to calculate customer retention rate:
-- 1- Determine the number of customers who made purchases in the current period (e.g., month: m )
-- 2- Identify the number of customers from month m who made purchases in month m+1 , m+2 as well.
-- Suppose you are a data analyst working for Amazon. The company is interested in measuring customer retention over the months to understand how many customers continue to make purchases over time.
-- Your task is to write an SQL to derive customer retention month over month, display the output in ascending order of current year, month & future year, month.
/*
Table: orders
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| order_id    | int       |
| customer_id | int       |
| order_date  | date      |
+-------------+-----------+
*/

with cte as
(select customer_id, year(order_date) as year, month(order_date) as month
from orders)

select cm.year as current_year, cm.month as current_month, fm.year as future_year, fm.month as future_month,
count(distinct cm.customer_id) as total_customer,
count(distinct case when fm.customer_id = cm.customer_id then fm.customer_id end) as retained_customers 
from cte cm
inner join cte fm on (fm.year > cm.year or (fm.year = cm.year and fm.month > cm.month))
group by cm.year, cm.month, fm.year, fm.month
order by cm.year, cm.month, fm.year, fm.month
