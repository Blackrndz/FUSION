/* ****************************************************************************
 * $Revision: 53782 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-03-31 18:00:16 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: $:
 * $Id: Manage Enterprise HCM Information - Attachments.sql 53782 2016-03-22 11:00:16Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT ExpenseTemplateEO.NAME RES_NAME
,ExpenseTemplateEO.DESCRIPTION RES_DESCRIPTION
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = ExpenseTemplateEO.ORG_ID
	) RES_BUSINESS_UNIT
,TO_CHAR(ExpenseTemplateEO.START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(ExpenseTemplateEO.INACTIVE_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,NVL2(
	(SELECT SETTING_VALUE
	FROM exm_org_settings
	WHERE SETTING_CODE                        = 'DFLT_CC_EXP_TEMPLATE_ID'
	AND ExpenseTemplateEO.ORG_ID              = ORG_ID(+)
	AND ExpenseTemplateEO.EXPENSE_TEMPLATE_ID = SETTING_VALUE(+)
	),'Yes','No') RES_SET_AS_DEFAULT
,ExpenseTemplateEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExpenseTemplateEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExpenseTemplateEO.CREATED_BY RSC_CREATED_BY
,ExpenseTemplateEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,ExpenseTemplateEO.ORG_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_EXPENSE_TEMPLATES ExpenseTemplateEO
ORDER BY ExpenseTemplateEO.NAME
,RES_BUSINESS_UNIT