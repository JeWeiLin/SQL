use leetcode;

## Problem 1757
CREATE TABLE IF NOT EXISTS Products (product_id INT, low_fats ENUM('Y', 'N'), recyclable ENUM('Y', 'N'));
INSERT INTO Products (product_id, low_fats, recyclable) VALUES ('0', 'Y', 'N');
INSERT INTO Products (product_id, low_fats, recyclable) VALUES ('1', 'Y', 'Y');
INSERT INTO Products (product_id, low_fats, recyclable) VALUES ('2', 'N', 'Y');
INSERT INTO Products (product_id, low_fats, recyclable) VALUES ('3', 'Y', 'Y');
INSERT INTO Products (product_id, low_fats, recyclable) VALUES ('4', 'N', 'N');

SELECT product_id FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';

## Problem 2356
CREATE TABLE IF NOT EXISTS Teacher (teacher_id INT, subject_id INT, dept_id INT);
INSERT INTO Teacher (teacher_id, subject_id, dept_id) VALUES ('1', '2', '3');
INSERT INTO Teacher (teacher_id, subject_id, dept_id) VALUES ('1', '2', '4');
INSERT INTO Teacher (teacher_id, subject_id, dept_id) VALUES ('1', '3', '3');
INSERT INTO Teacher (teacher_id, subject_id, dept_id) VALUES ('2', '1', '1');
INSERT INTO Teacher (teacher_id, subject_id, dept_id) VALUES ('2', '2', '1');
INSERT INTO Teacher (teacher_id, subject_id, dept_id) VALUES ('2', '3', '1');
INSERT INTO Teacher (teacher_id, subject_id, dept_id) VALUES ('2', '4', '1');

SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt FROM Teacher
GROUP BY teacher_id;

## Problem 1741
CREATE TABLE IF NOT EXISTS Employees (emp_id INT, event_day DATE, in_time INT, out_time INT);
INSERT INTO Employees (emp_id, event_day, in_time, out_time) VALUES ('1', '2020-11-28', '4', '32');
INSERT INTO Employees (emp_id, event_day, in_time, out_time) VALUES ('1', '2020-11-28', '55', '200');
INSERT INTO Employees (emp_id, event_day, in_time, out_time) VALUES ('1', '2020-12-3', '1', '42');
INSERT INTO Employees (emp_id, event_day, in_time, out_time) VALUES ('2', '2020-11-28', '3', '33');
INSERT INTO Employees (emp_id, event_day, in_time, out_time) VALUES ('2', '2020-12-9', '47', '74');

SELECT event_day AS day, emp_id, SUM(out_time - in_time) AS total_time FROM Employees
GROUP BY emp_id, event_day;


## Problem 1693
CREATE TABLE IF NOT EXISTS DailySales (date_id DATE, make_name VARCHAR(20), lead_id INT, partner_id INT);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-8', 'toyota', '0', '1');
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-8', 'toyota', '1', '0');
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-8', 'toyota', '1', '2');
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-7', 'toyota', '0', '2');
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-7', 'toyota', '0', '1');
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-8', 'honda', '1', '2');
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-8', 'honda', '2', '1');
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-7', 'honda', '0', '1');
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-7', 'honda', '1', '2');
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-7', 'honda', '2', '1');

SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales
GROUP BY date_id, make_name;

## Problem 1393
CREATE TABLE IF NOT EXISTS Stocks (stock_name VARCHAR(15), operation ENUM('Sell', 'Buy'), operation_day INT, price INT);
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Leetcode', 'Buy', '1', '1000');
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Corona Masks', 'Buy', '2', '10');
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Leetcode', 'Sell', '5', '9000');
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Handbags', 'Buy', '17', '30000');
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Corona Masks', 'Sell', '3', '1010');
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Corona Masks', 'Buy', '4', '1000');
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Corona Masks', 'Sell', '5', '500');
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Corona Masks', 'Buy', '6', '1000');
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Handbags', 'Sell', '29', '7000');
INSERT INTO Stocks (stock_name, operation, operation_day, price) VALUES ('Corona Masks', 'Sell', '10', '10000');

SELECT s.stock_name, s.sell_total - SUM(price) AS capital_gain_loss FROM Stocks AS b
	INNER JOIN (
		SELECT stock_name, SUM(price) AS sell_total FROM Stocks
		WHERE operation = 'Sell'
		GROUP BY stock_name, operation
    ) AS s ON b.stock_name = s.stock_name
WHERE operation = 'Buy'
GROUP BY stock_name, operation;

SELECT stock_name, 
	SUM(
		CASE WHEN operation = 'Buy' THEN
			-price
		ELSE
			price
		END
	) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name;

SELECT stock_name, SUM(CASE WHEN operation = 'Sell' THEN price ELSE -price END) AS capital_gain_loss FROM Stocks 
GROUP BY stock_name;

## Problem 1795
DROP TABLE IF EXISTS Products;
CREATE TABLE IF NOT EXISTS Products (product_id INT, store1 VARCHAR(10), store2 VARCHAR(10), store3 VARCHAR(10));
INSERT INTO Products (product_id, store1, store2, store3) VALUES ('0', '95', '100', '105');
INSERT INTO Products (product_id, store1, store2, store3) VALUES ('1', '70', 'None', '80');

SELECT * FROM (
	SELECT p.product_id, "store1" AS store, p.store1 AS price FROM Products AS p
	UNION ALL
	SELECT p.product_id, "store2" AS store, p.store2 AS price FROM Products AS p
	UNION ALL
	SELECT p.product_id, "store3" AS store, p.store3 AS price FROM Products AS p
) AS r
WHERE r.price != 'None';

SELECT p.product_id, "store1" AS store, p.store1 AS price FROM Products AS p
WHERE store1 != 'None'
UNION ALL
SELECT p.product_id, "store2" AS store, p.store2 AS price FROM Products AS p
WHERE store2 != 'None'
UNION ALL
SELECT p.product_id, "store3" AS store, p.store3 AS price FROM Products AS p
WHERE store3 != 'None';

## Problem 1683
DROP TABLE IF EXISTS Tweets;
CREATE TABLE IF NOT EXISTS Tweets (tweet_id INT, content VARCHAR(50));
INSERT INTO Tweets (tweet_id, content) VALUES ('1', 'Vote for Biden');
INSERT INTO Tweets (tweet_id, content) VALUES ('2', 'Let us make America great again!');

SELECT tweet_id FROM Tweets
WHERE LENGTH(content) > 15;

## Problem 1587
DROP TABLE IF EXISTS Users;
CREATE TABLE IF NOT EXISTS Users (account INT, name VARCHAR(20));
INSERT INTO Users (account, name) VALUES ('900001', 'Alice');
INSERT INTO Users (account, name) VALUES ('900002', 'Bob');
INSERT INTO Users (account, name) VALUES ('900003', 'Charlie');

DROP TABLE IF EXISTS Transactions;
CREATE TABLE IF NOT EXISTS Transactions (trans_id INT, account INT, amount INT, transacted_on DATE);
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES ('1', '900001', '7000', '2020-08-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES ('2', '900001', '7000', '2020-09-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES ('3', '900001', '-3000', '2020-09-02');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES ('4', '900002', '1000', '2020-09-12');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES ('5', '900003', '6000', '2020-08-07');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES ('6', '900003', '6000', '2020-09-07');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES ('7', '900003', '-4000', '2020-09-11');

SELECT r.name, r.balance FROM (
	SELECT u.name, SUM(t.amount) AS balance FROM Transactions AS t
	LEFT JOIN Users AS u
	ON t.account = u.account
	GROUP BY u.name
) AS r
WHERE balance > 10000;


# Problem 627
DROP TABLE IF EXISTS Salary;
CREATE TABLE IF NOT EXISTS Salary (id INT, name VARCHAR(100), sex CHAR(1), salary INT);
INSERT INTO Salary (id, name, sex, salary) VALUES ('1', 'A', 'm', '2500');
INSERT INTO Salary (id, name, sex, salary) VALUES ('2', 'B', 'f', '1500');
INSERT INTO Salary (id, name, sex, salary) VALUES ('3', 'C', 'm', '5500');
INSERT INTO Salary (id, name, sex, salary) VALUES ('4', 'D', 'f', '500');

SET SQL_SAFE_UPDATES = 0;

UPDATE Salary
SET sex = (
	CASE sex 
		WHEN 'f' THEN 'm'
		WHEN 'm' THEN 'f'
	END
);

    
# Problem 1378
DROP TABLE IF EXISTS Employees;
CREATE TABLE IF NOT EXISTS Employees (id INT, name VARCHAR(20));
INSERT INTO Employees (id, name) VALUES ('1', 'Alice');
INSERT INTO Employees (id, name) VALUES ('7', 'Bob');
INSERT INTO Employees (id, name) VALUES ('11', 'Meir');
INSERT INTO Employees (id, name) VALUES ('90', 'Winston');
INSERT INTO Employees (id, name) VALUES ('3', 'Jonathan');

DROP TABLE IF EXISTS EmployeeUNI;
CREATE TABLE IF NOT EXISTS EmployeeUNI (id INT, unique_id INT);
INSERT INTO EmployeeUNI (id, unique_id) VALUES ('3', '1');
INSERT INTO EmployeeUNI (id, unique_id) VALUES ('11', '2');
INSERT INTO EmployeeUNI (id, unique_id) VALUES ('90', '3');

SELECT eu.unique_id, e.name 
FROM Employees AS e
LEFT JOIN EmployeeUNI AS eu
ON e.id = eu.id;


# Problem 1068
DROP TABLE IF EXISTS Sales;
CREATE TABLE IF NOT EXISTS Sales (sale_id INT, product_id INT, year INT, quantity INT, price INT);
INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES ('1', '100', '2008', '10', '5000');
INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES ('2', '100', '2009', '12', '5000');
INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES ('7', '200', '2011', '15', '9000');

DROP TABLE IF EXISTS Product;
CREATE TABLE IF NOT EXISTS Product (product_id INT, product_name VARCHAR(10));
INSERT INTO Product (product_id, product_name) VALUES ('100', 'Nokia');
INSERT INTO Product (product_id, product_name) VALUES ('200', 'Apple');
INSERT INTO Product (product_id, product_name) VALUES ('300', 'Samsung');

SELECT p.product_name, s.year, s.price 
FROM Sales AS s
LEFT JOIN Product AS p
ON s.product_id = p.product_id;



# Problem 1179
DROP TABLE IF EXISTS Department;
CREATE TABLE IF NOT EXISTS Department (id INT, revenue INT, month VARCHAR(5));
INSERT INTO Department (id, revenue, month) VALUES ('1', '8000', 'Jan');
INSERT INTO Department (id, revenue, month) VALUES ('2', '9000', 'Jan');
INSERT INTO Department (id, revenue, month) VALUES ('3', '10000', 'Feb');
INSERT INTO Department (id, revenue, month) VALUES ('1', '7000', 'Feb');
INSERT INTO Department (id, revenue, month) VALUES ('1', '6000', 'Mar');


SELECT id,
	SUM(CASE month WHEN 'Jan' THEN revenue ELSE NULL END) AS Jan_Revenue,
    SUM(CASE month WHEN 'Feb' THEN revenue ELSE NULL END) AS Feb_Revenue,
    SUM(CASE month WHEN 'Mar' THEN revenue ELSE NULL END) AS Mar_Revenue,
    SUM(CASE month WHEN 'Apr' THEN revenue ELSE NULL END) AS Apr_Revenue,
    SUM(CASE month WHEN 'May' THEN revenue ELSE NULL END) AS May_Revenue,
    SUM(CASE month WHEN 'Jun' THEN revenue ELSE NULL END) AS Jun_Revenue,
    SUM(CASE month WHEN 'Jul' THEN revenue ELSE NULL END) AS Jul_Revenue,
    SUM(CASE month WHEN 'Aug' THEN revenue ELSE NULL END) AS Aug_Revenue,
    SUM(CASE month WHEN 'Sep' THEN revenue ELSE NULL END) AS Sep_Revenue,
    SUM(CASE month WHEN 'Oct' THEN revenue ELSE NULL END) AS Oct_Revenue,
    SUM(CASE month WHEN 'Nov' THEN revenue ELSE NULL END) AS Nov_Revenue,
    SUM(CASE month WHEN 'Dec' THEN revenue ELSE NULL END) AS Dec_Revenue
FROM Department
GROUP BY id;


# Problem 1890
DROP TABLE IF EXISTS Logins;
Create table If Not Exists Logins (user_id int, time_stamp datetime);
INSERT INTO Logins (user_id, time_stamp) VALUES ('6', '2020-06-30 15:06:07');
INSERT INTO Logins (user_id, time_stamp) VALUES ('6', '2021-04-21 14:06:06');
INSERT INTO Logins (user_id, time_stamp) VALUES ('6', '2019-03-07 00:18:15');
INSERT INTO Logins (user_id, time_stamp) VALUES ('8', '2020-02-01 05:10:53');
INSERT INTO Logins (user_id, time_stamp) VALUES ('8', '2020-12-30 00:46:50');
INSERT INTO Logins (user_id, time_stamp) VALUES ('2', '2020-01-16 02:49:50');
INSERT INTO Logins (user_id, time_stamp) VALUES ('2', '2019-08-25 07:59:08');
INSERT INTO Logins (user_id, time_stamp) VALUES ('14', '2019-07-14 09:00:00');
INSERT INTO Logins (user_id, time_stamp) VALUES ('14', '2021-01-06 11:59:59');

SELECT r.user_id, r.time_stamp AS last_stamp FROM(
	SELECT *,
		ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY time_stamp DESC) AS row_num
	FROM Logins
	WHERE time_stamp >= '2020-01-01 00:00:00' and time_stamp <= '2020-12-31 23:59:59'
) as r
WHERE r.row_num = 1;

SELECT user_id, MAX(time_stamp) AS last_stamp FROM Logins
WHERE YEAR(time_stamp) = '2020'
GROUP BY user_id;

# Problem 1484
DROP TABLE IF EXISTS Activities;
Create table If Not Exists Activities (sell_date date, product varchar(20));
INSERT INTO Activities (sell_date, product) VALUES ('2020-05-30', 'Headphone');
INSERT INTO Activities (sell_date, product) VALUES ('2020-06-01', 'Pencil');
INSERT INTO Activities (sell_date, product) VALUES ('2020-06-02', 'Mask');
INSERT INTO Activities (sell_date, product) VALUES ('2020-05-30', 'Basketball');
INSERT INTO Activities (sell_date, product) VALUES ('2020-06-01', 'Bible');
INSERT INTO Activities (sell_date, product) VALUES ('2020-06-02', 'Mask');
INSERT INTO Activities (sell_date, product) VALUES ('2020-05-30', 'T-Shirt');

SELECT sell_date, COUNT(DISTINCT product) AS num_sold, GROUP_CONCAT(DISTINCT product order by product) AS products FROM Activities
GROUP BY sell_date;

# Problem 175
DROP TABLE IF EXISTS Person;
CREATE TABLE IF NOT EXISTS Person (personId INT, firstName VARCHAR(255), lastName VARCHAR(255));
INSERT INTO Person (personId, lastName, firstName) VALUES ('1', 'Wang', 'Allen');
INSERT INTO Person (personId, lastName, firstName) VALUES ('2', 'Alice', 'Bob');

DROP TABLE IF EXISTS Address;
CREATE TABLE IF NOT EXISTS Address (addressId INT, personId INT, city VARCHAR(255), state VARCHAR(255));
INSERT INTO Address (addressId, personId, city, state) VALUES ('1', '2', 'New York City', 'New York');
INSERT INTO Address (addressId, personId, city, state) VALUES ('2', '3', 'Leetcode', 'California');

