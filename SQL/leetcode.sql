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
Create table If Not Exists Salary (id int, name varchar(100), sex char(1), salary int);
insert into Salary (id, name, sex, salary) values ('1', 'A', 'm', '2500');
insert into Salary (id, name, sex, salary) values ('2', 'B', 'f', '1500');
insert into Salary (id, name, sex, salary) values ('3', 'C', 'm', '5500');
insert into Salary (id, name, sex, salary) values ('4', 'D', 'f', '500');

SET SQL_SAFE_UPDATES=0;

UPDATE Salary
SET sex = (
	CASE sex 
    WHEN 'f' THEN 'm'
    WHEN 'm' THEN 'f'
    END);
    
# Problem 1378
DROP TABLE IF EXISTS Employees;
Create table If Not Exists Employees (id int, name varchar(20));
insert into Employees (id, name) values ('1', 'Alice');
insert into Employees (id, name) values ('7', 'Bob');
insert into Employees (id, name) values ('11', 'Meir');
insert into Employees (id, name) values ('90', 'Winston');
insert into Employees (id, name) values ('3', 'Jonathan');

DROP TABLE IF EXISTS EmployeeUNI;
Create table If Not Exists EmployeeUNI (id int, unique_id int);
insert into EmployeeUNI (id, unique_id) values ('3', '1');
insert into EmployeeUNI (id, unique_id) values ('11', '2');
insert into EmployeeUNI (id, unique_id) values ('90', '3');

SELECT eu.unique_id, e.name FROM Employees as e
LEFT JOIN EmployeeUNI as eu
ON e.id = eu.id;

# Problem 1068
DROP TABLE IF EXISTS Sales;
Create table If Not Exists Sales (sale_id int, product_id int, year int, quantity int, price int);
insert into Sales (sale_id, product_id, year, quantity, price) values ('1', '100', '2008', '10', '5000');
insert into Sales (sale_id, product_id, year, quantity, price) values ('2', '100', '2009', '12', '5000');
insert into Sales (sale_id, product_id, year, quantity, price) values ('7', '200', '2011', '15', '9000');

DROP TABLE IF EXISTS Product;
Create table If Not Exists Product (product_id int, product_name varchar(10));
insert into Product (product_id, product_name) values ('100', 'Nokia');
insert into Product (product_id, product_name) values ('200', 'Apple');
insert into Product (product_id, product_name) values ('300', 'Samsung');

SELECT p.product_name, s.year, s.price FROM Sales as s
LEFT JOIN Product as p
ON s.product_id = p.product_id;


# Problem 1179
DROP TABLE IF EXISTS Department;
Create table If Not Exists Department (id int, revenue int, month varchar(5));
insert into Department (id, revenue, month) values ('1', '8000', 'Jan');
insert into Department (id, revenue, month) values ('2', '9000', 'Jan');
insert into Department (id, revenue, month) values ('3', '10000', 'Feb');
insert into Department (id, revenue, month) values ('1', '7000', 'Feb');
insert into Department (id, revenue, month) values ('1', '6000', 'Mar');

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
insert into Logins (user_id, time_stamp) values ('6', '2020-06-30 15:06:07');
insert into Logins (user_id, time_stamp) values ('6', '2021-04-21 14:06:06');
insert into Logins (user_id, time_stamp) values ('6', '2019-03-07 00:18:15');
insert into Logins (user_id, time_stamp) values ('8', '2020-02-01 05:10:53');
insert into Logins (user_id, time_stamp) values ('8', '2020-12-30 00:46:50');
insert into Logins (user_id, time_stamp) values ('2', '2020-01-16 02:49:50');
insert into Logins (user_id, time_stamp) values ('2', '2019-08-25 07:59:08');
insert into Logins (user_id, time_stamp) values ('14', '2019-07-14 09:00:00');
insert into Logins (user_id, time_stamp) values ('14', '2021-01-06 11:59:59');

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
insert into Activities (sell_date, product) values ('2020-05-30', 'Headphone');
insert into Activities (sell_date, product) values ('2020-06-01', 'Pencil');
insert into Activities (sell_date, product) values ('2020-06-02', 'Mask');
insert into Activities (sell_date, product) values ('2020-05-30', 'Basketball');
insert into Activities (sell_date, product) values ('2020-06-01', 'Bible');
insert into Activities (sell_date, product) values ('2020-06-02', 'Mask');
insert into Activities (sell_date, product) values ('2020-05-30', 'T-Shirt');

SELECT sell_date, COUNT(DISTINCT product) AS num_sold, GROUP_CONCAT(DISTINCT product order by product) AS products FROM Activities
GROUP BY sell_date;

# Problem 175
DROP TABLE IF EXISTS Person;
Create table If Not Exists Person (personId int, firstName varchar(255), lastName varchar(255));
insert into Person (personId, lastName, firstName) values ('1', 'Wang', 'Allen');
insert into Person (personId, lastName, firstName) values ('2', 'Alice', 'Bob');

DROP TABLE IF EXISTS Address;
Create table If Not Exists Address (addressId int, personId int, city varchar(255), state varchar(255));
insert into Address (addressId, personId, city, state) values ('1', '2', 'New York City', 'New York');
insert into Address (addressId, personId, city, state) values ('2', '3', 'Leetcode', 'California');

SELECT p.firstname, p.lastname, a.city, a.state FROM Person as p
LEFT JOIN Address as a
ON p.personId = a.personId;


# Problem 1148
DROP TABLE IF EXISTS Views;
Create table If Not Exists Views (article_id int, author_id int, viewer_id int, view_date date);
insert into Views (article_id, author_id, viewer_id, view_date) values ('1', '3', '5', '2019-08-01');
insert into Views (article_id, author_id, viewer_id, view_date) values ('1', '3', '6', '2019-08-02');
insert into Views (article_id, author_id, viewer_id, view_date) values ('2', '7', '7', '2019-08-01');
insert into Views (article_id, author_id, viewer_id, view_date) values ('2', '7', '6', '2019-08-02');
insert into Views (article_id, author_id, viewer_id, view_date) values ('4', '7', '1', '2019-07-22');
insert into Views (article_id, author_id, viewer_id, view_date) values ('3', '4', '4', '2019-07-21');
insert into Views (article_id, author_id, viewer_id, view_date) values ('3', '4', '4', '2019-07-21');

SELECT DISTINCT author_id AS id FROM Views
WHERE author_id=viewer_id
ORDER BY author_id ASC;


# Problem 577
DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee (empId int, name varchar(255), supervisor varchar(255), salary int);
insert into Employee (empId, name, supervisor, salary) values ('3', 'Brad', 'None', '4000');
insert into Employee (empId, name, supervisor, salary) values ('1', 'John', '3', '1000');
insert into Employee (empId, name, supervisor, salary) values ('2', 'Dan', '3', '2000');
insert into Employee (empId, name, supervisor, salary) values ('4', 'Thomas', '3', '4000');

DROP TABLE IF EXISTS Bonus;
Create table If Not Exists Bonus (empId int, bonus int);
insert into Bonus (empId, bonus) values ('2', '500');
insert into Bonus (empId, bonus) values ('4', '2000');

SELECT e.name, b.bonus FROM Employee as e
LEFT JOIN Bonus as b
ON e.empId=b.empId
WHERE b.bonus<1000 or b.bonus is NULL;


# Problem 511
DROP TABLE IF EXISTS Activity;
Create table If Not Exists Activity (player_id int, device_id int, event_date date, games_played int);
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-01', '5');
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-05-02', '6');
insert into Activity (player_id, device_id, event_date, games_played) values ('2', '3', '2017-06-25', '1');
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '1', '2016-03-02', '0');
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '4', '2018-07-03', '5');

SELECT player_id, MIN(event_date) AS first_login FROM Activity
GROUP BY player_id;


# Problem 620
DROP TABLE IF EXISTS cinema;
Create table If Not Exists cinema (id int, movie varchar(255), description varchar(255), rating float(2, 1));
insert into cinema (id, movie, description, rating) values ('1', 'War', 'great 3D', '8.9');
insert into cinema (id, movie, description, rating) values ('2', 'Science', 'fiction', '8.5');
insert into cinema (id, movie, description, rating) values ('3', 'irish', 'boring', '6.2');
insert into cinema (id, movie, description, rating) values ('4', 'Ice song', 'Fantacy', '8.6');
insert into cinema (id, movie, description, rating) values ('5', 'House card', 'Interesting', '9.1');

SELECT * FROM cinema
WHERE id % 2 = 1 and description != 'boring'
ORDER BY rating DESC;


# Problem 608
DROP TABLE IF EXISTS Tree;
Create table If Not Exists Tree (id int, p_id varchar(255));
insert into Tree (id, p_id) values ('1', 'None');
insert into Tree (id, p_id) values ('2', '1');
insert into Tree (id, p_id) values ('3', '1');
insert into Tree (id, p_id) values ('4', '2');
insert into Tree (id, p_id) values ('5', '2');

