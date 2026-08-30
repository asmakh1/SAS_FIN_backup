%put RUNNING REPORT FROM &effective_date_filter_min_label. TO &effective_date_filter_max_label.;
%let Report_Where= AND DEPARTMENT = '0121' and (LEGAL_ENTITY in ('534', 'F51')) and ACCOUNT between '47000' and '47999';
%put &Report_Where.;