SELECT p.firstName, p.lastName, a.city, a.state FROM Person AS p
LEFT JOIN Address AS a
ON p.personId = a.personId;



# Problem 1148
DROP TABLE IF EXISTS Views;
CREATE TABLE IF NOT EXISTS Views (article_id INT, author_id INT, viewer_id INT, view_date DATE);
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES ('1', '3', '5', '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES ('1', '3', '6', '2019-08-02');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES ('2', '7', '7', '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES ('2', '7', '6', '2019-08-02');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES ('4', '7', '1', '2019-07-22');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES ('3', '4', '4', '2019-07-21');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES ('3', '4', '4', '2019-07-21');

SELECT DISTINCT author_id AS id FROM Views
WHERE author_id = viewer_id
ORDER BY author_id ASC;



# Problem 577
DROP TABLE IF EXISTS Employee;
CREATE TABLE IF NOT EXISTS Employee (empId INT, name VARCHAR(255), supervisor VARCHAR(255), salary INT);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES ('3', 'Brad', 'None', '4000');
INSERT INTO Employee (empId, name, supervisor, salary) VALUES ('1', 'John', '3', '1000');
INSERT INTO Employee (empId, name, supervisor, salary) VALUES ('2', 'Dan', '3', '2000');
INSERT INTO Employee (empId, name, supervisor, salary) VALUES ('4', 'Thomas', '3', '4000');

DROP TABLE IF EXISTS Bonus;
CREATE TABLE IF NOT EXISTS Bonus (empId INT, bonus INT);
INSERT INTO Bonus (empId, bonus) VALUES ('2', '500');
INSERT INTO Bonus (empId, bonus) VALUES ('4', '2000');

SELECT e.name, b.bonus FROM Employee AS e
LEFT JOIN Bonus AS b
ON e.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus IS NULL;



# Problem 511
DROP TABLE IF EXISTS Activity;
CREATE TABLE IF NOT EXISTS Activity (player_id INT, device_id INT, event_date DATE, games_played INT);
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('1', '2', '2016-03-01', '5');
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('1', '2', '2016-05-02', '6');
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('2', '3', '2017-06-25', '1');
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('3', '1', '2016-03-02', '0');
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('3', '4', '2018-07-03', '5');

SELECT player_id, MIN(event_date) AS first_login FROM Activity
GROUP BY player_id;



# Problem 620
DROP TABLE IF EXISTS cinema;
CREATE TABLE IF NOT EXISTS cinema (id INT, movie VARCHAR(255), description VARCHAR(255), rating FLOAT(2, 1));
INSERT INTO cinema (id, movie, description, rating) VALUES ('1', 'War', 'great 3D', '8.9');
INSERT INTO cinema (id, movie, description, rating) VALUES ('2', 'Science', 'fiction', '8.5');
INSERT INTO cinema (id, movie, description, rating) VALUES ('3', 'irish', 'boring', '6.2');
INSERT INTO cinema (id, movie, description, rating) VALUES ('4', 'Ice song', 'Fantacy', '8.6');
INSERT INTO cinema (id, movie, description, rating) VALUES ('5', 'House card', 'Interesting', '9.1');

SELECT * FROM cinema
WHERE id % 2 = 1 AND description != 'boring'
ORDER BY rating DESC;



# Problem 608
DROP TABLE IF EXISTS Tree;
CREATE TABLE IF NOT EXISTS Tree (id INT, p_id VARCHAR(255));
INSERT INTO Tree (id, p_id) VALUES ('1', 'None');
INSERT INTO Tree (id, p_id) VALUES ('2', '1');
INSERT INTO Tree (id, p_id) VALUES ('3', '1');
INSERT INTO Tree (id, p_id) VALUES ('4', '2');
INSERT INTO Tree (id, p_id) VALUES ('5', '2');

SELECT id,
	CASE
		WHEN p_id = 'None' THEN 'Root'
		WHEN id IN (SELECT DISTINCT p_id FROM Tree) THEN 'Inner'
		ELSE 'Leaf'
	END AS type
FROM Tree;



# Problem 610
DROP TABLE IF EXISTS Triangle;
CREATE TABLE IF NOT EXISTS Triangle (x INT, y INT, z INT);
INSERT INTO Triangle (x, y, z) VALUES ('13', '15', '30');
INSERT INTO Triangle (x, y, z) VALUES ('10', '20', '15');

SELECT *,
	CASE 
		WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes'
        ELSE 'No'
	END AS 'triangle'
FROM Triangle;

SELECT *,
	IF(x + y > z AND x + z > y AND y + z > x, 'Yes', 'No') AS 'triangle'
FROM Triangle;



# Problem 1965
DROP TABLE IF EXISTS Employees;
CREATE TABLE IF NOT EXISTS Employees (employee_id INT, name VARCHAR(30));
INSERT INTO Employees (employee_id, name) VALUES ('2', 'Crew');
INSERT INTO Employees (employee_id, name) VALUES ('4', 'Haven');
INSERT INTO Employees (employee_id, name) VALUES ('5', 'Kristian');

DROP TABLE IF EXISTS Salaries;
CREATE TABLE IF NOT EXISTS Salaries (employee_id INT, salary INT);
INSERT INTO Salaries (employee_id, salary) VALUES ('5', '76071');
INSERT INTO Salaries (employee_id, salary) VALUES ('1', '22517');
INSERT INTO Salaries (employee_id, salary) VALUES ('4', '63539');

SELECT * FROM (
	SELECT e.employee_id 
	FROM Employees AS e
	LEFT JOIN Salaries AS s
	ON e.employee_id = s.employee_id
	WHERE e.name IS NULL OR s.salary IS NULL
	UNION ALL
	SELECT s.employee_id 
	FROM Salaries AS s
	LEFT JOIN Employees AS e
	ON e.employee_id = s.employee_id
	WHERE e.name IS NULL OR s.salary IS NULL
) AS r
ORDER BY employee_id ASC;



# Problem 182
DROP TABLE IF EXISTS Person;
CREATE TABLE IF NOT EXISTS Person (id INT, email VARCHAR(255));
INSERT INTO Person (id, email) VALUES ('1', 'a@b.com');
INSERT INTO Person (id, email) VALUES ('2', 'c@d.com');
INSERT INTO Person (id, email) VALUES ('3', 'a@b.com');

SELECT email FROM (
	SELECT email, 
		ROW_NUMBER() OVER (PARTITION BY email) AS row_num
	FROM Person
) AS r
WHERE r.row_num = 2;

SELECT email FROM Person
GROUP BY email
HAVING COUNT(email) > 1;



# Problem 1327
DROP TABLE IF EXISTS Products;
CREATE TABLE IF NOT EXISTS Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
INSERT INTO Products (product_id, product_name, product_category) VALUES ('1', 'Leetcode Solutions', 'Book');
INSERT INTO Products (product_id, product_name, product_category) VALUES ('2', 'Jewels of Stringology', 'Book');
INSERT INTO Products (product_id, product_name, product_category) VALUES ('3', 'HP', 'Laptop');
INSERT INTO Products (product_id, product_name, product_category) VALUES ('4', 'Lenovo', 'Laptop');
INSERT INTO Products (product_id, product_name, product_category) VALUES ('5', 'Leetcode Kit', 'T-shirt');

DROP TABLE IF EXISTS Orders;
CREATE TABLE IF NOT EXISTS Orders (product_id INT, order_date DATE, unit INT);
INSERT INTO Orders (product_id, order_date, unit) VALUES ('1', '2020-02-05', '60');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('1', '2020-02-10', '70');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('2', '2020-01-18', '30');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('2', '2020-02-11', '80');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('3', '2020-02-17', '2');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('3', '2020-02-24', '3');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('4', '2020-03-01', '20');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('4', '2020-03-04', '30');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('4', '2020-03-04', '60');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('5', '2020-02-25', '50');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('5', '2020-02-27', '50');
INSERT INTO Orders (product_id, order_date, unit) VALUES ('5', '2020-03-01', '50');

SELECT p.product_name, o.unit 
FROM Products AS p
INNER JOIN (
	SELECT product_id, SUM(unit) AS unit 
	FROM Orders
	WHERE YEAR(order_date) = '2020' AND MONTH(order_date) = '2'
	GROUP BY product_id
	HAVING SUM(unit) >= 100
) AS o
ON p.product_id = o.product_id;



# Problem 1050
DROP TABLE IF EXISTS ActorDirector;
CREATE TABLE IF NOT EXISTS ActorDirector (actor_id INT, director_id INT, timestamp INT);
INSERT INTO ActorDirector (actor_id, director_id, timestamp) VALUES ('1', '1', '0');
INSERT INTO ActorDirector (actor_id, director_id, timestamp) VALUES ('1', '1', '1');
INSERT INTO ActorDirector (actor_id, director_id, timestamp) VALUES ('1', '1', '2');
INSERT INTO ActorDirector (actor_id, director_id, timestamp) VALUES ('1', '2', '3');
INSERT INTO ActorDirector (actor_id, director_id, timestamp) VALUES ('1', '2', '4');
INSERT INTO ActorDirector (actor_id, director_id, timestamp) VALUES ('2', '1', '5');
INSERT INTO ActorDirector (actor_id, director_id, timestamp) VALUES ('2', '1', '6');

SELECT CAST(SUBSTRING_INDEX(r.ad, ',', 1) AS UNSIGNED) AS actor_id, CAST(SUBSTRING_INDEX(r.ad, ',', -1) AS UNSIGNED) AS director_id 
FROM (
	SELECT CONCAT(actor_id, ',', director_id) AS ad
	FROM ActorDirector
	GROUP BY CONCAT(actor_id, ',', director_id)
	HAVING COUNT(CONCAT(actor_id, ',', director_id)) >= 3
) AS r;

SELECT actor_id, director_id 
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(timestamp) >= 3;



# Problem 584
DROP TABLE IF EXISTS Customer;
CREATE TABLE IF NOT EXISTS Customer (id INT, name VARCHAR(25), referee_id VARCHAR(255));
INSERT INTO Customer (id, name, referee_id) VALUES ('1', 'Will', 'None');
INSERT INTO Customer (id, name, referee_id) VALUES ('2', 'Jane', 'None');
INSERT INTO Customer (id, name, referee_id) VALUES ('3', 'Alex', '2');
INSERT INTO Customer (id, name, referee_id) VALUES ('4', 'Bill', 'None');
INSERT INTO Customer (id, name, referee_id) VALUES ('5', 'Zack', '1');
INSERT INTO Customer (id, name, referee_id) VALUES ('6', 'Mark', '2');

SELECT name 
FROM Customer
WHERE referee_id != '2' OR referee_id IS NULL;



# Problem 626
DROP TABLE IF EXISTS Seat;
Create table If Not Exists Seat (id int, student varchar(255));
insert into Seat (id, student) values ('1', 'Field');
insert into Seat (id, student) values ('2', 'Sherwood');
insert into Seat (id, student) values ('3', 'Aly');
insert into Seat (id, student) values ('4', 'Harriman');
insert into Seat (id, student) values ('5', 'Christ');
insert into Seat (id, student) values ('6', 'Pullan');
insert into Seat (id, student) values ('7', 'Harry');
insert into Seat (id, student) values ('8', 'Roosevelt');
insert into Seat (id, student) values ('9', 'Richard');
insert into Seat (id, student) values ('10', 'Evan');
insert into Seat (id, student) values ('11', 'Pansy');
insert into Seat (id, student) values ('12', 'Darwin');
insert into Seat (id, student) values ('13', 'Chamberian');
insert into Seat (id, student) values ('14', 'Kennedy');
insert into Seat (id, student) values ('15', 'Clapham');
insert into Seat (id, student) values ('16', 'Hart');
insert into Seat (id, student) values ('17', 'Carllyle');
insert into Seat (id, student) values ('18', 'Esther');
insert into Seat (id, student) values ('19', 'Rhodes');
insert into Seat (id, student) values ('20', 'Hodgson');


SELECT ROW_NUMBER() OVER (PARTITION BY (SELECT 1) ORDER BY r.rown ASC, r.id DESC) AS id,
	r.student
FROM (
	SELECT *,
		ROW_NUMBER() OVER (ORDER BY id) AS rown
	FROM Seat
	WHERE id % 2 = 1
	UNION ALL
	SELECT *,
		ROW_NUMBER() OVER (ORDER BY id) AS rown
	FROM Seat
	WHERE id % 2 = 0
	ORDER BY rown ASC, id DESC
) AS r;

SELECT 
	CASE
		WHEN id = (SELECT MAX(id) FROM Seat) AND id % 2 = 1 THEN id
        WHEN id % 2 = 1 THEN id + 1
        WHEN id % 2 = 0 THEN id - 1
    END AS id,
    student
FROM Seat
ORDER BY id;


# Problem 181
DROP TABLE IF EXISTS Employee;
CREATE TABLE IF NOT EXISTS Employee (id INT, name VARCHAR(255), salary INT, managerId VARCHAR(255));
INSERT INTO Employee (id, name, salary, managerId) VALUES ('1', 'Joe', '70000', '3');
INSERT INTO Employee (id, name, salary, managerId) VALUES ('2', 'Henry', '80000', '4');
INSERT INTO Employee (id, name, salary, managerId) VALUES ('3', 'Sam', '60000', 'None');
INSERT INTO Employee (id, name, salary, managerId) VALUES ('4', 'Max', '90000', 'None');

SELECT e1.name AS employee 
FROM Employee AS e1
INNER JOIN Employee AS e2
ON e1.managerId = e2.id
WHERE e1.salary > e2.salary;


# Problem 183
DROP TABLE IF EXISTS Customers;
CREATE TABLE IF NOT EXISTS Customers (id INT, name VARCHAR(255));
INSERT INTO Customers (id, name) VALUES ('1', 'Joe');
INSERT INTO Customers (id, name) VALUES ('2', 'Henry');
INSERT INTO Customers (id, name) VALUES ('3', 'Sam');
INSERT INTO Customers (id, name) VALUES ('4', 'Max');

DROP TABLE IF EXISTS Orders;
CREATE TABLE IF NOT EXISTS Orders (id INT, customerId INT);
INSERT INTO Orders (id, customerId) VALUES ('1', '3');
INSERT INTO Orders (id, customerId) VALUES ('2', '1');

SELECT c.name AS customers 
FROM Customers AS c
LEFT OUTER JOIN Orders AS o
ON c.id = customerId
WHERE o.id IS NULL;



# Problem 1729
DROP TABLE IF EXISTS Followers;
CREATE TABLE IF NOT EXISTS Followers(user_id INT, follower_id INT);
INSERT INTO Followers (user_id, follower_id) VALUES ('0', '1');
INSERT INTO Followers (user_id, follower_id) VALUES ('1', '0');
INSERT INTO Followers (user_id, follower_id) VALUES ('2', '0');
INSERT INTO Followers (user_id, follower_id) VALUES ('2', '1');

SELECT user_id, COUNT(follower_id) AS followers_count 
FROM Followers
GROUP BY user_id
ORDER BY user_id ASC;



# Problem 1581
DROP TABLE IF EXISTS Visits;
CREATE TABLE IF NOT EXISTS Visits(visit_id INT, customer_id INT);
INSERT INTO Visits (visit_id, customer_id) VALUES ('1', '23');
INSERT INTO Visits (visit_id, customer_id) VALUES ('2', '9');
INSERT INTO Visits (visit_id, customer_id) VALUES ('4', '30');
INSERT INTO Visits (visit_id, customer_id) VALUES ('5', '54');
INSERT INTO Visits (visit_id, customer_id) VALUES ('6', '96');
INSERT INTO Visits (visit_id, customer_id) VALUES ('7', '54');
INSERT INTO Visits (visit_id, customer_id) VALUES ('8', '54');

DROP TABLE IF EXISTS Transactions;
CREATE TABLE IF NOT EXISTS Transactions(transaction_id INT, visit_id INT, amount INT);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES ('2', '5', '310');
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES ('3', '5', '300');
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES ('9', '5', '200');
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES ('12', '1', '910');
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES ('13', '2', '970');

SELECT v.customer_id, COUNT(*) AS count_no_trans 
FROM Visits AS v
LEFT OUTER JOIN Transactions AS t
ON v.visit_id = t.visit_id
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id;



# Problem 595
DROP TABLE IF EXISTS World;
CREATE TABLE IF NOT EXISTS World (name VARCHAR(255), continent VARCHAR(255), area INT, population INT, gdp BIGINT);
INSERT INTO World (name, continent, area, population, gdp) VALUES ('Afghanistan', 'Asia', '652230', '25500100', '20343000000');
INSERT INTO World (name, continent, area, population, gdp) VALUES ('Albania', 'Europe', '28748', '2831741', '12960000000');
INSERT INTO World (name, continent, area, population, gdp) VALUES ('Algeria', 'Africa', '2381741', '37100000', '188681000000');
INSERT INTO World (name, continent, area, population, gdp) VALUES ('Andorra', 'Europe', '468', '78115', '3712000000');
INSERT INTO World (name, continent, area, population, gdp) VALUES ('Angola', 'Africa', '1246700', '20609294', '100990000000');

SELECT name, population, area 
FROM World
WHERE area >= 3000000 OR population >= 25000000;



# Problem 1661
DROP TABLE IF EXISTS Activity;
CREATE TABLE IF NOT EXISTS Activity (machine_id INT, process_id INT, activity_type ENUM('start', 'end'), timestamp FLOAT);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('0', '0', 'start', '0.712');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('0', '0', 'end', '1.52');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('0', '1', 'start', '3.14');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('0', '1', 'end', '4.12');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('1', '0', 'start', '0.55');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('1', '0', 'end', '1.55');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('1', '1', 'start', '0.43');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('1', '1', 'end', '1.42');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('2', '0', 'start', '4.1');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('2', '0', 'end', '4.512');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('2', '1', 'start', '2.5');
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES ('2', '1', 'end', '5');


SELECT r.machine_id, ROUND(AVG(r.nn), 3) AS processing_time FROM (
	SELECT machine_id,
		SUM(
			CASE activity_type
				WHEN 'start' THEN ROUND(-timestamp, 3)
				WHEN 'end' THEN ROUND(timestamp, 3)
			END
		) AS nn
	FROM Activity
	GROUP BY machine_id, process_id
) AS r
GROUP BY r.machine_id;

SELECT a1.machine_id, ROUND(AVG(a2.timestamp-a1.timestamp), 3) AS processing_time FROM Activity AS a1
INNER JOIN Activity AS a2
ON a1.machine_id=a2.machine_id AND a1.process_id=a2.process_id AND a1.activity_type='start' AND a2.activity_type='end'
GROUP BY a1.machine_id; 


# Problem 1204
DROP TABLE IF EXISTS Queue;
CREATE TABLE IF NOT EXISTS Queue (person_id INT, person_name VARCHAR(30), weight INT, turn INT);
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES ('5', 'Alice', '250', '1');
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES ('4', 'Bob', '175', '5');
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES ('3', 'Alex', '350', '2');
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES ('6', 'John Cena', '400', '3');
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES ('1', 'Winston', '500', '6');
INSERT INTO Queue (person_id, person_name, weight, turn) VALUES ('2', 'Marie', '200', '4');

SELECT q1.person_name
FROM Queue AS q1
WHERE (SELECT SUM(q2.weight) FROM Queue as q2 WHERE q2.turn <= q1.turn) <= 1000
ORDER BY q1.turn DESC LIMIT 1;

SELECT r.person_name FROM (
	SELECT person_name, turn,
		@running_total := @running_total + q.weight AS cum
	FROM Queue AS q
	INNER JOIN (SELECT @running_total := 0) AS r
	ORDER BY q.turn ASC
) AS r
WHERE r.cum <= 1000
ORDER BY r.turn DESC LIMIT 1;


# Problem 607
DROP TABLE IF EXISTS SalesPerson;
CREATE TABLE IF NOT EXISTS SalesPerson (sales_id INT, name VARCHAR(255), salary INT, commission_rate INT, hire_date DATE);
INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES ('1', 'John', '100000', '6', '2006-01-04');
INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES ('2', 'Amy', '12000', '5', '2010-01-05');
INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES ('3', 'Mark', '65000', '12', '2008-12-25');
INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES ('4', 'Pam', '25000', '25', '2005-01-01');
INSERT INTO SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES ('5', 'Alex', '5000', '10', '2007-02-03');

DROP TABLE IF EXISTS Company;
CREATE TABLE IF NOT EXISTS Company (com_id INT, name VARCHAR(255), city VARCHAR(255));
INSERT INTO Company (com_id, name, city) VALUES ('1', 'RED', 'Boston');
INSERT INTO Company (com_id, name, city) VALUES ('2', 'ORANGE', 'New York');
INSERT INTO Company (com_id, name, city) VALUES ('3', 'YELLOW', 'Boston');
INSERT INTO Company (com_id, name, city) VALUES ('4', 'GREEN', 'Austin');

DROP TABLE IF EXISTS Orders;
CREATE TABLE IF NOT EXISTS Orders (order_id INT, order_date DATE, com_id INT, sales_id INT, amount INT);
INSERT INTO Orders (order_id, order_date, com_id, sales_id, amount) VALUES ('1', '2014-01-01', '3', '4', '10000');
INSERT INTO Orders (order_id, order_date, com_id, sales_id, amount) VALUES ('2', '2014-02-01', '4', '5', '5000');
INSERT INTO Orders (order_id, order_date, com_id, sales_id, amount) VALUES ('3', '2014-03-01', '1', '1', '50000');
INSERT INTO Orders (order_id, order_date, com_id, sales_id, amount) VALUES ('4', '2014-04-01', '1', '4', '25000');


SELECT s.name FROM SalesPerson AS s
LEFT OUTER JOIN (
	SELECT * FROM Orders
	WHERE com_id IN (
		SELECT com_Id FROM Company 
		WHERE name = "RED"
)) AS oc
ON s.sales_id=oc.sales_id
WHERE oc.order_id IS NULL;


# Problem 586
DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders (order_number INT, customer_number INT);
INSERT INTO orders (order_number, customer_number) VALUES ('1', '1');
INSERT INTO orders (order_number, customer_number) VALUES ('2', '2');
INSERT INTO orders (order_number, customer_number) VALUES ('3', '3');
INSERT INTO orders (order_number, customer_number) VALUES ('4', '3');

SELECT r.customer_number FROM(
	SELECT customer_number,
		COUNT(*) AS order_num
	FROM orders
	GROUP BY customer_number
) AS r
ORDER BY r.order_num DESC LIMIT 1;


# Problem 2988
DROP TABLE IF EXISTS Employees;
CREATE TABLE IF NOT EXISTS Employees (emp_id INT, emp_name VARCHAR(50), dep_id INT, position VARCHAR(30));
INSERT INTO Employees (emp_id, emp_name, dep_id, position) VALUES ('156', 'Michael', '107', 'Manager');
INSERT INTO Employees (emp_id, emp_name, dep_id, position) VALUES ('112', 'Lucas', '107', 'Consultant');
INSERT INTO Employees (emp_id, emp_name, dep_id, position) VALUES ('8', 'Isabella', '101', 'Manager');
INSERT INTO Employees (emp_id, emp_name, dep_id, position) VALUES ('160', 'Joseph', '100', 'Manager');
INSERT INTO Employees (emp_id, emp_name, dep_id, position) VALUES ('80', 'Aiden', '100', 'Engineer');
INSERT INTO Employees (emp_id, emp_name, dep_id, position) VALUES ('190', 'Skylar', '100', 'Freelancer');
INSERT INTO Employees (emp_id, emp_name, dep_id, position) VALUES ('196', 'Stella', '101', 'Coordinator');
INSERT INTO Employees (emp_id, emp_name, dep_id, position) VALUES ('167', 'Audrey', '100', 'Consultant');
INSERT INTO Employees (emp_id, emp_name, dep_id, position) VALUES ('97', 'Nathan', '101', 'Supervisor');
INSERT INTO Employees (emp_id, emp_name, dep_id, position) VALUES ('128', 'Ian', '101', 'Administrator');
INSERT INTO Employees (emp_id, emp_name, dep_id, position) VALUES ('81', 'Ethan', '107', 'Administrator');

SELECT e.emp_name AS manager_name, e.dep_id FROM Employees AS e
INNER JOIN (
	SELECT dep_id FROM Employees
	GROUP BY dep_id
	HAVING COUNT(*) = (
	SELECT COUNT(*) AS num FROM Employees
	GROUP BY dep_id
    ORDER BY COUNT(*) DESC LIMIT 1
)) AS d
WHERE e.dep_id=d.dep_id AND e.position='Manager'
ORDER BY e.dep_id ASC;

WITH largest(dep_id, rnk) AS (
	SELECT dep_id,
		RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
	FROM Employees
	GROUP BY dep_id
)
SELECT emp_name AS manager_name, dep_id FROM Employees
WHERE position='manager' AND dep_id IN (
	SELECT dep_id FROM largest
    WHERE rnk='1'
)
ORDER BY dep_id ASC;


# Problem 1077
DROP TABLE IF EXISTS Project;
CREATE TABLE IF NOT EXISTS Project (project_id INT, employee_id INT);
INSERT INTO Project (project_id, employee_id) VALUES ('1', '1');
INSERT INTO Project (project_id, employee_id) VALUES ('1', '2');
INSERT INTO Project (project_id, employee_id) VALUES ('1', '3');
INSERT INTO Project (project_id, employee_id) VALUES ('2', '1');
INSERT INTO Project (project_id, employee_id) VALUES ('2', '4');

DROP TABLE IF EXISTS Employee;
CREATE TABLE IF NOT EXISTS Employee (employee_id INT, name VARCHAR(10), experience_years INT);
INSERT INTO Employee (employee_id, name, experience_years) VALUES ('1', 'Khaled', '3');
INSERT INTO Employee (employee_id, name, experience_years) VALUES ('2', 'Ali', '2');
INSERT INTO Employee (employee_id, name, experience_years) VALUES ('3', 'John', '3');
INSERT INTO Employee (employee_id, name, experience_years) VALUES ('4', 'Doe', '2');


WITH jointable AS (
	SELECT p.project_id, e.employee_id, e.experience_years
	FROM Project AS p
	INNER JOIN Employee AS e
	ON p.employee_id=e.employee_id
)
SELECT r.project_id, r.employee_id FROM (
	SELECT project_id, experience_years, employee_id,
		RANK() OVER (PARTITION BY project_id ORDER BY experience_years DESC) AS rnk
	FROM jointable
) AS r
WHERE r.rnk=1;

SELECT r.project_id, r.employee_id FROM (
	SELECT p.project_id, p.employee_id,
		RANK() OVER (PARTITION BY project_id ORDER BY experience_years DESC) AS rnk
	FROM Project AS p
	INNER JOIN Employee AS e
	ON p.employee_id=e.employee_id
) AS r
WHERE r.rnk='1';


# Problem 1715
DROP TABLE IF EXISTS Boxes;
CREATE TABLE IF NOT EXISTS Boxes (box_id INT, chest_id VARCHAR(255), apple_count INT, orange_count INT);
INSERT INTO Boxes (box_id, chest_id, apple_count, orange_count) VALUES ('2', 'None', '6', '15');
INSERT INTO Boxes (box_id, chest_id, apple_count, orange_count) VALUES ('18', 'None', '4', '15');
INSERT INTO Boxes (box_id, chest_id, apple_count, orange_count) VALUES ('19', 'None', '8', '4');
INSERT INTO Boxes (box_id, chest_id, apple_count, orange_count) VALUES ('12', 'None', '19', '20');
INSERT INTO Boxes (box_id, chest_id, apple_count, orange_count) VALUES ('20', 'None', '12', '9');
INSERT INTO Boxes (box_id, chest_id, apple_count, orange_count) VALUES ('8', 'None', '9', '9');
INSERT INTO Boxes (box_id, chest_id, apple_count, orange_count) VALUES ('3', 'None', '16', '7');

DROP TABLE IF EXISTS Chests;
CREATE TABLE IF NOT EXISTS Chests (chest_id INT, apple_count INT, orange_count INT);
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES ('6', '5', '6');
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES ('14', '20', '10');
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES ('2', '8', '8');
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES ('3', '19', '4');
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES ('16', '19', '19');


SELECT 
	SUM(r.bac)+IFNULL(SUM(r.cac), 0) AS apple_count,
    SUM(r.boc)+IFNULL(SUM(r.coc), 0) AS orange_count
FROM (
	SELECT b.apple_count AS bac, b.orange_count AS boc, c.apple_count AS cac, c.orange_count AS coc FROM Boxes AS b
	LEFT JOIN Chests AS c
	USING (chest_id)
) AS r;


# Problem 1270
DROP TABLE IF EXISTS Employees;
CREATE TABLE IF NOT EXISTS Employees (employee_id INT, employee_name VARCHAR(30), manager_id INT);
INSERT INTO Employees (employee_id, employee_name, manager_id) VALUES ('1', 'Boss', '1');
INSERT INTO Employees (employee_id, employee_name, manager_id) VALUES ('3', 'Alice', '3');
INSERT INTO Employees (employee_id, employee_name, manager_id) VALUES ('2', 'Bob', '1');
INSERT INTO Employees (employee_id, employee_name, manager_id) VALUES ('4', 'Daniel', '2');
INSERT INTO Employees (employee_id, employee_name, manager_id) VALUES ('7', 'Luis', '4');
INSERT INTO Employees (employee_id, employee_name, manager_id) VALUES ('8', 'John', '3');
INSERT INTO Employees (employee_id, employee_name, manager_id) VALUES ('9', 'Angela', '8');
INSERT INTO Employees (employee_id, employee_name, manager_id) VALUES ('77', 'Robert', '1');


SELECT e3.employee_id FROM Employees AS e4
INNER JOIN (
	SELECT e1.employee_id, e2.manager_id AS manager_of_manager_id FROM Employees AS e1
	INNER JOIN Employees AS e2
	ON e1.manager_id=e2.employee_id
) AS e3
ON e3.manager_of_manager_id=e4.employee_id
WHERE e4.manager_id=1 AND e3.employee_id != 1;

SELECT e1.employee_id
FROM Employees AS e1, Employees AS e2, Employees AS e3
WHERE e1.manager_id=e2.employee_id AND e2.manager_id=e3.employee_id AND e1.employee_id != 1 AND e3.manager_id=1;


# Problem 1445
DROP TABLE IF EXISTS Sales;
CREATE TABLE IF NOT EXISTS Sales (sale_date DATE, fruit ENUM('apples', 'oranges'), sold_num INT);
INSERT INTO Sales (sale_date, fruit, sold_num) VALUES ('2020-05-01', 'apples', '10');
INSERT INTO Sales (sale_date, fruit, sold_num) VALUES ('2020-05-01', 'oranges', '8');
INSERT INTO Sales (sale_date, fruit, sold_num) VALUES ('2020-05-02', 'apples', '15');
INSERT INTO Sales (sale_date, fruit, sold_num) VALUES ('2020-05-02', 'oranges', '15');
INSERT INTO Sales (sale_date, fruit, sold_num) VALUES ('2020-05-03', 'apples', '20');
INSERT INTO Sales (sale_date, fruit, sold_num) VALUES ('2020-05-03', 'oranges', '0');
INSERT INTO Sales (sale_date, fruit, sold_num) VALUES ('2020-05-04', 'apples', '15');
INSERT INTO Sales (sale_date, fruit, sold_num) VALUES ('2020-05-04', 'oranges', '16');


SELECT r.sale_date,
	SUM(r.arg) AS diff
FROM (
	SELECT *,
		CASE fruit
			WHEN 'apples' THEN sold_num
			WHEN 'oranges' THEN -sold_num
		END AS arg
	FROM Sales
) AS r
GROUP BY r.sale_date
ORDER BY r.sale_date ASC;

# Problem 1355
DROP TABLE IF EXISTS Friends;
CREATE TABLE IF NOT EXISTS Friends (id INT, name VARCHAR(30), activity VARCHAR(30));
INSERT INTO Friends (id, name, activity) VALUES ('1', 'Jonathan D.', 'Eating');
INSERT INTO Friends (id, name, activity) VALUES ('2', 'Jade W.', 'Singing');
INSERT INTO Friends (id, name, activity) VALUES ('3', 'Victor J.', 'Singing');
INSERT INTO Friends (id, name, activity) VALUES ('4', 'Elvis Q.', 'Eating');
INSERT INTO Friends (id, name, activity) VALUES ('5', 'Daniel A.', 'Eating');
INSERT INTO Friends (id, name, activity) VALUES ('6', 'Bob B.', 'Horse Riding');

DROP TABLE IF EXISTS Activities;
CREATE TABLE IF NOT EXISTS Activities (id INT, name VARCHAR(30));
INSERT INTO Activities (id, name) VALUES ('1', 'Eating');
INSERT INTO Activities (id, name) VALUES ('2', 'Singing');
INSERT INTO Activities (id, name) VALUES ('3', 'Horse Riding');


SELECT r.activity FROM (
	SELECT activity,
		RANK() OVER (ORDER BY COUNT(*) ASC) AS asc_rank,
		RANK() OVER (ORDER BY COUNT(*) DESC) AS desc_rank
	FROM Friends
	GROUP BY activity
) AS r
WHERE r.asc_rank != 1 AND r.desc_rank != 1;


# Problem 2020
DROP TABLE IF EXISTS Subscriptions;
CREATE TABLE IF NOT EXISTS Subscriptions (account_id INT, start_date DATE, end_date DATE);
INSERT INTO Subscriptions (account_id, start_date, end_date) VALUES ('9', '2020-02-18', '2021-10-30');
INSERT INTO Subscriptions (account_id, start_date, end_date) VALUES ('3', '2021-09-21', '2021-11-13');
INSERT INTO Subscriptions (account_id, start_date, end_date) VALUES ('11', '2020-02-28', '2020-08-18');
INSERT INTO Subscriptions (account_id, start_date, end_date) VALUES ('13', '2021-04-20', '2021-09-22');
INSERT INTO Subscriptions (account_id, start_date, end_date) VALUES ('4', '2020-10-26', '2021-05-08');
INSERT INTO Subscriptions (account_id, start_date, end_date) VALUES ('5', '2020-09-11', '2021-01-17');

DROP TABLE IF EXISTS Streams;
CREATE TABLE IF NOT EXISTS Streams (session_id INT, account_id INT, stream_date DATE);
INSERT INTO Streams (session_id, account_id, stream_date) VALUES ('14', '9', '2020-05-16');
INSERT INTO Streams (session_id, account_id, stream_date) VALUES ('16', '3', '2021-10-27');
INSERT INTO Streams (session_id, account_id, stream_date) VALUES ('18', '11', '2020-04-29');
INSERT INTO Streams (session_id, account_id, stream_date) VALUES ('17', '13', '2021-08-08');
INSERT INTO Streams (session_id, account_id, stream_date) VALUES ('19', '4', '2020-12-31');
INSERT INTO Streams (session_id, account_id, stream_date) VALUES ('13', '5', '2021-01-05');

SELECT COUNT(*) AS accounts_count FROM Subscriptions AS sub
LEFT OUTER JOIN Streams AS str
USING (account_id)
WHERE (YEAR(start_date) = '2021' OR YEAR(end_date) = '2021') AND (str.session_id IS NULL OR YEAR(str.stream_date) != '2021');


# Problem 2051
DROP TABLE IF EXISTS Members;
CREATE TABLE IF NOT EXISTS Members (member_id INT, name VARCHAR(30));
INSERT INTO Members (member_id, name) VALUES ('9', 'Alice');
INSERT INTO Members (member_id, name) VALUES ('11', 'Bob');
INSERT INTO Members (member_id, name) VALUES ('3', 'Winston');
INSERT INTO Members (member_id, name) VALUES ('8', 'Hercy');
INSERT INTO Members (member_id, name) VALUES ('1', 'Narihan');

DROP TABLE IF EXISTS Visits;
CREATE TABLE IF NOT EXISTS Visits (visit_id INT, member_id INT, visit_date DATE);
INSERT INTO Visits (visit_id, member_id, visit_date) VALUES ('22', '11', '2021-10-28');
INSERT INTO Visits (visit_id, member_id, visit_date) VALUES ('16', '11', '2021-01-12');
INSERT INTO Visits (visit_id, member_id, visit_date) VALUES ('18', '9', '2021-12-10');
INSERT INTO Visits (visit_id, member_id, visit_date) VALUES ('19', '3', '2021-10-19');
INSERT INTO Visits (visit_id, member_id, visit_date) VALUES ('12', '11', '2021-03-01');
INSERT INTO Visits (visit_id, member_id, visit_date) VALUES ('17', '8', '2021-05-07');
INSERT INTO Visits (visit_id, member_id, visit_date) VALUES ('21', '9', '2021-05-12');

DROP TABLE IF EXISTS Purchases;
CREATE TABLE IF NOT EXISTS Purchases (visit_id INT, charged_amount INT);
INSERT INTO Purchases (visit_id, charged_amount) VALUES ('12', '2000');
INSERT INTO Purchases (visit_id, charged_amount) VALUES ('18', '9000');
INSERT INTO Purchases (visit_id, charged_amount) VALUES ('17', '7000');


WITH jointable AS(
	SELECT member_id, name, 
		COUNT(CASE WHEN visit_id IS NOT NULL THEN 1 ELSE NULL END) AS visit_count,
        COUNT(CASE WHEN charged_amount IS NOT NULL THEN 1 ELSE NULL END) AS buy_count
    FROM Members AS m
	LEFT OUTER JOIN (
		SELECT * FROM Visits AS v
		LEFT OUTER JOIN Purchases AS p
		USING (visit_id)
	) AS vp
	USING (member_id)
    GROUP BY member_id, name
)

SELECT member_id, name,
	CASE
		WHEN visit_count = 0 THEN 'Bronze'
		WHEN (100*buy_count/visit_count) >= 80 THEN 'Diamond'
        WHEN (100*buy_count/visit_count) >= 50 THEN 'Gold'
        ELSE 'Silver'
    END AS category
FROM jointable
GROUP BY member_id, name;

SELECT member_id, name,
	CASE
		WHEN COUNT(v.visit_id) = 0 THEN 'Bronze'
        WHEN 100*COUNT(p.visit_id)/COUNT(v.visit_id) >= 80 THEN 'Diamond'
        WHEN 100*COUNT(p.visit_id)/COUNT(v.visit_id) >= 50 THEN 'Gold'
        ELSE 'Silver'
    END AS category
FROM Members AS m
LEFT JOIN Visits AS v USING (member_id)
LEFT JOIN Purchases AS p USING (visit_id)
GROUP BY member_id, name;


# Problem 2308
DROP TABLE IF EXISTS Genders;
CREATE TABLE IF NOT EXISTS Genders (user_id INT, gender ENUM('female', 'other', 'male'));
INSERT INTO Genders (user_id, gender) VALUES ('4', 'male');
INSERT INTO Genders (user_id, gender) VALUES ('7', 'female');
INSERT INTO Genders (user_id, gender) VALUES ('2', 'other');
INSERT INTO Genders (user_id, gender) VALUES ('5', 'male');
INSERT INTO Genders (user_id, gender) VALUES ('3', 'female');
INSERT INTO Genders (user_id, gender) VALUES ('8', 'male');
INSERT INTO Genders (user_id, gender) VALUES ('6', 'other');
INSERT INTO Genders (user_id, gender) VALUES ('1', 'other');
INSERT INTO Genders (user_id, gender) VALUES ('9', 'female');


WITH indextable AS (
	SELECT *,
		CASE gender
			WHEN 'female' THEN 1
			WHEN 'other' THEN 2
			WHEN 'male' THEN 3
		END AS inx1,
		ROW_NUMBER() OVER (PARTITION BY gender ORDER BY user_id ASC) AS inx2
	FROM Genders
)
SELECT user_id, gender FROM indextable
ORDER BY inx2, inx1;


# Problem 1951
DROP TABLE IF EXISTS Relations;
CREATE TABLE IF NOT EXISTS Relations (user_id INT, follower_id INT);
INSERT INTO Relations (user_id, follower_id) VALUES ('1', '3');
INSERT INTO Relations (user_id, follower_id) VALUES ('2', '3');
INSERT INTO Relations (user_id, follower_id) VALUES ('7', '3');
INSERT INTO Relations (user_id, follower_id) VALUES ('1', '4');
INSERT INTO Relations (user_id, follower_id) VALUES ('2', '4');
INSERT INTO Relations (user_id, follower_id) VALUES ('7', '4');
INSERT INTO Relations (user_id, follower_id) VALUES ('1', '5');
INSERT INTO Relations (user_id, follower_id) VALUES ('2', '6');
INSERT INTO Relations (user_id, follower_id) VALUES ('7', '5');

SELECT r.user1_id , r.user2_id FROM (
	SELECT r1.user_id AS user1_id, r2.user_id AS user2_id, 
		RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
	FROM Relations AS r1, Relations AS r2
	WHERE r1.user_id < r2.user_id AND r1.follower_id = r2.follower_id
	GROUP BY r1.user_id, r2.user_id
) AS r
WHERE r.rnk = 1
ORDER BY r.user1_id, r.user2_id;


# Problem 3140
DROP TABLE IF EXISTS Cinema;
CREATE TABLE IF NOT EXISTS Cinema (
    seat_id INT,
    free BOOLEAN
);
INSERT INTO Cinema (seat_id, free) VALUES ('1', '1');
INSERT INTO Cinema (seat_id, free) VALUES ('2', '0');
INSERT INTO Cinema (seat_id, free) VALUES ('3', '1');
INSERT INTO Cinema (seat_id, free) VALUES ('4', '1');
INSERT INTO Cinema (seat_id, free) VALUES ('5', '1');


# Problem 1532
DROP TABLE IF EXISTS Customers;
CREATE TABLE IF NOT EXISTS Customers (customer_id INT, name VARCHAR(10));
INSERT INTO Customers (customer_id, name) VALUES ('1', 'Winston');
INSERT INTO Customers (customer_id, name) VALUES ('2', 'Jonathan');
INSERT INTO Customers (customer_id, name) VALUES ('3', 'Annabelle');
INSERT INTO Customers (customer_id, name) VALUES ('4', 'Marwan');
INSERT INTO Customers (customer_id, name) VALUES ('5', 'Khaled');

DROP TABLE IF EXISTS Orders;
CREATE TABLE IF NOT EXISTS Orders (order_id INT, order_date DATE, customer_id INT, cost INT);
INSERT INTO Orders (order_id, order_date, customer_id, cost) VALUES ('1', '2020-07-31', '1', '30');
INSERT INTO Orders (order_id, order_date, customer_id, cost) VALUES ('2', '2020-07-30', '2', '40');
INSERT INTO Orders (order_id, order_date, customer_id, cost) VALUES ('3', '2020-07-31', '3', '70');
INSERT INTO Orders (order_id, order_date, customer_id, cost) VALUES ('4', '2020-07-29', '4', '100');
INSERT INTO Orders (order_id, order_date, customer_id, cost) VALUES ('5', '2020-06-10', '1', '1010');
INSERT INTO Orders (order_id, order_date, customer_id, cost) VALUES ('6', '2020-08-01', '2', '102');
INSERT INTO Orders (order_id, order_date, customer_id, cost) VALUES ('7', '2020-08-01', '3', '111');
INSERT INTO Orders (order_id, order_date, customer_id, cost) VALUES ('8', '2020-08-03', '1', '99');
INSERT INTO Orders (order_id, order_date, customer_id, cost) VALUES ('9', '2020-08-07', '2', '32');
INSERT INTO Orders (order_id, order_date, customer_id, cost) VALUES ('10', '2020-07-15', '1', '2');


SELECT r.name AS customer_name, r.customer_id, r.order_id, r.order_date FROM (
	SELECT c.customer_id, c.name, o.order_id, o.order_date,
		RANK() OVER (PARTITION BY c.customer_id, c.name ORDER BY o.order_date DESC) AS rnk
	FROM Customers AS c
	INNER JOIN Orders AS o
	ON c.customer_id=o.customer_id
) AS r
WHERE r.rnk <= 3
ORDER BY r.name ASC, r.customer_id ASC, r.order_date DESC;


# Problem 1875
DROP TABLE IF EXISTS Employees;
CREATE TABLE IF NOT EXISTS Employees (employee_id INT, name VARCHAR(30), salary INT);
INSERT INTO Employees (employee_id, name, salary) VALUES ('2', 'Meir', '3000');
INSERT INTO Employees (employee_id, name, salary) VALUES ('3', 'Michael', '3000');
INSERT INTO Employees (employee_id, name, salary) VALUES ('7', 'Addilyn', '7400');
INSERT INTO Employees (employee_id, name, salary) VALUES ('8', 'Juan', '6100');
INSERT INTO Employees (employee_id, name, salary) VALUES ('9', 'Kannon', '7400');

SELECT e.employee_id, e.name, e.salary, r.team_id FROM Employees AS e
INNER JOIN (
	SELECT salary,  
		ROW_NUMBER() OVER (ORDER BY salary ASC) AS team_id
	FROM Employees
	GROUP BY salary
	HAVING COUNT(*) > 1
) AS r
ON e.salary=r.salary
ORDER BY r.team_id ASC, e.employee_id ASC;


# Problem 2854
DROP TABLE IF EXISTS Steps;
CREATE TABLE IF NOT EXISTS Steps(user_id INT, steps_count INT, steps_date DATE);
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('1', '687', '2021-09-02');
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('1', '395', '2021-09-04');
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('1', '499', '2021-09-05');
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('1', '712', '2021-09-06');
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('1', '576', '2021-09-07');
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('2', '153', '2021-09-06');
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('2', '171', '2021-09-07');
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('2', '530', '2021-09-08');
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('3', '945', '2021-09-04');
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('3', '120', '2021-09-07');
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('3', '557', '2021-09-08');
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('3', '840', '2021-09-09');
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('3', '627', '2021-09-10');
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('5', '382', '2021-09-05');
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('6', '480', '2021-09-01');
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('6', '191', '2021-09-02');
INSERT INTO Steps (user_id, steps_count, steps_date) VALUES ('6', '303', '2021-09-05');


SELECT r.user_id, r.steps_date, r.rolling_average FROM (
	SELECT *,
		ROUND(AVG(steps_count) OVER (PARTITION BY user_id ORDER BY steps_date ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_average,
		LAG(steps_date, 2) OVER(PARTITION BY user_id ORDER BY steps_date ASC) AS two_rows_before
	FROM Steps
) AS r
WHERE DATEDIFF(r.steps_date, r.two_rows_before) = 2
ORDER BY r.user_id, r.steps_date;


# Problem 2159
DROP TABLE IF EXISTS Data;
CREATE TABLE IF NOT EXISTS Data (first_col INT, second_col INT);
INSERT INTO Data (first_col, second_col) VALUES ('4', '2');
INSERT INTO Data (first_col, second_col) VALUES ('2', '3');
INSERT INTO Data (first_col, second_col) VALUES ('3', '1');
INSERT INTO Data (first_col, second_col) VALUES ('1', '4');

SELECT d1.first_col, d2.second_col FROM (
	SELECT first_col, ROW_NUMBER() OVER (ORDER BY first_col ASC) AS rnum1 FROM Data
) AS d1
INNER JOIN (
	SELECT second_col, ROW_NUMBER() OVER (ORDER BY second_col DESC) AS rnum2 FROM Data
) AS d2
ON d1.rnum1=d2.rnum2;


# Problem 2175
DROP TABLE IF EXISTS TeamPoints;
CREATE TABLE IF NOT EXISTS TeamPoints (team_id INT, name VARCHAR(100), points INT);
INSERT INTO TeamPoints (team_id, name, points) VALUES ('3', 'Algeria', '1431');
INSERT INTO TeamPoints (team_id, name, points) VALUES ('1', 'Senegal', '2132');
INSERT INTO TeamPoints (team_id, name, points) VALUES ('2', 'New Zealand', '1402');
INSERT INTO TeamPoints (team_id, name, points) VALUES ('4', 'Croatia', '1817');

DROP TABLE IF EXISTS PointsChange;
CREATE TABLE IF NOT EXISTS PointsChange (team_id INT, points_change INT);
INSERT INTO PointsChange (team_id, points_change) VALUES ('3', '399');
INSERT INTO PointsChange (team_id, points_change) VALUES ('2', '0');
INSERT INTO PointsChange (team_id, points_change) VALUES ('4', '13');
INSERT INTO PointsChange (team_id, points_change) VALUES ('1', '-22');

SELECT tp.team_id, tp.name,
	CAST(ROW_NUMBER() OVER (ORDER BY tp.points DESC, tp.name ASC) AS SIGNED) - 
    CAST(ROW_NUMBER() OVER (ORDER BY tp.points+pc.points_change DESC, tp.name ASC) AS SIGNED) AS rank_diff
FROM TeamPoints AS tp
LEFT JOIN PointsChange AS pc
USING (team_id);

WITH totalpointchangetable AS (
	SELECT tp.team_id,
		SUM(points_change) AS total_points_change,
        ROW_NUMBER() OVER (ORDER BY SUM(tp.points) DESC) AS old_rank
	FROM TeamPoints AS tp
	INNER JOIN PointsChange AS pc
	USING (team_id)
	GROUP BY tp.team_id, tp.name
)

SELECT tp.team_id, tp.name,
	CAST(tpct.old_rank AS SIGNED) - CAST(ROW_NUMBER() OVER (ORDER BY tp.points+tpct.total_points_change DESC, tp.name ASC) AS SIGNED) AS rank_diff
FROM TeamPoints AS tp
INNER JOIN totalpointchangetable AS tpct
USING (team_id);


# Problem 2175
DROP TABLE IF EXISTS Student;
CREATE TABLE IF NOT EXISTS Student (student_id INT, student_name VARCHAR(45), gender VARCHAR(6), dept_id INT);
INSERT INTO Student (student_id, student_name, gender, dept_id) VALUES ('1', 'Jack', 'M', '1');
INSERT INTO Student (student_id, student_name, gender, dept_id) VALUES ('2', 'Jane', 'F', '1');
INSERT INTO Student (student_id, student_name, gender, dept_id) VALUES ('3', 'Mark', 'M', '2');

DROP TABLE IF EXISTS Department;
CREATE TABLE IF NOT EXISTS Department (dept_id INT, dept_name VARCHAR(255));
INSERT INTO Department (dept_id, dept_name) VALUES ('1', 'Engineering');
INSERT INTO Department (dept_id, dept_name) VALUES ('2', 'Science');
INSERT INTO Department (dept_id, dept_name) VALUES ('3', 'Law');

SELECT * FROM (
	SELECT d.dept_name,
		IFNULL(COUNT(student_id), 0) AS student_number
	FROM Department AS d
	LEFT JOIN Student AS s
	USING (dept_id)
	GROUP BY d.dept_name
) AS r
ORDER BY r.student_number DESC, r.dept_name ASC;


SELECT * FROM (
	SELECT dept_name,
		SUM(
			CASE 
				WHEN student_id THEN 1
				ElSE 0
			END
		) AS student_number
	FROM Department
	LEFT JOIN Student AS s
	USING (dept_id)
	GROUP BY dept_name
) AS r
ORDER BY r.student_number DESC, r.dept_name ASC;


# Problem 1468
DROP TABLE IF EXISTS Salaries;
CREATE TABLE IF NOT EXISTS Salaries (company_id INT, employee_id INT, employee_name VARCHAR(13), salary INT);
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES ('1', '1', 'Tony', '2000');
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES ('1', '2', 'Pronub', '21300');
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES ('1', '3', 'Tyrrox', '10800');
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES ('2', '1', 'Pam', '300');
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES ('2', '7', 'Bassem', '450');
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES ('2', '9', 'Hermione', '700');
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES ('3', '7', 'Bocaben', '100');
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES ('3', '2', 'Ognjen', '2200');
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES ('3', '13', 'Nyancat', '3300');
INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES ('3', '15', 'Morninngcat', '7777');

WITH taxtable AS (
	SELECT company_id,
	CASE 
		WHEN MAX(salary)<1000 THEN 1
        WHEN MAX(salary)>=1000 AND MAX(salary)<=10000 THEN 0.76
        WHEN MAX(salary)>10000 THEN 0.51
    END AS tax
	FROM Salaries
	GROUP BY company_id
) 
SELECT s.company_id, s.employee_id, s.employee_name,
	ROUND(s.salary*t.tax, 0) AS salary
FROM Salaries AS s
INNER JOIN taxtable As t
USING (company_id);


# Problem 2112
DROP TABLE IF EXISTS Flights;
CREATE TABLE IF NOT EXISTS Flights (departure_airport INT, arrival_airport INT, flights_count INT);
INSERT INTO Flights (departure_airport, arrival_airport, flights_count) VALUES ('1', '2', '4');
INSERT INTO Flights (departure_airport, arrival_airport, flights_count) VALUES ('2', '1', '5');
INSERT INTO Flights (departure_airport, arrival_airport, flights_count) VALUES ('2', '4', '5');

WITH traffictable AS (
	SELECT departure_airport AS airport_id, flights_count FROM Flights
	UNION ALL 
	SELECT arrival_airport AS airport_id, flights_count FROM Flights
)
SELECT r.airport_id FROM (
	SELECT airport_id,
		RANK() OVER (ORDER BY SUM(flights_count) DESC) AS rnk
	FROM traffictable
	GROUP BY airport_id
) AS r
WHERE r.rnk=1;


# Problem 1867
DROP TABLE IF EXISTS OrdersDetails;
CREATE TABLE IF NOT EXISTS OrdersDetails (order_id INT, product_id INT, quantity INT);
INSERT INTO OrdersDetails (order_id, product_id, quantity) VALUES ('1', '1', '12');
INSERT INTO OrdersDetails (order_id, product_id, quantity) VALUES ('1', '2', '10');
INSERT INTO OrdersDetails (order_id, product_id, quantity) VALUES ('1', '3', '15');
INSERT INTO OrdersDetails (order_id, product_id, quantity) VALUES ('2', '1', '8');
INSERT INTO OrdersDetails (order_id, product_id, quantity) VALUES ('2', '4', '4');
INSERT INTO OrdersDetails (order_id, product_id, quantity) VALUES ('2', '5', '6');
INSERT INTO OrdersDetails (order_id, product_id, quantity) VALUES ('3', '3', '5');
INSERT INTO OrdersDetails (order_id, product_id, quantity) VALUES ('3', '4', '18');
INSERT INTO OrdersDetails (order_id, product_id, quantity) VALUES ('4', '5', '2');
INSERT INTO OrdersDetails (order_id, product_id, quantity) VALUES ('4', '6', '8');
INSERT INTO OrdersDetails (order_id, product_id, quantity) VALUES ('5', '7', '9');
INSERT INTO OrdersDetails (order_id, product_id, quantity) VALUES ('5', '8', '9');
INSERT INTO OrdersDetails (order_id, product_id, quantity) VALUES ('3', '9', '20');
INSERT INTO OrdersDetails (order_id, product_id, quantity) VALUES ('2', '9', '4');


SELECT order_id
FROM OrdersDetails
GROUP BY order_id
HAVING MAX(quantity) > (
	SELECT MAX(r.average_quantity) AS max_average_quantity FROM (
		SELECT
			SUM(quantity)/COUNT(product_id) AS average_quantity
		FROM OrdersDetails
		GROUP BY order_id
	) AS r
);


# Problem 3103
DROP TABLE IF EXISTS TWEETS;
CREATE TABLE IF NOT EXISTS TWEETS (USER_ID INT, TWEET_ID INT, TWEET VARCHAR(100), TWEET_DATE DATE);
INSERT INTO TWEETS (USER_ID, TWEET_ID, TWEET, TWEET_DATE) VALUES ('135', '13', 'Enjoying a great start to the day. #HappyDay #MorningVibes', '2024-02-01');
INSERT INTO TWEETS (USER_ID, TWEET_ID, TWEET, TWEET_DATE) VALUES ('136', '14', 'Another #HappyDay with good vibes! #FeelGood', '2024-02-03');
INSERT INTO TWEETS (USER_ID, TWEET_ID, TWEET, TWEET_DATE) VALUES ('137', '15', 'Productivity peaks! #WorkLife #ProductiveDay', '2024-02-04');
INSERT INTO TWEETS (USER_ID, TWEET_ID, TWEET, TWEET_DATE) VALUES ('138', '16', 'Exploring new tech frontiers. #TechLife #Innovation', '2024-02-04');
INSERT INTO TWEETS (USER_ID, TWEET_ID, TWEET, TWEET_DATE) VALUES ('139', '17', 'Gratitude for today moments. #HappyDay #Thankful', '2024-02-05');
INSERT INTO TWEETS (USER_ID, TWEET_ID, TWEET, TWEET_DATE) VALUES ('140', '18', 'Innovation drives us. #TechLife #FutureTech', '2024-02-07');
INSERT INTO TWEETS (USER_ID, TWEET_ID, TWEET, TWEET_DATE) VALUES ('141', '19', 'Connecting with nature serenity. #Nature #Peaceful', '2024-02-09');


WITH RECURSIVE t1 AS (
		SELECT 
			SUBSTRING_INDEX(SUBSTRING_INDEX(tweet, "#", -1), " ", 1) AS tag,
			SUBSTRING(tweet, 1, LENGTH(tweet)-LOCATE("#", REVERSE(tweet))) AS remain
		FROM Tweets
        WHERE YEAR(tweet_date)=2024 AND MONTH(tweet_date)=2
        UNION ALL
        SELECT 
			SUBSTRING_INDEX(SUBSTRING_INDEX(remain, "#", -1), " ", 1) AS tag,
            SUBSTRING(remain, 1, LENGTH(remain)-LOCATE("#", REVERSE(remain))) AS remain
		FROM t1
        WHERE LOCATE("#", remain)>0
)

SELECT 
	CONCAT("#", tag) AS hashtag,
    count
FROM (
	SELECT tag,
		RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk,
        COUNT(*) AS count
	FROM t1
	GROUP BY tag
) AS r
ORDER BY r.rnk ASC, r.tag DESC LIMIT 3;


# Problem 1988
DROP TABLE IF EXISTS SCHOOLS;
CREATE TABLE IF NOT EXISTS SCHOOLS (SCHOOL_ID INT, CAPACITY INT);
INSERT INTO SCHOOLS (SCHOOL_ID, CAPACITY) VALUES ('11', '151');
INSERT INTO SCHOOLS (SCHOOL_ID, CAPACITY) VALUES ('5', '48');
INSERT INTO SCHOOLS (SCHOOL_ID, CAPACITY) VALUES ('9', '9');
INSERT INTO SCHOOLS (SCHOOL_ID, CAPACITY) VALUES ('10', '99');

DROP TABLE IF EXISTS EXAM;
CREATE TABLE IF NOT EXISTS EXAM (SCORE INT, STUDENT_COUNT INT);
INSERT INTO EXAM (SCORE, STUDENT_COUNT) VALUES ('975', '10');
INSERT INTO EXAM (SCORE, STUDENT_COUNT) VALUES ('966', '60');
INSERT INTO EXAM (SCORE, STUDENT_COUNT) VALUES ('844', '76');
INSERT INTO EXAM (SCORE, STUDENT_COUNT) VALUES ('749', '76');
INSERT INTO EXAM (SCORE, STUDENT_COUNT) VALUES ('744', '100');

SELECT s.school_id,
	IFNULL(MIN(e.score), -1) AS score
FROM Schools s
LEFT JOIN Exam e
ON s.capacity>=e.student_count
GROUP BY school_id;


# Problem 1651
DROP TABLE IF EXISTS Drivers;
CREATE TABLE IF NOT EXISTS Drivers (driver_id INT, join_date DATE);
INSERT INTO Drivers (driver_id, join_date) VALUES ('10', '2019-12-10');
INSERT INTO Drivers (driver_id, join_date) VALUES ('8', '2020-01-13');
INSERT INTO Drivers (driver_id, join_date) VALUES ('5', '2020-02-16');
INSERT INTO Drivers (driver_id, join_date) VALUES ('7', '2020-03-08');
INSERT INTO Drivers (driver_id, join_date) VALUES ('4', '2020-05-17');
INSERT INTO Drivers (driver_id, join_date) VALUES ('1', '2020-10-24');
INSERT INTO Drivers (driver_id, join_date) VALUES ('6', '2021-01-05');

DROP TABLE IF EXISTS Rides;
CREATE TABLE IF NOT EXISTS Rides (ride_id INT, user_id INT, requested_at DATE);
INSERT INTO Rides (ride_id, user_id, requested_at) VALUES ('6', '75', '2019-12-09');
INSERT INTO Rides (ride_id, user_id, requested_at) VALUES ('1', '54', '2020-02-09');
INSERT INTO Rides (ride_id, user_id, requested_at) VALUES ('10', '63', '2020-03-04');
INSERT INTO Rides (ride_id, user_id, requested_at) VALUES ('19', '39', '2020-04-06');
INSERT INTO Rides (ride_id, user_id, requested_at) VALUES ('3', '41', '2020-06-03');
INSERT INTO Rides (ride_id, user_id, requested_at) VALUES ('13', '52', '2020-06-22');
INSERT INTO Rides (ride_id, user_id, requested_at) VALUES ('7', '69', '2020-07-16');
INSERT INTO Rides (ride_id, user_id, requested_at) VALUES ('17', '70', '2020-08-25');
INSERT INTO Rides (ride_id, user_id, requested_at) VALUES ('20', '81', '2020-11-02');
INSERT INTO Rides (ride_id, user_id, requested_at) VALUES ('5', '57', '2020-11-09');
INSERT INTO Rides (ride_id, user_id, requested_at) VALUES ('2', '42', '2020-12-09');
INSERT INTO Rides (ride_id, user_id, requested_at) VALUES ('11', '68', '2021-01-11');
INSERT INTO Rides (ride_id, user_id, requested_at) VALUES ('15', '32', '2021-01-17');
INSERT INTO Rides (ride_id, user_id, requested_at) VALUES ('12', '11', '2021-01-19');
INSERT INTO Rides (ride_id, user_id, requested_at) VALUES ('14', '18', '2021-01-27');

DROP TABLE IF EXISTS AcceptedRides;
CREATE TABLE IF NOT EXISTS AcceptedRides (ride_id INT, driver_id INT, ride_distance INT, ride_duration INT);
INSERT INTO AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) VALUES ('10', '10', '63', '38');
INSERT INTO AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) VALUES ('13', '10', '73', '96');
INSERT INTO AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) VALUES ('7', '8', '100', '28');
INSERT INTO AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) VALUES ('17', '7', '119', '68');
INSERT INTO AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) VALUES ('20', '1', '121', '92');
INSERT INTO AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) VALUES ('5', '7', '42', '101');
INSERT INTO AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) VALUES ('2', '4', '6', '38');
INSERT INTO AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) VALUES ('11', '8', '37', '43');
INSERT INTO AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) VALUES ('15', '8', '108', '82');
INSERT INTO AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) VALUES ('12', '8', '38', '34');
INSERT INTO AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) VALUES ('14', '1', '90', '74');


