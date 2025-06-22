-- Sachin Tendulkar - Also known as little master. You are given runs scored by Sachin in his first 10 matches. You need to write an SQL to get match number when he completed 500 runs and his batting average at the end of 10 matches.
-- Batting Average = (Total runs scored) / (no of times batsman got out)
-- Round the result to 2 decimal places.
/*
Table: sachin
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| match_no    | int         |
| runs_scored | int         |
| status      | varchar(10) |
+-------------+-------------+
*/

with cte as
(select match_no, runs_scored, status,
sum(runs_scored)over(order by match_no) as running_score
from sachin)

select
min(case when running_score > 500 then match_no end) as match_no,
round(sum(runs_scored)/sum(case when status = 'out' then 1 else 0 end),2) as batting_average
from cte
