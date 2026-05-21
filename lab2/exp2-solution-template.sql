-- 姓名：李云浩
-- 学号：241880324
-- 提交前请确保本次实验独立完成，若有参考请注明并致谢。

SHOW DATABASES;
USE OrderDB;

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q1.1

DROP PROCEDURE IF EXISTS info_product;

CREATE PROCEDURE info_product (IN product_name VARCHAR(40))
    SELECT Customer.customerNo, Customer.customerName, OrderDetail.orderNo, OrderDetail.quantity, (OrderDetail.price * OrderDetail.quantity)
    FROM OrderDetail
    JOIN Product ON OrderDetail.productNo = Product.productNo
    JOIN OrderMaster ON OrderMaster.orderNo = OrderDetail.orderNo
    JOIN Customer ON Customer.customerNo = OrderMaster.customerNo
    WHERE Product.productName = product_name
    ORDER BY (OrderDetail.price * OrderDetail.quantity) DESC;

CALL info_product ('32M DRAM');

DROP PROCEDURE IF EXISTS info_product;

-- END Q1.1

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q1.2

DROP PROCEDURE IF EXISTS info_employee;

CREATE PROCEDURE info_employee (IN employee_No CHAR(8))
    SELECT E2.employeeNo, E2.employeeName, E2.gender, E2.hireDate, E2.department
    FROM Employee AS E1
    JOIN Employee AS E2 ON E1.department = E2.department
    WHERE E1.employeeNo = employee_No AND E1.hireDate > E2.hireDate;

CALL info_employee ('E2008005');

DROP PROCEDURE IF EXISTS info_employee;

-- END Q1.2

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q2.1

DROP FUNCTION IF EXISTS average_price;

CREATE FUNCTION average_price(product_name VARCHAR(40))
RETURNS FLOAT
READS SQL DATA
RETURN (
    SELECT SUM(quantity * price) / SUM(quantity)
    FROM OrderDetail
    JOIN Product ON Product.productNo = OrderDetail.productNo
    WHERE Product.productName = product_name
);

SELECT productName, average_price(productName)
FROM Product;

DROP FUNCTION IF EXISTS average_price;

-- END Q2.1

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q2.2

DROP FUNCTION IF EXISTS count_sum;

CREATE FUNCTION count_sum (product_no CHAR(9))
RETURNS INTEGER
READS SQL DATA
RETURN (
    SELECT SUM(quantity)
    FROM OrderDetail
    WHERE productNO = product_no
);

SELECT productNo, productName, count_sum(productNo)
FROM Product
WHERE count_sum(productNo) > 4;

DROP FUNCTION IF EXISTS count_sum;

-- END Q2.2

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q3.1

DROP TRIGGER IF EXISTS set_product_price;

CREATE TRIGGER set_product_price
BEFORE INSERT ON Product
FOR EACH ROW
BEGIN
    IF NEW.productPrice > 1000
        THEN SET NEW.productPrice = 1000;
    END IF;
END;

INSERT INTO Product 
VALUES ('114514', 'tempProduct', 'tempClass', 1919.81);

SELECT *
FROM Product
WHERE productName = 'tempProduct';

DELETE FROM Product
WHERE productName = 'tempProduct';

DROP TRIGGER IF EXISTS set_product_price;
-- END Q3.1

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q3.2

DROP TRIGGER IF EXISTS add_salary;

CREATE TRIGGER add_salary
AFTER INSERT ON OrderMaster
FOR EACH ROW
BEGIN
    UPDATE Employee
    SET salary = salary *
        CASE
            WHEN hireDate < '1992-01-01' THEN 1.08
            ELSE 1.05
        END
    WHERE employeeNo = NEW.employeeNo;
END;

SELECT employeeName, hireDate, salary
FROM employee
WHERE employeeNo = 'E2005001' OR employeeNo = 'E2005005';

INSERT INTO OrderMaster
VALUES ('123', 'C20050001', 'E2005001', '20260521', 0.00, '1');
INSERT INTO OrderMaster
VALUES ('456', 'C20050002', 'E2005005', '20060520', 0.00, '2');

SELECT employeeName, hireDate, salary
FROM employee
WHERE employeeNo = 'E2005001' OR employeeNo = 'E2005005';

DROP TRIGGER IF EXISTS add_salary;

-- END Q3.2
