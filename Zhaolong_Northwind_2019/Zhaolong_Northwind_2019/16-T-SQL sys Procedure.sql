/*  use sys procedure T-SQL functions
	Script Date: Mar 6, 2019
	Developed by: Zhaolong Wang
*/

--switch to Northwind database
USE Northwind2019;
GO

/* retrieve the list of database on the SQL server */
EXECUTE sp_databases;
GO

/* data type supported by SQL server */
EXECUTE sys.sp_datatype_info
;
GO

/*  */
EXEC sp_helpdb 'zhaolong_northwind';
GO

/* retrieve the definition of a user object, for example Customers table */
EXEC sp_help 'sales.customers'
;
GO

EXEC sp_helptext '[Sales].[CustomerContactNameView]'
;
GO

EXEC sp_tables @table_owner='Sales', @table_name='Orders'
;
GO

/* return contraint(s) for orders table */
EXEC sp_helpconstraint 'Sales.Orders'
;
go

/* 
    1.write queries that retrieve sys meta data 
    2.using sys catalog view
    3. using standard information schema views
    4. using sys function
    */

/* view server settings using sys views and functions */

SELECT name, value, value_in_use, description FROM sys.configurations;
GO

/* retrive the list of databases on the SQL server */
SELECT name,database_id,collation_name,user_access,user_access_desc,state_desc FROM sys.databases

/* list the user-defined tables, (without 'AS' is ok)*/
SELECT s.name 'Schema Name', t.name 'Table Name', t.type_desc 'Table Description', t.create_date 'Created Date'
    FROM sys.tables AS t 
    INNER JOIN sys.schemas AS S
    ON t.schema_id=s.schema_id
ORDER BY s.name, t.name;
;
GO

/* information schema views */
SELECT * FROM information_schema.views;
GO

SELECT * FROM information_schema.view_column_usage;
GO

EXEC sp_stored_procedures;
GO
