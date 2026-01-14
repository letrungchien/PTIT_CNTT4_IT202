use db_ss13;

create table likes (
    like_id int primary key auto_increment,
    user_id int,
    post_id int,
    liked_at datetime,
    foreign key (user_id) references users(user_id),
    foreign key (post_id) references posts(post_id)
);

delimiter $$
create trigger add_like
after insert on likes
for each row
begin
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
end$$
delimiter ;

delimiter $$
create trigger dele_like
after delete on likes
for each row
begin
    update posts
    set like_count = like_count - 1
    where post_id = old.post_id
      and like_count > 0;
end$$
delimiter ;


insert into likes (user_id, post_id, liked_at) values
(2, 1, '2025-01-10 11:00:00'),
(3, 1, '2025-01-10 13:00:00'),
(1, 3, '2025-01-11 10:00:00'),
(3, 4, '2025-01-12 16:00:00');


create view user_statistics as
select u.user_id,u.username,count(p.post_id) as post_count,sum(ifnull(p.like_count, 0)) as total_likes
from users u
left join posts p on p.user_id = u.user_id
group by u.user_id, u.username;


insert into likes (user_id, post_id, liked_at)
values (2, 4, now());

select * from user_statistics;
select * from posts where post_id = 4;


delete from likes
where user_id = 3;
