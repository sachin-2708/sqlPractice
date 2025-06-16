-- You are working with an employee database where each employee has a department id and a salary. Your task is to find the third highest salary in each department. If there is no third highest salary in a department, then the query should return salary as null for that department. Sort the output by department id.
-- Assume that none of the employees have same salary in a particular department.
/*
Table: employees 
+---------------+----------+
| COLUMN_NAME   | DATA_TYPE|
+---------------+----------+
| employee_id   | int      |
| department_id | int      |
| salary        | int      |
+---------------+----------+
*/

with cte as
(select department_id, salary,
rank()over(partition by department_id order by salary desc) as rn
from employees)

select distinct(e.department_id) as department_id, c.salary as third_highest_salary
from employees e
left join cte c on c.department_id = e.department_id
and c.rn = 3
order by department_id

-- Alternate Solution

with cte as
(select department_id, salary,
rank()over(partition by department_id order by salary desc) as rn
from employees)

select department_id, 
max(case when rn = 3 then salary else null end) as third_highest_salary
from cte
group by department_id
order by department_id
