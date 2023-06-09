/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Configure%20Payroll%20Legislations%20-%20Configure%20Legislation.sql $:
 * $Id: Configure Payroll Legislations - Configure Legislation.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
WITH TAX_YEAR AS (SELECT LEGISLATION_CODE,RULE_MODE FROM PAY_LEGISLATION_RULES WHERE RULE_TYPE = 'L'),
PAYROLL_RELATION AS (SELECT LEGISLATION_CODE,RULE_MODE FROM PAY_LEGISLATION_RULES WHERE RULE_TYPE = 'I')


SELECT fndTERREO.TERRITORY_SHORT_NAME RES_LEGISLATION
,(CASE WHEN INSTR((SELECT RULE_MODE FROM TAX_YEAR WHERE LEGISLATION_CODE = payINSTALLLEGISEO.LEGISLATION_CODE),'/') = 0 
	THEN 
	(SELECT SUBSTR(RULE_MODE,INSTR(RULE_MODE,'-')+1,LENGTH(RULE_MODE)) FROM TAX_YEAR WHERE LEGISLATION_CODE = payINSTALLLEGISEO.LEGISLATION_CODE)
	ELSE
	(SELECT SUBSTR(RULE_MODE,INSTR(RULE_MODE,'/')+1,LENGTH(RULE_MODE)) FROM TAX_YEAR WHERE LEGISLATION_CODE = payINSTALLLEGISEO.LEGISLATION_CODE)
		END) RES_MONTH 
,(CASE WHEN INSTR((SELECT RULE_MODE FROM TAX_YEAR WHERE LEGISLATION_CODE = payINSTALLLEGISEO.LEGISLATION_CODE),'/') = 0 
	THEN 
	(SELECT SUBSTR(RULE_MODE,1,INSTR(RULE_MODE,'-')-1) FROM TAX_YEAR WHERE LEGISLATION_CODE = payINSTALLLEGISEO.LEGISLATION_CODE)
	ELSE
	(SELECT SUBSTR(RULE_MODE,1,INSTR(RULE_MODE,'/')-1) FROM TAX_YEAR WHERE LEGISLATION_CODE = payINSTALLLEGISEO.LEGISLATION_CODE) 
		END) RES_DATE
,(SELECT NAME FROM FND_CURRENCIES_VL WHERE CURRENCY_CODE = fndTERREO.CURRENCY_CODE) RES_CURRENCY
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = payRELAEO.RULE_MODE
		AND LOOKUP_TYPE = 'PAY_TMPLT_LEG_RULE_REHIRE' AND LANGUAGE = USERENV('LANG')
		AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE ,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_RULE


,payINSTALLLEGISEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,payINSTALLLEGISEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,payINSTALLLEGISEO.CREATED_BY RSC_CREATED_BY
,payINSTALLLEGISEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PAY_INSTALLED_LEGISLATIONS payINSTALLLEGISEO
,PAYROLL_RELATION payRELAEO
,TAX_YEAR taxEO
,FND_TERRITORIES_VL fndTERREO
WHERE  payINSTALLLEGISEO.LEGISLATION_CODE = payRELAEO.LEGISLATION_CODE
AND payINSTALLLEGISEO.LEGISLATION_CODE = taxEO.LEGISLATION_CODE
AND payINSTALLLEGISEO.LEGISLATION_CODE = fndTERREO.TERRITORY_CODE 
AND taxEO.RULE_MODE IS NOT NULL
ORDER BY 1