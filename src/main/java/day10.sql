-------------------- Day 10 -------------------

---------- CTE - Common Table Expression --------
/*

In SQL, CTE stands for Common Table Expression.
It is a temporary result set that you can refer to within a SELECT, INSERT, UPDATE, or DELETE statement.
CTEs make your queries more readable and maintainable, especially when dealing with complex queries.

Syntax:

WITH cte_name (column1, column2, ...) AS (
    -- SQL query
)
SELECT * FROM cte_name;


Key Features:
Temporary Scope: A CTE exists only for the duration of the query in which it is defined.
Readability: It allows breaking down a complex query into simpler parts, making it easier to understand and debug.
Recursive Queries: You can use CTEs to perform recursive operations, such as traversing hierarchical data like trees or graphs.

*/



CREATE TABLE city_routes (
    routeID SERIAL PRIMARY KEY,
    start_point VARCHAR(50) NOT NULL,
    end_point VARCHAR(50) NOT NULL,
    distance DECIMAL(5, 2) NOT NULL,
    parent_routeID INT
);


INSERT INTO city_routes (start_point, end_point, distance, parent_routeID) VALUES
('Downtown', 'City Park', 5.0, NULL),
('City Park', 'Uptown', 12.0, 1),
('Downtown', 'Airport', 25.0, NULL),
('Uptown', 'Airport', 18.0, 2),
('City Park', 'Station A', 8.0, 1),
('Station A', 'Station B', 15.0, 5),
('Station B', 'Downtown', 20.0, 6);


SELECT * FROM city_routes;



-- Find all routes shorter than 10 km
-- 1st way: works for simpler queries

SELECT routeID, start_point, end_point , distance
FROM city_routes
WHERE distance < 10;


-- 2nd way: Using CTE

WITH short_routes AS (

SELECT routeID, start_point, end_point , distance
FROM city_routes
WHERE distance < 10

)
SELECT * FROM short_routes;


-- Find routes starting from 'Downtown' ending at the 'Airport'.


WITH DowntownToAirport AS (
	SELECT routeID, start_point, end_point , distance
	FROM city_routes
	WHERE start_point = 'Downtown' AND end_point = 'Airport'
)
SELECT * FROM DowntownToAirport;


-- OR use Multiple CTEs

WITH DowntownToAirport AS (
	SELECT routeID, start_point, end_point , distance
	FROM city_routes
	WHERE start_point = 'Downtown' AND end_point = 'Airport'
),

AirportRoutes AS (
	SELECT routeID, start_point, end_point , distance
	FROM city_routes
	WHERE start_point = 'Uptown' AND end_point = 'Airport'
)

SELECT * FROM DowntownToAirport
UNION
SELECT * FROM AirportRoutes;


-- Using CTE in UPDATE statement

WITH UpdateParkRoutes AS (
	SELECT routeID
	FROM city_routes
	WHERE start_point = 'City Park'
)

UPDATE city_routes
SET distance = distance * 1.10
WHERE routeID IN (SELECT * FROM UpdateParkRoutes);


SELECT * FROM city_routes;


-- Task 4: CTE with Aggregation
-- Calculate the total distance of all routes grouped by their starting points.


WITH RouteDistances AS (
    SELECT start_point, SUM(distance) AS TotalDistance
    FROM city_routes
    GROUP BY start_point
)
SELECT * FROM RouteDistances;


-- Task 5: Find Direct Connections
-- List all direct connections between routes (where one route’s endpoint matches another route’s starting point).

WITH DirectConnections AS (
    SELECT
        r1.routeID AS Route1, r1.start_point AS FromPoint, r1.end_point AS ToPoint,
        r2.routeID AS Route2, r2.start_point AS NextFromPoint, r2.end_point AS NextToPoint
    FROM city_routes r1
    INNER JOIN city_routes r2
    ON r1.end_point = r2.start_point
)
SELECT * FROM DirectConnections;

--------------- CASE STATEMENT ---------------
/*
The CASE statement in SQL is a powerful conditional expression that allows us to implement logic directly in our queries. (Similar to if-else statements in Java)

SYNTAX:

CASE
 WHEN condition1 THEN result1
 WHEN condition2 THEN result2
 ....
 ELSE default_result

END

*/
CREATE TABLE student_grades (
    studentID INT,
    student_name VARCHAR(50),
    subject VARCHAR(50),
    marks INT,
    term INT
);

DROP TABLE student_grades;

