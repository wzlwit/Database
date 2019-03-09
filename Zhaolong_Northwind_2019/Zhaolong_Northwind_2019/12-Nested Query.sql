/*  Create nested queris in Northwind table
	Script Date: Feb 28, 2019
	Developed by: Zhaolong Wang
*/

--switch to Northwind database
USE Northwind2019;
GO

/* return the last order placed */
SELECT MAX(od.orderid) FROM  Sales.[order details] AS OD;
GO

/* return the last order placed with the product id, unit price, and the quantity */
SELECT d.OrderID AS 'Last Order', unitprice, quantity FROM sales.[order details] AS d
WHERE d.orderID = (SELECT max (o.OrderID) FROM sales.orders AS O);
GO

/* return the list of orders placed by customers from Mexico (Ship Country) */
SELECT o.orderid, o.customerid, o.shipcountry FROM Sales.orders AS O
WHERE o.shipcountry='mexico';
GO

/* return the list of orders placed by customers(company name) from Mexico (Ship Country) */
SELECT o.orderid, c.companyname
FROM sales.orders AS o
JOIN Sales.Customers AS c
ON C.customerid=o.customerid;
GO

--nested query
SELECT o.orderid, o.CustomerID
FROM sales.orders AS o
WHERE o.customerid IN (
    SELECT c.customerid FROM sales.customers as C
    WHERE c.country='Mexico'
);
GO

/* correlated sub-query refers to columns of table used in outer table. Correlated sub-query is used to pass a value from the outer query to the inner query to be used as parameter */


/* return orders with the last order date for each employee */
SELECT o1.Orderid, o1.orderdate, o1.employeeid
FROM Sales.orders AS o1
/* JOIN Humanresources.employees AS e
ON o1.employeeid=e.employeeid */
WHERE o1.orderdate=(
    SELECT max(o2.orderdate)
    FROM sales.orders AS O2 
    WHERE o2.employeeid=o1.employeeid
)
ORDER BY o1.employeeid, o1.orderdate
;
GO

/* use the [NOT] [EXISTS] predicate with sub-query to check for any result that returns from a query. EXISTS evaluates whether rows exist, but rather than returns them, it returns true or false  */
SELECT e.employeeid, e.lastname
FROM Humanresources.employees AS e
WHERE(
    SELECT count(*)
    FROM sales.orders AS o
    WHERE o.employeeid=e.employeeid
)>0
;
GO

--using the EXISTS to return the same result
SELECT e.employeeid, e.lastname
FROM Humanresources.employees AS e
WHERE EXISTS (
    SELECT count(*) /* orderid*/
    FROM sales.orders AS o
    WHERE o.employeeid=e.employeeid
/* 	GROUP BY o.orderid */
)
;
GO

-- add yourself  as a new employee
INSERT INTO Humanresources.employees (lastname, firstname) VALUES ('zl', 'Wang')
;
GO

SELECT count(*)
FROM sales.orders AS o
GROUP BY o.employeeid
;

SELECT count(*)
FROM sales.orders AS o
WHERE o.employeeid=10
;

/* return any customer (company name) that has never placed an order */
-- use [NOT] EXISTS clause

SELECT c.customerid, c.companyname
FROM sales.customers AS c
WHERE NOT EXISTS (
    select o.Orderid
    FROM sales.orders AS o
    WHERE c.customerid=o.customerid
)
;
GO

-- use join

SELECT c.customerid, c.companyname
FROM sales.customers AS c
LEFT JOIN sales.orders AS o
ON o.customerid=c.customerid
WHERE o.orderid IS NULL
;
GO