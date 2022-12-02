-- 1Use sakila database. open 1st sakila schemas, open then 2nd sakila database.

-- 2Get all the data from tables actor, film and customer.
-- 3Get film titles.
-- 4Get unique list of film languages under the alias language. Note that we are not asking you to -- -- -- obtain the language per each film, but this is a good time to think about how you might get that -- --- - information in the future.
-- 5.1 Find out how many stores does the company have?
-- 5.2 Find out how many employees staff does the company have?
-- 5.3 Return a list of employee first names only?

-- 2Get all the data from tables actor, film and customer.
USE sakilla;
-- 2Get all the data from tables actor.
SELECT * FROM actor;
-- 2Get all the data from table film.
SELECT title FROM film;
-- 2Get all the data from tables customer.
SELECT * FROM customer;
-- 3Get film titles.
SELECT title FROM film;
SELECT * 
FROM language;

-- 4Get unique list of film languages under the alias language. Note that we are not asking you to 
-- obtain the language per each film, but this is a good time to think about how you might get that 
-- information in the future.
-- SELECT * FROM language;actor
SELECT name AS language FROM language; 
-- 5.1 Find out how many stores does the company have? 2 stores
SELECT * FROM store;
-- 5.2 Find out how many employees staff does the company have? - 2
SELECT * FROM staff;
-- 5.3 Return a list of employee first names only? Mike, Jon
SELECT first_name FROM staff;

-- LAB 1 MYSQL
# 1 Select all the actors with the first name ‘Scarlett’.
# 2 How many films (movies) are available for rent and how many films have been rented?
# 3 What are the shortest and longest movie duration? Name the values max_duration and 3min_duration.
# 4 What's the average movie duration expressed in format (hours, minutes)?
# 5 How many distinct (different) actors' last names are there?
# 6 Since how many days has the company been operating (check DATEDIFF() function)?
# 7 Show rental info with additional columns month and weekday. Get 20 results.
# 8 Add an additional column day_type with values 'weekend' and 'workday' depending on the rental # 8 day of the week.
# 9 Get release years.
# 10 Get all films with ARMAGEDDON in the title.
# 11 Get all films which title ends with APOLLO.
# 12 Get 10 the longest films.
# 13 How many films include Behind the Scenes content?

-- 1 Select all the actors with the first name ‘Scarlett’.1 
SELECT first_name, last_name FROM actor WHERE first_name = 'Scarlett';

-- 2 How many films (movies) are available for rent (table film: film_id:1000, table rental: inventory_id:4580) and how many films have been rented table rental, amount of return dates 15861?
-- 2 How many films (movies) are available for rent and how many films have been rented?
SELECT film_id FROM film; -- 1000 different film_id
SELECT inventory_id FROM rental; -- 4580 different invetory_id
SELECT return_date FROM rental; -- 16044 rows
SELECT rental_date FROM rental; -- 16044 rows
SELECT title FROM film; -- 1000 rows

-- 2 How many films (movies) are available for rent and how many films have been rented?
SELECT film.film_id,COUNT(rental.return_date) AS NumberOfReturnDates 
FROM rental
LEFT JOIN film 
ON rental.return_date = rental.return_date
GROUP BY film_id
LIMIT 1;

-- 183 movies on rent
SELECT COUNT(inventory_id) as NumOfMoviesOnRent
FROM rental
WHERE return_date IS NULL;
-- found in: 
-- SELECT Shippers.ShipperName,COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
-- LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
-- GROUP BY ShipperName;
-- https://www.w3schools.com/mysql/trymysql.asp?filename=trysql_select_groupby1

-- 3 What are the shortest 46 and longest 185 movie duration? Name the values max_duration and – min_duration.

SELECT title, length
FROM film
ORDER BY length ASC;

SELECT MIN(length) ASmMin_duration
FROM film;

SELECT MAX(length) AS max_duration
FROM film;

-- 4 What's the average movie duration expressed in format (hours, minutes)?
SELECT sec_to_time(AVG(length)*60)
AS average_duration
FROM sakila.film;
# 5 How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT last_name)
FROM actor;

# 6 Since how many days has the company been operating (check DATEDIFF() function)?
SELECT datediff((LEFT(MAX(last_update), 11)), LEFT(MIN(payment_date),11)) AS operating_days
FROM payment;

#7 Show rental info with additional columns month and weekday. Get 20 results.
#Just one of the date column

SELECT * , date_format(rental_date, '%M') AS 'month', date_format(rental_date, '%a') AS 'weekday'
FROM rental;

# 8 Add an additional column day_type with values 'weekend' and 'workday' depending on 
#the rental # 8 day of the week.
SELECT * ,
CASE
WHEN WEEKDAY(rental_date) BETWEEN 0 AND 4 THEN 'Weekday'
WHEN WEEKDAY(rental_date) BETWEEN 5 AND 6 THEN 'Weekend'
END AS day_type
FROM rental;

# 9 Get release years.
SELECT (release_year)
FROM film
LIMIT 1;

# 10 Get all films with ARMAGEDDON in the title.
SELECT title
FROM film
WHERE title LIKE ('%ARMAGEDDON');

# 11 Get all films which title ends with APOLLO.
SELECT title 
FROM film
WHERE right(title,6) = 'APOLLO';

# 12 Get 10 the longest films.
SELECT title, length 
FROM film
ORDER BY length DESC
LIMIT 10;

# 13 How many films include Behind the Scenes content?
SELECT COUNT(title)
FROM film
WHERE special_features LIKE ('%Behind the scenes%');



