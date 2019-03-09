USE AdventureWorks2017
;
GO

SELECT *
FROM sales.customer;

SELECT
	soh.OrderDate AS 'Date',
	soh.SalesOrderNumber AS 'Order',
	pps.Name AS 'Subcategory',
	pp.Name AS 'Product',
	sum(sod.OrderQty) AS 'Quantity',
	sum(sod.LineTotal) AS 'LineTotal'
FROM Sales.SalesPerson AS sp
	INNER JOIN Sales.SalesOrderHeader AS soh
		ON sp.BusinessEntityID=soh.SalesPersonID
	INNER JOIN Sales.SalesOrderDetail AS sod
		ON sod.SalesOrderID=soh.SalesOrderID
	INNER JOIN Production.Product AS pp
		ON sod.ProductID=pp.ProductID
	INNER JOIN Production.ProductSubcategory AS pps
		ON pp.ProductSubcategoryID=pps.ProductSubcategoryID
	INNER JOIN Production.ProductCategory AS ppc
		ON ppc.ProductCategoryID=pps.ProductCategoryID
GROUP BY soh.OrderDate ,
	soh.SalesOrderNumber,
	pps.Name,
	pp.Name,
	ppc.Name
HAVING ppc.Name='Clothing'
;
GO