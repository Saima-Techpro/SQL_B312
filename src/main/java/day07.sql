------------ Day 07 ---------
---------NOT LIKE Operator with Wildcards --------

CREATE TABLE words(
  word_id CHAR(10) UNIQUE,
  word VARCHAR(30) NOT NULL,
  number_of_letters SMALLINT
);


INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selena', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);
INSERT INTO words VALUES (1009, 'learn', 5);
INSERT INTO words VALUES (1010, 'techpro', 7);


SELECT * FROM words;

-- Find words that do not end with 't' and 'f'

SELECT *
FROM words
WHERE word NOT LIKE '%t' AND word NOT LIKE '%f';

-- Find words that do not have 'a' and 'e' as second letter

SELECT *
FROM words
WHERE word NOT LIKE '_a%' AND word NOT LIKE '_e%';

-- Find words whose first character is 'h', second character can be 'o', 'a' and 'i' and last character must be 't'

-- 1st way:
SELECT *
FROM words
WHERE word LIKE 'ho%t' OR word LIKE 'ha%t' OR word LIKE 'hi%t';


-- 2nd way: Using REGEXP_LIKE

SELECT *
FROM words
WHERE REGEXP_LIKE (word, 'h[oai](.*)t'); -- (.*) works the same as %


-- 3rd way: which is actually simpler version of 2nd way(REGEXP_LIKE is replaced with ~ sign)

SELECT *
FROM words
WHERE word ~ 'h[oai](.*)t';


/*
----------- NOTES about REGEX	(Regular Epxressions) with LIKE Operator ----------

1. REGEXP_LIKE Operator: We use this operator for search operation

  Syntax:

  SELECT *
  FROM table_name
  WHERE REGEXP_LIKE (column_name, 'pattern that we are looking for in String Data')

2. REGEXP_LIKE Operator works with STRING data type

3. We can use REGEX operator with ~ sign

   Syntax:

  SELECT *
  FROM table_name
  WHERE column_name sign ~ 'pattern that we are looking for in String Data'

4.  Symbols
    (.*) looks for multiple characters => works the same way as % sign in wildcards; you can use it without parenthesis as well like .*
	(.) looks for single character
	$ => last character
	'^' carrot sign => to ensure we are searching for first character (given inside the square brackets)
	        e.g. '^[asy]' means a, s and y(given inside the square brackets) should be first character only
    '^' carrot sign => can also be used to exclude some data from search operation
            e.g. '^[^asy]' with one ^ inside the square brackets => a, s, and y (or any given letters) should NOT be the first characters for my data

5. Pattern searching:
    [aoi] => any of the given letters inside the square brackets
	[a-f] => all character inside the square brackets (from a to f)
*/


-- Find words whose first character is 'h', second charcater can be any charcater from 'a' to 'f' and last character must be 't'

-- 1st way:
SELECT *
FROM words
WHERE REGEXP_LIKE (word, 'h[a-f](.*)t$'); -- $ means last character but it works even without it as well

-- 2nd way:

SELECT *
FROM words
WHERE word ~ 'h[a-f](.*)t$';


-- Find words whose first character is 'a' , 's' or 'y'

SELECT *
FROM words
WHERE word ~ '^[asy].*'; -- we can also use .* instead of. (.*)

-- Find words whose last character is 'm' , 'o' or 'a'

SELECT *
FROM words
WHERE word ~ '(.*)[moa]$';


-- Find words whose first character is NOT 'a' , 's' or 'y'

SELECT *
FROM words
WHERE word ~ '^[^asy].*';



-- Find words whose first character is 's' and last character is 'a'
-- 1st way:
SELECT *
FROM words
WHERE word ~ '^[s](.*)a$';


-- 2nd way:
SELECT *
FROM words
WHERE word ~ '^[s](.*)[a]$';

-- 3rd way:
SELECT *
FROM words
WHERE word ~ '^[s](.*)a';


-- 4th way:
SELECT *
FROM words
WHERE word ~ '^s(.*)a';

-- 5th way:
SELECT *
FROM words
WHERE word ~ '^s.*a'; -- simplest

-- ^ carrot sign, $ sign and [] become optional when we are searching for a SINGLE character in the query


-- Find words which start with 's' or 't' and ends with 'a' or 'o'
SELECT *
FROM words
WHERE word ~ '^[st].*[ao]';

-- OR

SELECT *
FROM words
WHERE word ~ '^[st].*[ao]$'; -- $ sign is optional


SELECT * FROM words;


-------------- HOMEWORK ----------------
-- 1.	Find names which does not start with 'E' and does not end with 'y' from company_employees table.
-- 2.	Find names whose first character is not 'J', 'B' or 'E' and last character is not 'r' or 't' from company_employees table.
-- 3.	Find names which start with chars from 'A' to 'F' and third character is 'a' from company_employees table.


SELECT * FROM company_employees;

-- For further practice =>  https://regexr.com/


-------------- Concatenation in SQL ------------

