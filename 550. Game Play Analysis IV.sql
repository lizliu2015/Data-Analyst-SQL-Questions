with a1 as(
select player_id, min(event_date) as first_login
from activity
group by player_id
)

select
round(cast(count(distinct a2.player_id) as float)/count(a1.player_id),2) as fraction #MS SQl / does only integer division
from a1 
left join activity a2 
on a1.first_login = dateadd(day, -1, a2.event_date)
and a1.player_id =a2.player_id;
