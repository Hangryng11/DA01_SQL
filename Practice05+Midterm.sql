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
--Ex5

