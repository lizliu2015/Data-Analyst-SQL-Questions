with CTE as(
select
d.name as department_name, e.name as employee, e.salary,
dense_rank() over(partition by d.name order by salary desc) as rk
from department d
inner join employee e on e.departmentid = d.id
)

select
department_name as department, employee, salary
from CTE
where rk <=3;
