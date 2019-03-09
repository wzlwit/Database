-- create query for task 4  to manipulate the data  of Library database
-- script date: Mars 06,2019
-- Developed by Zhaolong Wang

use Library;
go


/* 1. Create a mailing list of Library members that includes the members� full names and complete address information. */
select CONCAT_WS(', ', M.FirstName, coalesce(M.[Middle_I], ''), M.LastName) as 'Full Name',
	 CONCAT_WS(', ', A.Street, A.City, A.State, A.ZIP) as 'Address'
from [Member].[Members] as M
	inner join [Member].[Adults] as A
		on M.Member_no = A.Member_no
union
select CONCAT_WS(', ', M.FirstName, coalesce(M.[Middle_I], ''), M.LastName) as 'Full Name',
	 CONCAT_WS(', ', A.Street, A.City, A.State, A.ZIP) as 'Address'
from [Member].[Juveniles] as J
	inner join [Member].[Members] as M
		on J.Member_no = M.Member_no
	inner join [Member].[Adults] as A
		on J.[Adult_member_no] = A.Member_no


;
go

/*2. Write and execute a query on the title, item, and copy tables that returns the isbn, 
copy_no, on_loan, title, translation, and cover, and values for rows in the copy table with 
an ISBN of 1 (one), 500 (five hundred), or 1000 (thousand). Order the result by isbn column.
*/

select I.ISBN, C.Copy_no, C.title_no, C.on_loan, T.Title, I.Language, I.cover
from [Operation].[Titles] as T
	inner join[Operation].[Items] as I
		on T.Title_no = I.Title_no
	inner join [Operation].[Copies] as C
		on I.ISBN = C.ISBN
where C.ISBN in (1, 500, 1000)
order by C.ISBN
;
go

/* 3. Write and execute a query to retrieve the member�s full name and member_no 
from the member table and the isbn and log_date values from the reservation table 
for members 250, 341, 1675. Order the results by member_no. You should show information 
for these members, even if they have no books or reserve.
*/
SELECT  CONCAT_WS(', ', M.FirstName, coalesce(M.[Middle_I], ''), M.LastName) as 'Full Name',
	M.Member_no,
	R.ISBN,
	R.Log_Date
FROM [Member].[Members] as M
	left join [Operation].[Reservations] as R
		on M.Member_no = R.Member_no
where M.Member_no in (250, 341, 1675)
order by M.Member_no
;
go


 /*4. Create a view and save it as adultwideView that queries the member
  and adult tables.  Lists the name & address for all adults. */

 
create view member.adultwideView
as

select 
ma.Member_no as 'Member ID',
CONCAT_WS(' ',mm.FirstName,mm.LastName) as 'Full Name',
CONCAT_WS(' ',ma.Street,ma.City,ma.State,ma.ZIP) as 'Full Address',
ma.Expr_Date as 'Date of Expr'
from [Member].[Adults]  as MA
inner join [Member].[Members] as MM
on MA.Member_no = mm.Member_no
;
 go


 select * from member.adultwideView
 ;
 go


 /*5. Create a view and save it as ChildwideView that queries the member, adult,
  and juvenile tables.  Lists the name & address for the juveniles. */

   
create view member.ChildwideView
as

select 
mj.Member_no as 'Member ID',
CONCAT_WS(' ',mm.FirstName,mm.LastName) as 'Full Name',
CONCAT_WS(' ',ma.Street,ma.City,ma.State,ma.ZIP) as 'Full Address',
ma.Expr_Date as 'Date of Expr'
from  [Member].[Juveniles] as MJ 
inner join [Member].[Members] as MM
on MJ.Member_no = mm.Member_no
inner join [Member].[Adults] as MA
on MJ.Adult_member_no=MA.Member_no
;
 go


 select * from member.ChildwideView
 ;
 go


 /* 6. Create a view and save it as and CopywideView that queries the copy,
  title and item tables.  Lists complete information about each copy. 
*/



create view Operation.CopywideView
as

select Oi.ISBN as 'ISBN',
OC.Copy_no as 'Copy number',
ot.Title,
ot.Author,
ot.Description,
oi.Language,
oi.cover,
oc.on_loan  as 'on_loan'
from [Operation].[Copies] as OC 
inner join [Operation].[Items] as OI
on oc.ISBN=oi.ISBN
inner join [Operation].[Titles] as OT
on oc.title_no=ot.Title_no
;
go


select *
from [Operation].[Copies]

select * from Operation.CopywideView
;
go

/* 7. Create a view and save it as LoanableView that queries CopywideView (3-table join). 
 Lists complete information about each copy marked as loanable (loanable = 'Y'). */


 create view Operation.LoanableView
 as

 select  * from Operation.CopywideView
 where on_loan='N'
 ;
 go

 select * from Operation.LoanableView
 ;
 go


 /*8. Create a view and save it as OnshelfView that queries CopywideView (3-table join).
  Lists complete information about each copy that is not currently on loan (on_loan ='N'). */
   create view Operation.OnshelfView
 as

 select  * from Operation.CopywideView
 where on_loan='N'
 ;
 go

 select * from Operation.OnshelfView
 ;
 go

 /* 9 Create a view and save it as OnloanView that queries the loan, title, and member tables. 
 Lists the member, title, and loan information of a copy that is currently on loan. */
 IF OBJECT_ID('Operation.OnloanView', 'V') is not null
	drop view Operation.OnloanView
;
go

create view Operation.OnloanView
 as
 select 
 ot.Title,
 oc.Copy_no as 'Copy Number',
 CONCAT_WS(' ',mm.FirstName,mm.LastName) as 'Full Name',
 ol.out_Date as 'Out Date',
 ol.due_Date as 'Due Date',
 oc.on_loan as 'on_loan'
 
 from [Operation].[Copies] as OC
 inner join [Operation].[Titles] as OT
 on oc.title_no=ot.Title_no
 inner join [Operation].[Loans] as OL
 on oc.ISBN=ol.ISBN and oc.Copy_no=ol.ISBN
 inner join [Member].[Members] as MM
 on ol.Member_no=mm.Member_no
 where oc.on_loan='Y'
 ;
 go



 select * from Operation.OnloanView
 ;
 go

 /* 10. Create a view and save it as OverdueView that queries OnloanView (3-table join.)
  Lists the member, title, and loan information of a copy on loan that is overdue (due_date < current date).   */

  create view Operation.OverdueView
  as

  select * 
  from Operation.OnloanView
  where [Due Date]<GETDATE()
  ;
  go

  select * from Operation.OverdueView
  ;
  go
