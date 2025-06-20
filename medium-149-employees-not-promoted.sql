-- The promotions table records all historical promotions of employees (an employee can appear multiple times).
-- Write a query to find all employees who were not promoted in the last 1 year from today. Display id , name and latest promotion date for those employees order by id.
/*
Table: employees
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| id          | INT      |
| name        | VARCHAR  |  
+-------------+----------+
Table: promotions
+--------------+----------+
| COLUMN_NAME  | DATA_TYPE|
+--------------+----------+
|emp_id        | INT      |
|promotion_date| DATE     |  
+--------------+----------+
*/

select e.id,e.name, max(p.promotion_date) as last_promo_date
from employees e
left join promotions p on p.emp_id = e.id
group by e.id, e.name
having max(p.promotion_date) < date_sub(curdate(), interval 1 year)
or max(p.promotion_date) is null

-- Alternate Solution

with promo_last_year as
(select * from promotions
where promotion_date > date_sub(curdate(), interval 1 year))
, not_promo as
(select e.id, e.name
from employees e
left join promo_last_year p on e.id = p.emp_id
where p.promotion_date is null)

select n.id, n.name, max(p.promotion_date) as last_promo_date
from not_promo n
left join promotions p on p.emp_id = n.id
group by n.id, n.name
