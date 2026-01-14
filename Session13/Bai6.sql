use db_ss13;
-- 1
create table friendships (
    follower_id int,
    followee_id int,
    status enum('pending','accepted') default 'accepted',
    foreign key (follower_id) references users(user_id)
        on delete cascade,
    foreign key (followee_id) references users(user_id)
        on delete cascade
);
-- 2
delimiter $$
create trigger trg_after_insert_friendships
after insert on friendships
for each row
begin
    if new.status = 'accepted' then
        update users
        set follower_count = follower_count + 1
        where user_id = new.followee_id;
    end if;
end$$

delimiter ;


delimiter $$
create trigger trg_after_delete_friendships
after delete on friendships
for each row
begin
    if old.status = 'accepted' then
        update users
        set follower_count = follower_count - 1
        where user_id = old.followee_id
          and follower_count > 0;
    end if;
end$$

delimiter ;

-- 3
delimiter $$

create procedure follow_user(
    in p_follower_id int,
    in p_followee_id int,
    in p_status enum('pending','accepted')
)
begin
    -- khong duoc tu follow
    if p_follower_id = p_followee_id then
        signal sqlstate '45000'
        set message_text = 'khong the tu follow chinh minh';
    end if;

    -- kiem tra trung follow
    if exists (
        select 1 from friendships
        where follower_id = p_follower_id
          and followee_id = p_followee_id
    ) then
        signal sqlstate '45000'
        set message_text = 'da follow nguoi nay roi';
    end if;

    -- them quan he follow
    insert into friendships(follower_id, followee_id, status)
    values (p_follower_id, p_followee_id, p_status);
end$$

delimiter ;
-- 4
create view user_profile as
select 
    u.user_id,
    u.username,
    u.follower_count,
    u.post_count,
    ifnull(sum(p.like_count), 0) as total_likes,
    group_concat(
        concat(p.post_id, ': ', left(p.content, 30))
        order by p.created_at desc
        separator ' | '
    ) as recent_posts
from users u
left join posts p on u.user_id = p.user_id
group by u.user_id, u.username, u.follower_count, u.post_count;

-- 5
call follow_user(2, 1, 'accepted'); -- bob follow alice
call follow_user(3, 1, 'accepted'); -- charlie follow alice
