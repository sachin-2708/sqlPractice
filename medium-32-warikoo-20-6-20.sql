-- Ankur Warikoo, an influential figure in Indian social media, shares a guideline in one of his videos called the 20-6-20 rule for determining whether one can afford to buy a phone or not. The rule for affordability entails three conditions:

-- 1. Having enough savings to cover a 20 percent down payment.
-- 2. Utilizing a maximum 6-month EMI plan (no-cost) for the remaining cost.
-- 3. Monthly EMI should not exceed 20 percent of one's monthly salary.
-- Given the salary and savings of various users, along with data on phone costs, the task is to write an SQL to generate a list of phones (comma-separated) that each user can afford based on these criteria, display the output in ascending order of the user name.

-- Table: users
/*
+----------------+-------------+
| COLUMN_NAME    | DATA_TYPE   |
+----------------+-------------+
| user_name      | varchar(10) |
| monthly_salary | int         |
| savings        | int         |
+----------------+-------------+
*/
-- Table: phones
/*
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| cost        | int         |
| phone_name  | varchar(15) |
+-------------+-------------+
*/

WITH cte AS(select *, round((monthly_salary*.2),0) as salary_twentypercent,
round((cost*.2),0) as down_payment,
cost - round((cost*.2),0) as remaining_amount,
round((cost - (cost*.2))/6,0) as monthly_emi
from users
CROSS JOIN phones)

SELECT user_name, GROUP_CONCAT(phone_name SEPARATOR ', ') AS affordable_phones
FROM cte 
WHERE savings >= down_payment
AND monthly_emi <= salary_twentypercent
GROUP BY user_name


-- Alternate Solution

SELECT u.user_name, GROUP_CONCAT(p.phone_name SEPARATOR ',') AS affordable_phones
FROM users u
CROSS JOIN phones p
WHERE u.savings >= .2*p.cost
AND u.monthly_salary*0.2 >= p.cost*0.8/6
GROUP BY u.user_name
ORDER BY u.user_name
