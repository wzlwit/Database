/*  Working with Build-in T-SQL functions
	Script Date: Mar 4, 2019
	Developed by: Zhaolong Wang
*/

--switch to Northwind database
USE Northwind2019;
GO

/* some of T-SQL data functions */
SELECT
    OrderId AS 'Order',
    OrderDAte AS 'Order Date',
    year(OrderDate) AS 'Order Year',
    month(OrderDate) AS 'Order Month',
    day(OrderDate) AS 'Order Day',
    datePart(year, OrderDate) AS 'Year Date Part',
    datePart(Month, OrderDate) AS 'Month Date Part',
    datePart(Day, OrderDate) AS 'Day Date Part',
    datePart(Weekday, OrderDate) AS 'Week day Part',
    datePart(dayofyear, OrderDate) AS 'Day of year date Part',
    datename(dayofyear, OrderDate) AS 'Day of year date Part',
    EoMonth(OrderDate) AS 'End of Month'
--end of month
FROM Sales.Orders

/* return all orders placed in 2018 and 2019 */
SELECT
    OrderId AS 'Order',
    OrderDAte AS 'Order Date',
    dateName(day,orderdate)
FROM Sales.Orders
WHERE datepart(year, orderdate) IN ('2018','2019')
--or using between

/* some of T-SQL logical functions */
/* IsNumeric(expression) -returns 1 when the input expression evaluates to a valid data type, otherwise it returns 0. */

/* return employee names and postal code with numeric values */
SELECT FirstName, LastName, PostalCode
FROM HumanResources.employees
WHERE IsNumeric(PostalCode)=1
;
GO


/* IIF(expression) -Immediate if function returns one of two values depending on whetherthe boolean expression evaluate to true or false 
    IIF ((condition), true_value, false_value)
    iif ((gender='f'), 'Female', 'Male')
*/
/* return 'Low Price' if the product unit price is bless than $50, otherwise retrun 'High Price' */

SELECT ProductID, productname, unitprice, iif((unitprice<50), 'Low Price','Hight Price')
FROM Production.products

/* case expression evaluates a list of items and returns one of multiple result expression */
SELECT productid, ProductName, UnitPrice,
    'Price Range'= --we can put label at top
    CASE
    -- when condition then expression
        WHEN UnitPrice=0 then 'Out of Stock - Item not available'
        WHEN UnitPrice<50 then 'Unit Price Under $50'
        WHEN UnitPrice BETWEEN 50 AND 250 THEN 'Unit Price Under $250'
        ELSE 'Unit Price Over $1000'
    END
FROM Production.Products
;
GO

-- ! decode way
SELECT productid, ProductName, UnitPrice,
    CASE unitprice
    -- when condition then expression
        WHEN 0 then 'Out of Stock - Item not available'
        WHEN 40 then 'Unit Price is $40'
        ELSE 'Unit Price'
    END
    AS 'Price Range'
FROM Production.Products
;
GO

/* choose function - returns values at the specified index from a list of values
    SYNTAX: choose(index, value1, value2, ...) - index is one-based
 */

SELECT choose(2,'Manager','Programmer','Developer','Analyst','Tester')
 ;
 GO

SELECT CategoryID, CategoryName,
    choose(CategoryID,'A','B','C','D','E') AS 'Category'
--if not enough values, shows "NULL"
FROM Production.Categories
;
go

/* retrun customer address */
SELECT CustomerID, CompanyName, Address, City, Region, PostalCode, Country
FROM Sales.Customers

/* retrun customer full address */
SELECT CustomerID, CompanyName, (Address +' '+City
+' '+ Region+' '+ PostalCode+' '+ Country)
FROM Sales.Customers
;
GO

/* IsNull() function - replace null with the specified replacedment value.
    SYNTAX: IsNull(check_expression, replacement_value)
 */
SELECT CustomerID, CompanyName, (Address +' '+City
+' '+ isNull(Region,'')+' '+ PostalCode+' '+ Country)
FROM Sales.Customers
;
GO

/* re-write the previous script using concat() function */
SELECT CustomerID, CompanyName, concat(Address ,' ',City
,' ', isNull(Region,''),' ', PostalCode,' ', Country)
FROM Sales.Customers
;
GO

/* re-write the previous script using coalesce() function */
SELECT CustomerID, CompanyName, coalesce(Address ,' ',City
,' ', isNull(Region,'-'),' ', PostalCode,' ', Country)
FROM Sales.Customers
;
GO

--Apply to SQL Server version 2017 and above
--concat_ws()
SELECT CustomerID, CompanyName, concat_ws(' ',Address ,City
, isNull(Region,'-'), PostalCode, Country)
FROM Sales.Customers
;
GO

/* some of Aggregate functions */
--how many orders were taken by each employee in 2019. List them from the highest to the lowest
SELECT o.EmployeeID, concat_ws(', ',e.LastName,e.firstname) AS 'Employee', count(orderID) AS 'Counts of Orders'
FROM sales.orders AS o
    JOIN humanresources.employees AS e
    ON o.EmployeeID=e.EmployeeID
