/* ****************************************************************************
 * $Revision: 53782 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-03-31 18:00:16 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: $:
 * $Id: Manage Enterprise HCM Information - Attachments.sql 53782 2016-03-22 11:00:16Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT ExpenseTemplateEO.NAME RES_EXPENSE_REPORT_TEMPLATES_N
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = ExpenseTemplateEO.ORG_ID
	) RES_BUSINESS_UNIT
,ExpenseTypeEO.NAME RES_EXPENSE_TYPE_NAME
,ExpLookupYtpesE0.DISPLAYED_FIELD RES_PREFERRED_MERCHANT_LIST
,TO_CHAR(ExpTypePreferMapEO.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(ExpTypePreferMapEO.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,(SELECT DISPLAYED_FIELD
	FROM EXM_LOOKUP_VALUES
	WHERE LOOKUP_TYPE = 'EXM_PREFERRED_ENFORCEMENT'
	AND LOOKUP_CODE = ExpTypePreferMapEO.PREFERRED_ENFORCEMENT_CODE
	) RES_POLICY_ENFORCEMENT
,DECODE(ExpTypePreferMapEO.DISP_WARNING_TO_USER_FLAG,'Y','Yes','No') RES_DISPLAY_WARNING_TO_USER
,ExpTypePreferMapEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExpTypePreferMapEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExpTypePreferMapEO.CREATED_BY RSC_CREATED_BY
,ExpTypePreferMapEO.CREATION_DATE RSC_CREATION_DATE
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
,EXM_EXP_TYPE_PREFER_MAP ExpTypePreferMapEO
,EXM_LOOKUP_TYPES ExpLookupYtpesE0
WHERE ExpenseTemplateEO.EXPENSE_TEMPLATE_ID = ExpenseTypeEO.EXPENSE_TEMPLATE_ID
AND ExpenseTypeEO.EXPENSE_TYPE_ID = ExpTypePreferMapEO.EXPENSE_TYPE_ID
AND ExpTypePreferMapEO.LOOKUP_TYPE = ExpLookupYtpesE0.LOOKUP_TYPE
ORDER BY ExpenseTemplateEO.NAME
,RES_BUSINESS_UNIT
,ExpenseTypeEO.NAME
,TO_CHAR(ExpTypePreferMapEO.START_DATE,'DD-Mon-YYYY')