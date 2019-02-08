--2
--a)
select f.f_id,f.f_last,f.f_first, f.birthday,d.DeptName,d.location from faculty f, department d where f.DeptID = d.DeptID order by f.f_id;

      F_ID F_LAST          F_FIRST         BIRTHDAY    DEPTNAME                  LOCATION
---------- --------------- --------------- ----------- ------------------------- ---------------
         1 Robertson       Myra            30-Jul-0040 Computer Science          Campus CS
         2 Smith           Neal            12-May-0050 Telecommunication         Campus TEL
         3 Arlec           Lisa            24-Mar-0041 Accounting                Campus AC
         4 Fillipo         Paul            11-Jul-0071 Computer Science          Campus CS
         5 Denver          Paul            09-Jul-0080 Math & Science            Campus MS

		 
b)
select f.f_id,f.f_last,f.f_first, upper(to_Char(f.birthday,'dy, monthdd, yyyy hh:mm:ss A.M.'))"Birthday Format",d.DeptName,d.location from faculty f, department d where f.DeptID (+) = d.DeptID order by f.f_id;



      F_ID F_LAST          F_FIRST         Birthday Format                          DEPTNAME                  LOCATION
---------- --------------- --------------- ---------------------------------------- ------------------------- -------------------------
         1 Robertson       Myra            TUE, JULY     30, 1940 12:07:00 A.M.     Computer Science          Campus CS
         2 Smith           Neal            FRI, MAY      12, 1950 12:05:00 A.M.     Telecommunication         Campus TEL
         3 Arlec           Lisa            MON, MARCH    24, 1941 12:03:00 A.M.     Accounting                Campus AC
         4 Fillipo         Paul            THU, FEBRUARY 11, 1971 12:02:00 A.M.     Computer Science          Campus CS
         5 Denver          Paul            THU, OCTOBER  09, 1980 12:10:00 A.M.     Math & Science            Campus MS
                                                                                    Liberal Arts              Campus LA

6 rows selected.

 select s.s_id,s.s_last,s.s_class,s.birthday,c.CatStudDesc from student s, categorystudent c where s.birthday between c.CatStartDate and c.CatEndDate order by s.s_id;
  
      S_ID S_LAST     S_ BIRTHDAY    CATSTUDDESC
---------- ---------- -- ----------- --------------------
         1 Graham     JR 30-Jul-1980 Generation Y
         2 Sanchez    EX 12-May-1981 Generation Y
         3 White      EX 24-Mar-1987 Generation Y
         4 Phelp      JR 11-Feb-1988 Generation Y
         5 Lewis      SR 09-Oct-1970 Generation X
         6 James      JR 07-Dec-1960 Generation X1

6 rows selected.

d)
select f.f_id,f.f_last,f.f_first,f.birthday,d.deptid,d.deptname,d.location from faculty f,department d where f.deptid = d.deptid and f.birthday between '01-jan-1950' and '01-jan-1972';

      F_ID F_LAST          F_FIRST         BIRTHDAY        DEPTID DEPTNAME                  LOCATION
---------- --------------- --------------- ----------- ---------- ------------------------- -------------------------
         2 Smith           Neal            12-May-1950         20 Telecommunication         Campus TEL
         4 Fillipo         Paul            11-Feb-1971         10 Computer Science          Campus CS

e)
select s.s_id, s.s_last||' '||s.s_first"Student Name",s.soc_ins"Social Secu",upper(s.birthday),f.f_last||' '||f.f_first "Faculty Supervisor" from student s, faculty f where f.f_id=s.f_id;
--order by s.s_id;

      S_ID Student Name          Social Secu BIRTHDAY    Faculty Supervisor
---------- --------------------- ----------- ----------- -------------------------------
         1 Graham Bill           456-123-789 30-jul-1980 Fillipo Paul
         2 Sanchez Jim           654-123-789 12-may-1981 Arlec Lisa
         3 White Peter           456-321-789 24-mar-1987 Arlec Lisa
         4 Phelp David           456-123-987 11-feb-1988 Robertson Myra
         5 Lewis Sheila          456-321-987 09-oct-1970 Smith Neal
         6 James Thomas          654-321-987 07-dec-1960 Robertson Myra

