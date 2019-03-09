/*  work with views in Northwind table
	Script Date: Mar 1, 2019
	Developed by: Zhaolong Wang
*/

--switch to Northwind database
USE Northwind2019;
GO


SELECT * FROM [sys].[all_views];

/* return the definition of the sys.all_views */
EXECUTE sp_help 'sys.all_views';
GO

/* using the information_schema */
SELECT * FROM information_schema.views;
GO


/* Syntax:
    create view schema_name.view_name 
    [WITH ENCRIPTION]
    AS 
    SELECT col1, col2,... FROM obj_name
*/

/* create an employee view (EmployeeView) that returns first and last name. delete the object if exists and re-create it (ONLY ON DEVELOPMENT ENVIRONMENT.*/

IF ojbect_id('humanResources.employeeview','v') IS NOT NULL
    DROP VIEW HumanResources.EmployeeView
GO;

CREATE VIEW humanResources.EmployeeView
AS
SELECT e.firstname, e.lastname FROM humanResources.employees AS e
;
GO

/* modify the HumanResources.EmployeeView by adding the employee id and title */
ALTER VIEW humanResources.EmployeeView
AS
SELECT e.employeeid, e.firstname, e.lastname, e.title FROM humanResources.employees AS e
;
GO

SELECT * FROM humanResources.EmployeeView;
GO

/* change the column headings in the humanResources.EmployeeView: GivenName, FamilyName, JobTitle */
ALTER VIEW humanResources.EmployeeView 
AS
SELECT e.employeeid, e.firstname AS 'GivenName', e.lastname AS 'FamilyName', e.title AS JobTitle FROM humanResources.employees AS e
;
GO

ALTER VIEW humanResources.EmployeeView (Employeeid,GivenName,FamilyName,JobTitle)
AS
SELECT e.employeeid, e.firstname, e.lastname , e.title FROM humanResources.employees AS e
;
GO

/* view the definition of the HumanResources.EmployeeView*/

EXECUTE sp_helptext 'HumanResources.EmployeeView'
;
GO

/* protect the definition of the HumanResources.EmployeeView */
ALTER VIEW humanResources.EmployeeView (Employeeid,GivenName,FamilyName,JobTitle)
WITH ENCRYPTION
AS
SELECT e.employeeid, e.firstname, e.lastname , e.title FROM humanResources.employees AS e
;
GO

/* create the order total view (OrderTotalView) that returns the sum of each order */

CREATE VIEW Sales.OrderTotalView
AS
SELECT orderid, convert(money, SUM (unitPrice*Quantity*(1-discount))) AS Total
    FROM sales.[order details]
    GROUP BY orderid
;
GO

/* what is the grand total of the order number 10248  */
SELECT * FROM Sales.OrderTotalView
WHERE orderid=10248;
GO

/* create the contact customer view (Sales.CustomerContactNameView) that returns the contact name and title */
CREATE VIEW Sales.CustomerContactNameView
AS
    SELECT CompanyName, ContactName, ContactTitle
    FROM sales.customers;
GO

SELECT * FROM Sales.CustomerContactNameView;
GO

/* modify Sales.CustomerContactNameView and add the customer id and phone*/

ALTER VIEW Sales.CustomerContactNameView
AS
    SELECT CustomerID, CompanyName, ContactName, ContactTitle, Phone
    FROM sales.customers;
GO
