/* ****************************************************************************
 * $Revision$:
 * $Author$:
 * $Date$:
 * $HeadURL$:
 * $Id$:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=XCC_CONTROL_BUDGETS

SELECT xccCONTROLBUDE0.NAME  RES_NAME
,xccRULE0.RULE_NAME RES_SUPPLEMENTAL_RULES_NAME
,DECODE(xccRULE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,xccRULE0.DESCRIPTION RES_DESCRIPTION
,(SELECT BU_NAME 
	FROM FUN_FIN_BUSINESS_UNITS_V
	WHERE BU_ID = xccRULE0.BUSINESS_UNIT_ID 
	AND SYSDATE BETWEEN DATE_FROM AND DATE_TO
	) RES_BUSINESS_UNIT
,(SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LOOKUP_CODE = xccRULE0.CONTROL_LEVEL_CODE
	AND LOOKUP_TYPE = 'XCC_CB_CONTR_LVL' 
	AND LANGUAGE = USERENV('LANG')
	) RES_CONTROL_LEVEL
,xccRULE0.TOLERANCE_PERCENT RES_TOLERANCE_PERCENTAGE
,xccRULE0.TOLERANCE_AMOUNT RES_TOLERANCE_AMOUNT

,xccRULE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,xccRULE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,xccRULE0.CREATED_BY RSC_CREATED_BY
,xccRULE0.CREATION_DATE RSC_CREATION_DATE
,xccCONTROLBUDE0.LEDGER_ID RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM XCC_CONTROL_BUDGETS xccCONTROLBUDE0
,XCC_CB_RULES xccRULE0
WHERE xccCONTROLBUDE0.CONTROL_BUDGET_ID  = xccRULE0.CONTROL_BUDGET_ID 
ORDER BY xccCONTROLBUDE0.NAME,xccRULE0.RULE_NAME