-- In the Netflix dataset containing information about viewers and their viewing history, devise a query to identify viewers who primarily use mobile devices for viewing, but occasionally switch to other devices. Specifically, find viewers who have watched at least 75% of their total viewing time on mobile devices but have also used at least one other devices such as tablets or smart TVs for viewing. Provide the user ID and the percentage of viewing time spent on mobile devices. Round the result to nearest integer.
/*
Table: viewing_history
+-------------+--------------+
| COLUMN_NAME | DATA_TYPE    |
+-------------+--------------+
| user_id     | int          |
| title       | varchar(20)  |
| device_type | varchar(10)  |
| watch_mins  | int          |
+-------------+--------------+
*/

with cte as
(select user_id, device_type, sum(watch_mins) as device_time,
count(*)over(partition by user_id) as cnt
from viewing_history
group by user_id, device_type)
, cte1 as
(select user_id, device_type, device_time, sum(device_time)over(partition by user_id) as total_time
from cte
where cnt > 1)

select user_id, round(100.0*(device_time/total_time),0) as mobile_percentage_view 
from cte1
where device_type = 'Mobile'
and round(100.0*(device_time/total_time),0) > 75

-- 

with cte as
(select user_id,
sum(case when device_type = 'Mobile' then watch_mins end) as mobile_watch_mins,
sum(watch_mins) as total_time,
count(distinct device_type) as device_cnt
from viewing_history
group by user_id)

select user_id, round(100.0*(mobile_watch_mins/total_time),0) as mobile_percentage_view
from cte
where 100.0*(mobile_watch_mins/total_time) > 75
and device_cnt > 1
