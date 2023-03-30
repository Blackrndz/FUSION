/* ****************************************************************************
* $Revision: 59053 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-20 13:59:22 +0700 (Wed, 19 Oct 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Time%20Shift.sql $:
* $Id: Manage Buyer Assignment Rule Sets Lookup - Lookup Codes.sql 59053 2016-10-19 06:59:22Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT contextFlexfeildsE0.NAME RES_DISPLAY_NAME
,DECODE(contextUsagesE0.FLEXFIELD_USAGE_CODE,'EGO_ITEM_DL','Item'
	,'EGO_ITEM_REVISION_DL','Item Revision'
	,'EGO_ITEM_SUPPLIER_DL','Item Supplier'
	) RES_NAME
,NVL((SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'FND_EF_PIM_INHERIT_DEFAULT'
	AND LOOKUP_CODE = contextUsagesE0.C_EXT_ATTRIBUTE1
	),'None') RES_STYLE_TO_SKU
,NVL((SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'FND_EF_PIM_INHERIT_DEFAULT'
	AND LOOKUP_CODE = contextUsagesE0.C_EXT_ATTRIBUTE2
	),'None') RES_MASTER_TO_CHILD_ORGANIZATI
,NVL(contextUsagesE0.VIEW_PRIVILEGE_NAME,'None') RES_VIEW_PRIVILEGES
,NVL(contextUsagesE0.EDIT_PRIVILEGE_NAME,'None') RES_EDIT_PRIVILEGES
,contextUsagesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,contextUsagesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,contextUsagesE0.CREATED_BY RSC_CREATED_BY
,contextUsagesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DF_FLEXFIELDS_VL flexfiieldsE0
,FND_DF_CONTEXTS_VL contextFlexfeildsE0
,FND_EF_CONTEXT_USAGES contextUsagesE0
WHERE flexfiieldsE0.DESCRIPTIVE_FLEXFIELD_CODE = contextFlexfeildsE0.DESCRIPTIVE_FLEXFIELD_CODE
AND flexfiieldsE0.DESCRIPTIVE_FLEXFIELD_CODE = 'EGO_ITEM_EFF'
AND contextFlexfeildsE0.DESCRIPTIVE_FLEXFIELD_CODE = contextUsagesE0.DESCRIPTIVE_FLEXFIELD_CODE
AND contextFlexfeildsE0.APPLICATION_ID = contextUsagesE0.APPLICATION_ID
AND contextFlexfeildsE0.CONTEXT_CODE = contextUsagesE0.CONTEXT_CODE
ORDER BY contextFlexfeildsE0.NAME
,2