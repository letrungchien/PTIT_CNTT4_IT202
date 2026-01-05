use db_ss6 ;


select c.customer_id, c.full_name,count(o.order_id) as total_product,sum(o.total_amount) as total_spent,
avg(o.total_amount) as avg_order_price
from Customers c
join Orders o
on c.customer_id = o.customer_id
group by c.customer_id,c.full_name
having count(o.order_id) >= 3 and sum(o.total_amount) > 10000000
order by total_spent desc;
