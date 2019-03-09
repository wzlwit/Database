-- create daily functions, using trigger, function or procedures forLibrary database
-- script date: Mars 07,2019
-- Developed by Zhaolong Wang

use Library;
go

-- 1. Uniquely Identifying Books

/*2. Reserving Books 
	if 4 books reserved, message,
	if <4, insert one record in Reservations
*/
create procedure Operation.BookReservPr(
    @member_no smallint, @isbn smallint
)
AS
    declare @reserved int =
            (select count(member_no) from Operation.Reservations
            where member_no=@member_no
        )
    if (@reserved>=4)
		begin
			print 'You have already booked 4 books!'
		end
	else
		begin
            insert into Operation.Reservations values(
                    @isbn, @member_no, getdate(),null
            )
            print 'You successfully reserved'
        end
;
go

--test
exec Operation.BookReservPr @isbn=1, @member_no=1;
--You have already booked 4 books!

exec Operation.BookReservPr @isbn=5, @member_no=5;
--(1 row affected)
--You successfully reserved

select * from Operation.Reservations where datediff(day, log_date,getdate())=0;
--ISBN	Member_no	Log_Date				Rmarks	
--5		5			2019-03-07 14:51:06.327	NULL

delete from Operation.Reservations where datediff(day, log_date,getdate())=0; --delete the record for test in Reservations table
--(1 row affected)



/*3. Librarians must be able to determine how many copies of a book are out on loan at any given time and which books are on reserve.*/

 --   determine how many copies of a book are out on loan

create view operation.OnloanBookTitle
as 
	select 
		ot.Title_no,
		ot.title  as 'title',
		count(*) as 'copies on loan'
	from [Operation].[Copies] as oc
	inner join [Operation].[Titles] as ot
	on oc.title_no=ot.Title_no
	where oc.on_loan='y'
	group by ot.Title_no,oc.title_no,ot.title
	;
go

-- determine  how many reservtions for the book with the same title. 
create view operation.OnReserveBookIsbn
as 

select count (ore.isbn) as 'Numbers on Reservatin'  ,
 	ot.Title as 'title'
from [Operation].[Reservations] as ore
inner join [Operation].[Items] as ij 
on ore.ISBN=ij.ISBN
inner join [Operation].[Titles] as ot
on ij.Title_no=ot.Title_no
group by 
 ot.Title
 ;
 go


 -- full join the results from two views abouve.
create procedure operation.stutesOfBooks
as
begin
	select
		olv.title as 'Title',
		isnull(olv.[copies on loan],'0') as 'copies on loan',
		isnull(orv.[Numbers on Reservatin],'0') as 'Numbers on Reservatins'
	from operation.OnloanBookTitle as olv
	full join operation.OnReserveBookIsbn as orv
	on olv.title=orv.title
end
 ;
 go

 -- test the procedure operation.stutesOfBooks
 exec operation.stutesOfBooks;
 --Title					copies on loan	Numbers on Reservations
 --De La Terre a La Lune	40				0



/* 4. enrolling members */
--procedure to check who is 18 years old today and delete the record for Juveniles table
create procedure Member.GrownUpPr
as
	delete Member.Juveniles
	where datediff(day, dateadd(year,18,Birth_Date),getdate())>=0
;
go

--delete record from Juveniles table, (transfered to Adults)
create trigger Member.GrownUpTr
on Member.Juveniles
after delete
as	
/* 	declare @member_no as int = (select member_no from deleted)
	declare @adult_member_no as int =(select adult_member_no from deleted) 
*/
	insert into Member.Adults 
		select d.Member_no, a.Street, a.City, a.State, a.ZIP,a.PhoneNo, dateadd(year,1,getdate())
		from deleted as d
		inner join Member.Adults as a
		on d.Adult_member_no=a.Member_no
    
    --exec sp_send_dbmail -- send emails to the juvenile
;
go

--test delete and add to adult
delete Member.Juveniles where Member_no=18;
select * from Member.Adults where Member_no=18;
--18	Race Track Road	Harrisburg	PA	17100     	001-000-000-0000	2020-03-07 15:47:00.573

exec Member.GrownUpPr;
--(3334 rows affected)
--(3334 rows affected)

select * from Member.Juveniles order by Birth_Date;
--12	11	2002-01-06 23:18:07.000


