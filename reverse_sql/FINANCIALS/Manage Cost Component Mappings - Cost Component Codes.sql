/* ****************************************************************************
 * $Revision: 54470 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-04-19 10:52:05 +0700 (Tue, 19 Apr 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Contact%20Point%20Lookups%20-%20Lookup%20Codes.sql $:
 * $Id: Manage Contact Point Lookups - Lookup Codes.sql 54470 2016-04-19 03:52:05Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT ComponentGroupEO.COMPONENT_GROUP_CODE RES_CODE
,SetIdSetPEO.SET_NAME RES_SET_NAME
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'CST_COMPONENT_SOURCES'
	ANd LOOKUP_CODE = CostComponentPEO.SOURCE_CODE
	) RES_COST_COMPONENT_SOURCE
,(SELECT SET_NAME
	FROM FND_SETID_SETS_VL
	WHERE SET_ID = CostComponentPEO.SET_ID
	) RES_COST_COMPONENTS_SET_NAME
,CostComponentPEO.COST_COMPONENT_CODE RES_COST_COMPONENT_CODE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'CST_COST_ELEMENT_TYPES'
	ANd LOOKUP_CODE = CostComponentPEO.COST_COMPONENT_TYPE
	) RES_COST_COMPONENT_TYPE
,(SELECT SET_NAME
	FROM FND_SETID_SETS_VL
	WHERE SET_ID = CostElementPEO.SET_ID
	) RES_COST_ELEMENT_SET
,CostElementPEO.COST_ELEMENT_CODE RES_COST_ELEMENT
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'CST_COST_ELEMENT_TYPES'
	ANd LOOKUP_CODE = CostElementPEO.COST_ELEMENT_TYPE
	) RES_COST_ELEMENT_TYPE
,DECODE(ComponentGroupDetailEO.CAPITALIZATION_FLAG,'Y','Yes','No') RES_INCLUDE_IN_INVENTORY
,ComponentGroupDetailEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ComponentGroupDetailEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ComponentGroupDetailEO.CREATED_BY RSC_CREATED_BY
,ComponentGroupDetailEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_COMPONENT_GROUPS_VL ComponentGroupEO
,FND_SETID_SETS_VL SetIdSetPEO
,CST_COMPONENT_GROUP_DETAILS ComponentGroupDetailEO
,CST_COST_COMPONENTS_VL CostComponentPEO
,CST_COST_ELEMENTS_VL CostElementPEO
WHERE ComponentGroupEO.SET_ID = SetIdSetPEO.SET_ID
AND ComponentGroupEO.COMPONENT_GROUP_ID = ComponentGroupDetailEO.COMPONENT_GROUP_ID
AND ComponentGroupDetailEO.COMPONENT_MAPPING_TYPE = 'COMPONENTS'
AND ComponentGroupDetailEO.SOURCE_COST_COMPONENT_ID = CostComponentPEO.COST_COMPONENT_ID
AND ComponentGroupDetailEO.COST_ELEMENT_ID = CostElementPEO.COST_ELEMENT_ID
ORDER BY SetIdSetPEO.SET_CODE
,ComponentGroupEO.COMPONENT_GROUP_CODE
,CostComponentPEO.COST_COMPONENT_CODE