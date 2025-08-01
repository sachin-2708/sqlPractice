-- In your organization, each employee has a fixed joining salary recorded at the time they start. Over time, employees may receive one or more promotions, each offering a certain percentage increase to their current salary.
-- You're given two datasets:
-- employees :  contains each employee’s name and joining salary.
-- promotions:  lists all promotions that have occurred, including the promotion date and the percent increase granted during that promotion.
-- Your task is to write a SQL query to compute the current salary of every employee by applying each of their promotions increase round to 1 decimal places.
-- If an employee has no promotions, their current salary remains equal to the joining salary. Order the result by emp id.
/*
Table: employees
+--------------+----------+
| COLUMN_NAME  | DATA_TYPE|
+--------------+----------+
| id            | INT     |
| name          | VARCHAR |  
|joining_salary | INT     |  
+--------------+----------+
Table: promotions
+----------------+----------+
| COLUMN_NAME    | DATA_TYPE|
+----------------+----------+
|emp_id          | INT      |
|promotion_date  | DATE     | 
|percent_increase| INT      |   
+--------------+------------+
*/

with promotion_multipliers as
(select emp_id,
exp(sum(log(1 + ifnull(percent_increase,0)/100))) as total_multiplier
from promotions
group by emp_id)

select e.id, e.name, e.joining_salary as initial_salary, 
round(e.joining_salary * ifnull(p.total_multiplier,1),1) as current_salary
from employees e
left join promotion_multipliers p on p.emp_id = e.id
order by id

-- Alternate Solution

select e.id, e.name, e.joining_salary as initial_salary,
round(e.joining_salary * exp(sum(log(1 + ifnull(p.percent_increase,0)/100))),1) as current_salary
from employees e
left join promotions p on p.emp_id = e.id
group by e.id, e.name, e.joining_salary
order by id
