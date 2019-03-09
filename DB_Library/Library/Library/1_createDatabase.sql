-- create Library database
-- script date: february 26,2019
-- Developed by Zhaolong Wang

--switch to master database
use master
;
go --include end of batch markers(go statement)


 create database Library
  on primary
  (
  -- rows data file name
  name='Library',
  -- row data path and filename
  -- filename='C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Library\Library.mdf',
  filename = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\library.mdf',
  --rows fata file size
  size= 12MB,
  -- rows data file growth
  filegrowth=2mb,
  -- rows data maximum size
  maxsize=100mb
  )
  log on
  (
  --logicl log file name 
  name='Library_log',
  --log path and filename
  -- filename='C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Library\Library.ldf',
   filename = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\library.ldf',
  --log file size
  size= 3MB,
  -- log file growth
  filegrowth=10%,
  -- log maximum size
  maxsize=25mb
  )
  ;
  go





 execute sp_helpdb Library
  ;
  go
