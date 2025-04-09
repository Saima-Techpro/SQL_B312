----------- day 03 -----------

CREATE TABLE new_employees( -- DDL
	id CHAR (5) PRIMARY KEY,
	name VARCHAR (40) UNIQUE,
	salary INT NOT NULL,
	start_date DATE
);



INSERT INTO new_employees VALUES ('1002', 'Donatello', 12000, '2018-04-14');
INSERT INTO new_employees VALUES ('1003', null, 5000, '2018-04-14'); -- no error because UNIQUE allows one null value
INSERT INTO new_employees VALUES ('1004', 'Donatello', 5000, '2020-04-14'); -- error => name is not unique
INSERT INTO new_employees VALUES ('1005', 'Michael Angelo', 11000, '2018-04-14'); -- no error
INSERT INTO new_employees VALUES ('1006', 'Leonardo', null, '2019-03-24'); -- error => salary can't be null
INSERT INTO new_employees VALUES ('1007', 'Raphael', '', '2022-11-23'); -- error because data type mismatch
INSERT INTO new_employees VALUES ('', 'April', 8000, '2022-04-14');  -- no error => empty string is not null
INSERT INTO new_employees VALUES ('', 'Miss April', 10000, '2023-06-19'); -- error => you can't send empty string twice -> violates unique constraint
INSERT INTO new_employees VALUES ('1002', 'Splinter', 12000, '2024-03-14'); -- error => 1002 id already exists
INSERT INTO new_employees VALUES (null, 'Fred', 14000, '2022-05-16'); -- error => primary key doesn't allow null
INSERT INTO new_employees VALUES ('1008', 'Barnie', 10000, '2023-11-26');
INSERT INTO new_employees VALUES ('1009', 'Wilma', 11000, '2023-11-30');
INSERT INTO new_employees VALUES ('1010', 'Betty', 13000, '2023-09-24');

-- Inserting data into a table is DML

SELECT * FROM new_employees; -- DQL

--------------------------------------------------


CREATE TABLE addresses(
	address_id CHAR (5),
	dist VARCHAR (30),
	street VARCHAR (20),
	city VARCHAR (20),
	CONSTRAINT add_fk FOREIGN KEY (address_id) REFERENCES new_employees (id)
);


INSERT INTO addresses VALUES ('1003', 'Ninja Dist', '40.Cad.', 'Washington');
INSERT INTO addresses VALUES ('1003', 'Kaya Dist', '50.Cad.', 'Ankara');
INSERT INTO addresses VALUES ('1002', 'Tas Dist', '30.Cad.', 'Konya');
INSERT INTO addresses VALUES ('1012', 'Tas Sok', '30.Cad.', 'Konya'); -- This will not be added because id 1012 doesn't exist in new_employees table. Because of schema established through foreign key, this data will not be added
INSERT INTO addresses VALUES (Null, 'Tas Sok', '23.Cad.', 'Bursa');
INSERT INTO addresses VALUES (Null, 'Ninja Dist', '40.Cad.', 'Florida');
INSERT INTO addresses VALUES ('1005', 'DisneyLand', '30.Cad.', 'Florida');


SELECT * FROM addresses;


-- How to get specific data?

SELECT street FROM addresses;

SELECT city FROM addresses;


-------------- How to filter data at individual level through SQL queries --------------

----------- WHERE Condition --------------

-- From new_employees table, get the record whose salary is 13000

SELECT *
FROM new_employees
WHERE salary = 13000;


-- From new_employees table, get the record whose salary is greater than 8000

SELECT *
FROM new_employees
WHERE salary > 8000;

-- From new_employees table, get the record whose salary is less than 8000

SELECT *
FROM new_employees
WHERE salary < 8000;


-- From new_employees table, get the record whose name is Donatello

SELECT *
FROM new_employees
WHERE name = 'Donatello';


-- From addresses table, display the record whose id is 1003 and city is 'Ankara'

SELECT *
FROM addresses
WHERE address_id = '1003' AND city = 'Ankara'; -- this returns one record because AND is strict operator


SELECT *
FROM addresses
WHERE address_id = '1003' OR city = 'Ankara'; -- This returns 2 records because OR opertaor is easy going.




-- From addresses table, display the record where city is 'Bursa' or 'Konya'

SELECT *
FROM addresses
WHERE city = 'Bursa' OR city = 'Konya';


