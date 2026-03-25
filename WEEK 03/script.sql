--(1)
--(a)
-- Step 1: Create incomplete type for dept_t
CREATE TYPE dept_t;
/

-- Step 2: Create emp_t type with REF to dept_t
CREATE TYPE emp_t AS OBJECT (
    empno      CHAR(6),
    firstname  VARCHAR2(12),
    lastname   VARCHAR2(15),
    workdept   REF dept_t,
    sex        CHAR(1),
    birthdate  DATE,
    salary     NUMBER(8,2)
);
/

-- Step 3: Now create dept_t with REF to emp_t and REF to dept_t
CREATE TYPE dept_t AS OBJECT (
    deptno     CHAR(3),
    deptname   VARCHAR2(36),
    mgrno      REF emp_t,
    admrdept   REF dept_t
);
/

--(b)
CREATE TABLE ordept OF dept_t (
    deptno PRIMARY KEY
)
/

CREATE TABLE oremp OF emp_t (
    empno PRIMARY KEY
)
/

-- Set scope for REF columns
ALTER TABLE oremp
    ADD SCOPE FOR (workdept) IS ordept
/

ALTER TABLE ordept
    ADD SCOPE FOR (mgrno) IS oremp
/

ALTER TABLE ordept
    ADD SCOPE FOR (admrdept) IS ordept
/

--(c)
-- Insert into OREMP with NULL workdept
INSERT INTO oremp VALUES ('000010','CHRISTINE','HAAS',NULL,'F',DATE '1953-08-14',72750)
/

INSERT INTO oremp VALUES ('000020','MICHAEL','THOMPSON',NULL,'M',DATE '1968-02-02',61250)
/

INSERT INTO oremp VALUES ('000030','SALLY','KWAN',NULL,'F',DATE '1971-05-11',58250)
/

INSERT INTO oremp VALUES ('000060','IRVING','STERN',NULL,'M',DATE '1965-07-07',55555)
/

INSERT INTO oremp VALUES ('000070','EVA','PULASKI',NULL,'F',DATE '1973-05-26',56170)
/

INSERT INTO oremp VALUES ('000050','JOHN','GEYER',NULL,'M',DATE '1955-09-15',60175)
/

INSERT INTO oremp VALUES ('000090','EILEEN','HENDERSON',NULL,'F',DATE '1961-05-15',49750)
/

INSERT INTO oremp VALUES ('000100','THEODORE','SPENSER',NULL,'M',DATE '1976-12-18',46150)
/

-- Insert into ORDEPT with NULL admrdept
INSERT INTO ordept VALUES ('A00','SPIFFY COMPUTER SERVICE DIV.',
    (SELECT REF(e) FROM oremp e WHERE empno='000010'), NULL)
/

INSERT INTO ordept VALUES ('B01','PLANNING',
    (SELECT REF(e) FROM oremp e WHERE empno='000020'), NULL)
/

INSERT INTO ordept VALUES ('C01','INFORMATION CENTRE',
    (SELECT REF(e) FROM oremp e WHERE empno='000030'), NULL)
/

INSERT INTO ordept VALUES ('D01','DEVELOPMENT CENTRE',
    (SELECT REF(e) FROM oremp e WHERE empno='000060'), NULL)
/

-- Update workdept in OREMP
UPDATE oremp e
SET workdept = (SELECT REF(d) FROM ordept d WHERE d.deptno='A00')
WHERE empno='000010'
/

UPDATE oremp e
SET workdept = (SELECT REF(d) FROM ordept d WHERE d.deptno='B01')
WHERE empno IN ('000020','000090','000100')
/

UPDATE oremp e
SET workdept = (SELECT REF(d) FROM ordept d WHERE d.deptno='C01')
WHERE empno IN ('000030','000050')
/

UPDATE oremp e
SET workdept = (SELECT REF(d) FROM ordept d WHERE d.deptno='D01')
WHERE empno IN ('000060','000070')
/

-- Update admrdept in ORDEPT
UPDATE ordept d
SET admrdept = (SELECT REF(ad) FROM ordept ad WHERE ad.deptno='A00')
WHERE deptno IN ('A00','B01','C01')
/

UPDATE ordept d
SET admrdept = (SELECT REF(ad) FROM ordept ad WHERE ad.deptno='C01')
WHERE deptno='D01'
/

--(2)
--(a)
SELECT d.deptname,
       DEREF(d.mgrno).lastname AS manager_lastname
FROM ordept d
/

--(b)
SELECT e.empno,
       e.lastname,
       DEREF(e.workdept).deptname AS department_name
FROM oremp e
/

--(c)
SELECT d.deptno,
       d.deptname,
       DEREF(d.admrdept).deptname AS admin_dept_name
FROM ordept d
/

--(d)
SELECT d.deptno,
       d.deptname,
       DEREF(d.admrdept).deptname AS admin_dept_name,
       DEREF(DEREF(d.admrdept).mgrno).lastname AS admin_mgr_lastname
FROM ordept d
/

--(e)
SELECT e.empno,
       e.firstname,
       e.lastname,
       e.salary,
       DEREF(DEREF(e.workdept).mgrno).lastname AS manager_lastname,
       DEREF(DEREF(e.workdept).mgrno).salary   AS manager_salary
FROM oremp e
/

--(f)
SELECT DEREF(e.workdept).deptno   AS deptno,
       DEREF(e.workdept).deptname AS deptname,
       e.sex,
       AVG(e.salary) AS avg_salary
FROM oremp e
GROUP BY DEREF(e.workdept).deptno,
         DEREF(e.workdept).deptname,
         e.sex
/