INSERT INTO student_grades (studentID, student_name, subject, marks, term) VALUES
(1, 'Ali', 'Math', 85, 1),
(2, 'Fatih', 'Science', 60, 1),
(3, 'Veli', 'Math', 40, 1),
(4, 'Aygul', 'Comp. Sc.', 90, 1),
(5, 'Melissa', 'Comp. Sc.', 55, 1),
(6, 'Seher', 'Math', 99, 1),
(7, 'Mustafa', 'Science', 90, 1),
(8, 'Emily', 'Math', 35, 1),
(9, 'Omar', 'Comp. Sc.', 78, 1),
(10, 'Anisa', 'Comp. Sc.', 82, 1),
(11, 'Deniz', 'Science', 50, 1),
-- for term 2
(12, 'Ali', 'Math', 90, 2),
(13, 'Fatih', 'Science', 80, 2),
(14, 'Veli', 'Math', 70, 2),
(15, 'Aygul', 'Comp. Sc.', 70, 2),
(16, 'Melissa', 'Comp. Sc.', 75, 2),
(17, 'Seher', 'Math', 95, 2),
(18, 'Mustafa', 'Science', 70, 2),
(19, 'Emily', 'Math', 45, 2),
(20, 'Omar', 'Comp. Sc.', 88, 2),
(21, 'Anisa', 'Comp. Sc.', 62, 2),
(22, 'Deniz', 'Science', 70, 2);


SELECT * FROM student_grades;


-- Find out whos is Passed or failed. Add a column that shows 'Pass' if marks are 50 or above, otherwise 'Fail'

SELECT student_name, subject, marks,
CASE
	WHEN marks >= 50 THEN 'Pass'
	ELSE 'Fail'
END AS Status
FROM student_grades;

-- Grade students:
-- Assign grades based on marks:
-- A for marks ≥ 85,
-- B for 70–84,
-- C for 50–69,
-- D for marks < 50.

SELECT  student_name, subject, marks,
    CASE
        WHEN marks >= 85 THEN 'A'
        WHEN marks BETWEEN 70 AND 84 THEN 'B'
        WHEN marks BETWEEN 50 AND 69 THEN 'C'
        ELSE 'D'
    END AS Grade
FROM student_grades;


-- Elyas' solution:

SELECT student_name, subject, marks,
CASE
WHEN marks < 50 THEN 'D'
WHEN marks < 70 THEN 'C'
WHEN marks < 85 THEN 'B'
WHEN marks >84  THEN 'A'
ELSE 'Fail'
END
FROM student_grades;

-- Find out the top performers from student_grades table
-- Show 'Top Performer' for students who get 90 or above. otherwise 'Regular'


SELECT student_name, subject, marks,

CASE
	WHEN marks >= 90 THEN 'Top Performer'
	ELSE 'Regular'
END AS Performance

FROM student_grades;

-- Term-wise classification
-- Display 'First Half' for temr 1, and 'Second Half' for term 2

SELECT *,
CASE
	WHEN term = 1 THEN 'First Half'
	WHEN term = 2 THEN 'Second Half'
END AS TermPeriod

FROM student_grades;

-- OR

SELECT *,
CASE
WHEN term = 1 THEN 'First Half'
ELSE 'Second Half'
END
FROM student_grades;

-- Filter subjects
-- Display 'Core' for Math and Science, 'Optional' for Comp.Sc.


SELECT
    student_name, subject,
    CASE
        WHEN subject = 'Math' THEN 'Core'
        WHEN subject = 'Comp. Sc.' THEN 'Optional'
    END AS SubjectType
FROM student_grades;


-- OR
SELECT *,
CASE
WHEN subject IN ('Math','Science') THEN 'Core'
ELSE 'Optional'
END
FROM student_grades;


-- Intermediate Tasks

-- Find students for following awards and titles:
-- 'Star Student' for students with ALL subjects ≥ 85,
-- 'Achiever' for at least one subject ≥ 85,
-- 'Needs Improvement' otherwise.

SELECT student_name,

CASE
	WHEN MIN(marks) >=85 THEN 'Star Student'
	WHEN MAX(marks) >=85 THEN 'Achiever'
	ELSE 'Needs Improvement'
END AS student_titles

FROM student_grades
GROUP BY student_name;


-- Analyse Subject performance
-- Classify subjects based on the average marks
-- Good if average marks >=70
-- Average if 50-69
-- Poor if < 50

SELECT subject, AVG(marks),

CASE
	WHEN ROUND(AVG(marks), 2) >= 70 THEN 'Good'
	WHEN ROUND(AVG(marks), 2) BETWEEN 50 AND 69.99  THEN 'Average'  -- checks range => all nnumbers from 50 to 69.99
-- 	WHEN ROUND(AVG(marks), 2) IN(50, 69)  THEN 'Average' -- Checks only 2 values 50 , 69
	ELSE 'Poor'
END AS SubjectPerformance
FROM student_grades
GROUP BY subject

-- OR

WITH SubjectAverages AS (
    SELECT subject, ROUND(AVG(marks), 2 )AS AvgMarks
    FROM student_grades
    GROUP BY subject
)
SELECT subject, AvgMarks,
    CASE
        WHEN AvgMarks >= 70 THEN 'Good'
        WHEN AvgMarks BETWEEN 50 AND 69 THEN 'Average'
        ELSE 'Poor'
    END AS Performance
