
use db_ss3 ;

create table Subject(
subject_id int primary key,
subject_name varchar(50) not null ,
credit int check(credit > 0) not null
);

insert into Subject 
values 
(1,'lap trinh c',3),
(2,'java','4'),
(3,'cau truc du lieu & GT',2);

update Subject 
set credit =3
where subject_id=2;

update Subject 
set subject_name ='CSDL'
where subject_id=3;

select * from subject