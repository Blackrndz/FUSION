/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Balance%20Definitions%20-%20Balance%20Feeds%20by%20Element.sql $:
 * $Id: Manage Balance Definitions - Balance Feeds by Element.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT 
(CASE WHEN payBALNTYPEO.LEGISLATION_CODE IS NULL
	THEN (SELECT NAME FROM PER_LEGISLATIVE_DATA_GROUPS_VL WHERE LEGISLATIVE_DATA_GROUP_ID  = payBALNTYPEO.LEGISLATIVE_DATA_GROUP_ID)
	WHEN payBALNTYPEO.LEGISLATION_CODE = 'GB'
	THEN 'GB Legislative Data Group'
	WHEN payBALNTYPEO.LEGISLATION_CODE = 'US'
	THEN 'US Legislative Data Group'
	ELSE (SELECT NAME FROM PER_LEGISLATIVE_DATA_GROUPS_VL WHERE LEGISLATION_CODE  = payBALNTYPEO.LEGISLATION_CODE) END) RES_LEGISLATIVE_DATA_GROUP
,payBALNTYPEO.BALANCE_NAME RES_NAME
,payELETYPEO.ELEMENT_NAME RES_ELEMENT_NAME
,(SELECT BASE_CLASSIFICATION_NAME FROM PAY_ELE_CLASSIFICATIONS WHERE CLASSIFICATION_ID = payELETYPEO.CLASSIFICATION_ID
	AND SYSDATE BETWEEN DATE_FROM AND NVL(DATE_TO,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_ELEMENT_CLASSIFICATIONS
,(CASE WHEN payELETYPEO.USE_AT_ASG_LEVEL = 'Y' 
	THEN 'Payroll Assignment'
	ELSE 'Payroll Relationship' END)RES_EMPLOYMENT_LEVEL
,(SELECT NAME FROM PAY_INPUT_VALUES_VL WHERE INPUT_VALUE_ID = payBALFEEDEO.INPUT_VALUE_ID
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE ,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_INPUT_VALUE
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = payBALFEEDEO.SCALE
		AND LOOKUP_TYPE = 'PAY_ADD_SUBTRACT' AND LANGUAGE = USERENV('LANG')
		AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE ,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_ADD_OR_SUBTRACT
,TO_CHAR(payBALFEEDEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,DECODE(TO_CHAR(payBALFEEDEO.EFFECTIVE_END_DATE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(payBALFEEDEO.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE

,payBALFEEDEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,payBALFEEDEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,payBALFEEDEO.CREATED_BY RSC_CREATED_BY
,payBALFEEDEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM PAY_BALANCE_TYPES_VL  payBALNTYPEO
,PAY_BALANCE_FEEDS_F  payBALFEEDEO
,PAY_ELEMENT_TYPES_VL payELETYPEO
WHERE payBALNTYPEO.BALANCE_TYPE_ID = payBALFEEDEO.BALANCE_TYPE_ID
AND payBALFEEDEO.ELEMENT_TYPE_ID = payELETYPEO.ELEMENT_TYPE_ID
ORDER BY RES_LEGISLATIVE_DATA_GROUP,RES_NAME,RES_EFFECTIVE_START_DATE,RES_ELEMENT_NAME