-- add job and job_step
/* 
EXEC sp_add_job  
    @job_name = N'check grow up' ;  
GO  
EXEC sp_add_jobstep  
    @job_name = N'check grow up',  
    @step_name = N'delete 18years old',  
    @subsystem = N'TSQL',  
    @command = N'exec Member.GrownUpPr',   
    @retry_attempts = 2,  
    @retry_interval = 5 ;  
GO  
EXEC sp_add_schedule  
    @schedule_name = N'RunDaily',  
    @freq_type = 4, --daily  
    @active_start_time = 233000 ;  
USE msdb ;  
GO  
EXEC sp_attach_schedule  
   @job_name = N'check grow up',  
   @schedule_name = N'RunDaily';  
GO  
EXEC sp_add_jobserver  
    @job_name = N'check grow up';  
GO
 */


/*5 Checking Out Books */


/*--5.1  information about the member?s account, such as name, address, phone number, and the card?s expiration date. 
 cards that have expired or are about to expire will be highlighted.  
information about a member?s outstanding loans, including title, checkout date, and due date.
 with the most overdue loan appearing first and the most recent loan appearing last. 
 Highlighting also indicates loans that are overdue or are about to become overdue.  
 
 */

create procedure operation.memberLoanInforSP(
	@memberID as int)
as 
begin
    declare @checkAdult int =(
		select count(*) from member.adultwideView
			where [Member ID]= @memberID)
	if  (@checkAdult=0)	
	begin
		select 
			cv.[Member ID],
			cv.[Full Name],
			cv.[Full Address],
			cv.[Date of expr],
			case
				when cv.[Date of expr] < GETDATE() THEN 'MEMBER EXPR'
				when DATEDIFF(MONTH,cv.[Date of expr], getDate())<1 THEN 'EXPE SOON'
				else ' '
			end as 'Warning',
			ot.Title,
			ol.out_Date as 'Check out Date',
			ol.due_Date as 'Due Date',
			case
				when ol.due_Date < GETDATE() THEN 'OVER DUE'
				when DATEDIFF(day,ol.due_Date, getDate())<4 THEN 'Over due soon'
				else ' '
			end as 'Warning'
		from Member.ChildwideView cv
		inner join [Operation].[Loans] as ol
		on cv.[Member ID]=ol.Member_no
		inner join [Operation].[Titles] as ot
		on ol.title_no=ot.Title_no
		where [Member ID]= @memberID
		order by DATEDIFF(day,ol.due_Date, getDate()) desc
	end
	else 
  	begin 
   		select 
			mav.[Member ID],
			mav.[Full Name],
			mav.[Full Address],
			mav.[Date of expr],
			CASE
				WHEN mav.[Date of expr] < GETDATE() THEN 'MEMBER EXPR'
				WHEN DATEDIFF(MONTH,mav.[Date of expr], getDate())<1 THEN 'EXPE SOON'
				else ' '
			END AS 'Warning',
			ot.Title,
			ol.out_Date as 'Check out Date',
			ol.due_Date as 'Due Date',
			CASE
				WHEN ol.due_Date < GETDATE() THEN 'OVER DUE'
				WHEN DATEDIFF(day,ol.due_Date, getDate())<7 THEN 'OVER DUE SOON'
				else ' '
    		END AS 'Warning'
		from Member.adultwideView as  mav
		inner join [Operation].[Loans] as ol
		on mav.[Member ID]=ol.Member_no
		inner join [Operation].[Titles] as ot
		on ol.title_no=ot.Title_no
		where [Member ID]= @memberID
		order by DATEDIFF(day,ol.due_Date, getDate()) desc
	end
end
;
go

exec Operation.memberLoanInforSP @memberId=2158  --2158,1534

	
-- Members are allowed to have only four books checked out at a time. operation.BookOut allowed librarian to 
-- check if member has four books in hand
	
create procedure operation.BookOutSP(
	@memberID as int,
	@ISBN as int,
	@copy_no as int,
	@title_no as int
 )
as
begin
	declare @numberOfBooksOnLoan int =(
		select count(*) from Operation.Loans
		where Member_no=@memberID
	)
	-- check if Members already have four books in hand
	if (@numberOfBooksOnLoan>=4)
		print ('this member have already checked out FOUR Books!')
	else 
	begin 
	    declare @Status nchar(1) =(
			select on_loan from [Operation].[Copies]
			where ISBN=@ISBN and copy_no=@copy_no
		)
		if (@Status='y')
			print ('this Books is on loaned or reserved')
		else
		begin --- 1. insert data into table loans  2.update on_loan filed in table copies
			insert into [Operation].[Loans] values(
				@ISBN ,@copy_no, @title_no,@memberID,GETDATE(), dateadd(day,14,GETDATE())
			)
				update [Operation].[Copies] set [on_loan]='y'
				where ISBN=@ISBN and Copy_no=@copy_no;
		end
   end
