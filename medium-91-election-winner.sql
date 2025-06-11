-- You are provided with election data from multiple districts in India. Each district conducted elections for selecting a representative from various political parties. Your task is to analyze the election results to determine the winning party at national levels.  Here are the steps to identify winner:
--1- Determine the winning party in each district based on the candidate with the highest number of votes.
-- 2- If multiple candidates from different parties have the same highest number of votes in a district, consider it a tie, and all tied candidates are declared winners for that district.
-- 3- Calculate the total number of seats won by each party across all districts
-- 4- A party wins the election if it secures more than 50% of the total seats available nationwide.
-- Display the total number of seats won by each party and a result column specifying Winner or Loser. Order the output by total seats won in descending order.
/*
Table: elections
+---------------+-------------+
| COLUMN_NAME   | DATA_TYPE   |
+---------------+-------------+
| district_name | varchar(20) |
| candidate_id  | int         |
| party_name    | varchar(10) |
| votes         | int         |
+---------------+-------------+
*/


with cte as 
(select district_name, party_name, votes,
rank()over(partition by district_name order by votes desc) as rnk
from elections),
cte1 as 
(select party_name, count(*) as seats_won
from cte
where rnk = 1
group by party_name)

select party_name, seats_won,
case when seats_won/(select count(distinct district_name) from elections) > 0.5 then 'Winner' else 'Loser' end as result
from cte1

-- Alternate Solution (wont give distinct seat count as I am summing total candidates)
with cte as 
(select district_name, party_name, votes,
rank()over(partition by district_name order by votes desc) as rnk
from elections),
cte1 as 
(select party_name, count(*) as seats_won
from cte
where rnk = 1
group by party_name)
, cte2 as
(select party_name, seats_won, 
sum(seats_won)over() as total_seats
from cte1)

select party_name, seats_won,
case when seats_won/total_seats > 0.5 then 'Winner' else 'Loser' end as result
from cte2

-- Alternate Solution
with cte as 
(select district_name, party_name, votes,
rank()over(partition by district_name order by votes desc) as rnk
from elections),
cte_total_seats as
(select count(distinct district_name) as total_seats
 from elections)
 
select party_name, count(*) as seats_won,
case when count(*)/total_seats > 0.5 then 'Winner' else 'Loser' end as result
from cte, cte_total_seats
where rnk = 1
group by party_name, total_seats

-- Alternate Solution

with cte as 
(select district_name, party_name, votes,
rank()over(partition by district_name order by votes desc) as rnk
from elections),
cte1 as 
(select party_name, count(*) as seats_won
from cte
where rnk = 1
group by party_name)
, cte2 as
(select count(distinct district_name) as total_seats
from elections)

select party_name, seats_won,
case when seats_won/total_seats > 0.5 then 'Winner' else 'Loser' end as result
from cte1, cte2



