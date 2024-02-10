/* SQL questions - regression */

-- 1. Create a database called house_price_regression.
create database house_price_regression;

use house_price_regression;

-- 2. Create a table house_price_data with the same columns as given in the csv file. Please make sure you use the correct data types for the columns.
drop table if exists house_price_data;
CREATE TABLE `house_price_data` (
  `id` bigint,
  `date` date,
  `bedrooms` int,
  `bathrooms` float,
  `sqft_living` int,
  `sqft_lot` int,
  `floors` float,
  `waterfront` int,
  `view` int,
  `condition` int,
  `grade` int,
  `sqft_above` int,
  `sqft_basement` int,
  `yr_built` int,
  `zipcode` int,
  `lat` float,
  `long` float,
  `sqft_living15` int,
  `sqft_lot15` int,
  `price` int,
  `renovated` int,
  `major_city` text,
  `state` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* 3. Import the data from the csv file into the table. Before you import the data into the empty table, make sure that you have deleted the headers from the csv file. 
To not modify the original data, if you want you can create a copy of the csv file as well. 
Note you might have to use the following queries to give permission to SQL to import data from csv files in bulk:*/
SHOW VARIABLES LIKE 'local_infile'; -- This query would show you the status of the variable ‘local_infile’. If it is off, use the next command, otherwise you should be good to go

SET GLOBAL local_infile = 1;

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.2/Uploads/regression_data_cleaned - copy.csv"
INTO TABLE house_price_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(id, date, bedrooms, bathrooms, sqft_living, sqft_lot, floors, waterfront, view, `condition`, grade, sqft_above, sqft_basement, yr_built, zipcode, lat, `long`, sqft_living15, sqft_lot15, price, renovated, major_city, state)
;

-- 4. Select all the data from table house_price_data to check if the data was imported correctly
select * from house_price_data;

/* 5. Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. 
Select all the data from the table to verify if the command worked. Limit your returned results to 10. */
alter table house_price_data
drop column date;

select * from house_price_data
limit 10;

-- 6. Use sql query to find how many rows of data you have.
select count(*) as row_count
from house_price_data;

/* 7. Now we will try to find the unique values in some of the categorical columns:*/

-- What are the unique values in the column bedrooms?
select distinct bedrooms from house_price_data
order by bedrooms;

-- What are the unique values in the column bathrooms?
select distinct bathrooms from house_price_data
order by bathrooms;

-- What are the unique values in the column floors?
select distinct floors from house_price_data
order by floors;

-- What are the unique values in the column condition?
select distinct h.condition from house_price_data as h
order by h.condition;

-- What are the unique values in the column grade?
select distinct grade from house_price_data
order by grade;

/* 8.Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data. */
select * from house_price_data
order by price desc
limit 10; -- The most expensive house costs '7700000'

-- 9. What is the average price of all the properties in your data?
select avg(price) as average_price 
from house_price_data; -- average price = '541856.8463'

/* 10 In this exercise we will use simple group by to check the properties of some of the categorical variables in our data */

/* 10.1 What is the average price of the houses grouped by bedrooms? 
The returned result should have only two columns, bedrooms and Average of the prices. 
Use an alias to change the name of the second column. */
select bedrooms, round(avg(price),2) as average_price
from house_price_data
group by bedrooms
order by bedrooms; -- A house with one bedroom cost on average '321847.82' and a house with 11 bedrooms costs on average '520000'

/* 10.2 What is the average sqft_living of the houses grouped by bedrooms? 
The returned result should have only two columns, bedrooms and Average of the sqft_living. 
Use an alias to change the name of the second column. */
select bedrooms, round(avg(sqft_living),2) as average_sqft_living
from house_price_data
group by bedrooms
order by bedrooms; -- A house with one bedroom has a living room with an average of '888.58' sqft and a house with 11 bedrooms has a living room with an average of '3000' sqft

/* 10.3 What is the average price of the houses with a waterfront and without a waterfront? 
The returned result should have only two columns, waterfront and Average of the prices. 
Use an alias to change the name of the second column.*/
select waterfront, round(avg(price),2) as average_price
from house_price_data
group by waterfront
order by waterfront; -- A house with no waterfront costs on average'533263.10' and a house with waterfront costs on average '1662524.18'

/* 10.4 Is there any correlation between the columns condition and grade? 
You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. 
Visually check if there is a positive correlation or negative correlation or no correlation between the variables. */
select h.grade, 
       sum(case when h.condition = 1 then 1 else 0 end) as count_contidition1,
       sum(case when h.condition = 2 then 1 else 0 end) as count_contidition2,
       sum(case when h.condition = 3 then 1 else 0 end) as count_contidition3,
       sum(case when h.condition = 4 then 1 else 0 end) as count_contidition4,
       sum(case when h.condition = 5 then 1 else 0 end) as count_contidition5
from house_price_data h
group by h.grade
order by h.grade;

select h.condition, 
       sum(case when h.grade = 3 then 1 else 0 end) as count_grade3,
       sum(case when h.grade = 4 then 1 else 0 end) as count_grade4,
       sum(case when h.grade = 5 then 1 else 0 end) as count_grade5,
       sum(case when h.grade = 6 then 1 else 0 end) as count_grade6,
       sum(case when h.grade = 7 then 1 else 0 end) as count_grade7,
       sum(case when h.grade = 8 then 1 else 0 end) as count_grade8,
       sum(case when h.grade = 9 then 1 else 0 end) as count_grade9,
       sum(case when h.grade = 10 then 1 else 0 end) as count_grade10,
       sum(case when h.grade = 11 then 1 else 0 end) as count_grade11,
       sum(case when h.grade = 12 then 1 else 0 end) as count_grade12,
       sum(case when h.grade = 13 then 1 else 0 end) as count_grade13
from house_price_data h
group by h.condition
order by h.condition;

/* In a correlation table, when the higher values are centered or concentrated along the diagonal (from the top-left to bottom-right), 
it suggests a positive correlation between the variables. This scenario typically indicates that when one variable increases, 
the other variable also tends to increase, and when one variable decreases, the other variable also tends to decrease. 
The stronger the positive correlation, the more concentrated the higher values will be along the diagonal.

Conversely, if the lower values are centered and the higher values are pushed towards the edges of the table, 
it suggests a negative correlation, indicating that when one variable increases, the other variable tends to decrease, and vice versa.

In thise case we are facing a positive correlation: when the grade increases the the condition thends to increase and when the grade decreases the condition tends to decrease. */


/* 11. One of the customers is only interested in the following houses:
	- Number of bedrooms either 3 or 4
	- Bathrooms more than 3
	- One Floor
	- No waterfront
	- Condition should be 3 at least
	- Grade should be 5 at least
	- Price less than 300000 */
select * from house_price_data as h
where (bedrooms = 3 or bedrooms = 4) and floors = 1 and waterfront = 0 and h.condition >= 3 and grade >= 5 and price < 300000
order by price;
 
 /* 12. Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. 
 Write a query to show them the list of such properties. You might need to use a sub query for this problem.*/
 
 -- First get average of prices of all proporties
 select avg(price) as average_price 
from house_price_data;

-- Filter the proporties whose price is double of the average calculated on the previous query
select * from house_price_data
where price >= 2*(select avg(price) as average_price from house_price_data)
order by price;

/* 13. Since this is something that the senior management is regularly interested in, create a view of the same query. */
drop view twice_higher_than_average_proporties;

create view twice_higher_than_average_proporties as
select * from house_price_data
where price >= 2*(select avg(price) as average_price from house_price_data)
order by price;

select * from twice_higher_than_average_proporties;

/* 14. Most customers are interested in properties with three or four bedrooms. 
What is the difference in average prices of the properties with three and four bedrooms? */

-- First we calculate the average price for each type of property
select avg(price) as three_bedroom_avg_price from house_price_data
where bedrooms = 3; -- A three bedroom property costs in average '467795.76'

select avg(price) as four_bedroom_avg_price from house_price_data
where bedrooms = 4; -- A four bedroom property costs in average '636317.92'

select 
	(select avg(price) as four_bedroom_avg_price from house_price_data
	where bedrooms = 4)
    -
	(select avg(price) as three_bedroom_avg_price from house_price_data
	where bedrooms = 3) as avg_price_difference; 
-- The difference in average prices of the properties with three and four bedrooms is of '168522.1530'

/* 15. What are the different locations where properties are available in your database? (distinct zip codes)*/
select distinct zipcode
from house_price_data;

select count(distinct zipcode) as locations_count
from house_price_data; -- The properties are available in 70 different locations

/* 16. Show the list of all the properties that were renovated. */
select * from house_price_data
where renovated = 1;

/*17. Provide the details of the property that is the 11th most expensive property in your database. */
select * from house_price_data
order by price desc
limit 11;

select * from house_price_data
order by price desc
limit 10, 1;

/* Extra Questions*/

-- What is the average price grouped by zipcode (location)
select zipcode, round(avg(price),2) as average_price_location 
from house_price_data
group by zipcode
order by average_price_location desc;

-- For each zipcode (location) get the max and min price
select zipcode, max(price) max_price, min(price) min_price
from house_price_data
group by zipcode
order by max_price desc;

-- What are the zipcodes (locations) with the highest and lowest average of prices
with avg_price_location as
(
	select zipcode, round(avg(price),2) as average_price_location 
	from house_price_data
	group by zipcode
)
select *
from avg_price_location
where average_price_location = (select max(average_price_location) from avg_price_location) or 
		average_price_location = (select min(average_price_location) from avg_price_location)
order by average_price_location desc;


-- What are the different cities where properties are available in your database? (distinct major cites)
select distinct major_city from house_price_data;
select count(distinct major_city) major_city_count from house_price_data;

-- What is the average price grouped by major city
select major_city, round(avg(price),2) average_price_city from house_price_data
group by major_city
order by average_price_city desc;


-- For each major city get the max and min price
select major_city, max(price) max_price, min(price) min_price
from house_price_data
group by major_city
order by max_price desc;

-- What are the major cities with the highest and lowest average of prices
with avg_price_city as
(
	select major_city, round(avg(price),2) as average_price_city 
	from house_price_data
	group by major_city
)
select *
from avg_price_city
where average_price_city = (select max(average_price_city) from avg_price_city) or 
		average_price_city = (select min(average_price_city) from avg_price_city)
order by average_price_city desc;

-- What are the cheapeast and most expensive house in our database
select max(price) max_price, min(price) min_price 
from house_price_data;

select * from house_price_data
where price = (select max(price) from house_price_data) or price = (select min(price) from house_price_data);