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
SELECT 
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
