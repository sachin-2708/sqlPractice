-- A school maintains a record of students' SAT scores along with the class they belong to. The academic team wants to analyze which two students in each class have the closest SAT scores. 
-- This helps in grouping students with similar performance for peer learning programs.
-- Write a query to return, for each class, the pair of students with the smallest absolute difference in their SAT scores.
-- Return the class name, the two students' names, and their absolute score difference. Order by class.
-- Note: In each pair, the student with the lexicographically smaller name (alphabetically first) should appear as student1. This helps in consistent comparison and verification of results.
/*
Table: scores
+--------------+----------+
| COLUMN_NAME  | DATA_TYPE|
+--------------+----------+
| student_name | VARCHAR  | 
| class        | VARCHAR  |
| score        | INT      | 
+-------------------------+
*/

with student_pairs as
(select 
	s1.class,
    s1.student_name as student1,
    s2.student_name as student2,
    abs(s1.score - s2.score) as score_diff
from scores s1
join scores s2 on 
 	s1.class = s2.class 
 	and s1.student_name < s2.student_name)

, ranked_pairs as
(select *, 
 rank()over(partition by class order by score_diff) as rn
from student_pairs)

select 
	class, 
    student1,
    student2,
    score_diff
from ranked_pairs
where rn = 1
order by class
