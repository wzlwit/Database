USE master;

CREATE DATABASE Zhaolong_Northwind
ON PRIMARY(		
	name='Zhaolong_Northwind',-- rows data file name
	filename='C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Zhaolong_Northwind.mdf',-- rows data path and filename
	size=12MB,	-- rows data file size
	filegrowth=2MB,	-- rows data file grow
	maxsize=100MB -- or INLIMITED; -- rows data maximum size
)
log on(
	name='Zhaolong_Northwind_log',	-- logical filename
	filename='C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Zhaolong_Northwind_log.ldf',	-- log path and filename
	size=3MB,	-- log file size
	filegrowth=10%,	-- log file groth
	maxsize=25MB	-- log maximum size
);