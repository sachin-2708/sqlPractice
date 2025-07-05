-- A profit ride for a Uber driver is considered when the start location and start time of a ride exactly match with the previous ride's end location and end time. 
-- Write an SQL to calculate total number of rides and total profit rides by each driver, display the output in ascending order of id.
/*
Table: drivers
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| id          | varchar(10) |
| start_loc   | varchar(1)  |
| start_time  | time        |
| end_loc     | varchar(1)  |
| end_time    | time        |
+-------------+-------------+
*/

select d1.id, count(d1.id) as total_ride, count(d2.id) as profit_rides
from drivers d1
left join drivers d2 on d1.id = d2.id and d1.end_time = d2.start_time and d1.end_loc = d2.start_loc
group by d1.id
order by id

-- Alternate Solution

with cte as
(select *, 
lag(end_time,1)over(partition by id order by start_time) as prev_end_time,
lag(end_loc,1)over(partition by id order by start_time) as prev_end_loc
from drivers)

select id, count(*) as total_rides,
sum(case when start_time = prev_end_time and start_loc = prev_end_loc then 1 else 0 end) as profit_rides
from cte
group by id
order by id
