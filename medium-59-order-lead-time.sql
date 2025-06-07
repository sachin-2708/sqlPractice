-- You are given orders data of an online ecommerce company. Dataset contains order_id , order_date and ship_date. Your task is to find lead time in days between order date and ship date using below rules:
-- 1- Exclude holidays. List of holidays present in holiday table. 
-- 2- If the order date is on weekends, then consider it as order placed on immediate next Monday 
-- and if the ship date is on weekends, then consider it as immediate previous Friday to do calculations.
-- For example, if order date is March 14th 2024 and ship date is March 20th 2024. Consider March 18th is a holiday then lead time will be (20-14) -1 holiday = 5 days.
/*Table: orders
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| order_date  | date      |
| order_id    | int       |
| ship_date   | date      |
+-------------+-----------+
Table: holidays
+--------------+-----------+
| COLUMN_NAME  | DATA_TYPE |
+--------------+-----------+
| holiday_date | date      |
| holiday_id   | int       |
+--------------+-----------+*/


with cte as
(select *,
case when dayofweek(order_date) = 1 then date_add(order_date, interval 1 day)
when dayofweek(order_date) = 7 then date_add(order_date, interval 2 day) else order_date end as revised_order_date,
case when dayofweek(ship_date) = 1 then date_add(ship_date, interval -2 day)
when dayofweek(ship_date) = 7 then date_add(ship_date, interval -1 day) else ship_date end as revised_ship_date
from orders),
cte2 as(
select order_id, revised_order_date, revised_ship_date,
datediff(revised_ship_date,revised_order_date) as no_of_days
from cte)

select c.order_id, c.no_of_days-count(h.holiday_date) as lead_time
from cte2 c
left join holidays h on h.holiday_date between c.revised_order_date and c.revised_ship_date
group by c.order_id, c.no_of_days;
