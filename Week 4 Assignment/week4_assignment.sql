-- Nairobi Academy — Introduction to SQL (PostgreSQL)
-- Schema: nairobi_academy
-- Sample rows for students and exam_results are aligned with the assignment narrative
-- (Esther Akinyi student_id 5 in Nakuru; result_id 5 corrected; result_id 9 removed).
-- If your course handout lists different rows, replace the INSERT blocks for Q8 and Q10.
--
-- Optional — uncomment for a clean re-run in the same database:
-- DROP SCHEMA IF EXISTS nairobi_academy CASCADE;

-- =============================================================================
-- SECTION A — Building the Database (DDL)
-- =============================================================================

-- Q1. Create schema nairobi_academy and use it
CREATE SCHEMA IF NOT EXISTS nairobi_academy;
SET search_path TO nairobi_academy;

-- Q2. students
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(1),
    date_of_birth DATE,
    class VARCHAR(10),
    city VARCHAR(50)
);

-- Q3. subjects
CREATE TABLE subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL UNIQUE,
    department VARCHAR(50),
    teacher_name VARCHAR(100),
    credits INT
);

-- Q4. exam_results (marks INT NOT NULL)
CREATE TABLE exam_results (
    result_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    marks INT NOT NULL,
    exam_date DATE,
    grade VARCHAR(2)
);

-- Q5. Add phone_number to students
ALTER TABLE students ADD COLUMN phone_number VARCHAR(20);

-- Q6. Rename credits to credit_hours on subjects
ALTER TABLE subjects RENAME COLUMN credits TO credit_hours;

-- Q7. Remove phone_number from students
ALTER TABLE students DROP COLUMN phone_number;

-- =============================================================================
-- SECTION B — Filling the Database (DML)
-- =============================================================================

-- Q8. Insert 10 students
INSERT INTO students (student_id, first_name, last_name, gender, date_of_birth, class, city) VALUES
(1, 'John', 'Kamau', 'M', '2007-04-12', 'Form 4', 'Nairobi'),
(2, 'Mary', 'Wanjiru', 'F', '2008-11-03', 'Form 2', 'Mombasa'),
(3, 'Peter', 'Ochieng', 'M', '2008-02-20', 'Form 3', 'Nairobi'),
(4, 'Ann', 'Otieno', 'F', '2009-06-15', 'Form 1', 'Kisumu'),
(5, 'Esther', 'Akinyi', 'F', '2007-09-01', 'Form 4', 'Nakuru'),
(6, 'David', 'Mwangi', 'M', '2008-07-22', 'Form 3', 'Eldoret'),
(7, 'Grace', 'Njeri', 'F', '2008-12-10', 'Form 2', 'Nairobi'),
(8, 'James', 'Kiprop', 'M', '2007-01-30', 'Form 4', 'Kisumu'),
(9, 'Lucy', 'Chebet', 'F', '2009-03-18', 'Form 1', 'Mombasa'),
(10, 'Samuel', 'Odhiambo', 'M', '2007-05-25', 'Form 4', 'Nairobi');

-- Q9. Insert 10 subjects (column is credit_hours after Q6)
INSERT INTO subjects (subject_id, subject_name, department, teacher_name, credit_hours) VALUES
(1, 'Mathematics', 'Sciences', 'Mr. Njoroge', 4),
(2, 'English', 'Languages', 'Ms. Adhiambo', 3),
(3, 'Biology', 'Sciences', 'Ms. Otieno', 4),
(4, 'History', 'Humanities', 'Mr. Waweru', 3),
(5, 'Kiswahili', 'Languages', 'Ms. Nduta', 3),
(6, 'Physics', 'Sciences', 'Mr. Kamande', 4),
(7, 'Geography', 'Humanities', 'Ms. Chebet', 3),
(8, 'Chemistry', 'Sciences', 'Ms. Muthoni', 4),
(9, 'Computer Studies', 'Sciences', 'Mr. Oduya', 3),
(10, 'Business Studies', 'Humanities', 'Ms. Wangari', 3);

