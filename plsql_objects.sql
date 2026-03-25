-- Procedure to enroll a student in a course
CREATE OR REPLACE PROCEDURE Enroll_Student (
    p_enrollment_id IN NUMBER,
    p_student_id IN NUMBER,
    p_course_id IN NUMBER
)
AS
BEGIN
    INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date, grade)
    VALUES (p_enrollment_id, p_student_id, p_course_id, SYSDATE, NULL);

    INSERT INTO Audit_Log (log_id, action_description, action_date)
    VALUES (p_enrollment_id, 'Student ' || p_student_id || ' enrolled in course ' || p_course_id, SYSDATE);

    COMMIT;
END;
/

-- Function to get total courses of a student
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

-- Trigger to log new enrollment inserts
CREATE OR REPLACE TRIGGER trg_after_enrollment
AFTER INSERT ON Enrollments
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (log_id, action_description, action_date)
    VALUES (
        :NEW.enrollment_id + 1000,
        'New enrollment added for student ' || :NEW.student_id || ' to course ' || :NEW.course_id,
        SYSDATE
    );
END;
/
