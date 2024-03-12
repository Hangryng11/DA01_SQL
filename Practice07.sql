--EX1
WITH yearly_spend_cte AS
(SELECT EXTRACT(year from transaction_date) AS year,
product_id, spend as curr_year_spend,
LAG(spend) OVER( PARTITION BY product_id
ORDER BY product_id,
EXTRACT (Year from transaction_date)) as prev_year_spend
FROM user_transactions)
SELECT year, product_id, curr_year_spend, prev_year_spend,
ROUND(100*(curr_year_spend - prev_year_spend)/prev_year_spend,2)
AS yoy_rate
from yearly_spend_cte;
--EX2
with card_launch as
(SELECT card_name, issued_amount,
MAKE_DATE(issue_year,issue_month,1) as issue_date,
MIN(MAKE_DATE(issue_year,issue_month,1)) OVER(PARTITION BY
card_name) as launch_date
FROM monthly_cards_issued)

SELECT card_name,
issued_amount
from card_launch
WHERE issue_date = launch_date
ORDER BY issued_amount DESC;
--Ex3
with trans_num AS
(SELECT user_id, spend, transaction_date, row_number()
OVER( PARTITION BY user_id ORDER BY transaction_date) AS row_num
FROM transactions)
Select
user_id,
spend,
transaction_date
from trans_num
WHERE row_num=3;
--Ex4
with latest_trans as 
(SELECT transaction_date, user_id, product_id,
RANK() OVER (PARTITION BY user_id ORDER by transaction_date DESC)
AS transaction_rank
FROM user_transactions)

select transaction_date, user_id, count(product_id) as purchase_count
from latest_trans
where transaction_rank=1
GROUP by transaction_date, user_id
ORDER BY transaction_date;
--EX 5
SELECT user_id, tweet_date, ROUND(AVG(tweet_count)
OVER (PARTITION BY user_id ORDER BY tweet_date
ROWS between 2 preceding and current row),2) as roll_avg
FROM tweets;
--EX6
WITH payments AS (
  SELECT 
merchant_id, 
 EXTRACT(EPOCH FROM transaction_timestamp - 
LAG(transaction_timestamp) OVER(
 PARTITION BY merchant_id, credit_card_id, amount 
 ORDER BY transaction_timestamp)
)/60 AS minute_difference 
  FROM transactions) 

SELECT COUNT(merchant_id) AS payment_count
FROM payments 
WHERE minute_difference <= 10;
--EX7
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
--Ex8
with top_10 as (SELECT artist_name,
DENSE_RANK() OVER(
ORDER BY COUNT(songs.song_id)DESC) as artist_rank
FROM artists as a
JOIN songs ON a.artist_id=songs.artist_id
JOIN global_song_rank as g ON songs.song_id=g.song_id
WHERE g.rank>=10
GROUP BY a.artist_name)

SELECT artist_name, artist_rank
from top_10
where artist_rank <=5;
