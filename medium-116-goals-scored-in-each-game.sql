-- Please refer to the 3 tables below from a football tournament. Write an SQL which lists every game with the goals scored by each team. The result set should show: match id, match date, team1, score1, team2, score2. Sort the result by match id.
-- Please note that score1 and score2 should be number of goals scored by team1 and team2 respectively.
/*
Table: team 
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| id          | int         |
| name        | varchar(20) |
| coach       | varchar(20) |
+-------------+-------------+
Table: game
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| match_id    | int         |
| match_date  | date        |
| stadium     | varchar(20) |
| team1       | int         |
| team2       | int         |
+-------------+-------------+
Table: goal 
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| match_id    | int         |
| team_id     | int         |
| player      | varchar(20) |
| goal_time   | time        |
+-------------+-------------+
*/

with cte as
(select g1.match_id, g1.match_date, g1.team1, g1.team2, g2.team_id as team_goal_cnt
from game g1
left join goal g2 on g1.match_id = g2.match_id)

select match_id, match_date, team1,
sum(case when team1 = team_goal_cnt then 1 else 0 end) as score1,
team2, 
sum(case when team2 = team_goal_cnt then 1 else 0 end) as score2
from cte
group by match_id, match_date, team1, team2

-- Alternate Solution
  
select game.match_id,game.match_date,team1, 
sum(case when team1=team_id then 1 else 0 end) as score1
,team2, 
sum(case when team2=team_id then 1 else 0 end) as score2
from game 
left join goal on game.match_id=goal.match_id
group by game.match_id,game.match_date,team1,team2
order by game.match_id;
