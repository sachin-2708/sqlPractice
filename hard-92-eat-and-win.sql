-- A pizza eating competition is organized. All the participants are organized into different groups. In a contest , A participant who eat the most pieces of pizza is the winner and recieves their original bet plus 30% of all losing participants bets. In case of a tie all winning participants will get equal share (of 30%) divided among them .Return the winning participants' names for each group and amount of their payout(round to 2 decimal places) . ordered ascending by group_id , participant_name.
/*
Tables: Competition
+------------------+-------------+
| COLUMN_NAME      | DATA_TYPE   |
+------------------+-------------+
| group_id         | int         |
| participant_name | varchar(10) |
| slice_count      | int         |
| bet              | int         |
+------------------+-------------+
*/

with ranked as
(select group_id, participant_name, slice_count, bet,
dense_rank()over(partition by group_id order by slice_count desc) as rn
from competition)
, losing_bet as
(select group_id,0.3*sum(bet) as loser_bet
from ranked
where rn > 1
group by group_id)
, final as
(select r.group_id, r.participant_name, r.bet, l.loser_bet,
count(*)over(partition by r.group_id) as winner_cnt
from ranked r
join losing_bet l on l.group_id = r.group_id
where rn = 1)

select group_id, participant_name,
round(bet+case when winner_cnt > 1 then loser_bet/winner_cnt
else loser_bet end,2) as total_payout
from final
order by group_id, participant_name

-- alternate solution

with cte as
(select group_id, participant_name, slice_count, bet,
dense_rank()over(partition by group_id order by slice_count desc) as rn
from competition)
, cte2 as
(select group_id, 
sum(case when rn = 1 then 1 else 0 end) as winner_cnt,
sum(case when rn > 1 then bet else 0 end) as losers_bet
from cte
group by group_id)

select c1.group_id, c1.participant_name,
round(bet+(0.3*losers_bet)/winner_cnt,2) as total_payout
from cte c1
join cte2 c2 on c2.group_id = c1.group_id
where c1.rn = 1
order by c1.group_id, c1.participant_name
