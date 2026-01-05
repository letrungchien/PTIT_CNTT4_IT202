use db_ss6;

select p.product_name ,sum(o.quanty) as quantity ,sum(o.quanty*p.price) as total_price  ,sum(o.quanty * p.price) / SUM(o.quanty) as avg_price
from Product p
join Order_items o
on p.product_id = o.product_id
group by p.product_id,p.product_name
having sum(o.quanty) >= 10
order by  total_price desc 
limit 5;