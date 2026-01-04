use db_ss5;

select *
from product
where status = 'active'
  and price between 1000000 and 3000000
order by price asc
limit 10 offset 0;

select *
from product
where status = 'active'
  and price between 1000000 and 3000000
order by price asc
limit 10 offset 10;

