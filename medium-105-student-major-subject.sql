-- You are provided with information about students enrolled in various courses at a university. Each student can be enrolled in multiple courses, and for each course, it is specified whether the course is a major or an elective for the student.
-- Write a SQL query to generate a report that lists the primary (major_flag='Y') course for each student. If a student is enrolled in only one course, that course should be considered their primary course by default irrespective of the flag. Sort the output by student_id.
/*
Table: student_courses
+-------------+------------+
| COLUMN_NAME | DATA_TYPE  |
+-------------+------------+
| student_id  | int        |
| course_id   | int        |
| major_flag  | varchar(1) |
+-------------+------------+
*/

select student_id, course_id
from student_courses
where major_flag = 'Y'
or student_id in (
select student_id
from student_courses
group by student_id
having count(*) = 1)

-- Alternate Solution

with cte as
(select *,
row_number()over(partition by student_id order by
                 case when major_flag = 'Y' then 1 else 0 end desc) as rn
from student_courses)

select student_id, course_id
from cte
where rn = 1
