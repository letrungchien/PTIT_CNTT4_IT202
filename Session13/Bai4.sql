use db_ss13;

create table post_history(
	history_id int primary key auto_increment,
    post_id int references posts(post_id) on delete cascade,
    old_content text ,
    new_content text ,
    changed_at datetime ,
    changed_by_user_id int
);

insert into post_history
(post_id, old_content, new_content, changed_at, changed_by_user_id)
values
(3, 'noi dung cu 1', 'noi dung moi 1', now(), 2),
(1, 'noi dung cu 2', 'noi dung moi 2', now(), 1),
(4, 'noi dung cu 3', 'noi dung moi 3', now(), 3),
(3, 'noi dung cu 4', 'noi dung moi 4', now(), 2);


delimiter ..
create trigger be_up_post_history 
before update on posts 
for each row
begin
	if new.content <> old.content then 
    insert into post_history(post_id, old_content, new_content, changed_at, changed_by_user_id) values
    (old.post_id , old.content , new.content , now() , old.user_id);
    end if;
end ..
delimiter ;


select post_id, content from posts where post_id = 1;


update posts
set content = 'noi dung moi sau khi chinh sua'
where post_id = 1;

select * from post_history where post_id = 1;

    