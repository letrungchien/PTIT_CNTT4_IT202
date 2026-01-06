use db_ss7 ;

select c.* ,sum(tatol_amount)  as 'Total money'
from customers c 
join orders o on c.id =o.customer_id
group by c.id
having sum(tatol_amount) = (
   select sum(tatol_amount) from orders
   group by customer_id
  order by sum(tatol_amount) desc
  limit 1
);
