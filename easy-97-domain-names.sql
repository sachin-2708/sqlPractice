-- Write an SQL query to extract the domain names from email addresses stored in the Customers table.

/*Tables: Customers
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| CustomerID  | int         |
| Email       | varchar(25) |
+-------------+-------------+*/

SELECT email, 
SUBSTRING_INDEX(email, '@', -1) AS domain_name
FROM customers;
