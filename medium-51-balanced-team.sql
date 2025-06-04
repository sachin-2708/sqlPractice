-- Suppose you are a manager of a data analytics company. You are tasked to build a new team consists of senior and junior data analysts. 
-- The total budget for the salaries is 70000.  You need to use the below criterion for hiring:
-- 1- Keep hiring the seniors with the smallest salaries until you cannot hire anymore seniors.
-- 2- Use the remaining budget to hire the juniors with the smallest salaries until you cannot hire anymore juniors.
-- Display employee id, experience and salary. Sort in decreasing order of salary.
/*
Table: candidates
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| emp_id      | int         |
| experience  | varchar(6) |
| salary      | int         |
+-------------+-------------+
*/


with running_total_cte as (select *, 
sum(salary)over(partition by experience order by salary) as running_total
from candidates),
seniors as(
select emp_id, experience, salary
from running_total_cte
where experience = 'Senior'
and running_total <= 70000)

select emp_id, experience, salary
from seniors
union all
select  emp_id, experience, salary
from running_total_cte
where experience = 'Junior'
and running_total <= 70000-(select sum(salary) from seniors)
order by salary desc
