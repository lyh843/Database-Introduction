SELECT Sno, Sname FROM ST.Student;

SELECT Sname, Sno, Sdept FROM ST.Student;

SELECT * FROM ST.Student;

SELECT Sname, 2026-Sage FROM ST.Student;

SELECT Sname, 'Year of Birth:', 2026-Sage, LOWER(Sdept) FROM ST.Student;

SELECT Sname, 'Year of Birth:' BIRTH, 2026-Sage BIRTHDAY,
    LOWER(Sdept) DEPARTMENT
    FROM ST.Student;

SELECT DISTINCT Sno FROM ST.SC;

SELECT Sname
FROM Student
WHERE Sdept='CS';

SELECT Sname, Sage
FROM Student
WHERE Sage<20;

SELECT DISTINCT Sno
FROM SC
WHERE Grade<60;

SELECT Sname, Sdept, Sage
FROM Student
WHERE Sage BETWEEN 20 AND 23;

SELECT Sname, Sdept, Sage
FROM Student
WHERE Sage NOT BETWEEN 20 AND 23;

SELECT Sname, Ssex
FROM Student
WHERE Sdept IN ('CS', 'MA', 'IS');

SELECT *
FROM Student
WHERE Sno LIKE '201215121';

SELECT Sname, Sno, Ssex
FROM ST.Student
WHERE Sname LIKE '刘%';

SELECT Sname
FROM ST.Student
WHERE Sname LIKE '李_';

SELECT Sname, Sno, Ssex
FROM ST.Student
WHERE Sname NOT LIKE '_勇%';

SELECT Sno, Cno
FROM SC
WHERE Grade IS NULL;

SELECT Sname
FROM Student
WHERE Sdept='CS' AND Sage<20;

SELECT Sname, Ssex
FROM Student
WHERE Sdept='CS' OR Sdept='MA' OR Sdept='IS';

-- 排序

SELECT Sno, Grade
FROM SC
WHERE Cno='3'
ORDER BY Grade DESC;

SELECT *
FROM Student
ORDER BY Sdept, Sage DESC;

-- 计数
SELECT COUNT(*)
FROM Student;

SELECT COUNT(DISTINCT Sno)
FROM SC;

SELECT AVG(Grade)
FROM ST.SC
WHERE Cno='1';

SELECT MAX(Grade)
FROM ST.SC
WHERE Cno='1';

SELECT SUM(Course.Ccredit)
FROM ST.SC, ST.Course
WHERE SC.Sno='201215122' AND SC.Cno = Course.Cno;


-- 分组

SELECT Cno, COUNT(Sno)
FROM SC
GROUP BY Cno;

-- 查询选修了3门及以上课程的学生学号
SELECT Sno
FROM ST.SC
GROUP BY Sno
HAVING COUNT(*) >= 3;

SELECT Sno, AVG(Grade)
FROM ST.SC
GROUP BY Sno
HAVING AVG(Grade) >= 90;

-- 连接查询

SELECT Student.*, SC.*
FROM ST.Student, ST.SC
WHERE Student.Sno = SC.Sno;

SELECT Student.Sno, Sname, Ssex, Sage, Sdept, Cno, Grade
FROM ST.Student, ST.SC
WHERE Student.Sno=SC.Sno;

SELECT Student.Sno, Sname
FROM ST.Student, ST.SC
WHERE Cno='2' AND Grade>90 AND Student.Sno = SC.Sno;

SELECT FIRST.Cno, SECOND.Cpno
FROM ST.Course FIRST, ST.Course SECOND
where FIRST.Cpno=SECOND.Cno;

