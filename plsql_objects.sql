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
