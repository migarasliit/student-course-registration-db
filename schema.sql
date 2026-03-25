CREATE TABLE Students (
    student_id NUMBER PRIMARY KEY,
    full_name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    department VARCHAR2(50) NOT NULL,
    year_of_study NUMBER(1) CHECK (year_of_study BETWEEN 1 AND 4)
);

CREATE TABLE Lecturers (
    lecturer_id NUMBER PRIMARY KEY,
    full_name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    specialization VARCHAR2(100) NOT NULL
);

CREATE TABLE Courses (
    course_id NUMBER PRIMARY KEY,
    course_code VARCHAR2(10) UNIQUE NOT NULL,
    course_name VARCHAR2(100) NOT NULL,
    credits NUMBER(2) CHECK (credits > 0),
    lecturer_id NUMBER NOT NULL,
    CONSTRAINT fk_course_lecturer
        FOREIGN KEY (lecturer_id) REFERENCES Lecturers(lecturer_id)
);

CREATE TABLE Enrollments (
    enrollment_id NUMBER PRIMARY KEY,
    student_id NUMBER NOT NULL,
    course_id NUMBER NOT NULL,
    enrollment_date DATE DEFAULT SYSDATE,
    grade VARCHAR2(2),
    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id) REFERENCES Students(student_id),
    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    CONSTRAINT uq_student_course UNIQUE (student_id, course_id),
    CONSTRAINT chk_grade
        CHECK (grade IN ('A', 'B', 'C', 'D', 'F') OR grade IS NULL)
);

CREATE TABLE Audit_Log (
    log_id NUMBER PRIMARY KEY,
    action_description VARCHAR2(200) NOT NULL,
    action_date DATE DEFAULT SYSDATE
);
