-- You are tasked to determine the mother and father's name for each child based on the given data. The people table provides information about individuals, including their names and genders. The relations table specifies parent-child relationships, linking each child (c_id) to their parent (p_id). Each parent is identified by their ID, and their gender is used to distinguish between mothers (F) and fathers (M).
-- Write an SQL query to retrieve the names of each child along with the names of their respective mother and father, if available. If a child has only one parent listed in the relations table, the query should still include that parent's name and leave the other parent's name as NULL. Order the output by child name in ascending order.
/*
Tables: people
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| gender      | char(2)     |
| id          | int         |
| name        | varchar(20) |
+-------------+-------------+
Tables: relations 
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| c_id        | int       |
| p_id        | int       |
+-------------+-----------+
*/

with cte as
(select r.c_id as child_id, max(pm.name) as mother_name,
max(pf.name) as father_name                             -- Max used because the mother or father column will have null in them and we want to avoid them, so we aggregate them on the child_id
from relations r
left join people pm on pm.id = r.p_id and pm.gender = 'F'
left join people pf on pf.id = r.p_id and pf.gender = 'M'
group by r.c_id)

select p1.name as child_name, c.mother_name, c.father_name
from cte c
join people p1 on p1.id = c.child_id
order by child_name
