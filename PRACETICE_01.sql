--Baitap1
select NAME from city
where Countrycode='USA' and POPULATION>120000;
--Baitap2
select * from city
where countrycode='JPN';
--Baitap3
select CITY,
STATE from STATION;
--Baitap4
SELECT DISTINCT CITY FROM STATION 
WHERE CITY LIKE 'A%' 
OR CITY LIKE 'E%' 
OR CITY LIKE 'I%' 
OR CITY LIKE 'O%' 
OR CITY LIKE 'U%';
--Baitap5
SELECT DISTINCT CITY FROM STATION 
WHERE CITY LIKE '%a' 
OR CITY LIKE '%e' 
OR CITY LIKE '%i' 
OR CITY LIKE '%o' 
OR CITY LIKE '%u';
--Baitap6
SELECT DISTINCT CITY FROM STATION 
WHERE CITY NOT LIKE 'A%' 
AND CITY NOT LIKE 'E%' 
AND CITY NOT LIKE 'I%' 
AND CITY NOT LIKE 'O%' 
AND CITY NOT LIKE 'U%';
--BAITAP7
SELECT NAME FROM EMPLOYEE
ORDER BY NAME;
--BAITAP8
SELECT NAME FROM EMPLOYEE
WHERE SALARY >2000 AND MONTHS <10
ORDER BY EMPLOYEE_ID;
--BAITAP9
SELECT PRODUCT_ID FROM PRODUCTS
WHERE LOW_FATS LIKE 'Y' 
AND RECYCLABLE LIKE 'Y';
--BAITAP10
select name from customer
where not referee_id like 2
or referee_id is null;
--Baitap11
select name, area, population from World
where area >= 3000000
or population >= 25000000;
--Baitap12
select distinct viewer_id as id from Views
where viewer_id=author_id
order by view_date;
--Baitap13
SELECT * FROM parts_assembly
where finish_date is null;
--Baitap14
select * from lyft_drivers
where yearly_salary <=30000
OR yearly_salary >=70000;
--Baitap15
select * from uber_advertising
where money_spent >100000 and year = 2019;
