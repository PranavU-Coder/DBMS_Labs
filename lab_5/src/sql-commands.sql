CREATE DATABASE IF NOT EXISTS university;
USE university;

CREATE TABLE Instructor (
    ID        INT PRIMARY KEY,
    name      VARCHAR(50),
    dept_name VARCHAR(50),
    salary    INT
);
