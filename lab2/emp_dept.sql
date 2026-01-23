-- THIS IS POSTGRES

-- DATABASE INIT
CREATE TABLE Employee (
    EmpNo INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Gender CHAR(1) NOT NULL CHECK (Gender IN ('M', 'F')),
    Salary NUMERIC(10,2) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    DNo INT
);

CREATE TABLE Department (
    DeptNo INT PRIMARY KEY,
    DeptName VARCHAR(50) UNIQUE, 
    Location VARCHAR(50)
);

-- FOREIGN KEY
ALTER TABLE Employee
ADD CONSTRAINT fk_dept FOREIGN KEY (DNo)
REFERENCES Department(DeptNo);

-- INSERT VALID RECORDS
INSERT INTO Department VALUES (1, 'HR', 'Bangalore');
INSERT INTO Department VALUES (2, 'IT', 'Hyderabad');
INSERT INTO Department VALUES (3, 'Finance', 'Delhi');
INSERT INTO Employee VALUES (101, 'Alice', 'F', 25000, 'Bangalore', 1);
INSERT INTO Employee VALUES (102, 'Bob', 'M', 30000, 'Hyderabad', 2);
INSERT INTO Employee VALUES (103, 'Charlie', 'M', 28000, 'Delhi', 3);
SELECT * FROM Department;
SELECT * FROM Employee;

-- INSERT INVALID RECORDS
INSERT INTO Employee VALUES (104, 'David', 'X', 20000, 'Mumbai', 1);
INSERT INTO Employee (EmpNo, Gender, Salary, Address, DNo)
VALUES (105, 'M', 22000, 'Chennai', 2);
INSERT INTO Employee VALUES (106, 'Eva', 'F', 27000, 'Pune', 99);
INSERT INTO Department VALUES (4, 'HR', 'Chennai');

-- ATTEMPT TO DELETE
DELETE FROM Department WHERE DeptNo = 1;

-- CASCADE DELETE
ALTER TABLE Employee DROP CONSTRAINT fk_dept;
ALTER TABLE Employee
ADD CONSTRAINT fk_dept_cascade FOREIGN KEY (DNo)
REFERENCES Department(DeptNo)
ON DELETE CASCADE;
DELETE FROM Department WHERE DeptNo = 2;
SELECT * FROM Department;
SELECT * FROM Employee;

-- NEW CONSTRAINT & NEW RECORD
ALTER TABLE Employee
ALTER COLUMN Salary SET DEFAULT 10000;
INSERT INTO Employee (EmpNo, EmpName, Gender, Address, DNo)
VALUES (107, 'Frank', 'M', 'Kolkata', 3);
SELECT * FROM Employee WHERE EmpNo = 107;
SELECT * FROM Department;
SELECT * FROM Employee;
