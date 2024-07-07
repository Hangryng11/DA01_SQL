---Ex1
select 
    round(avg(order_date = customer_pref_delivery_date)*100,2) as immediate_percentage
from 
    delivery 
where 
    (customer_id, order_date) in(
        select customer_id,min(order_date)
         from delivery group by  customer_id)
--- Ex2
with a as
(
select player_id,
device_id,
First_value(event_date )OVER (Partition BY player_id order by event_date) as first_log,
Lead(event_date )OVER (Partition BY player_id order by event_date) as second_log
from Activity
)
Select round(COUNT(CASE WHEN first_log+1=second_log THEN player_id END)/count(distinct player_id),2) as fraction
from a
-- Ex3
WITH test_table AS (SELECT id, student, LAG(student,1) OVER (ORDER BY id) AS previous_student, LEAD(student,1) OVER (ORDER BY id) AS later_student FROM Seat)

SELECT id,
CASE
WHEN id%2 != 0 AND later_student IS NULL THEN student
WHEN id%2 != 0 THEN later_student
ELSE previous_student
END AS 'student'
FROM test_table;
-- Ex4
WITH TotalAmount AS (SELECT visited_on,
sum(amount) as total
FROM Customer
GROUP BY visited_on)

SELECT visited_on, amount, average_amount
FROM (SELECT visited_on,
sum(total) over(order by visited_on ASC rows between 6 preceding and current row) AS 'amount',
round(avg(total) over(order by visited_on ASC rows between 6 preceding and current row), 2) AS 'average_amount'
FROM TotalAmount) AS Temp
WHERE DATE_SUB(visited_on, INTERVAL 6 DAY) IN (SELECT visited_on FROM TotalAmount)
ORDER BY visited_on ASC
--Ex5
select round(sum(TIV_2016),2) as TIV_2016 from insurance
where TIV_2015 in
(select TIV_2015 from insurance group by TIV_2015 having count(TIV_2015) >1)
and concat(LAT, LON) not in
(select concat(LAT, LON) from insurance group by LAT, LON having count(concat(LAT, LON)) >1)
--Ex6
SELECT D.Name as Department, E.Name as Employee, E.Salary 
  FROM Department D, Employee E, Employee E2  
  WHERE D.ID = E.DepartmentId and E.DepartmentId = E2.DepartmentId and 
  E.Salary <= E2.Salary
  group by D.ID,E.Name having count(distinct E2.Salary) <= 3
  order by D.Name, E.Salary desc
--Ex7
with cte as (SELECT person_name,weight,turn,SUM(weight) over (order by turn) as total from Queue)
SELECT person_name
FROM cte
where total <= 1000
order by total DESC
LIMIT 1;
--Ex8
with cte as (
select * from (
select*,
rank() over(partition by product_id order by change_date desc) as rnk
from Products
where change_date < '2019-08-17') sq1
where rnk = 1)

select distinct p.product_id,
case when c.new_price is null then 10
else c.new_price end as price
from Products p left join cte c on P.product_id = C.product_id;
