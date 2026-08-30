%put RUNNING REPORT FROM &effective_date_filter_min_label. TO &effective_date_filter_max_label.;

%let Report_Where= AND (   LEGAL_ENTITY IN ('F51', 'F52')
                        OR LEGAL_ENTITY       <= '599')
                   AND (   LEGAL_ENTITY     IN ('F51', 'F52')
                        OR LEGAL_ENTITY       >= '500')
                   AND ACCOUNT BETWEEN '40000' AND '46999'
                   AND DEPARTMENT BETWEEN '0131' AND '0141';
%put &Report_Where.;
