DROP DATABASE IF EXISTS meta_db;
CREATE DATABASE meta_db;
use meta_db;

CREATE TABLE salesperson(
    id INT primary key NOT NULL,
    name varchar(50),
    age INT,
    salary float
);

INSERT INTO salesperson (id, name, age, salary) VALUES (1,'Abe',61,140000);
INSERT INTO salesperson (id, name, age, salary) VALUES (2,'Bob',34,44000);
INSERT INTO salesperson (id, name, age, salary) VALUES (5,'Chris',34,40000);
INSERT INTO salesperson (id, name, age, salary) VALUES (7,'Dan',41,55000);
INSERT INTO salesperson (id, name, age, salary) VALUES (8,'Ken',57,115000);
INSERT INTO salesperson (id, name, age, salary) VALUES (11,'Joe',38,38000);

CREATE TABLE customer(
    id INT primary key NOT NULL,
    name varchar(50),
    city varchar(50),
    industry_type char
);

INSERT INTO customer (id, name, city, industry_type) VALUES (4,'Samsonic','pleasant','J');
INSERT INTO customer (id, name, city, industry_type) VALUES (6,'Panasung','oaktown','J');
INSERT INTO customer (id, name, city, industry_type) VALUES (7,'Samony','jackson','B');
INSERT INTO customer (id, name, city, industry_type) VALUES (9,'Orange','jackson','B');

CREATE TABLE orders(
    number INT primary key NOT NULL,
    order_date date,
    cust_id  INT ,
    salesperson_id INT,
    amount INT,
    foreign key(salesperson_id) REFERENCES salesperson(id),
    foreign key(cust_id) REFERENCES customer(id)
);

INSERT INTO orders (number, order_date, cust_id, salesperson_id, amount) VALUES (10,'1996-8-2',4,2,540);
INSERT INTO orders (number, order_date, cust_id, salesperson_id, amount) VALUES (20,'1999-1-30',4,8,1800);
INSERT INTO orders (number, order_date, cust_id, salesperson_id, amount) VALUES (30,'1995-7-14',9,1,460);
INSERT INTO orders (number, order_date, cust_id, salesperson_id, amount) VALUES (40,'1998-1-29',7,2,2400);
INSERT INTO orders (number, order_date, cust_id, salesperson_id, amount) VALUES (50,'1998-2-3',6,7,600);
INSERT INTO orders (number, order_date, cust_id, salesperson_id, amount) VALUES (60,'1998-3-2',6,7,720);
INSERT INTO orders (number, order_date, cust_id, salesperson_id, amount) VALUES (70,'1998-5-6',9,7,150);

SELECT * FROM salesperson;
SELECT * FROM customer;
SELECT * FROM orders;

-- a. The names of all salespeople that have an order with Samsonic.
SELECT s.name
FROM salesperson s
JOIN orders o
ON s.id = o.salesperson_id
JOIN customer c
ON c.id = o.cust_id
WHERE c.name = "Samsonic";

SElECT salesperson.name
FROM salesperson, orders
WHERE salesperson.id = orders.salesperson_id AND cust_id = '4';

-- b. The names of all salespeople that do not have any order with Samsonic.
SELECT salesperson.name
FROM salesperson
WHERE salesperson.id NOT IN (
    SELECT orders.salesperson_id
    FROM orders, customer
    WHERE orders.cust_id = customer.id AND customer.name = 'Samsonic'
);

-- c. The names of salespeople that have 2 or more orders.
SELECT name
FROM (
    SELECT s.name, count(*) as order_count
    FROM salesperson s
    JOIN orders o
    ON s.id = o.salesperson_id
    GROUP BY s.id
    HAVING order_count >= 2
) a;

SELECT name
FROM orders, salesperson
WHERE orders.salesperson_id = salesperson.id
GROUP BY name, salesperson_id
HAVING COUNT(salesperson_id) > 1;

-- d. The names and ages of all salespersons must having a salary of 100,000 or greater.
SELECT name, age
FROM salesperson
WHERE salary >= 100000;

-- e. What sales people have sold more than 1400 total units?
SELECT s.name, o.amount
FROM salesperson s
JOIN orders o
ON s.id = o.salesperson_id
WHERE o.amount > 1400;

SELECT name, sum(amount) as total_units
FROM salesperson s
JOIN orders o
ON s.id = o.salesperson_id
GROUP BY s.id
HAVING total_units > 1400;

-- f. When was the earliest and latest order made to Samony
SELECT min(o.order_date), max(o.order_date)
FROM orders o
JOIN customer c
ON o.cust_id = c.id
WHERE c.name = "Samsonic";