6 rows selected.

f)
column "Information about Students" format a70;
select s.s_id||', '||s.s_last||' '||s.s_first||' born on '||s.birthday||' and having SI number '||s.soc_ins"Information about Students", 'supervised by '||f.f_last||' '||f.f_first||' born on '||f.birthday||' and having SI number '||f.soc_ins"Faculty supervisors" from student s, faculty f where s.f_id=f.f_id;


Information about Students                                             Faculty supervisors
---------------------------------------------------------------------- ---------------------------------------------------------------------------------------
1, Graham Bill born on 30-jul-1980 and having SI number 456-123-789    supervised by Fillipo Paul born on 11-feb-1971 and having SI number 123-456-987
2, Sanchez Jim born on 12-may-1981 and having SI number 654-123-789    supervised by Arlec Lisa born on 24-mar-1941 and having SI number 123-554-789
3, White Peter born on 24-mar-1987 and having SI number 456-321-789    supervised by Arlec Lisa born on 24-mar-1941 and having SI number 123-554-789
4, Phelp David born on 11-feb-1988 and having SI number 456-123-987    supervised by Robertson Myra born on 30-jul-1940 and having SI number 123-456-789
5, Lewis Sheila born on 09-oct-1970 and having SI number 456-321-987   supervised by Smith Neal born on 12-may-1950 and having SI number 321-456-789
6, James Thomas born on 07-dec-1960 and having SI number 654-321-987   supervised by Robertson Myra born on 30-jul-1940 and having SI number 123-456-789

6 rows selected.

g)
select s.s_id,s.s_last,s.s_first,upper(s.birthday)"Std BD",f.f_last,f.f_first,upper(f.birthday)"Fac BD" from student s, faculty f where f.f_id=s.f_id and s.s_id between 2 and 4 order by s.s_id;

      S_ID S_LAST     S_FIRST    Std BD               F_LAST          F_FIRST         Fac BD
---------- ---------- ---------- -------------------- --------------- --------------- --------------------
         2 Sanchez    Jim        12-MAY-1981          Arlec           Lisa            24-MAR-1941
         3 White      Peter      24-MAR-1987          Arlec           Lisa            24-MAR-1941
         4 Phelp      David      11-FEB-1988          Robertson       Myra            30-JUL-1940


h)
select f.f_id,f.f_last,f.f_first,f.birthday"Fac BD",d.deptname,d.location,s.s_last,s.s_first from student s, faculty f, department d where s.f_id=f.f_id and f.deptid=d.deptid order by f.f_id,s.s_last;

      F_ID F_LAST          F_FIRST         Fac BD      DEPTNAME             LOCATION   S_LAST     S_FIRST
---------- --------------- --------------- ----------- -------------------- ---------- ---------- ----------
         1 Robertson       Myra            30-jul-1940 Computer Science     Campus CS  James      Thomas
         1 Robertson       Myra            30-jul-1940 Computer Science     Campus CS  Phelp      David
         2 Smith           Neal            12-may-1950 Telecommunication    Campus TEL Lewis      Sheila
         3 Arlec           Lisa            24-mar-1941 Accounting           Campus AC  Sanchez    Jim
         3 Arlec           Lisa            24-mar-1941 Accounting           Campus AC  White      Peter
         4 Fillipo         Paul            11-feb-1971 Computer Science     Campus CS  Graham     Bill

6 rows selected.


i)
select f.f_id,f.f_last,f.f_first,f.birthday"Fac BD",d.deptname,d.location,s.s_last,s.s_first from faculty f, student s,department d where f.f_id=s.f_id(+) and f.deptid(+)=d.deptid order by f.f_id;

      F_ID F_LAST          F_FIRST         Fac BD      DEPTNAME             LOCATION   S_LAST     S_FIRST
