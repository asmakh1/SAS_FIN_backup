
   data _null_;
           call symput('ora_date_range_min', "'"||put("&date_range_min."d, yymmdd10.)||"'");
           call symput('ora_date_range_max', "'"||put("&date_range_max."d, yymmdd10.)||"'");
     run;

proc sql print;
connect to oracle as mydatabase 
(user=&user_id. password="&password." path=&dbEnvironment.); 

           CREATE TABLE WORK.Manual_Equipment_Subsidy AS
                SELECT Dealer_Code label = "Dealer Code",
				Dealer_Type label = "Dealer type",
				BAN label = "BAN",
				CTN label = "CTN",
				IMEI label = "IMEI",
				SKU label = "SKU",
				Transaction_Type label = "Transaction Type",
				Transaction_Date label = "Transaction Date",
				SCOA label = "SCOA",
				Subsidy_Paid_Date label = "Subsidy Paid Date",
				Subsidy_Paid label = "Subsidy Paid",
				Adjusted_Subsidy label = "Adjusted Subsidy",
				Adjustment label = "Adjustment",
				Date_Subsidy_Adjusted label = "Date_Subsidy_Adjusted",
				Adjustment_Reason label = "Adjustment_Reason"

FROM CONNECTION TO mydatabase
                      (
                select T1329.DEALER_CODE as Dealer_Code,
                      T1329.DEALER_TYPE as Dealer_Type,
                      T1329.BAN as BAN,
                      T1329.CTN as CTN,
                      T1329.IMEI as IMEI,
                      T1329.SKU as SKU,
                      T1329.TRANSACTION_TYPE as Transaction_Type,
                      TRUNC(T1329.TRANSACTION_DATE)  as Transaction_Date,
                      T1329.SCOA as SCOA,
                      TRUNC(T1329.SUBSIDY_PAID_DATE)  as Subsidy_Paid_Date,
                      T1329.SUBSIDY_PAID as Subsidy_Paid,
                      sum(distinct T1329.ADJUSTED_SUBSIDY) as Adjusted_Subsidy,
                      T1329.ADJUSTMENT as Adjustment,
                      TRUNC(T1329.DATE_SUBSIDY_ADJUSTED) as Date_Subsidy_Adjusted,
                      T1329.ADJUSTMENT_REASON as Adjustment_Reason     
                from 
                      OBIEE_IFRS_USER_B.DC_MANUAL_SUBSIDY T1329 /* Fact_DC_MANUAL_SUBSIDY */
                where  ( T1329.ADJUSTMENT not in (0) 
                      and T1329.STATUS not in ('D') 
                      and  TRUNC(T1329.TRANSACTION_DATE) between TO_DATE(&ora_date_range_min., 'YYYY-MM-DD') and TO_DATE(&ora_date_range_max. , 'YYYY-MM-DD') ) 
                group by T1329.ADJUSTED_SUBSIDY
                      , T1329.ADJUSTMENT
                      , T1329.ADJUSTMENT_REASON
                      , T1329.BAN
                      , T1329.CTN
                      , T1329.DEALER_CODE
                      , T1329.DEALER_TYPE
                      , T1329.IMEI
                      , T1329.SCOA
                      , T1329.SKU
                      , T1329.SUBSIDY_PAID
                      , T1329.TRANSACTION_TYPE
                      , T1329.ORDERID
                      , TRUNC(T1329.SUBSIDY_PAID_DATE) 
                      , TRUNC(T1329.TRANSACTION_DATE) 
                      ,  TRUNC(T1329.DATE_SUBSIDY_ADJUSTED)

                      );
           disconnect from mydatabase;
     quit;

