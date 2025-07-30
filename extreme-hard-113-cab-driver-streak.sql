-- A Cab booking company has a dataset of its trip ratings, each row represents a single trip of a driver. A trip has a positive rating if it was rated 4 or above, a streak of positive ratings is when a driver has a rating of 4 and above in consecutive trips. example: If there are 3 consecutive trips with a rating of 4 or above then the streak is 2.
-- Find out the maximum streak that a driver has had and sort the output in descending order of their maximum streak and then by descending order of driver_id.
-- Note: only users who have at least 1 streak should be included in the output.
/*
Table: rating_table 
+-----------------+----------+
| COLUMN_NAME     | DATA_TYPE|
+-----------------+----------+
| trip_time       | datetime |    
| driver_id       | varchar  |
| trip_id         | int      |
| rating          | int      |
+-----------------+----------+
*/

with above_four as
(select driver_id, trip_id - row_number()over(partition by driver_id order by trip_time) as groupings
from rating_table
where rating >= 4)
, grouping_cte as
(select driver_id, count(*)-1 as streak
from above_four
group by driver_id, groupings
having count(*) > 1)

select driver_id, max(streak) as max_streak
from grouping_cte
group by driver_id
order by max_streak desc, driver_id desc
