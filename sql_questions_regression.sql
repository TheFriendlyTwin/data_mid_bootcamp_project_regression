/* SQL questions - regression */

-- 1. Create a database called house_price_regression.
create database house_price_regression;

use house_price_regression;

-- 2. Create a table house_price_data with the same columns as given in the csv file. Please make sure you use the correct data types for the columns.
drop table if exists house_price_data;
CREATE TABLE `house_price_data` (
  `id` int,
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

/*Import the data from the csv file into the table. Before you import the data into the empty table, make sure that you have deleted the headers from the csv file. 
To not modify the original data, if you want you can create a copy of the csv file as well. 
Note you might have to use the following queries to give permission to SQL to import data from csv files in bulk:*/
SHOW VARIABLES LIKE 'local_infile'; -- This query would show you the status of the variable ‘local_infile’. If it is off, use the next command, otherwise you should be good to go

SET GLOBAL local_infile = 1;


