/*
Report Name: Error Log: SUMMARY BY AGING
Description of the Report: 
Ability to report on Total number of errors records per Age. 
FR_LOG will get an entry every day until error is resolved and status changed to S or N. However, older records for same error will remain in status C.
The solution is to ignore the errors that are already fixed.  
Counting will be done on only errors not resolved.
Aging will be calculated on first time (date) where error logged and current date.  

 
User Input Filters:
Filter1:  Report Date (CURRENT_DATE)
*/
*%let or_user= xxxxxxxx;       /* Database User ID */
*%let or_password= xxxxxxxx;   /* Database Password */
*%let or_path= xxxxxxx;        /* Connection Name BDWDEV,BDWQA,BDWPRD */
 

PROC SQL;
connect to oracle as mydatabase
   ( user=&user_id.
     password="&password."
     path=&dbEnvironment.
  );
CREATE TABLE WORK.TEST AS
  SELECT *
    FROM CONNECTION TO mydatabase(

select "Age","Total Records" from (
SELECT CASE d1.C2 WHEN '16-20' THEN  1  WHEN '21-25' THEN 2 WHEN '26-30' THEN 3 WHEN '31-60' THEN 4 WHEN '61-90' THEN 5 WHEN '91-120' THEN 6 WHEN '121-180' THEN 7 WHEN '>180' THEN 8 WHEN '<16' THEN 0 END AS S_NO,
D1.c2 AS "Age", NVL(D1.c1,'0') AS "Total Records"   FROM
  (SELECT
    /*+ PARALLEL(T1416 16) */
    COUNT(DISTINCT COL4_HASH) AS c1,
    CASE
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  < 16 
      THEN '<16'
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  BETWEEN 16 AND 20
      THEN '16-20'
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  BETWEEN 21 AND 25
      THEN '21-25'
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  BETWEEN 26 AND 30
      THEN '26-30'
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  BETWEEN 31 AND 60
      THEN '31-60'
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  BETWEEN 61 AND 90
      THEN '61-90'
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  BETWEEN 91 AND 120
      THEN '91-120'
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  BETWEEN 121 AND 180
      THEN '121-180'
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  > 180
      THEN '>180'
    
    END AS c2
    /* Enter Current Date */
  FROM OBIEE_IFRS_USER.FR_LOG T1416
    /* Fact_FR_LOG */
  WHERE ( T1416.FIXED = 'N' )
  GROUP BY
    CASE
    WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  < 16 
      THEN '<16'
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  BETWEEN 16 AND 20
      THEN '16-20'
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  BETWEEN 21 AND 25
      THEN '21-25'
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  BETWEEN 26 AND 30
      THEN '26-30'
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD'))  - trunc(T1416.ERR_OPEN)  BETWEEN 31 AND 60
      THEN '31-60'
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  BETWEEN 61 AND 90
      THEN '61-90'
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  BETWEEN 91 AND 120
      THEN '91-120'
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  BETWEEN 121 AND 180
      THEN '121-180'
      WHEN trunc(TO_DATE(&ora_EVENT_DATETIME. , 'YYYY-MM-DD') )  - trunc(T1416.ERR_OPEN)  > 180
      THEN '>180'
      
    END
  ) D1 order by 1)
/* Enter Current Date */

);

disconnect from mydatabase;
quit;