SELECT id,
	CASE
		WHEN p_id = 'None' THEN 'Root'
		WHEN id in (SELECT DISTINCT p_id from tree) THEN 'Inner'
		ELSE 'Leaf'
	END AS type
FROM Tree;


# Problem 610
DROP TABLE IF EXISTS Triangle;
Create table If Not Exists Triangle (x int, y int, z int);
insert into Triangle (x, y, z) values ('13', '15', '30');
insert into Triangle (x, y, z) values ('10', '20', '15');

SELECT *,
	CASE 
		WHEN x+y>z and x+z>y and y+z>x THEN 'Yes'
        ELSE 'No'
	END AS 'triangle'
FROM Triangle;

SELECT *,
	IF (x+y>z and x+z>y and y+z>x, 'Yes', 'No') AS 'triangle'
FROM Triangle;


# Problem 1965
DROP TABLE IF EXISTS Employees;
Create table If Not Exists Employees (employee_id int, name varchar(30));
insert into Employees (employee_id, name) values ('2', 'Crew');
insert into Employees (employee_id, name) values ('4', 'Haven');
insert into Employees (employee_id, name) values ('5', 'Kristian');

DROP TABLE IF EXISTS Salaries;
Create table If Not Exists Salaries (employee_id int, salary int);
insert into Salaries (employee_id, salary) values ('5', '76071');
insert into Salaries (employee_id, salary) values ('1', '22517');
insert into Salaries (employee_id, salary) values ('4', '63539');

SELECT * FROM (
	SELECT e.employee_id FROM Employees as e
	LEFT JOIN Salaries as s
	ON e.employee_id=s.employee_id
	WHERE e.name is NULL or s.salary is NULL
	UNION ALL
	SELECT s.employee_id FROM Salaries as s
	LEFT JOIN Employees as e
	ON e.employee_id=s.employee_id
	WHERE e.name is NULL or s.salary is NULL
) AS r
ORDER BY employee_id ASC;


# Problem 182
DROP TABLE IF EXISTS Person;
Create table If Not Exists Person (id int, email varchar(255));
insert into Person (id, email) values ('1', 'a@b.com');
insert into Person (id, email) values ('2', 'c@d.com');
insert into Person (id, email) values ('3', 'a@b.com');

SELECT email FROM (
	SELECT email, 
		ROW_NUMBER() OVER (PARTITION BY email) as row_num
	FROM Person
) as r
WHERE r.row_num=2;

SELECT email FROM Person
GROUP BY email
HAVING COUNT(email)>1;


# Problem 1327
DROP TABLE IF EXISTS Products;
Create table If Not Exists Products (product_id int, product_name varchar(40), product_category varchar(40));
insert into Products (product_id, product_name, product_category) values ('1', 'Leetcode Solutions', 'Book');
insert into Products (product_id, product_name, product_category) values ('2', 'Jewels of Stringology', 'Book');
insert into Products (product_id, product_name, product_category) values ('3', 'HP', 'Laptop');
insert into Products (product_id, product_name, product_category) values ('4', 'Lenovo', 'Laptop');
insert into Products (product_id, product_name, product_category) values ('5', 'Leetcode Kit', 'T-shirt');

DROP TABLE IF EXISTS Orders;
Create table If Not Exists Orders (product_id int, order_date date, unit int);
insert into Orders (product_id, order_date, unit) values ('1', '2020-02-05', '60');
insert into Orders (product_id, order_date, unit) values ('1', '2020-02-10', '70');
insert into Orders (product_id, order_date, unit) values ('2', '2020-01-18', '30');
insert into Orders (product_id, order_date, unit) values ('2', '2020-02-11', '80');
insert into Orders (product_id, order_date, unit) values ('3', '2020-02-17', '2');
insert into Orders (product_id, order_date, unit) values ('3', '2020-02-24', '3');
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-01', '20');
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-04', '30');
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-04', '60');
insert into Orders (product_id, order_date, unit) values ('5', '2020-02-25', '50');
insert into Orders (product_id, order_date, unit) values ('5', '2020-02-27', '50');
insert into Orders (product_id, order_date, unit) values ('5', '2020-03-01', '50');

SELECT p.product_name, o.unit FROM Products as p
INNER JOIN (
	SELECT product_id, SUM(unit) as unit FROM Orders
	WHERE YEAR(order_date)='2020' and MONTH(order_date)='2'
	GROUP BY product_id
	HAVING SUM(unit)>=100
) AS o
ON p.product_id=o.product_id;


# Problem 1050
DROP TABLE IF EXISTS ActorDirector;
Create table If Not Exists ActorDirector (actor_id int, director_id int, timestamp int);
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '0');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '1');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '2');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '2', '3');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '2', '4');
insert into ActorDirector (actor_id, director_id, timestamp) values ('2', '1', '5');
insert into ActorDirector (actor_id, director_id, timestamp) values ('2', '1', '6');

SELECT CAST(SUBSTRING_INDEX(r.ad, ',', 1) AS UNSIGNED) AS actor_id, CAST(SUBSTRING_INDEX(r.ad, ',', -1) AS UNSIGNED) AS director_id FROM (
	SELECT CONCAT(actor_id, ',', director_id) AS ad
	FROM ActorDirector
	GROUP BY CONCAT(actor_id, ',', director_id)
	HAVING COUNT(CONCAT(actor_id, ',', director_id)) >=3
) AS r;

SELECT actor_id, director_id FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(timestamp)>=3;


# Problem 584
DROP TABLE IF EXISTS Custormer;
Create table If Not Exists Customer (id int, name varchar(25), referee_id VARCHAR(255));
insert into Customer (id, name, referee_id) values ('1', 'Will', 'None');
insert into Customer (id, name, referee_id) values ('2', 'Jane', 'None');
insert into Customer (id, name, referee_id) values ('3', 'Alex', '2');
insert into Customer (id, name, referee_id) values ('4', 'Bill', 'None');
insert into Customer (id, name, referee_id) values ('5', 'Zack', '1');
insert into Customer (id, name, referee_id) values ('6', 'Mark', '2');

select name from customer
where referee_id != 2 or referee_id is NULL


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
Create table If Not Exists Employee (id int, name varchar(255), salary int, managerId VARCHAR(255));
insert into Employee (id, name, salary, managerId) values ('1', 'Joe', '70000', '3');
insert into Employee (id, name, salary, managerId) values ('2', 'Henry', '80000', '4');
insert into Employee (id, name, salary, managerId) values ('3', 'Sam', '60000', 'None');
insert into Employee (id, name, salary, managerId) values ('4', 'Max', '90000', 'None');

SELECT e1.name AS employee FROM Employee as e1
INNER JOIN Employee as e2
ON e1.managerId = e2.id
WHERE e1.salary > e2.salary;


# Problem 183
DROP TABLE IF EXISTS Customers;
Create table If Not Exists Customers (id int, name varchar(255));
insert into Customers (id, name) values ('1', 'Joe');
insert into Customers (id, name) values ('2', 'Henry');
insert into Customers (id, name) values ('3', 'Sam');
insert into Customers (id, name) values ('4', 'Max');

DROP TABLE IF EXISTS Orders;
Create table If Not Exists Orders (id int, customerId int);
insert into Orders (id, customerId) values ('1', '3');
insert into Orders (id, customerId) values ('2', '1');

SELECT c.name AS customers FROM Customers AS c
LEFT OUTER JOIN Orders AS o
ON c.id = customerId
WHERE o.id is NULL;


# Problem 1729
DROP TABLE IF EXISTS Followers;
Create table If Not Exists Followers(user_id int, follower_id int);
insert into Followers (user_id, follower_id) values ('0', '1');
insert into Followers (user_id, follower_id) values ('1', '0');
insert into Followers (user_id, follower_id) values ('2', '0');
insert into Followers (user_id, follower_id) values ('2', '1');

SELECT user_id, COUNT(follower_id) AS followers_count FROM Followers
GROUP BY user_id
ORDER BY user_id ASC;


# Problem 1581
DROP TABLE IF EXISTS Visits;
Create table If Not Exists Visits(visit_id int, customer_id int);
insert into Visits (visit_id, customer_id) values ('1', '23');
insert into Visits (visit_id, customer_id) values ('2', '9');
insert into Visits (visit_id, customer_id) values ('4', '30');
insert into Visits (visit_id, customer_id) values ('5', '54');
insert into Visits (visit_id, customer_id) values ('6', '96');
insert into Visits (visit_id, customer_id) values ('7', '54');
insert into Visits (visit_id, customer_id) values ('8', '54');

DROP TABLE IF EXISTS Transactions;
Create table If Not Exists Transactions(transaction_id int, visit_id int, amount int);
insert into Transactions (transaction_id, visit_id, amount) values ('2', '5', '310');
insert into Transactions (transaction_id, visit_id, amount) values ('3', '5', '300');
insert into Transactions (transaction_id, visit_id, amount) values ('9', '5', '200');
insert into Transactions (transaction_id, visit_id, amount) values ('12', '1', '910');
insert into Transactions (transaction_id, visit_id, amount) values ('13', '2', '970');

