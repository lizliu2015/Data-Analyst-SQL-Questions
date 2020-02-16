WITH CTE_cnt AS (
    SELECT
        user_id
        ,transaction_date
        ,COUNT(user_id) as num_trans
    FROM transactions
    GROUP BY user_id, transaction_date
)

,CTE_cnt_new AS (
    SELECT 
        c.transaction_date
        ,v.user_id
        , CASE WHEN c.num_trans is NULL THEN 0 ELSE c.num_trans END AS num_trans_new
    FROM visits v
    LEFT JOIN CTE_cnt c ON v.user_id = c.user_id
    AND v.visit_date = c.transaction_date
)

SELECT
    num_trans_new
    ,COUNT(*) 
FROM CTE_cnt_new

GROUP BY num_trans_new
