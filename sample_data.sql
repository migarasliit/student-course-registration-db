INSERT INTO Students (student_id, full_name, email, department, year_of_study)
VALUES (1, 'Migara Wijesinghe', 'migara@gmail.com', 'IT', 3);

INSERT INTO Students (student_id, full_name, email, department, year_of_study)
VALUES (2, 'Nimal Perera', 'nimal@gmail.com', 'SE', 2);

INSERT INTO Students (student_id, full_name, email, department, year_of_study)
VALUES (3, 'Kavindi Silva', 'kavindi@gmail.com', 'CS', 4);

INSERT INTO Students (student_id, full_name, email, department, year_of_study)
VALUES (4, 'Ayesha Fernando', 'ayesha@gmail.com', 'IT', 1);

INSERT INTO Lecturers (lecturer_id, full_name, email, specialization)
VALUES (101, 'Dr. Perera', 'perera@univ.edu', 'Database Systems');

INSERT INTO Lecturers (lecturer_id, full_name, email, specialization)
VALUES (102, 'Ms. Fernando', 'fernando@univ.edu', 'Software Engineering');

INSERT INTO Lecturers (lecturer_id, full_name, email, specialization)
VALUES (103, 'Mr. Silva', 'silva@univ.edu', 'Web Development');

INSERT INTO Courses (course_id, course_code, course_name, credits, lecturer_id)
VALUES (1001, 'DBS301', 'Database Systems', 3, 101);

INSERT INTO Courses (course_id, course_code, course_name, credits, lecturer_id)
VALUES (1002, 'SE302', 'Software Engineering', 4, 102);

INSERT INTO Courses (course_id, course_code, course_name, credits, lecturer_id)
VALUES (1003, 'WD201', 'Web Development', 3, 103);

INSERT INTO Courses (course_id, course_code, course_name, credits, lecturer_id)
VALUES (1004, 'CN202', 'Computer Networks', 3, 102);

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date, grade)
VALUES (1, 1, 1001, SYSDATE, 'A');

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date, grade)
VALUES (2, 1, 1002, SYSDATE, 'B');

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date, grade)
VALUES (3, 2, 1001, SYSDATE, 'A');

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date, grade)
VALUES (4, 2, 1003, SYSDATE, 'C');

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date, grade)
VALUES (5, 3, 1002, SYSDATE, 'B');

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date, grade)
VALUES (6, 3, 1004, SYSDATE, NULL);