SELECT v.customer_id, COUNT(*) AS count_no_trans FROM Visits AS v
LEFT OUTER JOIN Transactions AS t
ON v.visit_id=t.visit_id
WHERE t.transaction_id is NULL
GROUP BY v.customer_id;


# Problem 595
DROP TABLE IF EXISTS World;
Create table If Not Exists World (name varchar(255), continent varchar(255), area int, population int, gdp bigint);
insert into World (name, continent, area, population, gdp) values ('Afghanistan', 'Asia', '652230', '25500100', '20343000000');
insert into World (name, continent, area, population, gdp) values ('Albania', 'Europe', '28748', '2831741', '12960000000');
insert into World (name, continent, area, population, gdp) values ('Algeria', 'Africa', '2381741', '37100000', '188681000000');
insert into World (name, continent, area, population, gdp) values ('Andorra', 'Europe', '468', '78115', '3712000000');
insert into World (name, continent, area, population, gdp) values ('Angola', 'Africa', '1246700', '20609294', '100990000000');

SELECT name, population, area FROM World
WHERE area>=3000000 or population>=25000000;


# Problem 1661
DROP TABLE IF EXISTS Activity;
Create table If Not Exists Activity (machine_id int, process_id int, activity_type ENUM('start', 'end'), timestamp float);
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('0', '0', 'start', '0.712');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('0', '0', 'end', '1.52');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('0', '1', 'start', '3.14');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('0', '1', 'end', '4.12');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('1', '0', 'start', '0.55');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('1', '0', 'end', '1.55');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('1', '1', 'start', '0.43');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('1', '1', 'end', '1.42');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('2', '0', 'start', '4.1');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('2', '0', 'end', '4.512');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('2', '1', 'start', '2.5');
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('2', '1', 'end', '5');

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
Create table If Not Exists Queue (person_id int, person_name varchar(30), weight int, turn int);
insert into Queue (person_id, person_name, weight, turn) values ('5', 'Alice', '250', '1');
insert into Queue (person_id, person_name, weight, turn) values ('4', 'Bob', '175', '5');
insert into Queue (person_id, person_name, weight, turn) values ('3', 'Alex', '350', '2');
insert into Queue (person_id, person_name, weight, turn) values ('6', 'John Cena', '400', '3');
insert into Queue (person_id, person_name, weight, turn) values ('1', 'Winston', '500', '6');
insert into Queue (person_id, person_name, weight, turn) values ('2', 'Marie', '200', '4');

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
Create table If Not Exists SalesPerson (sales_id int, name varchar(255), salary int, commission_rate int, hire_date date);
insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('1', 'John', '100000', '6', '2006-01-04');
insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('2', 'Amy', '12000', '5', '2010-01-05');
insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('3', 'Mark', '65000', '12', '2008-12-25');
insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('4', 'Pam', '25000', '25', '2005-01-01');
insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('5', 'Alex', '5000', '10', '2007-02-03');

DROP TABLE IF EXISTS Company;
Create table If Not Exists Company (com_id int, name varchar(255), city varchar(255));
insert into Company (com_id, name, city) values ('1', 'RED', 'Boston');
insert into Company (com_id, name, city) values ('2', 'ORANGE', 'New York');
insert into Company (com_id, name, city) values ('3', 'YELLOW', 'Boston');
insert into Company (com_id, name, city) values ('4', 'GREEN', 'Austin');

DROP TABLE IF EXISTS Orders;
Create table If Not Exists Orders (order_id int, order_date date, com_id int, sales_id int, amount int);
insert into Orders (order_id, order_date, com_id, sales_id, amount) values ('1', '2014-01-01', '3', '4', '10000');
insert into Orders (order_id, order_date, com_id, sales_id, amount) values ('2', '2014-02-01', '4', '5', '5000');
insert into Orders (order_id, order_date, com_id, sales_id, amount) values ('3', '2014-03-01', '1', '1', '50000');
insert into Orders (order_id, order_date, com_id, sales_id, amount) values ('4', '2014-04-01', '1', '4', '25000');

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
Create table If Not Exists orders (order_number int, customer_number int);
insert into orders (order_number, customer_number) values ('1', '1');
insert into orders (order_number, customer_number) values ('2', '2');
insert into orders (order_number, customer_number) values ('3', '3');
insert into orders (order_number, customer_number) values ('4', '3');

SELECT r.customer_number FROM(
	SELECT customer_number,
		COUNT(*) AS order_num
	FROM orders
	GROUP BY customer_number
) AS r
ORDER BY r.order_num DESC LIMIT 1;


# Problem 2988
DROP TABLE IF EXISTS Employees;
Create table if not exists Employees ( emp_id int, emp_name varchar(50), dep_id int, position varchar(30));
insert into Employees (emp_id, emp_name, dep_id, position) values ('156', 'Michael', '107', 'Manager');
insert into Employees (emp_id, emp_name, dep_id, position) values ('112', 'Lucas', '107', 'Consultant');
insert into Employees (emp_id, emp_name, dep_id, position) values ('8', 'Isabella', '101', 'Manager');
insert into Employees (emp_id, emp_name, dep_id, position) values ('160', 'Joseph', '100', 'Manager');
insert into Employees (emp_id, emp_name, dep_id, position) values ('80', 'Aiden', '100', 'Engineer');
insert into Employees (emp_id, emp_name, dep_id, position) values ('190', 'Skylar', '100', 'Freelancer');
insert into Employees (emp_id, emp_name, dep_id, position) values ('196', 'Stella', '101', 'Coordinator');
insert into Employees (emp_id, emp_name, dep_id, position) values ('167', 'Audrey', '100', 'Consultant');
insert into Employees (emp_id, emp_name, dep_id, position) values ('97', 'Nathan', '101', 'Supervisor');
insert into Employees (emp_id, emp_name, dep_id, position) values ('128', 'Ian', '101', 'Administrator');
insert into Employees (emp_id, emp_name, dep_id, position) values ('81', 'Ethan', '107', 'Administrator');

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
Create table If Not Exists Project (project_id int, employee_id int);
insert into Project (project_id, employee_id) values ('1', '1');
insert into Project (project_id, employee_id) values ('1', '2');
insert into Project (project_id, employee_id) values ('1', '3');
insert into Project (project_id, employee_id) values ('2', '1');
insert into Project (project_id, employee_id) values ('2', '4');

DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee (employee_id int, name varchar(10), experience_years int);
insert into Employee (employee_id, name, experience_years) values ('1', 'Khaled', '3');
insert into Employee (employee_id, name, experience_years) values ('2', 'Ali', '2');
insert into Employee (employee_id, name, experience_years) values ('3', 'John', '3');
insert into Employee (employee_id, name, experience_years) values ('4', 'Doe', '2');

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
Create table If Not Exists Boxes (box_id int, chest_id VARCHAR(255), apple_count int, orange_count int);
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('2', 'None', '6', '15');
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('18', 'None', '4', '15');
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('19', 'None', '8', '4');
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('12', 'None', '19', '20');
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('20', 'None', '12', '9');
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('8', 'None', '9', '9');
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('3', 'None', '16', '7');

DROP TABLE IF EXISTS Chests;
Create table If Not Exists Chests (chest_id int, apple_count int, orange_count int);
insert into Chests (chest_id, apple_count, orange_count) values ('6', '5', '6');
insert into Chests (chest_id, apple_count, orange_count) values ('14', '20', '10');
insert into Chests (chest_id, apple_count, orange_count) values ('2', '8', '8');
insert into Chests (chest_id, apple_count, orange_count) values ('3', '19', '4');
insert into Chests (chest_id, apple_count, orange_count) values ('16', '19', '19');

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
Create table If Not Exists Employees (employee_id int, employee_name varchar(30), manager_id int);
insert into Employees (employee_id, employee_name, manager_id) values ('1', 'Boss', '1');
insert into Employees (employee_id, employee_name, manager_id) values ('3', 'Alice', '3');
insert into Employees (employee_id, employee_name, manager_id) values ('2', 'Bob', '1');
insert into Employees (employee_id, employee_name, manager_id) values ('4', 'Daniel', '2');
insert into Employees (employee_id, employee_name, manager_id) values ('7', 'Luis', '4');
insert into Employees (employee_id, employee_name, manager_id) values ('8', 'John', '3');
insert into Employees (employee_id, employee_name, manager_id) values ('9', 'Angela', '8');
insert into Employees (employee_id, employee_name, manager_id) values ('77', 'Robert', '1');

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
Create table If Not Exists Sales (sale_date date, fruit ENUM('apples', 'oranges'), sold_num int);
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-01', 'apples', '10');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-01', 'oranges', '8');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-02', 'apples', '15');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-02', 'oranges', '15');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-03', 'apples', '20');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-03', 'oranges', '0');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-04', 'apples', '15');
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-04', 'oranges', '16');

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
DROP TABLE IF EXISTS Friendsl;
Create table If Not Exists Friends (id int, name varchar(30), activity varchar(30));
insert into Friends (id, name, activity) values ('1', 'Jonathan D.', 'Eating');
insert into Friends (id, name, activity) values ('2', 'Jade W.', 'Singing');
insert into Friends (id, name, activity) values ('3', 'Victor J.', 'Singing');
insert into Friends (id, name, activity) values ('4', 'Elvis Q.', 'Eating');
insert into Friends (id, name, activity) values ('5', 'Daniel A.', 'Eating');
insert into Friends (id, name, activity) values ('6', 'Bob B.', 'Horse Riding');

