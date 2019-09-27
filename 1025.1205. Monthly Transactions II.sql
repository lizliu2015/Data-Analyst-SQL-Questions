With CTE1 as (
select t.country, left(c.trans_date,7) as mon,
count(trans_id) as chargeback_count,
sum(amount) as chargeback_amount
from transactions t
right join chargebacks c on t.id =c.trans_id
group by country, left(c.trans_date,7)
),

CTE2 as (
select country, left(t.trans_date,7) as mon,
count(id) as approved_count,
sum(amount) as approved_amount
from transactions t
where state = 'approved'
group by country, left(t.trans_date,7)
)

select 
coalesce(CTE2.mon, CTE1.mon) as month, 
coalesce(CTE2.country, CTE1.country) as country, 
coalesce(approved_count,0) as approved_count, 
coalesce(approved_amount,0) as approved_amount,
coalesce(chargeback_count,0) as chargeback_count,
coalesce(chargeback_amount,0) as chargeback_amount
from CTE1
full join CTE2 
on CTE1.country = CTE2.country and CTE1.mon = CTE2.mon;
