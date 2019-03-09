/* query multiple tables in Northwind table
	Script Date: Feb 28, 2019
	Developed by: Zhaolong Wang
*/

--switch to Northwind database
USE Northwind2019;
GO

ALTER SCHEMA Production TRANSFER [Sales].[Products];
GO

/* return the list of orders placed by customers (company name) */
SELECT CompanyName, o.orderid
FROM Sales.customers As c
    JOIN sales.orders AS o ON (c.customerid=o.customerid)
;
GO

/* Suppose you want to find out customers (Company Name) */

SELECT CompanyName, ProductName
FROM Sales.customers As c
    JOIN sales.orders AS o ON (c.customerid=o.customerid)
    JOIN Sales.[order details] AS d ON (o.orderid=d.orderid)
    JOIN Production.products AS p ON (d.productid=p.productid)
WHERE p.productname LIKE 'Chef Anton''s Cajun Seasoning' -- use ' to escape ', [] not work
;
GO

/* return the list of orders placed by customers (company name) even customer place no orders */
SELECT CompanyName, o.orderid
FROM Sales.customers As c
    LEFT JOIN sales.orders AS o ON (c.customerid=o.customerid)
WHERE o.orderid IS NULL
;
GO

SELECT CompanyName, o.orderid
FROM Sales.customers As c
    LEFT JOIN sales.orders AS o ON (c.customerid=o.customerid)
ORDER BY o.orderid --NULL will be in top rows when ASC order
;
GO

/* Find the total number of products supplied by each supplier (company name) */
SELECT s.CompanyName AS 'Company Name', COUNT(p.productID) AS 'Number of Products'
FROM production.suppliers AS s
    JOIN production.products AS p
    ON (p.supplierid=s.supplierid)
GROUP BY s.CompanyName
ORDER BY 2 ASC
;
GO

/* Find the total number of products supplied by each supplier (Company Name). */

/* Find out the discontinued products. Return the category and product names. */
SELECT productname, categoryname
FROM production.products AS p
    JOIN production.categories AS c
    ON c.categoryid=p.categoryid
WHERE p.discontinued =1
;
GO

/* Find out Suppliers (Company Name) who have supplied more than 4 products. List Suppliers that supplied the most products first. */
SELECT s.CompanyName AS 'Company Name', COUNT(p.productID) AS 'Number of Products'
FROM production.suppliers AS s
    JOIN production.products AS p
    ON (p.supplierid=s.supplierid)
GROUP BY s.CompanyName
HAVING COUNT(p.productID)>4
ORDER BY 2 DESC
;
GO

/* list customers (company name) and orders placed in 2019 */
--using ANSI SQL 89 syntax
SELECT c.CompanyName, o.orderid, o.orderdate
FROM sales.customers AS c, sales.orders AS o
WHERE c.customerid = o.customerid
    AND DatePart(hh, o.orderdate)=0
--can use '0' here
;

--using ANSI SQL 92 syntax
SELECT c.CompanyName, o.orderid, o.orderdate
FROM sales.customers AS c
    JOIN sales.orders AS o
    ON c.customerid = o.customerid
WHERE YEAR(o.orderdate)=2019
--can use '2019'
;

/* return suppliers company name, product name, category name, and order numbers */
SELECT s.CompanyName, p.productName, c.categoryname, d.orderid
FROM production.suppliers AS s
    JOIN Production.products AS p
    ON s.supplierid=p.supplierid
    JOIN Production.categories C
    ON c.categoryid=p.categoryid
    join Sales.[order details] AS d
    ON p.productID=d.productid
;
GO

/* Find out the list of employees that report to Andrew Fuller - supervisor with employee id = 2. Return Supervisor ID, first and last name, as well as Employee ID, first and last name.

	Use a self join when a table references data in itself.
*/
SELECT employeeid, reportsto
FROM humanresources.employees;

SELECT e.employeeid, e.firstname, e.lastname, e.reportsto, s.firstname, s.lastname
FROM humanresources.employees AS e
    JOIN humanresources.employees AS s
    ON e.reportsto=s.employeeid
WHERE e.reportsto=2
;
GO

/* list orders shipped by each shipper company. Return Shipper Company Name, Order ID, and Order Shipped Date */
ALTER SCHEMA Sales TRANSFER [production].[shippers];
GO

SELECT s.companyname, o.orderid, convert(nvarchar(12), o.shippeddate) AS 'ship date', CAST(o.shippedDate AS nvarchar(12))  --we can just use date() function
    FROM sales.orders AS o
    JOIN sales.Shippers AS s
    ON s.shipperid=o.shipvia
;
go    


/* check if there is any order not shipped yet. */
SElECT * FROM sales.orders WHERE shippeddate IS NULL;
GO