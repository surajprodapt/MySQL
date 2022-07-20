-- Connect to MySQL
mysql -u root -p

-- show databases
show databases;

-- load existing database 

source path\yourdb.sql

-- Create db
create database database_name;

-- drop db
drop database database_name

-- use/select db
use database_name

/* Create Table*/
create table course_list (
    course_id INT NOT NULL AUTO_INCREMENT,
    course_title VARCHAR(100) NOT NULL,
    course_author VARCHAR(40) NOT NULL,
    creation_date DATE,
    PRIMARY KEY (course_id)
);

/* Drop Table*/
drop table course_list;

/** Insert into table **/

INSERT INTO course_list (course_title, course_author, creation_date) 
    VALUES
    ("Java", "Venkat", NOW()),
    ("Python", "Trupthi", NOW()),
    ("MySQL", "Deepak", NOW());

-- Querying Data
-- Select queries 

SELECT select_list FROM table_name;

SELECT lastName
FROM employees;

SELECT 
    lastName, 
    firstName, 
    jobTitle
FROM
    employees;


SELECT * 
FROM employees;

SELECT 1 + 1;    

SELECT NOW();

SELECT CONCAT('John',' ','Doe');

-- column alias
SELECT expression AS column_alias;
SELECT CONCAT('John',' ','Doe') AS name;
SELECT CONCAT('Jane',' ','Doe') AS 'Full name';



-- Sorting Data

SELECT 
   select_list
FROM 
   table_name
ORDER BY 
   column1 [ASC|DESC], 
   column2 [ASC|DESC],
   ...;

--
SELECT
	contactLastname,
	contactFirstname
FROM
	customers
ORDER BY
	contactLastname;
--
SELECT
	contactLastname,
	contactFirstname
FROM
	customers
ORDER BY
	contactLastname DESC;

--
SELECT 
    contactLastname, 
    contactFirstname
FROM
    customers
ORDER BY 
	contactLastname DESC , 
	contactFirstname ASC;

--
SELECT 
    orderNumber, 
    orderlinenumber, 
    quantityOrdered * priceEach
FROM
    orderdetails
ORDER BY 
   quantityOrdered * priceEach DESC;

--
SELECT 
    orderNumber,
    orderLineNumber,
    quantityOrdered * priceEach AS subtotal
FROM
    orderdetails
ORDER BY subtotal DESC;

--
SELECT 
    orderNumber, status
FROM
    orders
ORDER BY FIELD(status,
        'In Process',
        'On Hold',
        'Cancelled',
        'Resolved',
        'Disputed',
        'Shipped');

--
SELECT 
    firstName, lastName, reportsTo
FROM
    employees
ORDER BY reportsTo;

--
SELECT 
    firstName, lastName, reportsTo
FROM
    employees
ORDER BY reportsTo DESC;

-- Filtering data
-- WHERE – learn how to use the WHERE clause to filter rows based on specified conditions.
-- SELECT  DISTINCT – show you how to use the DISTINCT operator in the SELECT statement to eliminate duplicate rows in a result set.
-- AND – introduce you to the AND operator to combine Boolean expressions to form a complex condition for filtering data.
-- OR– introduce you to the OR operator and show you how to combine the OR operator with the AND operator to filter data.
-- IN – show you how to use the IN operator in the WHERE clause to determine if a value matches any value in a set.
-- NOT IN – negate the IN operator using the NOT operator to check if a value doesn’t match any value in a set.
-- BETWEEN – show you how to query data based on a range using BETWEEN operator.
-- LIKE  – provide you with technique to query data based on a pattern.
-- LIMIT – use LIMIT to constrain the number of rows returned by SELECT statement
-- IS NULL – test whether a value is NULL or not by using IS NULL operator.

SELECT 
    select_list
FROM
    table_name
WHERE
    search_condition;

-- WHERE clause to find all employees whose job titles are Sales Rep
SELECT 
    lastname, 
    firstname, 
    jobtitle
FROM
    employees
WHERE
    jobtitle = 'Sales Rep';


-- WHERE clause to find employees whose job titles are Sales Rep and office codes are 1
SELECT 
    lastname, 
    firstname, 
    jobtitle,
    officeCode
FROM
    employees
WHERE
    jobtitle = 'Sales Rep' AND 
    officeCode = 1;

