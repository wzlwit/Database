/* Create Zhaolong_Northwind User-Defined Data Types
	Script Date: Feb 22, 2019
	Developed by: Zhaolong Wang
*/

--switch to master database

use Zhaolong_Northwind;
go --include end of batch markers (go statement)

/* create user-defined data types
SYNTAX 
    create type type_name
    from system_data_type constraint(s) 
 */

 create type mySIN
 from varchar(11) null;
 go
 
 create type myAddress
 from varchar(11) not null;
 go

CREATE TABLE Contacts (
  ContactID INT  NOT NULL,
  SIN mySIN,
  myAddress myAddress
);
go

/* retrun the definition of Contacts table */
execute sp_help Contacts;
go