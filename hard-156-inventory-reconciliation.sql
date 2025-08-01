-- A retail company tracks product scans using two systems:
-- System A (table1) logs scans when products arrive at the warehouse.
-- System B (table2) logs scans when products are shipped out.

-- Each scan logs only the product ids. Due to delays or duplicates, the number of scans per product can differ between systems.
-- Write a query to match scans from System A and System B by product ids and scan order (first from system A with first from first B, second from A with second from B, etc.). If a scan exists in only one system, show it with NULL in the unmatched column.
/*
Example input

Table : table1 
val1 
1
1
2
Table : table2 
val2 
1
2
2
Example output:
+------+------+
| val1 | val2 |
+------+------+
| 1    | 1    | 
| 1    | null | 
| 2    | 2    | 
| null | 2    | 
+-------------+
*/


with table1_cte as 
(select val1, row_number()over(partition by val1 order by val1) as rn
 from table1)
, table2_cte as 
(select val2, row_number()over(partition by val2 order by val2) as rn 
 from table2)
, left_joined as
(select t1.val1 as T1, t2.val2 as T2, t1.rn
from table1_cte t1
left join table2_cte t2 on t1.val1 = t2.val2 and t1.rn = t2.rn)
, right_joined as
(select t1.val1 as T1, t2.val2 as T2, t2.rn
from table2_cte t2
left join table1_cte t1 on t1.val1 = t2.val2 and t1.rn = t2.rn
where t1.val1 is null)
, combined as
(select * from left_joined
union all
select * from right_joined)

select T1, T2
from combined
order by coalesce (T1,T2), rn
