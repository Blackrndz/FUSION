/* ****************************************************************************
* $Revision: 78693 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-07 17:22:14 +0700 (Tue, 07 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Templates%20-%20Asset%20Assignments.sql $:
* $Id: Manage Project Templates - Asset Assignments.sql 78693 2022-06-07 10:22:14Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT projTemplatesE0.NAME RES_TEMPLATE_NAME
,projTemplatesE0.SEGMENT1 RES_TEMPLATE_NUMBER
,(CASE
	WHEN projAssetAssignE0.PROJECT_ASSET_ID IS NULL AND projAssetAssignE1.PROJECT_ASSET_ID IS NULL THEN
		'None'
	WHEN projAssetAssignE1.PROJECT_ASSET_ID = 0 THEN
		'Common costs'
	WHEN projAssetAssignE0.PROJECT_ASSET_ID IS NOT NULL THEN
		'Specific assets'
	END) RES_GROUPING_LEVEL_TYPE
,projAssetAssignE0.ASSET_NAME RES_ASSET_NAME
,projAssetAssignE0.ASSET_DESCRIPTION RES_DESCRIPTION 
,NVL(projAssetAssignE0.LAST_UPDATED_BY,projTemplatesE0.LAST_UPDATED_BY) RSC_LAST_UPDATED_BY
,NVL(projAssetAssignE0.LAST_UPDATE_DATE,projTemplatesE0.LAST_UPDATE_DATE) RSC_LAST_UPDATE_DATE
,NVL(projAssetAssignE0.CREATED_BY,projTemplatesE0.CREATED_BY) RSC_CREATED_BY
,NVL(projAssetAssignE0.CREATION_DATE,projTemplatesE0.CREATION_DATE) RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,projTemplatesE0.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_PROJECTS_ALL_VL projTemplatesE0
,FUN_ALL_BUSINESS_UNITS_V buE0
,(SELECT projAssetAssignE2.PROJECT_ID
	,projAssetAssignE2.PROJECT_ASSET_ID
	,projAssetAssignE2.LAST_UPDATED_BY 
	,projAssetAssignE2.LAST_UPDATE_DATE 
	,projAssetAssignE2.CREATED_BY 
	,projAssetAssignE2.CREATION_DATE 
	,projAssetsE0.ASSET_NAME
	,projAssetsE0.ASSET_DESCRIPTION
	FROM PJC_PRJ_ASSET_ASGS projAssetAssignE2
	,PJC_PRJ_ASSETS_ALL projAssetsE0
	WHERE projAssetAssignE2.TASK_ID = 0
	AND projAssetsE0.PROJECT_ID = projAssetAssignE2.PROJECT_ID
	AND projAssetsE0.PROJECT_ASSET_ID = projAssetAssignE2.PROJECT_ASSET_ID
	) projAssetAssignE0
,(SELECT PROJECT_ID
	,PROJECT_ASSET_ID
	,LAST_UPDATED_BY 
	,LAST_UPDATE_DATE 
	,CREATED_BY 
	,CREATION_DATE 
	FROM PJC_PRJ_ASSET_ASGS
	WHERE TASK_ID = 0
	AND PROJECT_ASSET_ID = 0
	) projAssetAssignE1
WHERE projTemplatesE0.TEMPLATE_FLAG = 'Y'
AND projTemplatesE0.ORG_ID = buE0.BU_ID
AND projTemplatesE0.PROJECT_ID = projAssetAssignE0.PROJECT_ID(+)
AND projTemplatesE0.PROJECT_ID = projAssetAssignE1.PROJECT_ID(+)
AND EXISTS (SELECT 1
	FROM PJF_PROJECT_OPTIONS
	WHERE OPTION_CODE = 'ASSET_ASSIGNMENTS'
	AND ENABLED = 'Y'
	AND PROJECT_ID = projTemplatesE0.PROJECT_ID)
ORDER BY projTemplatesE0.NAME
,projAssetAssignE0.ASSET_NAME