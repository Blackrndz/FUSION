/* ****************************************************************************
 * $Revision: 78239 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 22:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Rate%20Definitions%20-%20Rate%20Contributors.sql $:
 * $Id: Manage Rate Definitions - Rate Contributors.sql 78239 2022-04-07 15:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
-- RSC_PREREQUISITE_OBJECTS=PAY_RATE_DEFINITIONS_F
-- RSC_PREREQUISITE_OBJECTS=PAY_RATE_DEFINITIONS_F_TL
-- RSC_PREREQUISITE_OBJECTS=PAY_BALANCE_DIMENSIONS
-- RSC_PREREQUISITE_OBJECTS=PAY_RATE_CONTRIBUTORS_F
 
SELECT  payRATEDEFTLEO.NAME RES_NAME
,payRATEDEFEO.SHORT_NAME RES_SHORT_NAME
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE  LOOKUP_CODE = payRATECONTRIBUEO.CONTRIBUTOR_TYPE
	AND LOOKUP_TYPE = 'ORA_PAY_RATE_CONTRIBUTOR_TYPES' AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_CONTRIBUTOR_TYPE
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE  LOOKUP_CODE = payRATECONTRIBUEO.FEED
	AND LOOKUP_TYPE = 'PAY_ADD_SUBTRACT' AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_ADD_OR_SUBTRACT
,(SELECT DEFINITION_NAME FROM PAY_TIME_DEFINITIONS WHERE TIME_DEFINITION_ID = payRATECONTRIBUEO.AS_OF_DATE) RES_REFERENCE_DATE
,(SELECT BALANCE_NAME FROM PAY_BALANCE_TYPES_VL WHERE  BALANCE_TYPE_ID = payRATECONTRIBUEO.BALANCE_TYPE_ID) RES_BALANCE_NAME
,(CASE WHEN payRATECONTRIBUEO.CONTRIBUTOR_TYPE = 'S' THEN
	(SELECT SUBSTR(BASE_DIMENSION_NAME,5,LENGTH(BASE_DIMENSION_NAME)-4) FROM PAY_BALANCE_DIMENSIONS WHERE BALANCE_DIMENSION_ID = payRATECONTRIBUEO.BALANCE_DIMENSION_ID)END) RES_BALANCE_DIMENSION
,(SELECT NAME FROM PAY_RATE_DEFINITIONS_F_VL WHERE RATE_DEFINITION_ID = payRATECONTRIBUEO.CONTRIBUTOR_ID 
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD')))RES_RATE_NAME
,(CASE WHEN payRATECONTRIBUEO.CONTRIBUTOR_TYPE = 'BS' THEN 
	(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE  LOOKUP_CODE = payDIMENE0.DIMENSION_LEVEL
	AND LOOKUP_TYPE = 'PAY_DIMENSION_LEVEL' AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD')))END)  RES_EMPLOYMENT_LEVEL

,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE  LOOKUP_CODE = payRATECONTRIBUEO.PERIODICITY
	AND LOOKUP_TYPE = 'PAY_TMPLT_ET_TIME_DEFINITION' AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_PERIODICITY
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE  LOOKUP_CODE = payRATECONTRIBUEO.FACTOR_TYPE
	AND LOOKUP_TYPE = 'PAY_RATE_FACTOR_TYPES' AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD')))  RES_FACTOR_RULE
,(CASE WHEN payRATECONTRIBUEO.FACTOR_TYPE = 'VBC'
	THEN (SELECT NAME FROM PAY_VALUE_DEFINITIONS_TL WHERE VALUE_DEFN_ID = payRATECONTRIBUEO.FACTOR_VALUE AND LANGUAGE = USERENV('LANG')) 
	ELSE payRATECONTRIBUEO.FACTOR_VALUE END) RES_FACTOR_VALUE
,payRATECONTRIBUEO.FACTOR_IDENTIFIER RES_CRITERIA_VALUE
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE  LOOKUP_CODE = payRATECONTRIBUEO.MIN_TYPE 
	AND LOOKUP_TYPE = 'PAY_RATE_MIN_MAX_TYPES' AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_MINIMUM_RATE_RULE
,(CASE WHEN payRATECONTRIBUEO.MIN_TYPE  = 'VBC'
	THEN (SELECT NAME FROM PAY_VALUE_DEFINITIONS_TL WHERE VALUE_DEFN_ID = payRATECONTRIBUEO.MIN_VALUE
			AND LANGUAGE = USERENV('LANG'))
	WHEN payRATECONTRIBUEO.MIN_TYPE = 'RD' 
	THEN (SELECT NAME FROM PAY_RATE_DEFINITIONS_F_TL WHERE RATE_DEFINITION_ID = payRATECONTRIBUEO.MIN_VALUE
			AND LANGUAGE = USERENV('LANG'))
	ELSE payRATECONTRIBUEO.MIN_VALUE END) RES_MINIMUM_RATE_VALUE
,payRATECONTRIBUEO.MIN_VALUE_IDENTIFIER RES_MINIMUM_RATE_CRITERIA_VALU
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE  LOOKUP_CODE = payRATECONTRIBUEO.MAX_TYPE
	AND LOOKUP_TYPE = 'PAY_RATE_MIN_MAX_TYPES' AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_MAXIMUM_RATE_RULE
,(CASE WHEN payRATEDEFEO.MAX_TYPE = 'VBC'
	THEN (SELECT NAME FROM PAY_VALUE_DEFINITIONS_TL WHERE VALUE_DEFN_ID = payRATECONTRIBUEO.MAX_VALUE 
			AND LANGUAGE = USERENV('LANG'))
	WHEN payRATEDEFEO.MAX_TYPE = 'RD' 
	THEN (SELECT NAME FROM PAY_RATE_DEFINITIONS_F_TL WHERE RATE_DEFINITION_ID = payRATECONTRIBUEO.MAX_VALUE 
			AND LANGUAGE = USERENV('LANG')
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD')))
	ELSE payRATECONTRIBUEO.MAX_VALUE  END) RES_MAXIMUM_RATE_VALUE
,payRATECONTRIBUEO.MAX_VALUE_IDENTIFIER RES_MAXIMUM_RATE_CRITERIA_VALU
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE  LOOKUP_CODE = payRATECONTRIBUEO.LIMIT_MODE 
	AND LOOKUP_TYPE = 'ORA_PAY_RATE_LIMIT_MODE' AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_LIMIT_VIOLATION_ACTION
,DECODE(payRATECONTRIBUEO.FTE_FLAG,'Y','Yes','No') RES_RETURN_FULL_TIME_RATE
,TO_CHAR(payRATECONTRIBUEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(payRATECONTRIBUEO.EFFECTIVE_END_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,(SELECT BALANCE_NAME FROM PAY_BALANCE_TYPES_VL WHERE  BALANCE_TYPE_ID = payRATECONTRIBUEO.DIVISIONAL_BAL_TYPE_ID) RES_DIVISIONAL_BALANCE

,payRATECONTRIBUEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,payRATECONTRIBUEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,payRATECONTRIBUEO.CREATED_BY RSC_CREATED_BY
,payRATECONTRIBUEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,(SELECT LEGISLATION_CODE 
	FROM PER_LEGISLATIVE_DATA_GROUPS
	WHERE LEGISLATIVE_DATA_GROUP_ID = payRATEDEFEO.LEGISLATIVE_DATA_GROUP_ID
	) RSC_COUNTRY_ID

FROM PAY_RATE_DEFINITIONS_F payRATEDEFEO
,PAY_RATE_DEFINITIONS_F_TL payRATEDEFTLEO
,PAY_RATE_CONTRIBUTORS_F payRATECONTRIBUEO
,PAY_BALANCE_DIMENSIONS payDIMENE0
WHERE payRATEDEFEO.RATE_DEFINITION_ID = payRATEDEFTLEO.RATE_DEFINITION_ID
AND payRATEDEFEO.RATE_DEFINITION_ID = payRATECONTRIBUEO.RATE_DEFINITION_ID
AND payRATECONTRIBUEO.BALANCE_DIMENSION_ID = payDIMENE0.BALANCE_DIMENSION_ID(+)
AND payRATEDEFTLEO.LANGUAGE = USERENV('LANG')
AND SYSDATE BETWEEN payRATEDEFEO.EFFECTIVE_START_DATE AND NVL(payRATEDEFEO.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
AND SYSDATE BETWEEN payRATECONTRIBUEO.EFFECTIVE_START_DATE AND NVL(payRATECONTRIBUEO.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
ORDER BY RES_NAME