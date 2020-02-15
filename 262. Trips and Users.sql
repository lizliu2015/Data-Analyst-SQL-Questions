WITH valid_user AS (
  SELECT Users_Id
  FROM Users
  WHERE Banned = 'No'
)

, valid_trips AS (
  SELECT *
  FROM Trips
  WHERE Request_at BETWEEN '2013-10-01' AND '2013-10-03'
)

SELECT
  t.Request_at AS Day
  ,ROUND(CAST(SUM(CASE WHEN status <> 'completed' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*), 2)  AS 'Cancellation Rate'
FROM valid_trips t
JOIN valid_user d ON t.Driver_Id = d.Users_Id
JOIN valid_user c ON t.Client_Id = c.Users_Id
GROUP BY t.Request_at

## Use CAST as / return integer