---------- --------------- --------------- ----------- -------------------- ---------- ---------- ----------
         1 Robertson       Myra            30-jul-1940 Computer Science     Campus CS  Phelp      David
         1 Robertson       Myra            30-jul-1940 Computer Science     Campus CS  James      Thomas
         2 Smith           Neal            12-may-1950 Telecommunication    Campus TEL Lewis      Sheila
         3 Arlec           Lisa            24-mar-1941 Accounting           Campus AC  White      Peter
         3 Arlec           Lisa            24-mar-1941 Accounting           Campus AC  Sanchez    Jim
         4 Fillipo         Paul            11-feb-1971 Computer Science     Campus CS  Graham     Bill
         5 Denver          Paul            09-oct-1980 Math & Science       Campus MS
                                                       Liberal Arts         Campus LA

8 rows selected.


j)
select s.s_id,s.s_last,s.s_first,c.course_no,c.course_name,e.grade"GR",f.f_last||' '||f.f_first"Faculty Supervisor" from student s, faculty f, course c,enrollment e where s.f_id=f.f_id and e.s_id=s.s_id and e.course_no = c.course_no and e.s_id in (1,3,6) order by s.s_id;

      S_ID S_LAST     S_FIRST    COURSE_ COURSE_NAME               GR    Faculty Supervisor
---------- ---------- ---------- ------- ------------------------- ----- -------------------------------
         1 Graham     Bill       MIS 101 Intro. To Info. Systems   A+    Fillipo Paul
         3 White      Peter      MIS 651 Advanced Java             C+    Arlec Lisa
         3 White      Peter      CS 155  Programming in C++        B-    Arlec Lisa
         3 White      Peter      MIS 301 Systems Analysis          B-    Arlec Lisa
         6 James      Thomas     MIS 651 Advanced Java             C+    Robertson Myra
         6 James      Thomas     MIS 551 Advanced Web              B+    Robertson Myra

6 rows selected.


k)
select s.s_id,s.s_last,s.s_first,upper(s.birthday)"Std BD",s.soc_ins,c.course_no,c.course_name,e.grade"GR",f.f_first||' '||f.f_last"Faculty Supervisor" from student s, faculty f, enrollment e, course c where s.f_id=f.f_id and e.s_id=s.s_id and e.course_no = c.course_no and s.soc_ins like '456%' order by s.birthday desc,e.grade desc;

      S_ID S_LAST     S_FIRST    Std BD               SOC_INS     COURSE_ COURSE_NAME               GR    Faculty Supervisor
---------- ---------- ---------- -------------------- ----------- ------- ------------------------- ----- ------------------------
         4 Phelp      David      11-FEB-1988          456-123-987 CS 155  Programming in C++        B-    Myra Robertson
         4 Phelp      David      11-FEB-1988          456-123-987 MIS 551 Advanced Web              B+    Myra Robertson
         4 Phelp      David      11-FEB-1988          456-123-987 MIS 441 Database Management       A-    Myra Robertson
         3 White      Peter      24-MAR-1987          456-321-789 MIS 651 Advanced Java             C+    Lisa Arlec
         3 White      Peter      24-MAR-1987          456-321-789 CS 155  Programming in C++        B-    Lisa Arlec
         3 White      Peter      24-MAR-1987          456-321-789 MIS 301 Systems Analysis          B-    Lisa Arlec
         1 Graham     Bill       30-JUL-1980          456-123-789 MIS 101 Intro. To Info. Systems   A+    Paul Fillipo
         5 Lewis      Sheila     09-OCT-1970          456-321-987 MIS 301 Systems Analysis          B-    Neal Smith
         5 Lewis      Sheila     09-OCT-1970          456-321-987 MIS 451 Web-Based Systems         A+    Neal Smith

9 rows selected.


