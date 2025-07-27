-- You are a DevOps engineer responsible for monitoring the health and status of various services in your organization's infrastructure. 
-- Your team conducts canary tests on each service every minute to ensure their reliability and performance. 
-- As part of your responsibilities, you need to develop a SQL to identify any service that experiences continuous downtime for at least 5 minutes so that team can find the root cause and fix the issue. 
-- Display the output in descending order of service down minutes.
/*
Table:service_status 
+--------------+-------------+
| COLUMN_NAME  | DATA_TYPE   |
+--------------+-------------+
| service_name | varchar(4) |
| status       | varchar(4)  |
| updated_time | datetime    |
+--------------+-------------+
*/

with cte as
(select service_name, updated_time, status,
row_number()over(partition by service_name order by updated_time) as service_rank,
row_number()over(partition by service_name,status order by updated_time) as service_status_rank
from service_status
order by service_name,updated_time)


select service_name,
min(updated_time) as down_start_time,
max(updated_time) as down_end_time,
count(*) as down_minutes
from cte
where status = 'down'
group by service_name, service_rank - service_status_rank
having count(*)>=5
order by down_minutes desc