WITH RECURSIVE t1 AS (
	SELECT 
		1 AS sm,
        3 AS em
	UNION ALL
	SELECT
		sm+1 AS sm,
        em+1 AS em
	FROM t1
    WHERE em<12
)
SELECT sm AS month,
	ROUND(IFNULL(SUM(ride_distance), 0) / 3, 2) AS average_ride_distance,
    ROUND(IFNULL(SUM(ride_duration), 0) / 3, 2) AS average_ride_duration
FROM (
	SELECT * FROM Rides r
	INNER JOIN AcceptedRides ar
	USING (ride_id)
	WHERE YEAR(r.requested_at)=2020
) AS r
RIGHT JOIN t1
ON t1.sm <= MONTH(r.requested_at) AND MONTH(r.requested_at) <= t1.em
GROUP BY t1.sm, t1.em
ORDER BY t1.sm ASC;


# Problem 2893
DROP TABLE IF EXISTS Orders;
CREATE TABLE IF NOT EXISTS Orders (minute INT, order_count INT);
INSERT INTO Orders (minute, order_count) VALUES ('1', '0');
INSERT INTO Orders (minute, order_count) VALUES ('2', '2');
INSERT INTO Orders (minute, order_count) VALUES ('3', '4');
INSERT INTO Orders (minute, order_count) VALUES ('4', '6');
INSERT INTO Orders (minute, order_count) VALUES ('5', '1');
INSERT INTO Orders (minute, order_count) VALUES ('6', '4');
INSERT INTO Orders (minute, order_count) VALUES ('7', '1');
INSERT INTO Orders (minute, order_count) VALUES ('8', '2');
INSERT INTO Orders (minute, order_count) VALUES ('9', '4');
INSERT INTO Orders (minute, order_count) VALUES ('10', '1');
INSERT INTO Orders (minute, order_count) VALUES ('11', '4');
INSERT INTO Orders (minute, order_count) VALUES ('12', '6');


