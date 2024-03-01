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
TASK: 
SELECT replacement_cost, CASE 
WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'low'
WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'medium'
WHEN replacement_cost BETWEEN 25.00 AND 29.99 THEN 'high'
END quality
QUESTION:
SELECT Count(replacement_cost) from film
WHERE replacement_cost BETWEEN 9.99 AND 19.99
--Ex3
TASK:
with abc as (select fc.film_id from film_category as fc
LEFT JOIN film as f
ON fc.film_id=f.film_id
group by fc.film_id)

SELECT f.title, f.length, c.name AS category_name 
from film as f, category as c
INNER JOIN film_category as fc
ON fc.category_id=c.category_id
WHERE c.name IN ('Drama','Sports')
Order BY f.length DESC
QUESTION:
SELECT MAX(f.length), c.name from film as f, category as c
INNER JOIN film_category as fc
ON fc.category_id=c.category_id
Group by c.name
--EX4
with abc as (select fc.film_id from film_category as fc
LEFT JOIN film as f
ON fc.film_id=f.film_id
group by fc.film_id)

with cte as (SELECT COUNT(f.title), c.name as category_name 
from film as f, category as c
INNER JOIN film_category as fc
ON fc.category_id=c.category_id
Group by c.name,f.title)

select MAX(count) as max, c.name from cte, category as c
GROUP BY c.name
--Ex 5
with cte as (SELECT CONCAT(actor.first_name,' ' ,
actor.last_name) as full_name, COUNT(fa.film_id) as so_luong
from film_actor as fa
LEFT JOIN actor
ON fa.actor_id=actor.actor_id
Group by actor.first_name, 
actor.last_name, fa.film_id
ORDER BY actor.first_name, 
actor.last_name)

SELECT full_name, SUM(so_luong)
from cte
group by full_name, so_luong
ORDER BY SUM(so_luong) DESC
--Ex6

