-- An IT company pays its employees on hourly basis. You are given the database of employees along with their department id.
/*
Table: employees
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| emp_id      | int         |
| emp_name    | varchar(20) |
| dept_id     | int         |
+-------------+-------------+
Department table which consist of hourly rate for each department.
Table: dept
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| dept_id     | int       |
| hourly_rate | int       |
+-------------+-----------+
Given the daily entry_time and exit_time of each employee, calculate the total amount payable to each employee.
Table: daily_time
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| emp_id      | int       |
| entry_time  | datetime  |
| exit_time   | datetime  |
+-------------+-----------+
Please note that company also pays overtime to employees who work for more than 8 hours a day which is 1.5 times of hourly rate. So for example if hourly rate is 10 and a employee works for 9 hours then total payable will be 10*8+15*1 = 95 for that day. In this example 95 is total payout and 15 is overtime payout.  Round the result to 2 decimal places and sort the output by decreasing order of total payout.
*/

with cte as(select d.hourly_rate, e.emp_name, 
TIMESTAMPDIFF(second,dt.entry_time, dt.exit_time)/3600.0 as total_hours
from daily_time dt
inner join employees e on e.emp_id = dt.emp_id
inner join dept d on d.dept_id = e.dept_id)

select emp_name,
round(sum(case when total_hours <= 8 then hourly_rate*total_hours
else 8*hourly_rate+1.5*hourly_rate*(total_hours-8) end),2) as total_payout,
round(sum(case when total_hours > 8 then ((total_hours-8)*1.5*hourly_rate) else 0 end),2) as overtime_payout
from cte
group by emp_name
order by total_payout desc
