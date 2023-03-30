/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=WLF_PROPERTIES

SELECT (SELECT FORMULA_NAME 
	FROM FF_FORMULAS_TL 
	WHERE LANGUAGE = USERENV('LANG')
	AND TO_CHAR(FORMULA_ID) = (SELECT VALUE
		FROM WLF_PROPERTIES
		WHERE NAME = 'ORA_WLF_PLAN_WAGE_RATE_FF_ID')
	) RES_LEARNER_WAGE_RATE_FORMULA
,lookupsEo.MEANING RES_SUMMARY_METRICS
,'' RES_SUMMARY_STATUS
,setupsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,setupsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,setupsE0.CREATED_BY  RSC_CREATED_BY
,setupsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WLF_PROPERTIES setupsE0
,FND_LOOKUP_VALUES lookupsEo
WHERE lookupsEo.LANGUAGE = USERENV('LANG')
AND lookupsEo.LOOKUP_TYPE = 'ORA_WLF_PLAN_METRICS'
AND lookupsEo.LOOKUP_CODE = setupsE0.NAME
ORDER BY setupsE0.VALUE