WITH RECURSIVE t1 AS (
	SELECT 0 AS inx
    UNION ALL
    SELECT inx+1 AS inx
    FROM t1
    WHERE inx<(SELECT MAX(minute)/6 FROM Orders)
)
SELECT t.inx+1 AS interval_no,
	SUM(order_count) AS total_orders
FROM t1 t
INNER JOIN Orders o
ON FLOOR((minute-1) / 6) = t.inx
GROUP BY t.inx
ORDER BY t.inx ASC;

SELECT r.interval_no, SUM(r.order_count) AS total_orders FROM (
	SELECT *,
		IF(minute % 6 != 0, minute DIV 6 + 1, minute DIV 6) AS interval_no
	FROM Orders
) AS r
GROUP BY r.interval_no
ORDER BY r.interval_no ASC;


# Problem 1126
DROP TABLE IF EXISTS Events;
CREATE TABLE IF NOT EXISTS Events (business_id INT, event_type VARCHAR(10), occurrences INT);
INSERT INTO Events (business_id, event_type, occurrences) VALUES ('1', 'reviews', '7');
INSERT INTO Events (business_id, event_type, occurrences) VALUES ('3', 'reviews', '3');
INSERT INTO Events (business_id, event_type, occurrences) VALUES ('1', 'ads', '11');
INSERT INTO Events (business_id, event_type, occurrences) VALUES ('2', 'ads', '7');
INSERT INTO Events (business_id, event_type, occurrences) VALUES ('3', 'ads', '6');
INSERT INTO Events (business_id, event_type, occurrences) VALUES ('1', 'page views', '3');
INSERT INTO Events (business_id, event_type, occurrences) VALUES ('2', 'page views', '12');

