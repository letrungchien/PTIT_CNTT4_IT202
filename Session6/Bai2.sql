use db_ss6;

alter table Orders
add column total_amount decimal(10,2);

update Orders
set total_amount =200000
where order_id =1;

update Orders
set total_amount =380000
where order_id =2;

update Orders
set total_amount =21010000
where order_id =3;

update Orders
set total_amount =900000
where order_id =4;

update Orders
set total_amount =12300000
where order_id =5;

select c.customer_id, c.full_name,sum(o.total_amount) as total_price
from Customers c 
left join Orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.full_name;

select c.customer_id, c.full_name,max(o.total_amount) as max_price
from Customers c 
left join Orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.full_name;

select c.customer_id, c.full_name,sum(o.total_amount) as total_price
from Customers c 
left join Orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.full_name
order by total_price desc ;
