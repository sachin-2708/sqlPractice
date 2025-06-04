-- You are given a list of users and their opening account balance along with the transactions done by them. Write a SQL to calculate their account balance at the end of all the transactions. 
-- Please note that users can do transactions among themselves as well, display the output in ascending order of the final balance.
/*Table: users
+-----------------+-------------+
| COLUMN_NAME     | DATA_TYPE   |
+-----------------+-------------+
| user_id         | int         |
| username        | varchar(10) |
| opening_balance | int         |
+-----------------+-------------+

Table: transactions
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| id          | int       |
| from_userid | int       |
| to_userid   | int       |
| amount      | int       |
+-------------+-----------+*/

with all_transactions as
(select from_userid as user_id, -(amount) as amount 
from transactions
union
select to_userid, amount 
from transactions),

total_transact as(
select user_id, sum(amount) as total_amount
from all_transactions
group by user_id)

select u.username, u.opening_balance+coalesce(t.total_amount,0) as final_balance
from users u
left join total_transact t on u.user_id = t.user_id
order by final_balance

