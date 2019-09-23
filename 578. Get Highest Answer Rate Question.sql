with CTE as (
select 
question_id,
sum(case when action = 'show' then 1 else 0 end) as total,
sum(case when action = 'answer' then 1 else 0 end) as ans
from survey_log
group by question_id
)

select top 1 question_id as survey_log
from CTE
order by round(cast(ans as float)/total, 2) desc;
