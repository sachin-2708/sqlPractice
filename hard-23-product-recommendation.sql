-- Product recommendation. Just the basic type (“customers who bought this also bought…”). That, in its simplest form, is an outcome of basket analysis. Write a SQL to find the product pairs which have been purchased together in same order along with the purchase frequency (count of times they have been purchased together). Based on this data Amazon can recommend frequently bought together products to other users.
-- Order the output by purchase frequency in descending order. Please make in the output first product column has id greater than second product column. 
/*
Table: orders (primary key : order_id)
+-------------+------------+
| COLUMN_NAME | DATA_TYPE  |
+-------------+------------+
| order_id    | int        |
| customer_id | int        |
| product_id  | varchar(2) |
+-------------+------------+
*/

select 
	o1.product_id as product_1, 
    o2.product_id as product_2, 
    count(*) as purchase_freqency
from orders o1
inner join orders o2 
	on o1.order_id = o2.order_id
	and o1.product_id > o2.product_id
group by o1.product_id, o2.product_id
order by purchase_freqency desc
