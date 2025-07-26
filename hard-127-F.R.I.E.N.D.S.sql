-- You are given three tables: students, friends and packages. Friends table has student id and friend id(only best friend). A student can have more than one best friends. 
-- Write a query to output the names of those students whose ALL friends got offered a higher salary than them. Display those students name and difference between their salary and average of their friends salaries.
/*
Table: students 
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| id          | int      |
| name        | varchar  |
+-------------+----------+
Table: friends 
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| id          | int      |
| friend_id   | int      |
+-------------+----------+
Table: packages 
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| id          | int      |
| salary      | int      |
+-------------+----------+
*/

select s.name, sp.salary - avg(fp.salary) as salary_diff
from students s
inner join friends f on s.id = f.id
inner join packages sp on sp.id = s.id
inner join packages fp on fp.id = f.friend_id
group by s.name, sp.salary
having sp.salary < min(fp.salary)
order by name

-- alternate solution

with cte as
(select s.name, p.salary as student_salary, p1.salary as friend_salary
from friends f
join packages p on f.id = p.id
join packages p1 on f.friend_id = p1.id
join students s on s.id = f.id)

select name, min(student_salary) - avg(friend_salary) as salary_diff
from cte
group by name
having min(student_salary)<min(friend_salary)
order by name
