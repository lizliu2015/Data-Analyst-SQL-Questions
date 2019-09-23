#self join
select w1.id
from weather w1
join weather w2
where datediff(w1.recorddate, w2.recorddate) = 1
and w1.temperature > w2.temperature;

#window lag()
with CTE as (
select
id, 
temperature as curr,
lag(temperature, 1) over(order by recorddate) as prev
from weather
)

select
id
from CTE
where curr > prev;
