-- You have a table named numbers containing a single column n. You are required to generate an output that expands each number n into a sequence where the number appears n times.
/*
Table: numbers 
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| n           |   int     |    
+-------------+-----------+
*/

with recursive numberseries as
(select 
	n as original_number,
    n as expanded_number,
    1 as sequence_length
from numbers
union all
select
	ns.original_number,
    ns.expanded_number,
    ns.sequence_length + 1
from numberseries ns
where ns.sequence_length < ns.original_number)

select expanded_number
from numberseries
order by original_number, sequence_length
