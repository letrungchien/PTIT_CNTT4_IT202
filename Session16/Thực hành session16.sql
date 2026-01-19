create database th_ss16;

use th_ss16;

create table Customers(
customer_id  int auto_increment primary key,
customer_name varchar(100) not null,
phone varchar(20) not null unique,
address varchar(255) 
);

create table Products(
product_id 	int auto_increment primary key ,
product_name varchar(100) not null unique,
price decimal(10,2) not null,
quantity int not null check( quantity >0),
category varchar(50) not null 
);

create table  Employees(
employee_id int auto_increment primary key ,
employee_name varchar(100) not null ,
birthday date ,
position varchar(50) not null ,
salaruy decimal not null,
revenue decimal default 0
);

create table  Orders (
order_id int auto_increment primary key ,
customer_id int ,
employee_id int ,
order_date datetime default current_timestamp,
total_amount decimal(10,2) default 0,
foreign key (customer_id) references Customers(customer_id),
foreign key (employee_id) references Employees(employee_id)
);

create table OrderDetails(
order_detail_id int primary key auto_increment,
order_id int,
product_id int,
quantity int not null check( quantity > 0),
unit_price decimal(10,2) not null,
foreign key (order_id) references Orders(order_id),
foreign key (product_id) references Products(product_id)
);

-- 	Câu 3 - Chỉnh sửa cấu trúc bảng
-- 3.1 Thêm cột email có kiểu dữ liệu varchar(100) not null unique vào bảng
-- Customers
alter table  Customers add email varchar(100) not null unique ;

-- 3.2 Xóa cột ngày sinh ra khỏi bảng Employees
alter table Employees drop column birthday;

-- PHẦN 2: TRUY VẤN DỮ LIỆU
-- Câu 4 - Chèn dữ liệu
-- Viết câu lệnh chèn dữ liệu vào bảng (mỗi bảng ít nhất 5 bản ghi phù hợp)

insert into Customers (customer_name, phone, address, email) values
('Nguyen Van An', '0901111111', 'Ha Noi', 'an@gmail.com'),
('Tran Thi Binh', '0902222222', 'Hai Phong', 'binh@gmail.com'),
('Le Van Cuong', '0903333333', 'Da Nang', 'cuong@gmail.com'),
('Pham Thi Dao', '0904444444', 'TP HCM', 'dao@gmail.com'),
('Hoang Van Em', '0905555555', 'Can Tho', 'em@gmail.com');

insert into Products (product_name, price, quantity, category) values
('iPhone 14 Case', 150000, 100, 'Phone Case'),
('USB Type C Cable', 80000, 200, 'Cable'),
('Wireless Charger', 350000, 50, 'Charger'),
('Phone Stand', 120000, 80, 'Accessory'),
('Bluetooth Earphones', 500000, 60, 'Audio');

insert into Employees (employee_name, position, salaruy, revenue) values
('Nguyen Van Huy', 'Sales', 8000000, 0),
('Tran Thi Lan', 'Sales', 8500000, 0),
('Le Minh Tuan', 'Manager', 12000000, 0),
('Pham Quang Nam', 'Sales', 7800000, 0),
('Vo Thi Mai', 'Accountant', 9000000, 0);

insert into Orders (customer_id, employee_id, total_amount) values
(1, 1, 450000),
(2, 2, 80000),
(3, 1, 350000),
(4, 3, 620000),
(5, 4, 500000);

insert into OrderDetails (order_id, product_id, quantity, unit_price) values
(1, 1, 2, 150000),
(1, 4, 1, 120000),
(2, 2, 1, 80000),
(3, 3, 1, 350000),
(4, 5, 1, 500000);

-- Câu 5 - Truy vấn cơ bản
-- 5.1 Lấy danh sách tất cả khách hàng từ bảng Customers. Thông tin gồm : mã khách
-- hàng, tên khách hàng, email, số điện thoại và địa chỉ

select * from Customers;
-- 5.2 Sửa thông tin của sản phẩm có product_id = 1 theo yêu cầu : product_name=
-- “Laptop Dell XPS” và price = 99.99

update Products 
set product_name='Laptop Dell XPS' , price = 99.99
where product_id = 1;
-- 5.3 Lấy thông tin những đơn đặt hàng gồm : mã đơn hàng, tên khách hàng, tên nhân
-- viên, tổng tiền và ngày đặt hàng.
select * from Products ;
-- Câu 6 - Truy vấn đầy đủ
-- 6.1 Đếm số lượng đơn hàng của mỗi khách hàng. Thông tin gồm : mã khách hàng, tên
-- khách hàng, tổng số đơn
select c.customer_id,c.customer_name,count(o.order_id) as total_orders
from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

-- 6.2 Thống kê tổng doanh thu của từng nhân viên trong năm hiện tại. Thông tin gồm :
-- mã nhân viên, tên nhân viên, doanh thu
select e.employee_id,e.employee_name,sum(o.total_amount) as total_revenue
from employees e
join orders o on e.employee_id = o.employee_id
where year(o.order_date) = year(curdate())
group by e.employee_id, e.employee_name;

-- 6.3 Thống kê những sản phẩm có số lượng đặt hàng lớn hơn 100 trong tháng hiện tại.
-- Thông tin gồm : mã sản phẩm, tên sản phẩm, số lượt đặt và sắp xếp theo số lượng
-- giảm dần

select p.product_id,p.product_name,sum(od.quantity) as total_quantity
from orderdetails od
join products p on od.product_id = p.product_id
join orders o on od.order_id = o.order_id
where month(o.order_date) = month(curdate())
  and year(o.order_date) = year(curdate())
group by p.product_id, p.product_name
having sum(od.quantity) > 100
order by total_quantity desc;

