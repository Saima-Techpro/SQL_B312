-------------- Day 09 -------------

--------- ALTER TABLE ------------
-- ALTER TABLE is the keyword that we use to update / change structure of the table (DDL)
-- ADD COLUMN => to add new column on the existing table (OR just ADD can be used too)
-- RENAME COLUMN column_name TO new_name => used to change the name of the existing column
-- ALTER COLUMN => is used to change data type, set default value,  size for existing column
-- ADD CONSTRAINT => is used to add ANY constraint on any column


CREATE TABLE gadgets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    category VARCHAR(30),
    price NUMERIC(8,2)
);


-- Add a new column named 'brand' of type VARCHAR ro store the names of the brand
ALTER TABLE gadgets
ADD COLUMN brand VARCHAR (30); -- ADD brand VARCHAR(30) also works.


-- Rename column called name to gadget_name
ALTER TABLE gadgets
RENAME COLUMN name TO gadget_name;

-- Change data type of price column to INT

ALTER TABLE gadgets
ALTER COLUMN price TYPE INTEGER;


-- Set default value for category column to 'Misc'

ALTER TABLE gadgets
ALTER COLUMN category SET DEFAULT 'Misc';


-- Check if category is set to 'Misc'

INSERT INTO gadgets (gadget_name, price) VALUES ('IPhone 16 Pro Max', 4000);


-- Drop the category column
ALTER TABLE gadgets
DROP COLUMN category;

-- Add a UNIQUE constraint to gadget_name column
ALTER TABLE gadgets
ADD CONSTRAINT adding_unique UNIQUE (gadget_name);


-- Rename the name of the UNIQUE CONSTRAINT
ALTER TABLE gadgets
RENAME CONSTRAINT adding_unique TO adding_unique_key;


-- Check if UNIQUE constraint is implemented or not

INSERT INTO gadgets (gadget_name, price) VALUES ('IPhone 16 Pro Max', 4000); -- error so CONSTRAINT is verified


-- Rename table to electronic_gadgets
ALTER TABLE gadgets
RENAME TO electronic_gadgets;


SELECT * FROM gadgets; -- error because the name has been updated / changed

SELECT * FROM electronic_gadgets; -- works with the new name

-- Add manufacture_date column with DATE
--ALTER TABLE electronic_gadgets
--ADD COLUMN manufacture_date TYPE DATE;

-- OR SHORT VERSION
ALTER TABLE electronic_gadgets
ADD manufacture_date DATE;


-- Alter gadget_name to NOT NULL

ALTER TABLE electronic_gadgets
ALTER COLUMN gadget_name SET NOT NULL; -- If we want to keep UNIQUE as well



SELECT * FROM electronic_gadgets;

-------------------------------------------------------------

CREATE TABLE manufacturers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  country VARCHAR(30)
);

-- Insert Data

INSERT INTO manufacturers (name, country) VALUES
('TechNova', 'USA'),
('CloudCore', 'USA'),
('NetFusion', 'Canada'),
('DataWave', 'UK'),
('AppVerse', 'Germany'),
('SoftPort', 'Japan'),
('CyberQuotient', 'India');


SELECT * FROM manufacturers;

-- Add a column name_of_ceo to this table
ALTER TABLE manufacturers
ADD name_of_ceo VARCHAR (50);


ALTER TABLE manufacturers
ALTER COLUMN name_of_ceo SET NOT NULL; -- error => column already contains null values


-- TWO OPTIONS:
-- Option 1. Add the names of the ceo in each existing row one by one, then run the above query

UPDATE manufacturers SET name_of_ceo = 'Elyas' WHERE name ILIKE 'TechNova';
UPDATE manufacturers SET name_of_ceo = 'Thomas Beckett' WHERE name ILIKE 'CloudCore';
UPDATE manufacturers SET name_of_ceo = 'Harpreet Kaur' WHERE name ILIKE 'NetFusion';
UPDATE manufacturers SET name_of_ceo = 'Emily Stone' WHERE name ILIKE 'DataWave';
UPDATE manufacturers SET name_of_ceo = 'Jonas Richter' WHERE name ILIKE 'AppVerse';
UPDATE manufacturers SET name_of_ceo = 'Hiro Tanaka' WHERE name ILIKE 'SoftPort';
UPDATE manufacturers SET name_of_ceo = 'Meena Rathi' WHERE name ILIKE 'CyberQuotient';

-- ILIKE means ignore upper/lower case

ALTER TABLE manufacturers
ALTER COLUMN name_of_ceo SET NOT NULL; -- WORKS NOW


-- Option 2. DROP the table, add the new column / constarint on the table, create table again, add all data again



-- Change the SIZE of the column name_of_ceo to 60
ALTER TABLE manufacturers
ALTER COLUMN name_of_ceo TYPE VARCHAR (60);

-- Change the SIZE of the column name_of_ceo to 20
ALTER TABLE manufacturers
ALTER COLUMN name_of_ceo TYPE VARCHAR (20);


-- Change the SIZE of the column name_of_ceo to 10
ALTER TABLE manufacturers
ALTER COLUMN name_of_ceo TYPE VARCHAR (10); -- error => the data longer than 10 already exists in the columns so size can't be changed now


-- Add a FOREIGN KEY column and constraint to electronic_gadgets table to establish a schema between electronic_gadgets table and manufacturers table

-- Step 1: Add the new column
ALTER TABLE electronic_gadgets
ADD COLUMN manufacturer_id INT;

-- Step 2: Add FOREIGN KEY

ALTER TABLE electronic_gadgets
ADD CONSTRAINT fk_manufacturer FOREIGN KEY  (manufacturer_id) REFERENCES manufacturers (id);



SELECT * FROM electronic_gadgets;



--------------------------------------------------

SELECT * FROM company_employees


