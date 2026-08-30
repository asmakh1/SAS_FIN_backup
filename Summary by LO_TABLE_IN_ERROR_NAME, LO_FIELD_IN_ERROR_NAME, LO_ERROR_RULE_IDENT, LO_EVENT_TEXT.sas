
/*
Report Name: Error Log: SECTION 6 - Summary by LO_TABLE_IN_ERROR_NAME, LO_FIELD_IN_ERROR_NAME, LO_ERROR_RULE_IDENT, LO_EVENT_TEXT
Description of the Report: 
Ability to report on Total number of New and Previous error records break down to the following attributes:
•	LO_TABLE_IN_ERROR_NAME
•	LO_FIELD_IN_ERROR_NAME
•	LO_ERROR_RULE_IDENT
•	LO_EVENT_TEXT
User Input Filters:
Filter1:  Report Source Date (RDR.RR_FR_LOG_V. BUSINESS_DATE)
Filter2: Report Run Date (RDR.RR_FR_LOG_V. EVENT_DATETIME) ( Mandatory Filter )
 */
/*%let or_user= xxxxxxxx;    Database User ID
%let or_password= xxxxxxxx;   Database Password
%let or_path= xxxxxxx;       Connection Name BDWDEV,BDWQA,BDWPRD */
 
PROC SQL;
connect to oracle as mydatabase
   ( user=&user_id.
     password="&password."
     path=&dbEnvironment.  );
               CREATE TABLE WORK.TEST AS
SELECT * FROM CONNECTION TO mydatabase
(   

SELECT
  /*+ PARALLEL(T1412 8) */
  T1412.TABLE_IN_ERROR_NAME AS LO_TABLE_IN_ERROR_NAME,
  T1412.FIELD_IN_ERROR_NAME AS LO_FIELD_IN_ERROR_NAME,
  T1412.JOB_NAME            AS LO_ERROR_RULE_IDENT,
  T1412.ERROR_DESCRIPTION   AS LO_EVENT_TEXT,
  COUNT(
  CASE
    WHEN CAST(trim(both ' '
    FROM CAST(T1412.EVENT_DATETIME AS CHARACTER ( 30 ) )) AS DATE ) = (TO_DATE( &ora_EVENT_DATETIME. , 'YYYY-MM-DD'))
    THEN T1412.LPG_ID
  END ) AS "Total Net New Records",
  /* Enter EVENT_DATETIME */
  COUNT(
  CASE
    WHEN CAST(T1412.EVENT_DATETIME AS DATE ) NOT IN (TO_DATE( &ora_EVENT_DATETIME. , 'YYYY-MM-DD'))
    THEN T1412.LPG_ID
  END ) AS "Total Previous Records",
  /* Enter EVENT_DATETIME */
  COUNT(
  CASE
    WHEN CAST(trim(both ' '
    FROM CAST(T1412.EVENT_DATETIME AS CHARACTER ( 30 ) )) AS DATE ) = (TO_DATE( &ora_EVENT_DATETIME. , 'YYYY-MM-DD'))
    THEN T1412.LPG_ID
  END )+ COUNT(
  CASE
    WHEN CAST(T1412.EVENT_DATETIME AS DATE ) NOT IN (TO_DATE( &ora_EVENT_DATETIME. , 'YYYY-MM-DD'))
    THEN T1412.LPG_ID
  END ) AS "Total_Records"
FROM RDR.RR_FR_LOG_V T1412
  /* Fact_RR_FR_LOG_V */
WHERE ( (T1412.BUSINESS_DATE = TO_DATE( &ora_BUSINESS_DATE. , 'YYYY-MM-DD')
  /* Enter BUSINESS_DATE*/ or &ora_BUSINESS_DATE. ='         .')
AND ( CAST(T1412.EVENT_DATETIME AS DATE ) <> TO_DATE( &ora_EVENT_DATETIME. , 'YYYY-MM-DD')
  /* Enter EVENT_DATETIME */
OR CAST(trim(both ' '
FROM CAST(T1412.EVENT_DATETIME AS CHARACTER ( 30 ) )) AS DATE ) = (TO_DATE( &ora_EVENT_DATETIME. , 'YYYY-MM-DD')) ) )
  /*  Enter EVENT_DATETIME */
GROUP BY T1412.ERROR_DESCRIPTION,
  T1412.FIELD_IN_ERROR_NAME,
  T1412.JOB_NAME,
  T1412.TABLE_IN_ERROR_NAME

);

disconnect from mydatabase;
quit;



