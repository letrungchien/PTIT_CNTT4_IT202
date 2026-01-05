use db_ss6;

insert into Orders
values 
(6,1,'2026-01-06','pending',129000),
(7,2,'2026-01-06','pending',300800),
(8,3,'2026-01-07','pending',760000),
(9,4,'2026-01-07','pending',764000),
(10,5,'2026-01-08','pending',853000);

select order_date ,sum(o.total_amount) as total_price
from Orders o
group by order_date;

select order_date ,count(o.order_id) as total_product
from Orders o
group by order_date;

select order_date ,sum(o.total_amount) as total_price
from Orders o
group by order_date
having sum(o.total_amount)>10000000;