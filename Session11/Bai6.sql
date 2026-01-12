
use social_network_pro ;

-- 2)  Viết stored procedure tên NotifyFriendsOnNewPost nhận hai tham số IN:

-- p_user_id (INT) – ID của người đăng bài
-- p_content (TEXT) – Nội dung bài viết
-- Procedure sẽ thực hiện hai việc:

-- Thêm một bài viết mới vào bảng posts với user_id và content được truyền vào.
-- Tự động gửi thông báo loại 'new_post' vào bảng notifications cho tất cả bạn bè đã accepted (cả hai chiều trong bảng friends).
-- Nội dung thông báo: “[full_name của người đăng] đã đăng một bài viết mới”.
-- Không gửi thông báo cho chính người đăng bài.

delimiter $$

create procedure notifyfriendsonnewpost(
    in p_user_id int,
    in p_content text
)
begin
    declare v_post_id int;
    declare v_full_name varchar(255);

    select full_name
    into v_full_name
    from users
    where user_id = p_user_id;


    insert into posts(user_id, content, created_at)
    values (p_user_id, p_content, now());

 
    set v_post_id = last_insert_id();

  
    insert into notifications(user_id, type, content, created_at)
    select
        f.friend_id,
        'new_post',
        concat(v_full_name, ' đã đăng một bài viết mới'),
        now()
    from friends f
    where f.user_id = p_user_id
      and f.status = 'accepted'
      and f.friend_id <> p_user_id;

    insert into notifications(user_id, type, content, created_at)
    select
        f.user_id,
        'new_post',
        concat(v_full_name, ' đã đăng một bài viết mới'),
        now()
    from friends f
    where f.friend_id = p_user_id
      and f.status = 'accepted'
      and f.user_id <> p_user_id;

end $$

delimiter ;

-- 3) Gọi procedue trên và thêm bài viết mới 
call notifyfriendsonnewpost(1, 'hôm nay trời đẹp quá');

-- 4) Select ra những thông báo của bài viết vừa đăng
select *
from notifications
where type = 'new_post'
order by created_at desc;

-- 5) Xóa thủ tục vừa khởi tạo trên
drop procedure if exists notifyfriendsonnewpost;
