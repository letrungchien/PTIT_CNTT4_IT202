
use social_network_pro ;

-- 2) Viết procedure tên CreatePostWithValidation nhận IN p_user_id (INT), IN p_content (TEXT). Nếu độ dài content < 5 ký tự thì không thêm bài viết và SET một biến thông báo lỗi (có thể dùng OUT result_message VARCHAR(255) để trả về thông báo “Nội dung quá ngắn” hoặc “Thêm bài viết thành công”).

delimiter $$
create procedure CreatePostWithValidation(in p_user_id int ,in p_content text ,out result_message varchar(225) )
begin

 if char_length(p_content) < 5 then 
 set result_message='Nội dung quá ngắn';
 else 
 insert into posts(user_id, content, created_at)
 values (p_user_id, p_content, now());

 set result_message='Thêm bài viết thành công';
 end if;
end $$
delimiter ;

-- 3) Gọi thủ tục và thử insert các trường hợp 
call CreatePostWithValidation(1,'hi',@mgs);
call CreatePostWithValidation(1,'hello',@mgs);


-- 4) Kiểm tra các kết quả
select @mgs ;
-- 5) Xóa thủ tục vừa khởi tạo trên
drop procedure if exists  CreatePostWithValidation;