-- Q10. Insert 10 exam results
INSERT INTO exam_results (result_id, student_id, subject_id, marks, exam_date, grade) VALUES
(1, 1, 1, 72, '2024-03-15', 'B'),
(2, 2, 2, 65, '2024-03-16', 'C'),
(3, 3, 3, 55, '2024-01-10', 'D'),
(4, 4, 4, 88, '2024-03-17', 'A'),
(5, 5, 5, 49, '2024-03-18', 'D'),
(6, 6, 6, 70, '2024-02-05', 'B'),
(7, 7, 7, 45, '2024-03-14', 'E'),
(8, 8, 8, 76, '2024-03-16', 'B'),
(9, 9, 9, 60, '2024-03-20', 'C'),
(10, 10, 10, 82, '2024-04-01', 'A');

-- Q11. Confirm 10 rows in each table
SELECT COUNT(*) AS student_count FROM students;
SELECT COUNT(*) AS subject_count FROM subjects;
SELECT COUNT(*) AS exam_result_count FROM exam_results;

-- Q12. Esther Akinyi (student_id 5) moved to Nairobi
UPDATE students SET city = 'Nairobi' WHERE student_id = 5;

-- Q13. Correct marks for result_id 5
UPDATE exam_results SET marks = 59 WHERE result_id = 5;

-- Q14. Cancelled exam result
DELETE FROM exam_results WHERE result_id = 9;

-- =============================================================================
-- SECTION C — Querying the Data (Filtering with WHERE)
-- =============================================================================

-- Q15. Students in Form 4
SELECT * FROM students WHERE class = 'Form 4';

-- Q16. Subjects in Sciences department
SELECT * FROM subjects WHERE department = 'Sciences';

-- Q17. Exam results with marks >= 70
SELECT * FROM exam_results WHERE marks >= 70;

-- Q18. Female students only
SELECT * FROM students WHERE gender = 'F';

-- Q19. Form 3 AND from Nairobi
SELECT * FROM students WHERE class = 'Form 3' AND city = 'Nairobi';

-- Q20. Form 2 OR Form 4
SELECT * FROM students WHERE class = 'Form 2' OR class = 'Form 4';

-- SECTION A — Building the Database (DDL)

-- Q1. Create schema nairobi_academy
CREATE SCHEMA IF NOT EXISTS nairobi_academy;
SET search_path TO nairobi_academy;


-- Q2. students
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(1),
    date_of_birth DATE,
    class VARCHAR(10),
    city VARCHAR(50)
);


-- Q3. subjects
CREATE TABLE subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL UNIQUE,
    department VARCHAR(50),
    teacher_name VARCHAR(100),
    credits INT
);


-- Q4. exam_results
CREATE TABLE exam_results (
    result_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    marks INT NOT NULL,
    exam_date DATE,
    grade VARCHAR(2)
);


-- Q5. Add phone_number to students
ALTER TABLE students ADD COLUMN phone_number VARCHAR(20);


-- Q6. Rename credits to credit_hours on subjects
ALTER TABLE subjects RENAME COLUMN credits TO credit_hours;


-- Q7. Remove phone_number from students
ALTER TABLE students DROP COLUMN phone_number;


-- Q8. Insert 10 students
INSERT INTO students (student_id, first_name, last_name, gender, date_of_birth, class, city) VALUES
(1,'Amina','Wanjiku','F','2008-03-12','Form 3','Nairobi'),
(2,'Brian','Ochieng','M','2007-07-25','Form 4','Mombasa'),
(3,'Cynthia','Mutua','F','2008-11-05','Form 3','Kisumu'),
(4,'David','Kamau','M','2007-02-18','Form 4','Nairobi'),
(5,'Esther','Akinyi','F','2009-06-30','Form 2','Nakuru'),
(6,'Felix','Otieno','M','2009-09-14','Form 2','Eldoret'),
(7,'Grace','Mwangi','F','2008-01-22','Form 3','Nairobi'),
(8,'Hassan','Abdi','M','2007-04-09','Form 4','Mombasa'),
(9,'Ivy','Chebet','F','2009-12-01','Form 2','Nakuru'),
(10,'James','Kariuki','M','2008-08-17','Form 3','Nairobi');

-- Q9. Insert 10 subjects (column is credit_hours after Q6)
INSERT INTO subjects (subject_id, subject_name, department, teacher_name, credit_hours) VALUES
(1,'Mathematics','Sciences','Mr. Njoroge',4),
(2,'English','Languages','Ms. Adhiambo',3),
(3,'Biology','Sciences','Ms. Otieno',4),
(4,'History','Humanities','Mr. Waweru',3),
(5,'Kiswahili','Languages','Ms. Nduta',3),
(6,'Physics','Sciences','Mr. Kamande',4),
(7,'Geography','Humanities','Ms. Chebet',3),
(8,'Chemistry','Sciences','Ms. Muthoni',4),
(9,'Computer Studies','Sciences','Mr. Oduya',3),
(10,'Business Studies','Humanities','Ms. Wangari',3);


