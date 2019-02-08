--@'D:\Session I\Database\Lab5Command\registration\'


select student.s_last,student.s_first,faculty.f_last from student, faculty where student.f_id = faculty.f_id;
--the order of student,faculty or .f_id =.f_id doesn't matter.
--shortway for table name

--set column width
--COLUMN fieldname FORMAT A[num]; fieldname must be changed to alias if used.

select s.s_last,s.s_first, f.f_last from student s, faculty f where s.f_id=f.f_id;
S_LAST          S_FIRST         F_LAST
--------------- --------------- ---------------
Graham          Bill            Fillipo
Sanchez         Jim             Arlec
White           Peter           Arlec
Phelp           David           Robertson
Lewis           Sheila          Smith
James           Thomas          Robertson

6 rows selected.


select s.s_id,s.s_last,e.grade from student s, enrollment e where s.s_id = e.s_id;

      S_ID S_LAST          GRADE
---------- --------------- -----
         1 Graham          A+
         2 Sanchez         A-
         2 Sanchez         A+
         3 White           B-
         3 White           B-
         3 White           C+
         4 Phelp           B-
         4 Phelp           A-
         4 Phelp           B+
         5 Lewis           B+
         5 Lewis           A+
         6 James           B+
         6 James           C+

13 rows selected.


select s.s_last"Student Last",s.s_first"Student First", f.f_last"Faculty Last", f.f_first"Faculty First" from student s, faculty f where s.f_id=f.f_id;

Student Last    Student First   Faculty Last    Faculty First
--------------- --------------- --------------- ---------------
Graham          Bill            Fillipo         Paul
Sanchez         Jim             Arlec           Lisa
White           Peter           Arlec           Lisa
Phelp           David           Robertson       Myra
Lewis           Sheila          Smith           Neal
James           Thomas          Robertson       Myra

6 rows selected.



select s.s_last||' '||s.s_first"Student Name", f.f_last||' '|| f.f_first"Faculty Name" from student s, faculty f where s.f_id=f.f_id;
--cannot use number to alias table name, with ' '?
Student Name                    Faculty Name
------------------------------- -------------------------------
Graham Bill                     Fillipo Paul
Sanchez Jim                     Arlec Lisa
White Peter                     Arlec Lisa
Phelp David                     Robertson Myra
Lewis Sheila                    Smith Neal
James Thomas                    Robertson Myra

6 rows selected.


select s.s_id"Student ID",s.s_last||' '||s.s_first"Student Name",e.grade"Student Grade" from student s,enrollment e where s.s_id = e.s_id;

Student ID Student Name                    Stude
---------- ------------------------------- -----
         1 Graham Bill                     A+
         2 Sanchez Jim                     A-
         2 Sanchez Jim                     A+
         3 White Peter                     B-
         3 White Peter                     B-
         3 White Peter                     C+
         4 Phelp David                     B-
         4 Phelp David                     A-
         4 Phelp David                     B+
         5 Lewis Sheila                    B+
         5 Lewis Sheila                    A+
         6 James Thomas                    B+
         6 James Thomas                    C+

13 rows selected.


select s.s_id"Student ID",s.s_last||' '||s.s_first"Student Name",c.course_name,e.grade"Student Grade" from student s,enrollment e,course c where s.s_id = e.s_id and c.course_no=e.course_no;

Student ID Student Name                    COURSE_NAME               Stude
---------- ------------------------------- ------------------------- -----
         4 Phelp David                     Programming in C++        B-
         3 White Peter                     Programming in C++        B-
         1 Graham Bill                     Intro. To Info. Systems   A+
         5 Lewis Sheila                    Systems Analysis          B+
         3 White Peter                     Systems Analysis          B-
         4 Phelp David                     Database Management       A-
         2 Sanchez Jim                     Database Management       A-
         5 Lewis Sheila                    Web-Based Systems         A+
         2 Sanchez Jim                     Web-Based Systems         A+
         6 James Thomas                    Advanced Web              B+
         4 Phelp David                     Advanced Web              B+
         6 James Thomas                    Advanced Java             C+
         3 White Peter                     Advanced Java             C+

