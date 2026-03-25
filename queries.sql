-- 1. View all students
SELECT * FROM Students;

-- 2. View all courses with lecturer names
SELECT c.course_code, c.course_name, c.credits, l.full_name AS lecturer_name
FROM Courses c
JOIN Lecturers l ON c.lecturer_id = l.lecturer_id;

-- 3. View student enrollments
SELECT s.full_name AS student_name, c.course_name, e.grade
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- 4. Count number of students enrolled in each course
SELECT c.course_name, COUNT(e.student_id) AS total_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- 5. Find students with grade A
SELECT s.full_name, c.course_name, e.grade
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE e.grade = 'A';

-- 6. Find courses with more than 1 student
SELECT c.course_name, COUNT(*) AS student_count
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
GROUP BY c.course_name
HAVING COUNT(*) > 1;

-- 7. Students not enrolled in any course
SELECT s.full_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;
