
use social_network_pro;
-- Tạo một index idx_user_gender trên cột gender của bảng users.
create index idx_user_gender on users(gender);

-- 3) Tạo một View tên view_popular_posts để lưu trữ post_id, username người đăng,content(Nội dung bài viết), số like, số comment (sử dụng JOIN giữa posts, users, likes, comments; GROUP BY post_id).

create view view_popular_posts 
as
select p.post_id,u.username,p.content,count(l.post_id) as like_count,count(c.comment_id) as comment_count
from posts p
join users u on p.user_id = u.user_id
left join likes l on p.post_id = l.post_id
left join comments c on p.post_id = c.post_id
group by p.post_id, u.username, p.content;

-- 4) Truy vấn các thông tin của view view_popular_posts 
select * from view_popular_posts ;
-- 5) viết query sử dụng View này để liệt kê các bài viết có số like + comment > 10, ORDER BY tổng tương tác giảm dần.
select post_id,username,content,like_count,comment_count,(like_count + comment_count) as total_interactions
from view_popular_posts
where (like_count + comment_count) > 10
order by total_interactions desc;