-- WHERE clause uses the AND operator to combine two conditions
-- jobtitle = 'Sales Rep' AND officeCode = 1;
-- employees whose job title is Sales Rep or employees who locate the office with office code 1

SELECT 
    lastName, 
    firstName, 
    jobTitle, 
    officeCode
FROM
    employees
WHERE
    jobtitle = 'Sales Rep' OR 
    officeCode = 1
ORDER BY 
    officeCode , 
    jobTitle;

-- WHERE clause with the BETWEEN operator example
-- employees who locate in offices whose office code is from 1 to 3
SELECT 
    firstName, 
    lastName, 
    officeCode
FROM
    employees
WHERE
    officeCode BETWEEN 1 AND 3
ORDER BY officeCode;

--  employees whose last names end with the string 'son'
-- Ending with '%match_word'
-- Start with 'match_word%'
-- match '%match_word%'
SELECT 
    firstName, 
    lastName
FROM
    employees
WHERE
    lastName LIKE '%son'
ORDER BY firstName;

-- WHERE clause with the IN operator to find employees who locate in the office with office code 1.
SELECT 
    firstName, 
    lastName, 
    officeCode
FROM
    employees
WHERE
    officeCode IN (1 , 2, 3)
ORDER BY 
    officeCode;

-- WHERE clause with the IS NULL operator to get the rows with the values in the reportsTo column are NULL:

SELECT 
    lastName, 
    firstName, 
    reportsTo
FROM
    employees
WHERE
    reportsTo IS NULL;

-- Operator	Description
-- =	        Equal to. You can use it with almost any data type.
-- <> or !=	Not equal to
-- <	        Less than. You typically use it with numeric and date/time data types.
-- >	        Greater than.
-- <=	        Less than or equal to
-- >=	        Greater than or equal to

-- not equal to (<>) operator to find all employees who are not the Sales Rep:
SELECT 
    lastname, 
    firstname, 
    jobtitle
FROM
    employees
WHERE
    jobtitle <> 'Sales Rep';


-- employees whose office code is greater than 5

SELECT 
    lastname, 
    firstname, 
    officeCode
FROM
    employees
WHERE 
    officecode > 5;

    
-- Joining tables

-- Table & Column Aliases – introduce you to table and column aliases.
-- Joins  – give you an overview of joins supported in MySQL including inner join, left join, and right join.
-- INNER JOIN – query rows from a table that has matching rows in another table.
-- LEFT JOIN – return all rows from the left table and matching rows from the right table or null if no matching rows found in the right table.
-- RIGHT JOIN – return all rows from the right table and matching rows from the left table or null if no matching rows found in the left table.
-- CROSS JOIN – make a Cartesian product of rows from multiple tables.
-- Self-join – join a table to itself using table alias and connect rows within the same table using inner join and left join.

SELECT 
   [column_1 | expression] AS `descriptive name`
FROM 
   table_name;

-- selects the first names and last names of employees. It uses the CONCAT_WS() function to concatenate first name and last name into full name.

SELECT 
    CONCAT_WS(', ', lastName, firstname)
FROM
    employees;


-- column heading of the output a column alias as shown in the following query:
SELECT
   CONCAT_WS(', ', lastName, firstname) AS `Full name`
FROM
   employees;


-- ORDER BY clause to sort the employee’s full names alphabetically:
SELECT
	CONCAT_WS(', ', lastName, firstname) `Full name`
FROM
	employees
ORDER BY
	`Full name`;

-- selects the orders whose total amount is greater than 60000. It uses column aliases in GROUP BY and HAVING clauses.
SELECT
	orderNumber `Order no.`,
	SUM(priceEach * quantityOrdered) total
FROM
	orderDetails
GROUP BY
	`Order no.`
HAVING
	total > 60000;

-- table alias
-- SELECT * FROM employees e;

SELECT 
    e.firstName, 
    e.lastName
FROM
    employees e
ORDER BY e.firstName;

--
SELECT
	customerName,
	COUNT(o.orderNumber) total
FROM
	customers c
INNER JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY
	customerName
ORDER BY
	total DESC;

-- 
SELECT
	customers.customerName,
	COUNT(orders.orderNumber) total
FROM
	customers
INNER JOIN orders ON customers.customerNumber = orders.customerNumber
GROUP BY
	customerName
ORDER BY
	total DESC

------------------------------------------------------------------------------------------------------
-- Joins practice
-- Setting up sample tables
-- First, create two tables called members and committees:
-- 

