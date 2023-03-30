/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=WIS_RESOURCES_VL
 
SELECT (SELECT SCENARIO_NUMBER
	FROM CST_SCENARIOS
	WHERE SCENARIO_ID = CostResourceRatesE0.SCENARIO_ID
	) RES_SCENARIO
,(SELECT ORGANIZATION_NAME
	FROM INV_ORGANIZATION_DEFINITIONS_V
	WHERE ORGANIZATION_ID = CostResourceRatesE0.INV_ORG_ID
	) RES_PLANT
,ResourcesE0.RESOURCE_NAME RES_RESOURCE
,CostElementsE0.COST_ELEMENT_DESC RES_COST_ELEMENT
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'CST_COST_ELEMENT_TYPES'
	ANd LOOKUP_CODE = CostElementsE0.COST_ELEMENT_TYPE
	) RES_COST_ELEMENT_TYPE
,(SELECT EXPENSE_POOL_CODE
	FROM CST_EXPENSE_POOLS_VL
	WHERE EXPENSE_POOL_ID = CostResourceRateDetailsE0.EXPENSE_POOL_ID
	) RES_EXPENSE_POOL
,CostResourceRateDetailsE0.UNIT_RATE RES_RATE_USD
,CostResourceRateDetailsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CostResourceRateDetailsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CostResourceRateDetailsE0.CREATED_BY RSC_CREATED_BY
,CostResourceRateDetailsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,CostResourceRatesE0.COST_ORG_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_STD_RESOURCE_RATES CostResourceRatesE0
,WIS_RESOURCES_VL ResourcesE0
,CST_STD_RESOURCE_RATE_DETAILS CostResourceRateDetailsE0
,CST_COST_ELEMENTS_VL CostElementsE0
WHERE CostResourceRatesE0.RESOURCE_ID = ResourcesE0.RESOURCE_ID
AND CostResourceRatesE0.INV_ORG_ID = ResourcesE0.ORGANIZATION_ID
AND CostResourceRatesE0.STD_RESOURCE_RATE_ID = CostResourceRateDetailsE0.STD_RESOURCE_RATE_ID
AND CostResourceRateDetailsE0.COST_ELEMENT_ID = CostElementsE0.COST_ELEMENT_ID
ORDER BY 1,2,3