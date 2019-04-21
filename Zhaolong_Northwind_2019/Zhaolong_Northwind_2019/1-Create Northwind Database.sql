/* Create Zhaolong_Northwind Database
	Script Date: Feb 22, 2019
	Developed by: Zhaolong Wang
*/

/* In order to create a new database, switch to the master database */

/* Add a statement that specifies the script runs in the context of the master database */

--switch to master database

USE master;
go -- include end of batch markers (go statement)

/* SYNTAX to create a databse
	CREATE obj_name obj_type
	CREATE DATABASE db_name
*/

CREATE DATABASE Zhaolong_Northwind
ON PRIMARY
(
	
	-- rows data file name
	name='Zhaolong_Northwind',
	-- rows data path and filename
	filename='C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Zhaolong_Northwind.mdf',
	-- rows data file size
	size=12MB,
	-- rows data file grow
	filegrowth=2MB,
	-- rows data maximum size
	maxsize=100MB -- or INLIMITED
)
log on(
	-- logical filename
	name='Zhaolong_Northwind_log',
	-- log path and filename
	filename='C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Zhaolong_Northwind_log.ldf',
	-- log file size
	size=3MB,
	-- log file groth
	filegrowth=10%,
	-- log maximum size
	maxsize=25MB
)
;
go

 /* return the informaton about Zhaolong_Northwind database */
--  all system stored procedures start with SP_ prefix
execute sp_helpdb Zhaolong_Northwind
;
go

/* increase the size of Zhaolong_Northwind rows data file */

-- switch to MASTER database 
USE master
;
go

alter database Zhaolong_Northwind
	modify file(
		name='Zhaolong_Northwind',
		maxsize=50MB
	)
;
go

/* system function */
/* determine which activity is yours */
select @@spid as 'SP ID' --no matter @@SPID or @spid
;
go

/* who is the USER */
execute sp_who 52
;
go

/* what SQL server version you are running? Retrieve the connection, database context, and server information */

select @@version;
go

USE Zhaolong_Northwind;
select 
	user_name() as 'user Name',
	db_name() as 'database name',
	@@servername as 'server name'
;
go

USE master;
go --go outsied of the database to be dropped

/* drop MyDatabase 1 database */
drop database myDatabase1;
go