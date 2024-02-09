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
(id, date, bedrooms, bathrooms, sqft_living, sqft_lot, floors, waterfront, view, `condition`, grade, sqft_above, sqft_basement, yr_built, zipcode, lat, `long`, sqft_living15, sqft_lot15, price)
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

/* 7. Now we will try to find the unique values in some of the categorical columns:

	-	What are the unique values in the column bedrooms?
	-	What are the unique values in the column bathrooms?
	-	What are the unique values in the column floors?
	-	What are the unique values in the column condition?
	-	What are the unique values in the column grade? */
