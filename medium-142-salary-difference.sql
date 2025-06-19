-- You are given an employees table containing information about employees' salaries across different departments. Your task is to calculate the difference between the highest and second-highest salaries for each department.
-- Conditions:
-- If a department has only one employee, return NULL for that department.
-- If all employees in a department have the same salary, return NULL for that department.
-- The final output should include Department Name and Salary Difference. Order by Department Name.
/*
Table: employees
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| id          | int      |
| name        | VARCHAR  | 
| department  | VARCHAR  | 
| salary      | int      | 
+-------------+----------+
*/

with cte as
(select department, salary,
dense_rank()over(partition by department order by salary desc) as rn
from employees)

select department,
max(case when rn = 1 then salary end) -
max(case when rn = 2 then salary end) as difference
from cte
group by department
