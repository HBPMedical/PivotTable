DO $$
Declare concept text;
Declare valtype text;
Declare type_name text;
Declare query text;
Declare table_name text;
Declare char_val text;
Declare num_val numeric(18,5);
Declare usedid text;
Declare currentid text;
Declare sex text;
Declare year integer;
Declare startdate timestamp without time zone;
Declare subjectcode integer;
Declare subjectageyears integer;
Declare subjectage numeric(18,5);
Declare gender text;
Declare dataset text;
Declare agegroup text;
Declare encounter text;
BEGIN
query := '';
usedid := '';

-- create table for cde variables - the list of variables in this table are fixed (cde variables)
table_name := 'new_table';
query := 'CREATE TABLE ' || table_name || '( "subjectcode" integer, "subjectageyears" text, "subjectage" text, "gender" text, "3rdventricle" text, "4thventricle" text, "rightaccumbensarea" text, "leftaccumbensarea" text, "rightamygdala" text, "leftamygdala" text, "brainstem" text, "rightcaudate" text, "leftcaudate" text, "rightcerebellumexterior" text, "leftcerebellumexterior" text, "rightcerebellumwhitematter" text, "leftcerebellumwhitematter" text, "rightcerebralwhitematter" text, "leftcerebralwhitematter" text, "csfglobal" text, "righthippocampus" text, "lefthippocampus" text, "rightinflatvent" text, "leftinflatvent" text, "rightlateralventricle" text, "leftlateralventricle" text, "rightpallidum" text, "leftpallidum" text, "rightputamen" text, "leftputamen" text, "rightthalamusproper" text, "leftthalamusproper" text, "rightventraldc" text, "leftventraldc" text, "opticchiasm" text, "cerebellarvermallobulesiv" text, "cerebellarvermallobulesvivii" text, "cerebellarvermallobulesviiix" text, "leftbasalforebrain" text, "rightbasalforebrain" text, "rightacgganteriorcingulategyrus" text, "leftacgganteriorcingulategyrus" text, "rightainsanteriorinsula" text, "leftainsanteriorinsula" text, "rightaorganteriororbitalgyrus" text, "leftaorganteriororbitalgyrus" text, "rightangangulargyrus" text, "leftangangulargyrus" text, "rightcalccalcarinecortex" text, "leftcalccalcarinecortex" text, "rightcocentraloperculum" text, "leftcocentraloperculum" text, "rightcuncuneus" text, "leftcuncuneus" text, "rightententorhinalarea" text, "leftententorhinalarea" text, "rightfofrontaloperculum" text, "leftfofrontaloperculum" text, "rightfrpfrontalpole" text, "leftfrpfrontalpole" text, "rightfugfusiformgyrus" text, "leftfugfusiformgyrus" text, "rightgregyrusrectus" text, "leftgregyrusrectus" text, "rightioginferioroccipitalgyrus" text, "leftioginferioroccipitalgyrus" text, "rightitginferiortemporalgyrus" text, "leftitginferiortemporalgyrus" text, "rightliglingualgyrus" text, "leftliglingualgyrus" text, "rightlorglateralorbitalgyrus" text, "leftlorglateralorbitalgyrus" text, "rightmcggmiddlecingulategyrus" text, "leftmcggmiddlecingulategyrus" text, "rightmfcmedialfrontalcortex" text, "leftmfcmedialfrontalcortex" text, "rightmfgmiddlefrontalgyrus" text, "leftmfgmiddlefrontalgyrus" text, "rightmogmiddleoccipitalgyrus" text, "leftmogmiddleoccipitalgyrus" text, "rightmorgmedialorbitalgyrus" text, "leftmorgmedialorbitalgyrus" text, "rightmpogpostcentralgyrusmedialsegment" text, "leftmpogpostcentralgyrusmedialsegment" text, "rightmprgprecentralgyrusmedialsegment" text, "leftmprgprecentralgyrusmedialsegment" text, "rightmsfgsuperiorfrontalgyrusmedialsegment" text, "leftmsfgsuperiorfrontalgyrusmedialsegment" text, "rightmtgmiddletemporalgyrus" text, "leftmtgmiddletemporalgyrus" text, "rightocpoccipitalpole" text, "leftocpoccipitalpole" text, "rightofugoccipitalfusiformgyrus" text, "leftofugoccipitalfusiformgyrus" text, "rightopifgopercularpartoftheinferiorfrontalgyrus" text, "leftopifgopercularpartoftheinferiorfrontalgyrus" text, "rightorifgorbitalpartoftheinferiorfrontalgyrus" text, "leftorifgorbitalpartoftheinferiorfrontalgyrus" text, "rightpcggposteriorcingulategyrus" text, "leftpcggposteriorcingulategyrus" text, "rightpcuprecuneus" text, "leftpcuprecuneus" text, "rightphgparahippocampalgyrus" text, "leftphgparahippocampalgyrus" text, "rightpinsposteriorinsula" text, "leftpinsposteriorinsula" text, "rightpoparietaloperculum" text, "leftpoparietaloperculum" text, "rightpogpostcentralgyrus" text, "leftpogpostcentralgyrus" text, "rightporgposteriororbitalgyrus" text, "leftporgposteriororbitalgyrus" text, "rightppplanumpolare" text, "leftppplanumpolare" text, "rightprgprecentralgyrus" text, "leftprgprecentralgyrus" text, "rightptplanumtemporale" text, "leftptplanumtemporale" text, "rightscasubcallosalarea" text, "leftscasubcallosalarea" text, "rightsfgsuperiorfrontalgyrus" text, "leftsfgsuperiorfrontalgyrus" text, "rightsmcsupplementarymotorcortex" text, "leftsmcsupplementarymotorcortex" text, "rightsmgsupramarginalgyrus" text, "leftsmgsupramarginalgyrus" text, "rightsogsuperioroccipitalgyrus" text, "leftsogsuperioroccipitalgyrus" text, "rightsplsuperiorparietallobule" text, "leftsplsuperiorparietallobule" text, "rightstgsuperiortemporalgyrus" text, "leftstgsuperiortemporalgyrus" text, "righttmptemporalpole" text, "lefttmptemporalpole" text, "righttrifgtriangularpartoftheinferiorfrontalgyrus" text, "lefttrifgtriangularpartoftheinferiorfrontalgyrus" text, "rightttgtransversetemporalgyrus" text, "leftttgtransversetemporalgyrus" text, "montrealcognitiveassessment" text, "minimentalstate" text, "agegroup" text, "handedness" text, "updrstotal" text, "updrshy" text, "adnicategory" text, "edsdcategory" text, "ppmicategory" text, "alzheimerbroadcategory" text, "parkinsonbroadcategory" text, "neurogenerativescategories" text, "dataset" text, "apoe4" text, "rs3818361_t" text, "rs744373_c" text, "rs190982_g" text, "rs1476679_c" text, "rs11767557_c" text, "rs11136000_t" text, "rs610932_a" text, "rs3851179_a" text, "rs17125944_c" text, "rs10498633_t" text, "rs3764650_g" text, "rs3865444_t" text, "rs2718058_g" text, "fdg" text, "pib" text, "av45" text';
-- collect all hospital specific concept_cds in order to obtain the available columns
for concept, valtype in 
	select distinct on (concept_cd) concept_cd, valtype_cd 
	from observation_fact
