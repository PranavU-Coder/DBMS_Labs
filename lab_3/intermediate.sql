CREATE TABLE STUDENT (
    sid INT PRIMARY KEY,
    sname VARCHAR(50)
);

CREATE TABLE COURSE (
    cid INT PRIMARY KEY,
    cname VARCHAR(50)
);

CREATE TABLE ENROLL (
    sid INT,
    cid INT,
    semester VARCHAR(10),
    year INT,
    FOREIGN KEY (sid) REFERENCES STUDENT(sid),
    FOREIGN KEY (cid) REFERENCES COURSE(cid)
);

 -- MOCK DATA 
INSERT INTO STUDENT (sid, sname) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Diana'),
(5, 'Ethan');

INSERT INTO COURSE (cid, cname) VALUES
(101, 'DBMS'),
(102, 'Operating Systems'),
(103, 'Computer Networks'),
(104, 'Data Structures'),
(105, 'Machine Learning');

INSERT INTO ENROLL (sid, cid, semester, year) VALUES
(1, 101, 'SUMMER', 2022),  
(2, 102, 'SUMMER', 2022),  
(3, 103, 'SUMMER', 2022),  
(4, 101, 'SUMMER', 2022),  
(5, 104, 'SUMMER', 2022);  

INSERT INTO ENROLL (sid, cid, semester, year) VALUES
(1, 102, 'WINTER', 2022),  
(2, 103, 'WINTER', 2022), 
(3, 101, 'WINTER', 2022), 
(4, 105, 'WINTER', 2022),  
(5, 101, 'WINTER', 2022);  

SELECT cid
FROM ENROLL
WHERE semester = 'SUMMER' AND year = 2022
UNION
SELECT cid
FROM ENROLL
WHERE semester = 'WINTER' AND year = 2022;

SELECT cid
FROM ENROLL
WHERE semester = 'SUMMER' AND year = 2022
UNION ALL
SELECT cid
FROM ENROLL
WHERE semester = 'WINTER' AND year = 2022;

SELECT cid
FROM ENROLL
WHERE semester = 'SUMMER' AND year = 2022
INTERSECT
SELECT cid
FROM ENROLL
WHERE semester = 'WINTER' AND year = 2022;

SELECT cid
FROM ENROLL
WHERE semester = 'SUMMER' AND year = 2022
EXCEPT
SELECT cid
FROM ENROLL
WHERE semester = 'WINTER' AND year = 2022;

SELECT cid, cname
FROM COURSE
WHERE cid NOT IN (SELECT cid FROM ENROLL);

SELECT sname
FROM STUDENT
WHERE sid IN (SELECT sid FROM ENROLL WHERE cid = 101);

SELECT COUNT(DISTINCT sid) AS total_students
FROM ENROLL
WHERE cid = 101;

SELECT sname
FROM STUDENT s
WHERE EXISTS (SELECT 1 FROM ENROLL e WHERE e.sid = s.sid);

SELECT sname
FROM STUDENT s
WHERE NOT EXISTS (SELECT 1 FROM ENROLL e WHERE e.sid = s.sid);

SELECT sid, COUNT(cid) AS course_count
FROM ENROLL
GROUP BY sid
HAVING COUNT(cid) > 1;

SELECT cid, COUNT(sid) AS student_count
FROM ENROLL
GROUP BY cid
HAVING COUNT(sid) >= 2;

SELECT s.sid, s.sname, sub.course_count
FROM STUDENT s
JOIN (
    SELECT sid, COUNT(cid) AS course_count
    FROM ENROLL
    GROUP BY sid
) sub ON s.sid = sub.sid
WHERE sub.course_count > 1;

SELECT sid, sname
FROM STUDENT
WHERE (SELECT COUNT(cid) FROM ENROLL e WHERE e.sid = STUDENT.sid)
      > ANY (SELECT COUNT(cid) FROM ENROLL GROUP BY sid);

SELECT sid, sname
FROM STUDENT
WHERE (SELECT COUNT(cid) FROM ENROLL e WHERE e.sid = STUDENT.sid)
      > ALL (SELECT COUNT(cid) FROM ENROLL GROUP BY sid);

CREATE VIEW SummerCourses AS
SELECT DISTINCT c.cid, c.cname
FROM COURSE c
JOIN ENROLL e ON c.cid = e.cid
WHERE e.semester = 'SUMMER';

SELECT * FROM SummerCourses;
