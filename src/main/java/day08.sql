-------------- Day 08 -----------
CREATE TABLE new_workers (
  id CHAR(9),
  name VARCHAR(50),
  state VARCHAR(50),
  salary SMALLINT,
  company VARCHAR(20),
  number_of_employees numeric(5)

);


INSERT INTO new_workers VALUES(123451760, 'Ali Can', 'Pennsylvania', 8000, 'GOOGLE', 90000);
INSERT INTO new_workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM', 34500);
INSERT INTO new_workers VALUES(456789012, 'Veli Han', 'Arizona', 4000, 'GOOGLE', 90000);
INSERT INTO new_workers VALUES(234567890, 'Ayse Gul', 'Florida', 1500, 'APPLE', 45500);
INSERT INTO new_workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM', 23700);
INSERT INTO new_workers VALUES(567890123, 'Yusuf Arturk', 'Washington', 8000, 'APPLE', 45500);
INSERT INTO new_workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE', 90000);
INSERT INTO new_workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT', 60000);
INSERT INTO new_workers VALUES(456789012, 'Ayse Gul', 'Texas', 1500, 'GOOGLE', 90000);
INSERT INTO new_workers VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM', 23700);
INSERT INTO new_workers VALUES(123456710, 'Ali Can', 'Pennsylvania', 5000, 'IBM', 23700);
INSERT INTO new_workers VALUES(785690123, 'Fatih Tamer', 'Texas', 9000, 'MICROSOFT', 60000);
INSERT INTO new_workers VALUES(123456789, 'John Walker', 'Florida', 5000, 'GOOGLE', 90000);


SELECT * FROM  new_workers;

-- Find total salry for each worker

SELECT name, SUM(salary) "total_salary"
FROM new_workers
GROUP BY name;

-- Find total number of workers for each state and order them in descending order

SELECT state, COUNT(id) AS total_num_of_workers
FROM new_workers
GROUP BY state
ORDER BY total_num_of_workers DESC;


-- Find total number of workers for each company which is paying salary more than 5000
SELECT company, COUNT(id) AS total_num_of_workers
FROM new_workers
WHERE salary > 5000
GROUP BY company


-- Find total number of workers for each state that has more than 100,000 workers

SELECT state, COUNT(name) AS total_num_of_workers
FROM new_workers
GROUP BY state
HAVING SUM(number_of_employees) > 100000;


-- Find the minimum salary values that are above 2000 per company

SELECT company, MIN(salary) AS min_salary
FROM new_workers
GROUP BY company
HAVING MIN(salary) > 2000;


-- Find the maximum salary values that are above 7000 per company

SELECT company, MAX(salary) AS max_salary
FROM new_workers
GROUP BY company
HAVING MAX(salary) > 7000;



SELECT * FROM  new_workers;


-------------------- MovieReviews Table -----------------
-- Find movies with more than 2 reviews AND the average rating is more than 4

SELECT movie_name, COUNT(reviewer) AS total_reviews ,  ROUND(AVG(rating) , 1)  AS avg_rating
FROM MovieReviews
GROUP BY movie_name
HAVING COUNT(reviewer) > 2 AND ROUND(AVG(rating) , 1) > 4;

--COUNT(*) => ALL values in that column will be counted EVEN THE NULL VALUES
--COUNT(reviewer) => null values won't be counted

-- Find the reviewer who has reviewed at least 2 movies with average rating of 3
SELECT reviewer,
COUNT (reviewer) AS num_of_movies_reviewed,
ROUND (AVG(rating), 1) AS avg_rating
FROM MovieReviews
GROUP BY reviewer
HAVING COUNT(reviewer) >=2 AND ROUND(AVG(rating), 1) > 3


-- Find the number of movies reviewed on each date where at least 2 movies are reviewed

SELECT review_date, COUNT(DISTINCT movie_name) AS movies_reviewed
FROM MovieReviews
GROUP BY review_date
HAVING COUNT(DISTINCT movie_name) >= 2;


SELECT * FROM MovieReviews;



------------------------ UNION, UNION ALL, INTERSECT, EXCEPT ------------------------
CREATE TABLE alice_books (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(100)
);



