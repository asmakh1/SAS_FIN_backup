%put RUNNING REPORT FROM &effective_date_filter_min_label. TO &effective_date_filter_max_label.;
%let Report_Where= AND 
	(LEGAL_ENTITY in ('F51', 'F52') 
or LEGAL_ENTITY >= '500') and (LEGAL_ENTITY in ('F51', 'F52') 
or LEGAL_ENTITY <= '599') 
and DEPARTMENT = '0141'
and ACCOUNT BETWEEN '47000' AND '47999';
%put &Report_Where.;