CREATE TABLE employees1 (
  employee_id numeric(9),
  employee_first_name VARCHAR(20),
  employee_last_name VARCHAR(20)
);


INSERT INTO employees1 VALUES(14, 'Chris', 'Tae');
INSERT INTO employees1 VALUES(11, 'John', 'Walker');
INSERT INTO employees1 VALUES(12, 'Amy', 'Star');
INSERT INTO employees1 VALUES(13, 'Brad', 'Pitt');
INSERT INTO employees1 VALUES(15, 'Chris', 'Way');

-- Following values are added later

INSERT INTO employees1 (employee_id, employee_first_name) VALUES(15, 'Ali');
INSERT INTO employees1 (employee_id, employee_last_name) VALUES(17, 'Can');

SELECT * FROM employees1;

SELECT employee_first_name , employee_last_name
FROM employees1;

SELECT employee_first_name
FROM employees1;


SELECT employee_last_name
FROM employees1;

-- Merge first name and last name => full name

SELECT employee_first_name ||' '|| employee_last_name AS full_name
FROM employees1;


SELECT employee_first_name ||' => '|| 'This is my first name' AS Full_name
FROM employees1;

-- Merge id, first and last name  (Bio data)

SELECT employee_id ||' - '|| employee_first_name ||' '|| employee_last_name AS Biodata
FROM employees1;


-- OR use CONCAT() function

SELECT CONCAT(employee_first_name , ' ' , employee_last_name)
FROM employees1;

-- NOTE: In case of null value in any of the columns, concatenation through this sign ||' - '|| will return null; but the CONCAT() function will return the value that exists in any of the given column

SELECT LENGTH(employee_first_name)
FROM employees1;


-------------------- GROUP BY CLAUSE -----------------
-- It is used for grouping the data together in one field
-- It is mostly used with AGGREGATE FUNCTIONS

CREATE TABLE shopping_list (
    item_id SERIAL PRIMARY KEY,
    category VARCHAR(50),
    item_name VARCHAR(50),
    price DECIMAL(8, 2)
);


INSERT INTO shopping_list (category, item_name, price)
VALUES
    ('Fruits', 'Apple', 1.50),
    ('Vegetables', 'Tomato', 1.00),
    ('Dairy', 'Milk', 2.25),
    ('Bakery', 'Muffin', 1.50),
    ('Meat', 'Chicken', 5.50),
    ('Vegetables', 'Carrot', 0.75),
    ('Meat', 'Mutton', 6.80),
    ('Dairy', 'Cheese', 3.75),
    ('Fruits', 'Banana', 0.99),
    ('Bakery', 'Croissant', 2.00),
    ('Bakery', 'Baguette', 2.20),
    ('Meat', 'Salmon', 9.99),
    ('Fruits', 'Grapes', 2.50),
    ('Vegetables', 'Broccoli', 1.25),
    ('Dairy', 'Butter', 2.50),
    ('Dairy', 'Yogurt', 1.99),
    ('Vegetables', 'Spinach', 1.80),
    ('Fruits', 'Orange', 1.25),
    ('Bakery', 'Bread', 1.80),
    ('Meat', 'Beef', 7.20);


SELECT * FROM shopping_list;


SELECT category
FROM shopping_list;

SELECT price
FROM shopping_list;

SELECT category , price
FROM shopping_list;

-- Find how much is the total price for each category

SELECT category , SUM(price)
FROM shopping_list
GROUP BY category;

-- Find average price for each category
SELECT category , ROUND(AVG(price), 3) AS average_price
FROM shopping_list
GROUP BY (category);

-- Find min, max, and total number of items for each category

SELECT category,
MAX(price) AS Max_price,
MIN(price) AS Min_price ,
COUNT (item_id) total_num_of_items
FROM shopping_list
GROUP BY category;


----------------------------------------------

SELECT * FROM company_employees;

SELECT name
FROM company_employees;

SELECT SUM(salary)
FROM company_employees;

-- Find total salary for each employee from company_employees table

SELECT name, SUM(salary) AS total_salary
FROM company_employees
GROUP BY name;


-- Find number of employees per state in descending order
SELECT state, COUNT(id) AS total_num_of_employees
FROM company_employees
GROUP BY (state)
ORDER BY COUNT(id) DESC;

-- OR we can also use the ALIAS in place of Aggregate function

SELECT state, COUNT(id) AS total_num_of_employees
FROM company_employees
GROUP BY (state)
ORDER BY total_num_of_employees DESC;


-- Find total number of employees for each company which is paying more than 4000

SELECT company, COUNT(id) AS total_num_of_employees
FROM company_employees
WHERE salary > 4000 -- WHERE condition is ised to filter data, ALWAYS use this BEFORE BROUP BY
GROUP BY company;


-- Find total salary for each employee and returns the ones who are earnign more than 3000

SELECT name, SUM(salary) AS total_salary
FROM company_employees
GROUP BY name
HAVING SUM(salary) > 3000; -- HAVING clause is used for filtering data AFTER grouping the data



SELECT * FROM company_employees;

-------------------- HAVING CLAUSE -------------------

