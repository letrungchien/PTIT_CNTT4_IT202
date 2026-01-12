use social_network_pro ;

-- 2) Tạo stored procedure có tham số IN nhận vào p_user_id:

-- Tạo stored procedure nhận vào mã người dùng p_user_id và trả về danh sách bài viết của user đó.Thông tin trả về gồm:

-- PostID (post_id)
-- Nội dung (content)
-- Thời gian tạo (created_at)
delimiter $$
create procedure printUser( in id int )
begin
 select p.post_id , c.content, u.created_at
 from users u
 join posts p on p.user_id=u.user_id
 join comments c on c.user_id=u.user_id
 where u.user_id =id;
end $$
delimiter ;

-- 3) Gọi lại thủ tục vừa tạo với user cụ thể mà bạn muốn
call printUser(1);
-- 4) Xóa thủ tục vừa tạo.
drop procedure if exists printUser;