DROP TABLE IF EXISTS Activities;
Create table If Not Exists Activities (id int, name varchar(30));
insert into Activities (id, name) values ('1', 'Eating');
insert into Activities (id, name) values ('2', 'Singing');
insert into Activities (id, name) values ('3', 'Horse Riding');

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
Create table If Not Exists Subscriptions (account_id int, start_date date, end_date date);
insert into Subscriptions (account_id, start_date, end_date) values ('9', '2020-02-18', '2021-10-30');
insert into Subscriptions (account_id, start_date, end_date) values ('3', '2021-09-21', '2021-11-13');
insert into Subscriptions (account_id, start_date, end_date) values ('11', '2020-02-28', '2020-08-18');
insert into Subscriptions (account_id, start_date, end_date) values ('13', '2021-04-20', '2021-09-22');
insert into Subscriptions (account_id, start_date, end_date) values ('4', '2020-10-26', '2021-05-08');
insert into Subscriptions (account_id, start_date, end_date) values ('5', '2020-09-11', '2021-01-17');

DROP TABLE IF EXISTS Streams;
Create table If Not Exists Streams (session_id int, account_id int, stream_date date);
insert into Streams (session_id, account_id, stream_date) values ('14', '9', '2020-05-16');
insert into Streams (session_id, account_id, stream_date) values ('16', '3', '2021-10-27');
insert into Streams (session_id, account_id, stream_date) values ('18', '11', '2020-04-29');
insert into Streams (session_id, account_id, stream_date) values ('17', '13', '2021-08-08');
insert into Streams (session_id, account_id, stream_date) values ('19', '4', '2020-12-31');
insert into Streams (session_id, account_id, stream_date) values ('13', '5', '2021-01-05');

SELECT COUNT(*) AS accounts_count FROM Subscriptions AS sub
LEFT OUTER JOIN Streams AS str
USING (account_id)
WHERE (YEAR(start_date) = '2021' OR YEAR(end_date) = '2021') AND (str.session_id IS NULL OR YEAR(str.stream_date) != '2021');


# Problem 2051
DROP TABLE IF EXISTS Members;
Create table If Not Exists Members (member_id int, name varchar(30));
insert into Members (member_id, name) values ('9', 'Alice');
insert into Members (member_id, name) values ('11', 'Bob');
insert into Members (member_id, name) values ('3', 'Winston');
insert into Members (member_id, name) values ('8', 'Hercy');
insert into Members (member_id, name) values ('1', 'Narihan');

DROP TABLE IF EXISTS Visits;
Create table If Not Exists Visits (visit_id int, member_id int, visit_date date);
insert into Visits (visit_id, member_id, visit_date) values ('22', '11', '2021-10-28');
insert into Visits (visit_id, member_id, visit_date) values ('16', '11', '2021-01-12');
insert into Visits (visit_id, member_id, visit_date) values ('18', '9', '2021-12-10');
insert into Visits (visit_id, member_id, visit_date) values ('19', '3', '2021-10-19');
insert into Visits (visit_id, member_id, visit_date) values ('12', '11', '2021-03-01');
insert into Visits (visit_id, member_id, visit_date) values ('17', '8', '2021-05-07');
insert into Visits (visit_id, member_id, visit_date) values ('21', '9', '2021-05-12');

DROP TABLE IF EXISTS Purchases;
Create table If Not Exists Purchases (visit_id int, charged_amount int);
insert into Purchases (visit_id, charged_amount) values ('12', '2000');
insert into Purchases (visit_id, charged_amount) values ('18', '9000');
insert into Purchases (visit_id, charged_amount) values ('17', '7000');


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
Create table If Not Exists Genders (user_id int, gender ENUM('female', 'other', 'male'));
insert into Genders (user_id, gender) values ('4', 'male');
insert into Genders (user_id, gender) values ('7', 'female');
insert into Genders (user_id, gender) values ('2', 'other');
insert into Genders (user_id, gender) values ('5', 'male');
insert into Genders (user_id, gender) values ('3', 'female');
insert into Genders (user_id, gender) values ('8', 'male');
insert into Genders (user_id, gender) values ('6', 'other');
insert into Genders (user_id, gender) values ('1', 'other');
insert into Genders (user_id, gender) values ('9', 'female');

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
Create table If Not Exists Relations (user_id int, follower_id int);
insert into Relations (user_id, follower_id) values ('1', '3');
insert into Relations (user_id, follower_id) values ('2', '3');
insert into Relations (user_id, follower_id) values ('7', '3');
insert into Relations (user_id, follower_id) values ('1', '4');
insert into Relations (user_id, follower_id) values ('2', '4');
insert into Relations (user_id, follower_id) values ('7', '4');
insert into Relations (user_id, follower_id) values ('1', '5');
insert into Relations (user_id, follower_id) values ('2', '6');
insert into Relations (user_id, follower_id) values ('7', '5');

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
CREATE TABLE if Not exists Cinema (
    seat_id INT,
    free BOOLEAN
);
insert into Cinema (seat_id, free) values ('1', '1');
insert into Cinema (seat_id, free) values ('2', '0');
insert into Cinema (seat_id, free) values ('3', '1');
insert into Cinema (seat_id, free) values ('4', '1');
insert into Cinema (seat_id, free) values ('5', '1');


# Problem 1532
DROP TABLE IF EXISTS Customers;
Create table If Not Exists Customers (customer_id int, name varchar(10));
insert into Customers (customer_id, name) values ('1', 'Winston');
insert into Customers (customer_id, name) values ('2', 'Jonathan');
insert into Customers (customer_id, name) values ('3', 'Annabelle');
insert into Customers (customer_id, name) values ('4', 'Marwan');
insert into Customers (customer_id, name) values ('5', 'Khaled');

DROP TABLE IF EXISTS Orders;
Create table If Not Exists Orders (order_id int, order_date date, customer_id int, cost int);
insert into Orders (order_id, order_date, customer_id, cost) values ('1', '2020-07-31', '1', '30');
insert into Orders (order_id, order_date, customer_id, cost) values ('2', '2020-7-30', '2', '40');
insert into Orders (order_id, order_date, customer_id, cost) values ('3', '2020-07-31', '3', '70');
insert into Orders (order_id, order_date, customer_id, cost) values ('4', '2020-07-29', '4', '100');
insert into Orders (order_id, order_date, customer_id, cost) values ('5', '2020-06-10', '1', '1010');
insert into Orders (order_id, order_date, customer_id, cost) values ('6', '2020-08-01', '2', '102');
insert into Orders (order_id, order_date, customer_id, cost) values ('7', '2020-08-01', '3', '111');
insert into Orders (order_id, order_date, customer_id, cost) values ('8', '2020-08-03', '1', '99');
insert into Orders (order_id, order_date, customer_id, cost) values ('9', '2020-08-07', '2', '32');
insert into Orders (order_id, order_date, customer_id, cost) values ('10', '2020-07-15', '1', '2');

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
Create table If Not Exists Employees (employee_id int, name varchar(30), salary int);
insert into Employees (employee_id, name, salary) values ('2', 'Meir', '3000');
insert into Employees (employee_id, name, salary) values ('3', 'Michael', '3000');
insert into Employees (employee_id, name, salary) values ('7', 'Addilyn', '7400');
insert into Employees (employee_id, name, salary) values ('8', 'Juan', '6100');
insert into Employees (employee_id, name, salary) values ('9', 'Kannon', '7400');

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
Create table if not exists Steps(user_id int, steps_count int, steps_date date);
insert into Steps (user_id, steps_count, steps_date) values ('1', '687', '2021-09-02');
insert into Steps (user_id, steps_count, steps_date) values ('1', '395', '2021-09-04');
insert into Steps (user_id, steps_count, steps_date) values ('1', '499', '2021-09-05');
insert into Steps (user_id, steps_count, steps_date) values ('1', '712', '2021-09-06');
insert into Steps (user_id, steps_count, steps_date) values ('1', '576', '2021-09-07');
insert into Steps (user_id, steps_count, steps_date) values ('2', '153', '2021-09-06');
insert into Steps (user_id, steps_count, steps_date) values ('2', '171', '2021-09-07');
insert into Steps (user_id, steps_count, steps_date) values ('2', '530', '2021-09-08');
insert into Steps (user_id, steps_count, steps_date) values ('3', '945', '2021-09-04');
insert into Steps (user_id, steps_count, steps_date) values ('3', '120', '2021-09-07');
insert into Steps (user_id, steps_count, steps_date) values ('3', '557', '2021-09-08');
insert into Steps (user_id, steps_count, steps_date) values ('3', '840', '2021-09-09');
insert into Steps (user_id, steps_count, steps_date) values ('3', '627', '2021-09-10');
insert into Steps (user_id, steps_count, steps_date) values ('5', '382', '2021-09-05');
insert into Steps (user_id, steps_count, steps_date) values ('6', '480', '2021-09-01');
insert into Steps (user_id, steps_count, steps_date) values ('6', '191', '2021-09-02');
insert into Steps (user_id, steps_count, steps_date) values ('6', '303', '2021-09-05');

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
Create table If Not Exists Data (first_col int, second_col int);
insert into Data (first_col, second_col) values ('4', '2');
insert into Data (first_col, second_col) values ('2', '3');
insert into Data (first_col, second_col) values ('3', '1');
insert into Data (first_col, second_col) values ('1', '4');

