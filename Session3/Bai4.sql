
use db_ss3;

create table Enrollment(		
Student_id int not null ,
Subject_id int not null,
Enroll_date date ,
  primary key (student_id,subject_id),
  foreign key (student_id) references Student(student_id),
  foreign key (subject_id) references Subject(subject_id)
);

insert into Enrollment
values 
(1,1,'2025-11-12'),
(1,2,'2025-11-12'),
(2,2,'2025-11-15'),
(2,3,'2025-12-01'),
(3,3,'2025-12-11');

select * from Enrollment;
select * from Enrollment where student_id=1;
