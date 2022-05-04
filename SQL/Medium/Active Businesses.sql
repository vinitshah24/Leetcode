"""
Question 65
Table: Events
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| business_id   | int     |
| event_type    | varchar |
| occurences    | int     |
+---------------+---------+
(business_id, event_type) is the primary key of this table.
Each row in the table logs the info that an event of some type occured at some business for a number of times.

Write an SQL query to find all active businesses.
An active business is a business that has more than one event type with occurences greater
than the average occurences of that event type among all businesses.

The query result format is in the following example:

Events table:
+-------------+------------+------------+
| business_id | event_type | occurences |
+-------------+------------+------------+
| 1           | reviews    | 7          |
| 3           | reviews    | 3          |
| 1           | ads        | 11         |
| 2           | ads        | 7          |
| 3           | ads        | 6          |
| 1           | page views | 3          |
| 2           | page views | 12         |
+-------------+------------+------------+

Result table:
+-------------+
| business_id |
+-------------+
| 1           |
+-------------+
Average for 'reviews', 'ads' and 'page views' are (7+3)/2=5, (11+7+6)/3=8, (3+12)/2=7.5 respectively.
Business with id 1 has 7 'reviews' events (more than 5) and 11 'ads' events (more than 8)
so it is an active business.
"""

USE test_db;
CREATE TABLE events (
	business_id int,
	event_type varchar(200),
	occurences int
);

INSERT INTO events
VALUES
    (1,'reviews',7),
    (3,'reviews',3),
    (1,'ads',11),
    (2,'ads',7),
    (3,'ads',6),
    (1,'pageviews',3),
    (2,'pageviews',12);

SELECT * FROM events;

-- Solution
with avg_occurences as (
    select *, avg(occurences) over (partition by event_type) as avg_occurences
    from events
)
select business_id
from avg_occurences
where occurences > avg_occurences
group by business_id
having count(event_type) > 1;

-------------------------------------------------------------------------------------------------------------
select c.business_id
from (
    select *
    from events e
    join (select event_type as event, round(avg(occurences),2) as average from events group by event_type) b
    on e.event_type = b.event
) c
where c.occurences > c.average
group by c.business_id
having count(*) > 1;

select business_id
from Events e1
right join (select event_type, avg(occurences) as avg_occurences from Events group by event_type) e2
on e1.event_type = e2.event_type
group by e1.business_id
having sum(if(e1.occurences > e2.avg_occurences, 1, 0)) > 1;


