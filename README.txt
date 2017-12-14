20171213
-----------------
- pivot_i2b2_cde_SF_MinDate_onPgAdmin: creates the flat csv table considering for each concept_cd the oldest examination date (min(start_date)
- pivot_i2b2_cde_SF_MinDate: same as above but runs on MIPMap psql

20171121
---------------
- pivot_i2b2: contains old schema, creates one file with (old) cde and extra variables, does not consider baseline examination
- pivot_i2b2_cde: cde schema, creates two files (one with cde variables and one with extra), considers only baseline examinations
- pivot_i2b2_cde_noBaseline: same as "pivot_i2b2_cde" but does not consider baseline examinations
- pivot_i2b2_cde_onPgAdmin: same as "pivot_i2b2_cde" that can be run (more easily) on pgAdmin
- pivot_i2b2_cde_singleFile: cde schema, same as "pivot_i2b2_cde" that creates one single file with all variables (cde and extra), considers only baseline examinations
- pivot_i2b2-noMonths: same as "pivot_i2b2", but in its schema there exist no subjectagemonths column


20171120
---------------------------
Renamed:
1. pivot_i2b2_cde_getBaselineFromYoungerPatient --> pivot_i2b2_cde
2. pivot_i2b2_cde --> pivot_i2b2_cde_noBaseline

Updated:
1. pivot_i2b2_cde_onPgAdmin to consider only baseline exams



pivot_i2b2_cde_getBaselineFromYoungerPatient
---------------------------------------------
In this file on line 72 we select the baseline encounters of the patient. This is done by selecting the encounter number that is connected to the minimum age of the patient, and in the following select only the examinations that are related to this encounter


20171108 - subjectagemonths has been changed to subjectage, that is the age using decimals. This can be extracted from visit.patient_age - subjectageyears can be extracted using round(visit.patient_age)


20171107 - the version that extracts the months works only in cases where the birthdate of the patient has been provided. If a date has not been provided then the script does not work. Hence, it does not work in CLM dataset but works on Lille and Niguarda

However the cde needs to be created - hence this might change
