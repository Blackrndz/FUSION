/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-04-21 $:
 * $HeadURL: $:
 * $Id: Manage Expense Report Audit Rules by Expense Templates and Types - Business Unit Assignment.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT ExpTypeRuleSetEO.NAME RES_NAME
,(select ExpenseTemplateEO.NAME
	FROM EXM_EXPENSE_TEMPLATES ExpenseTemplateEO
	WHERE TRUNC(sysdate) BETWEEN TRUNC(NVL(ExpenseTemplateEO.START_DATE, sysdate)) 
	AND TRUNC(NVL(ExpenseTemplateEO.INACTIVE_DATE, sysdate))
	AND ExpenseTemplateEO.EXPENSE_TEMPLATE_ID   =   ExpTypeRuleEO.EXPENSE_TEMPLATE_ID
	AND ExpenseTemplateEO.ORG_ID = ExpTypeRuleSetEO.ORG_ID 
	) RES_EXPENSE_TEMPLATE
,(select distinct ExpenseTypeEO.NAME
	FROM EXM_EXPENSE_TYPES ExpenseTypeEO 
	where ExpenseTypeEO.EXPENSE_TEMPLATE_ID =  ExpTypeRuleEO.EXPENSE_TEMPLATE_ID
	and ExpenseTypeEO.EXPENSE_TYPE_ID =  ExpTypeRuleEO.EXPENSE_TYPE_ID
	) RES_EXPENSE_TYPE_TYPE
,(select CurrencyPEO.CURRENCY_CODE || ' - ' || CurrencyPEO.NAME  
	FROM fnd_currencies_vl CurrencyPEO 
	where CurrencyPEO.currency_code = ExpTypeRuleEO.CURRENCY_CODE       
	) RES_EXPENSE_TYPE_CURRENCY
,ExpTypeRuleEO.AMOUNT RES_EXPENSE_TYPE_AMOUNT
,ExpTypeRuleEO.CUMULATIVE_AMOUNT RES_EXPENSE_TYPE_CUMULATIVE_AM
,(select ExmLookupPEO.DISPLAYED_FIELD
	FROM EXM_LOOKUP_VALUES ExmLookupPEO
	WHERE ExmLookupPEO.LOOKUP_TYPE = 'EXM_AUD_EXP_TYPE_PERIOD' 
	and ExmLookupPEO.LOOKUP_CODE = ExpTypeRuleEO.PERIOD          
	) RES_EXPENSE_TYPE_PERIOD
,ExpTypeRuleEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExpTypeRuleEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExpTypeRuleEO.CREATED_BY RSC_CREATED_BY
,ExpTypeRuleEO.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,ExpTypeRuleSetEO.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_EXP_TYPE_RULES ExpTypeRuleEO
,EXM_EXP_TYPE_RULE_SETS ExpTypeRuleSetEO
WHERE ExpTypeRuleSetEO.EXP_TYPE_RULE_SET_ID = ExpTypeRuleEO.EXP_TYPE_RULE_SET_ID
ORDER BY EXP_TYPE_RULE_ID 