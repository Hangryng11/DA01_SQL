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
