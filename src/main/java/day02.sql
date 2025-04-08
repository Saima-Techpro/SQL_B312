----------- day 02 ------------

-- Create TABLE

CREATE TABLE IF NOT EXISTS students ( -- DDL -> is used to create structure
	id CHAR (4),
	name VARCHAR(30),
	age INT,
	register_date DATE
);

DROP TABLE students; -- DDL

-- How to read data from a table?

SELECT * FROM students; -- DQL -> is used to read the data


-- How to add data into the table?
-- SYNTAX
-- INSERT INTO table_name VALUES (col1, col2, col3, col4);

INSERT INTO students VALUES('01', 'Tom Hanks', 55, '2024-12-15');
INSERT INTO students VALUES('02', 'Emma Watson', 25, '2024-11-24');
INSERT INTO students VALUES('03', 'John Doe', 35, '2024-10-29');


-- How to add data into the specific columns of a table?
-- SYNTAX
-- INSERT INTO table_name (name of the specific columns) VALUES (add the values in the same order that you declared in this query)

INSERT INTO students (id, name, register_date) VALUES ('04', 'Bob Smith', '2024-12-08');

INSERT INTO students (id, name) VALUES ('05', 'Jason Slater');

INSERT INTO students(age, register_date) VALUES(42, '2025-03-03');



SELECT * FROM students; -- it works like System.out.println of java

---------------- CONSTRAINTS ---------------

CREATE TABLE employees (
	id SERIAL,
	name VARCHAR (20) NOT NULL,
	age INT CHECK (age >=18 AND age <=65),
	email VARCHAR (40) UNIQUE,
	salary REAL
);


SELECT * FROM employees;

-- How to add data in this table?

INSERT INTO employees VALUES(01, 'Tom Hanks', 45, 'th@gmail.com', 50000);
INSERT INTO employees VALUES(02, 'Jphn Doe', 35, 'jd@gmail.com', 55000);
INSERT INTO employees VALUES(05, 'Emma Watson', 25, 'ew@gmail.com', 65000);

-- INSERT INTO employees VALUES ( ,'', ,'', );
/* Normal syntax that we follow when we try to add all values in a table => follow the
   order of the fields as declared in the table creation.
   BUt with SERIAL data type, we DO NOT need to add value because it will cause conflict.
   So we need to add values by using 2nd way of adding into SPECIFC FIELDS
*/

-- How to add data into specific columns?

INSERT INTO employees (name, age, email, salary) VALUES ('Bob Smith', 33, 'bs@yahoo.com', 61000);

INSERT INTO employees (age, email, salary) VALUES (30, 'ab@outlook.com', 59000); -- shows error => violates not-null constraint in the name column

INSERT INTO employees (name, email, salary) VALUES ('Maryam', 'mm@gmail.com', 58000); -- no error because age columns doesn't have NOT NULL constraint


INSERT INTO employees (name, age, email, salary) VALUES ('Anglina Joli', 67, 'aj@yahoo.com', 80000); -- shows error because age column has a CHECK constraint which will not allow 67 years old entry

INSERT INTO employees (name, age, email, salary) VALUES ('Keira Knightly', 34, 'ab@outlook.com', 75000);

INSERT INTO employees (name, age, email, salary) VALUES ('Judi Dench', 44, 'ab@outlook.com', 95000); -- shows error because email violates unique constraint


SELECT * FROM employees;

------------- CONSTRAINT - PRIMARY KEY ---------------

-- There are 2 ways to add PRIMARY KEY

-- 1st way:

CREATE TABLE books (

	book_id SERIAL PRIMARY KEY,
	book_name VARCHAR (30) NOT NULL,
	publisher_name VARCHAR (20),
	page_number INT

);

SELECT * FROM books;

-- HOMEWORK: add at least data to this table

-- 2nd way


CREATE TABLE children_books (

	book_id SERIAL,
	book_name VARCHAR (30) NOT NULL,
	publisher_name VARCHAR (20),
	page_number INT,
	CONSTRAINT id_pk PRIMARY KEY (book_id)

);

SELECT * FROM children_books;


------------ COMPOSITE KEY -----------

CREATE TABLE adventure_books (
	book_id SERIAL ,
	book_name VARCHAR (30) NOT NULL ,
	publisher_name VARCHAR (20),
	page_number INT,
	CONSTRAINT composite_key PRIMARY KEY (book_id, book_name)
);

SELECT * FROM adventure_books;