-- HAVING Clause is used to filter the result of AGGREGATE FUNCTIONS
-- HAVING Clause works in combination with GROUP BY
-- Both WHERE condition and HAVING Clause are used to filter the data
-- DIFFERENCE: WHERE condition filters the individual data BEFORE grouping;
--			   while HAVING Clause filters the result AFTER grouping.
-- HAVING Clause works with AGGREGATE FUNCTIONS ONLY. (not with ALIAS)


------------------------------------------------------

CREATE TABLE MovieReviews (
    review_id SERIAL PRIMARY KEY,
    movie_name VARCHAR(50) NOT NULL,
    reviewer VARCHAR(50) NOT NULL,
    rating INTEGER CHECK (rating BETWEEN 1 AND 5),
    review_date DATE NOT NULL
);


INSERT INTO MovieReviews (movie_name, reviewer, rating, review_date) VALUES
('Inception', 'Alice', 5, '2024-11-01'),
('Inception', 'Bob', 4, '2024-11-02'),
('Titanic', 'Alice', 5, '2024-11-03'),
('Titanic', 'Charlie', 3, '2024-11-03'),
('Avatar', 'Alice', 4, '2024-11-05'),
('Avatar', 'David', 5, '2024-11-06'),
('The Matrix', 'Bob', 3, '2024-11-07'),
('The Matrix', 'Charlie', 4, '2024-11-08'),
('The Matrix', 'Alice', 5, '2024-11-09'),
('Inception', 'David', 5, '2024-11-10'),
('Titanic', 'Bob', 2, '2024-11-11'),
('Avatar', 'Charlie', 4, '2024-11-12'),
('The Last Samurai', 'Goychak', 5, '2024-11-12'),
('Shawshank Redemption', 'Pelin', 5, '2024-11-20'),
('Bourne Identity', 'Shukrullah', 5, '2024-11-19'),
('Skyfall', 'Natalia', 5, '2024-11-18'),
('Leave the World Behind', 'Pelin', 1, '2024-11-20'),
('Barbie', 'Shukrullah', 1, '2024-11-08'),
('Skyfall', 'Natalia', 5, '2024-11-18');


-- Count how many reviews have been submitted for each movie
SELECT movie_name, COUNT(review_id) AS total_reviews
FROM MovieReviews
GROUP BY movie_name;

-- OR
SELECT movie_name, COUNT(*) AS total_reviews
FROM MovieReviews
GROUP BY movie_name;

-- Find the average rating for each movie
SELECT movie_name, ROUND(AVG(rating), 1) AS avg_rating
FROM MovieReviews
GROUP BY movie_name;


-- Find the movies with more than 2 reviews

SELECT movie_name, COUNT(*) AS total_reviews
FROM MovieReviews
GROUP BY movie_name
HAVING COUNT(*)  > 2;

-- Find reviewer who has given the highest rating across all the movies
-- 1st way
SELECT reviewer, ROUND(AVG(rating) , 1)  avg_review
FROM MovieReviews
GROUP BY reviewer
ORDER BY avg_review DESC
LIMIT 1;

-- 2nd way: Using HAVING clause and  getting the maximum average rating dynamically through a subquery

SELECT reviewer, ROUND(AVG(rating) , 1)  avg_review
FROM MovieReviews
GROUP BY reviewer
HAVING ROUND(AVG(rating) , 1) = (SELECT MAX(avg_rating) FROM (SELECT AVG(rating) AS avg_rating FROM MovieReviews GROUP BY reviewer));



--------------- ADVANCE QUESTIONS- optional --------------

-- Find movies with more than 3 reviews where the average rating is greater than 4.

SELECT movie_name, COUNT(*) AS total_reviews, AVG(rating) AS average_rating
FROM MovieReviews
GROUP BY movie_name
HAVING COUNT(*) > 3 AND AVG(rating) > 4;

-- Identify reviewers who have reviewed at least 2 movies with an average rating below 3.

SELECT reviewer, COUNT(*) AS reviewed_movies, AVG(rating) AS average_rating
FROM MovieReviews
GROUP BY reviewer
HAVING COUNT(*) >= 2 AND AVG(rating) < 3;

--Find the number of movies reviewed on each date where at least 2 movies were reviewed.

SELECT review_date, COUNT(DISTINCT movie_name) AS movies_reviewed
FROM MovieReviews
GROUP BY review_date
HAVING COUNT(DISTINCT movie_name) >= 2;

--List movies with more than 1 review where the maximum rating given is at least twice the minimum rating.

SELECT movie_name, MAX(rating) AS max_rating, MIN(rating) AS min_rating
FROM MovieReviews
GROUP BY movie_name
HAVING COUNT(*) > 1 AND MAX(rating) >= 2 * MIN(rating);

--Find reviewers who have given the exact same rating to all their reviewed movies.

SELECT reviewer, MIN(rating) AS consistent_rating
FROM MovieReviews
GROUP BY reviewer
HAVING MIN(rating) = MAX(rating);





SELECT * FROM MovieReviews;





