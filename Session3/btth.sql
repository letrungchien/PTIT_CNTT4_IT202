create database bttl;

use bttl;

CREATE TABLE Student(
student_id INT PRIMARY KEY,
full_name VARCHAR(50) NOT NULL,
date_of_birth DATE ,
email VARCHAR(100) NOT NULL UNIQUE
);

create table Subject(
subject_id int primary key,
subject_name varchar(50) not null ,
credit int check(credit > 0) not null
);

create table Enrollment(		
Student_id int not null ,
Subject_id int not null,
Enroll_date date ,
  primary key (student_id,subject_id),
  foreign key (student_id) references Student(student_id),
  foreign key (subject_id) references Subject(subject_id)
);
create table Score(
student_id int not null,
subject_id int not null,
mid_score  int check(mid_score>=0 and mid_score<=10),
final_score int check(final_score>=0 and final_score<=10),
  primary key (student_id,subject_id),
  foreign key (student_id) references Student(student_id),
  foreign key (subject_id) references Subject(subject_id)
);



-- thêm sinh viên 
insert into Student values
(1,'An','2003-01-11','an@gmail.com'),
(2,'Chi','2006-02-12','chi@gamil.com'),
(3,'Chiến','2006-01-18','chien@gmail.com');

-- them mon hoc
insert into Subject values 
(1,'lap trinh c',3),
(2,'java','4'),
(3,'cau truc du lieu & GT',2);

-- them dang ki mon
insert into Enrollment values 
(1,1,'2025-11-12'),
(1,2,'2025-11-12'),
(2,2,'2025-11-15'),
(2,3,'2025-12-01'),
(3,3,'2025-12-11');

-- them diem 
insert into Score values
(1,1,9,9),
(1,2,8,8),
(2,2,8,7),
(3,3,6,9);

-- cap nhap diem
update Score
set final_score =8
where student_id=2 and subject_id=2;

-- xoa sinh vien id 2
delete from Score where  student_id = 2;


delete from Student where  student_id = 2;

-- lay toan bo sinh vien 
select *from Student;