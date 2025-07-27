-- You are given a table of  train schedule which contains the arrival and departure times of trains at each station on a given day. 
-- At each station one platform can accommodate only one train at a time, from the beginning of the minute the train arrives until the end of the minute it departs. 
-- Write a query to find the minimum number of platforms required at each station to handle all train traffic to ensure that no two trains overlap at any station.
/*
Table: train_schedule 
+---------------+----------+
| COLUMN_NAME   | DATA_TYPE|
+---------------+----------+
| station_id    | int      |
| train_id      | int      |
| arrival_time  | time     |
| departure_time| time     |
+-------------+------------+
*/

with events as
(select station_id, arrival_time as event_time, +1 as event
from train_schedule
union all
select station_id, date_add(departure_time, interval +1 minute) as event_time, -1 as event
from train_schedule)
, running_sum as
(select station_id, event_time, 
sum(event)over(partition by station_id order by event_time) as platforms
from events)

select station_id, max(platforms) as min_platforms_required
from running_sum
group by station_id