SELECT e.business_id FROM Events e
INNER JOIN (
	SELECT event_type, AVG(occurrences) AS avg_occ FROM Events
	GROUP BY event_type
) r
USING (event_type)
WHERE e.occurrences>r.avg_occ
GROUP BY business_id
HAVING COUNT(*)>1;


# Problem 2324
DROP TABLE IF EXISTS Sales;
CREATE TABLE IF NOT EXISTS Sales (sale_id INT, product_id INT, user_id INT, quantity INT);
INSERT INTO Sales (sale_id, product_id, user_id, quantity) VALUES ('1', '1', '101', '10');
INSERT INTO Sales (sale_id, product_id, user_id, quantity) VALUES ('2', '3', '101', '7');
INSERT INTO Sales (sale_id, product_id, user_id, quantity) VALUES ('3', '1', '102', '9');
INSERT INTO Sales (sale_id, product_id, user_id, quantity) VALUES ('4', '2', '102', '6');
INSERT INTO Sales (sale_id, product_id, user_id, quantity) VALUES ('5', '3', '102', '10');
INSERT INTO Sales (sale_id, product_id, user_id, quantity) VALUES ('6', '1', '102', '6');

DROP TABLE IF EXISTS Product;
CREATE TABLE IF NOT EXISTS Product (product_id INT, price INT);
INSERT INTO Product (product_id, price) VALUES ('1', '10');
INSERT INTO Product (product_id, price) VALUES ('2', '25');
INSERT INTO Product (product_id, price) VALUES ('3', '15');


