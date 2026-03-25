 -- Procedure to enroll a student in a course
CREATE OR REPLACE PROCEDURE Enroll_Student (
    p_enrollment_id IN NUMBER,
    p_student_id IN NUMBER,
    p_course_id IN NUMBER
)
AS
    v_log_id NUMBER;
BEGIN
    INSERT INTO Enrollments (
        enrollment_id,
        student_id,
        course_id,
        enrollment_date,
        grade
    )
    VALUES (
        p_enrollment_id,
        p_student_id,
        p_course_id,
        SYSDATE,
        NULL
    );

    SELECT NVL(MAX(log_id), 0) + 1
    INTO v_log_id
    FROM Audit_Log;

    INSERT INTO Audit_Log (
        log_id,
        action_description,
        action_date
    )
    VALUES (
        v_log_id,
        'Student ID ' || p_student_id || ' enrolled in Course ID ' || p_course_id,
        SYSDATE
    );

    COMMIT;
END;
/

-- Function to get total courses followed by a student
CREATE OR REPLACE FUNCTION Get_Total_Courses (
    p_student_id IN NUMBER
)
RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_total
    FROM Enrollments
    WHERE student_id = p_student_id;

    RETURN v_total;
END;
/

-- Trigger to log every new enrollment
CREATE OR REPLACE TRIGGER trg_after_enrollment
AFTER INSERT ON Enrollments
FOR EACH ROW
DECLARE
    v_log_id NUMBER;
BEGIN
    SELECT NVL(MAX(log_id), 0) + 1
    INTO v_log_id
    FROM Audit_Log;

    INSERT INTO Audit_Log (
        log_id,
        action_description,
        action_date
    )
    VALUES (
        v_log_id,
        'New enrollment added for student ID ' || :NEW.student_id ||
        ' to course ID ' || :NEW.course_id,
        SYSDATE
    );
END;
/

-- Procedure to update a student's grade
CREATE OR REPLACE PROCEDURE Update_Student_Grade (
    p_student_id IN NUMBER,
    p_course_id IN NUMBER,
    p_grade IN VARCHAR2
)
AS
    v_log_id NUMBER;
BEGIN
    UPDATE Enrollments
    SET grade = p_grade
    WHERE student_id = p_student_id
      AND course_id = p_course_id;

    SELECT NVL(MAX(log_id), 0) + 1
    INTO v_log_id
    FROM Audit_Log;

    INSERT INTO Audit_Log (
        log_id,
        action_description,
        action_date
    )
    VALUES (
        v_log_id,
        'Grade updated for student ID ' || p_student_id ||
        ' in course ID ' || p_course_id || ' to grade ' || p_grade,
        SYSDATE
    );

    COMMIT;
END;
/
-- Example anonymous block to test the function
DECLARE
    v_total NUMBER;
BEGIN
    v_total := Get_Total_Courses(1);
    DBMS_OUTPUT.PUT_LINE('Total courses followed by student 1: ' || v_total);
END;
/
