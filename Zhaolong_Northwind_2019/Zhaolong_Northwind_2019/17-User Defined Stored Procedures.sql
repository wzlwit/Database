/*  user defined procedure T-SQL functions
	Script Date: Mar 6, 2019
	Developed by: Zhaolong Wang
*/

--switch to Northwind database
USE Northwind2019;
GO

/* create a procedure, HumanResources.getAllEmployeesSP, that returns the employee first name, last name, and title */

CREATE PROCEDURE HumanResources.getAllEmployeesSP
AS
    BEGIN
        SELECT FirstName,LastName,TITLE
        FROM HumanResources.Employees
    END
;
GO

EXEC HumanResources.getAllEmployeesSP @EmployeeID=1;
GO

/* create a procedure, HumanResources.getAllEmployeesSP, that returns the employee first name, last name, and title, selecting the employee number */
ALTER PROCEDURE HumanResources.getAllEmployeesSP(
    @EmployeeID AS INT
)
AS
    BEGIN
        SELECT FirstName,LastName,TITLE
        FROM HumanResources.Employees
        WHERE EmployeeID = @EmployeeID
    END
;
GO

/* create HumanResources.getEmployeeByTitleSP, that returns the employee full name, phone, and title, selecting the Job Title */
ALTER PROCEDURE HumanResources.getEmployeeByTitleSP(
    @title AS varchar(30)
)
AS
    BEGIN
        SELECT concat_ws(' ', FirstName, LastName) 'Full Name', HomePhone 'Phone',Title
        FROM HumanResources.Employees
        WHERE title LIKE '%'+@title+'%' -- concat('%',@title,'%')
    END
;
GO

EXEC HumanResources.getEmployeeByTitleSP 'sales';
GO

/* create HumanResources.getEmployeeByTitleAndCitySP, that returns the employee full name, phone, and title, selecting the Job Title */
 ALTER PROCEDURE getEmployeeByTitleAndCitySP(
    @title AS varchar(30),
    @city AS varchar(15)
)
AS
    BEGIN
        SELECT concat_ws(' ', FirstName, LastName) 'Full Name', HomePhone 'Phone',Title, City
        FROM HumanResources.Employees
        WHERE title LIKE '%'+@title+'%' -- concat('%',@title,'%')
            AND city LIKE '%'+@city+'%'
    END
;
GO

EXEC getEmployeeByTitleAndCitySP 'sales','n';
GO

/* hide the definition of the procedure HumanResources.EncryptedEmplyeesSP */
ALTER PROCEDURE HumanResources.EncryptedEmplyeesSP
WITH ENCRYPTION
AS  
    BEGIN
        SELECT EmployeeID, FirstName, LastName
        FROM HumanResources.Employees
    END
;
GO

EXEC sp_helptext 'HumanResources.EncryptedEmplyeesSP';

/* create a procedure, Production.getProductBySupplierSP, that returns the supplier id, company name, and product name for a specific supplier */

ALTER PROCEDURE Production.getProductBySupplierSP(
    @suppliername AS VARCHAR(20)
)
WITH RECOMPILE
AS 
	BEGIN
        SELECT s.SupplierID, s.CompanyName, p.ProductName
        FROM Production.Suppliers s
        JOIN Production.Products p
        ON s.SupplierID=p.SupplierID
        WHERE s.CompanyName LIKE '%'+@suppliername+'%'
    END
;
GO

EXEC Production.getProductBySupplierSP 'exo';

/* create a procedure, Production.getProductListSP, that returns a list of products with prices that do not exceed a specific amount */
ALTER PROCEDURE Production.getProductListSP(
    @ProductName NVARCHAR(40), -- product name
    @MaxPrice MONEY, --Maximum product price OUTPUT
    @ComparePrice AS MONEY OUTPUT,
    @ListPrice AS MONEY OUT -- OUT / OUTPUT
    -- 
)
AS
 SELECT pp.ProductName 'Product', pp.UnitPrice 'Unit Price'
    FROM Production.Products AS pp
     INNER JOIN Sales.[Order Details] AS sod
     ON pp.ProductID=sod.ProductID
    WHERE pp.ProductName LIKE '%'+@ProductName+'%'
     AND sod.UnitPrice <@MaxPrice
SET @ListPrice=(
    SELECT max(pp.UnitPrice)
    FROM Production.Products pp
        JOIN Sales.[Order Details] AS sod
        ON pp.ProductID=sod.ProductID
        -- WHERE sod.UnitPrice<@MaxPrice
            WHERE pp.ProductName LIKE '%'+@ProductName+'%'
            AND sod.UnitPrice <@MaxPrice
)
-- set the @ComparePrice equal to @MaxPrice
SET @ComparePrice=@MaxPrice
;   
GO

/* tesing the procedure  Production.getProductListSP */
DECLARE @ComparePrice AS MONEY, @Cost AS MONEY
EXEC  Production.getProductListSP 'Mishi', 100, @ComparePrice OUTPUT, @Cost OUT
IF (@Cost <=@ComparePrice)
    BEGIN
        print 'These products can be purchased for less than $'+RTRIM(cast(@ComparePrice AS NVARCHAR(20))) +'.'
    END
ELSE
    BEGIN
        print 'The prices for all products in this category exceed $'+RTRIM(cast(@ComparePrice AS NVARCHAR(20))) +'.'
    END
;
GO

/* create a procedure, Sales.getCountOrdersByCountry, that returns the number of orders placed by customer in a specific year and country */
SELECT *
FROM Sales.Orders

ALter PROCEDURE Sales.getCountOrdersByCountry(
    @country AS NVARCHAR(20),
    @ShippedYear AS INT =2018
)
AS
    BEGIN
        SELECT count(orderid) 'Orders Amount'
        FROM Sales.Orders
		WHERE ShipCity LIKE @country AND year(ShippedDate) =@ShippedYear
    END
;
GO

EXEC Sales.getCountOrdersByCountry 'Canada', 2018
;
GO

        SELECT count(orderid) 'Orders Amount'
        FROM Sales.Orders
		WHERE ShipCity LIKE 'can' AND year(ShippedDate) =2018