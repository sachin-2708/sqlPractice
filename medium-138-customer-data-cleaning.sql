-- You are given a table with customers information that contains inconsistent and messy data. Your task is to clean the data by writing an SQL query to:
-- 1- Trim extra spaces from the customer name and email fields.
-- 2- Convert all email addresses to lowercase for consistency.
-- 3- Remove duplicate records based on email address (keep the record with lower customer id).
-- 4- Standardize the phone number format to only contain digits (remove dashes, spaces, and special characters).
-- 5- Replace NULL values in address with 'Unknown'.
-- Sort the output by customer id.
/*
Table: customers
+---------------+----------+
| COLUMN_NAME   | DATA_TYPE|
+---------------+----------+
| customer_id   | int      |
| customer_name | varchar  | 
| email         | varchar  | 
| phone         | varchar  | 
| address       | varchar  | 
+---------------+----------+
*/

with cte as
(select customer_id,
trim(customer_name) as customer_name,
lower(email) as email,
REGEXP_REPLACE(phone, '[^0-9]', '') as phone,
Coalesce(address, 'Unknown') as address,
row_number()over(partition by email order by customer_id) as rn
from customers)

select customer_id, customer_name, email, phone, address
from cte
where rn = 1
order by customer_id
