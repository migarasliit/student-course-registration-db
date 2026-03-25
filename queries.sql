-- 1. View all students
SELECT * FROM Students;

-- 2. View all lecturers
SELECT * FROM Lecturers;

-- 3. View all courses
SELECT * FROM Courses;

-- 4. Display courses with lecturer names
SELECT
    c.course_code,
    c.course_name,
    c.credits,
    l.full_name AS lecturer_name,
    l.specialization
FROM Courses c
JOIN Lecturers l
    ON c.lecturer_id = l.lecturer_id;

-- 5. Display student enrollments with course details
SELECT
    s.full_name AS student_name,
    s.department,
    c.course_name,
    c.course_code,
    e.grade,
    e.enrollment_date
FROM Enrollments e
JOIN Students s
    ON e.student_id = s.student_id
JOIN Courses c
    ON e.course_id = c.course_id
ORDER BY s.full_name;

-- 6. Count number of students enrolled in each course
SELECT
    c.course_name,
    COUNT(e.student_id) AS total_students
FROM Courses c
LEFT JOIN Enrollments e
    ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY total_students DESC;

-- 7. Find students who received grade A
SELECT
    s.full_name AS student_name,
    c.course_name,
    e.grade
FROM Enrollments e
JOIN Students s
    ON e.student_id = s.student_id
JOIN Courses c
    ON e.course_id = c.course_id
WHERE e.grade = 'A';

-- 8. Find courses with more than 1 enrolled student
SELECT
    c.course_name,
    COUNT(e.student_id) AS student_count
FROM Enrollments e
JOIN Courses c
    ON e.course_id = c.course_id
GROUP BY c.course_name
HAVING COUNT(e.student_id) > 1;

-- 9. List students not enrolled in any course
SELECT
    s.student_id,
    s.full_name
FROM Students s
LEFT JOIN Enrollments e
    ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

-- 10. Display average academic performance by course
SELECT
    c.course_name,
    ROUND(AVG(
        CASE e.grade
            WHEN 'A' THEN 4
            WHEN 'B' THEN 3
            WHEN 'C' THEN 2
            WHEN 'D' THEN 1
            WHEN 'F' THEN 0
        END
    ), 2) AS average_grade_point
FROM Enrollments e
JOIN Courses c
    ON e.course_id = c.course_id
WHERE e.grade IS NOT NULL
GROUP BY c.course_name;

-- 11. Show number of courses each student has enrolled in
SELECT
    s.full_name AS student_name,
    COUNT(e.course_id) AS total_courses
FROM Students s
LEFT JOIN Enrollments e
    ON s.student_id = e.student_id
GROUP BY s.full_name
ORDER BY total_courses DESC;

-- 12. Find students enrolled in Database Systems
SELECT
    s.full_name AS student_name,
    s.department
FROM Students s
JOIN Enrollments e
    ON s.student_id = e.student_id
JOIN Courses c
    ON e.course_id = c.course_id
WHERE c.course_name = 'Database Systems';

-- 13. Find the lecturer who teaches the highest number of courses
SELECT
    l.full_name AS lecturer_name,
    COUNT(c.course_id) AS total_courses
FROM Lecturers l
LEFT JOIN Courses c
    ON l.lecturer_id = c.lecturer_id
GROUP BY l.full_name
ORDER BY total_courses DESC;

-- 14. Find students who are enrolled in more than one course
SELECT
    s.full_name AS student_name,
    COUNT(e.course_id) AS enrolled_courses
FROM Students s
JOIN Enrollments e
    ON s.student_id = e.student_id
GROUP BY s.full_name
HAVING COUNT(e.course_id) > 1;

-- 15. Display courses that currently have no enrollments
SELECT
    c.course_id,
    c.course_name
FROM Courses c
LEFT JOIN Enrollments e
    ON c.course_id = e.course_id
WHERE e.course_id IS NULL;
