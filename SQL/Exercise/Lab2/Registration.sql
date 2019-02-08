-- @ '[path\filename]'
set pagesize 800	--no ; at the end, it is not universal SQL command
set linesize 800

drop table faculty cascade constraints;
CREATE TABLE faculty
(f_id NUMBER(5),f_last VarChar2(30) constraint faculty_f_last_nn not null
,f_first VarChar2(30), constraint faculty_f_id_pk primary key (f_id));

insert into faculty values
(1,'Robertson','Myra');
insert into faculty values
(2,'Smith','Neal');
insert into faculty values
(3,'Arlec','Lisa');
insert into faculty values
(4,'Fillipo','Paul');
insert into faculty values
(5,'Denver','Paul');

drop table student cascade constraints;
create table student
(s_id number(5),s_last varchar2(30),s_first varchar2(30),s_class char(2),f_id number(5),
constraint student_s_id_pk primary key (s_id),
constraint student_f_id_fk foreign key (f_id) references faculty(f_id));

insert into student values (1,'Graham','Bill','JR',4);
insert into student values (2,'Sanchez','Jim','EX',3);
insert into student values (3,'White','Peter','EX',3);
insert into student values (4,'Phelp','David','JR',1);
insert into student values (5,'Lewis','Sheila','SR',2);
insert into student values (6,'James','Thomas','JR',1);

drop table course cascade constraints;
create table course
(course_no char(7),course_name varchar2(30),credits number(2),max_enrl number(5),
constraint course_course_no_pk primary key (course_no));
insert into course values ('CS 155','Programming in C++',3,90);
insert into course values ('MIS 101','Intro. To Info. Systems',3,140);
insert into course values ('MIS 301','Systems Analysis',3,35);
insert into course values ('MIS 441','Database Management',3,12);
insert into course values ('MIS 451','Web-Based Systems',3,30);
insert into course values ('MIS 551','Advanced Web',3,30);
insert into course values ('MIS 651','Advanced Java',3,30);





drop table enrollment cascade constraints;

create table enrollment
(s_id number(5),course_no char(7),grade char(5),
constraint enrollment_pk primary key(s_id,course_no),
constraint enrollment_s_id_fk foreign key (s_id) references student(s_id),
constraint enrollment_course_no_fk foreign key (course_no) references course(course_no)); 

insert into enrollment values (1,'MIS 101','A+');
insert into enrollment values (2,'MIS 441','A-');
insert into enrollment values (2,'MIS 451','A+');
insert into enrollment values (3,'CS 155','B-');
insert into enrollment values (3,'MIS 301','B-');
insert into enrollment values (3,'MIS 651','C+');
insert into enrollment values (4,'CS 155','B-');
insert into enrollment values (4,'MIS 441','A-');
insert into enrollment values (4,'MIS 551','B+');
insert into enrollment values (5,'MIS 301','B+');
insert into enrollment values (5,'MIS 451','A+');
insert into enrollment values (6,'MIS 551','B+');
insert into enrollment values (6,'MIS 651','C+');


select TABLE_NAME from user_tables;
select f_id, f_last from faculty;
select s_id, s_class from student;
select * from faculty;
select * from student;
select * from course;
select * from enrollment

