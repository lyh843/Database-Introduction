SHOW DATABASES;
USE OrderDB;

-- 任务1

SELECT employeeName, salary
FROM Employee
WHERE department = "业务科";

UPDATE Employee
SET salary = salary + 200
WHERE department = "业务科";


SELECT employeeName, salary
FROM Employee
WHERE department = "业务科";

-- 任务2

SELECT customerName, address, telephone
FROM Customer;

-- 任务3