
use db_ss3;

insert into Student 
values (5,'mon','2000-09-21','mon@gmail.com');


update Student 
set email='trungchien@gmail.com'
where student_id=3;

update Student 
set  date_of_birth='2002-02-22'
where student_id=2;

delete from Student where student_id=5;
select * from Student