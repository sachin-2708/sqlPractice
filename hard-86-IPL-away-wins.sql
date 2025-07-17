-- In the Indian Premier League (IPL), each team plays two matches against every other team: one at their home venue and one at their opponent's venue. We want to identify team combinations where each team wins the away match but loses the home match against the same opponent. Write an SQL query to find such team combinations, where each team wins at the opponent's venue but loses at their own home venue.
/*
Table: Matches
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| away_team   | varchar(10) |
| home_team   | varchar(10) |
| match_id    | int         |
| winner_team | varchar(10) |
+-------------+-------------+
*/

select m1.home_team as team1, m1.away_team as team2
from matches m1
join matches m2 
	on m1.home_team = m2.away_team 
    and m1.away_team = m2.home_team
where m1.match_id < m2.match_id 
	and m1.winner_team = m1.away_team 
    and m2.winner_team = m2.away_team
