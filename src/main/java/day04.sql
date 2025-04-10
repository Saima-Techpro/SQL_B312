-------------- day 04 ------------

CREATE TABLE primary_students(
	student_id CHAR (5) PRIMARY KEY,
	student_name VARCHAR (30),
	email_address VARCHAR (50) NOT NULL,
	student_age NUMERIC(2) CHECK (student_age>5 OR student_age <15),
	phone_number CHAR (10) UNIQUE
);

SELECT * FROM primary_students;

-- 1st way of adding values

INSERT INTO primary_students VALUES ('1111', 'Ryan Brooks', 'rb@gmail.com', 11, '1234567890');
INSERT INTO primary_students VALUES ('1112', 'Emma Williams', 'ew@gmail.com', 12, '2345678901');
INSERT INTO primary_students VALUES ('1114', 'Alice Baker', 'ab@gmail.com', 10, '3456789012');
--INSERT INTO primary_students VALUES ('113', 'Tom Hanks', null, 123, '1234567890');-- there are 3 errors in  this data

INSERT INTO primary_students VALUES ('113', 'Tom Hanks', 'th@yahoo.com', 13, '1236789045');

-- 2nd way: Add data into specific columns
INSERT INTO primary_students (student_id, email_address, phone_number) VALUES ('1115', 'abc@outlook.com', '5678901234');
INSERT INTO primary_students (student_id, email_address, phone_number) VALUES('1116', 'xyz@yahoo.com', '6701234589');


-- 3rd way:
INSERT INTO primary_students (student_id, email_address, phone_number) VALUES
 				('1117', 'bc@gmail.com', '6778901234') ,
				('1118', 'pq@yahoo.com', '8889012345');




------------- UPDATE - SET  (DML)-------------
-- SYNTAX
-- UPDATE table_name
-- SET column_name = NEW VALUE
-- WHERE condition

UPDATE primary_students
SET student_id = '1113'
WHERE student_name = 'Tom Hanks';


-- Update name to 'Keira Knightly' where id is 1115

UPDATE primary_students
SET student_name = 'Keira Knightly'
WHERE student_id = '1115';

-- Change 'Alice Baker' name to ...?

UPDATE primary_students
SET student_name = 'Elyas'
WHERE student_name = 'Alice Baker';


-- Change email 'bc@gmail.com' to null

UPDATE primary_students
SET email_address = null
WHERE student_id = '1117'; -- error => violates not-null constraint in email_address column


-- Change email 'bc@gmail.com' to 'pq@yahoo.com'
UPDATE primary_students
SET email_address = 'pq@yahoo.com'
-- WHERE student_id = '1117' OR
WHERE email_address = 'bc@gmail.com';



SELECT * FROM primary_students;

DROP TABLE primary_students; -- will completely remove the table from the database

DELETE FROM primary_students; -- all records will be removed, but the table structure stays (SOFT REMOVAL) because data is revokable

TRUNCATE TABLE primary_students; -- all records will be removed, but the table structure stays (HARD REMOVAL) because data is NOT revokable


---------------------------------------------------

CREATE TABLE restaurants (
    restaurant_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    location VARCHAR NOT NULL,
    rating DECIMAL(2, 1) CHECK (rating >= 1 AND rating <= 5)
);

-- 1st way:

INSERT INTO restaurants VALUES (DEFAULT,'Four Seasons', 'Shahr-e-Naw', 4.5);
INSERT INTO restaurants VALUES (DEFAULT,'SALT BEA', 'İSTANBUL', 5);
INSERT INTO restaurants VALUES(DEFAULT, 'Istanbul', '2 Bury Old Road, Manchester, M8 9JN', 4.8);

INSERT INTO restaurants VALUES (DEFAULT, 'Hard Rock Cafe', 'London', 4.5);
INSERT INTO restaurants VALUES (DEFAULT, 'Bukhara', 'Kabul', 5.0 );


-- 2nd way:

INSERT INTO restaurants (name, location, rating) VALUES ( 'SEMBOL', 'CAMLICA', 5);

INSERT INTO restaurants(name , location, rating) VALUES('Miu Shushi', 'Calle de leon', 5  );
INSERT INTO restaurants (name,location,rating) VALUES ('VEGGIE' , 'Munich',  4);
INSERT INTO restaurants (name,location) VALUES ('SunShine' , 'DownTown');
INSERT INTO restaurants (name,location) VALUES ('Eatly' , 'Dubai Mall');

