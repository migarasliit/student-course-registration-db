# Student Course Registration Database System

## Overview
This mini project demonstrates my understanding of relational database design, SQL querying, and Oracle-style PL/SQL concepts.

The system models a simple university course registration process where students can enroll in courses taught by lecturers. It includes database schema creation, sample data insertion, reporting queries, and PL/SQL objects such as a procedure, function, and trigger.

## Features
- Manage students, lecturers, courses, and enrollments
- Apply primary keys, foreign keys, unique constraints, and check constraints
- Run SQL queries for reporting and analysis
- Use PL/SQL objects such as procedures, functions, and triggers
- Maintain a simple audit log for enrollment-related actions

## Technologies / Concepts Used
- SQL
- Oracle-style PL/SQL
- Relational Database Design
- Normalization
- Joins
- Aggregation
- Subqueries
- Constraints
- Audit Logging

## Project Structure
- `schema.sql` – creates the database tables
- `sample_data.sql` – inserts sample records
- `queries.sql` – contains useful SQL queries for reports and analysis
- `plsql_objects.sql` – contains PL/SQL procedure, function, and trigger

## Database Entities
- Students
- Lecturers
- Courses
- Enrollments
- Audit_Log

## Relationships
- One lecturer can teach many courses
- One student can enroll in many courses
- One course can have many students
- The `Enrollments` table resolves the many-to-many relationship between students and courses

## Learning Outcome
This project helped me practice:
- designing relational schemas
- writing SQL queries for data retrieval and reporting
- using constraints for data integrity
- writing Oracle-style PL/SQL objects

## Note
This project is written using Oracle-style SQL / PL-SQL syntax for learning and portfolio purposes.

## Author
Migara Wijesinghe
