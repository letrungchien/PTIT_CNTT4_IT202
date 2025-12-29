
CREATE DATABASE db_ss3;

USE db_ss3;
CREATE TABLE Student(
student_id INT PRIMARY KEY,
full_name VARCHAR(50) NOT NULL,
date_of_birth DATE ,
email VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO Student (student_id,full_name,date_of_birth,email)
VALUES 
(1,'An','2003-01-11','an@gmail.com'),
(2,'Chi','2006-02-12','chi@gamil.com'),
(3,'Chiến','2006-01-18','chien@gmail.com');

SELECT *
FROM Student;

SELECT student_id,full_name FROM Student;

