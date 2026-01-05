use db_ss6;

create table Product (
product_id int auto_increment primary key,
product_name varchar(225),
price decimal(10,2)
);

create table Order_items(
order_id int auto_increment primary key,
product_id int ,
quanty int ,
foreign key (product_id) references Product(product_id)
);

insert into Product (product_name,price)
values
('Laptop',22000000),
('Iphone13','24500000'),
('Quần',470000),
('Xe máy',43000000),
('Đồng hồ',2300000);

insert into Order_items (product_id ,quanty)
values
(1,4),
(2,3),
(3,4),
(4,6),
(5,6);

select p.product_id,p.product_name,p.price,o.quanty
from Product p 
 left join Order_items o
on p.product_id =o.product_id;

select p.product_id,p.product_name,sum(o.quanty*p.price) as toatl_price
from Product p 
left join Order_items o
on p.product_id = o.product_id
group by p.product_id,p.product_name;

select p.product_id,p.product_name,sum(o.quanty*p.price) as toatl_price
from Product p 
left join Order_items o
on p.product_id = o.product_id
group by p.product_id,p.product_name
having sum(o.quanty*p.price)>5000000;