SELECT d1.first_col, d2.second_col FROM (
	SELECT first_col, ROW_NUMBER() OVER (ORDER BY first_col ASC) AS rnum1 FROM Data
) AS d1
INNER JOIN (
	SELECT second_col, ROW_NUMBER() OVER (ORDER BY second_col DESC) AS rnum2 FROM Data
) AS d2
ON d1.rnum1=d2.rnum2;


# Problem 2175
DROP TABLE IF EXISTS TeamPoints;
Create table If Not Exists TeamPoints (team_id int, name varchar(100), points int);
insert into TeamPoints (team_id, name, points) values ('3', 'Algeria', '1431');
insert into TeamPoints (team_id, name, points) values ('1', 'Senegal', '2132');
insert into TeamPoints (team_id, name, points) values ('2', 'New Zealand', '1402');
insert into TeamPoints (team_id, name, points) values ('4', 'Croatia', '1817');

DROP TABLE IF EXISTS PointsChange;
Create table If Not Exists PointsChange (team_id int, points_change int);
insert into PointsChange (team_id, points_change) values ('3', '399');
insert into PointsChange (team_id, points_change) values ('2', '0');
insert into PointsChange (team_id, points_change) values ('4', '13');
insert into PointsChange (team_id, points_change) values ('1', '-22');

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
Create table If Not Exists Student (student_id int,student_name varchar(45), gender varchar(6), dept_id int);
insert into Student (student_id, student_name, gender, dept_id) values ('1', 'Jack', 'M', '1');
insert into Student (student_id, student_name, gender, dept_id) values ('2', 'Jane', 'F', '1');
insert into Student (student_id, student_name, gender, dept_id) values ('3', 'Mark', 'M', '2');

DROP TABLE IF EXISTS Department;
Create table If Not Exists Department (dept_id int, dept_name varchar(255));
insert into Department (dept_id, dept_name) values ('1', 'Engineering');
insert into Department (dept_id, dept_name) values ('2', 'Science');
insert into Department (dept_id, dept_name) values ('3', 'Law');

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
Create table If Not Exists Salaries (company_id int, employee_id int, employee_name varchar(13), salary int);
insert into Salaries (company_id, employee_id, employee_name, salary) values ('1', '1', 'Tony', '2000');
insert into Salaries (company_id, employee_id, employee_name, salary) values ('1', '2', 'Pronub', '21300');
insert into Salaries (company_id, employee_id, employee_name, salary) values ('1', '3', 'Tyrrox', '10800');
insert into Salaries (company_id, employee_id, employee_name, salary) values ('2', '1', 'Pam', '300');
insert into Salaries (company_id, employee_id, employee_name, salary) values ('2', '7', 'Bassem', '450');
insert into Salaries (company_id, employee_id, employee_name, salary) values ('2', '9', 'Hermione', '700');
insert into Salaries (company_id, employee_id, employee_name, salary) values ('3', '7', 'Bocaben', '100');
insert into Salaries (company_id, employee_id, employee_name, salary) values ('3', '2', 'Ognjen', '2200');
insert into Salaries (company_id, employee_id, employee_name, salary) values ('3', '13', 'Nyancat', '3300');
insert into Salaries (company_id, employee_id, employee_name, salary) values ('3', '15', 'Morninngcat', '7777');

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
Create table If Not Exists Flights (departure_airport int, arrival_airport int, flights_count int);
insert into Flights (departure_airport, arrival_airport, flights_count) values ('1', '2', '4');
insert into Flights (departure_airport, arrival_airport, flights_count) values ('2', '1', '5');
insert into Flights (departure_airport, arrival_airport, flights_count) values ('2', '4', '5');

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
Create table If Not Exists OrdersDetails (order_id int, product_id int, quantity int);
insert into OrdersDetails (order_id, product_id, quantity) values ('1', '1', '12');
insert into OrdersDetails (order_id, product_id, quantity) values ('1', '2', '10');
insert into OrdersDetails (order_id, produsct_id, quantity) values ('1', '3', '15');
insert into OrdersDetails (order_id, product_id, quantity) values ('2', '1', '8');
insert into OrdersDetails (order_id, product_id, quantity) values ('2', '4', '4');
insert into OrdersDetails (order_id, product_id, quantity) values ('2', '5', '6');
insert into OrdersDetails (order_id, product_id, quantity) values ('3', '3', '5');
insert into OrdersDetails (order_id, product_id, quantity) values ('3', '4', '18');
insert into OrdersDetails (order_id, product_id, quantity) values ('4', '5', '2');
insert into OrdersDetails (order_id, product_id, quantity) values ('4', '6', '8');
insert into OrdersDetails (order_id, product_id, quantity) values ('5', '7', '9');
insert into OrdersDetails (order_id, product_id, quantity) values ('5', '8', '9');
insert into OrdersDetails (order_id, product_id, quantity) values ('3', '9', '20');
insert into OrdersDetails (order_id, product_id, quantity) values ('2', '9', '4');

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
DROP TABLE IF EXISTS Tweets;
Create table If Not Exists Tweets (user_id int, tweet_id int, tweet varchar(100), tweet_date date);
insert into Tweets (user_id, tweet_id, tweet, tweet_date) values ('135', '13', 'Enjoying a great start to the day. #HappyDay #MorningVibes', '2024-02-01');
insert into Tweets (user_id, tweet_id, tweet, tweet_date) values ('136', '14', 'Another #HappyDay with good vibes! #FeelGood', '2024-02-03');
insert into Tweets (user_id, tweet_id, tweet, tweet_date) values ('137', '15', 'Productivity peaks! #WorkLife #ProductiveDay', '2024-02-04');
insert into Tweets (user_id, tweet_id, tweet, tweet_date) values ('138', '16', 'Exploring new tech frontiers. #TechLife #Innovation', '2024-02-04');
insert into Tweets (user_id, tweet_id, tweet, tweet_date) values ('139', '17', 'Gratitude for today moments. #HappyDay #Thankful', '2024-02-05');
insert into Tweets (user_id, tweet_id, tweet, tweet_date) values ('140', '18', 'Innovation drives us. #TechLife #FutureTech', '2024-02-07');
insert into Tweets (user_id, tweet_id, tweet, tweet_date) values ('141', '19', 'Connecting with nature serenity. #Nature #Peaceful', '2024-02-09');

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
DROP TABLE IF EXISTS Schools;
Create table If Not Exists Schools (school_id int, capacity int);
insert into Schools (school_id, capacity) values ('11', '151');
insert into Schools (school_id, capacity) values ('5', '48');
insert into Schools (school_id, capacity) values ('9', '9');
insert into Schools (school_id, capacity) values ('10', '99');

DROP TABLE IF EXISTS Exam;
Create table If Not Exists Exam (score int, student_count int);
insert into Exam (score, student_count) values ('975', '10');
insert into Exam (score, student_count) values ('966', '60');
insert into Exam (score, student_count) values ('844', '76');
insert into Exam (score, student_count) values ('749', '76');
insert into Exam (score, student_count) values ('744', '100');

SELECT s.school_id,
	IFNULL(MIN(e.score), -1) AS score
FROM Schools s
LEFT JOIN Exam e
ON s.capacity>=e.student_count
GROUP BY school_id;


# Problem 1651
DROP TABLE IF EXISTS Drivers;
Create table If Not Exists Drivers (driver_id int, join_date date);
insert into Drivers (driver_id, join_date) values ('10', '2019-12-10');
insert into Drivers (driver_id, join_date) values ('8', '2020-1-13');
insert into Drivers (driver_id, join_date) values ('5', '2020-2-16');
insert into Drivers (driver_id, join_date) values ('7', '2020-3-8');
insert into Drivers (driver_id, join_date) values ('4', '2020-5-17');
insert into Drivers (driver_id, join_date) values ('1', '2020-10-24');
insert into Drivers (driver_id, join_date) values ('6', '2021-1-5');

