-- Ex1
select country.continent,floor(avg(city.population))
from city,country
where city.countrycode=country.code
group by country.continent;
-- Ex2
SELECT 
ROUND(COUNT(texts.email_id)::DECIMAL
/COUNT(DISTINCT emails.email_id),2) AS activation_rate
FROM emails
LEFT JOIN texts
  ON emails.email_id = texts.email_id
  AND texts.signup_action = 'Confirmed';
-- Ex3
SELECT age.age_bucket, 
ROUND(100.0*
SUM(activitites.time_spent) FILTER (where activitites.time_spent = 'send')/SUM(activitites.time_spent),2) AS send_perc,
ROUND(100.0*
SUM(activitites.time_spent) FILTER (where activitites.time_spent = 'open')/SUM(activitites.time_spent),2) AS open_perc
FROM activities
INNER JOIN age_breakdown AS age
ON activities.user_id=age.user_id
Where activites.activity_type IN ('open','send')
Group by age.age_bucket;
-- Ex4
With supercloud AS (SELECT customers.customer_id, count(distinct products.product_category)
AS unique_count
FROM customer_contracts AS customers
LEFT JOIN products
ON customers.product_id=products.product_id
Group by customers.customer_id)
SELECT customer_id
from supercloud
Where unique_count = (SELECT COUNT(DISTINCT product_category)
From products)
order by customer_id
--Ex6
SELECT products.product_name, SUM(orders.unit) AS unit
FROM orders
LEFT JOIN products
ON orders.product_id=products.product_id
WHERE YEAR(order_date)=2020 AND MONTH(order_date)=02
GROUP BY product_name 
HAVING unit >=100;
--Ex7
SELECT DISTINCT page_id 
FROM pages
WHERE  page_id NOT IN (SELECT page_id FROM page_likes)
ORDER BY page_id;

---MIDTERM
--EX1
SELECT DISTINCT(replacement_cost) from film
Select MIN(replacement_cost) from film
--EX2
SELECT count(replacement_cost) FILTER 
(WHERE replacement_cost BETWEEN 9.99 AND 19.99)
from film


