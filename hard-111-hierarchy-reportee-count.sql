-- Write a SQL query to find the number of reportees (both direct and indirect) under each manager. The output should include:
-- m_id: The manager ID.
-- num_of_reportees: The total number of unique reportees (both direct and indirect) under that manager.
-- Order the result by number of reportees in descending order.
/*
Table: hierarchy
+-------------+------------+
|COLUMN_NAME  | DATA_TYPE  |
+-------------+------------+
| e_id        | int        |
| m_id        | int        |
+-------------+------------+
*/

with recursive report_chain as
(select 
	m_id as manager_id,
    e_id as reportee_id
from hierarchy
union all
 select 
 	rc.manager_id,
 	h.e_id as reportee_id
 from report_chain rc
 join hierarchy h 
 on rc.reportee_id = h.m_id
 )
 
select manager_id, count(distinct reportee_id) as no_of_reportees 
from report_chain
group by manager_id
order by no_of_reportees desc
