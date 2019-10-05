/*
orders: order_id, user_id, product_id,dest_country, time
products: product_id, price, shipping
users: user_id, status

Quesiton:
Get the top three products based on GMV for each destination country
destination_country, product_id, rank
*/

with CTE as (
select dest_country, product_id, sum(price) as GMV
from orders o 
left join products p on o.product_id = p.product_id
group by dest_country, product_id
)

With CTE2 as (
select *,
rank() over (partition by dest_country order by GMV) as rk
from CTE
)

select 
dest_country, product_id, rk
from CTE2
where rk <= 3;
