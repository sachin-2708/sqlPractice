-- You are working as a data analyst at a tech company called "TechGuru Inc." that specializes in software development and data science solutions. The HR department has tasked you with analyzing the salaries of employees. Your goal is to identify employees who earn above the average salary for their respective job title but are not among the top 3 earners within their job title. Consider the sum of base_pay, overtime_pay and other_pay as total salary. 
-- In case multiple employees have same total salary then ranked them based on higher base pay. Sort the output by total salary in descending order.
/*
Table: employee 
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| emp_id      | int         |
| emp_name    | varchar(20) |
| job_title   | varchar(20) |
+-------------+-------------+
Table: salary 
+--------------+-----------+
| COLUMN_NAME  | DATA_TYPE |
+--------------+-----------+
| emp_id       | int       |
| base_pay     | int       |
| other_pay    | int       |
| overtime_pay | int       |
+--------------+-----------+
*/

with cte as
(select e.emp_name, e.job_title, 
s.base_pay + s.overtime_pay + s.other_pay as total_pay, s.base_pay,
avg(s.base_pay + s.overtime_pay + s.other_pay)over(partition by job_title) as title_avg_pay,
dense_rank()over(partition by job_title order by (s.base_pay + s.overtime_pay + s.other_pay) desc, base_pay desc) as rn
from employee e 
join salary s on e.emp_id = s.emp_id)

select emp_name, job_title, total_pay, base_pay, title_avg_pay
from cte
where rn > 3 and total_pay > title_avg_pay