CREATE TABLE members (
    member_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY (member_id)
);

CREATE TABLE committees (
    committee_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY (committee_id)
);

-- Second, insert some rows into the tables members and committees :
INSERT INTO members(name)
VALUES('John'),('Jane'),('Mary'),('David'),('Amelia');

INSERT INTO committees(name)
VALUES('John'),('Mary'),('Amelia'),('Joe');

-- Third, query data from the tables members and committees:

SELECT * FROM members;

SELECT * FROM committees;

-- MySQL INNER JOIN clause
-- syntax
SELECT column_list
FROM table_1
INNER JOIN table_2 ON join_condition;

-- nner join clause to find members who are also the committee members:

SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
INNER JOIN committees c ON c.name = m.name;

-- Because both tables use the same column to match, you can use the USING clause as shown in the following query:
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
INNER JOIN committees c USING(name);


-- MySQL LEFT JOIN clause
-- basic syntax of a left join clause that joins two tables:
SELECT column_list 
FROM table_1 
LEFT JOIN table_2 ON join_condition;

-- The left join also supports the USING clause if the column used for matching in both tables are the same:
SELECT column_list 
FROM table_1 
LEFT JOIN table_2 USING (column_name);

--  left join clause to join the members with the committees table:

SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
LEFT JOIN committees c USING(name);

-- left join clause with the USING syntax:

SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
LEFT JOIN committees c USING(name);

-- To find members who are not the committee members, you add a WHERE clause and IS NULL operator as follows:
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
LEFT JOIN committees c USING(name)
WHERE c.committee_id IS NULL;


-- MySQL RIGHT JOIN clause
-- syntax of the right join:

SELECT column_list 
FROM table_1 
RIGHT JOIN table_2 ON join_condition;

 -- left join clause, the right clause also supports the USING syntax:
SELECT column_list 
FROM table_1 
RIGHT JOIN table_2 USING (column_name);

-- To find rows in the right table that does not have corresponding rows in the left table, you also use a WHERE clause with the IS NULL operator:
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
RIGHT JOIN committees c on c.name = m.name;


-- right join to join the members and committees tables:

SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
RIGHT JOIN committees c on c.name = m.name;


-- right join clause with the USING syntax:

SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
RIGHT JOIN committees c USING(name);

-- To find the committee members who are not in the members table, you use this query:
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
RIGHT JOIN committees c USING(name)
WHERE m.member_id IS NULL;


-- MySQL CROSS JOIN clause
-- syntax to cross join
SELECT select_list
FROM table_1
CROSS JOIN table_2;

-- cross join clause to join the members with the committees tables:

SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
CROSS JOIN committees c;
--------------------------------------------------------------------------------------------------------

-- Grouping data

SELECT 
    c1, c2,..., cn, aggregate_function(ci)
FROM
    table
WHERE
    where_conditions
GROUP BY c1 , c2,...,cn;

-- group values of the order’s status into subgroups, you use the GROUP BY clause with the status column as the following query:
SELECT 
    status
FROM
    orders
GROUP BY status;

-- the GROUP BY clause returns unique occurrences of status values. It works like the DISTINCT operator as shown in the following query:

SELECT DISTINCT
    status
FROM
    orders;

-- Using MySQL GROUP BY with aggregate functions

SELECT 
    status, COUNT(*)
FROM
    orders
GROUP BY status;

-- To get the total amount of all orders by status, you join the orders table with the orderdetails 
-- table and use the SUM function to calculate the total amount. See the following query:

SELECT 
    status, 
    SUM(quantityOrdered * priceEach) AS amount
FROM
    orders
INNER JOIN orderdetails 
    USING (orderNumber)
GROUP BY 
    status;

-- the following query returns the order numbers and the total amount of each order.
SELECT 
    orderNumber,
    SUM(quantityOrdered * priceEach) AS total
FROM
    orderdetails
GROUP BY 
    orderNumber;

-- Sub Queries
SELECT 
    lastName, firstName
FROM
    employees
WHERE
    officeCode IN (SELECT 
            officeCode
        FROM
            offices
        WHERE
            country = 'USA');

-- the following query returns the customer who has the highest payment.
SELECT 
    customerNumber, 
    checkNumber, 
    amount
FROM
    payments
WHERE
    amount = (SELECT MAX(amount) FROM payments);