INSERT INTO alice_books (book_id, book_title)
VALUES
    (1, 'The Great Gatsby'),
    (2, 'To Kill a Mockingbird'),
    (3, 'Pride and Prejudice'),
    (4, 'Jane Eyre'),
    (5, 'Animal Farm');



CREATE TABLE bob_books (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(100)
);

INSERT INTO bob_books (book_id, book_title)
VALUES
    (2, 'To Kill a Mockingbird'),
    (4, '1984'),
    (6, 'The Catcher in the Rye'),
    (5, 'Animal Farm');



CREATE TABLE john_books (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(100)
);


INSERT INTO john_books (book_id, book_title)
VALUES
    (9, 'Psychology of Money'),
    (12, 'Political Economy'),
    (7, 'Computational Thinking'),
    (5, 'Animal Farm');


--------------- UNION OPERATOR -----------------
-- It is used to combine or unite the result of 2 or more queries in ONE COLUMN.
-- It returns UNIQUE values only (repeated values/data/records are printed only ONCE)
-- Data type of the columns should be SAME; number of columns should be SAME; order of the columns (in terms of data type type) should be SAME
-- Names of the columns can be DIFFERENT as long as their data type is SAME
-- The columns can be from different tables
-- We can use UNION Operator for more than 2 SELECT queries as well




-- Find the title of the books read by Alice

SELECT book_title
FROM alice_books;


-- Find the title of the books read by Bob

SELECT book_title
FROM bob_books;


-- Create a list of all the books read by Alice and Bob (without duplicate values)

SELECT book_title
FROM alice_books
UNION
SELECT book_title
FROM bob_books


-- Can we use UNION operator for more than 2 SELECT queries?

SELECT book_title
FROM alice_books
UNION
SELECT book_title
FROM bob_books
UNION
SELECT book_title
FROM john_books


--------------- UNION ALL OPERATOR -----------------
-- It is used to combine or unite the result of 2 or more queries in ONE COLUMN.
-- It does NOT return UNIQUE values (repeated values/data/records are printed)
-- Data type of the columns should be SAME; number of columns should be SAME; order of the columns (in terms of data type type) should be SAME
-- Names of the columns can be DIFFERENT as long as their data type is SAME
-- The columns can be from different tables
-- We can use UNION ALL Operator for more than 2 SELECT queries as well



-- Create a list of all the books read by Alice and Bob (WITH duplicate values)

SELECT book_title
FROM alice_books
UNION ALL
SELECT book_title
FROM bob_books;

-- Can we use UNION ALL operator for more than 2 SELECT queries?

SELECT book_title
FROM alice_books
UNION ALL
SELECT book_title
FROM bob_books
UNION ALL
SELECT book_title
FROM john_books;

--------------- INTERSECT OPERATOR -----------------
-- It is used to combine or unite the result of 2 or more queries in ONE COLUMN.
-- It returns COMMON values.
-- It reurns UNIQUE (repeated values/data/records are printed ONLY ONCE)
-- Data type of the columns should be SAME; number of columns should be SAME; order of the columns (in terms of data type type) should be SAME
-- Names of the columns can be DIFFERENT as long as their data type is SAME
-- The columns can be from different tables
-- We can use INTERSECT Operator for more than 2 SELECT queries as well




-- Create a list of all the books read by BOTH Alice and Bob (COMMON values)

SELECT book_title
FROM alice_books
INTERSECT
SELECT book_title
FROM bob_books;

-- Can we use INTERSECT operator for more than 2 SELECT queries?

SELECT book_title
FROM alice_books
INTERSECT
SELECT book_title
FROM bob_books
INTERSECT
SELECT book_title
FROM john_books;


--------------- EXCEPT OPERATOR -----------------
-- It is used to combine or unite the result of 2 or more queries in ONE COLUMN.
-- It extracts the result of FIRST query from the result of the second query
-- It reurns UNIQUE (repeated values/data/records are printed ONLY ONCE)
-- Data type of the columns should be SAME; number of columns should be SAME; order of the columns (in terms of data type type) should be SAME
-- Names of the columns can be DIFFERENT as long as their data type is SAME
-- The columns can be from different tables
-- We can use INTERSECT Operator for more than 2 SELECT queries as well


