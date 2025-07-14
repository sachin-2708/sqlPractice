-- You are working as a data analyst for a large company that tracks employee salaries across multiple departments. The leadership team wants to understand how much each department contributes to the company’s total payroll.
-- Write a SQL query to calculate the percentage of total salary contributed by each department. Round the result to 2 decimal places.
/*
Table: employees
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| emp_id      | INT      |
| dept_id     | INT      | 
| salary      | INT      |
+-------------+----------+
*/

with payroll as 
(select dept_id, sum(salary) as dept_salary
from employees
group by dept_id)

select dept_id,
round(100.0*dept_salary/(sum(dept_salary)over()),2) as salary_contribution_pct
from payroll

-- alternate solution

select dept_id, 
round(100.0*sum(salary)/(select sum(salary) from employees),2) as salary_contribution_pct
from employees
group by dept_id
