"""
Question 75
The Employee table holds all employees including their managers.
Every employee has an Id, and there is also a column for the manager Id.

+------+----------+-----------+----------+
|Id    |Name 	  |Department |ManagerId |
+------+----------+-----------+----------+
|101   |John 	  |A 	      |null      |
|102   |Dan 	  |A 	      |101       |
|103   |James 	  |A 	      |101       |
|104   |Amy 	  |A 	      |101       |
|105   |Anne 	  |A 	      |101       |
|106   |Ron 	  |B 	      |101       |
+------+----------+-----------+----------+
Given the Employee table, write a SQL query that finds out managers with at least 5 direct report.
For the above table, your SQL query should return:
+-------+
| Name  |
+-------+
| John  |
+-------+
Note:
No one would report to himself.
"""

-- Solution
with manager_tbl as
(
    select managerid, count(name) as total
    from employee
    group by managerid
)
select e.name
from manager_tbl
join employee e
on manager_tbl.managerid = e.id
where manager_tbl.total >= 5;