13 rows selected.

select s.s_id, s.s_last,s.s_class, f.f_last,f.f_first from student s, faculty f where s.f_id=f.f_id and s.s_class = 'EX';

      S_ID S_LAST          S_ F_LAST          F_FIRST
---------- --------------- -- --------------- ---------------
         2 Sanchez         EX Arlec           Lisa
         3 White           EX Arlec           Lisa

		 
column "Student Name" format a15		 
column "Student birthday" format a40		 
select s.s_id"Student ID",s.s_last||' '||s.s_first"Sutdent Name",upper(to_char(s.birthday,'DY, month dd,yyyy hh:mm:ss A.M.'))"Student birthday", f.f_last||' '||f.f_first"Faculty Last", c.course_name, e.grade"Student Grade" from student s, course c, enrollment e,faculty f where  s.s_id = e.s_id and s.f_id = f.f_id and e.course_no=c.course_no order by s.s_id;


Student ID Sutdent Name          Student birthday                         Faculty Last                 COURSE_NAME                  Stude
---------- --------------------- ---------------------------------------- ------------------------------- ------------------------- -----
         1 Graham Bill           WED, JULY      30,1980 12:07:00 A.M.     Fillipo Paul                    Intro. To Info. Systems   A+
         2 Sanchez Jim           TUE, MAY       12,1981 12:05:00 A.M.     Arlec Lisa                      Database Management       A-
         2 Sanchez Jim           TUE, MAY       12,1981 12:05:00 A.M.     Arlec Lisa                      Web-Based Systems         A+
         3 White Peter           TUE, MARCH     24,1987 12:03:00 A.M.     Arlec Lisa                      Systems Analysis          B-
         3 White Peter           TUE, MARCH     24,1987 12:03:00 A.M.     Arlec Lisa                      Advanced Java             C+
         3 White Peter           TUE, MARCH     24,1987 12:03:00 A.M.     Arlec Lisa                      Programming in C++        B-
         4 Phelp David           THU, FEBRUARY  11,1988 12:02:00 A.M.     Robertson Myra                  Advanced Web              B+
         4 Phelp David           THU, FEBRUARY  11,1988 12:02:00 A.M.     Robertson Myra                  Database Management       A-
         4 Phelp David           THU, FEBRUARY  11,1988 12:02:00 A.M.     Robertson Myra                  Programming in C++        B-
         5 Lewis Sheila          FRI, OCTOBER   09,1970 12:10:00 A.M.     Smith Neal                      Systems Analysis          B+
         5 Lewis Sheila          FRI, OCTOBER   09,1970 12:10:00 A.M.     Smith Neal                      Web-Based Systems         A+
         6 James Thomas          WED, DECEMBER  07,1960 12:12:00 A.M.     Robertson Myra                  Advanced Java             C+
         6 James Thomas          WED, DECEMBER  07,1960 12:12:00 A.M.     Robertson Myra                  Advanced Web              B+

13 rows selected.




select  c.course_no,c.course_name,c.credits,c.max_enrl,l.lc_type,l.lc_desc from course c, levelclass l where c.max_enrl between l.lc_min and l.lc_max;

COURSE_ COURSE_NAME                  CREDITS   MAX_ENRL    LC_TYPE LC_DESC
------- ------------------------- ---------- ---------- ---------- --------------------
MIS 441 Database Management                3         12          1 Small Class
MIS 651 Advanced Java                      3         30          2 Medium Class
MIS 451 Web-Based Systems                  3         30          2 Medium Class
MIS 551 Advanced Web                       3         30          2 Medium Class
MIS 301 Systems Analysis                   3         35          3 Large Class
CS 155  Programming in C++                 3         90          3 Large Class
MIS 101 Intro. To Info. Systems            3        140          4 Extra Large Class

