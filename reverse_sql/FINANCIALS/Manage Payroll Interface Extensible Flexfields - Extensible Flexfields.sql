/* ****************************************************************************
 * $Revision: 73226 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2020-01-16 17:22:17 +0700 (Thu, 16 Jan 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Payroll%20Interface%20Extensible%20Flexfields%20-%20Extensible%20FlexFields.sql $:
 * $Id: Manage Payroll Interface Extensible Flexfields - Extensible FlexFields.sql 73226 2020-01-16 10:22:17Z tanawat.wongjan $:
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
AND flexfieldsE0.APPLICATION_ID = 10511
ORDER BY flexfieldsE0.NAME