/* Transfer tables from one to another schema
	Script Date: Feb 27, 2019
	Developed by: Zhaolong Wang
*/

--switch to Northwind database

use Northwind2019;
go

/* 8  Transfer tables from one to another schema
    Alter schema to_schema_name TRANSFER FROM from_schema_name.tb_name
*/


-- 1. categories
ALTER SCHEMA Production TRANSFER dbo.Categories;
GO

ALTER SCHEMA HumanResources TRANSFER [dbo].[Territories];
GO

ALTER SCHEMA Production TRANSFER [dbo].[Suppliers];
GO

ALTER SCHEMA Production TRANSFER [dbo].[Shippers];
GO

ALTER SCHEMA HumanResources TRANSFER [dbo].[Region];
GO

ALTER SCHEMA Production TRANSFER [dbo].[Products];
GO

ALTER SCHEMA Sales TRANSFER [dbo].[Orders];
GO

ALTER SCHEMA Sales TRANSFER [dbo].[Order Details];
GO

ALTER SCHEMA HumanResources TRANSFER [dbo].[EmployeeTerritories];
GO

ALTER SCHEMA HumanResources TRANSFER [dbo].[Employees];
GO

ALTER SCHEMA Sales TRANSFER [dbo].[Customers];
GO

ALTER SCHEMA Sales TRANSFER [dbo].[CustomerDemographics];
GO

ALTER SCHEMA Sales TRANSFER [dbo].[CustomerCustomerDemo];
GO

