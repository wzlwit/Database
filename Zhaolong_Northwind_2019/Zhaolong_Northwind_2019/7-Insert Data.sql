/* Insert data into Zhaolong_Nortwind
	Script Date: Feb 27, 2019
	Developed by: Zhaolong Wang
*/

--switch to master database

use Zhaolong_Northwind;
go

/* to insert multiple rows from an external object */
DELETE FROM Sales.Customers;
GO

BULK INSERT Sales.Customers
FROM 'C:\Users\ipd\OneDrive - John Abbott College\DatabaseII\ExerciseInClass\Zhaolong_Northwind_2019\Northwind_Data\Customers.csv'
WITH (
    FORMAT='CSV',
    FIRSTROW=2
    
    /* ,
    ROWTERMINATOR='\n',
    FIELDTERMINATOR='\t' */
);
GO

/* INSERT INTO schema_name.table_name 
VALUES (val1, val2,...)
;
GO */

-- a better way
/* 
INSERT INTO schema_name.table_name (col1, col2,...)
VALUES (val1, val2,...)
;
GO */

/* insert data from another table */
/* INSERT INTO Sales.Customers (col1,col2,...)
SELECT (col1, col2,...) --()is optional
FROM Sales.Suppliers */

;
GO

