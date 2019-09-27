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


