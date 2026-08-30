%put RUNNING REPORT FROM &effective_date_filter_min_label. TO &effective_date_filter_max_label.;

%let Report_Where= AND DEPARTMENT = '0121'
                   AND (LEGAL_ENTITY IN ('571', 'F52'))
                   AND ACCOUNT BETWEEN '40000' AND '46999';
%put &Report_Where.;
