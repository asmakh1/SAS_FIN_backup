/*** PLEASE CREATE YOUR OWN COPY TO MODIFY THIS CODE! ****/
  %macro build_bill_cycle_where;
  length BillCycle_where     $250
         BillCycle_where_ora $250;
  BillCycle_where = "and Bill_Cycle in (";
  BillCycle_where_ora= "and lpad(Bill_Cycle_CD, 2, '0') in (";

   %if &BillCycle_COUNT. > 1 %then %do;
     %do i= 1 %to &BillCycle_COUNT.;
       BillCycle_where=trim(left(BillCycle_where))||"'&&BillCycle&i'";
       BillCycle_where_ora=trim(left(BillCycle_where_ora))||"'&&BillCycle&i'";
/*      %put "&&BillCycle&i",; */
	   %if &i < &BillCycle_Count %then %do;
	      BillCycle_where=trim(left(BillCycle_where))||", ";
	      BillCycle_where_ora =trim(left(BillCycle_where_ora))||",";
       %end;
       %else %do;
         BillCycle_where=trim(left(BillCycle_where))||")";
         BillCycle_where_ora=trim(left(BillCycle_where_ora))||")";
       %end;
     %end;
   %end;
   %else %do;
     BillCycle_where = "and Bill_Cycle in ('&BillCycle.')";
     BillCycle_where_ora= "and lpad(Bill_Cycle_CD, 2, '0') in ('&BillCycle.')";
   %end;
%mend build_bill_cycle_where;


data _null_;

  if "&BusEvent." > "" then
    BusEvent_where= "and Business_Event = '&BusEvent.'";
	else BusEvent_where='';
  call symput( 'BusEvent_where', BusEvent_where);

  if "&ActivityDate." > "" then
    ActivityDate_where= "and Activity_Date = '&ActivityDate.'d";
	else ActivityDate_where='';
  call symput( 'ActivityDate_where', ActivityDate_where);    

  if &BillCycle_COUNT. > 0 then do;
     %build_bill_cycle_where;
  end;
	else do;
      BillCycle_where='';
      BillCycle_where_ora='';
    end;
  call symput( 'BillCycle_where', BillCycle_where);
  call symput( 'BillCycle_where_ora', BillCycle_where_ora);

  WHERE_STR= trim(left(substr(COMPBL(BusEvent_where || " "
                           || ActivityDate_where || " "
                           || BillCycle_where), 5)));
    call symput( 'WHERE_STR', trim(left(WHERE_STR)));
  put where_str=;
run;

/* -------------------------------------------------------------------
   Run the tabulate procedure
   ------------------------------------------------------------------- */
%macro Summary_Report;

%if "&BusEvent_where." = "" %then %let All_Events=All="All Events";
                            %else %let All_Events=;
Title1 &SelectReport.;
Title2 "Activity Amount by Billing Cycle";
%put   &BusEvent_where. &ActivityDate_where. &BillCycle_where.;
Title3 "Filter by: ( &Where_str. )";

PROC TABULATE
     DATA=WORK.TEST
              (Where=(1=1
                      &BusEvent_where.
                      &ActivityDate_where.
                      &BillCycle_where.))
      out=tab_out;
	
	VAR ACTIVITY_AMOUNT;
	CLASS BILL_CYCLE /	ORDER=UNFORMATTED MISSING;
	CLASS BUSINESS_EVENT /	ORDER=UNFORMATTED MISSING;
	CLASS ACTIVITY_DATE /	ORDER=UNFORMATTED MISSING ;

%if ("&BusEvent." = "" and
     "&ActivityDate." = "" ) %then %do;
  table 
     (all="All Events" business_event=""),
       Activity_Amount=""*
     (All=""*All="All Cycles" BILL_CYCLE="Billing Day")*
         Sum=""*format=comma12.
             / nocontinued condense misstext='0' box="Business Event";
%end;

	TABLE
   (
/*      All="All Events"*/
      &All_Events.
      business_event="Business Event:"),

	 All="Activity Date"*( ALL="All Days" ACTIVITY_DATE=""),
        Activity_Amount=""*
           (All=""*All="Total" BILL_CYCLE="Billing Day")*
                Sum=""*format=comma12. / nocontinued condense misstext='0' box=_page_;
	;

QUIT;
%mend;

%macro Refresh_Filters;
proc SQL;
  create table sasifrs.Business_Event_filter as
    select distinct Business_Event from TEST
      Where 1=1
            &BusEvent_where.
            &ActivityDate_where.
            &BillCycle_where.;
  create table sasifrs.Bill_Cycle_filter as
    select distinct Bill_Cycle from TEST
      Where 1=1
            &BusEvent_where.
            &ActivityDate_where.
            &BillCycle_where.;
  create table sasifrs.Activity_Date_filter as
    select distinct Activity_Date from TEST
      Where 1=1
            &BusEvent_where.
            &ActivityDate_where.
            &BillCycle_where.;
quit;

%mend;

%macro count_recs;

proc sql noprint;
select count(*) into: rec_cnt
  from WORK.TEST
              (Where=(1=1
                      &BusEvent_where.
                      &ActivityDate_where.
                      &BillCycle_where.))
;
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



