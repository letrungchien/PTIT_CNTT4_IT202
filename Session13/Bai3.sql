
use db_ss13;

delimiter $$
create trigger be_user_like_self
before insert on likes
for each row
begin
	if new.user_id = (select user_id from posts where post_id = new.post_id) then 
		signal sqlstate '45000' set message_text = "khong the like duoc bai viet cua chinh minh";
	end if;
end $$
delimiter ;

insert into likes (user_id, post_id, liked_at) values
(1, 1, '2025-01-10 11:00:00');

delimiter $$
create trigger in_like_count 
after insert on likes
for each row
begin
	update posts set like_count = like_count + 1 where post_id = new.post_id;
end $$
delimiter ;

delimiter $$
create trigger dl_like_count 
after delete on likes
for each row
begin
	update posts set like_count = like_count - 1 where post_id = old.post_id;
end $$
delimiter ;

delimiter $$
create trigger up_like_count 
after update on likes
for each row
begin
	if old.post_id <> new.post_id then 
		update posts set like_count = like_count + 1 where new.post_id = post_id;
        update posts set like_count = like_count - 1 where post_id = old.post_id;
	end if;
end $$
delimiter ;

select post_id, like_count from posts where post_id in (1,2);

insert into likes(user_id, post_id) values (3,1);

select post_id, like_count from posts where post_id in (1,2);

update likes
set post_id = 2
where user_id = 3 and post_id = 1;

select post_id, like_count from posts where post_id in (1,2);

delete from likes
where user_id = 3 and post_id = 2;

select post_id, like_count from posts where post_id in (1,2);

    

