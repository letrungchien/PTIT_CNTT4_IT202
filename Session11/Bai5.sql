
use social_network_pro ;

-- 2)Viết procedure tên CalculateUserActivityScore nhận IN p_user_id (INT), trả về OUT activity_score (INT). Điểm được tính: mỗi post +10 điểm, mỗi comment +5 điểm, mỗi like nhận được +3 điểm. Sử dụng CASE hoặc IF để phân loại mức hoạt động (ví dụ: >500 “Rất tích cực”, 200-500 “Tích cực”, <200 “Bình thường”) và trả thêm OUT activity_level (VARCHAR(50)).

-- Gợi ý: Dùng các SELECT COUNT riêng cho posts, comments, likes (JOIN posts và likes), tính tổng điểm, sau đó dùng CASE để xác định level.

delimiter $$
create procedure CalculateUserActivityScore( in p_user_id int ,  out activity_score int ,out  activity_level varchar(50))
begin
  declare total_post int default 0;
  declare total_comment int default 0;
  declare total_like int default 0;
  
  select count(*)
  into total_post
  from posts 
  where user_id =p_user_id ;
  
   select count(*)
  into total_comment
  from comments 
  where user_id =p_user_id ;
   select count(*)
  into total_like
  from likes 
  where user_id =p_user_id ;
  
   set activity_score = total_post*10 + total_comment*5+ total_like*3;
   
   if  activity_score > 500 then 
   set activity_level = 'Rất tích cực ';
   elseif activity_score between 200 and 500  then 
   set activity_level = 'Tích cực ';
    elseif activity_score  <= 200 then 
   set activity_level = 'Bình thường ';
   end if;
end $$
delimiter ;


-- 3) Gọi thủ tục trên select ra activity_score và activity_level

call CalculateUserActivityScore(1,@score,@level);
select @score,@level;
-- 4) Xóa thủ tục vừa khởi tạo trên

drop procedure if exists CalculateUserActivityScore;