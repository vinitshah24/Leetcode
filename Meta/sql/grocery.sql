-- products
-- +-------------------+---------
-- | product_id        | INTEGER |
-- | product_class_id  | INTEGER |
-- | brand_name        | VARCHAR |
-- | product_name      | VARCHAR |
-- | is_low_fat_flg    | TINYINT |
-- | is_recyclable_flg | TINYINT |
-- | gross_weight      | DECIMAL |
-- | net_weight        | DECIMAL |
-- +------------------+----------+

-- product_classes
-- +---------------------+---------+
-- | product_class_id    | INTEGER |
-- | product_subcategory | VARCHAR |
-- | product_category    | VARCHAR |
-- | product_department  | VARCHAR |
-- | product_family      | VARCHAR |
-- +---------------------+---------+

-- sales
-- +------------------+---------+
-- | product_id       | INTEGER |
-- | store_id         | INTEGER |
-- | customer_id      | INTEGER |
-- | promotion_id     | INTEGER |
-- | store_sales      | DECIMAL |
-- | store_cost       | DECIMAL |
-- | units_sold       | DECIMAL |
-- | transaction_date | DATE    |
-- +------------------+---------+

-- promotions
-- +------------------+---------+
-- | promotion_id     | INTEGER |
-- | promotion_name   | VARCHAR |
-- | media_type       | VARCHAR |
-- | cost             | DECIMAL |
-- | start_date       | DATE    |
-- | end_date         | DATE    |
-- +------------------+---------+

-- What percent of all products in the grocery chain's catalog are both low fat and recyclable?
SELECT
COUNT(CASE WHEN is_low_fat_flg = 'Y' AND is_recyclable_flg = 'Y' THEN product_id END) * 100 / COUNT(product_id)
FROM PRODUCTS;

select round(count(
    distinct
    case
        when low_fats = 'Y' and recyclable = 'Y'
        then product_id
        else null
    end
    ) * 100 / count(distinct product_id), 2)
from Products;

-- What are the top five (ranked in decreasing order) single-channel media types that correspond to the most money
-- the grocery chain had spent on its promotional campaigns?
SELECT media_type
FROM promotions
GROUP BY media_type
ORDER BY SUM(cost) DESC
LIMIT 5;

-- media_type can contain multiple values seperated by a comma, so single channel is when media_type only has one value.
SELECT media_type as single_channel_media_type, sum(cost) as total_cost
FROM promotions
WHERE media_type not like '%,%'
GROUP BY media_type
ORDER BY SUM(cost) DESC
LIMIT 5;

-- Percent of sales that had a valid promotion, the VP of marketing wants to know what percent of transactions
-- occur on either the very first day or the very last day of a promotion campaign.
select round(sum(case when promotion_id not Null then 1 else 0 end) * 100.0 / count(*), 2)
from sales;

-- Write a query that returns product_family, units_sold, percentage of promoted.
select product_family,
    sum(units_sold),
    sum(case when s.promotion_id != 0 then 1 else 0 end) * 100.0 / count(1) as prct_promoted
from sales s
left join products p on s.product_id = p.product_id
left join product_classes pc on p.product_class_id = ps.product_class_id
join promotions prm on s.promotion_id = prm.promotion_id
group by product_family;

select
    pc.product_family,
    sum(s.units_sold),
    ROUND(sum(case when s.promotion_id 0 then 1 else 0 end)*100.0/ count(s.product_id), 2) as percent_promoted
from sales s
left join products p on s.product_id = p.product_id
left join product_classes pc on p.product_class_id = pc.product_class_id
group by pc.product_family;

-- Write a query that returns percentage of unsold product_category.
select (sum(case when (p_id=0 or s_id=0) then 1 else 0 end) * 100.0 / count(*)) as pct_product_categories_never_sold
from (
    select product_category, count(distinct (s.product_id)) as s_id, count(distinct (p.product_id)) as p_id
    FROM product_classes c
    left JOIN products p ON c.product_class_id = p.product_class_id
    left JOIN sales s ON s.product_id = p.product_id group by product_category
);

-- Find top 5 sales products having promotions
Select Sum(s.store_sales), brand_name, count(p.product_id)
from products p
inner join sales s
ON p.product_id = s.product_id
where promotion_id is not null
group by brand_name
having count(p.product_id) =1 /* single-channel media type */
order by 1 desc
limit 5;

-- % of sales that had a valid promotion, the VP of marketing wants to know what % of transactions occur on either
-- the very first day or the very last day of a promotion campaign.
select sum(case when valid_promotion = 1 then 1 else 0 end) / count(*) * 100 as percentage
from sales
where day = First_day(date) or day = last_day(date);

select
sum(case when transaction_date = (select min(transaction_date) from sales) then 1 else 0)/count(*) as first_day_sales,
sum(case when transaction_date = (select max(transaction_date) from sales) then 1 else 0)/count(*) as last_day_sales
from sales;

select
avg(transaction_date in (p.start_date,p.end_date))*100 as first_last_pct
from
sales s
join promotions p using(promotion_id);


