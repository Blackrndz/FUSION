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
,flexfieldsE0.DESCRIPTION RES_DESCRIPTION
,(SELECT APPLICATION_NAME
	FROM FND_APPLICATION_VL
	WHERE APPLICATION_ID = flexfieldsE0.APPLICATION_ID
	) RES_APPLICATION
,(SELECT USER_MODULE_NAME
	FROM FND_APPL_TAXONOMY_VL
	WHERE MODULE_ID = flexfieldsE0.MODULE_ID
	) RES_MODULE
,flexfieldsE0.CATEGORY_HIERARCHY_LABEL RES_CATEGORY_HIERARCHY
,flexfieldsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,flexfieldsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,flexfieldsE0.CREATED_BY RSC_CREATED_BY
,flexfieldsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DF_FLEXFIELDS_VL flexfieldsE0
WHERE flexfieldsE0.FLEXFIELD_TYPE = 'EFF'
ORDER BY flexfieldsE0.NAME