--Ex1
SELECT 
SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views,
SUM(CASE WHEN device_type in ('tablet','phone') THEN 1 ELSE 0 END) AS mobile_views
FROM viewership
Group by laptop_views, mobile_views;
--Ex2
SELECT x,y,z,
CASE WHEN x+y>z and y+z>x and z+x>y then 'Yes'
ELSE 'No' 
END as triangle
FROM Triangle;
--EX3
with aaa as (SELECT 
sum(case when call_category is null or call_category = 'n/a' then 1        
else 0 end) as aa1,
sum(case when call_category is not null and call_category != 'n/a'    then 1 else 0 end) 
as bb1
FROM callers) 

select round(sum(aa1) / sum(aa1+bb1) * 100,1) 
as call_percentage
from aaa;
--Ex4
select name
from Customer
where coalesce(referee_id,'') <> '2';
--Ex5
select survived,
COUNT(Passengerid) FILTER(WHERE pclass=1) AS first_class,
COUNT(passengerid) FILTER(WHERE pclass=2) AS second_class,
COUNT(passengerid) FILTER(WHERE pclass=3) AS third_class
from titanic
Group by survived;
