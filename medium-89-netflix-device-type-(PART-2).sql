-- In the Netflix viewing history dataset, you are tasked with identifying viewers who have a consistent viewing pattern across multiple devices. Specifically, viewers who have watched the same title on more than 1 device type. 
-- Write an SQL query to find users who have watched more number of titles on multiple devices than the number of titles they watched on single device. Output the user id , no of titles watched on multiple devices and no of titles watched on single device, display the output in ascending order of user_id.
/*
Table:viewing_history
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| user_id     | int         |
| title       | varchar(20) |
| device_type | varchar(10) |
+-------------+-------------+
*/

with cte as
(select user_id, title, count(*) as viewed_device_nos
from viewing_history
group by user_id, title)
, cte1 as
(select user_id,
sum(case when viewed_device_nos > 1 then 1 else 0 end) as multiple_device_cnt,
sum(case when viewed_device_nos = 1 then 1 else 0 end) as single_device_cnt
from cte
group by user_id)

select user_id, multiple_device_cnt, single_device_cnt
from cte1
where multiple_device_cnt > single_device_cnt
order by user_id;