l)
column "Student Birthday" format a40;
column "Faculty Supervisor" format a15;
select s.s_id,s.s_last,s.s_first,upper(to_Char(s.birthday,'dy, month dd, yyyy hh:mm:ss a.m.'))"Student Birthday",s.soc_ins,f.f_last||' '||f.f_first"Faculty Supervisor",d.deptname,d.location from student s, faculty f, department d where s.f_id=f.f_id and f.deptid=d.deptid and s.soc_ins like '456%789';

      S_ID S_LAST     S_FIRST    Student Birthday                         SOC_INS     Faculty Supervi DEPTNAME             LOCATION
---------- ---------- ---------- ---------------------------------------- ----------- --------------- -------------------- ----------
         3 White      Peter      TUE, MARCH     24, 1987 12:03:00 AM      456-321-789 Arlec Lisa      Accounting           Campus AC
         1 Graham     Bill       WED, JULY      30, 1980 12:07:00 AM      456-123-789 Fillipo Paul    Computer Science     Campus CS


m)		 
select s.s_id,s.s_last,s.s_first,upper(to_Char(s.birthday,'dy, month dd, yyyy hh:mm:ss a.m.'))"Student Birthday",s.soc_ins,c.course_no,c.course_name,e.grade"GR",f.f_last||' '||f.f_first"Faculty Supervisor" from student s, faculty f, course c,enrollment e where s.f_id=f.f_id and e.course_no=c.course_no and s.s_id=e.s_id and s.birthday between '01-jan-1970' and '31-dec-1981' order by s.birthday desc;

      S_ID S_LAST     S_FIRST    Student Birthday                         SOC_INS     COURSE_ COURSE_NAME               GR    Faculty Supervi
---------- ---------- ---------- ---------------------------------------- ----------- ------- ------------------------- ----- ---------------
         2 Sanchez    Jim        TUE, MAY       12, 1981 12:05:00 AM      654-123-789 MIS 441 Database Management       A-    Arlec Lisa
         2 Sanchez    Jim        TUE, MAY       12, 1981 12:05:00 AM      654-123-789 MIS 451 Web-Based Systems         A+    Arlec Lisa
         1 Graham     Bill       WED, JULY      30, 1980 12:07:00 AM      456-123-789 MIS 101 Intro. To Info. Systems   A+    Fillipo Paul
         5 Lewis      Sheila     FRI, OCTOBER   09, 1970 12:10:00 AM      456-321-987 MIS 451 Web-Based Systems         A+    Smith Neal
         5 Lewis      Sheila     FRI, OCTOBER   09, 1970 12:10:00 AM      456-321-987 MIS 301 Systems Analysis          B-    Smith Neal

		 
n)
select s.s_id,s.s_last,s.s_first,upper(to_Char(s.birthday,'dy, month dd, yyyy hh:mm:ss a.m.'))"Student Birthday",s.soc_ins,c.course_no,c.course_name,e.grade"GR",f.f_last||' '||f.f_first"Faculty Supervisor" from student s, faculty f, course c,enrollment e where s.f_id=f.f_id and e.course_no=c.course_no and s.s_id=e.s_id and s.birthday between '01-jan-1970' and '31-dec-1981' and s.soc_ins like '%123%' order by s.birthday desc;

      S_ID S_LAST     S_FIRST    Student Birthday                         SOC_INS     COURSE_ COURSE_NAME               GR    Faculty Supervi
---------- ---------- ---------- ---------------------------------------- ----------- ------- ------------------------- ----- ---------------
         2 Sanchez    Jim        TUE, MAY       12, 1981 12:05:00 AM      654-123-789 MIS 441 Database Management       A-    Arlec Lisa
         2 Sanchez    Jim        TUE, MAY       12, 1981 12:05:00 AM      654-123-789 MIS 451 Web-Based Systems         A+    Arlec Lisa
         1 Graham     Bill       WED, JULY      30, 1980 12:07:00 AM      456-123-789 MIS 101 Intro. To Info. Systems   A+    Fillipo Paul

		 