/*
Report Name: Error Log: SECTION1- Summary Totals
Description of the Report: 
Ability to report on Total New and Previous Error records.
User Input Filters:
Filter1:  Report Source Date (RDR.RR_FR_LOG_V. BUSINESS_DATE)
Filter2: Report Run Date (RDR.RR_FR_LOG_V. EVENT_DATETIME) ( Mandatory Filter )

%let or_user= xxxxxxxx;       Database User ID 
%let or_password= xxxxxxxx;   Database Password 
%let or_path= xxxxxxx;        Connection Name BDWDEV,BDWQA,BDWPRD 

*/
PROC SQL;
connect to oracle as mydatabase
   ( user=&user_id.
     password="&password."
     path=&dbEnvironment.
  );
               CREATE TABLE WORK.TEST AS
SELECT * FROM CONNECTION TO mydatabase
(   
select
      D1.c1 as "Total Net New Records",
      D1.c2 as "Total Previous Records",
     D1.c2 + D1.c1 as "Total Records"
    
     FROM
     (select /*+ PARALLEL(T982 8) */count(case  when  cast(trim(both ' ' from cast(T982.EVENT_DATETIME as  CHARACTER ( 30 ) )) as DATE )
     = (TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD')) then T982.LPG_ID end ) as c1,/*  Enter EVENT_DATETIME */
     count (case  when  cast(T982.EVENT_DATETIME as DATE ) not in (TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD')) then T982.LPG_ID end ) as c2 /*  Enter EVENT_DATETIME */

from 
     RDR.RR_FR_LOG_V T982 /* Fact_RR_FR_LOG_V */ 
where  ( 
(T982.BUSINESS_DATE = TO_DATE(&ora_BUSINESS_DATE. , 'YYYY-MM-DD')/* Enter BUSINESS_DATE*/ 
or &ora_BUSINESS_DATE. ='         .')
and cast(T982.EVENT_DATETIME as DATE ) <> TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') /*  Enter EVENT_DATETIME */

or  cast(trim(both ' ' from cast(T982.EVENT_DATETIME as  CHARACTER ( 30 ) )) as DATE ) = (TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD')) ) ) /*  Enter EVENT_DATETIME */
D1

);


 
disconnect from mydatabase;
quit;
