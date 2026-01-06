use db_ss7;

select *  from customers where id in (
  select customer_id from orders 
  group by customer_id 
  having sum(tatol_amount) > (select avg(tatol_amount) from orders)
)