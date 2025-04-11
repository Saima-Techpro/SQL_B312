------------------ Day 05 -----------------

--------- INTERVIEW QUESTION ------------

SELECT * FROM workers;

-- HW
-- Find the record of the worker who is earning THIRD highest salary

-- second_highest_salary
SELECT MAX(worker_salary) AS second_highest_salary
FROM workers
WHERE worker_salary < (SELECT MAX(worker_salary) FROM workers);

-- third_highest_salary

SELECT MAX(worker_salary) AS third_highest_salary
FROM workers
WHERE worker_salary < (SELECT MAX(worker_salary)
FROM workers
WHERE worker_salary < (SELECT MAX(worker_salary) FROM workers));


-- Find the record of the worker who is earning THIRD lowest salary
-- Lowest salary
SELECT MIN(worker_salary) FROM workers;

-- Second lowest salary
SELECT MIN(worker_salary) AS second_lowest_salary
FROM workers
WHERE worker_salary > (SELECT MIN(worker_salary) FROM workers);


-- Third lowest salary

SELECT MIN(worker_salary) AS third_lowest_salary
FROM workers
WHERE worker_salary > (SELECT MIN(worker_salary)
						FROM workers
						WHERE worker_salary > (SELECT MIN(worker_salary) FROM workers));


---------------------- ORDER BY CLAUSE ------------------------
-- Subquery is a universal language.
-- ORDER BY - OFFSET  is most commonly used in MySQL, PostgreSQL, Oracle. It is NOT universal.
-- ORDER BY sorts the data in ASCENDING Order by default. If we want to change the order to Descending, we must add DESC keyword.
-- If the datatype is STRING, by default, it's ordered in Alphabetical (Natural) order.


-- ORDER BY clause is used to sort the sort according to the column_name that is mentioned after this clause

-- ORDER BY clause can be used ONLY with SELECT STATEMENT
-- WHERE condition MUST be used before ORDER BY clause


SELECT *
FROM workers
ORDER BY worker_id; -- by default, data is sorted in ASCENDING ORDER

-- Highest salary
SELECT *
FROM workers
ORDER BY worker_salary DESC
FETCH NEXT 1 ROW ONLY;


-- Second highest salary

SELECT *
FROM workers
ORDER BY worker_salary DESC
OFFSET 1 -- offset means skip 1 row
FETCH NEXT 1 ROW ONLY;

-- Third highest salary

SELECT *
FROM workers
ORDER BY worker_salary DESC
OFFSET 2
FETCH NEXT 1 ROW ONLY;


-- shorter version
SELECT *
FROM workers
ORDER BY worker_salary DESC
OFFSET 2 LIMIT 1;


-- lowest salary
SELECT *
FROM workers
ORDER BY worker_salary
OFFSET 1 LIMIT 1;


SELECT *
FROM workers
ORDER BY worker_name; -- if the data type is String, records will be sorted in Alphabetical order


------------------------ LOGICAL OPERATORS -------------------------
--------- IN and NOT IN Operators -----------

-- IN operator allows you to specify multiple values in WHERE clause.
-- IN operator is used to help reduce the need to use multiple OR conditions in
-- a SELECT, INSERT, UPDATE or DELETE statement.



--NOT IN operator  is used to replace a group of arguments using the <> (!=) operator that
--are combined with an AND. It can make code easier to read and understand for
--SELECT, INSERT, UPDATE or DELETE statements



CREATE TABLE customers_products (
  product_id INT,
  customer_name VARCHAR(30),
  product_name VARCHAR(30)
);

INSERT INTO customers_products VALUES (10, 'Mark Twain', 'Orange');
INSERT INTO customers_products VALUES (10, 'Mark Wilson', 'Mango');
INSERT INTO customers_products VALUES (20, 'John Clark', 'Apple');
INSERT INTO customers_products VALUES (30, 'Amy Williams', 'Plum');
INSERT INTO customers_products VALUES (20, 'Mark Donne', 'Apple');
INSERT INTO customers_products VALUES (10, 'Adam Smith', 'Orange');
INSERT INTO customers_products VALUES (40, 'John Evans', 'Apricot');
INSERT INTO customers_products VALUES (20, 'Eddie Murphy', 'Apple');
INSERT INTO customers_products VALUES (30, 'Anna Goldman', 'Mango');
INSERT INTO customers_products VALUES (50, 'Helen Green', 'Grapes');
INSERT INTO customers_products VALUES (10, 'Laura Owen', 'PineApple');


