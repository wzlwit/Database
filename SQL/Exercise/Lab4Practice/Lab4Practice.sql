 update book set PubDate = decode (b_id, 1, '13-JUL-97', 2, '06-JAN-05', 3, '31-MAY-10', 4, '16-OCT-11', 5, '17-AUG-09', 6, '24-SEP-07');
 

 
update book set pubdate = '13-JUL-97' where b_id = 1;
update book set pubdate = '06-JAN-05' where b_id = 2;
update book set pubdate = '31-MAY-10' where b_id = 3;
update book set pubdate = '16-OCT-11' where b_id = 4;
update book set pubdate = '17-AUG-09' where b_id = 5;
update book set pubdate = '24-SEP-07' where b_id = 6;
5 rows updated.

select * from book;

      B_ID B_AUTHOR             B_TITLE                        B_ISBN        B_    B_PRICE       P_ID PUBDATE
---------- -------------------- ------------------------------ ------------- -- ---------- ---------- ---------
         1 Stev_Jeff            Java Programming               1234987       BG       42.4          4 13-JUL-97
         2 Amine Khan           Oracle Database                345675        EX      252.4          1 06-JAN-05
         3 Eduard Becher        History of Art                 098766        EX      202.3          5 31-MAY-05
         4 James Peter          PHP Programming                765432        MD       66.7          2 16-OCT-11
	   5 Paul Tremblay        Economy and Wealth             1209845       BG       43.3			3 17-AUG-09
         6 Paul Henry           Business Principles            654321        BG       12.6          4 24-SEP-07

		 

update book set b_type = '&b_type' where b_id = '&b_id';
Enter value for b_type: BG
Enter value for b_id: 3
old   1: update book set b_type = '&b_type' where b_id = '&b_id'
new   1: update book set b_type = 'BG' where b_id = '3'

1 row updated.

update book set b_isbn = '&b_isbn' where b_id = '&b_id';
Enter value for b_isbn: 123-456
Enter value for b_id: 3
old   1: update book set b_isbn = '&b_isbn' where b_id = '&b_id'
new   1: update book set b_isbn = '123-456' where b_id = '3'

1 row updated.

select * from book;

      B_ID B_AUTHOR             B_TITLE                        B_ISBN        B_    B_PRICE       P_ID PUBDATE
---------- -------------------- ------------------------------ ------------- -- ---------- ---------- ---------
         1 Stev_Jeff            Java Programming               1234987       BG       42.4          4 13-JUL-97
         2 Amine Khan           Oracle Database                345675        EX      252.4          1 06-JAN-05
         3 Eduard Becher        History of Art                 123-456       BG      202.3          5 31-MAY-10
         4 James Peter          PHP Programming                765432        MD       66.7          2 16-OCT-11
         6 Paul Henry           Business Principles            654321        BG       12.6          4 24-SEP-07


--- use decode for one expression
		 
update book set b_price = Decode(b_type, 'BG', b_price*1.1,'MD', b_price*1.2, 'EX', b_price*1.3);

5 rows updated.

select * from book;

      B_ID B_AUTHOR             B_TITLE                        B_ISBN        B_    B_PRICE       P_ID PUBDATE
---------- -------------------- ------------------------------ ------------- -- ---------- ---------- ---------
         1 Stev_Jeff            Java Programming               1234987       BG      46.64          4 13-JUL-97
         2 Amine Khan           Oracle Database                345675        EX     328.12          1 06-JAN-05
         3 Eduard Becher        History of Art                 123-456       BG     222.53          5 31-MAY-10
         4 James Peter          PHP Programming                765432        MD      80.04          2 16-OCT-11
         6 Paul Henry           Business Principles            654321        BG      13.86          4 24-SEP-07


		 
select 	b_id, upper (b_author), lower(b_title), initcap(b_title) from book;

      B_ID UPPER(B_AUTHOR)      LOWER(B_TITLE)                 INITCAP(B_TITLE)
