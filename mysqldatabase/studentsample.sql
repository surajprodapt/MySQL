-- CREATE DATABASE `student_database`;
-- USE `student_database`;
-- DROP TABLE IF EXISTS `user`;
-- CREATE TABLE `user`(
--     `id` INT NOT NULL,
--     `media_id` INT NOT NULL,
--     `name` VARCHAR(45) NOT NULL,
--     PRIMARY KEY (`id`)
-- )ENGINE=InnoDB;
-- INSERT into `user`(`id`,`media_id`,`name`) VALUES (1,101,'Suraj'),
-- (2,102,'Rohan'),
-- (3,103,'Roop'),
-- (4,104,'Ravi');
-- DROP TABLE IF EXISTS `media`;
-- CREATE TABLE `media`(
--     `id` INT NOT NULL,
--     `user_id` INT NOT NULL,
--     `path` VARCHAR(70) NOT NULL,
--     `filetype` VARCHAR(20) NOT NULL,
--     `filesize` DECIMAL NOT NULL,
--     PRIMARY KEY (`id`),
--     FOREIGN KEY(`user_id`) REFERENCES `user`(`id`)
-- )ENGINE=InnoDB;
-- INSERT into `media` (`id`,`user_id`,`path`,`filetype`,`filesize`)
-- VALUES
-- (101,1,'x','doc',25.01),
-- (102,2,'y','zip',12.24);
-- DROP TABLE IF EXISTS `comment_has_media`;
-- CREATE TABLE `comment_has_media`(
--     `comment_id` INT NOT NULL,
--     `comment_bug_project_id` INT NOT NULL,
--     `comment_bug_id` INT NOT NULL,
--     `media_id` INT NOT NULL,
--     PRIMARY KEY (`comment_id`)
-- )ENGINE=InnoDB;
-- INSERT into `comment_has_media` (`comment_id`, `comment_bug_project_id`, `comment_bug_id`, `media_id` )
-- VALUES
-- (101,11,45,1),
-- (102,21,55,2);
-- DROP TABLE IF EXISTS `bug_has_media`;
-- CREATE TABLE `bug_has_media`(
--     `bug_id` INT NOT NULL,
--     `bug_project_id` INT NOT NULL,
--     `media_id` INT NOT NULL,
--     PRIMARY KEY (`bug_id`)
--     -- CONSTRAINT FK_bugmedia FOREIGN KEY(`bug_id`) REFERENCES `media`(`id`)
-- );
-- INSERT into  `bug_has_media`(`bug_id`,`bug_project_id`,`media_id` )
-- VALUES
-- (101,11,1),
-- (102,21,4);
-- DROP TABLE IF EXISTS `comment`;
-- CREATE TABLE `comment`(
--     `id` INT NOT NULL,
--     `bug_project_id` INT NOT NULL,
--     `bug_id` INT NOT NULL,
--     `text` TEXT,
--     PRIMARY KEY (`id`)
--     -- CONSTRAINT FK_comment FOREIGN KEY(`id`) REFERENCES `comment_has_media`(`media_id`)
-- );
-- INSERT into  `comment`(`id`,`bug_project_id`,`bug_id`,`text` )
-- VALUES
-- (1,11,101,'syntax'),
-- (2,21,404,'error');
-- DROP TABLE IF EXISTS `bug`;
-- CREATE TABLE `bug`(
--     `id` INT NOT NULL,
--     `project_id` INT NOT NULL,
--     `name` VARCHAR(45),
--     PRIMARY KEY (`id`)
--     -- CONSTRAINT FK_commentbug FOREIGN KEY(`id`) REFERENCES `comment`(`id`)
--     );
--     INSERT into  `bug`(`id`,`project_id`,`name` )
-- VALUES
-- (1,11,'syntax error'),
-- (2,21,'h');
-- DROP TABLE IF EXISTS `project`;
-- CREATE TABLE `project`(
--     `id` INT NOT NULL,
--     `name` VARCHAR(45),
--     PRIMARY KEY (`id`)
--     -- CONSTRAINT FK_project FOREIGN KEY(`id`) REFERENCES `comment`(`id`)
--     );
--     INSERT into  `project`(`id`,`name` )
-- VALUES
-- (1,'angular'),
-- (2,'javascript');
-- DROP TABLE IF EXISTS `project_has_user`;
-- CREATE TABLE `project_has_user`(
--     `project_id` INT NOT NULL,
--     `user_id` INT NOT NULL,
--     -- `manager_name` VARCHAR(50) NOT NULL, 
--     PRIMARY KEY (`project_id`)
--     --  CONSTRAINT FK_projectuser FOREIGN KEY(`user_id`) REFERENCES `user`(`id`)
--     );
--     INSERT into  `project_has_user`(`project_id`,`user_id` )
-- VALUES
-- (101,1);
CREATE DATABASE IF NOT EXISTS empdb;

use empdb;