loop
CASE
    WHEN 'T'=valtype 
    THEN 
	type_name := ' text';
    ELSE 
	type_name := ' numeric(18,5)';
END case;
if query = '' then
	query := query || '"' || concept || '"' || type_name ;
else
	-- if the concept_cd has not been inserted before
	if query not like ('%"' || concept || '"%') then
		-- add it in the create statement
		query := query || ',' || '"' || concept || '"' || type_name ;
	end if;
end if;
end loop;
-- add primary key
query := query || ', PRIMARY KEY (subjectcode))';

-- execute statement
execute format('DROP TABLE IF EXISTS ' || table_name);
execute format(query);
-- Table has been created. Time to populate it. 

--Need to store informatio other than concept_cd, like subjectageyears, subjectage, gender, dataset, and agegroup

for subjectcode, subjectageyears, subjectage, gender, dataset in 
	select observation_fact.patient_num, round(visit_dimension.patient_age), visit_dimension.patient_age, patient_dimension.sex_cd , observation_fact.provider_id
	from observation_fact, patient_dimension, visit_dimension, (select v.patient_num, v.encounter_num from (select patient_num, min(patient_age) mindate from visit_dimension group by patient_num) as foo, visit_dimension as v where foo.patient_num = v.patient_num and foo.mindate = v.patient_age) as encounter_num_with_min_age where observation_fact.patient_num=patient_dimension.patient_num and encounter_num_with_min_age.encounter_num = observation_fact.encounter_num and encounter_num_with_min_age.encounter_num = visit_dimension.encounter_num and encounter_num_with_min_age.patient_num = observation_fact.patient_num order by patient_num
