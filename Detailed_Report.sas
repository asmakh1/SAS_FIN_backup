data _null_;
  if "&ActivityDate." > "" then
/*    effective_date_ora_min= "and effective_date >= TO_DATE('"||put("&ActivityDate."d, yymmdd10.)||"', 'YYYY-MM-DD')";*/
    activity_date_ora= "and effective_date = TO_DATE('"||put("&ActivityDate."d, yymmdd10.)||"', 'YYYY-MM-DD')";
	else activity_date_ora='';
  call symput( 'activity_date_ora', activity_date_ora);
run;
%put &activity_date_ora.;

/*= TOT Wireless Service Revenue (EBU);*/
PROC SQL;
    connect to Oracle (user=&user_id.
                       pass="&password."
                       path= &dbEnvironment.);

CREATE TABLE Detailed_Report AS
SELECT
    BAN                                   AS BAN,
    BAN_NUM                               AS BAN_NUM,
    ACC_DEF_BASE_CALC_AMOUNT format=comma15.2,
    ACC_EVENT_ID                          AS ACC_EVENT_ID,
    ACCEVENT_ID                           AS ACCEVENT_ID,
    ACCOUNT                               AS ACCOUNT,
    ACCRUAL_TREATMENT_TYPE                AS ACCRUAL_TREATMENT_TYPE,
    ACTIVITY_AMOUNT format=comma15.2,
    datepart(ACTIVITY_DATE) format=yymmdd10. AS ACTIVITY_DATE,
    ADJ_REASON_CD                         AS ADJ_REASON_CD,
    AE_INPUT_TIME                         AS AE_INPUT_TIME,
    BALANCE_TYPE                          AS BALANCE_TYPE,
    CYCLE_RUN_YEAR,
    BALANCE_IMPACT_CODE as BALANCE_IMPACT_CODE,
    put(BILL_CYCLE, $NVS.)                AS BILL_CYCLE,
    BILL_MONTH_BILL_CYCLE                 AS BILL_MONTH_BILL_CYCLE,
    BILL_MONTH                            AS BILL_MONTH,
    BUS_EVENT_JL_DESC                     AS BUS_EVENT_JL_DESC,
    BUS_EVENT_SUB_TYPE                    AS BUS_EVENT_SUB_TYPE,
    datepart(BUSINESS_DATE) format=yymmdd10. AS BUSINESS_DATE,
    BUSINESS_EVENT                        AS BUSINESS_EVENT,
    CA_CHANGE_TYPE                        AS CA_CHANGE_TYPE ,
    CHANNEL                               AS CHANNEL,
    CHARGE_TYPE                           AS CHARGE_TYPE,
    CONTRACT_ID                           AS CONTRACT_ID,
    CONTRACT_PRODUCT_PART_ID              AS CONTRACT_PRODUCT_PART_ID,
    CONTRACT_TRANS_TYPE                   AS CONTRACT_TRANS_TYPE,
    CONTRACT_TYPE                         AS CONTRACT_TYPE,
    CONTRACT_VERSION_NO                   AS CONTRACT_VERSION_NO,
    CREDIT_CLASS                          AS CREDIT_CLASS,
    CURRENCY                              AS CURRENCY,
    DEALER_CD                             AS DEALER_CD,
    DEPARTMENT                            AS DEPARTMENT,
    DISCOUNT_CD                           AS DISCOUNT_CD,
    EBA_ID                                AS EBA_ID,
    datepart(EFFECTIVE_DATE) format=yymmdd10. AS EFFECTIVE_DATE,
    datepart(ETL_INSRT_DT) format=yymmdd10. AS ETL_INSRT_DT,
    ETL_INSRT_RUN_ID                      AS ETL_INSRT_RUN_ID,
    FAK_ID                                AS FAK_ID,
    FEATURE_CD                            AS FEATURE_CD,
    FEED_ID                               AS FEED_ID,
    FRANCHISE_TYPE                        AS FRANCHISE_TYPE,
    FUTURE_1                              AS FUTURE_1,
    FUTURE_2                              AS FUTURE_2,
    GAAP                                  AS GAAP ,
    IMEI_SKU                              AS IMEI_SKU,
    IMEI                                  AS IMEI,
    INTER_COMPANY                         AS INTER_COMPANY,
    datepart(JL_AMENDED_ON) format=yymmdd10. AS JL_AMENDED_ON,
    JL_AUTHORIZED_BY                      AS JL_AUTHORIZED_BY,
    JL_CREATED_BY                         AS JL_CREATED_BY,
    datepart(JL_CREATED_ON) format=yymmdd10. AS JL_CREATED_ON,
    JL_DESC                               AS JL_DESC,
    JL_POSTED_BY                          AS JL_POSTED_BY,
    JOURNAL_DESC                          AS JOURNAL_DESC,
    JRNL_HEADER_ID                        AS JRNL_HEADER_ID,
    JRNL_LINE_NUMBER                      AS JRNL_LINE_NUMBER,
    JRNL_PROCESS_ID                       AS JRNL_PROCESS_ID,
    JRNL_STATUS_TEXT                      AS JRNL_STATUS_TEXT,
    JRNL_STATUS                           AS JRNL_STATUS,
    JRNL_TYPE                             AS JRNL_TYPE,
    LEGAL_ENTITY                          AS LEGAL_ENTITY,
    LOCATION                              AS LOCATION,
    MANUAL_ADJ_FLAG                       AS MANUAL_ADJ_FLAG,
    NAC_VS_HUP                            AS NAC_VS_HUP,
    NO_OF_DAYS_DEF_ACC                    AS NO_OF_DAYS_DEF_ACC,
    PCT_INSTRUMENT_ID                     AS PCT_INSTRUMENT_ID,
    PRODUCT                               AS PRODUCT,
    REV_CD                                AS REV_CD,
    datepart(REVERSAL_DATE) format=yymmdd10. AS REVERSAL_DATE,
    SCHEMA                                AS SCHEMA,
    SEGMENT                               AS SEGMENT,
    SID                                   AS SID,
    SKU                                   AS SKU,
    SLR_JOURNAL_LINE_EXT_SKEY             AS SLR_JOURNAL_LINE_EXT_SKEY,
    SOC                                   AS SOC,
    SOURCE_SYSTEM                         AS SOURCE_SYSTEM,
    SUBSCRIBER_ID                         AS SUBSCRIBER_ID,
    SUBSCRIBER_NO                         AS SUBSCRIBER_NO,
    SYS_CREATE_DATETIME                   AS SYS_CREATE_DATETIME,
    SYS_CREATED_BY                        AS SYS_CREATED_BY,
    SYS_UPDATE_DATETIME                   AS SYS_UPDATE_DATETIME,
    SYS_UPDATED_BY                        AS SYS_UPDATED_BY,
    UNIQUE_TRANS_ID                       AS UNIQUE_TRANS_ID,
    datepart(VALUE_DATE) format=yymmdd10. AS VALUE_DATE,
    VOL_INVOL_TERMINATION                 AS VOL_INVOL_TERMINATION
