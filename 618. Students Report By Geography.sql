/* window function */
With CTE as (
select *,
ROW_NUMBER()OVER(PARTITION BY continent ORDER BY name) AS rk
FROM student
)

SELECT rk,
MAX(CASE WHEN continent = 'America' THEN name END )AS America,
MAX(CASE WHEN continent = 'Europe' THEN name END )AS Europe,
MAX(CASE WHEN continent = 'Asia' THEN name END )AS Asia
from CTE
GROUP BY rk

/* join tables */
with CTE_America as(
select
row_number() over (order by name) as id, name
from student
where continent = 'America'
),

CTE_Europe as(
select
row_number() over (order by name) as id, name
from student
where continent = 'Europe'
),

CTE_Asia as(
select
row_number() over (order by name) as id, name
from student
where continent = 'Asia'
)

select 
amer.name as America,
asia.name as Asia,
eu.name as Europe
from CTE_america amer
full join CTE_Europe eu on amer.id =eu.id
full join CTE_asia asia on asia.id = amer.id; 


