-- You have a table called electronic_items. Write an SQL query to find the average price of electronic items in each category, considering only categories where the average price exceeds 500 and at least 20 total quantity of items is available. 
-- Additionally, only include items with a warranty period of 12 months or more. 
-- Return the category name along with the average price of items in that category. Order the result by average price (round to 2 decimal places) in descending order.

 
/*
Tables: electronic_items
+-----------------+--------------+
| COLUMN_NAME     | DATA_TYPE    |
+-----------------+--------------+
| item_id         | int          |
| item_name       | varchar(20)  |
| category        | varchar(15)  |
| price           | decimal(5,1) |
| quantity        | int          |
| warranty_months | int          |
+-----------------+--------------+
*/

SELECT category, ROUND(AVG(price),2) AS average_price
FROM electronic_items
WHERE warranty_months >= 12 
GROUP BY category
HAVING AVG(price) > 500
AND SUM(quantity) >= 20
ORDER BY average_price DESC;
