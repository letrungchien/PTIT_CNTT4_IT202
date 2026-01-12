
use social_network_pro ;

-- 2) Viết stored procedure tên CalculateBonusPoints nhận hai tham số:

-- p_user_id (INT, IN) – ID của user
-- p_bonus_points (INT, INOUT) – Điểm thưởng ban đầu (khi gọi procedure, bạn truyền vào một giá trị điểm khởi đầu, ví dụ 100).
-- Trong procedure:
-- Đếm số lượng bài viết (posts) của user đó.
-- Nếu số bài viết ≥ 10, cộng thêm 50 điểm vào p_bonus_points.
-- Nếu số bài viết ≥ 20, cộng thêm tổng cộng 100 điểm (thay vì chỉ 50).
-- Cuối cùng, tham số p_bonus_points sẽ được sửa đổi và trả ra giá trị mới.
-- Gợi ý:
-- Sử dụng SELECT để lấy số bài viết, lưu vào biến tạm.
-- Dùng IF-ELSEIF-ELSE để kiểm tra điều kiện và cộng điểm trực tiếp vào tham số INOUT


delimiter $$
 create  procedure CalculateBonusPoints(in p_user_id int ,inout p_bonus_points int )
 begin 
declare total_posts int;
select count(*) 
into total_posts
from posts p
where p.user_id =p_user_id;

if total_posts >=   20 then
set p_bonus_points =p_bonus_points+ 100;
elseif total_posts >=   10 then
set p_bonus_points =p_bonus_points+50;
end if;
 end $$
 delimiter ;
-- 3) Gọi thủ tục trên với giá trị id user và p_bonus_points bất kì mà bạn muốn cập nhật
set @points =100;
call CalculateBonusPoints(1,@points);
-- 4) Select ra p_bonus_points 
select @points;
-- 5) Xóa thủ tục mới khởi tạo trên 
drop procedure if exists CalculateBonusPoints;