SELECT r.user_id, r.product_id FROM (
	SELECT s.user_id, p.product_id,
		RANK() OVER (PARTITION BY s.user_id ORDER BY SUM(s.quantity*p.price) DESC) AS rnk
	FROM Sales s
	INNER JOIN Product p
	ON s.product_id=p.product_id
	GROUP BY s.user_id, p.product_id
) AS r
WHERE r.rnk=1;


# Problem 1709
DROP TABLE IF EXISTS UserVisits;
CREATE TABLE IF NOT EXISTS UserVisits (user_id INT, visit_date DATE);
INSERT INTO UserVisits (user_id, visit_date) VALUES ('1', '2020-11-28');
INSERT INTO UserVisits (user_id, visit_date) VALUES ('1', '2020-10-20');
INSERT INTO UserVisits (user_id, visit_date) VALUES ('1', '2020-12-03');
INSERT INTO UserVisits (user_id, visit_date) VALUES ('2', '2020-10-05');
INSERT INTO UserVisits (user_id, visit_date) VALUES ('2', '2020-12-09');
INSERT INTO UserVisits (user_id, visit_date) VALUES ('3', '2020-11-11');


SELECT r.user_id, MAX(r.window_len) AS biggest_window FROM (
	SELECT *,
		DATEDIFF(LEAD(visit_date, 1, '2021-1-1') OVER (PARTITION BY user_id ORDER BY visit_date ASC), visit_date) AS window_len
	FROM UserVisits
) AS r
GROUP BY r.user_id;


# Problem 3050
DROP TABLE IF EXISTS Toppings;
CREATE TABLE IF NOT EXISTS Toppings (topping_name VARCHAR(100), cost DECIMAL(5,2));
INSERT INTO Toppings (topping_name, cost) VALUES ('Pepperoni', '0.5');
INSERT INTO Toppings (topping_name, cost) VALUES ('Sausage', '0.7');
INSERT INTO Toppings (topping_name, cost) VALUES ('Chicken', '0.55');
INSERT INTO Toppings (topping_name, cost) VALUES ('Extra Cheese', '0.4');

SELECT * FROM (
	SELECT
		CONCAT(t1.topping_name, ",", t2.topping_name, ",", t3.topping_name) AS pizza,
		SUM(t1.cost+t2.cost+t3.cost) AS total_cost 
	FROM Toppings AS t1, Toppings AS t2, Toppings AS t3
	WHERE t1.topping_name<t2.topping_name AND t2.topping_name<t3.topping_name
	GROUP BY t1.topping_name, t2.topping_name, t3.topping_name
) r
ORDER BY r.total_cost DESC, r.pizza ASC; 


# Problem 2686
DROP TABLE IF EXISTS Delivery;
CREATE TABLE IF NOT EXISTS Delivery (delivery_id INT, customer_id INT, order_date DATE, customer_pref_delivery_date DATE);
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES ('1', '1', '2019-08-01', '2019-08-02');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES ('2', '2', '2019-08-01', '2019-08-01');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES ('3', '1', '2019-08-01', '2019-08-01');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES ('4', '3', '2019-08-02', '2019-08-13');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES ('5', '3', '2019-08-02', '2019-08-02');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES ('6', '2', '2019-08-02', '2019-08-02');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES ('7', '4', '2019-08-03', '2019-08-03');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES ('8', '1', '2019-08-03', '2019-08-03');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES ('9', '5', '2019-08-04', '2019-08-18');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES ('10', '2', '2019-08-04', '2019-08-18');

SELECT r.order_date,
	ROUND(SUM(r.inx)/COUNT(*)*100, 2) AS immediate_percentage
FROM (
	SELECT *,
		CASE
			WHEN order_date=customer_pref_delivery_date THEN 1
			ELSE 0
		END AS inx
	FROM Delivery
) r
GROUP BY r.order_date
ORDER BY r.order_date ASC;


# Problem 2362
DROP TABLE IF EXISTS Products;
CREATE TABLE IF NOT EXISTS Products (product_id INT, price INT);
INSERT INTO Products (product_id, price) VALUES ('1', '100');
INSERT INTO Products (product_id, price) VALUES ('2', '200');

DROP TABLE IF EXISTS Purchases;
CREATE TABLE IF NOT EXISTS Purchases (invoice_id INT, product_id INT, quantity INT);
INSERT INTO Purchases (invoice_id, product_id, quantity) VALUES ('1', '1', '2');
INSERT INTO Purchases (invoice_id, product_id, quantity) VALUES ('3', '2', '1');
INSERT INTO Purchases (invoice_id, product_id, quantity) VALUES ('2', '2', '3');
INSERT INTO Purchases (invoice_id, product_id, quantity) VALUES ('2', '1', '4');
INSERT INTO Purchases (invoice_id, product_id, quantity) VALUES ('4', '1', '10');

WITH rnktable AS (
	SELECT invoice_id,
		RANK() OVER (ORDER BY SUM(price*quantity) DESC, invoice_id ASC) AS rnk
	FROM Products pr
	INNER JOIN Purchases pu
	USING (product_id)
	GROUP BY invoice_id
)

SELECT product_id, quantity,
	price*quantity AS price
FROM Products pr
INNER JOIN Purchases pu
USING (product_id)
WHERE invoice_id=(SELECT invoice_id FROM rnktable WHERE rnk=1);


# Problem 574
DROP TABLE IF EXISTS Candidate;
CREATE TABLE IF NOT EXISTS Candidate (id INT, name VARCHAR(255));
INSERT INTO Candidate (id, name) VALUES ('1', 'A');
INSERT INTO Candidate (id, name) VALUES ('2', 'B');
INSERT INTO Candidate (id, name) VALUES ('3', 'C');
INSERT INTO Candidate (id, name) VALUES ('4', 'D');
INSERT INTO Candidate (id, name) VALUES ('5', 'E');

DROP TABLE IF EXISTS Vote;
CREATE TABLE IF NOT EXISTS Vote (id INT, candidateId INT);
INSERT INTO Vote (id, candidateId) VALUES ('1', '2');
INSERT INTO Vote (id, candidateId) VALUES ('2', '4');
INSERT INTO Vote (id, candidateId) VALUES ('3', '3');
INSERT INTO Vote (id, candidateId) VALUES ('4', '2');
INSERT INTO Vote (id, candidateId) VALUES ('5', '5');

SELECT c.name FROM (
	SELECT candidateId,
		COUNT(*) AS cnt
	FROM Vote
	GROUP BY candidateId
) AS r
INNER JOIN Candidate c
ON r.candidateId=c.id
ORDER BY r.cnt DESC LIMIT 1;


# Problem 3118
DROP TABLE IF EXISTS Purchases;
CREATE TABLE IF NOT EXISTS Purchases (user_id INT, purchase_date DATE, amount_spend INT);
INSERT INTO Purchases (user_id, purchase_date, amount_spend) VALUES ('11', '2023-11-03', '1126');
INSERT INTO Purchases (user_id, purchase_date, amount_spend) VALUES ('15', '2023-11-10', '7473');
INSERT INTO Purchases (user_id, purchase_date, amount_spend) VALUES ('17', '2023-11-17', '2414');
INSERT INTO Purchases (user_id, purchase_date, amount_spend) VALUES ('12', '2023-11-24', '9692');
INSERT INTO Purchases (user_id, purchase_date, amount_spend) VALUES ('8', '2023-11-24', '5117');
INSERT INTO Purchases (user_id, purchase_date, amount_spend) VALUES ('1', '2023-11-24', '5241');
INSERT INTO Purchases (user_id, purchase_date, amount_spend) VALUES ('10', '2023-11-22', '8266');
INSERT INTO Purchases (user_id, purchase_date, amount_spend) VALUES ('13', '2023-11-21', '12000');

DROP TABLE IF EXISTS Users;
CREATE TABLE IF NOT EXISTS Users (user_id INT, membership ENUM('Standard', 'Premium', 'VIP'));
INSERT INTO Users (user_id, membership) VALUES ('11', 'Premium');
INSERT INTO Users (user_id, membership) VALUES ('15', 'VIP');
INSERT INTO Users (user_id, membership) VALUES ('17', 'Standard');
INSERT INTO Users (user_id, membership) VALUES ('12', 'VIP');
INSERT INTO Users (user_id, membership) VALUES ('8', 'Premium');
INSERT INTO Users (user_id, membership) VALUES ('1', 'VIP');
INSERT INTO Users (user_id, membership) VALUES ('10', 'Standard');
INSERT INTO Users (user_id, membership) VALUES ('13', 'Premium');

WITH RECURSIVE predefinetable AS (
	SELECT 1 AS week_of_month
    UNION ALL
    SELECT week_of_month+1 AS week_of_moth FROM predefinetable
    WHERE week_of_month<4
)

SELECT inx_table.week_of_month, inx_table.membership,
	IFNULL(amount_table.total_amount, 0) AS total_amount
