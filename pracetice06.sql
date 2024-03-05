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
--Ex 6
SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month, country,
COUNT(*) AS trans_count,
SUM(amount) AS trans_total_amount,
SUM(CASE WHEN state ='approved' THEN 1 ELSE 0 END) AS approved_count,
SUM(CASE WHEN state ='approved' THEN amount ELSE 0 END) AS approved_total_amount
from transactions
GROUP BY month, country
