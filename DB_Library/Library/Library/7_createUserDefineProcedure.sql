-- create user define procedure to generating usage report of Library database
-- script date: Mars 06,2019
-- Developed by Bianyu WANG(1896181) , Hongyu ZHAO(1895825), Yangyang MA(1896156), Zhaolong Wang(1896216 ) 

--  switch to the Library database
-- add a statement that specifies the script runs in the context of the Library database


use Library;
go


/*
 create a view to union Table Loan and LoanHist

 */

if OBJECT_id('Operation.unionLoanAndLoanHist','v') is not null
drop view Operation.unionLoanAndLoanHist
;
go

create view operation.unionLoanAndLoanHist

as 

		select 
		h.ISBN,h.Copy_no,h.Member_no,h.out_Date,h.title_no,h.due_Date,'On Loan' as 'Status'
		from [Operation].[Loanhist] as h

		union

		select 
		l.ISBN,l.Copy_no,l.Member_no,l.out_Date,l.title_no,l.due_Date,'Closed' as 'Status'
		from  [Operation].[Loans] as l
;
go

-- test view operation.unionLoanAndLoanHist

select * from operation.unionLoanAndLoanHist
;
go
 
/*1. How many loans did the library do last year?*/


if OBJECT_id('Operation.getLoanNumberFn','fn') is not null
drop function Operation.getLoanNumberFn
;
go


create function Operation.getLoanNumberFn
(
--declaire parameter(s)
@AnalyseYear as datetime
)
 returns int
 as
	begin
		declare @NumberOfLoanOpen as int = 
		(select count(*) 
		from operation.unionLoanAndLoanHist -- use view created on the top of this script
		where year([out_Date])= @AnalyseYear
		)

	return @NumberOfLoanOpen
	end
;
go


-- use Operation.getLoanNumberFn

select  [Operation].[getLoanNumberFn](2007) as 'Total Loans'
;
go


/*
2. What percentage of the membership borrowed at least one book?
*/


if OBJECT_id('operation.percentageOfActiveMembersSP','sP') is not null
drop procedure operation.percentageOfActiveMembersSP
;
go



create procedure operation.percentageOfActiveMembersSP
(
@AnalyseYear as int
)
as 

begin 

-- get all active members from loan and loanHist

declare @activeMember int = (

	select count(distinct A.Member_no) from 
	 
	 operation.unionLoanAndLoanHist as A -- view create at the beginning of this script
	
	where year(A.out_Date)=@AnalyseYear

)

-- total number of members in the library

declare @totalMember as int=
	(
	select count(mm.Member_no)
	from [Member].[Members] as MM
	)

select ltrim(cast(@activeMember*1.0*100/@totalMember as decimal(5,2)))+'%' 

end
;
go


exec operation.percentageOfActiveMembersSP @analyseYear='2007'
;
go



/*
3. What was the greatest number of books borrowed by any one individual? 
*/

if OBJECT_id('operation.popularBooksFn','fn') is not null
drop function operation.popularBooksFn
;
go



create function operation.popularBooksFn()
returns table

as return
(
select count(v.title_no) as 'Total number of Loan', ot.title
from operation.unionLoanAndLoanHist as v
inner join [Operation].[Titles] as ot
on v.title_no=ot.Title_no
group by  v.title_no , ot.title

having   count(v.title_no)= 
(
select top 1 count(title_no)
from operation.unionLoanAndLoanHist 
group by title_no
order by count(title_no) desc
)

)
;
go

select * from operation.popularBooksFn()
;
go


/*4. What percentage of the books was loaned out at least once last year*/

if OBJECT_id('Operation.percentageOfLoanedSP','sp') is not null
drop procedure Operation.percentageOfLoanedSP
;
go


create procedure Operation.percentageOfLoanedSP
(
@analyseYear as datetime
)
as

begin 
-- how many books in the library
	declare @totalBook int=
	(
	select count(*) from [Operation].[Copies] 
	)
-- how many books was loaned out at analysed year
	declare @bookLoanded int=
	(
	select Count(distinct CONCAT_ws('/',[ISBN],[Copy_no])) 
	from operation.unionLoanAndLoanHist  -- view defined at the begin of this script
	where year([out_Date])= @analyseYear
	)

 select ltrim(cast(@bookLoanded*1.0*100/@totalBook as decimal(5,2)))+'%'  as 'percentage of the books was loaned '

 end
 ;
 go

 
 -- test procdure Operation.percentageOfLoanedSP
exec Operation.percentageOfLoanedSP @analyseYear=2007
;
go


/*5. What percentage of all loans eventually becomes overdue?*/

if OBJECT_id('Operation.percentageOverDueSP','sp') is not null
drop procedure Operation.percentageOverDueSP
;
go


create procedure Operation.percentageOverDueSP
as

begin

	declare @overdueBooksOnLoan int =(
		select count(*)
		from [Operation].[Loans]
		where [due_Date]< GETDATE()
		)

	declare @overdueBooksClosed int =(
	    select count(*)
		from [Operation].[Loanhist]
		where [in_Date]> [due_Date]
	)

	declare @totalLoan int=
	(
	select count(*) from Operation.unionLoanAndLoanHist
	)

	select ltrim(cast((@overdueBooksOnLoan+@overdueBooksClosed)*1.0*100/@totalLoan as decimal(5,2)))+'%'  as 'percentage of overdue loan'

end;
go

exec  Operation.percentageOverDueSP;



/*6. What is the average length of a loan?*/

if OBJECT_id('Operation.averageLoan','fn') is not null
drop function Operation.averageLoan
;
go


create function Operation.averageLoan()
returns int
as

begin
declare @average int =
 (select avg(abs(DATEDIFF(day,[in_Date],[out_Date]))) from [Operation].[Loanhist])
 return @average
end
;

--- test function Operation.averageLoan()

select  Operation.averageLoan() as ' average length of a loan';



/*7. What are the library peak hours for loans? */

if OBJECT_id('Operation.peakHours','fn') is not null
drop function Operation.peakHours
;
go

create function  Operation.peakHours()
returns table

as return
(
select 
datepart(hour,out_date) as 'Peak hour',
COUNT(datepart(hour,out_date)) as 'Number of Activity'
from  Operation.unionLoanAndLoanHist 
group by datepart(hour,out_date)
)
;
go

-- test function operation.peakhours()

select * from operation.peakhours()
;
go