FROM SubjectAverages;


-- Task 8: Performance Trend
-- Compare marks in Math across semesters for each student:

-- Improved if Semester 2 marks > Semester 1 marks,
-- Declined if less,
-- Stable if equal.

WITH MathMarks AS (
    SELECT student_name, term, marks
    FROM student_grades
    WHERE subject = 'Math'
)
SELECT m1.student_name,
    CASE
        WHEN m2.marks > m1.marks THEN 'Improved'
        WHEN m2.marks < m1.marks THEN 'Declined'
        ELSE 'Stable'
    END AS Trend
FROM MathMarks m1
JOIN MathMarks m2
ON m1.student_name = m2.student_name AND m1.term = 1 AND m2.term = 2;


SELECT * FROM student_grades;


---------------------- Pl/pgSQL ----------------------
-- Pl => Procedural
-- pg => Postgre
-- SQL => Structured Query Language

/*

PL/pgSQL stands for "Procedural Language/PostgreSQL Structured Query Language."
It is PostgreSQL's procedural language, used to write functions, triggers, anonymous blocks, and control-flow logic.

Regular SQL is declarative:
“What you want to do” (like SELECT, UPDATE, DELETE)
PL/pgSQL adds procedural power:
“How you want to do it” (with IF, LOOP, CASE, variables, etc.)

1. anonymous blocks (return type is void)
Syntax:
 do $$
 declare (optional)
 begin

 end $$


2. Functions

*/

--1. anonymous blocks

do $$
declare
		-- variable declaration in Java
		-- data_type variable_name assignment operator value;
		-- String firstName = 'John';

		-- variable declaration in SQL
		-- variable_name  data_type  := value;
		-- first_name VARCHAR (20) := 'John';

		first_name VARCHAR (20) := 'John';
		last_name VARCHAR (20) := 'Smith';
		payment NUMERIC (4, 2) := 20.5;

begin
		-- raise notice works like System.out.println("First name: " + firstName)
		-- we can also raise warning, info, error etc.

	raise notice 'First name: % , Last name: %' , first_name , last_name;

end $$;


-- Raise an output : somebody received some money

do $$
declare
		first_name VARCHAR (20) := 'John';
		last_name VARCHAR (20) := 'Smith';
		payment NUMERIC (4, 2) := 20.5;
begin
-- 	raise notice 'First name: %  received % USD.' , first_name, payment;
	raise notice '% received %USD.' , first_name, payment;
end $$;


-- Raise an output : Person A and Person B bought tickets for 50 USD

do $$
declare
	name VARCHAR(10) := 'Emily';
	name2 VARCHAR(10) := 'John';
	price integer := 50;
begin
	raise info '% and % bought tickets for % USD', name, name2 , price;
end $$;

------------------------ FUNCTIONS --------------------------

/*

SYNTAX:

CREATE OR REPLACE FUNCTION function_name(parameter_name data_type, ...)
RETURNS return_data_type AS $$
BEGIN
    -- Function body (logic or query)
    RETURN value;
END;
$$ LANGUAGE plpgsql;

NOTES:

function_name: The name of the function.
parameter_name and data_type: Input parameters for the function (optional).
RETURNS: Specifies the data type of the result (e.g., INTEGER, TEXT, TABLE).
AS $$ ... $$: Contains the function body.
LANGUAGE: Specifies the language used (e.g., plpgsql, sql).
*/

CREATE OR REPLACE FUNCTION addition(a INTEGER, b INTEGER)
RETURNS INTEGER AS
$$
BEGIN
	RETURN a + b;
END
$$ LANGUAGE plpgsql;

SELECT addition(4, 6) AS sum; -- 10

-- Function with conditional logic

CREATE OR REPLACE FUNCTION get_discount(amount NUMERIC)
RETURNS NUMERIC AS
$$
BEGIN
	IF amount > 1000 THEN
	RETURN amount * 0.10; -- 10% discount
	ELSE
	RETURN amount;  -- no discount
	END IF;

END
$$ LANGUAGE plpgsql;


SELECT get_discount(1400) AS discount;

SELECT get_discount(600) AS no_discount;


-- Function that returns a table

SELECT * FROM fetch_active_customers();


CREATE OR REPLACE FUNCTION fetch_active_customers()
RETURNS TABLE (customer_id INTEGER, cutomer_name VARCHAR)
AS
$$
BEGIN
-- 	RETURN QUERY SELECT id, name FROM customers WHERE status = 'Active';
	RETURN QUERY SELECT id, name FROM manufacturers WHERE country = 'Japan';
END
$$ LANGUAGE plpgsql;


-- Call the above function


SELECT id, name FROM manufacturers WHERE country = 'Japan';

-- How to drop a function?
DROP FUNCTION fetch_active_customers();