-- 3rd way:
INSERT INTO restaurants  (name, location, rating) VALUES
		('GlobeFish Restaurant','Calgary',5.0),
		('Fushion Sushi','Toronto',4.9),
		('The Gourmet Kitchen', 'New York, NY', 4.5),
		('Spicy Delights', 'Los Angeles, CA', 4.2),
		('Seafood Paradise', 'Miami, FL', 4.7);



-- Update VEGGIE restaurant's rating to 5

UPDATE restaurants
SET rating = 5.0
WHERE name = 'VEGGIE';


-- UPDATE name and rating of a restaurant is 6

UPDATE restaurants
SET name = 'Sembol' , rating = 4.9
WHERE restaurant_id = 6;


-- Decrease the rating of all restaurants by 0.5

UPDATE restaurants
SET rating = rating - 0.5;


-- Set rating to 4.9 to the restaurants which have null rating

UPDATE restaurants
SET rating = 4.9
WHERE rating = null; -- This won't work

UPDATE restaurants
SET rating = 4.9
WHERE rating IS NULL;



SELECT * FROM restaurants;

------------------------------ AGGREGATE FUNCTIONS -------------------------------
-- In SQL, there are five aggregate functions : MIN, MAX, COUNT, AVG, SUM


-- Find minimum age of the students

SELECT MIN(student_age)
FROM primary_students;



-- Find maximum age of the students

SELECT MAX(student_age)
FROM primary_students;


-- How many students are in this school

SELECT COUNT(student_id)
FROM primary_students;


-- Update all students' age to the maximum age

UPDATE primary_students
SET student_age = 13;  -- HARD CODED


-- dynamic way
UPDATE primary_students
SET student_age = (SELECT MAX(student_age) FROM primary_students); -- subquery => subquery ALWAYS runs first. if it returns data, th eouter query will be executed



SELECT * FROM primary_students;



-- Find out the average rating of the restaurants
SELECT AVG(rating) FROM restaurants;

-- How many restaurants?
SELECT COUNT(restaurant_id) FROM restaurants;


SELECT * FROM restaurants;

--------------------------------------------------------

CREATE TABLE parents (
	parent_id CHAR (5) PRIMARY KEY,
	parent_name TEXT,
	student_id CHAR (5),
	parent_address TEXT,
	parent_dob DATE
);

INSERT INTO parents VALUES('2111', 'Adam Brooks', '1111', 'Miami, FL', '1994-10-23');
INSERT INTO parents VALUES('2112', 'Angie Williams', '1112', 'New York, US', '1987-02-13');
INSERT INTO parents VALUES('2113', 'Andrew Duffy', '1113', 'Berlin, Germany', '1976-12-05');
INSERT INTO parents VALUES('2114', 'John Baker', '1114', 'London, UK', '1980-07-07');
INSERT INTO parents VALUES('2115', 'Lydia Smith', '1115', 'Toront, Canada', '1986-09-24');
INSERT INTO parents VALUES('2116', 'Dogan Can', '1116', 'Istanbul, Turkiye', '1990-11-11');


SELECT * FROM parents;

-- Who is the oldest in parents table?

SELECT MIN(parent_dob) FROM parents;

-- to get the whole record of the oldest parent

SELECT *
FROM parents
WHERE parent_dob = '1976-12-05'; -- HARD CODED

-- Dynamic way:
SELECT *
FROM parents
WHERE parent_dob = (SELECT MIN(parent_dob) FROM parents); -- subquery

-- to get the name of the oldest parent

SELECT parent_name
FROM parents
WHERE parent_dob = (SELECT MIN(parent_dob) FROM parents);


-- Get the record of the youngest in parents table?

SELECT *
FROM parents
WHERE parent_dob = (SELECT MAX(parent_dob) FROM parents);



------------------------ ALIAS --------------------------

-- ALIAS is a temporary name that we give to the column that is showing the results
-- key word for that is AS


CREATE TABLE workers(
  worker_id SMALLINT,
  worker_name VARCHAR(30),
  worker_salary NUMERIC,

  CONSTRAINT worker_id_pk PRIMARY KEY(worker_id)
);


