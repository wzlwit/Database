/*  create user-defined T-SQL functions
	Script Date: Mar 5, 2019
	Developed by: Zhaolong Wang
*/

--switch to Northwind database
USE Northwind2019;
GO

/* create a function, Production.getInventoryStockFn, that takes one input value, a Product ID, and returns a single data value, the aggregated quantity of the specified product in inventory */

/* check for function existence */
IF object_id('Production.getInventoryStockFn','Fn') IS NOT NULL
	DROP FUNCTION Production.getInventoryStockFn
;
GO

SELECT ProductID, ProductName, UnitsInStock, UnitsOnOrder, Production.getInventoryStockFn(ProductID) AS 'Stock Level'
FROM Production.Products
WHERE ProductID IN (1,3,5)
;


ALTER FUNCTION Production.getInventoryStockFn (
-- declare parameters
    @ProductID AS INT
)
RETURNS INT
AS
BEGIN
    -- retrun the stock leve for products
    -- declare a variable
    DECLARE @StockLevel AS INT
    SELECT @StockLevel=pp.UnitsInStock+pp.UnitsOnOrder
    FROM Production.Products AS pp
    WHERE pp.ProductID=@ProductID
    -- return the result to the function caller

    IF (@StockLevel IS NULL)
        BEGIN
        SET @StockLevel=0
    END
    RETURN @StockLevel
END
;
GO

DROP FUNCTION [Production].[getInventoryStockFn];
GO

SELECT Production.getInventoryStockFn(6) AS 'Invetory'
;
GO


/* create a function, HumanResources.getEmployeeSeniorityFn, that returns the employee seniority. Drop the function if exists and re-create it */

IF object_id('HumanResources.getEmployeeSeniorityFn','Fn') IS NOT NULL  DROP FUNCTION HumanResources.getEmployeeSeniorityFn
;
GO

CREATE FUNCTION HumanResources.getEmployeeSeniorityFn(
    -- declare a parameter: @para_name AS data_type [=expression]
    @HireDate AS DATETIME
)
RETURNS INT
AS
    BEGIN
    -- declare the return variable
    DECLARE @Seniority AS INT
    -- computer the return value
    SELECT @Seniority=abs(dateDiff(year, @hireDate,getDate()))
    --we can use set for SELECT
    -- return the result to the function caller
    RETURN @Seniority
END
;
GO

SELECT HumanResources.getEmployeeSeniorityFn('2020/11/14')
;
GO

/* display the seniority of Northwind employees */
SELECT EmployeeID, FirstName, LastName, Title, HireDate, HumanResources.getEmployeeSeniorityFn(HireDate) AS 'Seniority'
FROM HumanResources.Employees
-- WHERE EmployeeID=1
WHERE Title like 'Sales Rep%'
ORDER BY 'Seniority' DESC
;
GO

/* create a table-valued function TVF
Function Types:
IF - SQL Inline table-valued function
TF - SQL table-valued function
FN - SQL scalar function
*/

/* create a function, Sales.getOrderDetailsFn, that takes one argument (OrderID) and returns the order details as table-valued result. Include Order ID and Product Name
 */
CREATE FUNCTION Sales.getOrderDetailsFn(
    --  declare parameter
     @OrderID AS INT
 )
RETURNS TABLE
AS
    RETURN(
        SELECT sod.orderid, pp.productname, sod.quantity, sod.Unitprice, sod.discount
FROM Production.Products AS pp
    JOIN Sales.[Order Details] AS sod
    ON pp.ProductID=sod.ProductID
WHERE @OrderID= sod.OrderID

    )
;
GO

/* Create a function, Sales.getOrderDetailsByDateFn, That takes date parameters and returns the order details as table-valued result by specifying a date range. Include Order ID and Product Name */

CREATE FUNCTION Sales.getOrderDetailsByDateFn(
    @StartDate AS datetime, 
    @EndDate AS datetime
)
RETURNS table
AS
    RETURN
    (SELECT sod.orderid, pp.productname, sod.quantity, sod.Unitprice, sod.discount
FROM Production.Products AS pp
    JOIN Sales.[Order Details] AS sod
    ON pp.ProductID=sod.ProductID
    JOIN Sales.orders AS SO
    ON so.orderid=sod.orderid
WHERE so.orderdate between @StartDate AND @EndDate)
;
GO


select *
from sales.getOrderDetailsByDateFn('1/1/2019','3/31/2019')
;
GO

/* create a function Sales.getNmberOfDaysFn, that returns the number of days between the order date and the ship date */
ALTER FUNCTION Sales.getNmberOfDaysFn(
    @orderdate AS datetime,
    @shippeddate AS datetime
)
RETURNS INT
AS
    BEGIN
		DECLARE @NumberOfDays AS INT = abs(dateDiff(day, @orderdate, @shippedDate))
		RETURN @NumberOfDays
	END
;
GO


SELECT Sales.getNmberOfDaysFn('3/1/2019', GETDATE());
GO

/* create a function, HumanResources.getEmployeeFullNameFn, that returns the full name of an employee */
CREATE FUNCTION HumanResources.getEmployeeFullNameFn(
    @id AS INT
)
RETURNS VARCHAR(100)
AS
    BEGIN
        DECLARE @fname AS VARCHAR(100)
        SELECT @fname=concat_ws(', ', LastName, FirstName)
        FROM HumanResources.Employees
        WHERE Employeeid=@id;
        RETURN @fname;
    END
;
GO

/* tesing HumanResources.getEmployeeFullNameFn */
SELECT employeeid, HumanResources.getEmployeeFullNameFn(EmployeeID)
FROM HumanResources.Employees
ORDER BY EmployeeID
GO

UPDATE HumanResources.Employees 
SET LastName='Wang', FirstName='zl'
WHERE EmployeeID=10;