DROP TABLE IF EXISTS Rides;
Create table If Not Exists Rides (ride_id int, user_id int, requested_at date);
insert into Rides (ride_id, user_id, requested_at) values ('6', '75', '2019-12-9');
insert into Rides (ride_id, user_id, requested_at) values ('1', '54', '2020-2-9');
insert into Rides (ride_id, user_id, requested_at) values ('10', '63', '2020-3-4');
insert into Rides (ride_id, user_id, requested_at) values ('19', '39', '2020-4-6');
insert into Rides (ride_id, user_id, requested_at) values ('3', '41', '2020-6-3');
insert into Rides (ride_id, user_id, requested_at) values ('13', '52', '2020-6-22');
insert into Rides (ride_id, user_id, requested_at) values ('7', '69', '2020-7-16');
insert into Rides (ride_id, user_id, requested_at) values ('17', '70', '2020-8-25');
insert into Rides (ride_id, user_id, requested_at) values ('20', '81', '2020-11-2');
insert into Rides (ride_id, user_id, requested_at) values ('5', '57', '2020-11-9');
insert into Rides (ride_id, user_id, requested_at) values ('2', '42', '2020-12-9');
insert into Rides (ride_id, user_id, requested_at) values ('11', '68', '2021-1-11');
insert into Rides (ride_id, user_id, requested_at) values ('15', '32', '2021-1-17');
insert into Rides (ride_id, user_id, requested_at) values ('12', '11', '2021-1-19');
insert into Rides (ride_id, user_id, requested_at) values ('14', '18', '2021-1-27');

DROP TABLE IF EXISTS AcceptedRides;
Create table If Not Exists AcceptedRides (ride_id int, driver_id int, ride_distance int, ride_duration int);
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('10', '10', '63', '38');
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('13', '10', '73', '96');
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('7', '8', '100', '28');
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('17', '7', '119', '68');
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('20', '1', '121', '92');
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('5', '7', '42', '101');
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('2', '4', '6', '38');
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('11', '8', '37', '43');
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('15', '8', '108', '82');
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('12', '8', '38', '34');
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('14', '1', '90', '74');

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
Create table if not exists Orders(minute int, order_count int);
insert into Orders (minute, order_count) values ('1', '0');
insert into Orders (minute, order_count) values ('2', '2');
insert into Orders (minute, order_count) values ('3', '4');
insert into Orders (minute, order_count) values ('4', '6');
insert into Orders (minute, order_count) values ('5', '1');
insert into Orders (minute, order_count) values ('6', '4');
insert into Orders (minute, order_count) values ('7', '1');
insert into Orders (minute, order_count) values ('8', '2');
insert into Orders (minute, order_count) values ('9', '4');
insert into Orders (minute, order_count) values ('10', '1');
insert into Orders (minute, order_count) values ('11', '4');
insert into Orders (minute, order_count) values ('12', '6');

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
Create table If Not Exists Events (business_id int, event_type varchar(10), occurrences int);
insert into Events (business_id, event_type, occurrences) values ('1', 'reviews', '7');
insert into Events (business_id, event_type, occurrences) values ('3', 'reviews', '3');
insert into Events (business_id, event_type, occurrences) values ('1', 'ads', '11');
insert into Events (business_id, event_type, occurrences) values ('2', 'ads', '7');
insert into Events (business_id, event_type, occurrences) values ('3', 'ads', '6');
insert into Events (business_id, event_type, occurrences) values ('1', 'page views', '3');
insert into Events (business_id, event_type, occurrences) values ('2', 'page views', '12');

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
Create table If Not Exists Sales (sale_id int, product_id int, user_id int, quantity int);
insert into Sales (sale_id, product_id, user_id, quantity) values ('1', '1', '101', '10');
insert into Sales (sale_id, product_id, user_id, quantity) values ('2', '3', '101', '7');
insert into Sales (sale_id, product_id, user_id, quantity) values ('3', '1', '102', '9');
insert into Sales (sale_id, product_id, user_id, quantity) values ('4', '2', '102', '6');
insert into Sales (sale_id, product_id, user_id, quantity) values ('5', '3', '102', '10');
insert into Sales (sale_id, product_id, user_id, quantity) values ('6', '1', '102', '6');

DROP TABLE IF EXISTS Product;
Create table If Not Exists Product (product_id int, price int);
insert into Product (product_id, price) values ('1', '10');
insert into Product (product_id, price) values ('2', '25');
insert into Product (product_id, price) values ('3', '15');

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
Create table If Not Exists UserVisits(user_id int, visit_date date);
insert into UserVisits (user_id, visit_date) values ('1', '2020-11-28');
insert into UserVisits (user_id, visit_date) values ('1', '2020-10-20');
insert into UserVisits (user_id, visit_date) values ('1', '2020-12-3');
insert into UserVisits (user_id, visit_date) values ('2', '2020-10-5');
insert into UserVisits (user_id, visit_date) values ('2', '2020-12-9');
insert into UserVisits (user_id, visit_date) values ('3', '2020-11-11');

SELECT r.user_id, MAX(r.window_len) AS biggest_window FROM (
	SELECT *,
		DATEDIFF(LEAD(visit_date, 1, '2021-1-1') OVER (PARTITION BY user_id ORDER BY visit_date ASC), visit_date) AS window_len
	FROM UserVisits
) AS r
GROUP BY r.user_id;


# Problem 3050
DROP TABLE IF EXISTS Toppings;
Create table if not exists Toppings(topping_name varchar(100), cost decimal(5,2));
insert into Toppings (topping_name, cost) values ('Pepperoni', '0.5');
insert into Toppings (topping_name, cost) values ('Sausage', '0.7');
insert into Toppings (topping_name, cost) values ('Chicken', '0.55');
insert into Toppings (topping_name, cost) values ('Extra Cheese', '0.4');

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
Create table If Not Exists Delivery (delivery_id int, customer_id int, order_date date, customer_pref_delivery_date date);
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('1', '1', '2019-08-01', '2019-08-02');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('2', '2', '2019-08-01', '2019-08-01');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('3', '1', '2019-08-01', '2019-08-01');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('4', '3', '2019-08-02', '2019-08-13');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('5', '3', '2019-08-02', '2019-08-02');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('6', '2', '2019-08-02', '2019-08-02');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('7', '4', '2019-08-03', '2019-08-03');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('8', '1', '2019-08-03', '2019-08-03');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('9', '5', '2019-08-04', '2019-08-18');
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('10', '2', '2019-08-04', '2019-08-18');

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
Create table If Not Exists Products (product_id int, price int);
insert into Products (product_id, price) values ('1', '100');
insert into Products (product_id, price) values ('2', '200');

DROP TABLE IF EXISTS Purchases;
Create table If Not Exists Purchases (invoice_id int, product_id int, quantity int);
insert into Purchases (invoice_id, product_id, quantity) values ('1', '1', '2');
insert into Purchases (invoice_id, product_id, quantity) values ('3', '2', '1');
insert into Purchases (invoice_id, product_id, quantity) values ('2', '2', '3');
insert into Purchases (invoice_id, product_id, quantity) values ('2', '1', '4');
insert into Purchases (invoice_id, product_id, quantity) values ('4', '1', '10');

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
Create table If Not Exists Candidate (id int, name varchar(255));
insert into Candidate (id, name) values ('1', 'A');
insert into Candidate (id, name) values ('2', 'B');
insert into Candidate (id, name) values ('3', 'C');
insert into Candidate (id, name) values ('4', 'D');
insert into Candidate (id, name) values ('5', 'E');

DROP TABLE IF EXISTS Vote;
Create table If Not Exists Vote (id int, candidateId int);
insert into Vote (id, candidateId) values ('1', '2');
insert into Vote (id, candidateId) values ('2', '4');
insert into Vote (id, candidateId) values ('3', '3');
insert into Vote (id, candidateId) values ('4', '2');
insert into Vote (id, candidateId) values ('5', '5');

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
Create Table if Not Exists Purchases( user_id int, purchase_date date, amount_spend int);
insert into Purchases (user_id, purchase_date, amount_spend) values ('11', '2023-11-03', '1126');
insert into Purchases (user_id, purchase_date, amount_spend) values ('15', '2023-11-10', '7473');
insert into Purchases (user_id, purchase_date, amount_spend) values ('17', '2023-11-17', '2414');
insert into Purchases (user_id, purchase_date, amount_spend) values ('12', '2023-11-24', '9692');
insert into Purchases (user_id, purchase_date, amount_spend) values ('8', '2023-11-24', '5117');
insert into Purchases (user_id, purchase_date, amount_spend) values ('1', '2023-11-24', '5241');
insert into Purchases (user_id, purchase_date, amount_spend) values ('10', '2023-11-22', '8266');
insert into Purchases (user_id, purchase_date, amount_spend) values ('13', '2023-11-21', '12000');

DROP TABLE IF EXISTS Users;
Create Table if Not Exists Users (user_id int, membership enum('Standard', 'Premium', 'VIP'));
insert into Users (user_id, membership) values ('11', 'Premium');
insert into Users (user_id, membership) values ('15', 'VIP');
insert into Users (user_id, membership) values ('17', 'Standard');
insert into Users (user_id, membership) values ('12', 'VIP');
insert into Users (user_id, membership) values ('8', 'Premium');
insert into Users (user_id, membership) values ('1', 'VIP');
insert into Users (user_id, membership) values ('10', 'Standard');
insert into Users (user_id, membership) values ('13', 'Premium');

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
Create table If Not Exists Signups (user_id int, time_stamp datetime);
insert into Signups (user_id, time_stamp) values ('3', '2020-03-21 10:16:13');
insert into Signups (user_id, time_stamp) values ('7', '2020-01-04 13:57:59');
insert into Signups (user_id, time_stamp) values ('2', '2020-07-29 23:09:44');
insert into Signups (user_id, time_stamp) values ('6', '2020-12-09 10:39:37');

