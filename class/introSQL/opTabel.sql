CREATE TABLE Student(
    Sno CHAR(9) PRIMARY KEY,
    Sname CHAR(20) UNIQUE,
    Ssex CHAR(2),
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


-- index part

CREATE UNIQUE INDEX Stusno ON Student(Sno);
CREATE UNIQUE INDEX Coucno ON Course(Cno);
CREATE UNIQUE INDEX SCno ON SC(Sno ASC,Cno DESC); -- ASC 为 升序， DESC 为 降序。默认升序

ALTER TABLE SC RENAME INDEX SCno TO SCSno;


-- insert data

INSERT INTO Student (Sno, Sname, Ssex, Sage, Sdept, S_entrance)
VALUES
('201215121', 'LiYong', 'M', 20, 'CS', '2012-09-01'),
('201215122', 'LiuChen', 'F', 19, 'CS', '2012-09-01'),
('201215123', 'WangMin', 'F', 18, 'MA', '2013-09-01'),
('201215124', 'ZhangLi', 'M', 19, 'IS', '2013-09-01'),
('201215125', 'ChenDong', 'M', 21, 'CS', '2011-09-01'),
('201215126', 'ZhaoQian', 'F', 20, 'IS', '2012-09-01'),
('201215127', 'SunNa', 'F', 19, 'MA', '2013-09-01'),
('201215128', 'WuPeng', 'M', 22, 'EE', '2011-09-01');

INSERT INTO Course (Cno, Cname, Cpno, Ccredit)
VALUES
('1', 'Database', '5', 4),
('2', 'Math', NULL, 2),
('3', 'InfoSystem', '1', 4),
('4', 'OperatingSystem', '6', 3),
('5', 'DataStructure', '7', 4),
('6', 'DataProcessing', NULL, 2),
('7', 'Pascal', '6', 4);

INSERT INTO SC (Sno, Cno, Grade)
VALUES
('201215121', '1', 92),
('201215121', '2', 85),
('201215121', '3', 88),
('201215122', '2', 90),
('201215122', '3', 80),
('201215123', '2', 75),
('201215123', '5', 84),
('201215124', '1', 88),
('201215124', '4', 76),
('201215125', '1', 91),
('201215125', '6', 87),
('201215126', '3', 89),
('201215126', '7', 93),
('201215127', '2', 78),
('201215127', '5', 82),
('201215128', '4', 85),
('201215128', '6', 79);
