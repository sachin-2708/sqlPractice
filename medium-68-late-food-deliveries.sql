-- You're analyzing the efficiency of food delivery on Zomato, focusing on the late deliveries. Total food delivery time for an order is a combination of food preparation time + time taken by rider to deliver the order. 
-- Suppose that as per order time and expected time of delivery there is equal time allocated to restaurant for food preparation and rider to deliver the order. Write an SQL to find orders which got delayed only because of more than expected time taken by the rider, display order_id, expected_delivery_mins, rider_delivery_mins, food_prep_mins in ascending order of order_id.
/*
Table: orders
+------------------------+-----------+
| COLUMN_NAME            | DATA_TYPE |
+------------------------+-----------+
| order_id               | int       |
| restaurant_id          | int       |
| order_time             | time      |
| expected_delivery_time | time      |
| actual_delivery_time   | time      |
| rider_delivery_mins    | int       |
+------------------------+-----------+
*/

with cte as
(select order_id, order_time, actual_delivery_time, rider_delivery_mins,
timestampdiff(minute, order_time, expected_delivery_time) as expected_delivery_mins,
timestampdiff(minute, order_time, actual_delivery_time) as actual_delivery_mins
from orders
where actual_delivery_time > expected_delivery_time),
cte2 as(
select order_id, expected_delivery_mins, rider_delivery_mins, expected_delivery_mins/2 as expected_food_prep,
actual_delivery_mins - rider_delivery_mins as food_prep_mins
from cte)

select order_id, expected_delivery_mins, rider_delivery_mins, food_prep_mins
from cte2
where food_prep_mins <= expected_food_prep
