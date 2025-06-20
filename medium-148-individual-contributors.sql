-- You are given a table named employees with the following structure:
/*
Table: employees
+--------------+----------+
| COLUMN_NAME  | DATA_TYPE|
+--------------+----------+
| employee_id  | INT      |
| name         | VARCHAR  |  
| manager_id   | INT      |
+--------------+----------+
Each row represents an employee. The manager_id column references the employee_id of their manager. The top-level manager(s) (e.g., CEO) will have NULL as their manager_id.

Write a SQL query to find employees who do not manage any other employees, ordered in ascending order of employee id.
*/

with cte as
(select distinct(manager_id) as emp_id
from employees)

select e.employee_id, e.name, e.manager_id
from employees e
left join cte c on c.emp_id = e.employee_id
where c.emp_id is null
order by e.employee_id

-- Alternate Solution

select *
from employees
where employee_id not in
(select distinct(manager_id)
from employees
where manager_id is not null)    -- important to put where manager_id is not null because if there is null present, it will break the comparisons
