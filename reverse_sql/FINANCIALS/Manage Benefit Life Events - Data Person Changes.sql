/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Life%20Events%20-%20Data%20Person%20Changes.sql $:
* $Id: Manage Benefit Life Events - Data Person Changes.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT NAME RES_NAME
,SOURCE_TABLE RES_TABLE_NAME
,SOURCE_COLUMN RES_COLUMN_NAME
,NVL((SELECT DECODE(MEANING,'Any value','Any Value','No value','No Value',MEANING)
		FROM FND_LOOKUP_VALUES
		WHERE LANGUAGE = USERENV('LANG')
		AND LOOKUP_TYPE IN ('BEN_ANY_OR_NULL','CONTACT','EMP_CAT')
		AND LOOKUP_CODE = OLD_VAL)
	,(CASE
		WHEN SOURCE_TABLE = 'BEN_PER_BENEFIT_GROUP_F' AND SOURCE_COLUMN = 'BENEFIT_GROUP_ID' THEN
			(SELECT NAME FROM BEN_BENFTS_GRP WHERE TO_CHAR(BENFTS_GRP_ID) = OLD_VAL)
		WHEN SOURCE_TABLE = 'BEN_BENEFIT_RELATIONS_F' AND SOURCE_COLUMN = 'PRIMARY_REL' THEN
			DECODE(OLD_VAL,'Y','Yes','No')
		ELSE
			OLD_VAL
		END)
	) RES_OLD_VALUE
,NVL((SELECT DECODE(MEANING,'Any value','Any Value','No value','No Value',MEANING)
		FROM FND_LOOKUP_VALUES
		WHERE LANGUAGE = USERENV('LANG')
		AND LOOKUP_TYPE IN ('BEN_ANY_OR_NULL','CONTACT','EMP_CAT')
		AND LOOKUP_CODE = NEW_VAL)
	,(CASE
		WHEN SOURCE_TABLE = 'BEN_PER_BENEFIT_GROUP_F' AND SOURCE_COLUMN = 'BENEFIT_GROUP_ID' THEN
			(SELECT NAME FROM BEN_BENFTS_GRP WHERE TO_CHAR(BENFTS_GRP_ID) = NEW_VAL)
		WHEN SOURCE_TABLE = 'BEN_BENEFIT_RELATIONS_F' AND SOURCE_COLUMN = 'PRIMARY_REL' THEN
			DECODE(NEW_VAL,'Y','Yes','No')
		ELSE
			NEW_VAL
		END)
	) RES_NEW_VALUE
	/*
		Columns 'RES_OLD_VALUE' and 'RES_NEW_VALUE' are the columns that need to translate with some condition that might need to investgate more 
		due to the translates are not come from only source and seem like Oracle might hardcode it to the code.
		
		Please note that I haven't apply all possible translation to this query.
	*/
,(SELECT FORMULA_NAME
	FROM FF_FORMULAS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND FORMULA_ID = PER_INFO_CHG_CS_LER_RL
	) RES_PERSON_CHANGE_FORMULA
,DECODE(RULE_OVERRIDES_FLAG,'Y','Yes','No') RES_FORMULA_OVERRIDES
,LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CREATED_BY RSC_CREATED_BY
,CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_PER_INFO_CHG_CS_LER
ORDER BY NAME