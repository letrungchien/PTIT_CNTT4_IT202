
use db_ss7;

select *
from orders 
where tatol_amount > (select avg(tatol_amount) from orders);

