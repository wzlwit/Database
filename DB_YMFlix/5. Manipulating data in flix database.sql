/*Manipulating the flix (DVDRENTALS) Database
 script date: February 19, 2019
*/

-- switch to ymdatabase
use ymflix
;

/* to answer any question about yout data, follow these steps:
1. read the questions
2. determin objects
3. column
4. run
5. define criteria, and run
*/

/* list all dvd id, name, and year released */
select DVDID, DVDName, YearRlsd
from dvds
;

/* 2. list all dvd id, name released in 2001*/
select DVDID, DVDName
from dvds
where YearRlsd = '2001'
;

/*
select *
from customers
where city like 'montreal'
order by
group by
;
*/

/* 3. list all dvd id, names that have more than one disk*/
select DVDID, DVDName
from dvds
where NumDisks > 1
;

-- using alias
/* rewrite the previoius script using aliases */
select D.DVDID as 'DVD ID', 
       D.DVDName as 'DVD Name',
	   D.NumDisks as 'Number of Disks'
from dvds as D
where D.NumDisks > 1
;

/* change the column names in the result set of the table Employees. EmpID- Employee ID */
select E.EmpID as 'Employee ID',
	   E.EmpFN as 'Employee First Name'
       
from employees as E
;

/* RETURN THE EMPLOYEE FULL NAME AS A SINGLE STRING, using the concatenation operator (+) */
select 
	concat(E.empfn, ' ', E.empmn,' ', E.empln) as 'full name'
from employees as E
;

-- using coalesce function
select 
	concat(E.empfn, ' ', coalesce(E.empmn, ''),' ', E.empln) as 'full name'
from employees as E
;

-- using concat_ws() function
select 
	concat_ws(' ', E.empfn, coalesce(E.empmn, ''), E.empln) as 'full name'
from employees as E
;

/* how many orders placed by each customer, list them from the highest to the lowest */
select O.CustID as 'Customer',
       count(O.OrderID) as 'Number of Orders'
from orders as O
group by O.CustID
order by count(O.OrderID) desc
;

select *
from transactions
;

/* change the date in to February 19, 2019 for the transaction id number 1 */
/* syntax:
	update object_name
    set column_name = expression
    where (condition)
*/
update transactions
set datein = '2019/02/19'
where TransID = 1
;

/* change the date due to date out plus 5 days for the transaction id number 2 */
update transactions
set DateDue = DateOut + interval 5 day
where TransID = 2
;

/* return dvd id, dvd name and rating description */
select D.DVDID as 'DVD ID', 
       D.DVDName as 'DVD Name',
       R.RatingDescrip as 'rating description'
from dvds as D inner join ratings as R
on D.RatingID = R.RatingID
;

/* find out rating with no dvds */
select D.DVDID as 'DVD ID', 
       D.DVDName as 'DVD Name',
       R.RatingDescrip as 'rating description'
from dvds as D right join ratings as R
on D.RatingID = R.RatingID
where D.DVDName is null
;
select *
from ratings
;

/* return dvd id, dvd name, rating description and studio description */
select D.DVDID as 'DVD ID', 
       D.DVDName as 'DVD Name',
       R.RatingDescrip as 'rating description',
       S.studdescrip as 'studio description'
from dvds as D 
	inner join ratings as R
		on D.RatingID = R.RatingID
	inner join studios as S
		on D.StudID = S.StudID
;

/* return dvd id, dvd name, rating description, studio description, status description, movie type description and format description*/
create view DVDView
as 
select D.DVDID as 'DVD ID', 
       D.DVDName as 'DVD Name',
       R.RatingDescrip as 'rating description',
       S.studdescrip as 'studio description',
       Sta.StatDescrip as 'status description',
       M.MTypeDescrip as 'movie type description',
       F.FormDescrip as 'format description'
from dvds as D 
	inner join ratings as R
		on D.RatingID = R.RatingID
	inner join studios as S
		on D.StudID = S.StudID
	inner join status as Sta
		on D.StatID = Sta.StatID
	inner join movietypes as M
		on D.MTypeID = M.MTypeID
	inner join formats as F
		on D.FormID = F.FormID
	
;

select *
from dvdview
;