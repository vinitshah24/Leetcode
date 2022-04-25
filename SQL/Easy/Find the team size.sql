-- Question 47

-- Table: Employee
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | employee_id   | int     |
-- | team_id       | int     |
-- +---------------+---------+
-- employee_id is the primary key for this table.
-- Each row of this table contains the ID of each employee and their respective team.
-- Write an SQL query to find the team size of each of the employees.

-- Return result table in any order.
-- The query result format is in the following example:

-- Employee Table:
-- +-------------+------------+
-- | employee_id | team_id    |
-- +-------------+------------+
-- |     1       |     8      |
-- |     2       |     8      |
-- |     3       |     8      |
-- |     4       |     7      |
-- |     5       |     9      |
-- |     6       |     9      |
-- +-------------+------------+

-- Result table:
-- +-------------+------------+
-- | employee_id | team_size  |
-- +-------------+------------+
-- |     1       |     3      |
-- |     2       |     3      |
-- |     3       |     3      |
-- |     4       |     1      |
-- |     5       |     2      |
-- |     6       |     2      |
-- +-------------+------------+
-- Employees with Id 1,2,3 are part of a team with team_id = 8.
-- Employees with Id 4 is part of a team with team_id = 7.
-- Employees with Id 5,6 are part of a team with team_id = 9.

USE test_db;
DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
    employee_id INT,
    team_id INT
);
INSERT INTO employee (employee_id, team_id) VALUES (1,3), (2,3), (3,3), (4,1), (5,2), (6,2);
SELECT * FROM employee;

-- Solution
Select employee_id, b.team_size
from employee e
join (
Select team_id, count(team_id) as team_size
from employee
group by team_id
) b
on e.team_id = b.team_id;

select e.employee_id, (select count(team_id) from Employee where e.team_id = team_id) as team_size
from Employee e;

SELECT employee_id, COUNT(team_id) OVER (PARTITION BY team_id) team_size
FROM Employee;

select t1.employee_id, t2.team_size
from Employee as t1
inner join (select team_id, count(1) as team_size
    from Employee
    group by team_id) as t2
on t1.team_id = t2.team_id