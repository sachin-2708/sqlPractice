-- In professional tennis, there are four major tournaments that make up the Grand Slam: Wimbledon, French Open, US Open, and Australian Open. Each year, these tournaments declare one winner, and winning any of them is a major achievement for a tennis player. In championships table the wimbledon, fr_open, us_open and au_open columns have the winner player id.
-- You are given data from a tennis database. Your task is to write a query to report the total number of Grand Slam tournaments won by each player. The result should include all players, even those who have never won a tournament. For such players, the count should be 0.
-- Return the result with columns: player_id, player_name, and grand_slams_count. The result should be sorted by grand_slams_count in descending order.
/*
Table: players
+--------------+----------+
| COLUMN_NAME  | DATA_TYPE|
+--------------+----------+
| player_id    | INT      |
| player_name  | varchar  | 
+-------------------------+
Table: championships
+--------------+----------+
| COLUMN_NAME  | DATA_TYPE|
+--------------+----------+
| year         | INT      | 
| view_date    | date     |
| article_id   | INT      | 
+-------------------------+
*/

with winner_cte as
(select year, wimbledon as winner_id from championships
union all
select year, fr_open from championships
union all
select year, us_open from championships
union all
select year, au_open from championships)

select p.player_id, p.player_name, coalesce(count(w.winner_id),0) as grand_slam_count
from players p
left join winner_cte w on w.winner_id = p.player_id
group by p.player_id, p.player_name
order by grand_slam_count desc
