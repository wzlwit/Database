-- create schema of Library database
-- script date: february 26,2019
-- Developed by Zhaolong Wang

use Library;
go

-- create schema
/*

syntex:
 create  object_type object_name
create schema schema_name authorization owner_name 
*/

-- create sales, humanResources, and production schema
create schema Member authorization dbo;
go

create schema Operation authorization dbo;
go


