
create database db_ss6;

use db_ss6;

create table Customers(
customer_id int primary key,
full_name varchar(225),
city varchar(225)
);

create table  Orders(
 order_id int primary key,
 customer_id int ,
 order_date date ,
 status enum('pending','completed','cancelled'),
 foreign key (customer_id) references Customers(customer_id)
);
insert into Customers 
values 
(1,'Lê Văn A','Hà Nội'),
(2,'Nguyễn Thị B','Bắc Giang'),
(3,'Trần Văn C','Hà Nội'),
(4,'Lò Vi Sóng','Lào Cai'),
(5,'Lê Thị D','Thanh Hóa');


insert into Orders
values
(1,1,'2026-01-05','pending'),
(2,1,'2026-01-05','pending'),
(3,3,'2026-01-05','pending'),
(4,2,'2026-01-05','pending'),
(5,1,'2026-01-05','pending');

select* from Orders o
join Customers c
on o.customer_id=c.customer_id;

select c.customer_id, c.full_name,count(o.order_id) as total_order
from Customers c 
left join Orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.full_name;

select c.customer_id, c.full_name,count(o.order_id) as total_order
from Customers c 
left join Orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.full_name
having count(o.order_id)>=1;