---------- -------------------- ------------------------------ ------------------------------
         1 STEV_JEFF            java programming               Java Programming
         2 AMINE KHAN           oracle database                Oracle Database
         3 EDUARD BECHER        history of art                 History Of Art
         4 JAMES PETER          php programming                Php Programming
         6 PAUL HENRY           business principles            Business Principles

		 
--e) figure5
select p_name, p_address, p_id from publisher order by length(p_name) asc;

P_NAME                         P_ADDRESS                                      P_ID
------------------------------ ---------------------------------------- ----------
Campus Press                   21 Durocher Avenue Quebec Canada                  2
MIT Publishing                 32 Square Paule Boston, USA                       5
Course Technology              13 Ontario Street Canada                          1
Pearson Education              45 New York USA                                   3
Harvard Publishing             New Hamphshir, Boston                             4


--f) figure6
select p_name, instr(p_name, ' ')"The Blank Position of P_Name", p_address, p_id from publisher order by length(p_name) asc;


P_NAME                         The Blank Position of P_Name P_ADDRESS                                   P_ID
------------------------------ ---------------------------- ---------------------------------------- ----------
Campus Press                                              7 21 Durocher Avenue Quebec Canada               2
MIT Publishing                                            4 32 Square Paule Boston, USA                    5
Course Technology                                         7 13 Ontario Street Canada                       1
Pearson Education                                         8 45 New York USA                                3
Harvard Publishing                                        8 New Hamphshir, Boston                          4

--g) figure7
select p_name, substr(p_name,1,instr(p_name, ' '))"Pub_N_Part1", substr(p_name, instr(p_name,' '))"P_N_Part2", p_id from publisher order by length(p_name);

P_NAME               Pub_N_Part1                                                                      P_N_Part2                                                                              P_ID
-------------------- -------------------------------------------------------------------------------- -------------------------------------------------------------------------------- ----------
Campus Press         Campus                                                                            Press                                                                                    2
MIT Publishing       MIT                                                                               Publishing                                                                               5
Course Technology    Course                                                                            Technology                                                                               1
Pearson Education    Pearson                                                                           Education                                                                                3
Harvard Publishing   Harvard                                                                           Publishing                                                                               4


--h) figure8
select b_id, b_author, b_title, ceil(b_price) from book order by b_price desc;
      B_ID B_AUTHOR             B_TITLE                                  CEIL(B_PRICE)
---------- -------------------- ---------------------------------------- -------------
         2 Amine Khan           Oracle Database                                    329
         3 Eduard Becher        History of Art                                     263
         4 James Peter          PHP Programming                                     81
         5 Paul Tremblay        Economy and Wealth                                  48
         1 Stev_Jeff            Java Programming                                    47
         6 Paul Henry           Business Principles                                 14

6 rows selected.


--i) figure9
select b_id, substr(b_author,1,instr(b_author, ' '))"Author F_name", substr(b_author,instr(b_author,' '))"Author L_name", b_type, Decode(b_type,'BG','Book for beginners', 'EX', 'Book for Expert','MD','Book for Intermediate') "Book Level" from book;

      B_ID Author F_name                                                                    Author L_name                                                            B_ Book Level
---------- -------------------------------------------------------------------------------- -------------------------------------------------------------------------------- -- ---------------------
         1                                                                                  Stev_Jeff                                                                BG Book for beginners
         2 Amine                                                                             Khan                                                                    EX Book for Expert
         3 Eduard                                                                            Becher                                                                  EX Book for Expert
         4 James                                                                             Peter                                                                   MD Book for Intermediate
         5 Paul                                                                              Tremblay                                                                BG Book for beginners
         6 Paul                                                                              Henry                                                                   BG Book for beginners

6 rows selected.

j) figure10
select b_id, b_author, b_title, to_char(b_price, '$999.999') "bPFormat" from book;

      B_ID B_AUTHOR             B_TITLE                                  bPFormat
