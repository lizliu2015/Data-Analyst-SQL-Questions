#window function lag()
with three_day_log as(
SELECT
        Num
        ,LAG(Num, 1) OVER (ORDER BY Id) AS next
        ,LAG(Num, 2) OVER (ORDER BY Id) AS next_next
    FROM Logs
)

SELECT DISTINCT Num AS ConsecutiveNums
FROM three_day_log
WHERE Num = next AND next = next_next;


#self join
select
distinct l1.num as ConsecutiveNums
from logs l1, logs l2, logs l3
where l1.num = l2.num and l2.num=l3.num
and (l1.id = l2.id -1 and l2.id = l3.id -1)
