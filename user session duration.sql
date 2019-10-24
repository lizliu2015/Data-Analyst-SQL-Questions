With CTE_Inactivity as(
SELECT 
    *
    , DATETIME_DIFF(DATETIME(lag(observed_at, 1) over (partition by machine order by observed_at)), DATETIME(observed_at), MINUTE) as inactivity_time
FROM `pristine-flames-216323.fortressiq.Senior_Data_Analyst_Data_Challenge` 
)

, CTE_session as(
SELECT
      concat(machine, '-', cast(row_number() over(partition by machine order by observed_at ) as string)) as session_id
      , machine
      , observed_at as session_start_at
      , lead(observed_at, 1) over(partition by machine order by observed_at) as next_session_start_at
    FROM CTE_Inactivity
    WHERE (CTE_Inactivity.inactivity_time < -30 OR CTE_Inactivity.inactivity_time is null)
)

, CTE_duraiton as ( 
SELECT s.machine, s.session_id
        , -DATETIME_DIFF(MIN(DATETIME(observed_at)), MAX(DATETIME(observed_at)), minute) AS duration
FROM CTE_session s
LEFT JOIN CTE_Inactivity i 
      ON s.machine = i.machine
      AND i.observed_at >= s.session_start_at
      AND (i.observed_at < s.next_session_start_at OR s.next_session_start_at is null)
GROUP BY 1,2
)

select
machine, avg(duration) as total_active_time
from CTE_duraiton
group by machine;