7 rows selected.


--selfjoin with different alias for the same tablename
select c.course_name, r.course_name"prequire course" from course c, course r where c.prereq = r.course_no;

COURSE_NAME               prequire course
------------------------- -------------------------
Advanced Java             Intro. To Info. Systems
Web-Based Systems         Intro. To Info. Systems
Programming in C++        Intro. To Info. Systems
Database Management       Systems Analysis
Advanced Web              Web-Based Systems
Systems Analysis          Advanced Java

6 rows selected.

select s.s_id,s.s_last,f.f_last,f.f_first from student s, faculty f where s.f_id = f.f_id; 

      S_ID S_LAST     F_LAST          F_FIRST
---------- ---------- --------------- ---------------
         1 Graham     Fillipo         Paul
         2 Sanchez    Arlec           Lisa
         3 White      Arlec           Lisa
         4 Phelp      Robertson       Myra
         5 Lewis      Smith           Neal
         6 James      Robertson       Myra

6 rows selected.

select s.s_id,s.s_last,f.f_last,f.f_first from student s, faculty f where s.f_id(+) = f.f_id; 
      S_ID S_LAST     F_LAST          F_FIRST
---------- ---------- --------------- ---------------
         1 Graham     Fillipo         Paul
         2 Sanchez    Arlec           Lisa
         3 White      Arlec           Lisa
         4 Phelp      Robertson       Myra
         5 Lewis      Smith           Neal
         6 James      Robertson       Myra
                      Denver          Paul
					  
7 rows selected.

--rows operator
select s.s_id, s.s_last,s.s_first, w.w_id, w.w_last,w.w_first from student s, worker w where s.s_last (+) = w.w_last and s.s_first=w.w_first;
select w_id,w_last,w_first from worker intersect select s_id,s_last,s_first from student;

      W_ID W_LAST     W_FIRST
---------- ---------- ----------
         1 Graham     Bill
         3 White      Peter

select w_id,w_last,w_first from worker union select s_id,s_last,s_first from student;

      W_ID W_LAST     W_FIRST
---------- ---------- ----------
         1 Graham     Bill
         2 Craig      Daniel
         2 Sanchez    Jim
         3 White      Peter
         4 Depp       Johnny
         4 Phelp      David
         5 Lewis      Sheila
         5 Shell      Amanda
         6 James      Thomas

9 rows selected.

select w_id,w_last,w_first from worker union all select s_id,s_last,s_first from student;

      W_ID W_LAST     W_FIRST
---------- ---------- ----------
         1 Graham     Bill
         2 Craig      Daniel
         3 White      Peter
         4 Depp       Johnny
         5 Shell      Amanda
         1 Graham     Bill
         2 Sanchez    Jim
         3 White      Peter
         4 Phelp      David
         5 Lewis      Sheila
         6 James      Thomas

11 rows selected.

select w_id,w_last,w_first from worker minus select s_id,s_last,s_first from student;

      W_ID W_LAST     W_FIRST
---------- ---------- ----------
         2 Craig      Daniel
         4 Depp       Johnny
         5 Shell      Amanda

		 
select s_id,s_last,s_first from student minus select w_id,w_last,w_first from worker;

      S_ID S_LAST     S_FIRST
---------- ---------- ----------
         2 Sanchez    Jim
         4 Phelp      David
         5 Lewis      Sheila
         6 James      Thomas

b)
select b.b_id,b.b_author,b.b_title,b.b_price,p.p_name from book b, publisher p where b.p_id = p.p_id;

      B_ID B_AUTHOR             B_TITLE                 B_PRICE P_NAME
---------- -------------------- -------------------- ---------- --------------------
         1 Stev Jeff            Java Programming           42.4 Harvard Publishing
         2 Amine Khan           Oracle Database           252.4 Course Technology
         3 Eduard Becher        History of Art            202.3 MIT Publishing
         4 James Peter          PHP Programming            66.7 Campus Press
         5 Paul Tremblay        Economy and Wealth         43.3 Pearson Education
         6 Paul Henry           Business Principles        12.6 Harvard Publishing

