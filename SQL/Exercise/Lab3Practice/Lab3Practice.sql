--exercise for Review 3 Database
select s_last"Student Last", s_first"Student First", soc_ins"Social Security",birthday from student;

--e)
Student Last    Student First   Social Secu BIRTHDAY
--------------- --------------- ----------- ---------
Graham          Bill            456-123-789 30-JUL-80
Sanchez         Jim             654-123-789 12-MAY-81
White           Peter           456-321-789 24-MAR-87
Phelp           David           456-123-987 11-FEB-88
Lewis           Sheila          456-321-987 09-OCT-70
James           Thomas          654-321-987 07-DEC-60

--f)
select s_id||', '||s_last||' '||s_first||' born on '||birthday|| ' and having SI number '||soc_ins "Information about Students" from student;

Information about Students
--------------------------------------------------------------------------------
1, Graham Bill born on 30-JUL-80 and having SI number 456-123-789
2, Sanchez Jim born on 12-MAY-81 and having SI number 654-123-789
3, White Peter born on 24-MAR-87 and having SI number 456-321-789
4, Phelp David born on 11-FEB-88 and having SI number 456-123-987
5, Lewis Sheila born on 09-OCT-70 and having SI number 456-321-987
6, James Thomas born on 07-DEC-60 and having SI number 654-321-987

6 rows selected.

--g)
Select s_id, s_last"Student Last", s_first"Student FIRST", soc_ins"Social Secu", birthday from student where s_id between 2 and 4;

      S_ID Student Last    Student FIRST   Social Secu BIRTHDAY
---------- --------------- --------------- ----------- ---------
         2 Sanchez         Jim             654-123-789 12-MAY-81
         3 White           Peter           456-321-789 24-MAR-87
         4 Phelp           David           456-123-987 11-FEB-88

		 
--h)
Select s_id, s_last"Student Last", s_first"Student FIRST", soc_ins"Social Secu", birthday from student where s_id in (1,3,6);

      S_ID Student Last    Student FIRST   Social Secu BIRTHDAY
---------- --------------- --------------- ----------- ---------
         1 Graham          Bill            456-123-789 30-JUL-80
         3 White           Peter           456-321-789 24-MAR-87
         6 James           Thomas          654-321-987 07-DEC-60

Select s_id, s_last"Student Last", s_first"Student FIRST", soc_ins"Social Secu", birthday from student where s_id not in (1,3,6);

      S_ID Student Last    Student FIRST   Social Secu BIRTHDAY
---------- --------------- --------------- ----------- ---------
         2 Sanchez         Jim             654-123-789 12-MAY-81
         4 Phelp           David           456-123-987 11-FEB-88
         5 Lewis           Sheila          456-321-987 09-OCT-70

--i) not ordered in the picture of PDF lab-review
Select s_id, s_last"Student Last", s_first"Student FIRST", soc_ins"Social Secu", birthday from student where soc_ins like '456%'
	order by birthday asc;

      S_ID Student Last    Student FIRST   Social Secu BIRTHDAY
---------- --------------- --------------- ----------- ---------
         5 Lewis           Sheila          456-321-987 09-OCT-70
         1 Graham          Bill            456-123-789 30-JUL-80
         3 White           Peter           456-321-789 24-MAR-87
         4 Phelp           David           456-123-987 11-FEB-88
		 
		 

--j)
Select s_id, s_last"Student Last", s_first"Student FIRST", soc_ins"Social Secu", birthday from student where soc_ins like '456%789' order by birthday asc;

      S_ID Student Last    Student FIRST   Social Secu BIRTHDAY
---------- --------------- --------------- ----------- ---------
         1 Graham          Bill            456-123-789 30-JUL-80
         3 White           Peter           456-321-789 24-MAR-87

--k)		 
Select s_id, s_last"Student Last", s_first"Student FIRST", soc_ins"Social Secu", birthday from student where birthday between '01-JAN-70' and '31-DEC-81' order by birthday asc;

      S_ID Student Last    Student FIRST   Social Secu BIRTHDAY
---------- --------------- --------------- ----------- ---------
         5 Lewis           Sheila          456-321-987 09-OCT-70
         1 Graham          Bill            456-123-789 30-JUL-80
         2 Sanchez         Jim             654-123-789 12-MAY-81
		 
--i)
Select s_id, s_last"Student Last", s_first"Student FIRST", soc_ins"Social Secu", birthday from student where birthday between '01-JAN-70' and '31-DEC-81' and soc_ins like '%-123-%' order by birthday asc;

      S_ID Student Last    Student FIRST   Social Secu BIRTHDAY
---------- --------------- --------------- ----------- ---------
         1 Graham          Bill            456-123-789 30-JUL-80
         2 Sanchez         Jim             654-123-789 12-MAY-81
