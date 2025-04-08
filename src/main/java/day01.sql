-- For single line comment
-- CREATE DATABASE db_name;

/*
For multiline comments:

There are 2 ways to create databases:
1. from the structure itself => right click databases => create Database and provide name and users details

2. open a query tool from the default postgres database => write SQL command

CREATE DATABASE batch318;

Refresh the databses and new database would be created

*/

CREATE DATABASE batch318;

DROP DATABASE batch312; -- this will fail because the batch312 database is open / is in use at the moment


DROP DATABASE batch318;


-- Create table using SQL command

CREATE TABLE students(); -- This table is created but it doesn't have any columns /structure

-- Delete table using SQL command

DROP TABLE students;


-- Create table with structure

CREATE TABLE students (

	id CHAR(4),
	name VARCHAR (30),
	age INT,
	register_date DATE

);


-- How to see the table on the console
SELECT * FROM students;