6 rows selected.


c)
select b.b_id,c.c_no,b.b_author,b.b_title,c.c_title,c.c_price,b.b_price,p.p_name from book b, chapter c, publisher p where b.p_id=p.p_id and b.b_id=c.b_id;


      B_ID       C_NO B_AUTHOR             B_TITLE              C_TITLE                 C_PRICE    B_PRICE P_NAME
---------- ---------- -------------------- -------------------- -------------------- ---------- ---------- --------------------
         1          1 Stev Jeff            Java Programming     Java 1                       12       42.4 Harvard Publishing
         1          2 Stev Jeff            Java Programming     Java 2                        0       42.4 Harvard Publishing
         2          1 Amine Khan           Oracle Database      Oracle 1                     22      252.4 Course Technology
         2          2 Amine Khan           Oracle Database      Oracle 2                     32      252.4 Course Technology
         2          3 Amine Khan           Oracle Database      Oracle 3                     42      252.4 Course Technology
         3          1 Eduard Becher        History of Art       History 1                     0      202.3 MIT Publishing
         3          2 Eduard Becher        History of Art       History 2                     0      202.3 MIT Publishing
         3          3 Eduard Becher        History of Art       History 3                    65      202.3 MIT Publishing
         4          1 James Peter          PHP Programming      PHP 1                        12       66.7 Campus Press
         4          2 James Peter          PHP Programming      PHP 2                        65       66.7 Campus Press
         5          1 Paul Tremblay        Economy and Wealth   Economy 1                    52       43.3 Pearson Education
         5          2 Paul Tremblay        Economy and Wealth   Economy 2                    76       43.3 Pearson Education
         6          1 Paul Henry           Business Principles  Business 1                    0       12.6 Harvard Publishing

13 rows selected.


d)
select b.b_id,c.c_no,b.b_author,b.b_title,c.c_title,c.c_price,b.b_price,p.p_name from book b, publisher p , chapter c where b.p_id = p.p_id and b.b_id=c.b_id and c.c_title like '%2' order by b.b_id;

      B_ID       C_NO B_AUTHOR             B_TITLE              C_TITLE                 C_PRICE    B_PRICE P_NAME
---------- ---------- -------------------- -------------------- -------------------- ---------- ---------- --------------------
         1          2 Stev Jeff            Java Programming     Java 2                        0       42.4 Harvard Publishing
         2          2 Amine Khan           Oracle Database      Oracle 2                     32      252.4 Course Technology
         3          2 Eduard Becher        History of Art       History 2                     0      202.3 MIT Publishing
         4          2 James Peter          PHP Programming      PHP 2                        65       66.7 Campus Press
         5          2 Paul Tremblay        Economy and Wealth   Economy 2                    76       43.3 Pearson Education

		 
e)
select b.b_id"BookID", c.c_no"Chapter No", b.b_author"Book Author", b.b_title"Book Title", c.c_title"Chapter Title",b.b_price"Book Price",p.p_name"Pub Name" from book b, publisher p, chapter c where b.b_id=c.b_id and b.p_id=p.p_id and b.b_price>=200;		 
   
    BookID Chapter No Book Author          Book Title           Chapter Title        Book Price Pub Name
---------- ---------- -------------------- -------------------- -------------------- ---------- --------------------
         2          1 Amine Khan           Oracle Database      Oracle 1                  252.4 Course Technology
         2          2 Amine Khan           Oracle Database      Oracle 2                  252.4 Course Technology
         2          3 Amine Khan           Oracle Database      Oracle 3                  252.4 Course Technology
         3          1 Eduard Becher        History of Art       History 1                 202.3 MIT Publishing
         3          2 Eduard Becher        History of Art       History 2                 202.3 MIT Publishing
         3          3 Eduard Becher        History of Art       History 3                 202.3 MIT Publishing

6 rows selected.
		 