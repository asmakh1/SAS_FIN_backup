%put RUNNING REPORT FROM &effective_date_filter_min_label. TO &effective_date_filter_max_label.;
%let Report_Where=  
AND DEPARTMENT BETWEEN '0131' AND '0141'and (LEGAL_ENTITY IN ('F51', 'F52')
OR LEGAL_ENTITY       <= '599')
AND (LEGAL_ENTITY     IN ('F51', 'F52')
OR LEGAL_ENTITY       >= '500')
and ACCOUNT between '47000' and '47999';
%put &Report_Where.;
