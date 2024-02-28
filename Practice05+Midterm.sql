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
