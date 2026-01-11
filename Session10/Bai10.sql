
use social_network_pro;
-- 2)Tạo một chỉ mục (index) trên cột username của bảng users.
create index idx_username on users(username);
-- 3)Tạo một View có tên view_user_activity_2 để thống kê tổng số bài viết (total_posts) và tổng số bạn bè (total_friends) của mỗi người dùng. Cột total_posts được tính dựa trên số lượng bản ghi trong bảng posts của mỗi người dùng. Cột total_friends được tính theo trạng thái kết bạn là accepted trong bảng friends.
create view view_user_activity_2 
as
select u.user_id,count(distinct p.post_id) as total_posts,count(distinct f.friend_id) as total_friends
from users u
left join posts p on u.user_id = p.user_id
left join friends f on u.user_id = f.user_id and f.status = 'accepted'
group by u.user_id;

-- 4) Hiển thị lại view trên. 
select *
from view_user_activity_2;
-- 5)Viết một truy vấn kết hợp view_user_activity với bảng users để hiển thị danh sách người dùng (bao gồm full_name, total_posts, total_friends), chỉ bao gồm người dùng có total_posts > 0 (số bài viết lớn hơn 0), sắp xếp theo total_posts giảm dần (từ cao đến thấp).

-- Thêm một cột friend_description vào kết quả. Cột này chứa mô tả rút gọn về số bạn bè, cụ thể:
-- Nếu total_friends > 5, hiển thị "Nhiều bạn bè".
-- Nếu total_friends từ 2 đến 5, hiển thị "Vừa đủ bạn bè".
-- Nếu total_friends < 2, hiển thị "Ít bạn bè".
-- Thêm một cột post_activity_score (điểm hoạt động bài viết) với công thức:
-- Nếu total_posts > 10, post_activity_score = total_posts * 1.1 (tăng 10%).
-- Nếu total_posts từ 5 đến 10, post_activity_score = total_posts.
-- Nếu total_posts < 5, post_activity_score = total_posts * 0.9 (giảm 10%).

select u.full_name, v.total_posts,v.total_friends,
    case
        when v.total_friends > 5 then 'Nhiều bạn bè'
        when v.total_friends between 2 and 5 then 'Vừa đủ bạn bè'
        else 'Ít bạn bè'
    end as friend_description,
    case
        when v.total_posts > 10 then v.total_posts * 1.1
        when v.total_posts between 5 and 10 then v.total_posts
        else v.total_posts * 0.9
    end as post_activity_score
from users u
join view_user_activity_2 v on u.user_id = v.user_id
where v.total_posts > 0
order by v.total_posts desc;