DROP TABLE IF EXISTS Confirmations;
Create table If Not Exists Confirmations (user_id int, time_stamp datetime, action ENUM('confirmed','timeout'));
insert into Confirmations (user_id, time_stamp, action) values ('3', '2021-01-06 03:30:46', 'timeout');
insert into Confirmations (user_id, time_stamp, action) values ('3', '2021-07-14 14:00:00', 'timeout');
insert into Confirmations (user_id, time_stamp, action) values ('7', '2021-06-12 11:57:29', 'confirmed');
insert into Confirmations (user_id, time_stamp, action) values ('7', '2021-06-13 12:58:28', 'confirmed');
insert into Confirmations (user_id, time_stamp, action) values ('7', '2021-06-14 13:59:27', 'confirmed');
insert into Confirmations (user_id, time_stamp, action) values ('2', '2021-01-22 00:00:00', 'confirmed');
insert into Confirmations (user_id, time_stamp, action) values ('2', '2021-02-28 23:59:59', 'timeout');

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
Create table If Not Exists Candidates (candidate_id int, name varchar(30), years_of_exp int, interview_id int);
insert into Candidates (candidate_id, name, years_of_exp, interview_id) values ('11', 'Atticus', '1', '101');
insert into Candidates (candidate_id, name, years_of_exp, interview_id) values ('9', 'Ruben', '6', '104');
insert into Candidates (candidate_id, name, years_of_exp, interview_id) values ('6', 'Aliza', '10', '109');
insert into Candidates (candidate_id, name, years_of_exp, interview_id) values ('8', 'Alfredo', '0', '107');

DROP TABLE IF EXISTS Rounds;
Create table If Not Exists Rounds (interview_id int, round_id int, score int);
insert into Rounds (interview_id, round_id, score) values ('109', '3', '4');
insert into Rounds (interview_id, round_id, score) values ('101', '2', '8');
insert into Rounds (interview_id, round_id, score) values ('109', '4', '1');
insert into Rounds (interview_id, round_id, score) values ('107', '1', '3');
insert into Rounds (interview_id, round_id, score) values ('104', '3', '6');
insert into Rounds (interview_id, round_id, score) values ('109', '1', '4');
insert into Rounds (interview_id, round_id, score) values ('104', '4', '7');
insert into Rounds (interview_id, round_id, score) values ('104', '1', '2');
insert into Rounds (interview_id, round_id, score) values ('109', '2', '1');
insert into Rounds (interview_id, round_id, score) values ('104', '2', '7');
insert into Rounds (interview_id, round_id, score) values ('107', '2', '3');
insert into Rounds (interview_id, round_id, score) values ('101', '1', '8');

SELECT c.candidate_id
FROM Candidates c
INNER JOIN Rounds as r
USING (interview_id)
WHERE c.years_of_exp >= 2
GROUP BY c.candidate_id
HAVING SUM(score)>15;


# Problem 612
DROP TABLE IF EXISTS Point2D;
Create Table If Not Exists Point2D (x int not null, y int not null);
insert into Point2D (x, y) values ('-1', '-1');
insert into Point2D (x, y) values ('0', '0');
insert into Point2D (x, y) values ('-1', '-2');

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
Create table If Not Exists Scores (id int, score DECIMAL(3,2));
insert into Scores (id, score) values ('1', '3.5');
insert into Scores (id, score) values ('2', '3.65');
insert into Scores (id, score) values ('3', '4.0');
insert into Scores (id, score) values ('4', '3.85');
insert into Scores (id, score) values ('5', '4.0');
insert into Scores (id, score) values ('6', '3.65');

SELECT score,
	DENSE_RANK() OVER (ORDER BY score DESC) AS "rank"
FROM Scores
ORDER BY "rank" ASC;


# Problem 1158
DROP TABLE IF EXISTS Users;
Create table If Not Exists Users (user_id int, join_date date, favorite_brand varchar(10));
insert into Users (user_id, join_date, favorite_brand) values ('1', '2018-01-01', 'Lenovo');
insert into Users (user_id, join_date, favorite_brand) values ('2', '2018-02-09', 'Samsung');
insert into Users (user_id, join_date, favorite_brand) values ('3', '2018-01-19', 'LG');
insert into Users (user_id, join_date, favorite_brand) values ('4', '2018-05-21', 'HP');

DROP TABLE IF EXISTS Orders;
Create table If Not Exists Orders (order_id int, order_date date, item_id int, buyer_id int, seller_id int);
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('1', '2019-08-01', '4', '1', '2');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('2', '2018-08-02', '2', '1', '3');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('3', '2019-08-03', '3', '2', '3');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('4', '2018-08-04', '1', '4', '2');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('5', '2018-08-04', '1', '3', '4');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('6', '2019-08-05', '2', '2', '4');

DROP TABLE IF EXISTS Items;
Create table If Not Exists Items (item_id int, item_brand varchar(10));
insert into Items (item_id, item_brand) values ('1', 'Samsung');
insert into Items (item_id, item_brand) values ('2', 'Lenovo');
insert into Items (item_id, item_brand) values ('3', 'LG');
insert into Items (item_id, item_brand) values ('4', 'HP');

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
Create table If Not Exists Salary (id int, employee_id int, amount int, pay_date date);
insert into Salary (id, employee_id, amount, pay_date) values ('1', '1', '9000', '2017/03/31');
insert into Salary (id, employee_id, amount, pay_date) values ('2', '2', '6000', '2017/03/31');
insert into Salary (id, employee_id, amount, pay_date) values ('3', '3', '10000', '2017/03/31');
insert into Salary (id, employee_id, amount, pay_date) values ('4', '1', '7000', '2017/02/28');
insert into Salary (id, employee_id, amount, pay_date) values ('5', '2', '6000', '2017/02/28');
insert into Salary (id, employee_id, amount, pay_date) values ('6', '3', '8000', '2017/02/28');

DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee (employee_id int, department_id int);
insert into Employee (employee_id, department_id) values ('1', '1');
insert into Employee (employee_id, department_id) values ('2', '2');
insert into Employee (employee_id, department_id) values ('3', '2');


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
Create table If Not Exists Books (book_id int, name varchar(50), available_from date);
insert into Books (book_id, name, available_from) values ('1', 'Kalila And Demna', '2010-01-01');
insert into Books (book_id, name, available_from) values ('2', '28 Letters', '2012-05-12');
insert into Books (book_id, name, available_from) values ('3', 'The Hobbit', '2019-06-10');
insert into Books (book_id, name, available_from) values ('4', '13 Reasons Why', '2019-06-01');
insert into Books (book_id, name, available_from) values ('5', 'The Hunger Games', '2008-09-21');

