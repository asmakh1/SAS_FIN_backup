data _null_;

call symput('ora_date_range_min',"'"||put("&date_range_min."d, yymmdd10.)||"'");
  call symput('ora_date_range_max',"'"||put("&date_range_max."d, yymmdd10.)||"'");
  call symput('ora_contract_type',"'"||"&contract_type."||"'");

  run;

PROC SQL;
connect to oracle as mydatabase
   /*(user=&or_user
		password="&or_password"
		path=&or_path)*/
(user=&user_id.
                       pass="&password."
                       path= &dbEnvironment.);
	CREATE TABLE WORK.Contract_Asset_Exception AS 
	SELECT 
  CTN LABEL = "CTN" ,
  Subscriber_ID LABEL = "Subscriber ID",
  	Contract_ID LABEL = "Contract ID",
	 Contract_Version_Number LABEL = "Contract Version No",
	 MSRP label = "MSRP",
	 Contract_Asset_Balance label = "Contract Asset Balance",
	 Threshold_Dollar label = "Threshold($)",
	 Threshold_Percent label = "Threshold(%)",
	 ACT_VAR_CAB_MSRP label = "Actual $$ Variance(CAB vs MSRP)",
	 ACT_VAR_CAB_PRCNT_MSRP label = "Actual $$ Variance(CAB vs X% of MSRP)",
	 ACT_VAR_CAB_AMT label = "Actual $$ Variance(CAB vs $$Amount)",
	 datepart(Effective_Date) as EFFECTIVE_DATE format=yymmdd10. label = 'Effective Date'
      FROM CONNECTION TO mydatabase
(  

select  T907.CTN as CTN,
     T907.SUBSCRIBER_ID as Subscriber_ID,
	 T907.CONTRACT_ID as Contract_ID,
	 max(T907.CONTRACT_VERSION) as Contract_Version_Number,
	 max(T907.MSRP) as MSRP,
	 sum(T907.CONTRACT_ASSET_BALANCE) as Contract_Asset_Balance,
	 &threshold_dollar. as Threshold_Dollar,
	 &threshold_percent. as Threshold_Percent,
	 sum(case  when T907.CONTRACT_TYPE in ('SERVICE ONLY WITH NON-ROGERS HARDWARE', 'SERVICE ONLY WITH NON-ROGERS HRDWR AND CC', 'SUBSIDIZED EQUIPMENT AND SERVICE', 'SUBSIDIZED EQUIPMENT AND SERVICE AND CC') then T907.CONTRACT_ASSET_BALANCE - T907.MSRP else NULL end ) as ACT_VAR_CAB_MSRP,
	 sum(case  when T907.CONTRACT_TYPE in ('SERVICE ONLY WITH NON-ROGERS HARDWARE', 'SERVICE ONLY WITH NON-ROGERS HRDWR AND CC', 'SUBSIDIZED EQUIPMENT AND SERVICE', 'SUBSIDIZED EQUIPMENT AND SERVICE AND CC') then T907.CONTRACT_ASSET_BALANCE - T907.MSRP * case  when &threshold_percent. is null then 0 else &threshold_percent. end  / 100 else NULL end ) as ACT_VAR_CAB_PRCNT_MSRP,
	 sum(case  when T907.CONTRACT_TYPE in ('SERVICE ONLY AND CHARGED ECF', 'SERVICE ONLY WITH RECOVERABLE CREDIT') then T907.CONTRACT_ASSET_BALANCE - case  when &threshold_dollar. is null then 0 else &threshold_dollar. end  else NULL end ) as ACT_VAR_CAB_AMT,
	 max(T907.ACTIVATION_DATE) as Effective_Date
     
from 
     OBIEE_IFRS_USER_B.CONTRACT_ASSET_EXCEPTION T907 /* Fact_CONTRACT_ASSET_EXCEPTION */ 
where  ( T907.ACTIVATION_DATE between TO_DATE(&ora_date_range_min. , 'YYYY-MM-DD') 
and TO_DATE(&ora_date_range_max. , 'YYYY-MM-DD') ) 
and sku is not null 
AND (T907.CONTRACT_TYPE = &ora_contract_type. or &ora_contract_type.=' ') 
group by T907.CONTRACT_ID, T907.CTN, T907.SUBSCRIBER_ID
having max(T907.MSRP) * &threshold_percent. / 100 < sum(T907.CONTRACT_ASSET_BALANCE) 
and &threshold_dollar. < sum(T907.CONTRACT_ASSET_BALANCE)

)
; 

disconnect from mydatabase;
quit;

