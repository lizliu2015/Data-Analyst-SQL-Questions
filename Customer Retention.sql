 select
  activity.date, 
  count(distinct activity.user_id) as active_users, 
  count(distinct future_activity.user_id) as retained_users,
  count(distinct future_activity.user_id) / 
    count(distinct activity.user_id)::float as retention
from activity
left join activity as future_activity on
  activity.user_id = future_activity.user_id
  and activity.date = future_activity.date - interval '1 day'
group by 1