SELECT book_title
FROM alice_books

EXCEPT

SELECT book_title
FROM bob_books;


-- Can we use EXCEPT operator for more than 2 SELECT queries?

SELECT book_title
FROM alice_books
EXCEPT
SELECT book_title
FROM bob_books
EXCEPT
SELECT book_title
FROM john_books;


--Data type of the columns should be SAME; number of columns should be SAME; order of the columns (in terms of data type type) should be SAME

-- SELECT  book_title , book_id
-- FROM alice_books
-- EXCEPT
-- SELECT book_title
-- FROM bob_books

-- SELECT book_id , book_title
-- FROM alice_books
-- EXCEPT
-- SELECT book_title
-- FROM bob_books


------------------------------------------------

CREATE TABLE employees_a (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(30),
    department VARCHAR(20)
);

INSERT INTO employees_a (employee_id, employee_name, department)
VALUES
    (1, 'John Smith', 'HR'),
    (2, 'Alice Johnson', 'IT'),
    (3, 'Bob Williams', 'Finance'),
    (4, 'Eva Davis', 'Marketing');



CREATE TABLE employees_b (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(30),
    department VARCHAR(20)
);

INSERT INTO employees_b (employee_id, employee_name, department)
VALUES
    (2, 'Alice Johnson', 'IT'),
    (3, 'Bob Williams', 'Finance'),
    (5, 'Charlie Brown', 'Sales'),
    (6, 'Grace Miller', 'HR');


-- Find the unique list of all employees across both the tables

SELECT employee_name
FROM employees_a
UNION
SELECT employee_name
FROM employees_b;


-- Find the list of all employees from both tables who work in HR


SELECT employee_name
FROM employees_a
WHERE department = 'HR'
UNION ALL
SELECT employee_name
FROM employees_b
WHERE department = 'HR';


-- Find the list of all employees who are in both tables (COMMON) in IT department

SELECT employee_name
FROM employees_a
WHERE department = 'IT'
INTERSECT
SELECT employee_name
FROM employees_b
WHERE department = 'IT';


-- Find the list of all employees who are NOT employees_a table


SELECT employee_name
FROM employees_b

EXCEPT

SELECT employee_name
FROM employees_a


----------------------- String Manipulations ------------------------


INSERT INTO new_employees VALUES('1011', 'Rafael', 15000, '2023-11-25');
INSERT INTO new_employees VALUES('1012', 'Natalia', 13000, '2023-11-09');
INSERT INTO new_employees VALUES('1022', 'Kemal', 22000, '2024-11-20');
INSERT INTO new_employees VALUES('1014', 'Alexander', 25000, '2017-05-01');
INSERT INTO new_employees VALUES('1004', 'Goya', 23000, '2017-05-02');
INSERT INTO new_employees VALUES('1013', 'Damon', 11000, '2023-12-12');
INSERT INTO new_employees VALUES('1033', '  Ali Can  ', 11000, '2023-12-12');
INSERT INTO new_employees VALUES('1029', 'veli', 21000, '2023-12-12');


SELECT * FROM new_employees;

-- Find distinct name from new_employees table.

SELECT DISTINCT name
FROM new_employees;


SELECT DISTINCT salary  -- DISTINCT keyword gets rid of duplicate values
FROM new_employees;


-- Find distinct names and their length from new_employees table

SELECT DISTINCT name , LENGTH(name) AS name_length
FROM new_employees;


-- Remove spaces from names
SELECT TRIM(name)
FROM new_employees;

-- Display the name first 3 characters of the name only

SELECT name, SUBSTRING(name, 1,3) -- both indexes are inclusive
FROM new_employees;

-- Display the name with First letter as capital
SELECT name, INITCAP(name)
FROM new_employees;

-- Display names in uppercase and lowercase
SELECT name, UPPER(name)
FROM new_employees;

SELECT name, LOWER(name)
FROM new_employees;


-- Remove the space completely from the names

SELECT REPLACE(name, ' ', '')
FROM new_employees;

