-- A company record its employee's movement In and Out of office in a table. Please note below points about the data:
-- 1- First entry for each employee is “in”
-- 2- Every “in” is succeeded by an “out”
-- 3- Employee can work across days
-- Write a SQL to find the number of employees inside the Office at “2019-04-01 19:05:00".
/*Table: employee_record
+-------------+------------+
| COLUMN_NAME | DATA_TYPE  |
+-------------+------------+
| emp_id      | int        |
| action      | varchar(3) |
| created_at  | datetime   |
+-------------+------------+
*/

WITH cte AS 
(SELECT emp_id,
SUM(CASE WHEN action = 'in' THEN 1 ELSE 0 END) AS inn,
SUM(CASE WHEN action = 'out' THEN 1 ELSE 0 END) AS outt
FROM employee_record
WHERE created_at <= '2019-04-01 19:05:00'
GROUP BY emp_id)

SELECT SUM(CASE WHEN inn<>outt THEN 1 ELSE 0 END) AS no_of_employees
FROM cte


-- Alternate Solution
  
WITH cte AS
(SELECT *, LEAD(created_at)OVER(PARTITION BY emp_id ORDER BY created_at) AS next_created_at
FROM employee_record)

SELECT count(*) AS no_of_employees
FROM cte
WHERE action = 'in'
AND '2019-04-01 19:05:00' BETWEEN created_at AND next_created_at

--

SELECT COUNT(DISTINCT emp_id) AS no_of_employees
FROM(
SELECT *, 
ROW_NUMBER()OVER(PARTITION BY emp_id ORDER BY created_at DESC) AS rnk
FROM employee_record
WHERE created_at <= '2019-04-01 19:05:00')a
WHERE rnk = 1 AND action = 'in'
