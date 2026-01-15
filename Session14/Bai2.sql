use db_ss14;
alter table posts add likes_count int default 0;

create table likes(
	like_id int primary key auto_increment,
    post_id int , 
    user_id int,
    foreign key(post_id) references posts(post_id),
    foreign key(user_id) references users(user_id),
    unique key un_like(post_id , user_id)
);
delimiter ..
create procedure getData(g_post_id int , g_user_id int)
begin
	declare exit handler for sqlexception 
    begin
		rollback;
		signal sqlstate '45000' set message_text = "Bai viet nay da duoc like";
        
    end ;
    start transaction ;
    insert into likes(post_id,user_id) values(g_post_id,g_user_id);
    update posts set likes_count = likes_count + 1 where post_id = g_post_id;
    commit;
end ..
delimiter ;

call getData(1, 2);
call getData(1, 2);