CREATE TABLE merits(
    performance INT(11) NOT NULL PRIMARY KEY,
    percentage FLOAT NOT NULL
);

CREATE TABLE employees(
    emp_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(255) NOT NULL,
    performance INT(11) DEFAULT NULL,
    salary FLOAT DEFAULT NULL,
    FOREIGN KEY(performance) REFERENCES merits(performance)
);

INSERT INTO
    merits(performance, percentage)
VALUES
(1, 0),
(2, 0.01),
(3, 0.03),
(4, 0.05),
(5, 0.08);

INSERT INTO
    employees(emp_name, performance, salary)
VALUES
    ('Tinku BHati', 1, 120220),
    ('Roop BHati', 3, 90220),
    ('Rohan Bisht', 2, 56764),
    ('Suraj', 4, 63544),
    ('Yogesh', 4, 456752);

UPDATE
    employees
    INNER JOIN merits ON employees.performance = merits.performance
SET
    salary = salary + salary * percentage;

INSERT INTO
    employees(emp_name, performance, salary)
VALUES
('Jack William', NULL.43000),
    ('Jack Bond', NULL, 52000);

UPDATE
    employees
    LEFT JOIN merits ON employees.performance = merits.performance
SET
    salary = salary + salary * 0.015
WHERE
    merits.percentage IS NULL;

DROP TABLE IF EXISTS t1,
t2;

CREATE TABLE t1 (id INT PRIMARY KEY AUTO_INCREMENT);

CREATE TABLE t2(
    id VARCHAR(20) PRIMARY KEY,
    ref INT NOT NULL
);

INSERT INTO
    t1
VALUES
(1),
(2),
(3);

INSERT INTO
    t2
VALUES
('A' 1),
('B' 2),
('C' 3);

DELETE t1,
t2
FROM
    t1
    INNER JOIN t2 ON t2.ref = t1.id
WHERE
    t1.id = 1;

--sub query
SELECT
    customerNumber,
    checkNumber,
    amount
FROM
    payments
WHERE
    amount =(
        SELECT
            MAX(amount)
        FROM
            payments
    );

SELECT
    customerNumber,
    checkNumber,
    amount
FROM
    payments
WHERE
    amount >(
        SELECT
            AVG(amount)
    );

--not in
SELECT
    customerName
FROM
    customers
WHERE
    customerNumber NOT IN(
        SELECT
            DISTINCT customerNumber
        FROM
            orders
    );

SELECT
    productName,
    buyPrice
FROM
    products p1
WHERE
    buyPrice >(
        SELECT
            AVG(buyPrice)
        FROM
            products
        WHERE
            productline = p1.productline
    );

--exists
SELECT
    customerNumber,
    customerName
FROM
    customers
WHERE
    EXISTS(
        SELECT
            orderNumber,
            SUM(priceEach * quantityOrdered)
        FROM
            orderdetails
            INNER JOIN orders USING (orderNumber)
        WHERE
            customerNumber = customers.customerNumber
        GROUP BY
            orderNumber
        HAVING
            SUM(priceEach * quantityOrdered) > 60000
    );

SELECT
    customerNumber,
    customerName
FROM
    customers
WHERE
    EXISTS(
        SELECT
            orderNumber,
            SUM(priceEach * quantityOrdered)
        FROM
            orderdetails
            INNER JOIN orders USING (orderNumber)
        WHERE
            customerNumber = customers.customerNumber
        GROUP BY
            orderNumber
        HAVING
            SUM(priceEach * quantityOrdered) > 60000
    );

--indexes
CREATE INDEX inx_e ON employees(email);

EXPLAIN
SELECT
    employeeNumber,
    lastName,
    firstName
FROM
    employees
WHERE
    jobTitle = 'Sales Rep';

CREATE TABLE leads(
    lead_id INT AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    information_source VARCHAR(255),
    INDEX name(first_name, last_name),
    UNIQUE email(email),
    PRIMARY KEY(lead_id)
);

CREATE UNIQUE INDEX email ON employees(email);

ALTER TABLE
    employees
ADD
    CONSTRAINT UNIQUE KEY(email);

SELECT
    firstName,
    lastName,
    email
FROM
    employees
WHERE
    lastName = 'Patterson';

EXPLAIN
SELECT
    firstName,
    lastName,
    email
FROM
    employees
WHERE
    lastName = 'Patterson';

SELECT
    firstName,
    lastName,
    email
FROM
    employees
WHERE
    lastName = 'Patterson'
    AND firstName = 'Steve';

EXPLAIN
SELECT
    firstName,
    lastName,
    email
FROM
    employees
WHERE
    lastName = 'Patterson'
    AND firstName = 'Steve';

--CREATE Procedures:
DELIMETER $ $ CREATE Procedure GetCustomers() BEGIN
SELECT
    customerName,
    city,
    state,
    postalCode,
    country
FROM
    customers
ORDER BY
    customerName

END $ $ DELIMETER;