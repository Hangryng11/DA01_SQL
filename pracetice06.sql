-- Ex 1
SELECT count(distinct company_id)
AS duplicate_companies
FROM (SELECT company_id, title, description,
count(job_id) AS job_count
from job_listings
GROUP BY company_id, title, description)
AS job_count_cte
WHERE job_count >1
-- Ex 2
WITH ranked_spending_cte AS
(SELECT category, product, SUM(spend) AS total_spend,
RANK() over (PARTITION BY category
ORDER BY SUM(spend) DESC) AS ranking
From product_spend
WHERE EXTRACT (year from transaction_date)=2022
GROUP BY category, product)

SELECT category, product, total_spend
FROM ranked_spending_cte
WHERE ranking <=2
ORDER BY category, ranking;
--EX 3
SELECT COUNT(policy_holder_id) AS member_count
From (SELECT policy_holder_id, COUNT(case_id) AS call_count
FROM callers
Group by policy_holder_id
HAVING count(case_id)>=3) AS call_records
--Ex 4
SELECT DISTINCT page_id 
FROM pages
WHERE  page_id NOT IN (SELECT page_id FROM page_likes)
ORDER BY page_id;
--Ex5
SELECT 
  EXTRACT(MONTH FROM cr_month.event_date) AS mth, 
  COUNT(DISTINCT cr_month.user_id) AS monthly_active_users 
FROM user_actions AS cr_month
WHERE EXISTS (
  SELECT last_month.user_id 
  FROM user_actions AS last_month
  WHERE last_month.user_id = cr_month.user_id
AND EXTRACT(MONTH FROM last_month.event_date) =
EXTRACT(MONTH FROM cr_month.event_date - interval '1 month')
)
  AND EXTRACT(MONTH FROM cr_month.event_date) = 7
  AND EXTRACT(YEAR FROM cr_month.event_date) = 2022
GROUP BY EXTRACT(MONTH FROM cr_month.event_date);
--Ex 6
SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month, country,
COUNT(*) AS trans_count,
SUM(amount) AS trans_total_amount,
SUM(CASE WHEN state ='approved' THEN 1 ELSE 0 END) AS approved_count,
SUM(CASE WHEN state ='approved' THEN amount ELSE 0 END) AS approved_total_amount
from transactions
GROUP BY month, country
--EX 7
with etc as(select product_id, MIN(year) as first_year
from sales
group by product_id)

SELECT etc.product_id, etc.first_year, sales.quantity, sales.price
from etc
JOIN sales
on etc.product_id=sales.product_id
AND etc.first_year=sales.year
ORDER BY etc.product_id
--EX8
SELECT customer_id
from (select customer_id, p.product_key from customer
JOIN product AS p
ON customer.product_key=p.product_key
) AS cp
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) IN (SELECT DISTINCT COUNT(*) from product)
--EX9
SELECT employee_id from Employees
where salary < 30000
AND manager_id NOT IN (select employee_id from employees)
ORDER by employee_id
--EX10
SELECT count(distinct company_id)
AS duplicate_companies
FROM (SELECT company_id, title, description,
count(job_id) AS job_count
from job_listings
GROUP BY company_id, title, description)
AS job_count_cte
WHERE job_count >1
--EX11
(select u.name as results from movierating m left join users u on m.user_id = u.user_id group by m.user_id 
order by count(*) DESC,u.name ASC limit 1)
UNION ALL
(SELECT title as results
from movies as m
JOIN movierating as mr
ON m.movie_id=mr.movie_id
WHERE month(created_at)= '02' AND YEAR(created_at)='2020'
GROUP BY title
ORDER BY AVG(rating) DESC, title Limit 1)
--Ex12
WITH CTE AS(
SELECT requester_id , accepter_id
FROM RequestAccepted
UNION ALL
SELECT accepter_id , requester_id
FROM RequestAccepted
)
SELECT requester_id id, count(accepter_id) num
FROM CTE
group by 1
ORDER BY 2 DESC
LIMIT 1
