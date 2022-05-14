"""
Question 105
A U.S graduate school has students from Asia, Europe and America.
The students' location information are stored in table student as below.
| name   | continent |
|--------|-----------|
| Jack   | America   |
| Pascal | Europe    |
| Xi     | Asia      |
| Jane   | America   |

Pivot the continent column in this table so that each name is sorted alphabetically and
displayed underneath its corresponding continent.
The output headers should be America, Asia and Europe respectively.
It is guaranteed that the student number from America is no less than either Asia or Europe.

For the sample input, the output is:
| America | Asia | Europe |
|---------|------|--------|
| Jack    | Xi   | Pascal |
| Jane    |      |        |
"""

USE test_db;
Create table If Not Exists student (name varchar(50), continent varchar(7));
insert into student values
('Jane', 'America'),
('Pascal', 'Europe'),
('Xi', 'Asia'),
('Jack', 'America');
SELECT * FROM student;

-- Solution
select
    min(case when continent = 'America' then name end) as America,
    min(case when continent = 'Asia'    then name end) as Asia,
    min(case when continent = 'Europe'  then name end) as Europe
from (
    select
        *,
        row_number() over (partition by continent order by name) as rn
    from student
) a
group by rn;

-------------------------------------------------------------------------------------------------------------------

SELECT a.name AS America,
       b.name AS Asia,
       c.name AS Europe
FROM
    (SELECT ROW_NUMBER() OVER (ORDER BY name) AS ID, name FROM student) r
LEFT JOIN
    (SELECT ROW_NUMBER() OVER (ORDER BY name) AS ID, name FROM student WHERE continent = 'Asia') b
USING(ID)
LEFT JOIN
    (SELECT ROW_NUMBER() OVER (ORDER BY name) AS ID, name FROM student WHERE continent = 'America') a
USING(ID)
LEFT JOIN
    (SELECT ROW_NUMBER() OVER (ORDER BY name) AS ID, name FROM student WHERE continent = 'Europe') c
USING(ID)
WHERE NOT(a.ID IS NULL AND b.ID IS NULL AND c.ID IS NULL);

-------------------------------------------------------------------------------------------------------------------

select America, Asia, Europe
from (
    select
    name as America, row_number() over () as rn
    from student
    where continent = 'America'
    order by America
) a
left join (
    select name as Asia, row_number() over () as tn
    from student
    where continent = 'Asia'
    order by Asia
) b
on rn = tn
left join (
    select name as Europe, row_number() over () as kn
    from student
    where continent = 'Europe'
    order by Europe
) c
on rn = kn;
