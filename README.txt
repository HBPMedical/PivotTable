20171108 - subjectagemonths has been changed to subjectage, that is the age using decimals. This can be extracted from visit.patient_age - subjectageyears can be extracted using round(visit.patient_age)


20171107 - the version that extracts the months works only in cases where the birthdate of the patient has been provided. If a date has not been provided then the script does not work. Hence, it does not work in CLM dataset but works on Lille and Niguarda

However the cde needs to be created - hence this might change
