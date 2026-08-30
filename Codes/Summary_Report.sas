data _null_;

call symput('ora_date_range_min',"'"||put("&date_range_min."d, yymmdd10.)||"'");
  call symput('ora_date_range_max',"'"||put("&date_range_max."d, yymmdd10.)||"'");
 

  run;

PROC SQL;
connect to oracle as mydatabase
   /*(user=&or_user
		password="&or_password"
		path=&or_path)*/
(user=&user_id.
                       pass="&password."
                       path= &dbEnvironment.);

CREATE TABLE work.Split_Deff AS
           SELECT * FROM CONNECTION TO mydatabase
           (   SELECT LEGAL_ENTITY AS COMPANY,
                 LOCATION,
                 DEPARTMENT,
                 PRODUCT,
                 ACCOUNT,
                 CHANNEL,
                 FUTURE_1,
                 FUTURE_2,
                 INTER_COMPANY,
                 BILL_CYCLE,
                 GL_DESCRIPTION,
                 DEFERRAL_TYPE,
                 ROUND(SUM(ACTIVITY_AMOUNT),2) AS AMOUNT
           FROM
                 ( WITH SAWITH0 AS
           (SELECT ROUND(SUM(T1065.JLE_ACTIVITY_AMOUNT),2) AS ACTIVITY_AMOUNT
                 /*c1*/
                 ,
                 T1065.JLE_ACCOUNT AS ACCOUNT
                 /*c2*/
                 ,
                 T1065.JLE_BILL_CYCLE_CD AS BILL_CYCLE
                 /*c3*/
                 ,
                 T1065.JLE_BUS_EVENT_JL_DESC AS GL_DESCRIPTION
                 /*c4*/
                 ,
                 T1065.JLE_CHANNEL AS CHANNEL
                 /*c5*/
                 ,
                 T1065.JLE_DEPARTMENT AS DEPARTMENT
                 /*c6*/
                 ,
                 T1065.JLE_FUTURE_1 AS FUTURE_1
                 /*c7*/
                 ,
                 T1065.JLE_FUTURE_2 AS FUTURE_2
                 /*c8*/
                 ,
                 T1065.JLE_INTER_COMPANY AS INTER_COMPANY
                 /*c9*/
                 ,
                 T1065.JLE_LEGAL_ENTITY AS LEGAL_ENTITY
                 /*c10*/
                 ,
                 T1065.JLE_LOCATION AS LOCATION
                 /*c11*/
                 ,
                 T1065.JLE_PRODUCT AS PRODUCT
                 /*c12*/
                 ,
           CASE
                 WHEN T1065.JLE_BUSINESS_EVENT = 'DEFERRAL'
                 AND T1065.JLE_REVERSAL_DATE  IS NULL
                 THEN 'DEFERRAL'
           ELSE 'DEFERRAL REVERSE'
           END 
      AS DEFERRAL_TYPE
           /*c13*/
      FROM RDR.RJLE_SLR_JOURNAL_LINE_EXT T1065
           /* Fact_RJLE_SLR_JOURNAL_LINE_EXT */
      WHERE ( T1065.JLE_EFFECTIVE_DATE BETWEEN TO_DATE(&ora_date_range_min. , 'YYYY-MM-DD') AND TO_DATE(&ora_date_range_max. , 'YYYY-MM-DD') )
           /*FILTER ENETERED BY USER*/
      GROUP BY T1065.JLE_DEPARTMENT,
           T1065.JLE_ACCOUNT,
           T1065.JLE_FUTURE_1,
           T1065.JLE_FUTURE_2,
           T1065.JLE_INTER_COMPANY,
           T1065.JLE_LEGAL_ENTITY,
           T1065.JLE_LOCATION,
           T1065.JLE_PRODUCT,
           T1065.JLE_BILL_CYCLE_CD,
           T1065.JLE_BUS_EVENT_JL_DESC,
           T1065.JLE_CHANNEL,
      CASE
           WHEN T1065.JLE_BUSINESS_EVENT = 'DEFERRAL'
           AND T1065.JLE_REVERSAL_DATE  IS NULL
           THEN 'DEFERRAL'
      ELSE 'DEFERRAL REVERSE'
      END
                 )
           SELECT 0 AS c1,
                 D1.ACCOUNT
                 /*c2*/
           AS ACCOUNT
                 /*c2*/
                 ,
                 D1.BILL_CYCLE
                 /*c3*/
           AS BILL_CYCLE
                 /*c3*/
                 ,
                 D1.GL_DESCRIPTION
                 /*c4*/
           AS GL_DESCRIPTION
                 /*c4*/
                 ,
                 D1.CHANNEL
                 /*c5*/
           AS CHANNEL
                 /*c5*/
                 ,
                 D1.DEPARTMENT
                 /*c6*/
           AS DEPARTMENT
                 /*c6*/
                 ,
                 D1.FUTURE_1
                 /*c7*/
           AS FUTURE_1
                 /*c7*/
                 ,
                 D1.FUTURE_2
                 /*c8*/
           AS FUTURE_2
                 /*c8*/
                 ,
                 D1.INTER_COMPANY
                 /*c9*/
           AS INTER_COMPANY
                 /*c9*/
                 ,
                 D1.LEGAL_ENTITY
                 /*c10*/
           AS LEGAL_ENTITY
                 /*c10*/
                 ,
                 D1.LOCATION
                 /*c11*/
           AS LOCATION
                 /*c11*/
                 ,
                 D1.PRODUCT
                 /*c12*/
           AS PRODUCT
                 /*c12*/
                 ,
                 D1.DEFERRAL_TYPE
                 /*c13*/
           AS DEFERRAL_TYPE
                 /*c13*/
                 ,
                 0 AS c15,
                 ROUND(D1.ACTIVITY_AMOUNT,2)
                 /*c1*/
           AS ACTIVITY_AMOUNT
                 /*c16*/
           FROM SAWITH0 D1
                 )
           GROUP BY LEGAL_ENTITY,
                 LOCATION,
                 DEPARTMENT,
                 PRODUCT,
                 ACCOUNT,
                 CHANNEL,
                 FUTURE_1,
                 FUTURE_2,
                 INTER_COMPANY,
                 BILL_CYCLE,
                 GL_DESCRIPTION,
                 DEFERRAL_TYPE
                 );
      disconnect from mydatabase;
quit;


%mend count_recs;

%macro Run_Report();
  %count_recs;
  %if &rec_cnt. > 0 %then %do;
    %refresh_filters;
    %if "&ReportType." = "Summary" %then %Summary_Report;
    %if "&ReportType." = "Detailed" %then %do;
      %put Running Detailed Report;
      %include '/sasfinshare/1_AnalyticalReports/Codes/Detailed_Report.sas';
    %end;
  %end;
  %else %do;
    data no_resc;
	  a= "No records found. Please update your filters and re-run.";
	run;
	proc print noobs;
	run;
  %end;
%mend;

%Run_Report;