-- Add a new column 'country' with VARCHAR data type and set the default value 'USA'

ALTER TABLE company_employees
ADD COLUMN country VARCHAR(5) DEFAULT 'USA';

-- Change the name of 'salary' column to 'income'

ALTER TABLE company_employees
RENAME COLUMN salary TO income;

-- Change the data type of 'income' from smallint to REAL

ALTER TABLE company_employees
ALTER COLUMN income TYPE REAL;


-- Can we change it back to smallint? YES

ALTER TABLE company_employees
ALTER COLUMN income TYPE SMALLINT;

-- Can we change the data type from REAL / SMALLINT to VARCHAR?
-- YES
ALTER TABLE company_employees
ALTER COLUMN income TYPE VARCHAR;

-- Can we change the data type back to REAL?

ALTER TABLE company_employees
ALTER COLUMN income TYPE REAL; -- error => column "income" cannot be cast automatically to type real

-- We have to insist on this type casting by  "USING income::real"
ALTER TABLE company_employees
ALTER COLUMN income TYPE REAL USING income::real; -- no error


SELECT * FROM company_employees;


----------------------------- JOINS ------------------------


-- JOINS are used to join / combine data from two or more TABLES
-- They're ALWAYS used with ON statement

-- INNER JOIN: it returns common data from two tables according to the given filter
-- LEFT JOIN: it returns ALL values from first table AND common values according to the given filter
-- RIGHT JOIN: it returns ALL values from second table AND common values according to the given filter
-- FULL JOIN: it returns ALL values from BOTH tables according to the given filter
-- SELF JOIN: it works with SINGLE table, it works with it SELF, and returns data according to the given filter


CREATE TABLE my_companies(
  company_id CHAR(3),
  company_name VARCHAR(20)
);

INSERT INTO my_companies VALUES(100, 'IBM');
INSERT INTO my_companies VALUES(101, 'GOOGLE');
INSERT INTO my_companies VALUES(102, 'MICROSOFT');
INSERT INTO my_companies VALUES(103, 'APPLE');



CREATE TABLE orders(
  company_id CHAR(3),
  order_id CHAR(3),
  order_date DATE
);

INSERT INTO orders VALUES(101, 11, '17-Apr-2024');
INSERT INTO orders VALUES(102, 22, '25-Nov-2024');
INSERT INTO orders VALUES(103, 33, '19-Jan-2024');
INSERT INTO orders VALUES(104, 44, '20-Aug-2024');
INSERT INTO orders VALUES(105, 55, '21-Oct-2024');


-- Find the company_name, company_id and order_date for the company that exists in both tables

----------------- INNER JOIN ---------------------
SELECT company_name, my_companies.company_id, order_date
FROM my_companies INNER JOIN orders
ON my_companies.company_id = orders.company_id;


-- With ALIAS for tables

SELECT company_name, mc.company_id, order_date
FROM my_companies mc INNER JOIN orders o
ON mc.company_id = o.company_id;


----------------------- LEFT JOIN -------------------------

SELECT company_name, mc.company_id, order_date
FROM my_companies mc LEFT JOIN orders o
ON mc.company_id = o.company_id;




----------------------- RIGHT JOIN -------------------------

SELECT company_name, mc.company_id, order_date
FROM my_companies mc RIGHT JOIN orders o
ON mc.company_id = o.company_id;

-- Change the position of the table
SELECT company_name, mc.company_id, order_date
FROM orders o  RIGHT JOIN my_companies mc
ON mc.company_id = o.company_id;


-- NOTE: the ORDER of the tables MATTERS (IMPORTANT!!!!)


----------------------- FULL JOIN -------------------------

SELECT company_name, mc.company_id, order_date
FROM my_companies mc FULL JOIN orders o
ON mc.company_id = o.company_id;

----------------------- SELF JOIN -------------------------
CREATE TABLE jobs(
  id CHAR(2),
  name VARCHAR(20),
  title VARCHAR(40),
  manager_id CHAR(2)
);

INSERT INTO jobs VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO jobs VALUES(2, 'John Walker', 'QA', 3);
INSERT INTO jobs VALUES(3, 'Angie Star', 'QA Lead', 4);
INSERT INTO jobs VALUES(4, 'Amy Sky', 'CEO', 5);

SELECT * FROM jobs;

-- Find the name of the manager of each employee

SELECT j1.name , j2.name
FROM jobs j1 SELF JOIN jobs j2
ON jobs.id = jobs.manager_id; -- error => PostgreSQL doesn't recognise SELF JOIN


-- PostgreSQL takes INNER JOIN in place of SELF JOIN
SELECT j2.name AS name_of_employee , j1.name name_of_manager
FROM jobs j1 INNER JOIN jobs j2
ON j1.id = j2.manager_id;



SELECT * FROM orders;
SELECT * FROM my_companies ;



------------- ANOTHER EXAMPLE ------------

CREATE TABLE departments (
  dept_id SERIAL PRIMARY KEY,
  dept_name VARCHAR(50) NOT NULL,
  parent_dept_id INT  -- self-reference to dept_id
);


INSERT INTO departments (dept_name, parent_dept_id) VALUES
('Head Office', NULL),
('Finance', 1),
('IT', 1),
('HR', 1),
('Payroll', 2),
('Security', 3),
('Recruitment', 4);


SELECT * FROM departments;


-- Show each department with its parent_department

SELECT pd.dept_name AS department, d.dept_name AS parent_department
FROM departments d JOIN departments pd
ON  d.dept_id = pd.parent_dept_id;


-- HW
-- List all sub_departments under 'Head Office' only

SELECT d.dept_name AS sub_department
FROM departments d JOIN departments p
ON d.parent_dept_id = p.dept_id
WHERE p.dept_name = 'Head Office';