SELECT * FROM customers_products;

-- Find the records that have the product_name Apple, Mango, Orange

-- 1st way: NOT RECOMMENDED
SELECT *
FROM customers_products
WHERE product_name = 'Mango' OR product_name = 'Orange' OR product_name = 'Apple';

-- 2nd way: RECOMMENDED
SELECT *
FROM customers_products
WHERE product_name IN ('Mango', 'Orange', 'Apple');

-- Find the records that don't have Apple, Mango, Orange
-- 1st way: NOT RECOMMENDED
SELECT *
FROM customers_products
WHERE product_name <> 'Mango' AND product_name <> 'Orange' AND product_name <> 'Apple';


-- 2nd way: RECOMMENDED
SELECT *
FROM customers_products
WHERE product_name NOT IN ('Mango', 'Orange', 'Apple');


------------------- BETWEEN and NOT BETWEEN ----------------------
-- BETWEEN is inclusive => beginning and ending boundary values are included in the result set
-- NOT BETWEEN is exclusive => beginning and ending boundary values are NOT included in the result set



-- Find the product_name where id is greater than/ equal to 20 and less than / equal to 50
-- 1st way:
SELECT *
FROM customers_products
WHERE product_id >= 20  AND product_id <= 50;

-- 2nd way
SELECT *
FROM customers_products
WHERE product_id BETWEEN 20 AND 50; -- boundary values are inclusive


-- Find the product_name where id is NOT greater than/ equal to 20 and NOT less than / equal to 50

SELECT *
FROM customers_products
WHERE product_id NOT BETWEEN 20 AND 50; -- boundary values are exclusive



-------------------------- EXISTS Operator -----------------------------
-- This operator is quite TRICKY!! so be careful while using it.

-- EXISTS Operator works with a subquery
-- If subquery returns data, for EXISTS Operator it means it's true that asked data exists. So it allows the update / delete

-- EVEN IF ONE DATA EXISTS, IT WILL BE CONSIDERED TRUE

-- If subquery does NOT return data, for EXISTS Operator it means it's false that asked data does NOT exist. So it doesn't allow the update / delete





CREATE TABLE customers_likes(
  product_id CHAR(10),
  customer_name VARCHAR(50),
  liked_product VARCHAR(50)
);

INSERT INTO customers_likes VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_likes VALUES (50, 'Mark', 'Pineapple');
INSERT INTO customers_likes VALUES (60, 'John', 'Avocado');
INSERT INTO customers_likes VALUES (30, 'Lary', 'Cherries');
INSERT INTO customers_likes VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_likes VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_likes VALUES (40, 'John', 'Apricot');
INSERT INTO customers_likes VALUES (20, 'Eddie', 'Apple');


SELECT * FROM customers_likes;

-- Update all customer_name to 'no name' if the column has a name 'Hary'

-- 1st way:
UPDATE customers_likes
SET customer_name = 'no name'
WHERE customer_name = 'Hary'; -- nothing changed because 'Hary' doesn't exist in our table


-- 2nd way:
UPDATE customers_likes
SET customer_name = 'no name'
WHERE EXISTS(SELECT customer_name FROM customers_likes WHERE customer_name = 'Hary'); -- nothing changed because subquery doesn't retun any data in the result set which means false for EXISTS Operator so EXISTS Operator doesn't allow any update





-- Update all customer_name to 'no name' if the column has a name 'Lary'
UPDATE customers_likes
SET customer_name = 'no name'
WHERE EXISTS(SELECT customer_name FROM customers_likes WHERE customer_name = 'Lary'); -- Update is allowed because subquery retuns 'Lary' in the result set which means true for EXISTS Operator so EXISTS Operator allows the update




-- Update all customer_name to 'some name' if liked_product column has 'Orange'

UPDATE customers_likes
SET customer_name = 'my name'
WHERE liked_product = 'Apricot'; -- updates specific data/record ONLY

-- With EXISTS Operator
UPDATE customers_likes
SET customer_name = 'some name'
WHERE EXISTS (SELECT liked_product FROM customers_likes WHERE liked_product = 'Orange')