-- Q10. Insert 10 exam results
INSERT INTO exam_results (result_id, student_id, subject_id, marks, exam_date, grade) VALUES
(1,1,1,78,'2024-03-15','B'),
(2,1,2,85,'2024-03-16','A'),
(3,2,1,92,'2024-03-15','A'),
(4,2,3,55,'2024-03-17','C'),
(5,3,2,49,'2024-03-16','D'),
(6,3,4,71,'2024-03-18','B'),
(7,4,1,88,'2024-03-15','A'),
(8,4,6,63,'2024-03-19','C'),
(9,5,5,39,'2024-03-20','F'),
(10,6,9,95,'2024-03-21','A');


-- Q11. Confirm 10 rows in each table
SELECT COUNT(*) AS student_count FROM students;
SELECT COUNT(*) AS subject_count FROM subjects;
SELECT COUNT(*) AS exam_result_count FROM exam_results;


-- Q12. Esther Akinyi (student_id 5) moved to Nairobi from Nakuru
UPDATE students SET city = 'Nairobi' WHERE student_id = 5;


-- Q13. Correct marks for result_id 5
UPDATE exam_results SET marks = 59 WHERE result_id = 5;


-- Q14. Cancelled exam result
DELETE FROM exam_results WHERE result_id = 9;


-- Q15. Students in Form 4
SELECT * FROM students WHERE class = 'Form 4';


-- Q16. Subjects in Sciences department
SELECT * FROM subjects WHERE department = 'Sciences';


-- Q17. Exam results with marks >= 70
SELECT * FROM exam_results WHERE marks >= 70;


-- Q18. Female students only
SELECT * FROM students WHERE gender = 'F';


-- Q19. Form 3 AND from Nairobi
SELECT * FROM students WHERE class = 'Form 3' AND city = 'Nairobi';


-- Q20. Form 2 OR Form 4
SELECT * FROM students WHERE class = 'Form 2' OR class = 'Form 4';


-- =============================================================================
-- PART 2 — BETWEEN, IN/NOT IN, LIKE, COUNT, CASE WHEN
-- =============================================================================

-- Part 2 Q1. Marks between 50 and 80 inclusive
SELECT * FROM exam_results WHERE marks BETWEEN 50 AND 80;


-- Part 2 Q2. Exams between 15 Mar 2024 and 18 Mar 2024 inclusive
SELECT * FROM exam_results WHERE exam_date BETWEEN '2024-03-15' AND '2024-03-18';


-- Part 2 Q3. Students in Nairobi, Mombasa, or Kisumu
SELECT * FROM students WHERE city IN ('Nairobi', 'Mombasa', 'Kisumu');


-- Part 2 Q4. Students NOT in Form 2 or Form 3
SELECT * FROM students WHERE class NOT IN ('Form 2', 'Form 3');

-- Part 2 Q5. First name starts with 'A' or 'E'
SELECT * FROM students WHERE first_name LIKE 'A%' OR first_name LIKE 'E%';


-- Part 2 Q6. Subject name contains 'Studies'
SELECT * FROM subjects WHERE subject_name LIKE '%Studies%';


-- Part 2 Q7. How many students in Form 3?
SELECT COUNT(*) AS form_3_student_count FROM students WHERE class = 'Form 3';


-- Part 2 Q8. How many exam results with mark >= 70?
SELECT COUNT(*) AS high_mark_count FROM exam_results WHERE marks >= 70;



-- Part 2 Q9. Performance label per exam result
SELECT
    result_id,
    student_id,
    subject_id,
    marks,
    CASE
        WHEN marks >= 80 THEN 'Distinction'
        WHEN marks >= 60 THEN 'Merit'
        WHEN marks >= 40 THEN 'Pass'
        ELSE 'Fail'
    END AS performance
FROM exam_results;


-- Part 2 Q10. Senior vs Junior by class
SELECT
    first_name,
    last_name,
    class,
    CASE
        WHEN class IN ('Form 3', 'Form 4') THEN 'Senior'
        WHEN class IN ('Form 2', 'Form 1') THEN 'Junior'
    END AS student_level
FROM students;