FROM (
	SELECT * FROM predefinetable p
	CROSS JOIN
		( 
		 SELECT "Premium" AS membership
         UNION ALL
		 SELECT "VIP" membership
	) membership_table
) inx_table
LEFT JOIN (
	SELECT wom_table.week_of_month, wom_table.membership,
	 SUM(amount_spend) AS total_amount
	FROM (
		SELECT *,
			WEEK(purchase_date, 5) - WEEK('2023-11-1') + 1 AS week_of_month
		FROM Purchases
		INNER JOIN Users
		USING (user_id)
		WHERE DAYOFWEEK(purchase_date)=6 AND membership != "Standard" AND YEAR(purchase_date)=2023 AND MONTH(purchase_date)=11
	) wom_table
	GROUP BY wom_table.week_of_month, wom_table.membership
) amount_table
ON inx_table.week_of_month=amount_table.week_of_month AND inx_table.membership=amount_table.membership
ORDER BY inx_table.week_of_month, inx_table.membership ASC


WITH RECURSIVE weeks AS (
    SELECT 1 AS week_of_month
    UNION ALL
    SELECT week_of_month + 1 FROM weeks
    WHERE week_of_month < 4
),
membership_types AS (
    SELECT 'Premium' AS membership
    UNION ALL
    SELECT 'VIP' AS membership
),
all_combinations AS (
    SELECT w.week_of_month, m.membership
    FROM weeks w
    CROSS JOIN membership_types m
),
purchase_summary AS (
    SELECT 
        WEEK(p.purchase_date, 5) - WEEK('2023-11-1') + 1 AS week_of_month,
        u.membership,
        SUM(p.amount_spend) AS total_amount
    FROM Purchases p
    INNER JOIN Users u ON p.user_id = u.user_id
    WHERE 
        DAYOFWEEK(p.purchase_date) = 6 
        AND u.membership != 'Standard'
        AND YEAR(p.purchase_date) = 2023 
        AND MONTH(p.purchase_date) = 11
    GROUP BY week_of_month, u.membership
)
SELECT 
    a.week_of_month, 
    a.membership,
    IFNULL(ps.total_amount, 0) AS total_amount
FROM 
    all_combinations a
LEFT JOIN 
    purchase_summary ps
ON 
    a.week_of_month = ps.week_of_month 
    AND a.membership = ps.membership
ORDER BY 
    a.week_of_month, 
    a.membership ASC;
    
    
# Problem 1934
DROP TABLE IF EXISTS Signups;
CREATE TABLE IF NOT EXISTS Signups (user_id INT, time_stamp DATETIME);
INSERT INTO Signups (user_id, time_stamp) VALUES ('3', '2020-03-21 10:16:13');
INSERT INTO Signups (user_id, time_stamp) VALUES ('7', '2020-01-04 13:57:59');
INSERT INTO Signups (user_id, time_stamp) VALUES ('2', '2020-07-29 23:09:44');
INSERT INTO Signups (user_id, time_stamp) VALUES ('6', '2020-12-09 10:39:37');

DROP TABLE IF EXISTS Confirmations;
CREATE TABLE IF NOT EXISTS Confirmations (user_id INT, time_stamp DATETIME, action ENUM('confirmed', 'timeout'));
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES ('3', '2021-01-06 03:30:46', 'timeout');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES ('3', '2021-07-14 14:00:00', 'timeout');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES ('7', '2021-06-12 11:57:29', 'confirmed');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES ('7', '2021-06-13 12:58:28', 'confirmed');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES ('7', '2021-06-14 13:59:27', 'confirmed');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES ('2', '2021-01-22 00:00:00', 'confirmed');
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES ('2', '2021-02-28 23:59:59', 'timeout');


SELECT s.user_id,
	ROUND(SUM(IFNULL(c.inx, 0)) / COUNT(s.user_id), 2) AS confirmation_rate
FROM Signups s
LEFT JOIN (
	SELECT *,
		IF (action="confirmed", 1, 0) AS inx
    FROM Confirmations
) c
USING (user_id) 
GROUP BY s.user_id;


# Problem 2041
DROP TABLE IF EXISTS Candidates;
CREATE TABLE IF NOT EXISTS Candidates (candidate_id INT, name VARCHAR(30), years_of_exp INT, interview_id INT);
INSERT INTO Candidates (candidate_id, name, years_of_exp, interview_id) VALUES ('11', 'Atticus', '1', '101');
INSERT INTO Candidates (candidate_id, name, years_of_exp, interview_id) VALUES ('9', 'Ruben', '6', '104');
INSERT INTO Candidates (candidate_id, name, years_of_exp, interview_id) VALUES ('6', 'Aliza', '10', '109');
INSERT INTO Candidates (candidate_id, name, years_of_exp, interview_id) VALUES ('8', 'Alfredo', '0', '107');

DROP TABLE IF EXISTS Rounds;
CREATE TABLE IF NOT EXISTS Rounds (interview_id INT, round_id INT, score INT);
INSERT INTO Rounds (interview_id, round_id, score) VALUES ('109', '3', '4');
INSERT INTO Rounds (interview_id, round_id, score) VALUES ('101', '2', '8');
INSERT INTO Rounds (interview_id, round_id, score) VALUES ('109', '4', '1');
INSERT INTO Rounds (interview_id, round_id, score) VALUES ('107', '1', '3');
INSERT INTO Rounds (interview_id, round_id, score) VALUES ('104', '3', '6');
INSERT INTO Rounds (interview_id, round_id, score) VALUES ('109', '1', '4');
INSERT INTO Rounds (interview_id, round_id, score) VALUES ('104', '4', '7');
INSERT INTO Rounds (interview_id, round_id, score) VALUES ('104', '1', '2');
INSERT INTO Rounds (interview_id, round_id, score) VALUES ('109', '2', '1');
INSERT INTO Rounds (interview_id, round_id, score) VALUES ('104', '2', '7');
INSERT INTO Rounds (interview_id, round_id, score) VALUES ('107', '2', '3');
INSERT INTO Rounds (interview_id, round_id, score) VALUES ('101', '1', '8');

SELECT c.candidate_id
FROM Candidates c
INNER JOIN Rounds as r
USING (interview_id)
WHERE c.years_of_exp >= 2
GROUP BY c.candidate_id
HAVING SUM(score)>15;


# Problem 612
DROP TABLE IF EXISTS Point2D;
CREATE TABLE IF NOT EXISTS Point2D (x INT NOT NULL, y INT NOT NULL);
INSERT INTO Point2D (x, y) VALUES ('-1', '-1');
INSERT INTO Point2D (x, y) VALUES ('0', '0');
INSERT INTO Point2D (x, y) VALUES ('-1', '-2');

SELECT DISTINCT r.dist AS shortest FROM (
	SELECT
		ROUND(POWER(POWER((p1.x-p2.x), 2)+POWER((p1.y-p2.y),2), 0.5), 2) AS dist,
		DENSE_RANK() OVER (ORDER BY POWER(POWER((p1.x-p2.x), 2)+POWER((p1.y-p2.y),2), 0.5) ASC) AS rnk
	FROM Point2D p1
	CROSS JOIN Point2D p2
) r
WHERE r.rnk=2;

SELECT ROUND(POWER(POWER((p1.x-p2.x), 2)+POWER((p1.y-p2.y),2), 0.5), 2) AS shortest
FROM Point2D p1
CROSS JOIN Point2D p2
HAVING shortest != 0
ORDER BY shortest ASC LIMIT 1;


# Problem 178
DROP TABLE IF EXISTS Scores;
CREATE TABLE IF NOT EXISTS Scores (id INT, score DECIMAL(3,2));
INSERT INTO Scores (id, score) VALUES ('1', '3.5');
INSERT INTO Scores (id, score) VALUES ('2', '3.65');
INSERT INTO Scores (id, score) VALUES ('3', '4.0');
INSERT INTO Scores (id, score) VALUES ('4', '3.85');
INSERT INTO Scores (id, score) VALUES ('5', '4.0');
INSERT INTO Scores (id, score) VALUES ('6', '3.65');

SELECT score,
	DENSE_RANK() OVER (ORDER BY score DESC) AS "rank"
FROM Scores
ORDER BY "rank" ASC;


# Problem 1158
DROP TABLE IF EXISTS Users;
CREATE TABLE IF NOT EXISTS Users (user_id INT, join_date DATE, favorite_brand VARCHAR(10));
INSERT INTO Users (user_id, join_date, favorite_brand) VALUES ('1', '2018-01-01', 'Lenovo');
INSERT INTO Users (user_id, join_date, favorite_brand) VALUES ('2', '2018-02-09', 'Samsung');
INSERT INTO Users (user_id, join_date, favorite_brand) VALUES ('3', '2018-01-19', 'LG');
INSERT INTO Users (user_id, join_date, favorite_brand) VALUES ('4', '2018-05-21', 'HP');

DROP TABLE IF EXISTS Orders;
CREATE TABLE IF NOT EXISTS Orders (order_id INT, order_date DATE, item_id INT, buyer_id INT, seller_id INT);
INSERT INTO Orders (order_id, order_date, item_id, buyer_id, seller_id) VALUES ('1', '2019-08-01', '4', '1', '2');
INSERT INTO Orders (order_id, order_date, item_id, buyer_id, seller_id) VALUES ('2', '2018-08-02', '2', '1', '3');
INSERT INTO Orders (order_id, order_date, item_id, buyer_id, seller_id) VALUES ('3', '2019-08-03', '3', '2', '3');
INSERT INTO Orders (order_id, order_date, item_id, buyer_id, seller_id) VALUES ('4', '2018-08-04', '1', '4', '2');
INSERT INTO Orders (order_id, order_date, item_id, buyer_id, seller_id) VALUES ('5', '2018-08-04', '1', '3', '4');
INSERT INTO Orders (order_id, order_date, item_id, buyer_id, seller_id) VALUES ('6', '2019-08-05', '2', '2', '4');

DROP TABLE IF EXISTS Items;
CREATE TABLE IF NOT EXISTS Items (item_id INT, item_brand VARCHAR(10));
INSERT INTO Items (item_id, item_brand) VALUES ('1', 'Samsung');
INSERT INTO Items (item_id, item_brand) VALUES ('2', 'Lenovo');
INSERT INTO Items (item_id, item_brand) VALUES ('3', 'LG');
INSERT INTO Items (item_id, item_brand) VALUES ('4', 'HP');

SELECT u.user_id AS buyer_id, u.join_date,
	SUM(IFNULL(o.inx, 0)) AS orders_in_2019
FROM Users u
LEFT JOIN (
	SELECT *, 1 AS inx FROM Orders
    WHERE YEAR(order_date) = 2019
) o
ON u.user_id=o.buyer_id 
GROUP BY u.user_id, u.join_date;


# Problem 615
DROP TABLE IF EXISTS Salary;
CREATE TABLE IF NOT EXISTS Salary (id INT, employee_id INT, amount INT, pay_date DATE);
INSERT INTO Salary (id, employee_id, amount, pay_date) VALUES ('1', '1', '9000', '2017/03/31');
INSERT INTO Salary (id, employee_id, amount, pay_date) VALUES ('2', '2', '6000', '2017/03/31');
INSERT INTO Salary (id, employee_id, amount, pay_date) VALUES ('3', '3', '10000', '2017/03/31');
INSERT INTO Salary (id, employee_id, amount, pay_date) VALUES ('4', '1', '7000', '2017/02/28');
INSERT INTO Salary (id, employee_id, amount, pay_date) VALUES ('5', '2', '6000', '2017/02/28');
INSERT INTO Salary (id, employee_id, amount, pay_date) VALUES ('6', '3', '8000', '2017/02/28');

DROP TABLE IF EXISTS Employee;
CREATE TABLE IF NOT EXISTS Employee (employee_id INT, department_id INT);
INSERT INTO Employee (employee_id, department_id) VALUES ('1', '1');
INSERT INTO Employee (employee_id, department_id) VALUES ('2', '2');
INSERT INTO Employee (employee_id, department_id) VALUES ('3', '2');


WITH company AS (
	SELECT LEFT(pay_date, 7) AS month,
	AVG(amount) AS avg_company
	FROM Salary
	GROUP BY month
),
department AS (
SELECT LEFT(s.pay_date, 7) AS month,
	e.department_id,
    AVG(s.amount) AS avg_dep
FROM Salary s
INNER JOIN Employee e
USING (employee_id)
GROUP BY month, e.department_id 
)
SELECT c.month AS pay_month, d.department_id,
	CASE
		WHEN d.avg_dep>c.avg_company THEN "higher"
        WHEN d.avg_dep<c.avg_company THEN "lower"
        ELSE "same"
    END comparison
FROM company c
INNER JOIN department d
USING (month);


# Problem 1098
DROP TABLE IF EXISTS Books;
CREATE TABLE IF NOT EXISTS Books (book_id int, name varchar(50), available_from date);
INSERT INTO Books (book_id, name, available_from) VALUES ('1', 'Kalila And Demna', '2010-01-01');
INSERT INTO Books (book_id, name, available_from) VALUES ('2', '28 Letters', '2012-05-12');
INSERT INTO Books (book_id, name, available_from) VALUES ('3', 'The Hobbit', '2019-06-10');
INSERT INTO Books (book_id, name, available_from) VALUES ('4', '13 Reasons Why', '2019-06-01');
INSERT INTO Books (book_id, name, available_from) VALUES ('5', 'The Hunger Games', '2008-09-21');

DROP TABLE IF EXISTS Orders;
CREATE TABLE IF NOT EXISTS Orders (order_id int, book_id int, quantity int, dispatch_date date);
INSERT INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES ('1', '1', '2', '2018-07-26');
INSERT INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES ('2', '1', '1', '2018-11-05');
INSERT INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES ('3', '3', '8', '2019-06-11');
INSERT INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES ('4', '4', '6', '2019-06-05');
INSERT INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES ('5', '4', '5', '2019-06-20');
INSERT INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES ('6', '5', '9', '2009-02-02');
INSERT INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES ('7', '5', '8', '2010-04-13');


SELECT b.book_id, b.name FROM Books b
LEFT JOIN (
	SELECT b.book_id,
		SUM(o.quantity) AS total
	FROM Books b
	LEFT JOIN Orders o
	USING (book_id)
	WHERE b.available_from<'2019-05-23' AND o.dispatch_date>='2018-06-23' AND o.dispatch_date<='2019-06-23'
	GROUP BY b.book_id
) r
USING (book_id)
WHERE b.available_from<'2019-05-23' AND (r.total<10 OR r.total IS NULL);


