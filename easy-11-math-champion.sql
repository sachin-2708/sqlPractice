-- Easy Problem 11th Math Champion
-- You are provided with two tables: Students and Grades.
-- Write a SQL query to find students who have higher grade in Math than the average grades of all the students together in Math. 
-- Display student name and grade in Math order by grades.

 /*Tables: Students
+--------------+-------------+
| COLUMN_NAME  | DATA_TYPE   |
+--------------+-------------+
| class_id     | int         |
| student_id   | int         |
| student_name | varchar(20) |
+--------------+-------------+

Tables: Grades
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| student_id  | int         |
| subject     | varchar(20) |
| grade       | int         |
+-------------+-------------+
*/

SELECT s.student_name, 
	g.grade as math_grade
FROM students s
INNER JOIN grades g ON
g.student_id = s.student_id
WHERE subject = 'Math'
AND g.grade > (SELECT AVG(grade)      -- Subquery to get the average grade in math
             FROM grades
             WHERE subject = 'Math')
ORDER BY math_grade;