-- Câu 7 - Truy vấn nâng cao
-- 7.1 Lấy danh sách khách hàng chưa từng đặt hàng. Thông tin gồm : mã khách hàng và
-- tên khách hàng
select c.customer_id,c.customer_name
from customers c
left join orders o on c.customer_id = o.customer_id
where o.order_id is null;

-- 7.2 Lấy danh sách sản phẩm có giá cao hơn giá trung bình của tất cả sản phẩm
select *
from products
where price > (select avg(price) from products);

-- 7.3 Tìm những khách hàng có mức chi tiêu cao nhất. Thông tin gồm : mã khách hàng,
-- tên khách hàng và tổng chi tiêu .(Nếu các khách hàng có cùng mức chi tiêu thì lấy hết)

select c.customer_id,c.customer_name,sum(o.total_amount) as total_spending
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having total_spending = (
    select max(total_sum) 
    from (
        select sum(total_amount) as total_sum
        from orders
        group by customer_id
    ) t
);

-- Câu 8 - Tạo view
-- 8.1 Tạo view có tên view_order_list hiển thị thông tin đơn hàng gồm : mã đơn hàng,
-- tên khách hàng, tên nhân viên, tổng tiền và ngày đặt. Các bản ghi sắp xếp theo thứ tự
-- ngày đặt mới nhất

create view view_order_list as
select o.order_id,c.customer_name,e.employee_name,o.total_amount,o.order_date
from orders o
join customers c on o.customer_id = c.customer_id
join employees e on o.employee_id = e.employee_id
order by o.order_date desc;

-- 8.2 Tạo view có tên view_order_detail_product hiển thị chi tiết đơn hàng gồm : Mã
-- chi tiết đơn hàng, tên sản phẩm, số lượng và giá tại thời điểm mua. Thông tin sắp xếp
-- theo số lượng giảm dần
create view view_order_detail_product as
select od.order_detail_id,p.product_name,od.quantity,od.unit_price
from orderdetails od
join products p on od.product_id = p.product_id
order by od.quantity desc;

-- Câu 9 - Tạo thủ tục lưu trữ
-- 9.1 Tạo thủ tục có tên proc_insert_employee nhận vào các thông tin cần thiết (trừ mã
-- nhân viên và tổng doanh thu) , thực hiện thêm mới dữ liệu vào bảng nhân viên và trả
-- về mã nhân viên vừa mới thêm.

delimiter $$
create procedure proc_insert_employee(
    in p_employee_name varchar(100),
    in p_position varchar(50),
    in p_salary decimal(10,2)
)
begin
    insert into employees(employee_name, position, salaruy)
    values (p_employee_name, p_position, p_salary);

    select last_insert_id() as new_employee_id;
end $$
delimiter ;

-- 9.2 Tạo thủ tục có tên proc_get_orderdetails lọc những chi tiết đơn hàng dựa theo
-- mã đặt hàng.
delimiter $$
create procedure proc_get_orderdetails(
    in p_order_id int
)
begin
    select *
    from orderdetails
    where order_id = p_order_id;
end $$
delimiter ;

-- 9.3 Tạo thủ tục có tên proc_cal_total_amount_by_order nhận vào tham số là mã
-- đơn hàng và trả về số lượng loại sản phẩm trong đơn hàng đó.
delimiter $$
create procedure proc_cal_total_amount_by_order(
    in p_order_id int
)
begin
    select count(distinct product_id) as total_products
    from orderdetails
    where order_id = p_order_id;
end $$
delimiter ;

-- Câu 10 - Tạo trigger
-- Tạo trigger có tên trigger_after_insert_order_details để tự động cập nhật số lượng
-- sản phẩm trong kho mỗi khi thêm một chi tiết đơn hàng mới. Nếu số lượng trong kho
-- không đủ thì ném ra thông báo lỗi “Số lượng sản phẩm trong kho không đủ” và hủy
-- thao tác chèn.
delimiter $$
create trigger trigger_after_insert_order_details
before insert on orderdetails
for each row
begin
    declare current_quantity int;

    select quantity into current_quantity
    from products
    where product_id = new.product_id;

    if current_quantity < new.quantity then
        signal sqlstate '45000'
        set message_text = 'so luong san pham trong kho khong du';
    else
        update products
        set quantity = quantity - new.quantity
        where product_id = new.product_id;
    end if;
end $$
delimiter ;

-- Câu 11 - Quản lý transaction
-- Tạo một thủ tục có tên proc_insert_order_details nhận vào tham số là mã đơn hàng,
-- mã sản phẩm, số lượng và giá sản phẩm. Sử dụng transaction thực hiện các yêu cầu
-- sau :

-- Kiểm tra nếu mã hóa đơn không tồn tại trong bảng order thì ném ra thông báo
-- lỗi “không tồn tại mã hóa đơn”.
-- Chèn dữ liệu vào bảng order_details
-- Cập nhật tổng tiền của đơn hàng ở bảng Orders
-- Nếu như có bất cứ lỗi nào sinh ra, rollback lại Transaction

delimiter $$
create procedure proc_insert_order_details(
    in p_order_id int,
    in p_product_id int,
    in p_quantity int,
    in p_unit_price decimal(10,2)
)
begin
    declare order_count int;

    start transaction;

    select count(*) into order_count
    from orders
    where order_id = p_order_id;

    if order_count = 0 then
        signal sqlstate '45000'
        set message_text = 'khong ton tai ma hoa don';
    end if;

    insert into orderdetails(order_id, product_id, quantity, unit_price)
    values (p_order_id, p_product_id, p_quantity, p_unit_price);

    update orders
    set total_amount = total_amount + (p_quantity * p_unit_price)
    where order_id = p_order_id;

    commit;
end $$
delimiter ;
