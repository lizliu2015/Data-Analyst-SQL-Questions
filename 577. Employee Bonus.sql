select name, bonus
from employee e
left join bonus b on e.empid=b.empid
where b.bonus < 1000
or b.bonus is null; # Pay attention to null value here since it satisfies the contrains too
