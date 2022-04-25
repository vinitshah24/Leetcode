-- Question 32
-- Write a SQL query to delete all duplicate email entries in a table named Person,
-- keeping only unique emails based on its smallest Id.

-- +----+------------------+
-- | Id | Email            |
-- +----+------------------+
-- | 1  | john@example.com |
-- | 2  | bob@example.com  |
-- | 3  | john@example.com |
-- +----+------------------+

-- Id is the primary key column for this table.
-- For example, after running your query, the above Person table should have the following rows:
-- +----+------------------+
-- | Id | Email            |
-- +----+------------------+
-- | 1  | john@example.com |
-- | 2  | bob@example.com  |
-- +----+------------------+

USE test_db;
DROP TABLE IF EXISTS person;
CREATE TABLE person (
    id INT,
    email VARCHAR(250)
);
INSERT INTO person (id, email) VALUES (1, "john@example.com"), (2, "bob@example.com"), (3, "john@example.com");
SELECT * FROM person;

-- Solution
SET SQL_SAFE_UPDATES = 0;

With t1 as
(
    Select *,
    row_number() over(partition by email order by id) as rk
    from person
)
Delete from person
where id in (Select t1.id from t1 where t1.rk>1);
