-- EX1
SELECT DISTINCT CITY FROM STATION
WHERE ID%2=0;
--Ex2
select count(city) - count(distinct city) 
from station;
--Ex4
SELECT 
Round(CAST(sum(item_count*order_occurrences)/sum(order_occurrences) 
as decimal),1) as mean
FROM items_per_order;
--Ex5
SELECT candidate_id FROM candidates
where skill in ('Python', 'Tableau', 'PostgreSQL')
group by candidate_id
having count(skill)=3;
--Ex6
SELECT user_id, DATE(max(post_date))-DATE(min(post_date)) as day_between
FROM posts
where post_date >= '2021/01/01' and post_date < '2022/01/01'
group by user_id
Having count(post_id)>=2;
--Ex7
SELECT card_name, Max(issued_amount)-MIN(issued_amount) AS Difference
FROM monthly_cards_issued
Group by card_name
order by difference DESC;
--Ex8
SELECT manufacturer, 
count(drug) as drug_count, 
abs(sum(cogs - total_sales)) as total_loss  
FROM pharmacy_sales
where total_sales<cogs
Group by manufacturer
Order by Total_loss DESC;
--Ex9
select * from cinema
where id%2=1 and description <> 'boring'
order by rating DESC;
--Ex10
select teacher_id, count(distinct subject_id) as cnt
from Teacher
group by teacher_id;
--Ex11
select user_id, count(follower_id) as followers_count
from Followers
Group by user_id
Order by user_id;
--Ex12
select class from courses
group by class
Having count(student)>=5;

