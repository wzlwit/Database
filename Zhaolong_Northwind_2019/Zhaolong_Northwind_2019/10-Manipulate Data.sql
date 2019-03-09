/* Manipulating data in Northwind table
	Script Date: Feb 27, 2019
	Developed by: Zhaolong Wang
*/

--switch to Northwind database
use Northwind2019;
go

/* 1. find customers in London (UK) with Sales Representative contact title */

SELECT CustomerID, CompanyName, City, Country FROM Sales.Customers
    WHERE City='London' AND Country='UK' AND ContactTitle='Sales Representative'
;
GO

/* Example 2
Suppose that you want to see a list of countries where Northwind Traders’ suppliers are located. You want to arrange the countries alphabetically, and within each country you want to list supplier names alphabetically. Create this query and save it as 2_qrySupplierLocations.
 */
SELECT CompanyName, Country FROM Production.Suppliers
    ORDER BY Country ASC, CompanyName ASC
;
GO

/* Example 3
Suppose you want to see the name and location of Northwind Traders’ suppliers from Germany. Create this query and save it as 3_qrySuppliersFromGermany. 
 */
SELECT CompanyName, City, Region, Country FROM Production.Suppliers;

SELECT CompanyName, City, Region, Country FROM Production.Suppliers
    WHERE Country='Germany'
;
GO

/* Example 4
Suppose that you want to display company names of suppliers from Sweden, but you only want to see the company names, not the country, in the result set. Create this query and save it as 4_qrySuppliersLocatedInSweden. 
 */
SELECT CompanyName FROM Production.Suppliers
    WHERE Country='Sweden'
;
GO

/* Example 5
Suppose that you want to view all the fields in the Northwind Order Details table, but you’re interested in seeing only those records with an Order ID greater than 11000. Create this query and save it as 5_qryOrderIDGreaterThan11000.
 */
SELECT * FROM Sales.Orders
    WHERE OrderID>11000
;
GO

/* Example 6
Suppose that you want to find employees how are hired between January 1st and March 31st 2019 (first quarter of 2019). Create this query and save it as 6_qryEmployeesHiredInFirstQuarter2016.  
 */
SELECT * FROM HumanResources.Employees;
SELECT * FROM HumanResources.Employees
    WHERE HireDate BETWEEN '2019-01-01' AND '2019-03-31' -- can use / or format as 'mm/dd/yyyy'
;
GO

/* Example 7
Suppose you want to see Northwind suppliers from Germany or Canada. Create this query and save it as 7_qrySuppliersFromGermanyOrCanada.
 */
SELECT * FROM Production.Suppliers
    WHERE Country IN ('Germany', 'Canada')
;
GO

/* Example 8
Suppose you want to see Northwind suppliers in either the UK (United Kingdom) or Paris. Create this query and save it as 8_qrySuppliersInUKOrParis. 
 */
SELECT * FROM Production.Suppliers
    WHERE Country ='UK' OR City='Paris'
;
GO


/* Example 9
Suppose that you want to find suppliers who have a fax number. Create this query and save it as 9_qrySuppliersWithFaxNumber.
 */
SELECT * FROM Production.Suppliers
    WHERE Fax IS NOT NULL
;
GO

/* Example 10
Suppose that you want to see Northwind Traders customers who are located in Seattle, Kirkland, or Portland. Create this query and save it as 10_qryCustomerCityLocation. 
 */
SELECT * FROM Sales.Customers
    WHERE City IN ('Seattle', 'Kirkland', 'Portland')
;
GO

/* Example 11
Suppose that you want to select a list of countries where Northwind suppliers are located. Create this query and save it as 11_qryDistinctSuppliersCountry. 
 */
SELECT DISTINCT Country FROM Production.Suppliers
ORDER BY Country
;
GO

/* Example 12
Suppose you remeber that a customer's company name start with 'the', but you can't remember the rest of the name. Find all the company namesstarting with 'the'.
 */
 SELECT CompanyName
 FROM Sales.Customers
 WHERE CompanyName LIKE 'The%'
 ;
 GO


 /* using the SELCET INTO statement */
 SELECT ProductName as Product, UnitPrice AS 'Price', (UnitPrice*1.1) AS 'Tax'
 INTO #PriceTable
 FROM Production.Products
 ;
 GO

 USE tempdb;
 GO
 EXECUTE sp_help 'tempdb.#PriceTable'
 ;
 GO