%put RUNNING REPORT FROM &effective_date_filter_min_label. TO &effective_date_filter_max_label.;
%let Report_Where= AND (LEGAL_ENTITY in ('F51', 'F52') or LEGAL_ENTITY >= '500') and (LEGAL_ENTITY in ('F51', 'F52') or LEGAL_ENTITY <= '599') and (PRODUCT in ('1040', '1420')) and ACCOUNT between '40000' and '46999' ;
%put &Report_Where.;
