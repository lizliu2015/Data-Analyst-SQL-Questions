with cte as (
select
d.name as dep_name,
e.name as emp_name, 
e.salary,
rank() over(partition by e.departmentid order by salary desc) as rk
from employee e
right join department d on e.departmentid = d.id
)

select dep_name as department, emp_name as employee, salary
from cte
where rk = 1
order by dep_name, emp_name;
