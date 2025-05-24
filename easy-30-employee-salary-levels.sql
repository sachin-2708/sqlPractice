-- Write an SQL query to find the average salaries of employees at each salary level. "Salary Level" are defined as per below conditions:
-- If the salary is less than 50000, label it as "Low".
-- If the salary is between 50000 and 100000 (inclusive), label it as "Medium".
-- If the salary is greater than 100000, label it as "High".
-- Round the average to nearest integer. Display the output in ascending order of salary level.
/*
Tables: Employees
+---------------+--------------+
| COLUMN_NAME   | DATA_TYPE    |
+---------------+--------------+
| employee_id   | int          |
| employee_name | varchar(20) |
| salary        | int          |
+---------------+--------------+
*/

WITH sal_category AS (                    -- CTE is used to categorise the salary levels and then use it in main query from easy group by
SELECT 
  	employee_id, 
  	salary,
	CASE
    	WHEN salary < 50000 THEN 'Low'
        WHEN salary BETWEEN 50000 AND 100000 THEN 'Medium'
        ELSE 'High'
        END AS salary_level
FROM employees
)

SELECT 
	salary_level,
    ROUND(AVG(salary),0) AS avg_salary
FROM sal_category
GROUP BY salary_level
ORDER BY salary_level
