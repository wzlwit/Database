/* Modify and update data of table
	Script Date: Feb 27, 2019
	Developed by: Zhaolong Wang
*/

--switch to Northwind database
use Northwind2019;
go

/* update data 
Syntax:
    update schema_name.obj_name 
        SET obj_name = exp
*/
SELECT * FROM Sales.orders;
GO

/* update  [OrderDate] [RequiredDate] and [ShippedDate]
    1998 -> 2019
    1997 -> 2018
    1996 -> 2017
    by adding 21 years
*/

/* using DATEADD(datepart, number, date) */

UPDATE Sales.Orders
    SET OrderDate=dateadd(year, 21, OrderDate)
    -- WHERE 
;
GO

UPDATE Sales.Orders
    SET RequiredDate=dateadd(year, 21, RequiredDate),
        ShippedDate=dateadd(year, 21, ShippedDate)
    -- WHERE 
;
GO

SELECT * FROM Sales.Orders;
GO

/* update HumanResources.Employees table 
    HireDate:
    1994 -> 2019
    1993 -> 2018
    1992 -> 2017
*/
UPDATE HumanResources.Employees
    SET HireDate=dateadd(year, 25,HireDate)
;
GO
UPDATE HumanResources.Employees
    SET BirthDate=dateadd(year, 20,BirthDate)
;
GO

SELECT * FROM HumanResources.Employees;
GO

