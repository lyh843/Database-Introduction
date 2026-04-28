CREATE SCHEMA IF NOT EXISTS ST;
USE ST;

DROP TABLE IF EXISTS SC;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;

CREATE TABLE Student(
    Sno CHAR(9) PRIMARY KEY,
    Sname CHAR(20) UNIQUE,
    Ssex CHAR(3),
    Sage SMALLINT,
    Sdept CHAR(20)
);

CREATE TABLE Course(
    Cno CHAR(4) PRIMARY KEY,
    Cname CHAR(20) NOT NULL,
    Cpno CHAR(4),
    Ccredit SMALLINT,
    FOREIGN KEY (Cpno) REFERENCES Course(Cno)
);

CREATE TABLE SC(
    Sno CHAR(9),
    Cno CHAR(4),
    Grade SMALLINT,
    PRIMARY KEY (Sno, Cno),
    FOREIGN KEY (Sno) REFERENCES Student(Sno),
    FOREIGN KEY (Cno) REFERENCES Course(Cno)
);

ALTER TABLE Student ADD S_entrance DATE;

ALTER TABLE Student MODIFY COLUMN Sage INT;

ALTER TABLE Course ADD UNIQUE(Cname);


-- 赋值

INSERT INTO Student (Sno, Sname, Ssex, Sage, Sdept)
VALUES
('201215121', '李勇', '男', 20, 'CS'),
('201215122', '刘晨', '女', 19, 'CS'),
('201215123', '王敏', '女', 18, 'MA'),
('201215125', '张立', '男', 19, 'IS');

INSERT INTO Course (Cno, Cname, Cpno, Ccredit)
VALUES
('1', '数据库', NULL, 4),
('2', '数学', NULL, 2),
('3', '信息系统', NULL, 4),
('4', '操作系统', NULL, 3),
('5', '数据结构', NULL, 4),
('6', '数据处理', NULL, 2),
('7', 'Pascal语言', NULL, 4);

UPDATE Course SET Cpno = '5' WHERE Cno = '1';
UPDATE Course SET Cpno = '1' WHERE Cno = '3';
UPDATE Course SET Cpno = '6' WHERE Cno = '4';
UPDATE Course SET Cpno = '7' WHERE Cno = '5';
UPDATE Course SET Cpno = '6' WHERE Cno = '7';

INSERT INTO SC (Sno, Cno, Grade)
VALUES
('201215121', '1', 92),
('201215121', '2', 85),
('201215121', '3', 88),
('201215122', '2', 90),
('201215122', '3', 80);