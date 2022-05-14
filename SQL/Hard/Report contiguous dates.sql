"""
Question 104
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

Write an SQL query to generate a report of period_state for each
continuous interval of days in the period from 2019-01-01 to 2019-12-31.
period_state is 'failed' if tasks in this interval failed or 'succeeded' if tasks in this interval succeeded.
Interval of days are retrieved as start_date and end_date.
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
"""

USE test_db;
CREATE TABLE failed (fail_date DATE);
INSERT INTO failed VALUES
("2018-12-28"),
("2018-12-29"),
("2019-01-04"),
("2019-01-05");
SELECT * FROM failed;

CREATE TABLE succeeded (success_date DATE);
INSERT INTO succeeded VALUES
("2018-12-30"),
("2018-12-31"),
("2019-01-01"),
("2019-01-02"),
("2019-01-03"),
("2019-01-06");
SELECT * FROM succeeded;

-- Solution
with t1 as (
    select
        min(success_date) as start_date,
        max(success_date) as end_date,
        state
    from (
        select
            *,
            date_sub(success_date, interval row_number() over(order by success_date) day) as diff,
            1 as state
        from succeeded
        where success_date between "2019-01-01" and "2019-12-31"
    ) a
    group by diff
),
t2 as(
    select min(fail_date) as start_date, max(fail_date) as end_date, state
    from (
        select
            *,
            date_sub(fail_date, interval row_number() over(order by fail_date) day) as diff,
            0 as state
        from failed
        where fail_date between "2019-01-01" and "2019-12-31"
    ) b
    group by diff
)
select
    case
        when c.state = 1 then "succeeded"
        else "failed"
    end as period_state,
    start_date,
    end_date
from (
    select * from t1
    union all select * from t2
) c
order by start_date;

------------------------------------------------------------------------------------------------------------------

with cte as (
    select
        fail_date as cal_date,
        'failed' as state
    from Failed
union all
    select
        success_date as cal_date,
        'succeeded' as state
    from Succeeded
)
select
    state as period_state,
    min(cal_date) as start_date,
    max(cal_date) as end_date
from (
    select
        state,
        cal_date,
        rank() over (partition by state order by cal_date) as ranking,
        rank() over (order by cal_date) as id
    from cte
    where cal_date between '2019-01-01' and '2019-12-31'
) t
group by state, (id - ranking)
order by 2;
