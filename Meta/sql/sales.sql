-- products                                  sales
-- +------------------+---------+            +------------------+---------+
-- | product_id       | int     |            | product_id       | int     |
-- | product_class_id | int     |            | store_id         | int     |
-- | brand_name       | varchar |            | customer_id      | int     |
-- | product_name     | varchar |            | promotion_id     | int     |
-- | price            | int     |            | store_sales      | decimal |
-- +------------------+---------+            | store_cost       | decimal |
--                                           | units_sold       | decimal |
--                                           | transaction_date | date    |
--                                           +------------------+---------+

-- stores                                    customers
-- +-------------------+---------+           +---------------------+---------+
-- | store_id          | int     |           | customer_id         | int     |
-- | type              | varchar |           | first_name          | varchar |
-- | name              | varchar |           | last_name           | varchar |
-- | state             | varchar |           | state               | varchar |
-- | first_opened_date | datetime|           | birthdate           | date    |
-- | last_remodel_date | datetime|           | education           | varchar |
-- | area_sqft         | int     |           | gender              | varchar |
-- +-------------------+---------+           | date_account_opened | date    |
--                                           +---------------------+---------+

-- Question 1:
-- What brands have an average price above $3 and contain at least 2 different products?
select brandname
from products
group by brandname
having avg(price) > 3 and count(distinct productid) > 2;

-- Question 2:
-- To improve sales, the marketing department runs various types of promotions.
-- The marketing manager would like to analyze the effectiveness of these promotion campaigns.
-- In particular, what percent of our sales transactions had a valid promotion applied?

select round(sum(case when promotion_id not Null then 1 else 0 end)*100.0/count(*),2)
from sales;

-- Question 3:
-- We want to run a new promotion for our most successful category of products
-- (we call these categories “product classes”).
-- Can you find out what are the top 3 selling product classes by total sales?

-- Question 4:
-- We are considering running a promo across brands. We want to target
-- customers who have bought products from two specific brands.
-- Can you find out which customers have bought products from both the
-- “Fort West" and the "Golden" brands?
select customer_id, count(distinct brandname) from sales s inner join products p
on s.product_id = p.product_id
where p.brand_name in ("fort west", " Golden")
group by customer_id having count(distinct brandname ) = 2


select tmp.customer_id, c2.first_name, c2.last_name from
(
    select distinct customer_id
    from Sales s
    inner join product p
    on s.product_id = p.product_id
    where p.brand_name = "Fort West"
    INTERSECT
    select distinct customer_id
    from Sales s
    inner join product p
    on s.product_id = p.product_id
    where p.brand_name = "Golden"
) tmp
join customers c2
on tmp.customer_id = c2.customer_id;

SELECT first_name, last_name
FROM Customers
WHERE customer_id IN (
    SELECT s.customer_id
    FROM product p
    INNER JOIN sales s ON p.product_id = s.product_id
    WHERE p.brand_name = 'Fort West'
)
AND customer_id IN (
    SELECT s.customer_id
    FROM product p
    INNER JOIN sales s ON p.product_id = s.product_id
    WHERE p.brand_name = 'Golden'
);

select customer_id, count(distinct brand_name)
from sales s
inner join products p
on s.product_id = p.product_id
where p.brand_name in ('Golden', 'Fort West')
group by customer_id having count(distinct brand_name) = 2

