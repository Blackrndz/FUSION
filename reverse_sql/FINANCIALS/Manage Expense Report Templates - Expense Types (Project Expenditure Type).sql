/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Expense%20Report%20Templates%20-%20Expense%20Types%20(Project%20Expenditure%20Type).sql $:
 * $Id: Manage Expense Report Templates - Expense Types (Project Expenditure Type).sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT ExpenseTemplateEO.NAME RES_EXPENSE_REPORT_TEMPLATES_N
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = ExpenseTemplateEO.ORG_ID
	) RES_BUSINESS_UNIT
,ExpenseTypeEO.NAME RES_EXPENSE_TYPE_NAME
,(SELECT NAME FROM HR_ALL_ORGANIZATION_UNITS
		WHERE ORGANIZATION_ID =ExpenseProjectTypeMapEO.PROJECT_UNIT_ID) RES_PROJECT_UNIT
,pjfEXPTypeEO.EXPENDITURE_TYPE_NAME RES_PROJECT_EXPENDITURE_TYPE
,pjfEXPTypeEO.DESCRIPTION RES_DESCRIPTION

,ExpenseProjectTypeMapEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExpenseProjectTypeMapEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExpenseProjectTypeMapEO.CREATED_BY RSC_CREATED_BY
,ExpenseProjectTypeMapEO.CREATION_DATE RSC_CREATION_DATE
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
,EXM_PROJECT_EXP_TYPE_MAPS ExpenseProjectTypeMapEO
,PJF_EXP_TYPES_VL pjfEXPTypeEO

WHERE ExpenseTemplateEO.EXPENSE_TEMPLATE_ID = ExpenseTypeEO.EXPENSE_TEMPLATE_ID
AND ExpenseTypeEO.EXPENSE_TYPE_ID = ExpenseProjectTypeMapEO.EXPENSE_TYPE_ID
AND ExpenseProjectTypeMapEO.EXPENDITURE_TYPE_ID = pjfEXPTypeEO.EXPENDITURE_TYPE_ID
ORDER BY ExpenseTemplateEO.NAME
,RES_BUSINESS_UNIT
,ExpenseTypeEO.NAME
,RES_PROJECT_UNIT