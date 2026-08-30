%put RUNNING REPORT FROM &effective_date_filter_min_label. TO &effective_date_filter_max_label.;
%let Report_Where= AND 
	DEPARTMENT = '0136' and (LEGAL_ENTITY in ('F51', 'F52') or LEGAL_ENTITY <= '599') and (LEGAL_ENTITY in ('F51', 'F52') or LEGAL_ENTITY >= '500') and ACCOUNT between '47000' and '47999';
%put &Report_Where.;
