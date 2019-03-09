/* Create indexes in Zhaolong_Nortwind
	Script Date: Feb 27, 2019
	Developed by: Zhaolong Wang
*/

--switch to master database

use Zhaolong_Northwind;
go

/* Syntax:
1. Create a non-clustered index on a table (base table) or a view (virtual table) 
    create obj_type obj_name
    create nonclustered index index_name ON tb_name (col_name)

2. create a clustered index oa a table
    create clustere index index_name ON tb_name (col_name)
 */

/* retrieve index information on table Sales.Customers */
EXECUTE sp_helpindex 'Sales.[Order Details]';
GO

/* the index_id is unique only within the object */
SELECT * FROM sys.indexes;
GO

SELECT
    name, -- Name of the index. Name must be unique
    index_id, --The ID of the index: 0->Heap, 1->Clustered, >1->non-clustered index
    type, -- Type of index: 0->Heap, 1->Clustered, 2->non-clustered, 3->XML, 4-> Special
    type_desc, -- Description of the index
    is_unique, -- 1-> index is unique, 0-> index is not unique
    is_primary_key -- 1-> index is a part of a primary key constraint
FROM sys.indexes
WHERE object_id=OBJECT_ID('Sales.Customers')
;
GO

/* Check if indexes exist in the HumanResources.Employees table */
EXECUTE sp_helpindex 'HumanResources.Employees';
GO

/* Create a non clustered index (ncl_LastName) on the employee last name */
CREATE NONCLUSTERED INDEX ncl_LastName ON HumanResources.Employees (LastName);
GO

/* Drop index */
DROP INDEX HumanResources.Employees.ncl_LastName;
GO

/* create a unique non-clustered index u_nclProductName on the table Production.Products */
CREATE UNIQUE NONCLUSTERED INDEX u_nclProductName ON Production.Products;
GO