DROP TABLE IF EXISTS Orders;
Create table If Not Exists Orders (order_id int, book_id int, quantity int, dispatch_date date);
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('1', '1', '2', '2018-07-26');
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('2', '1', '1', '2018-11-05');
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('3', '3', '8', '2019-06-11');
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('4', '4', '6', '2019-06-05');
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('5', '4', '5', '2019-06-20');
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('6', '5', '9', '2009-02-02');
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('7', '5', '8', '2010-04-13');

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
Create table If Not Exists Actions (user_id int, post_id int, action_date date, action ENUM('view', 'like', 'reaction', 'comment', 'report', 'share'), extra varchar(10));
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'like', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'share', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('2', '4', '2019-07-04', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('2', '4', '2019-07-04', 'report', 'spam');
insert into Actions (user_id, post_id, action_date, action, extra) values ('3', '4', '2019-07-04', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('3', '4', '2019-07-04', 'report', 'spam');
insert into Actions (user_id, post_id, action_date, action, extra) values ('4', '3', '2019-07-02', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('4', '3', '2019-07-02', 'report', 'spam');
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '2', '2019-07-04', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '2', '2019-07-04', 'report', 'racism');
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '5', '2019-07-04', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '5', '2019-07-04', 'report', 'racism');

SELECT a.extra AS report_reason,
	COUNT(DISTINCT a.post_id) AS report_count
FROM Actions a
WHERE a.action_date="2019-07-04" AND a.action="report"
GROUP BY a.extra;


# Problem 1142
DROP TABLE IF EXISTS Activity;
Create table If Not Exists Activity (user_id int, session_id int, activity_date date, activity_type ENUM('open_session', 'end_session', 'scroll_down', 'send_message'));
insert into Activity (user_id, session_id, activity_date, activity_type) values ('1', '1', '2019-07-20', 'open_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('1', '1', '2019-07-20', 'scroll_down');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('1', '1', '2019-07-20', 'end_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('2', '4', '2019-07-20', 'open_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('2', '4', '2019-07-21', 'send_message');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('2', '4', '2019-07-21', 'end_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '2', '2019-07-21', 'open_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '2', '2019-07-21', 'send_message');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '2', '2019-07-21', 'end_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '5', '2019-07-21', 'open_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '5', '2019-07-21', 'scroll_down');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '5', '2019-07-21', 'end_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('4', '3', '2019-06-25', 'open_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('4', '3', '2019-06-25', 'end_session');

SELECT 
	ROUND(IFNULL(COUNT(DISTINCT session_id)/COUNT(DISTINCT user_id), 0), 2) AS average_sessions_per_user
FROM Activity
WHERE activity_date<="2019-07-27" AND activity_date>="2019-06-28";


# Problem 1677
DROP TABLE IF EXISTS Product;
Create table If Not Exists Product(product_id int, name varchar(15));
insert into Product (product_id, name) values ('0', 'ham');
insert into Product (product_id, name) values ('1', 'bacon');

DROP TABLE IF EXISTS Invoice;
Create table If Not Exists Invoice(invoice_id int,product_id int,rest int, paid int, canceled int, refunded int);
insert into Invoice (invoice_id, product_id, rest, paid, canceled, refunded) values ('23', '0', '2', '0', '5', '0');
insert into Invoice (invoice_id, product_id, rest, paid, canceled, refunded) values ('12', '0', '0', '4', '0', '3');
insert into Invoice (invoice_id, product_id, rest, paid, canceled, refunded) values ('1', '1', '1', '1', '0', '1');
insert into Invoice (invoice_id, product_id, rest, paid, canceled, refunded) values ('2', '1', '1', '0', '1', '1');
insert into Invoice (invoice_id, product_id, rest, paid, canceled, refunded) values ('3', '1', '0', '1', '1', '1');
insert into Invoice (invoice_id, product_id, rest, paid, canceled, refunded) values ('4', '1', '1', '1', '1', '0');

SELECT p.name,
	IFNULL(SUM(i.rest), 0) AS rest, IFNULL(SUM(i.paid), 0) AS paid, IFNULL(SUM(i.canceled), 0) AS canceled, IFNULL(SUM(i.refunded), 0) AS refunded
FROM Product p
LEFT JOIN Invoice i
USING (product_id)
GROUP BY p.name 
ORDER BY p.name;


# Problem 1264
DROP TABLE IF EXISTS Friendship;
Create table If Not Exists Friendship (user1_id int, user2_id int);
insert into Friendship (user1_id, user2_id) values ('1', '2');
insert into Friendship (user1_id, user2_id) values ('1', '3');
insert into Friendship (user1_id, user2_id) values ('1', '4');
insert into Friendship (user1_id, user2_id) values ('2', '3');
insert into Friendship (user1_id, user2_id) values ('2', '4');
insert into Friendship (user1_id, user2_id) values ('2', '5');
insert into Friendship (user1_id, user2_id) values ('6', '1');

DROP TABLE IF EXISTS Likes;
Create table If Not Exists Likes (user_id int, page_id int);
insert into Likes (user_id, page_id) values ('1', '88');
insert into Likes (user_id, page_id) values ('2', '23');
insert into Likes (user_id, page_id) values ('3', '24');
insert into Likes (user_id, page_id) values ('4', '56');
insert into Likes (user_id, page_id) values ('5', '11');
insert into Likes (user_id, page_id) values ('6', '33');
insert into Likes (user_id, page_id) values ('2', '77');
insert into Likes (user_id, page_id) values ('3', '77');
insert into Likes (user_id, page_id) values ('6', '88');

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
Create Table if Not Exists Scores (student_id int, student_name varchar(40), assignment1 int,assignment2 int, assignment3 int);
insert into Scores (student_id, student_name, assignment1, assignment2, assignment3) values ('309', 'Owen', '88', '47', '87');
insert into Scores (student_id, student_name, assignment1, assignment2, assignment3) values ('321', 'Claire', '98', '95', '37');
insert into Scores (student_id, student_name, assignment1, assignment2, assignment3) values ('338', 'Julian', '100', '64', '43');
insert into Scores (student_id, student_name, assignment1, assignment2, assignment3) values ('423', 'Peyton', '60', '44', '47');
insert into Scores (student_id, student_name, assignment1, assignment2, assignment3) values ('896', 'David', '32', '37', '50');
insert into Scores (student_id, student_name, assignment1, assignment2, assignment3) values ('235', 'Camila', '31', '53', '69');

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
Create table If Not Exists Transactions (account_id int, day date, type ENUM('Deposit', 'Withdraw'), amount int);
insert into Transactions (account_id, day, type, amount) values ('1', '2021-11-07', 'Deposit', '2000');
insert into Transactions (account_id, day, type, amount) values ('1', '2021-11-09', 'Withdraw', '1000');
insert into Transactions (account_id, day, type, amount) values ('1', '2021-11-11', 'Deposit', '3000');
insert into Transactions (account_id, day, type, amount) values ('2', '2021-12-07', 'Deposit', '7000');
insert into Transactions (account_id, day, type, amount) values ('2', '2021-12-12', 'Withdraw', '7000');

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
Create table If Not Exists Customers (customer_id int, name varchar(10));
insert into Customers (customer_id, name) values ('1', 'Alice');
insert into Customers (customer_id, name) values ('2', 'Bob');
insert into Customers (customer_id, name) values ('3', 'Tom');
insert into Customers (customer_id, name) values ('4', 'Jerry');
insert into Customers (customer_id, name) values ('5', 'John');

DROP TABLE IF EXISTS Orders;
Create table If Not Exists Orders (order_id int, order_date date, customer_id int, product_id int);
insert into Orders (order_id, order_date, customer_id, product_id) values ('1', '2020-07-31', '1', '1');
insert into Orders (order_id, order_date, customer_id, product_id) values ('2', '2020-7-30', '2', '2');
insert into Orders (order_id, order_date, customer_id, product_id) values ('3', '2020-08-29', '3', '3');
insert into Orders (order_id, order_date, customer_id, product_id) values ('4', '2020-07-29', '4', '1');
insert into Orders (order_id, order_date, customer_id, product_id) values ('5', '2020-06-10', '1', '2');
insert into Orders (order_id, order_date, customer_id, product_id) values ('6', '2020-08-01', '2', '1');
insert into Orders (order_id, order_date, customer_id, product_id) values ('7', '2020-08-01', '3', '3');
insert into Orders (order_id, order_date, customer_id, product_id) values ('8', '2020-08-03', '1', '2');
insert into Orders (order_id, order_date, customer_id, product_id) values ('9', '2020-08-07', '2', '3');
insert into Orders (order_id, order_date, customer_id, product_id) values ('10', '2020-07-15', '1', '2');

DROP TABLE IF EXISTS Products;
Create table If Not Exists Products (product_id int, product_name varchar(20), price int);
insert into Products (product_id, product_name, price) values ('1', 'keyboard', '120');
insert into Products (product_id, product_name, price) values ('2', 'mouse', '80');
insert into Products (product_id, product_name, price) values ('3', 'screen', '600');
insert into Products (product_id, product_name, price) values ('4', 'hard disk', '450');

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
Create table If Not Exists RequestAccepted (requester_id int not null, accepter_id int null, accept_date date null);
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('1', '2', '2016-06-03');
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('1', '3', '2016-06-08');
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('2', '3', '2016-06-08');
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('3', '4', '2016-06-09');

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
Create table If Not Exists Cinema (seat_id int primary key auto_increment, free bool);
insert into Cinema (seat_id, free) values ('1', '1');
insert into Cinema (seat_id, free) values ('2', '0');
insert into Cinema (seat_id, free) values ('3', '1');
insert into Cinema (seat_id, free) values ('4', '1');
insert into Cinema (seat_id, free) values ('5', '1');

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
Create table If Not Exists Players (player_id int, group_id int);
insert into Players (player_id, group_id) values ('10', '2');
insert into Players (player_id, group_id) values ('15', '1');
insert into Players (player_id, group_id) values ('20', '3');
insert into Players (player_id, group_id) values ('25', '1');
insert into Players (player_id, group_id) values ('30', '1');
insert into Players (player_id, group_id) values ('35', '2');
insert into Players (player_id, group_id) values ('40', '3');
insert into Players (player_id, group_id) values ('45', '1');
insert into Players (player_id, group_id) values ('50', '2');

DROP TABLE IF EXISTS Matches;
Create table If Not Exists Matches (match_id int, first_player int, second_player int, first_score int, second_score int);
insert into Matches (match_id, first_player, second_player, first_score, second_score) values ('1', '15', '45', '3', '0');
insert into Matches (match_id, first_player, second_player, first_score, second_score) values ('2', '30', '25', '1', '2');
insert into Matches (match_id, first_player, second_player, first_score, second_score) values ('3', '30', '15', '2', '0');
insert into Matches (match_id, first_player, second_player, first_score, second_score) values ('4', '40', '20', '5', '2');
insert into Matches (match_id, first_player, second_player, first_score, second_score) values ('5', '35', '50', '1', '1');

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

