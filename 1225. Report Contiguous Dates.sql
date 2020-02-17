Table: Failed

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| fail_date    | date    |
+--------------+---------+
Primary key for this table is fail_date.
Failed table contains the days of failed tasks.
Table: Succeeded

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| success_date | date    |
+--------------+---------+
Primary key for this table is success_date.
Succeeded table contains the days of succeeded tasks.
 

A system is running one task every day. Every task is independent of the previous tasks. The tasks can fail or succeed.

Write an SQL query to generate a report of period_state for each continuous interval of days in the period from 2019-01-01 to 2019-12-31.

period_state is 'failed' if tasks in this interval failed or 'succeeded' if tasks in this interval succeeded. Interval of days are retrieved as start_date and end_date.

Order result by start_date.

The query result format is in the following example:

Failed table:
+-------------------+
| fail_date         |
+-------------------+
| 2018-12-28        |
| 2018-12-29        |
| 2019-01-04        |
| 2019-01-05        |
+-------------------+

Succeeded table:
+-------------------+
| success_date      |
+-------------------+
| 2018-12-30        |
| 2018-12-31        |
| 2019-01-01        |
| 2019-01-02        |
| 2019-01-03        |
| 2019-01-06        |
+-------------------+


Result table:
+--------------+--------------+--------------+
| period_state | start_date   | end_date     |
+--------------+--------------+--------------+
| succeeded    | 2019-01-01   | 2019-01-03   |
| failed       | 2019-01-04   | 2019-01-05   |
| succeeded    | 2019-01-06   | 2019-01-06   |
+--------------+--------------+--------------+

The report ignored the system state in 2018 as we care about the system in the period 2019-01-01 to 2019-12-31.
From 2019-01-01 to 2019-01-03 all tasks succeeded and the system state was "succeeded".
From 2019-01-04 to 2019-01-05 all tasks failed and system state was "failed".
From 2019-01-06 to 2019-01-06 all tasks succeeded and system state was "succeeded".


In this question you need to report contiguous dates, to do that you need to think how you can use row_number(). 
You are grouping date ranges. If they are contiguous they go the same group, if they are not, it creates a new group. 
If you have row_number() for each date, and if you group by by dateadd(day, -rn, dt) 
-> what this will do is that each contiguous date will produce same value for dateadd(day, -rn, dt) 
-> it will go the same group, if it’s not Contiguous it will create a different value for it.

select
state as period_state,
min(dt) as start_date,
max(dt) as end_date
from
(select 
 success_date as dt, 'succeeded' as state, 
 row_number() over(order by success_date) as rn 
 from succeeded 
 where success_date between '2019-01-01' and '2019-12-31'
union
select fail_date as dt, 'failed' as state, 
 row_number() over(order by fail_date) as rn 
 from failed
where fail_date between '2019-01-01' and '2019-12-31') x
group by
state,
dateadd(day, -rn, dt)
order by start_date;
