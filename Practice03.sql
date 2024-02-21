--Ex1
Select name from Students
where marks > 75
Order by RIGHT(Name,3),ID;
--Ex2
select user_id, 
Concat(Upper(left(name,1)), lower(right(name,length(name)-1))) as name
from Users
Order by user_id;
--Ex3
SELECT manufacturer,
'$' || round(sum(total_sales)/1000000,0) || ' ' || 'miliiion' as sale
FROM pharmacy_sales
group by manufacturer
order by sum(total_sales) desc, manufacturer;
--Ex4
SELECT Extract('month' from submit_date) as mth, product_id,
Round(AVG(Stars),2) AS AVG_stars
FROM reviews
group by mth, product_id
order by mth, product_id;
--Ex5
SELECT sender_id, 
count(message_id) as message_count 
FROM messages
Where Extract('month'from sent_date)=8 
AND Extract('year' from sent_date)=2022
Group by sender_id
order by message_count DESC
Limit 2
--Ex6
Select tweet_id from Tweets
where length(content)>15;
--Ex7
select activity_date as day, 
count(distinct(user_id)) as active_users
from activity
Where activity_date between '2019-06-28' and '2019-07-27'
Group by activity_date;
--Ex8
select count(*) from employees
where joining_date 
between '2022-01-01' and '2022-07-31';
--Ex9
select position('a' IN first_name 
from worker
where first_name='Amitah';
--Ex10
select winery, substring(title, length(winery)+2,4)
from winemag_p2
where country='Macedonia';
