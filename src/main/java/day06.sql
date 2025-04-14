------------- Day 06 ------------

------ Subquerey across the tables -------

CREATE TABLE company_employees (
  id CHAR(9) PRIMARY KEY,
  name VARCHAR(50),
  state VARCHAR(50),
  salary SMALLINT,
  company VARCHAR(20)
);


INSERT INTO company_employees VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO company_employees VALUES(324567891, 'Neena Omar', 'Ohio', 6000, 'GOOGLE');
INSERT INTO company_employees VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO company_employees VALUES(345678901, 'Ali Can', 'Texas', 3500, 'IBM');
INSERT INTO company_employees VALUES(345678905, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO company_employees VALUES(456789019, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO company_employees VALUES(456789130, 'Veli Han', 'Arozona', 4000, 'GOOGLE');
INSERT INTO company_employees VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO company_employees VALUES(234560789, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO company_employees VALUES(456789018, 'Aygul Aydem', 'Pennsylvania', 2500, 'IBM');
INSERT INTO company_employees VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');
INSERT INTO company_employees VALUES(123710456, 'Yusuf Arturk', 'Washington', 9000, 'APPLE');



CREATE TABLE companies (
  company_id CHAR(9),
  company VARCHAR(20),
  number_of_employees SMALLINT
);


INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);


-- Find the employee and the company name whose company has more than 15000

SELECT name, company
FROM company_employees
WHERE company IN (SELECT company FROM companies WHERE number_of_employees > 15000); -- subquery will return two values which we can use in IN Operator =>  IN('GOOGLE', 'APPLE')


-- Find the company name and company id which is operational in 'Texas'
SELECT company_id , company
FROM companies
WHERE company IN(SELECT company FROM company_employees WHERE state = 'Texas');


-- Find employee name and their states if they work for company_id 103

SELECT name, state
FROM company_employees
WHERE company IN (SELECT company FROM companies WHERE company_id = '103');

-- OR

SELECT name, state
FROM company_employees
WHERE company = (SELECT company FROM companies WHERE company_id = '103');


--NOTE: If the subquery returns more than one values, equal sign = will not work
SELECT name, state
FROM company_employees
WHERE company = (SELECT company FROM companies WHERE company_id > '101');

-- But IN Operator will work wether subquery returns single value or more
SELECT name, state
FROM company_employees
WHERE company IN (SELECT company FROM companies WHERE company_id > '101');


-- Find the company name, number of employees and average salary paid by each company

SELECT company, number_of_employees , (SELECT AVG(salary) AS avg_salary FROM company_employees WHERE company_employees.company = companies.company)
FROM companies;


-- Find the company name, company id, maximum and minimum salaries paid by each company
SELECT company, company_id,
(SELECT MAX(salary) AS max_salary_per_company FROM company_employees ce WHERE ce.company = c.company ),
(SELECT MIN(salary) AS min_salary_per_company FROM company_employees ce WHERE ce.company = c.company )
FROM companies c;

-- NOTE: We can use ALIAS for table names as well => ce for company_employees table, c for companies table


SELECT * FROM company_employees;
SELECT * FROM companies;



------------------------- IS NULL and NOT NULL Operators --------------------------

CREATE TABLE people (
	ssn INT UNIQUE,
	name VARCHAR (30),
	address VARCHAR (50)
);


INSERT INTO people VALUES (123456789, 'Mark Star', 'Florida');
INSERT INTO people VALUES (234567890, 'Angie Way', 'Virginia');
INSERT INTO people VALUES (345678912, 'Olivia Brooks', 'Arizona');
INSERT INTO people VALUES (456789123, 'Mary Tien', 'New Jersey');

INSERT INTO people (ssn, address) VALUES (567890123, 'California');
INSERT INTO people (ssn, address) VALUES (678901234, 'Michigan');
INSERT INTO people (ssn, address) VALUES (789012345, 'Ohio');


INSERT INTO people (ssn, name) VALUES (890123456, 'Emily Simpson');
INSERT INTO people (ssn, name) VALUES (901234567, 'Axcel Jackson');
INSERT INTO people (ssn, name) VALUES (012389456, 'John Smith');

INSERT INTO people (name, address) VALUES ('John Doe', 'Texas');
INSERT INTO people (name, address) VALUES ('Tom Hanks', 'Washington');
INSERT INTO people (name, address) VALUES ('Emma Watson', 'New York');


-- UPDATE all null names to 'Names will be added later'

UPDATE people
SET name = 'Names will be added later'
WHERE name IS NULL;


-- UPDATE all null address to 'Address is not provided'

UPDATE people
SET address = 'Address is not provided'
WHERE address IS NULL;


-- Delete all records where ssn is null

DELETE
FROM people
WHERE ssn IS NULL;

-- Delete all records where address is not null
DELETE
FROM people
WHERE address IS NOT NULL;


SELECT * FROM people;


------------------------- LIKE Operator --------------------------

-- LIKE Operator is used with WILDCARDS
-- Wildcard => useful expressions for search operations in SQL queries
-- They're used with STRING data type
-- There are many wildcards

-- 1. % => percentage sign => it represents zero or more characters
-- 2. _ => underscore sign => it represents single character


CREATE TABLE email_list(
	 email_id INT PRIMARY KEY,
	 email_address VARCHAR (50)
 );



 INSERT INTO email_list (email_id, email_address)
 VALUES
 		(1, 'alice*gmail.com'),
		(2, 'bob@example.com'),
		(3, 'charlie@hotmail.com'),
		(4, 'dave@gmail.com'),
		(5, 'eve@yahoo.com'),
		(6, 'frank@gmail.com'),
		(7, 'grace@example.com'),
		(8, 'john@outlook.com'),
		(9, 'emily@gmail.com'),
		(10, 'ava@yahoo.com');

 INSERT INTO email_list (email_id, email_address)  VALUES (11, 'neymar@gmail.com')

SELECT * FROM email_list;


-- Return all records where email address ends at 'gmail.com'
SELECT *
FROM email_list
WHERE email_address LIKE '%gmail.com';


-- Return all records where email address starts with f

SELECT *
FROM email_list
WHERE email_address LIKE 'f%';



-- Return all records where email address starts with john

SELECT *
FROM email_list
WHERE email_address LIKE 'john%';


-- Return all records where email address has 'v' anywhere

SELECT *
FROM email_list
WHERE email_address LIKE '%v%';


-- Return all records where email address starts with 'g' and ends with 'm'

SELECT *
FROM email_list
WHERE email_address LIKE 'g%m';

-- Return all records where email address has 'r' and 'n' at ANY position

SELECT *
FROM email_list
WHERE email_address LIKE '%r%n%' OR email_address LIKE '%n%r%'

-- OR

SELECT *
FROM email_list
WHERE email_address LIKE '%r%' AND email_address LIKE '%n%'


-- If we want to look for a specific data at a specific place

-- Return all records which have 'a' at second place

SELECT *
FROM email_list
WHERE email_address LIKE '_a%';



-- Return all records which have 'y' at fifth place

SELECT *
FROM email_list
WHERE email_address LIKE '____y%';

-- Return all records which have 'r' at fourth place and 'h' at 9th place

SELECT *
FROM email_list
WHERE email_address LIKE '___r____h%';

-- OR

SELECT *
FROM email_list
WHERE email_address LIKE '___r%' OR email_address LIKE '________h%';

-- Return all records which have 'o' at the second last position

SELECT *
FROM email_list
WHERE email_address LIKE '%o_';


-- Return all records which have 'p' at the 7th last position

SELECT *
FROM email_list
WHERE email_address LIKE '%p______';


-- HW from company_employees table

--Select employee names which start with 'E'
--Select employee names which ends with 'e'
--Select employee names which starts with 'B' and ends with 't'
--Select employee names which has 'a' in any position
--Select employee names which has 'e' and 'r' in any position
--Select state whose second character is 'e' and fourth is 'n'
--Select state whose second last character is 'i'
--Select 'states' whose second character is 'e' and it has at least 6 characters
--Select state which has 'i' in any position after second character



SELECT * FROM email_list;

-- https://medium.com/@rupa.mahanti0/10-free-websites-to-learn-and-practice-sql-ca0711278378
-- https://sqlbolt.com/
-- https://www.sqlcourse.com/
-- https://online.stanford.edu/courses/soe-ydatabases0005-databases-relational-databases-and-sql