SELECT * FROM new_employees;
SELECT * FROM addresses;

-- ALL ABOVE QUERIES ARE DQL


CREATE TABLE new_students(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR (30),
	last_name VARCHAR (30),
	exam_score INT
);


SELECT * FROM new_students;

-- 3rd way of adding values into a table

INSERT INTO new_students (first_name, last_name, exam_score) VALUES
		('Tom', 'Hanks', 85),
		('Keira', 'Knightly', 92),
		('Lenardo', 'Dicaprio', 78),
		('Julia', 'Roberts', 88),
		('Denzel', 'Washington', 95),
		('Benedict', 'Cumberbatch', 88),
		('Brad', 'Pitt', 91),
		('Russel', 'Crowe', 89),
		('Emma', 'Watson', 87),
		('Judy', 'Dench', 97);


---------------- How to DELETE specific data ----------------

-- From new_students table, delete the record whose first_name is 'Lenardo'

DELETE
FROM new_students
WHERE first_name = 'Lenardo';


-- From new_students table, delete the record whose exam score is 85

DELETE
FROM new_students
WHERE exam_score = 85;


-- From new_students table, delete the record whose id is 7

DELETE
FROM new_students
WHERE id = 7;



-- From new_students table, delete the record whose id is 8 or whose last name is 'Washington'

DELETE
FROM new_students
WHERE id = 8 OR last_name = 'Washington';

DELETE
FROM new_students
WHERE id = 2 OR last_name != 'Washington'; -- This removed all records because last_name  can be any thing other Washington so ut removed all last_names

-- So we added the data again

DELETE
FROM new_students
WHERE id = 14 AND last_name = 'Roberts';


-- Delete all records
DELETE FROM new_students;

TRUNCATE TABLE new_students;


DROP TABLE new_students;

---------- TRUNCATE, DELETE and DROP ----------

-- TRUNCATE (hard)  vs. DELETE (soft)
-- 1.  Both are used to remove data from the tables
-- When we remove data using TRUNCATE, we can NOT revoke that data (hard)
-- whereas if we remove data using DELETE, we CAN revoke the data (soft)


-- 2. TRUNCATE is DDL while DELETE is DML

-- 3. With DELETE, we can use conditions to filter our query but with TRUNCATE, we can NOT use conditions


-- DROP completey removes the table => data as well as structure of the table from the database


SELECT * FROM new_students;


------------------------------------------------------

SELECT * FROM new_employees; -- parent table because it has PRIMARY KEY
SELECT * FROM addresses; -- child table because it has FOREIGN KEY

TRUNCATE TABLE addresses; -- removed all rows from the table but the table itself exists

DROP TABLE addresses;

TRUNCATE TABLE new_employees; -- not allowed --- shows error => because there's a schema between this parent table and a child table called addresses


------------------ CASCADE -------------

CREATE TABLE parent (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE child (
    id SERIAL PRIMARY KEY,
    parent_id INTEGER REFERENCES parent(id)
);



INSERT INTO parent (name) VALUES ('Parent 1'), ('Parent 2'), ('Parent 3'), ('Parent 4');
INSERT INTO child (parent_id) VALUES (1), (2), (3), (4) ;


SELECT * FROM parent;
SELECT * FROM child;

TRUNCATE TABLE parent; -- error =>cannot truncate a table referenced in a foreign key constraint

-- However we can force to do this
TRUNCATE TABLE parent CASCADE;

-- All rows from the parent table are removed.
-- The child table, which references parent, is also truncated automatically.

-------------- NOTES ON CASCADE -----------

-- Cascade is used to delete the parent table by force (without deleting the child table first) - schema is established through Foreign Key
-- ON DELETE CASCADE => if any row from customers table is deleted, the corresponding row from orders table will automatically be deleted as well

-- We can use CASCADE in queries as well


CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id) ON DELETE CASCADE
);


DROP TABLE customers CASCADE;  -- while dropping customers table, all child tables will be dropped as well

/*
Key Points to Remember:

- Efficient for Clearing Data: Ideal for quickly resetting tables with dependencies.
- No Rollback for Referenced Rows: Once executed, it’s not reversible unless you have a backup.
- Foreign Key Constraints: Automatically propagates truncation to tables with foreign key
	dependencies.
- Usage in Production: Use carefully, as it removes all rows without logging individual deletions.
*/