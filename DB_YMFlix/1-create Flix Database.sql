/*Create the flix (DVDRENTALS) Database
 script date: February 15, 2019
*/

/* SYNTAX:
  create object_type object_name
  where object_type: database, table, view, function, and so on
  */
  
  create database if not exists YMFlix
  ;
  GO
  
  /*switch to the current database -YMFlix
   SYNTAX: use database_name;
   */
   
   use YMFlix
   ;
  -- using schema clause to create a database 
  -- create a schema is the same as create a database in MySQL server, but not in microsoft SQL SERVER
  CREATE database mydb1
  ;
  use mydb1
  ;
  GO

  create schema Sales
  ;
  GO
  /*delete a database
  SYNTAX: drop object_type object_name
  */
  
  drop database mydb1
  ;
  drop database sales
  ;
  