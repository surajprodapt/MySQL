--check version
mysql -V 


--Access MySQL  --cmd --gui editors:
mysql -u root -p

 --crud operations
--Show Database
show databases;
SHOW DATABASES;

--Create Database
Create DATABASE prodapt_database;

--use database

USE prodapt_database;

--show tables/LIST TABLES
SHOW TABLES:

--create table

CREATE TABLE course_list(
    cousre_id INT NOT NULL AUTO_INCREMENT,
    course_title VARCHAR(50) NOT NULL,
    course_author VARCHAR(40) NOT NULL,
    course_date Date,
    PRIMARY KEY(coure_id)
)

CREATE TABLE person_list(
    person_id INT NOT NULL AUTO_INCREMENT,
    person_name VARCHAR(50) NOT NULL,
    person_email VARCHAR(40) NOT NULL,
    person_profession VARCHAR(40) NOT NULL,
    person_project VARCHAR(30),
    PRIMARY KEY(person_id)


)

--drop table

DROP TABLE course_list;

--insert data into table

INSERT INFO course_list(course_title,course_author,course_date) VALUES ("Java","Suraj",NOW());

--insert multiple data into table

INSERT INFO course_list(course_title,course_author,course_date) 
VALUES ("Java","Suraj",NOW()),
VALUES ("Angular","Ravi",NOW()),
VALUES ("Python","Rohan",NOW());

--select data from table
select * from course_list;
select course_author from course_list;

--update records in the table

UPDATE course_list SET course_title "Python Basic" WHERE coure_id=3;

--Delete query

UPDATE course_list WHERE coure_id=3;

--rename table
RENAME TABLE old_table-name to new_table_name;

--RENAME TABLE course_list TO course_li;

--alter table

ALTER TABLE course_list
ADD coure_score VARCHAR(80) NOT NULL;

--decribe table
describe table_name;

--modify column type
ALTER TABLE course_list
MODIFY coure_score VARCHAR(50) NOT NULL;
--RENAME column name
ALTER TABLE course_list
CHANGE COLUMN old_column_name TO new_column_name course_number INT NOT NULL;

ALTER TABLE course_list
CHANGE COLUMN  coure_score course_number INT NOT NULL;


--delete the column
ALTER TABLE course_list
DROP COLUMN column coure_name;

--reltionships
--Foreign key 

CREATE TABLE orders(
    order_id INT NOT NULL,
    order_number INT NOT NULL
    person_id INT,
    PRIMARY KEY(order_id),
    CONSTRAINT FK_personsorders FOREIGN KEY(person_id) REFERENCES Person(person_id)
)

CREATE TABLE persons(
    person_id INT NOT NULL AUTO_INCREMENT,
    person_name VARCHAR(50) NOT NULL,
    person_email VARCHAR(40) NOT NULL,
    PRIMARY KEY(person_id)
)

--alter Fk
ALTER TABLE orders
ADD CONTRAINT FK_personsorders FOREIGN KEY(person_id) REFERENCES Person(person_id)

--drop fk
ALTER TABLE order DROP CONSTRAINT FK_personsorders;

--import existing database--inside mysql terminal

source path/mysql_file_name
 

-- Query data 
--       select
--       filter
--       sort
--       joining 
--       group
--       subquery
--       set operatiom
--       modify

-- SELECT field_name from tablename;
SELECT person_name from personS;

SELECT * from persons

--sort quries

SELECT 
    filled_name
FROM
    table_name
ORDER BY
    column1 [asc|desc],
    column2 [asc|desc];

--user customer table to practice sort

---order by lastname

SELECT
     person_name
FROM
     persons
ORDER BY
     person_name DESC;
     --person_name ASSc

SELECT
    jobTitle
FROM 
    employees
ORDER by
    jobTitle 

--orderdetails

SELECT
    orderNumber,
    orderLineNumber,
    quantityOrdered * priceEach
FROM
    orderdetails
ORDER BY 
    quantityOrdered * priceEach Desc;

    --by alias
    SELECT
    orderNumber,
    orderLineNumber,
    quantityOrdered * priceEach AS subtotals
FROM
    orderdetails
ORDER BY 
    subtotals Desc;


-- status 
--     In Progress
--     On Hold
--        Cancelled
--        Resolved
--        Disputed
--        Shipped


SELECT
    orderNumber,status
FROM
    orders
ORDER BY FIELD(status,
"In Process",
"On Hold",
"Cancelled",
"Resolved"
"Disputed",
"Shipped");


SELECT
   firstName,
   lastName,
   reportsTo
FROM
   employees
ORDER by
   reportsTo;


   --FROM ->WHERE ->SELECT ->ORDER BY

   SELECT
      firstName
      lastName
      jobTitle
   FROM
      employees
   WHERE
      jobTitle="Sales Rep"; AND  --OR
      officeCode =1;


   SELECT
      firstName
      lastName
      jobTitle
   FROM
      employees
   WHERE
      jobTitle="Sales Rep";OR
      officeCode =1;
   ORDER BY
      officeCode,
      jobTitle;

   
SELECT
      firstName
      lastName
      officeCode
   FROM
      employees
   WHERE
      officeCode BETWEEN 1 AND 3;
   ORDER BY officeCode;

--Like Clause

SELECT
    firstName,
    lastName
FROM
    employees
WHERE
    lastName LIKE '%son'  --'Thom%'  --'%att%' --"_r%"second char --"a_%"
ORDER BY
    firstName;


--IN operator
SELECT
   firstName
   lastName
   officeCode
FROM
   employees
WHERE officeCode IN (1,2,3)
ORDER BY
officeCode;