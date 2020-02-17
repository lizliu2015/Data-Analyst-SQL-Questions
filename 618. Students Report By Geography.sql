A U.S graduate school has students from Asia, Europe and America. The students' location information are stored in table student as below.
 

| name   | continent |
|--------|-----------|
| Jack   | America   |
| Pascal | Europe    |
| Xi     | Asia      |
| Jane   | America   |
 

Pivot the continent column in this table so that each name is sorted alphabetically and displayed underneath its corresponding continent. The output headers should be America, Asia and Europe respectively. It is guaranteed that the student number from America is no less than either Asia or Europe.
 

For the sample input, the output is:
 

| America | Asia | Europe |
|---------|------|--------|
| Jack    | Xi   | Pascal |
| Jane    |      |        |
 

Follow-up: If it is unknown which continent has the most students, can you write a query to generate the student report?


WITH CTE AS(
SELECT
    name
    ,continent
    ,ROW_number() OVER(PARTITION BY continent ORDER BY name) AS num
FROM student
)

SELECT
    america.name AS 'America'
    ,asia.name AS 'Asia'
    ,europe.name AS 'Europe'
FROM(
    SELECT *
    FROM CTE
    WHERE continent = 'America'
) america
FULL JOIN(
    SELECT *
    FROM CTE
    WHERE continent = 'Asia'
) asia
    ON america.num = asia.num
FULL JOIN(
    SELECT *
    FROM CTE
    WHERE continent = 'Europe'
) europe
    ON america.num = europe.num
