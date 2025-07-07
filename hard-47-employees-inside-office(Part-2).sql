-- A company record its employee's movement In and Out of office in a table. Please note below points about the data:
-- 1- First entry for each employee is “in”
-- 2- Every “in” is succeeded by an “out”
-- 3- Employee can work across days
-- Write an SQL to measure the time spent by each employee inside the office between “2019-04-01 14:00:00” and “2019-04-02 10:00:00" in minutes, display the output in ascending order of employee id .
/*
Table: employee_record
+-------------+------------+
| COLUMN_NAME | DATA_TYPE  |
+-------------+------------+
| emp_id      | int        |
| action      | varchar(3) |
| created_at  | datetime   |
+-------------+------------+
*/

with timings as
(select *,
lead(created_at,1)over(partition by emp_id order by created_at) as next_time
from employee_record)
, new_timings as
(select emp_id,
case when created_at < '2019-04-01 14:00:00' then '2019-04-01 14:00:00' 
else created_at end as new_created_at,
case when next_time > '2019-04-02 10:00:00' then '2019-04-02 10:00:00' 
else next_time end as new_next_time
from timings
where action = 'in')

select emp_id,
sum(case when new_created_at > new_next_time then 0 else 
  timestampdiff(minute,new_created_at, new_next_time) end) as time_spent
from new_timings
group by emp_id