FROM CONNECTION TO oracle
(  
SELECT DISTINCT
    ROUND(ACC_DEF_BASE_CALC_AMOUNT,2)  AS ACC_DEF_BASE_CALC_AMOUNT,
    ACC_EVENT_ID                       AS ACC_EVENT_ID,
    ACCEVENT_ID                        AS ACCEVENT_ID,
    ACCOUNT                            AS ACCOUNT,
    ACCRUAL_TREATMENT_TYPE             AS ACCRUAL_TREATMENT_TYPE,
    ROUND(  ACTIVITY_AMOUNT ,2)        AS ACTIVITY_AMOUNT,
  ACTIVITY_DATE                        AS ACTIVITY_DATE,
  ADJ_REASON_CD                        AS ADJ_REASON_CD,
  AE_INPUT_TIME                        AS AE_INPUT_TIME,
  BALANCE_TYPE                         AS BALANCE_TYPE,
  BAN_NUM                              AS BAN_NUM,
    BILL_YEAR                          as BILL_YEAR,
    CYCLE_RUN_YEAR                     as CYCLE_RUN_YEAR,
  BALANCE_IMPACT_CODE                  as BALANCE_IMPACT_CODE,
  BAN                                  AS BAN ,
  lpad(BILL_CYCLE_CD, 2, '0')          AS BILL_CYCLE,
  BILL_MONTH_BILL_CYCLE                AS BILL_MONTH_BILL_CYCLE,
  BILL_MONTH                           AS BILL_MONTH,
  BUS_EVENT_JL_DESC                    AS BUS_EVENT_JL_DESC,
  BUS_EVENT_SUB_TYPE                   AS BUS_EVENT_SUB_TYPE,
  BUSINESS_DATE                        AS BUSINESS_DATE,
  BUSINESS_EVENT                       AS BUSINESS_EVENT,
  CA_CHANGE_TYPE                       AS CA_CHANGE_TYPE ,
  CHANNEL                              AS CHANNEL,
  CHARGE_TYPE                          AS CHARGE_TYPE,
  CONTRACT_ID                          AS CONTRACT_ID,
  CONTRACT_PRODUCT_PART_ID             AS CONTRACT_PRODUCT_PART_ID,
  CONTRACT_TRANS_TYPE                  AS CONTRACT_TRANS_TYPE,
  CONTRACT_TYPE                        AS CONTRACT_TYPE,
  CONTRACT_VERSION_NO                  AS CONTRACT_VERSION_NO,
  CREDIT_CLASS                         AS CREDIT_CLASS,
  CURRENCY                             AS CURRENCY,
  DEALER_CD                            AS DEALER_CD,
  DEPARTMENT                           AS DEPARTMENT,
  DISCOUNT_CD                          AS DISCOUNT_CD,
  EBA_ID                               AS EBA_ID,
  EFFECTIVE_DATE                       AS EFFECTIVE_DATE,
  ETL_INSRT_DT                         AS ETL_INSRT_DT,
  ETL_INSRT_RUN_ID                     AS ETL_INSRT_RUN_ID,
  FAK_ID                               AS FAK_ID,
  FEATURE_CD                           AS FEATURE_CD,
  FEED_ID                              AS FEED_ID,
  FRANCHISE_TYPE                       AS FRANCHISE_TYPE,
  FUTURE_1                             AS FUTURE_1,
  FUTURE_2                             AS FUTURE_2,
  GAAP                                 AS GAAP ,
  IMEI_SKU                             AS IMEI_SKU,
  IMEI                                 AS IMEI,
  INTER_COMPANY                        AS INTER_COMPANY,
  JL_AMENDED_ON                        AS JL_AMENDED_ON,
  JL_AUTHORIZED_BY                     AS JL_AUTHORIZED_BY,
  JL_CREATED_BY                        AS JL_CREATED_BY,
  JL_CREATED_ON                        AS JL_CREATED_ON,
  JL_DESC                              AS JL_DESC,
  JL_POSTED_BY                         AS JL_POSTED_BY,
  JOURNAL_DESC                         AS JOURNAL_DESC,
  JRNL_HEADER_ID                       AS JRNL_HEADER_ID,
  JRNL_LINE_NUMBER                     AS JRNL_LINE_NUMBER,
  JRNL_PROCESS_ID                      AS JRNL_PROCESS_ID,
  JRNL_STATUS_TEXT                     AS JRNL_STATUS_TEXT,
  JRNL_STATUS                          AS JRNL_STATUS,
  JRNL_TYPE                            AS JRNL_TYPE,
  LEGAL_ENTITY                         AS LEGAL_ENTITY,
  LOCATION                             AS LOCATION,
  MANUAL_ADJ_FLAG                      AS MANUAL_ADJ_FLAG,
  NAC_VS_HUP                           AS NAC_VS_HUP,
  NO_OF_DAYS_DEF_ACC                   AS NO_OF_DAYS_DEF_ACC,
  PCT_INSTRUMENT_ID                    AS PCT_INSTRUMENT_ID,
  PRODUCT                              AS PRODUCT,
  REV_CD                               AS REV_CD,
  REVERSAL_DATE                        AS REVERSAL_DATE,
  SCHEMA                               AS SCHEMA,
  SEGMENT                              AS SEGMENT,
  SID                                  AS SID,
  SKU                                  AS SKU,
  SLR_JOURNAL_LINE_EXT_SKEY            AS SLR_JOURNAL_LINE_EXT_SKEY,
  SOC                                  AS SOC,
  SOURCE_SYSTEM                        AS SOURCE_SYSTEM,
  SUBSCRIBER_ID                        AS SUBSCRIBER_ID,
  SUBSCRIBER_NO                        AS SUBSCRIBER_NO,
  SYS_CREATE_DATETIME                  AS SYS_CREATE_DATETIME,
  SYS_CREATED_BY                       AS SYS_CREATED_BY,
  SYS_UPDATE_DATETIME                  AS SYS_UPDATE_DATETIME,
  SYS_UPDATED_BY                       AS SYS_UPDATED_BY,
  UNIQUE_TRANS_ID                      AS UNIQUE_TRANS_ID,
  VALUE_DATE                           AS VALUE_DATE,
  VOL_INVOL_TERMINATION                AS VOL_INVOL_TERMINATION
FROM OBIEE_IFRS_USER.SLR_JOURNAL_LINE_EXT
WHERE ( 1 = 1
        &Report_Where.
        &BusEvent_where.
        &activity_date_ora.
        &BillCycle_where_ora.
        &effective_date_ora_min.
        &effective_date_ora_max.
      )
order by activity_amount desc
);

quit;

%macro emailCSV;
  %if "&CSV_flag." = "Yes" %then %do;
    proc export dbms=csv  file="~/&SelectReport..csv" replace;
    run;

    filename myemail email 
                     content_type="text/plain"
                     attach=( "~/&SelectReport..csv")
                     to=("&SYSUSERID.@rci.rogers.com")
                     subject="Output from &SelectReport." lrecl=120;

    data _null_;
      file myemail;

      put 'Hi everyone,';
      put "This email was sent by SAS Server" / "do not answer it";
      put //// 'Thanks,';
      put &_CLIENTUSERNAME.;

    run;
  %end;
%mend emailCSV;

%emailCSV;