INSERT INTO workers VALUES(101, 'Ali Can', 10000);
INSERT INTO workers VALUES(102, 'Veli Han', 4000);
INSERT INTO workers VALUES(103, 'Aisha Can', 7000);
INSERT INTO workers VALUES(104, 'Angie Ocean', 12000);
INSERT INTO workers VALUES(105, 'Musa Ahmet', 9000);
INSERT INTO workers VALUES(106, 'Ali Can', 19000);
INSERT INTO workers VALUES(107, 'Aygul Aksoy',13000);
INSERT INTO workers VALUES(108, 'Hasan Basri', 16000);
INSERT INTO workers VALUES(109, 'Fatih Tamer', 18000);
INSERT INTO workers VALUES(110, 'Emel Ebru', 8000);


-- Find the minimum salary
SELECT MIN(worker_salary) AS minimum_salary
FROM workers;

-- Find the maximum salary
SELECT MAX(worker_salary) AS maximum_salary
FROM workers;


-- Find the average salary
SELECT AVG(worker_salary) AS average_salary
FROM workers;

-- Find the total salary
SELECT SUM(worker_salary) AS total_salary
FROM workers;


--------------- Combining UPDATE-SET and AGGREGARE FUNCTIONS ------------------


-- Increase Veli's salary to 20% less than the highest salary

-- 1. Find the highest salary from the table
SELECT MAX(worker_salary) FROM workers; -- 19000

-- 2. Calculate 20% less than the highest salary
SELECT MAX(worker_salary) * 0.8 FROM workers; -- 15200

-- 3. Update Veli's salary

UPDATE workers
SET worker_salary = 15200 -- HARD CODED
WHERE worker_name = 'Veli Han';

-- DYNAMIC WAY

UPDATE workers
SET worker_salary = (SELECT MAX(worker_salary) * 0.8 FROM workers)
WHERE worker_name = 'Veli Han';


-- Decrease Hasan's salary to 30% more than the lowest salary

-- 1. Find the lowest salary

SELECT MIN(worker_salary) AS lowest_salary FROM workers; -- 7000

-- 2. Find 30% more than the lowest salary

SELECT MIN(worker_salary) * 1.3  FROM workers; -- 9100


-- 3. Update Hasan's salary
UPDATE workers
SET worker_salary = (SELECT MIN(worker_salary) * 1.3  FROM workers)
WHERE worker_id = 108;



-- Update everybody's salary with a bonus amount of 1000

UPDATE workers
SET worker_salary = worker_salary + 1000;


-- Increase the salary by 1000 if the salary is less than average salary

SELECT AVG(worker_salary) FROM workers; --13030

UPDATE workers
SET worker_salary = worker_salary + 1000
WHERE worker_salary < (SELECT AVG(worker_salary) FROM workers);



-- Increase the salary equal to average salary if the salary is less than average salary

UPDATE workers
SET worker_salary = (SELECT AVG(worker_salary) FROM workers)
WHERE worker_salary < (SELECT AVG(worker_salary) FROM workers);


----------------------- INTERVIEW QUESTIONS --------------------------

-- Find the record of the worker who is earning second highest salary

SELECT MAX(worker_salary) AS highest_salary FROM workers; -- returns maximum salary

-- the worker who is earning the highest salary
SELECT *
FROM workers
WHERE worker_salary = (SELECT MAX(worker_salary) AS highest_salary FROM workers); -- returns the worker with highest salary


-- Calculate the second highest salary

SELECT MAX(worker_salary) AS second_highest_salary
FROM workers
WHERE worker_salary < (SELECT MAX(worker_salary) FROM workers);


-- To get the worker earning second highest salary

SELECT *
FROM workers
WHERE worker_salary = (SELECT MAX(worker_salary) AS second_highest_salary
FROM workers
WHERE worker_salary < (SELECT MAX(worker_salary) FROM workers));


-- HW
-- Find the record of the worker who is earning THIRD highest salary


SELECT MAX (worker_salary) AS third_highest_salary
FROM workers
WHERE worker_salary < (SELECT MAX(worker_salary)
					   FROM workers
					   WHERE worker_salary <(SELECT MAX(worker_salary)FROM workers));


-- How to get the 3rd LOWEST salary
SELECT MIN (worker_salary) AS third_lowest_salary
FROM workers
WHERE worker_salary >(SELECT MIN(worker_salary)
					  FROM workers
					  WHERE worker_salary >(SELECT MIN(worker_salary)FROM workers));

SELECT * FROM workers;
