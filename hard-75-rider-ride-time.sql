-- You are working with Zomato, a food delivery platform, and you need to analyze the performance of Zomato riders in terms of the time they spend delivering orders each day. Given the pickup and delivery times for each order, your task is to calculate the duration of time spent by each rider on deliveries each day.  Order the output by rider id and ride date.
/*
Table:orders 
+---------------+-----------+
| COLUMN_NAME   | DATA_TYPE |
+---------------+-----------+
| rider_id      | int       |
| order_id      | int       |
| pickup_time   | datetime  |
| delivery_time | datetime  |
+---------------+-----------+
*/

with cte as
(select rider_id, date(pickup_time) as ride_date,
case when date(pickup_time) = date(delivery_time) then timestampdiff(minute,pickup_time,delivery_time) 
else timestampdiff(minute,pickup_time,date_format(delivery_time,'%Y-%m-%d 00:00:00'))
end as ride_time_mins
from orders
union all
select rider_id, date(delivery_time) as ride_date,
case when date(pickup_time) <> date(delivery_time) then timestampdiff(minute,date_format(delivery_time,'%Y-%m-%d 00:00:00'),delivery_time)
end as ride_time_mins
from orders)

select rider_id, ride_date, sum(ride_time_mins) rider_time_mins
from cte
where ride_time_mins > 0
group by rider_id, ride_date
order by rider_id, ride_date
