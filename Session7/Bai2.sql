
use db_ss7;

create table products (
id int auto_increment primary key,
name varchar(50) ,
price decimal(10,2)
);

create table order_items(
order_id int auto_increment primary key,
product_id int ,
quantity int ,
foreign key (product_id) references products(id)
);

insert into products (name, price)
 values
('Bút bi', 5000),
('Vở 100 trang', 12000),
('Thước kẻ', 7000),
('Tẩy', 3000),
('Balo', 150000);

insert into order_items (product_id, quantity)
 values
(1, 10),
(2, 5),
(3, 3),
(4, 20);

select*
 from products
 where id in (select product_id from order_items )
 
