 create database db_ss7;
  use db_ss7;
  
  create table customers (
  id int auto_increment primary key,
  name varchar(50),
  email varchar(50)
  );
  create table 	orders(
  id int auto_increment primary key ,
  customer_id int ,
  order_date date,
  tatol_amount decimal(10,2),
  foreign key ( customer_id) references customers(id)
  );
 
 insert into customers (name,email)
values
('Chiến','chien@gmail.com'),
('Chi','chi@gmail.com'),
('Thư','thu@gmail.com'),
('Hưng','hung@gmail.com'),
('Nam','nam@gmail.com'),
('Tuấn','tuan@gmail.com'),
('Linh','linh@gmail.com');

insert into orders (customer_id,order_date,tatol_amount)
values
(1,'2026-01-05','100000'),
(2,'2026-01-06','200000'),
(3,'2026-01-03','300000'),
(4,'2026-01-04','400000'),
(5,'2026-01-05','200000'),
(6,'2026-01-06','500000'),
(1,'2026-01-05','200000'),
(1,'2026-01-04','700000');

 select *
 from customers
 where id in (select customer_id from orders  );
 -- distinct
 
 