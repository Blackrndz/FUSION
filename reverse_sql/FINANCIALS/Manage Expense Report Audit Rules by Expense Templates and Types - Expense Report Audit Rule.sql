/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-04-21 $:
 * $HeadURL:  $:
 * $Id: Manage Expense Report Audit Rules by Expense Templates and Types - Expense Report Audit Rule by Expense Templates and Types.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT ExpTypeRuleSetEO.NAME RES_NAME
,ExpTypeRuleSetEO.DESCRIPTION RES_DESCRIPTION
,(select BU_NAME 
	FROM FUN_ALL_BUSINESS_UNITS_V 
	WHERE BU_ID = ExpTypeRuleSetEO.ORG_ID  
	) RES_BUSINESS_UNIT
,ExpTypeRuleSetEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExpTypeRuleSetEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExpTypeRuleSetEO.CREATED_BY RSC_CREATED_BY
,ExpTypeRuleSetEO.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,ExpTypeRuleSetEO.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_EXP_TYPE_RULE_SETS ExpTypeRuleSetEO
ORDER BY ExpTypeRuleSetEO.NAME