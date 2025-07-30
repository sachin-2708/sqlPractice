-- Given a list of matches in the group stage of the football World Cup, compute the number of points each team currently has.
-- You are given two tables, "teams" and "matches", with the following structures:
/*
Table: teams
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| team_id     | int      |
| team_name   | VARCHAR  | 
+-------------+----------+
Table: matches
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| match_id    | int      |
| host_team   | int      | 
| guest_team  | int      | 
| host_goals  | int      | 
| guest_goals | int      | 
+-------------+----------+
You need to compute the total number of points each team has scored after all the matches described in the table. The scoring rules are as follows:
• If a team wins a match (scores more goals than the other team), it receives 3 points.
• If a team draws a match (scores exactly the same number of goals as the opponent), it receives 1 point.
• If a team loses a match (scores fewer goals than the opponent), it receives no points.
Write an SQL query that returns all the teams ids along with its name and the number of points it received after all described matches ("num_points"). The table should be ordered by "num_points" (in decreasing order). In case of a tie, order the rows by "team_id" (in increasing order).
*/

with cte as
(select match_id, host_team as team_id, host_goals as goals,
case when host_goals > guest_goals then host_team
when host_goals < guest_goals then guest_team
when host_goals = guest_goals then 'tie' end as winner_id
from matches
union all
select match_id, guest_team as team_id, guest_goals as goals,
case when host_goals > guest_goals then host_team
when host_goals < guest_goals then guest_team
when host_goals = guest_goals then 'tie' end as winner_id
from matches)
, points as
(select match_id, team_id, goals, winner_id,
case when team_id = winner_id then 3
when winner_id = 'tie' then 1
else 0 end as points
from cte)

select t.team_id, t.team_name, coalesce(sum(points),0) as num_points
from teams t
left join points p on p.team_id = t.team_id
group by t.team_id, t.team_name
order by num_points desc, team_id

-- Alternate result

select t.team_id, t.team_name,
sum(case when m.host_team = t.team_id and m.host_goals > m.guest_goals then 3
when m.guest_team = t.team_id and m.guest_goals > m.host_goals then 3
when m.host_team = t.team_id and m.host_goals = m.guest_goals then 1
when m.guest_team = t.team_id and m.guest_goals = m.host_goals then 1
else 0 end) as num_points
from teams t
left join matches m on t.team_id = m.host_team or t.team_id = m.guest_team
group by t.team_id, t.team_name
order by num_points desc, t.team_id
