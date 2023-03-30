/* ****************************************************************************
 * $Revision: 54841 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-04-29 15:18:22 +0700 (Fri, 29 Apr 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Locations%20-%20Asset%20Locations.sql $:
 * $Id: Manage Asset Locations - Asset Locations.sql 54841 2016-04-29 08:18:22Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT flexfieldsE0.NAME RES_FLEXFIELD_NAME
,flexfieldsE0.DESCRIPTIVE_FLEXFIELD_CODE RES_FLEXFIELD_CODE
,contextsE0.NAME RES_DISPLAY_NAME
,contextsE0.CONTEXT_CODE RES_CONTEXT_CODE
,contextsE0.CONTEXT_IDENTIFIER RES_API_NAME
,contextsE0.DESCRIPTION RES_DESCRIPTION
,DECODE(contextsE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,DECODE(contextsE0.TRANSLATABLE_FLAG,'Y','Yes','No') RES_TRANSLATABLE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'FND_EF_CONTEXT_MULTIROW_TYPES'
	AND LOOKUP_CODE = contextsE0.MULTIROW_FLAG
	) RES_BEHAVIOR
,contextsE0.INSTRUCTION_HELP_TEXT RES_INSTRUCTION_HELP_TEXT
,contextsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,contextsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,contextsE0.CREATED_BY RSC_CREATED_BY
,contextsE0.CREATION_DATE RSC_CREATION_DATE
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
WHERE flexfieldsE0.FLEXFIELD_TYPE = 'EFF'
AND flexfieldsE0.APPLICATION_ID = 10008
AND flexfieldsE0.DESCRIPTIVE_FLEXFIELD_CODE = contextsE0.DESCRIPTIVE_FLEXFIELD_CODE
AND flexfieldsE0.APPLICATION_ID = contextsE0.APPLICATION_ID
ORDER BY flexfieldsE0.NAME
,contextsE0.NAME