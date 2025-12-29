use db_ss3;

create table Score(
student_id int not null,
subject_id int not null,
mid_score  int check(mid_score>=0 and mid_score<=10),
final_score int check(final_score>=0 and final_score<=10),
  primary key (student_id,subject_id),
  foreign key (student_id) references Student(student_id),
  foreign key (subject_id) references Subject(subject_id)
);

insert into Score 
values 
(1,1,9,9),(1,2,8,8),(2,2,8,7),(3,3,6,9);

update Score
set final_score =8
where student_id=2 and subject_id=2;

select * from Score;
select * from Score where final_score >=8