--You're working for a financial analytics company that specializes in analyzing credit card expenditures. You have a dataset containing information about users' credit card expenditures across different card companies.
--Write an SQL query to find the total expenditure from other cards (excluding Mastercard) for users who hold Mastercard.  Display only the users(along with Mastercard expense and other expense) for which expense from other cards together is more than Mastercard expense.
/*
Table: expenditures
+--------------+-------------+
| COLUMN_NAME  | DATA_TYPE   |
+--------------+-------------+
| user_name    | varchar(10) |
| expenditure  | int         |
| card_company | varchar(15) |
+--------------+-------------+
*/

with mastercard_cte as
(select user_name, sum(expenditure) as mastercard_expense from expenditures
where card_company = 'Mastercard'
group by user_name),
other_cards as
(select user_name, sum(expenditure) as other_expense
from expenditures
where card_company <> 'Mastercard'
group by user_name)

select m.user_name, m.mastercard_expense,
o.other_expense
from mastercard_cte m
inner join other_cards o on o.user_name = m.user_name
where o.other_expense > m.mastercard_expense 
