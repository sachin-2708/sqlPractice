-- Suppose you are analyzing the purchase history of customers in an e-commerce platform. Your task is to identify customers who have bought different products on different dates.
-- Write an SQL to find customers who have bought different products on different dates, means product purchased on a given day is not repeated on any other day by the customer. Also note that for the customer to qualify he should have made purchases on at least 2 distinct dates. Please note that customer can purchase same product more than once on the same day and that doesn't disqualify him. Output should contain customer id and number of products bought by the customer in ascending order of userid.
/*
Table: purchase_history 
+--------------+-----------+
| COLUMN_NAME  | DATA_TYPE |
+--------------+-----------+
| userid       | int       |
| productid    | int       |
| purchasedate | date      |
+--------------+-----------+
*/

with cte as
(select distinct userid, productid, purchasedate 
from purchase_history)
, cte1 as
(select userid, count(*) as cnt_products, count(distinct productid) as dist_products, count(distinct purchasedate) as dist_date
from cte
group by userid)

select userid, cnt_products 
from cte1
where cnt_products = dist_products and dist_date > 1

-- alternate solution

with cte as
(select distinct userid, productid, purchasedate 
from purchase_history)

select userid, count(*) as cnt_products
from cte
group by userid
having count(*) = count(distinct productid) and count(distinct purchasedate) > 1
order by userid
