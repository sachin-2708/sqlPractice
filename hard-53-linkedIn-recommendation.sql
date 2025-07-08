-- LinkedIn stores information of post likes in below format. Every time a user likes a post there will be an entry made in post likes table.
/*Table : post_likes 
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| post_id     | int       |
| user_id     | int       |
+-------------+-----------+
LinkedIn also stores the information when someone follows another user in below format.
Table : user_follows
+-----------------+-----------+
| COLUMN_NAME     | DATA_TYPE |
+-----------------+-----------+
| follows_user_id | int       |
| user_id         | int       |
+-----------------+-----------+
The marketing team wants to send one recommendation post to each user . Write an SQL to find out that one post id for each user that is liked by the most number of users that they follow. Display user id, post id and no of likes.
Please note that team do not want to recommend a post which is already liked by the user. If for any user,  2 or more posts are liked by equal number of users that they follow then select the smallest post id, display the output in ascending order of user id.
*/

with cte as
(select u.user_id, p.post_id, count(*) as no_of_likes
from user_follows u
inner join post_likes p on p.user_id = u.follows_user_id
where (u.user_id, p.post_id) not in (select user_id, post_id from post_likes)
group by u.user_id, p.post_id)
, cte2 as
(select *, row_number()over(partition by user_id order by no_of_likes desc, post_id) as rn
from cte)

select user_id, post_id, no_of_likes
from cte2
where rn=1
