%put RUNNING REPORT FROM &effective_date_filter_min_label. TO &effective_date_filter_max_label.;

%let Report_Where= AND (ACCOUNT  IN ('40617', '40625', '40692')
                     OR ACCOUNT        >= '40001'
                     OR ACCOUNT        >= '40177'
                     OR ACCOUNT        >= '40610'
                     OR ACCOUNT        >= '40650'
                     OR ACCOUNT        >= '45000'
                     OR ACCOUNT        <= '40599')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '40650'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '40650'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40599')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40650'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40613')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '40650'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40199')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '40650'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '40650'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40650'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40613')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '40650'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40650'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40613')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '40650'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40650'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40613')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40650'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40613')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40650'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40613')
AND (LEGAL_ENTITY IN ('F51', 'F52')
OR LEGAL_ENTITY   <= '599')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40650'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40613')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '40650'
OR ACCOUNT        >= '45000')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '40650'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '40650'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40199')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '40650'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40016')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '40650'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '40650'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '45010')
AND (LEGAL_ENTITY IN ('F51', 'F52')
OR LEGAL_ENTITY   >= '500')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '40650'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40599')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40653')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40653')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40653')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40653')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40653')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40653')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '40653')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '40653')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '40653')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '40650'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40599')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '40653')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '40653')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40610'
OR ACCOUNT        <= '40653'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '40653')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40653')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40610'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40653')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40650'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40650'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40650'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40650'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40650'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40650'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40650'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40610'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40653'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40610'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40653'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40610'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40653'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40400'
OR ACCOUNT        >= '40610'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40653'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '40653')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40610'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40653'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40650'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40400'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '40653'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '40653'
OR ACCOUNT        <= '45010')
AND (PRODUCT      >= '1011'
OR PRODUCT        <= '1333')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40177'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '40653'
OR ACCOUNT        <= '45010')
AND (PRODUCT      >= '1011'
OR PRODUCT        >= '1301')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40650'
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40613')
AND (PRODUCT      <= '1033'
OR PRODUCT        <= '1333')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40177'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '40653'
OR ACCOUNT        <= '45010')
AND (PRODUCT      >= '1301'
OR PRODUCT        <= '1033')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        >= '40400'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '40653'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40610'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40653'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40001'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '40653'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40610'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40653'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40177'
OR ACCOUNT        >= '40400'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '40653'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '40400'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '40653'
OR ACCOUNT        <= '45010')
AND (ACCOUNT      IN ('40617', '40625', '40692')
OR ACCOUNT        >= '45000'
OR ACCOUNT        <= '40016'
OR ACCOUNT        <= '40199'
OR ACCOUNT        <= '40599'
OR ACCOUNT        <= '40613'
OR ACCOUNT        <= '40653');

%put &Report_Where.;
