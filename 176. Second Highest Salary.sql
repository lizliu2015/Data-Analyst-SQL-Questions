Write a SQL query to get the second highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, then the query should return null.

+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+

Goal of this exercise: 
1. get the second highest
2. deal with null value

Method 1:
SELECT
    IFNULL(
      (SELECT DISTINCT Salary
       FROM Employee
       ORDER BY Salary DESC
        LIMIT 1 OFFSET 1),
    NULL) AS SecondHighestSalary;

Method 2:
SELECT MAX(salary) as SecondHighestSalary
FROM employee
WHERE salary < (select MAX(salary) FROM employee)';


#Method 3 - window funciton
with CTE AS (
SELECT
salary,
rank() over (ORDER BY salary) AS rk
FROM employee
)

SELECT
salary AS secondhighestsalary
FROM CTE
WHERE rk = 2;
