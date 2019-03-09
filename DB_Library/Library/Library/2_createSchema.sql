-- create schema of Library database
-- script date: february 26,2019
-- Developed by Bianyu WANG(1896181) , Hongyu ZHAO(1895825), Yangyang MA(1896156), Zhaolong Wang(1896216 ) 

-- in order to create schema, switch to the Library database
-- add a statement that specifies the script runs in the context of the Library database



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


