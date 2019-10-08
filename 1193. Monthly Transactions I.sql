With CTE_all as (
    select left(trans_date, 7) as month, country, count(*) as trans_count, sum(amount) as trans_total_amount
    from transactions
    group by left(trans_date, 7), country
),

CTE_Approved as (
    select left(trans_date, 7) as month, country, count(*) as approved_count, sum(amount) as approved_total_amount
    from transactions
    where state = 'approved'
    group by left(trans_date, 7), country
)

select
coalesce(al.month, ap.month) as month, 
coalesce(al.country, ap.country) as country, 
coalesce(trans_count, 0) as trans_count,
coalesce(approved_count,0) as approved_count, 
coalesce(trans_total_amount,0) as trans_total_amount, 
coalesce(approved_total_amount,0) as approved_total_amount
from CTE_all al
left join CTE_approved ap 
on al.month = ap.month and al.country = ap.country



# case when
select
left(trans_date, 7) as month,
country,
count(*) as trans_count,
sum(case when state = 'approved' then 1 else 0 end) as approved_count,
sum(amount) as trans_total_amount,
sum(case when state= 'approved' then amount else 0 end) as approved_total_amount
from transactions
group by left(trans_date, 7), country
order by month
