/* Create Zhaolong_Northwind Schemas
	Script Date: Feb 22, 2019
	Developed by: Zhaolong Wang
*/

--switch to master database

use Zhaolong_Northwind;
go --include end of batch markers (go statement)

/* create schema
SYTAX
    create obj_type obj_name
    create schema schema_name authorization owner_name 
*/

create schema Sales authorization dbo;
go

create schema HumanResources authorization dbo;
go

create schema Production authorization dbo;
go


