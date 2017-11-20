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
