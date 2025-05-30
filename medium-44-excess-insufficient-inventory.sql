-- Suppose you are a data analyst working for Flipkart. Your task is to identify excess and insufficient inventory at various Flipkart warehouses in terms of no of units and cost.  
-- Excess inventory is when inventory levels are greater than inventory targets else its insufficient inventory.
-- Write an SQL to derive excess/insufficient Inventory volume and value in cost for each location as well as at overall company level, display the results in ascending order of location id.
/*Table: inventory
+------------------+-----------+
| COLUMN_NAME      | DATA_TYPE |
+------------------+-----------+
| inventory_level  | int       |
| inventory_target | int       |
| location_id      | int       |
| product_id       | int       |
+------------------+-----------+
Table: products
+-------------+--------------+
| COLUMN_NAME | DATA_TYPE    |
+-------------+--------------+
| product_id  | int          |
| unit_cost   | decimal(5,2) |
+-------------+--------------+
*/

WITH cte AS(SELECT i.location_id,
SUM(i.inventory_level - i.inventory_target) AS excess_insufficient_qty,
SUM((i.inventory_level - i.inventory_target)*p.unit_cost) AS excess_insufficient_value
FROM inventory i
JOIN products p ON p.product_id = i.product_id
GROUP BY i.location_id)

SELECT CAST(location_id AS CHAR) AS location_id, excess_insufficient_qty, excess_insufficient_value
FROM cte
UNION
SELECT 'Overall' AS location_id,
SUM(excess_insufficient_qty),
SUM(excess_insufficient_value)
FROM cte
ORDER BY location_id
