-- You are given table of cricket match played in a ICC cricket tournament with the details of winner for each match. You need to derive a points table using below rules.
-- 1- For each win a team gets 2 points. 
-- 2- For a loss team gets 0 points.
-- 3- In case of a draw both the team gets 1 point each.
-- Display team name , matches played, # of wins , # of losses and points.  Sort output in ascending order of team name.
/*
Table: icc_world_cup 
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| team_1      | varchar(10) |
| team_2      | varchar(10) |
| winner      | varchar(10) |
+-------------+-------------+
*/

with matches as
(select team_1 as team, team_2 as opponent, winner
from icc_world_cup
union all
select team_2 as team, team_1 as opponent, winner
from icc_world_cup)
, result_cte as
(select team as team_name,
case when winner = team then 'win'
when winner = 'Draw' then 'draw'
else 'loss' end as result
from matches)
, result_cnt as
(select team_name,
count(*) as match_played,
sum(case when result = 'win' then 1 else 0 end) as no_of_wins,
sum(case when result = 'loss' then 1 else 0 end) as no_of_losses,
sum(case when result = 'draw' then 1 else 0 end) as no_of_draws
from result_cte
group by team_name)

select team_name, match_played, no_of_wins, no_of_losses,
2*no_of_wins+1*no_of_draws as total_points
from result_cnt
order by team_name

-- Alternate Solution

with matches as
(select team_1 as team_name, team_2 as opponent,
case when team_1 = winner then 1 else 0 end as win_flag,
case when winner = 'Draw' then 1 else 0 end as draw_flag
from icc_world_cup
union all
select team_2 as team_name, team_1 as opponent,
case when team_2 = winner then 1 else 0 end as win_flag,
case when winner = 'Draw' then 1 else 0 end as draw_flag
from icc_world_cup)

select team_name,
count(*) as matches_played,
sum(win_flag) as no_of_wins,
count(*) - sum(win_flag) - sum(draw_flag) no_of_losses,
2*sum(win_flag) + 1*sum(draw_flag) as total_points
from matches
group by team_name
order by team_name