end
;
go 


-- test operation.BookOut
exec operation.BookOutSP @memberID=2158,
                       @ISBN =111,
					   @copy_no =1,
					   @title_no =1

;
go

/*
 after insert the data into table loans, check if this member reserved this book, if yes, delete the data from table reservations
*/

create trigger operation.BookOutTR on [Operation].[Loans]
after insert
as
begin
	declare @reserved int =(
		select count(*) from[Operation].[Reservations]
		where ISBN=(select isbn from inserted) and Member_no=(select  Member_no from inserted)
	)
	if (@reserved >0)
 		delete from [Operation].[Reservations]
		where ISBN=(select isbn from inserted) and Member_no=(select  Member_no from inserted)
end ;
go




/** 
6  Checking In Books
*/

-- show the book's information when checked in
create function Operation.CheckInFn(
    @isbn int, @copy_no int
)
returns table
AS
    return(
		select l.isbn, t.Title, t.Author, m.[Member_no], CONCAT_WS(', ', m.LastName, m.FirstName) as 'Full Name'
		from Operation.Loans as l
		join Operation.Titles as t
		on l.title_no=t.title_no
		join Member.Members as m
		on l.member_no=m.member_no
		where l.isbn=@isbn and l.copy_no=@copy_no
	)
;
go

--test
select * from Operation.CheckInFn(1,5);
go
/*
isbn	Title					Author					Member_no	Full Name
1		Last of the Mohicans	James Fenimore Cooper	1534		Brooke, William
*/


--trigger after deleting record from loan, which means the copy is returned.
create trigger Operation.CheckInTr
on Operation.Loans
after delete
as
	insert into Operation.LoanHist --returned information to Loanhist
		select ISBN, Copy_no, out_Date, title_no, Member_no, due_date, getdate() as 'In Date',
			case 
				when datediff(day,due_date,getdate())>0 then datediff(day,due_date,getdate())*0.5 --$0.5 a day, lol
				else null
			end,
			null,null,null
		from deleted

	--check the Reservations table and/or update the Copies table to set the copy loanable again
	declare @isbn int=(select isbn from deleted)
	declare @copy_no int =(select Copy_no from deleted)
	
	-- get the longest member that reserves this returned book (isbn)
	declare @reserved int = ( 
		select top 1 member_no from Operation.Reservations
			where isbn=@isbn order by log_date asc
		)

	if (@reserved= null)--no resevation
		update Operation.Copies set  on_loan='N' --loanable
			where isbn=@isbn and Copy_no=@copy_no
	else print 'some people has reserved the book, Member Number is: '+@reserved
		--sp_send_dbemail, don't set the Copies table to be 'N' for the copy
;
go

--test @reserved
declare @reserved int = (
		select top 1 member_no from Operation.Reservations
			where isbn=1 order by log_date asc
		)
select @reserved;


--test delete one record from Loans table
delete Operation.Loans where isbn=3 and copy_no=3;
--no record in loans for 3, 3
--Copies table: on_loan = N for 3,3


--create the procedure for check in
create procedure Operation.CheckInPr(
    @isbn int, @copy_no int
)
as
	select * from Operation.CheckInFn(@isbn,@copy_no)
	
	delete Operation.Loans
		where isbn=@isbn and copy_no=@copy_no
;
go

--test
exec Operation.CheckInPr 2,4 ;
--2	Last of the Mohicans	James Fenimore Cooper	1235	Barr, Katie			--show the book information to checkin
select * from Operation.Loans;
-- no record for  isbn=2, copy_no=4
select * from Operation.Loanhist order by in_date desc;
--ISBN	Copy_no	out_Date					title_no	Member_no	due_Date					in_Date						Fine_assessed
--2		4		2007-12-29 23:18:08.000		1			936			2008-01-12 23:18:08.000		2019-03-07 18:27:50.423		2036.00


-- 7 usage report
-- please refer to '7_createUserDefineProcedure'


select * from Operation.Copies;
select * from Operation.Reservations;
select * from Member.Members;
select * from Member.Juveniles order by Birth_Date;
select * from Operation.Loans;
select * from Operation.Loanhist order by in_date desc;

