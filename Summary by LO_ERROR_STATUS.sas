/*
Report Name: Error Log: SECTION 4 - SUMMARY BY LO_ERROR_STATUS
Description of the Report: 
Ability to report on Total number of New and Previous error records per Error Status.
User Input Filters:
Filter1:  Report Source Date (RDR.RR_FR_LOG_V. BUSINESS_DATE)
Filter2: Report Run Date (RDR.RR_FR_LOG_V. EVENT_DATETIME) ( Mandatory Filter )
 */

/*%let or_user= xxxxxxxx;       /* Database User ID 
%let or_password= xxxxxxxx;   /* Database Password 
%let or_path= xxxxxxx;        /* Connection Name BDWDEV,BDWQA,BDWPRD */
 
PROC SQL;
connect to oracle as mydatabase
   ( user=&user_id.
     password="&password."
     path=&dbEnvironment.
  );
               CREATE TABLE WORK.TEST AS
SELECT * FROM CONNECTION TO mydatabase
(   
SELECT D1.c3    AS LO_ERROR_STATUS,
  D1.c1         AS "Total Net New Records",
  D1.c2         AS "Total Previous Records",
  D1.c2 + D1.c1 AS "Total Records"
FROM (SELECT
    /*+ PARALLEL(T1412 8) */
    COUNT(
    CASE
      WHEN CAST(trim(both ' '
      FROM CAST(T1412.EVENT_DATETIME AS CHARACTER ( 30 ) )) AS DATE ) = (TO_DATE(
        &ora_EVENT_DATETIME. , 'YYYY-MM-DD'))
      THEN T1412.LPG_ID
    END ) AS c1,
    /* Enter EVENT_DATETIME */
    COUNT(
    CASE
      WHEN CAST(T1412.EVENT_DATETIME AS DATE ) NOT IN (TO_DATE(
        &ora_EVENT_DATETIME. , 'YYYY-MM-DD'))
      THEN T1412.LPG_ID
    END ) AS c2,
    /* Enter EVENT_DATETIME */
    CASE
      WHEN T1412.ERROR_STATUS IS NULL
      THEN 'Others'
      ELSE T1412.ERROR_STATUS
    END AS c3
  FROM RDR.RR_FR_LOG_V T1412
    /* Fact_RR_FR_LOG_V */
  WHERE ( (T1412.BUSINESS_DATE = TO_DATE(
    &ora_BUSINESS_DATE. , 'YYYY-MM-DD')
    /*Enter BUSINESS_DATE */
	or &ora_BUSINESS_DATE. ='         .')
  AND ( CAST(T1412.EVENT_DATETIME AS DATE ) <> TO_DATE(
    &ora_EVENT_DATETIME. , 'YYYY-MM-DD')
    /* Enter EVENT_DATETIME */
  OR CAST(trim(both ' '
  FROM CAST(T1412.EVENT_DATETIME AS CHARACTER ( 30 ) )) AS DATE ) = (TO_DATE(
    &ora_EVENT_DATETIME. , 'YYYY-MM-DD'))) )
    /* Enter EVENT_DATETIME */
  GROUP BY
    CASE
      WHEN T1412.ERROR_STATUS IS NULL
      THEN 'Others'
      ELSE T1412.ERROR_STATUS
    END
  ) D1

);
disconnect from mydatabase;
quit;


