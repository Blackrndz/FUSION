/* ****************************************************************************
 * $Revision: 53782 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-03-31 18:00:16 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: $:
 * $Id: Manage Enterprise HCM Information - Attachments.sql 53782 2016-03-22 11:00:16Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=EXM_EXP_TYPE_ENTERT_POL_MAP
 
SELECT ExpenseTemplateEO.NAME RES_EXPENSE_REPORT_TEMPLATES_N
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = ExpenseTemplateEO.ORG_ID
	) RES_BUSINESS_UNIT
,ExpenseTypeEO.NAME RES_EXPENSE_TYPE_NAME
,PolicyEO.POLICY_NAME RES_POLICY_NAME
,PolicyEO.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(PolExpTypeMapEO.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(PolExpTypeMapEO.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,PolExpTypeMapEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PolExpTypeMapEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PolExpTypeMapEO.CREATED_BY RSC_CREATED_BY
,PolExpTypeMapEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,ExpenseTemplateEO.ORG_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_EXPENSE_TEMPLATES ExpenseTemplateEO
,EXM_EXPENSE_TYPES ExpenseTypeEO
,EXM_EXP_TYPE_ENTERT_POL_MAP PolExpTypeMapEO
,EXM_ENTERTAINMENT_POLICIES PolicyEO
WHERE ExpenseTemplateEO.EXPENSE_TEMPLATE_ID = ExpenseTypeEO.EXPENSE_TEMPLATE_ID
AND PolExpTypeMapEO.ENTERTAINMENT_POLICY_ID = PolicyEO.ENTERTAINMENT_POLICY_ID
AND PolExpTypeMapEO.EXPENSE_TYPE_ID = ExpenseTypeEO.EXPENSE_TYPE_ID
ORDER BY ExpenseTemplateEO.NAME
,RES_BUSINESS_UNIT
,ExpenseTypeEO.NAME
,PolicyEO.POLICY_NAME