-- Update all customer_name to 'John Doe' if liked_product column has Orange, Avocado, Pineapple

-- 1st way:
UPDATE customers_likes
SET customer_name = 'John Doe'
WHERE liked_product = 'Orange' OR liked_product = 'Pineapple' OR liked_product = 'Avocado';

-- 2nd way:
UPDATE customers_likes
SET customer_name = 'Bob Smith'
WHERE liked_product IN ('Orange' , 'Pineapple' , 'Avocado');


-- 3rd way:
UPDATE customers_likes
SET customer_name = 'John Doe'
WHERE EXISTS(SELECT customer_name FROM customers_likes WHERE liked_product IN ('Orange', 'Pineapple' , 'Avocado'));

/*
------ What's the difference?
-- If you want to update specific records in a table, DO NOT use EXISTS operator.
-- Because EXISTS operator works with a subquery. If that subquery returns true, EXISTS operator updates the WHOLE field.

-- It is COMMON for all!!

-- To update / delete specific records in a table, use traditional way like this:
UPDATE customers_likes
SET customer_name = 'Some name'
WHERE liked_product = 'Orange';

OR
use IN operator

*/


-- Delete records if there's 'Cherries' in liked_product list

DELETE
FROM customers_likes
WHERE liked_product = 'Cherries'; -- deletes specific data/ record which had 'Cherries'

-- with EXISTS operator
DELETE
FROM customers_likes
WHERE EXISTS (SELECT liked_product FROM customers_likes WHERE liked_product = 'Avocado');


-- This deletes all rows  because subquery returned true, EXISTS operator will delete all rows.


SELECT * FROM customers_likes;

DROP TABLE customers_likes;

---------------------------------------------------------------

CREATE TABLE customers_products1 (
  product_id INT,
  customer_name VARCHAR(30),
  product_name VARCHAR(30)
);

INSERT INTO customers_products1 VALUES (10, 'Mark Twain', 'Orange');
INSERT INTO customers_products1 VALUES (10, 'Mark Wilson', 'Mango');
INSERT INTO customers_products1 VALUES (20, 'John Clark', 'Apple, Orange, Mango');
INSERT INTO customers_products1 VALUES (30, 'Amy Williams', 'Plum');
INSERT INTO customers_products1 VALUES (20, 'Mark Donne', 'Apple');
INSERT INTO customers_products1 VALUES (10, 'Adam Smith', 'Orange');
INSERT INTO customers_products1 VALUES (40, 'John Evans', 'Apricot');
INSERT INTO customers_products1 VALUES (20, 'Eddie Murphy', 'Apple');
INSERT INTO customers_products1 VALUES (30, 'Anna Goldman', 'Mango, Apple, Orange');
INSERT INTO customers_products1 VALUES (50, 'Helen Green', 'Grapes');
INSERT INTO customers_products1 VALUES (10, 'Laura Owen', 'PineApple');
INSERT INTO customers_products1 VALUES (20, 'John Clark', 'Apple');
INSERT INTO customers_products1 VALUES (20, 'John Clark', 'Orange');
INSERT INTO customers_products1 VALUES (20, 'John Clark', 'Mango');


SELECT * FROM customers_products1;


SELECT *
FROM customers_products1
WHERE product_name = 'Mango, Apple, Orange';

----------------------

SELECT *
FROM customers_products1
WHERE product_name = 'Mango' AND  customer_name = 'John Clark';

----------------------

SELECT *
FROM customers_products1
WHERE product_name = 'Mango' AND  product_name = 'Apple' AND  product_name = 'Orange'; -- no record is returned


/*
In SQL, the AND operator is a logical operator that is used to combine multiple conditions in a WHERE clause.
When you use the AND operator, all conditions specified must evaluate to true for a row to be included in the result set.

customer_name = 'John Clark': This condition checks whether the customer_name column of a row equals 'John Clark'.

AND: This is the logical AND operator, which means both conditions on either side of it must be true for the row to be selected.

product_name = 'Apple': This condition checks whether the product_name column of a row equals 'Apple'.

So, the AND operator works by evaluating both conditions specified on either side of it.
If both conditions are true for a particular row in the customers_products1 table,
then that row will be included in the result set returned by the query.
If any one of the conditions is false for a row, that row will be excluded from the result set.

*/


