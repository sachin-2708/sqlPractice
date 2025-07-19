-- You are given two tables: products and orders. The products table contains information about each product, including the product ID and available quantity in the warehouse. The orders table contains details about customer orders, including the order ID, product ID, order date, and quantity requested by the customer.
-- Write an SQL query to generate a report listing the orders that can be fulfilled based on the available inventory in the warehouse, following a first-come-first-serve approach based on the order date. Each row in the report should include the order ID, product name, quantity requested by the customer, quantity actually fulfilled, and a comments column as below:

-- If the order can be completely fulfilled then 'Full Order'.
-- If the order can be partially fulfilled then 'Partial Order'.
-- If order can not be fulfilled at all then 'No Order' .
-- Display the output in ascending order of order id.
/*
Table: products
+--------------------+-------------+
| COLUMN_NAME        | DATA_TYPE   |
+--------------------+-------------+
| product_id         | int         |
| product_name       | varchar(10) |
| available_quantity | int         |
+--------------------+-------------+

Table: orders
+--------------------+-----------+
| COLUMN_NAME        | DATA_TYPE |
+--------------------+-----------+
| order_id           | int       |
| product_id         | int       |
| order_date         | date      |
| quantity_requested | int       |
+--------------------+-----------+
*/

with cte as
(select 
 	o.order_id, 
 	p.product_name, 
 	o.order_date, 
 	o.quantity_requested, 
 	p.available_quantity,
 	sum(quantity_requested)over(partition by o.product_id order by o.order_date) as running_inventory
from orders o
join products p on p.product_id = o.product_id)

select 
	order_id, 
    product_name, 
    quantity_requested,
    case when available_quantity >= running_inventory then quantity_requested 
    when available_quantity - (running_inventory - quantity_requested) > 0 then available_quantity - (running_inventory - quantity_requested) 
    else 0 end as qty_fulfilled,
	case when available_quantity >= running_inventory then 'Full Order' 
    when available_quantity - (running_inventory - quantity_requested) > 0 then 'Partial Order'
    else 'No Order' end as comments
from cte
