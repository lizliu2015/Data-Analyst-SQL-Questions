#find duplicate records
SELECT email, 
 MAX(registered_at)
FROM visitor
GROUP BY email
HAVING ( COUNT(email) > 1 );

#day 1 retention
with v1 as (
  select count(user_id) as num_registered, date(registered_at) as date
  from visitor
  group by date(registered_at)
),

v2 as (
  select b.user_id, date(b.registered_at) as date
  from visit a
  left join visitor b
  on a.user_id = b.user_id
  where date(a.event_at) = date(b.registered_at) + 1
)

select v1.date, count(v2.user_id)/sum(v1.num_registered) as day_1_retention
from
v1 left join v2
on v1.date = v2.date
group by v1.date
order by v1.date