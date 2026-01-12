
use social_network_pro ;

-- 2) Tính tổng like của bài viết
-- Viết stored procedure CalculatePostLikes nhận vào:

-- IN p_post_id: mã bài viết
-- OUT total_likes: tổng số lượt like nhận được trên tất cả bài viết của người dùng đó
--     Gợi ý:
-- IN: p_post_id 
-- OUT: total_likes
-- Logic: truyền vào post_id để đếm số likes post đó
delimiter $$
create procedure CalculatePostLikes(in p_post_id int ,out total_likes int)
begin
  select count(*)
  into total_likes
  from likes 
  where post_id =p_post_id ;
end $$
delimiter ;

-- 3) Thực hiện gọi stored procedure CalculatePostLikes với một post cụ thể và truy vấn giá trị của tham số OUT total_likes sau khi thủ tục thực thi.
call CalculatePostLikes(1,@total);
select @total;
-- 4) Xóa thủ tục vừa mới tạo trên
drop procedure if exists CalculatePostLikes;