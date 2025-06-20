-- You are given a table named students with the following structure:
/*
Table: students
+--------------+----------+
| COLUMN_NAME  | DATA_TYPE|
+--------------+----------+
| student_id   | INT      |
| skill        | VARCHAR  |  
+--------------+----------+
Each row represents a skill that a student knows. A student can appear multiple times in the table if they have multiple skills.

Write a SQL query to return the student_ids of students who only know the skill 'SQL'.  Sort the result by student id.
*/

select student_id
from students
where student_id not in (
select student_id 
from students
where lower(skill) not like 'sql')

-- Alternate Solution

with cte as
(select student_id, lower(skill) as skill, count(*)over(partition by student_id) as cnt 
from students)

select student_id
from cte
where skill = 'sql' and cnt = 1

