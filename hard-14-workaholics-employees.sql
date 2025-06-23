-- Write a query to find workaholics employees.  Workaholics employees are those who satisfy at least one of the given criterions:
-- 1- Worked for more than 8 hours a day for at least 3 days in a week. 
-- 2- worked for more than 10 hours a day for at least 2 days in a week. 
-- You are given the login and logout timings of all the employees for a given week. Write a SQL to find all the workaholic employees along with the criterion that they are satisfying (1,2 or both), display it in the order of increasing employee id
/*
Table: employees
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| emp_id      | int       |
| login       | datetime  |
| logout      | datetime  |
+-------------+-----------+
*/

with hours_cal as 
(select emp_id,
timestampdiff(second,login, logout)/3600 as hours
from employees)
, timeframe_cte as
(select emp_id, 
case when hours > 10 then 'worked_10'
when hours > 8 then 'worked_8'
else 'under_8' end as timeframe
from hours_cal)
, days_cal as
(select emp_id,
sum(case when timeframe = 'worked_10' then 1 else 0 end) as days_10,
count(*) as days_8
from timeframe_cte
where timeframe in ('worked_10','worked_8')
group by emp_id)

select emp_id,
case when days_8 >=3 and days_10 >=2 then 'both'
when days_8 >= 3 then '1'
else '2'
end as criterian
from days_cal
