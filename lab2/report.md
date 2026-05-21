# 《数据库概论》实验二 高级SQL 实验报告

**姓名：** 李云浩	**学号：** 241880324   **联系方式：** 241880324@qq.com

---

## 实验环境

操作系统为 windows，采用VS code ide 以及其中的 SQL Tools 插件进行代码编写和运行。MySQL 版本是 8.0.46-winx64，高级程序语言代码部分则采用 C 语言。

## 实验过程

### T1.1

**代码部分：**

```sql
CREATE PROCEDURE info_product (IN product_name VARCHAR(40))
    SELECT Customer.customerNo, Customer.customerName, OrderDetail.orderNo, OrderDetail.quantity, (OrderDetail.price * OrderDetail.quantity)
    FROM OrderDetail
    JOIN Product ON OrderDetail.productNo = Product.productNo
    JOIN OrderMaster ON OrderMaster.orderNo = OrderDetail.orderNo
    JOIN Customer ON Customer.customerNo = OrderMaster.customerNo
    WHERE Product.productName = product_name
    ORDER BY (OrderDetail.price * OrderDetail.quantity) DESC;

CALL info_product ('32M DRAM');
```

**实验截图：**

![image-20260517213718655](t1_1.png)

---

### T1.2

**代码部分：**

```sql
CREATE PROCEDURE info_employee (IN employee_No CHAR(8))
    SELECT E2.employeeNo, E2.employeeName, E2.gender, E2.hireDate, E2.department
    FROM Employee AS E1
    JOIN Employee AS E2 ON E1.department = E2.department
    WHERE E1.employeeNo = employee_No AND E1.hireDate > E2.hireDate;

CALL info_employee ('E2008005');
```

**实验截图：**

![image-20260517213939031](t1_2.png)

---

### T2.1

**代码部分：**

```sql
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
```

**实验截图：**

![image-20260517214656150](t2_1.png)

---

### T2.2

**代码部分：**

```sql
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
```

**实验结果：**

![image-20260517214815305](t2_2.png)

---

### T3.1

**代码部分：**

```sql
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
```

**实验结果：**

![image-20260517215140914](t3_1.png)

---

### T3.2

**代码部分：**

```sql
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

SELECT employeeName, salary
FROM employee
WHERE employeeNo = 'E2005001' OR employeeNo = 'E2005005';

INSERT INTO OrderMaster
VALUES ('123', 'C20050001', 'E2005001', '20260521', 0.00, '1');
INSERT INTO OrderMaster
VALUES ('456', 'C20050002', 'E2005005', '20060520', 0.00, '2');

SELECT employeeName, salary
FROM employee
WHERE employeeNo = 'E2005001' OR employeeNo = 'E2005005';

DROP TRIGGER IF EXISTS add_salary;
```

**实验结果：**

加订单前：

![image-20260521200129013](T3_2_1.png)

加订单后：

![image-20260521200149925](T3_2_2.png)

---



## 实验中遇到的困难及解决办法

## 参考文献及致谢