---------- -------------------- ---------------------------------------- ---------
         1 Stev Jeff            Java Programming                           $46.640
         2 Amine Khan           Oracle Database                           $328.120
         3 Eduard Becher        History of Art                            $262.990
         4 James Peter          PHP Programming                            $80.040
         5 Paul Tremblay        Economy and Wealth                         $47.630
         6 Paul Henry           Business Principles                        $13.860

6 rows selected.


--k) figure11
select b_id, b_author, b_title, to_char(Decode(b_type, 'BG',b_price/1.1, 'MD',b_price/1.2,'EX',b_price/1.3),'$999.999')"New Price" from book;
select b_id, b_author, b_title, to_char(case when b_type ='BG' then b_price/1.1 when b_type='MD' then b_price/1.2 when b_type='EX' then b_price/1.3 end,'$999.999') "New Price" from book;

      B_ID B_AUTHOR             B_TITLE                                  New Price
---------- -------------------- ---------------------------------------- ---------
         1 Stev Jeff            Java Programming                           $42.400
         2 Amine Khan           Oracle Database                           $252.400
         3 Eduard Becher        History of Art                            $202.300
         4 James Peter          PHP Programming                            $66.700
         5 Paul Tremblay        Economy and Wealth                         $43.300
         6 Paul Henry           Business Principles                        $12.600

6 rows selected.

--l) figure12
select max(b_price)"Maximum BOOK Price", min(b_price)"Minimum BOOK Price",avg(b_price)"Average BOOK Price" from book;

Maximum BOOK Price Minimum BOOK Price Average BOOK Price
------------------ ------------------ ------------------
            328.12              13.86             129.88

			
--m) figure13
select b_id, upper(b_author)"Author's Name", lower(b_title)"Title in Lower Case", upper(to_char(PubDate, 'DY, Month dd, yyyy hh:mm:ss p.m.'))"Publishing Date Format" from book;


      B_ID Author's Name        Title in Lower Case                      Publishing Date Format
---------- -------------------- ---------------------------------------- -----------------------------------------------------------------------
         1 STEV JEFF            java programming                         SUN, JULY      13, 1997 12:07:00 AM
         2 AMINE KHAN           oracle database                          THU, JANUARY   06, 2005 12:01:00 AM
         3 EDUARD BECHER        history of art                           MON, MAY       31, 2010 12:05:00 AM
         4 JAMES PETER          php programming                          SUN, OCTOBER   16, 2011 12:10:00 AM
         5 PAUL TREMBLAY        economy and wealth                       MON, AUGUST    17, 2009 12:08:00 AM
         6 PAUL HENRY           business principles                      MON, SEPTEMBER 24, 2007 12:09:00 AM

6 rows selected.

--n) figure14
select b_id, upper(b_author)"Author's Name", lower(b_title)" Title in Lower Case",to_char(Decode(b_type, 'BG',b_price/1.1, 'MD',b_price/1.2,'EX',b_price/1.3),'$999.99')"bPFormat", upper(to_char(PubDate, 'DY, Month dd, yyyy hh:mm:ss p.m.'))"Publishing Date Format" from book;

      B_ID Author's Name         Title in Lower Case                     bPForma  Publishing Date Format
---------- -------------------- ---------------------------------------- -------- ----------------------------------------
         1 STEV JEFF            java programming                           $42.40 SUN, JULY      13, 1997 12:07:00 AM
         2 AMINE KHAN           oracle database                           $252.40 THU, JANUARY   06, 2005 12:01:00 AM
         3 EDUARD BECHER        history of art                            $202.30 MON, MAY       31, 2010 12:05:00 AM
         4 JAMES PETER          php programming                            $66.70 SUN, OCTOBER   16, 2011 12:10:00 AM
         5 PAUL TREMBLAY        economy and wealth                         $43.30 MON, AUGUST    17, 2009 12:08:00 AM
         6 PAUL HENRY           business principles                        $12.60 MON, SEPTEMBER 24, 2007 12:09:00 AM

6 rows selected.

--ex m and n are done in computers in E120, so a bit different display.