WHERE year(orderdate)=2019
GROUP BY o.Employeeid, concat_ws(', ',e.LastName,e.firstname)
ORDER BY [Counts of Orders] desc --using alias by []
;
GO


/* return the list of customers (Company Name) who placed more than 10 orders. Add Employee Full Name */
SELECT /* concat_ws(', ',e.LastName,e.firstname) AS 'Employee', */ c.customerid, c.companyName, count(o.orderid) AS 'Counts of Orders'
FROM sales.orders AS o
    /*     JOIN humanresources.employees AS e
    ON o.EmployeeID=e.EmployeeID */
    JOIN sales.customers AS c
    ON o.customerid =c.customerid
WHERE year(o.orderdate)=2019
GROUP BY c.customerid,c.CompanyName/* ,concat_ws(', ',e.LastName,e.firstname) */
HAVING count(o.orderid)>5
ORDER BY [Counts of Orders] desc --using alias by []
;
GO

/* some of string functions:
    left([col_name], number)
    right([col_name],number)
    substring([colname],start[,end]) // start from 1
*/

/* return the first 3 character of employee first name */
SELECT Employeeid, left(firstname,3) AS 'Left', right(lastname, 4) AS 'Right'
FROM humanresources.employees
;
GO

SELECT Employeeid, substring(firstname,1,3) AS 'First Name'
FROM humanresources.employees
;
GO

/* return the area code of customers in Brazil */
SELECT substring(phone,2,2)
FROM sales.customers
WHERE country='brazil'

/* return the area code of suppliers in Canada, USA, and Mexico */
SELECT CompanyName, City, Phone, substring(phone,2,3) AS 'Area Code'
FROM Production.Suppliers
WHERE country  IN ('Canada','USA','Mexico')

/* return the database name 
    SELECT db_name AS ' ', db_id() AS 'Database ID'
 */
SELECT db_name() AS 'Databaase Name ', db_id() AS 'Database ID'
;
GO

/* return the current user, session user, system user, and user name */
SELECT current_user, session_user, system_user, user_name()
;
GO

/* find out the employee seniority (how many years an employee works in this company) */
SELECT concat_ws(', ', lastname, firstname) AS 'Employee',
    datediff(year, hiredate, getdate()) AS 'Seniority'
FROM HumanResources.employees
ORDER BY [Seniority] DESC
-- or 'Seniority'

/* how long it took to ship orders in 2019. List them from the longest to shortest values */
SELECT Orderid, CustomerID, orderdate, shippedDate, abs(datediff(day, orderdate, shippedDate)) AS 'Days to take'
FROM sales.orders
WHERE year(OrderDate)= 2019 AND shippedDate IS NOT NULL
ORDER BY 'Days to take' DESC

/* convert from one data type to another: cast() and convert() functions
if the data types are incompatible, cast will return an error
*/

SELECT cast(sysdatetime() as datetime);

SELECT cast('20190403' AS INT);

/* convert()
    convert(data_type, value, [style_number])
 */
SELECT convert(char(10),current_timestamp,103) AS 'British/French',
    convert(char(10),current_timestamp,104) AS 'German',
    convert(char(10),current_timestamp,105) AS 'Italian Style',
    convert(char(10),current_timestamp,112) AS 'ISO',
    convert(char(10),current_timestamp,110) AS 'USA'
;
GO

/* using parse and try_parse functions */
SELECT 
    PARSE('04/03/2019' AS DATETIME USING'en-us') AS 'US date',
    PARSE('04/03/2019' AS DATETIME USING'fr-fr') AS 'France date',
    PARSE('04/03/2019' AS DATETIME USING'fr-ca') AS 'Canada French',
    PARSE('04/03/2019' AS DATETIME USING'en-ca') AS 'Canada English'
;
GO

SELECT 
    TRY_PARSE('13/9/2019' AS DATETIME USING 'en-us') AS 'US Date',
    TRY_PARSE('13/9/2019' AS DATETIME USING 'fr-fr') AS 'Fr Date'
;

/* international language supported in SQL server */
EXECUTE sp_helplanguage
;
GO

/* @@LangID -returns the local language identifier (ID) of the language that is currently being used */
SELECT @@LangID as 'Language ID';

SET LANGUAGE 'Simplified Chinese'; -- set default language

SET LANGUAGE 'us_english';
DECLARE @today AS DATETIME
SET @today ='03/04/2019'
;
SELECT datename(month, @today) AS 'Month Name';
GO

EXECUTE sp_helplanguage French
;
GO

SELECT dateName(month, orderdate) AS 'Month'
FROM Sales.Orders
WHERE OrderID=10248;

SELECT (isNull(N'SO' +convert(nvarchar(8),OrderID), N'***ERROR')) --N means national
FROM Sales.Orders
;
GO

/* for more information about Built-In T-SQL functions, visit https://docs.microsoft.com/en-us/sql/t-sql/functions */