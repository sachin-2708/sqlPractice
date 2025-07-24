-- You are given two tables, players and matches, with the following structure.
-- Each record in the table players represents a single player in the tournament. The column player_id contains the ID of each player. The column group_id contains the ID of the group each player belongs to.
/*
Table: players 
+-----------------+----------+
| COLUMN_NAME     | DATA_TYPE|
+-----------------+----------+
| player_id       | int      |    
| group_id        | int      |
+-----------------+----------+
*/
-- Each record in the table matches represents a single match in the group stage. The column first_player (second_player) contains the ID of the first player (second player) in each match. The column first_score (second_score) contains the number of points scored by the first player (second player) in each match. You may assume that, in each match, players belong to the same group.
/*
Table: matches 
+---------------+----------+
| COLUMN_NAME   | DATA_TYPE|
+---------------+----------+
| match_id      | int      |    
| first_player  | int      |
| second_player | int      |
| first_score   | int      |
| second_score  | int      |
+---------------+----------+
*/
-- Write an SQL to compute the winner in each group. The winner in each group is the player who scored the maximum total number of points within the group. If there is more than one such player, the winner is the one with the highest ID. Write an SQL query that returns a table containing the winner of each group. Each record should contain the ID of the group and the ID of the winner in this group. Records should be sorted by group id. 


with all_match_points as
(select first_player as player_id, sum(first_score) as score 
from matches
group by first_player
union all
select second_player as player_id, sum(second_score) as score 
from matches
group by second_player)
, player_scores as
(select player_id, sum(score) as final_score
from all_match_points
group by player_id)
, ranked_players as
(select p.group_id, ps.player_id, ps.final_score,
row_number()over(partition by p.group_id order by ps.final_score desc, ps.player_id desc) as rn 
from player_scores ps
join players p on ps.player_id = p.player_id)

select group_id, player_id
from ranked_players
where rn = 1

