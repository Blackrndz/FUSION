/* ****************************************************************************
 * $Revision: 55453 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-05-25 18:43:01 +0700 (Wed, 25 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Line%20Ordering%20Rules%20-%20AutoInvoice%20Line%20Ordering%20Rules.sql $:
 * $Id: Manage AutoInvoice Line Ordering Rules - AutoInvoice Line Ordering Rules.sql 55453 2016-05-25 11:43:01Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT CostOrgEO.COST_ORG_NAME RES_COST_ORGANIZATION
,CostBookPEO.COST_BOOK_CODE RES_COST_BOOK
,(SELECT MEANING 
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'CST_PERIOD_VALIDATION_TYPES'
	AND LOOKUP_CODE = PeriodValidationEO.VALIDATION_TYPE
	) RES_VALIDATION_TYPE
,DECODE(PeriodValidationEO.PERIOD_CLOSE_FLAG,'Y','Yes','No') RES_PERIOD_CLOSE
,DECODE(PeriodValidationEO.PERIOD_FINAL_CLOSE_FLAG,'Y','Yes','No') RES_FINAL_PERIOD_CLOSE
,(SELECT MEANING 
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'CST_PERIOD_VALIDATION_ACTIONS'
	AND LOOKUP_CODE = PeriodValidationEO.VALIDATION_ACTION_CODE
	) RES_ACTION
,PeriodValidationEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PeriodValidationEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PeriodValidationEO.CREATED_BY RSC_CREATED_BY
,PeriodValidationEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,CostOrgParametersEO.COST_ORG_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_COST_ORG_PARAMETERS CostOrgParametersEO
,CST_COST_ORGS_V CostOrgEO
,CST_COST_ORG_BOOKS CostOrgBookEO
,CST_COST_BOOKS_VL CostBookPEO
,CST_PERIOD_VALIDATIONS PeriodValidationEO
WHERE CostOrgParametersEO.COST_ORG_ID       = CostOrgEO.COST_ORG_ID
AND SYSDATE BETWEEN CostOrgEO.EFFECTIVE_START_DATE AND CostOrgEO.EFFECTIVE_END_DATE
AND CostOrgParametersEO.COST_ORG_ID = CostOrgBookEO.COST_ORG_ID
AND CostOrgBookEO.COST_BOOK_ID     = CostBookPEO.COST_BOOK_ID
AND CostOrgParametersEO.COST_ORG_ID       = PeriodValidationEO.COST_ORG_ID
AND CostOrgBookEO.COST_BOOK_ID     = PeriodValidationEO.COST_BOOK_ID
ORDER BY CostOrgEO.COST_ORG_NAME
,CostBookPEO.COST_BOOK_CODE
,PeriodValidationEO.VALIDATION_TYPE