INSERT INTO Students VALUES (1, 'Migara Wijesinghe', 'migara@gmail.com', 'IT', 3);
INSERT INTO Students VALUES (2, 'Nimal Perera', 'nimal@gmail.com', 'SE', 2);
INSERT INTO Students VALUES (3, 'Kavindi Silva', 'kavindi@gmail.com', 'CS', 4);

INSERT INTO Lecturers VALUES (101, 'Dr. Perera', 'perera@univ.edu', 'Database Systems');
INSERT INTO Lecturers VALUES (102, 'Ms. Fernando', 'fernando@univ.edu', 'Software Engineering');

INSERT INTO Courses VALUES (1001, 'DBS301', 'Database Systems', 3, 101);
INSERT INTO Courses VALUES (1002, 'SE302', 'Software Engineering', 4, 102);
INSERT INTO Courses VALUES (1003, 'WD201', 'Web Development', 3, 102);

INSERT INTO Enrollments VALUES (1, 1, 1001, SYSDATE, 'A');
INSERT INTO Enrollments VALUES (2, 1, 1002, SYSDATE, 'B');
INSERT INTO Enrollments VALUES (3, 2, 1001, SYSDATE, 'A');
INSERT INTO Enrollments VALUES (4, 3, 1003, SYSDATE, 'B');
