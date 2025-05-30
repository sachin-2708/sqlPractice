-- Write an SQL query to find the course names where the average score (calculated only for students who have scored less than 70 in at least one course) is greater than 70. 
-- Sort the result by the average score in descending order.

/*Table: students
+-------------+------------+
| COLUMN_NAME | DATA_TYPE  |
+-------------+------------+
| student_id  | int        |
| course_name | VARCHAR(10)|
| score       | int        |
+-------------+------------+
*/

SELECT course_name, AVG(score) AS avg_score 
FROM students
WHERE student_id IN 
  (SELECT distinct(student_id)
FROM students
WHERE score < 70)
GROUP BY course_name
HAVING AVG(score) > 70
ORDER BY avg_score DESC
