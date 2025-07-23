-- Write an SQL query to find all the contiguous ranges of log_id values.
/*
Table: logs
+-------------+------------+
| COLUMN_NAME | DATA_TYPE  |
+-------------+------------+
| log_id      | int        |
+-------------+------------+
*/

with numbered_logs as
(select log_id,
log_id - row_number()over(order by log_id) as grp
from logs)

select min(log_id) as start_id,
max(log_id) as end_id
from numbered_logs
group by grp
