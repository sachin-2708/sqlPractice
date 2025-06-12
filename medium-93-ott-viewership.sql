-- You have a table named ott_viewership. Write an SQL query to find the top 2 most-watched shows in each genre in the United States. 
-- Return the show name, genre, and total duration watched for each of the top 2 most-watched shows in each genre. sort the result by genre and total duration.
/*
Tables: ott_viewership
+--------------+-------------+
| COLUMN_NAME  | DATA_TYPE   |
+--------------+-------------+
| viewer_id    | int         |
| show_id      | int         |
| show_name    | varchar(20) |
| genre        | varchar(10) |
| country      | varchar(15) |
| view_date    | date        |
| duration_min | int         |
+--------------+-------------+
*/

with cte as
(select show_name, genre, sum(duration_min) as total_duration,
 rank()over(partition by genre order by sum(duration_min) desc) as rnk
from ott_viewership
where country = 'United States'
group by show_name, genre)

select show_name, genre, total_duration
from cte
where rnk <= 2 
order by genre, total_duration
