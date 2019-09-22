#window funciton
with CTE as (
select
salary,
rank() over (order by salary) as rk
from employee
)

select
salary as secondhighestsalary
from CTE
where rk = 2;

#subquery
select max(salary) as SecondHighestSalary
from employee
where salary < (select max(salary) from employee);