# Problem 1113
DROP TABLE IF EXISTS Actions;
CREATE TABLE IF NOT EXISTS Actions (user_id int, post_id int, action_date date, action ENUM('view', 'like', 'reaction', 'comment', 'report', 'share'), extra varchar(10));
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('1', '1', '2019-07-01', 'view', 'None');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('1', '1', '2019-07-01', 'like', 'None');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('1', '1', '2019-07-01', 'share', 'None');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('2', '4', '2019-07-04', 'view', 'None');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('2', '4', '2019-07-04', 'report', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('3', '4', '2019-07-04', 'view', 'None');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('3', '4', '2019-07-04', 'report', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('4', '3', '2019-07-02', 'view', 'None');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('4', '3', '2019-07-02', 'report', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('5', '2', '2019-07-04', 'view', 'None');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('5', '2', '2019-07-04', 'report', 'racism');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('5', '5', '2019-07-04', 'view', 'None');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('5', '5', '2019-07-04', 'report', 'racism');


SELECT a.extra AS report_reason,
	COUNT(DISTINCT a.post_id) AS report_count
FROM Actions a
WHERE a.action_date="2019-07-04" AND a.action="report"
GROUP BY a.extra;


# Problem 1142
DROP TABLE IF EXISTS Activity;
CREATE TABLE IF NOT EXISTS Activity (user_id int, session_id int, activity_date date, activity_type ENUM('open_session', 'end_session', 'scroll_down', 'send_message'));
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('1', '1', '2019-07-20', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('1', '1', '2019-07-20', 'scroll_down');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('1', '1', '2019-07-20', 'end_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('2', '4', '2019-07-20', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('2', '4', '2019-07-21', 'send_message');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('2', '4', '2019-07-21', 'end_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('3', '2', '2019-07-21', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('3', '2', '2019-07-21', 'send_message');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('3', '2', '2019-07-21', 'end_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('3', '5', '2019-07-21', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('3', '5', '2019-07-21', 'scroll_down');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('3', '5', '2019-07-21', 'end_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('4', '3', '2019-06-25', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('4', '3', '2019-06-25', 'end_session');


SELECT 
	ROUND(IFNULL(COUNT(DISTINCT session_id)/COUNT(DISTINCT user_id), 0), 2) AS average_sessions_per_user
FROM Activity
WHERE activity_date<="2019-07-27" AND activity_date>="2019-06-28";


# Problem 1677
DROP TABLE IF EXISTS Product;
CREATE TABLE IF NOT EXISTS Product(product_id int, name varchar(15));
INSERT INTO Product (product_id, name) VALUES ('0', 'ham');
INSERT INTO Product (product_id, name) VALUES ('1', 'bacon');

DROP TABLE IF EXISTS Invoice;
CREATE TABLE IF NOT EXISTS Invoice(invoice_id int, product_id int, rest int, paid int, canceled int, refunded int);
INSERT INTO Invoice (invoice_id, product_id, rest, paid, canceled, refunded) VALUES ('23', '0', '2', '0', '5', '0');
INSERT INTO Invoice (invoice_id, product_id, rest, paid, canceled, refunded) VALUES ('12', '0', '0', '4', '0', '3');
INSERT INTO Invoice (invoice_id, product_id, rest, paid, canceled, refunded) VALUES ('1', '1', '1', '1', '0', '1');
INSERT INTO Invoice (invoice_id, product_id, rest, paid, canceled, refunded) VALUES ('2', '1', '1', '0', '1', '1');
INSERT INTO Invoice (invoice_id, product_id, rest, paid, canceled, refunded) VALUES ('3', '1', '0', '1', '1', '1');
INSERT INTO Invoice (invoice_id, product_id, rest, paid, canceled, refunded) VALUES ('4', '1', '1', '1', '1', '0');

SELECT p.name,
	IFNULL(SUM(i.rest), 0) AS rest, IFNULL(SUM(i.paid), 0) AS paid, IFNULL(SUM(i.canceled), 0) AS canceled, IFNULL(SUM(i.refunded), 0) AS refunded
FROM Product p
LEFT JOIN Invoice i
USING (product_id)
GROUP BY p.name 
ORDER BY p.name;


# Problem 1264
DROP TABLE IF EXISTS Friendship;
CREATE TABLE IF NOT EXISTS Friendship (user1_id int, user2_id int);
INSERT INTO Friendship (user1_id, user2_id) VALUES ('1', '2');
INSERT INTO Friendship (user1_id, user2_id) VALUES ('1', '3');
INSERT INTO Friendship (user1_id, user2_id) VALUES ('1', '4');
INSERT INTO Friendship (user1_id, user2_id) VALUES ('2', '3');
INSERT INTO Friendship (user1_id, user2_id) VALUES ('2', '4');
INSERT INTO Friendship (user1_id, user2_id) VALUES ('2', '5');
INSERT INTO Friendship (user1_id, user2_id) VALUES ('6', '1');

DROP TABLE IF EXISTS Likes;
CREATE TABLE IF NOT EXISTS Likes (user_id int, page_id int);
INSERT INTO Likes (user_id, page_id) VALUES ('1', '88');
INSERT INTO Likes (user_id, page_id) VALUES ('2', '23');
INSERT INTO Likes (user_id, page_id) VALUES ('3', '24');
INSERT INTO Likes (user_id, page_id) VALUES ('4', '56');
INSERT INTO Likes (user_id, page_id) VALUES ('5', '11');
INSERT INTO Likes (user_id, page_id) VALUES ('6', '33');
INSERT INTO Likes (user_id, page_id) VALUES ('2', '77');
INSERT INTO Likes (user_id, page_id) VALUES ('3', '77');
INSERT INTO Likes (user_id, page_id) VALUES ('6', '88');


WITH friend AS (
	SELECT * FROM Friendship
	WHERE user1_id=1 OR user2_id=1
	UNION ALL
	SELECT user2_id, user1_id FROM Friendship
	WHERE user1_id=1 OR user2_id=1
),
jointable AS (
	SELECT * FROM friend f
    INNER JOIN Likes l
    ON f.user1_id=user_id
)
SELECT DISTINCT page_id AS recommended_page FROM jointable
WHERE user1_id!=1 AND page_id NOT IN (SELECT DISTINCT page_id FROM jointable WHERE user1_id=1);


# Problem 2989
DROP TABLE IF EXISTS Scores;
CREATE TABLE IF NOT EXISTS Scores (student_id int, student_name varchar(40), assignment1 int, assignment2 int, assignment3 int);
INSERT INTO Scores (student_id, student_name, assignment1, assignment2, assignment3) VALUES ('309', 'Owen', '88', '47', '87');
INSERT INTO Scores (student_id, student_name, assignment1, assignment2, assignment3) VALUES ('321', 'Claire', '98', '95', '37');
INSERT INTO Scores (student_id, student_name, assignment1, assignment2, assignment3) VALUES ('338', 'Julian', '100', '64', '43');
INSERT INTO Scores (student_id, student_name, assignment1, assignment2, assignment3) VALUES ('423', 'Peyton', '60', '44', '47');
INSERT INTO Scores (student_id, student_name, assignment1, assignment2, assignment3) VALUES ('896', 'David', '32', '37', '50');
INSERT INTO Scores (student_id, student_name, assignment1, assignment2, assignment3) VALUES ('235', 'Camila', '31', '53', '69');


WITH result AS (
	SELECT
		assignment1+assignment2+assignment3 AS total,
		ROW_NUMBER() OVER (ORDER BY assignment1+assignment2+assignment3 ASC) AS lowest,
		ROW_NUMBER() OVER (ORDER BY assignment1+assignment2+assignment3 DESC) AS highest
	FROM Scores
)
SELECT 
	SUM(CASE
		WHEN highest=1 THEN total
        WHEN lowest=1 THEN -total
        ELSE 0
    END) AS difference_in_score
FROM result;


# Problem 2066
DROP TABLE IF EXISTS Transactions;
CREATE TABLE IF NOT EXISTS Transactions (account_id int, day date, type ENUM('Deposit', 'Withdraw'), amount int);
INSERT INTO Transactions (account_id, day, type, amount) VALUES ('1', '2021-11-07', 'Deposit', '2000');
INSERT INTO Transactions (account_id, day, type, amount) VALUES ('1', '2021-11-09', 'Withdraw', '1000');
INSERT INTO Transactions (account_id, day, type, amount) VALUES ('1', '2021-11-11', 'Deposit', '3000');
INSERT INTO Transactions (account_id, day, type, amount) VALUES ('2', '2021-12-07', 'Deposit', '7000');
INSERT INTO Transactions (account_id, day, type, amount) VALUES ('2', '2021-12-12', 'Withdraw', '7000');


SELECT account_id, day,
	SUM(sumcol) OVER (PARTITION BY account_id ORDER BY day ASC) AS balance
FROM (
	SELECT account_id, day, 
		IF(type="Deposit", amount, -amount) AS sumcol
	FROM Transactions
) r
ORDER BY account_id ASC, day ASC;


# Problem 1596
DROP TABLE IF EXISTS Customers;
CREATE TABLE IF NOT EXISTS Customers (customer_id int, name varchar(10));
INSERT INTO Customers (customer_id, name) VALUES ('1', 'Alice');
INSERT INTO Customers (customer_id, name) VALUES ('2', 'Bob');
INSERT INTO Customers (customer_id, name) VALUES ('3', 'Tom');
INSERT INTO Customers (customer_id, name) VALUES ('4', 'Jerry');
INSERT INTO Customers (customer_id, name) VALUES ('5', 'John');

DROP TABLE IF EXISTS Orders;
CREATE TABLE IF NOT EXISTS Orders (order_id int, order_date date, customer_id int, product_id int);
INSERT INTO Orders (order_id, order_date, customer_id, product_id) VALUES ('1', '2020-07-31', '1', '1');
INSERT INTO Orders (order_id, order_date, customer_id, product_id) VALUES ('2', '2020-7-30', '2', '2');
INSERT INTO Orders (order_id, order_date, customer_id, product_id) VALUES ('3', '2020-08-29', '3', '3');
INSERT INTO Orders (order_id, order_date, customer_id, product_id) VALUES ('4', '2020-07-29', '4', '1');
INSERT INTO Orders (order_id, order_date, customer_id, product_id) VALUES ('5', '2020-06-10', '1', '2');
INSERT INTO Orders (order_id, order_date, customer_id, product_id) VALUES ('6', '2020-08-01', '2', '1');
INSERT INTO Orders (order_id, order_date, customer_id, product_id) VALUES ('7', '2020-08-01', '3', '3');
INSERT INTO Orders (order_id, order_date, customer_id, product_id) VALUES ('8', '2020-08-03', '1', '2');
INSERT INTO Orders (order_id, order_date, customer_id, product_id) VALUES ('9', '2020-08-07', '2', '3');
INSERT INTO Orders (order_id, order_date, customer_id, product_id) VALUES ('10', '2020-07-15', '1', '2');

DROP TABLE IF EXISTS Products;
CREATE TABLE IF NOT EXISTS Products (product_id int, product_name varchar(20), price int);
INSERT INTO Products (product_id, product_name, price) VALUES ('1', 'keyboard', '120');
INSERT INTO Products (product_id, product_name, price) VALUES ('2', 'mouse', '80');
INSERT INTO Products (product_id, product_name, price) VALUES ('3', 'screen', '600');
INSERT INTO Products (product_id, product_name, price) VALUES ('4', 'hard disk', '450');


SELECT r.customer_id, r.product_id, r.product_name FROM (
	SELECT c.customer_id, p.product_name, p.product_id,
		RANK() OVER (PARTITION BY o.customer_id ORDER BY COUNT(p.product_name) DESC) AS rnk
	FROM Customers c, Orders o, Products p
	WHERE c.customer_id=o.customer_id AND o.product_id=p.product_id
	GROUP BY o.customer_id, p.product_id, p.product_name
) r
WHERE r.rnk=1;


# Problem 602
DROP TABLE IF EXISTS RequestAccepted;
CREATE TABLE IF NOT EXISTS RequestAccepted (requester_id int NOT NULL, accepter_id int NULL, accept_date date NULL);
INSERT INTO RequestAccepted (requester_id, accepter_id, accept_date) VALUES ('1', '2', '2016-06-03');
INSERT INTO RequestAccepted (requester_id, accepter_id, accept_date) VALUES ('1', '3', '2016-06-08');
INSERT INTO RequestAccepted (requester_id, accepter_id, accept_date) VALUES ('2', '3', '2016-06-08');
INSERT INTO RequestAccepted (requester_id, accepter_id, accept_date) VALUES ('3', '4', '2016-06-09');


WITH all_user AS (
	SELECT requester_id AS id
    FROM RequestAccepted
    UNION ALL
	SELECT accepter_id AS id
    FROM RequestAccepted
)
SELECT id,
	COUNT(*) AS num
FROM all_user
GROUP BY id
ORDER BY COUNT(*) DESC LIMIT 1;


# Problem 603
DROP TABLE IF EXISTS Cinema;
CREATE TABLE IF NOT EXISTS Cinema (seat_id int PRIMARY KEY AUTO_INCREMENT, free bool);
INSERT INTO Cinema (seat_id, free) VALUES ('1', '1');
INSERT INTO Cinema (seat_id, free) VALUES ('2', '0');
INSERT INTO Cinema (seat_id, free) VALUES ('3', '1');
INSERT INTO Cinema (seat_id, free) VALUES ('4', '1');
INSERT INTO Cinema (seat_id, free) VALUES ('5', '1');

SELECT r.seat_id FROM (
	SELECT *,
		IFNULL(LAG(free, 1) OVER(ORDER BY seat_id ASC), 0) AS lastrow,
		IFNULL(LEAD(free, 1) OVER (ORDER BY seat_id ASC), 0) AS nextrow
	FROM Cinema
) r
WHERE r.free=1 AND (r.lastrow=1 OR r.nextrow=1)
ORDER BY r.seat_id ASC;

SELECT seat_id FROM Cinema
WHERE free=1 AND (
	seat_id-1 IN (SELECT seat_id FROM Cinema WHERE free=1)
    OR
    seat_id+1 IN (SELECT seat_id FROM Cinema WHERE free=1)
);


# Problem 1194
DROP TABLE IF EXISTS Players;
CREATE TABLE IF NOT EXISTS Players (player_id int, group_id int);
INSERT INTO Players (player_id, group_id) VALUES ('10', '2');
INSERT INTO Players (player_id, group_id) VALUES ('15', '1');
INSERT INTO Players (player_id, group_id) VALUES ('20', '3');
INSERT INTO Players (player_id, group_id) VALUES ('25', '1');
INSERT INTO Players (player_id, group_id) VALUES ('30', '1');
INSERT INTO Players (player_id, group_id) VALUES ('35', '2');
INSERT INTO Players (player_id, group_id) VALUES ('40', '3');
INSERT INTO Players (player_id, group_id) VALUES ('45', '1');
INSERT INTO Players (player_id, group_id) VALUES ('50', '2');

DROP TABLE IF EXISTS Matches;
CREATE TABLE IF NOT EXISTS Matches (match_id int, first_player int, second_player int, first_score int, second_score int);
INSERT INTO Matches (match_id, first_player, second_player, first_score, second_score) VALUES ('1', '15', '45', '3', '0');
INSERT INTO Matches (match_id, first_player, second_player, first_score, second_score) VALUES ('2', '30', '25', '1', '2');
INSERT INTO Matches (match_id, first_player, second_player, first_score, second_score) VALUES ('3', '30', '15', '2', '0');
INSERT INTO Matches (match_id, first_player, second_player, first_score, second_score) VALUES ('4', '40', '20', '5', '2');
INSERT INTO Matches (match_id, first_player, second_player, first_score, second_score) VALUES ('5', '35', '50', '1', '1');

WITH all_player AS (
	SELECT first_player AS player, first_score AS score FROM Matches
	UNION ALL
	SELECT second_player AS player, second_score AS score FROM Matches
)
SELECT r.group_id, r.player AS player_id FROM (
	SELECT p.group_id, ap.player, 
		RANK() OVER(PARTITION BY p.group_id ORDER BY SUM(ap.score) DESC, ap.player ASC) AS rnk
	FROM all_player ap
	INNER JOIN Players p
	ON ap.player=p.player_id
	GROUP BY p.group_id, ap.player
) r
WHERE r.rnk=1;

SELECT r.group_id, r.player_id FROM (
	SELECT p.player_id, p.group_id,
		RANK() OVER(PARTITION BY p.group_id ORDER BY 
		SUM(CASE WHEN p.player_id=m.first_player THEN m.first_score ELSE m.second_score END) DESC, 
		p.player_id ASC) AS rnk
	FROM Players p
	INNER JOIN Matches m
	ON p.player_id in (m.first_player, m.second_player)
	GROUP BY p.group_id, p.player_id
) r
WHERE r.rnk=1;

