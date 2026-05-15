SHOW DATABASES;
USE OrderDB;

-- 任务1

SELECT employeeNo, employeeName, salary
FROM Employee
ORDER BY salary DESC
LIMIT 20;

-- 任务2

DELETE FROM Customer
WHERE customerName = "泰康股份有限公司";

INSERT INTO Customer
VALUES ("C20080002", "泰康股份有限公司", "010-5422685", "天津市", "220501");

SELECT *
FROM Customer
WHERE customerName = "泰康股份有限公司";

DELETE FROM Customer
WHERE customerName = "泰康股份有限公司";

-- 任务3

SELECT *
FROM Employee;

DELETE FROM Employee
WHERE salary > 5000;

SELECT *
FROM Employee;

-- 任务4

SELECT *
FROM Product;

UPDATE Product
SET productPrice = productPrice * 0.5
WHERE productPrice > 1000;

SELECT *
FROM Product;