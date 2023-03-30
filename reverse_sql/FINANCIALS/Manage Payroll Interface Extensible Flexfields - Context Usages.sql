/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payroll%20Interface%20Extensible%20Flexfields%20-%20Context%20Usages.sql $:
 * $Id: Manage Payroll Interface Extensible Flexfields - Context Usages.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT flexfieldsE0.NAME RES_FLEXFIELD_NAME
,flexfieldsE0.DESCRIPTIVE_FLEXFIELD_CODE RES_FLEXFIELD_CODE
,contextsE0.NAME RES_DISPLAY_NAME
,contextsE0.CONTEXT_CODE RES_CONTEXT_CODE
,(SELECT NAME
	FROM FND_DF_FLEX_USAGES_VL 
	WHERE FLEXFIELD_USAGE_CODE   = contextUsagesE0.FLEXFIELD_USAGE_CODE
	) RES_NAME
,(CASE
	WHEN flexfieldsE0.DESCRIPTIVE_FLEXFIELD_CODE = 'EGO_ITEM_EFF' THEN
		NVL((SELECT MEANING
			FROM FND_LOOKUPS
			WHERE LOOKUP_TYPE = 'FND_EF_PIM_INHERIT_DEFAULT'
			AND LOOKUP_CODE = contextUsagesE0.C_EXT_ATTRIBUTE1),'None')
	END) RES_STYLE_TO_SKU
,(CASE
	WHEN flexfieldsE0.DESCRIPTIVE_FLEXFIELD_CODE = 'EGO_ITEM_EFF' THEN
		NVL((SELECT MEANING
		FROM FND_LOOKUPS
		WHERE LOOKUP_TYPE = 'FND_EF_PIM_INHERIT_DEFAULT'
		AND LOOKUP_CODE = contextUsagesE0.C_EXT_ATTRIBUTE2 ),'None')
	END) RES_MASTER_TO_CHILD_ORGANIZATI
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

FROM FND_DF_FLEXFIELDS_VL flexfieldsE0
,FND_DF_CONTEXTS_VL contextsE0
,FND_EF_CONTEXT_USAGES contextUsagesE0
WHERE flexfieldsE0.FLEXFIELD_TYPE = 'EFF'
AND flexfieldsE0.APPLICATION_ID = 10511
AND flexfieldsE0.DESCRIPTIVE_FLEXFIELD_CODE = contextsE0.DESCRIPTIVE_FLEXFIELD_CODE
AND flexfieldsE0.APPLICATION_ID = contextsE0.APPLICATION_ID
AND contextsE0.DESCRIPTIVE_FLEXFIELD_CODE = contextUsagesE0.DESCRIPTIVE_FLEXFIELD_CODE
AND contextsE0.APPLICATION_ID = contextUsagesE0.APPLICATION_ID
AND contextsE0.CONTEXT_CODE = contextUsagesE0.CONTEXT_CODE
ORDER BY flexfieldsE0.NAME
,contextsE0.NAME
,3