LOOP
currentid := ',' || subjectcode || ',';

CASE 
	WHEN subjectageyears is null
		THEN agegroup = null;
	WHEN 50 <= subjectageyears and subjectageyears < 60
		THEN agegroup = '50-59y';
	WHEN 60 <= subjectageyears and subjectageyears < 70
		THEN agegroup = '60-69y';
	WHEN 70 <= subjectageyears and subjectageyears < 90
		THEN agegroup = '70-79y';
	WHEN 80 <= subjectageyears
		THEN agegroup = '+80y';
	ELSE
		agegroup = '-50y';
END CASE;

	IF ( usedid ~ currentid) then
	else
		execute format('insert into ' || table_name  || '( subjectcode, subjectageyears, subjectage, gender, dataset, agegroup) VALUES (' || subjectcode || ',' || subjectageyears || ',' || subjectage || ',''' || gender || ''',''' || dataset || ''',''' || agegroup || ''')');
		usedid := usedid || ',' || subjectcode ||',';
	end if;
END LOOP;
-- Demographics info has been stored

-- Store data. For every concept_cd and every patient store the data that are the OLDEST
for concept in SELECT column_name FROM information_schema.columns WHERE information_schema.columns.table_name = 'new_table'
loop
	for subjectcode, encounter, startdate, valtype, char_val, num_val in
	(select v.patient_num, v.encounter_num, v.start_date, v.valtype_cd, v.tval_char, v.nval_num 
	from 
		(select patient_num, min(start_date) mindate from observation_fact where concept_cd = concept group by patient_num) as foo,
		observation_fact as v 
	where foo.patient_num = v.patient_num and foo.mindate = v.start_date and concept_cd = concept)
	loop
		CASE
		    WHEN 'T'=valtype 
		    THEN
				IF coalesce(TRIM(char_val), '') <> '' AND char_val IS NOT NULL THEN
					execute format('update ' || table_name  || ' set ' || '"' || concept || '" = ''' ||  char_val || ''' where subjectcode = ' || subjectcode );
				END IF;
		   ELSE 
				IF num_val IS NOT NULL THEN
					execute format('UPDATE ' || table_name  || ' set ' || '"' || concept || '" = ' ||  num_val || ' where subjectcode = ' || subjectcode );
				END IF;
		END CASE;
	end loop;
end loop;


BEGIN
	COPY new_table FROM '/tmp/harmonized_clinical_data.csv' DELIMITER ',' CSV HEADER ; 
EXCEPTION
WHEN OTHERS 
        THEN raise notice 'No such file /tmp/harmonized_clinical_data.csv';
END;
COPY (SELECT * FROM new_table) TO '/tmp/harmonized_clinical_data.csv' WITH CSV DELIMITER ',' HEADER;
EXECUTE FORMAT('DROP TABLE IF EXISTS ' || table_name);
END; $$
