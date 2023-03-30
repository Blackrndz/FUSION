/* ****************************************************************************
 * $Revision: 48779 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2015-08-07 18:53:26 +0700 (Fri, 07 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 48779 2015-08-07 11:53:26Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=FND_KF_STR_INSTANCES_VL

SELECT distinct Head.KEY_FLEXFIELD_CODE RES_KEY_FLEXFIELD_CODE
,Head.NAME  RES_KEY_FLEXFIELD_NAME
,Detail.STRUCTURE_INSTANCE_CODE RES_STRUCTURE_INSTANCE_CODE
,Detail.STRUCTURE_INSTANCE_IDENTIFIER RES_API_NAME
,Detail.NAME RES_NAME
,Detail.DESCRIPTION RES_DESCRIPTION
,decode(Detail.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,decode(Detail.DYNAMIC_COMBO_CREATION_FLAG,'Y','Yes','No') RES_DYNAMIC_COMBINATION_CREATI
,decode(Detail.SHA_ENABLED_FLAG,'Y','Yes','No') RES_SHORTHAND_ALIAS_ENABLED
,Detail.STRUCTURE_NAME RES_STRUCTURE_NAME
,Detail.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,Detail.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,Detail.CREATED_BY RSC_CREATED_BY
,Detail.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,Detail.STRUCTURE_INSTANCE_NUMBER RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
(SELECT KeyFlexfieldEO.APPLICATION_ID
	,KeyFlexfieldEO.KEY_FLEXFIELD_CODE
	,KeyFlexfieldEO.MODULE_ID
	,KeyFlexfieldEO.NAME
	,KeyFlexfieldEO.BI_ENABLED_FLAG
	,KeyFlexfieldEO.DEPLOYMENT_STATUS
	,KeyFlexfieldEO.DEPLOYMENT_ERROR_MESSAGE
	,KeyFlexfieldEO.DEPLOYMENT_DATE
	,ApplTaxonomyPEO.MODULE_ID AS MODULE_ID1
	,ApplTaxonomyPEO.MODULE_TYPE
	,ApplTaxonomyPEO.MODULE_KEY
	,ApplTaxonomyPEO.USER_MODULE_NAME  
	,ApplicationPEO.APPLICATION_ID AS APPLICATION_ID1
	,ApplicationPEO.APPLICATION_NAME 
	FROM fusion.FND_KF_FLEXFIELDS_VL KeyFlexfieldEO
	, fusion.FND_APPL_TAXONOMY_VL ApplTaxonomyPEO
	, fusion.FND_APPLICATION_VL ApplicationPEO 
	WHERE KeyFlexfieldEO.MODULE_ID = ApplTaxonomyPEO.MODULE_ID 
	AND KeyFlexfieldEO.APPLICATION_ID = ApplicationPEO.APPLICATION_ID 
	AND (KeyFlexfieldEO.module_id in (select rf.child_module_id
									from fusion.fnd_appl_taxonomy_rf rf
									inner join fusion.fnd_appl_taxonomy t
									on rf.ancestor_module_id = t.module_id
									where t.module_type = 'APPLICATION' 
									and t.module_key = 'GL'
									)) 
	) Head
,(SELECT StructureInstance.STRUCTURE_INSTANCE_ID
	,StructureInstance.APPLICATION_ID
	,StructureInstance.KEY_FLEXFIELD_CODE
	,StructureInstance.STRUCTURE_INSTANCE_CODE
	,StructureInstance.NAME
	,StructureInstance.ENABLED_FLAG
	,StructureInstance.STRUCTURE_ID
	,StructureInstance.SHA_ENABLED_FLAG
	,KeyFlexfieldStructureEO.STRUCTURE_ID AS STRUCTURE_ID1
	,KeyFlexfieldStructureEO.NAME AS STRUCTURE_NAME  
	,StructureInstance.DESCRIPTION
	,StructureInstance.STRUCTURE_INSTANCE_IDENTIFIER
	,StructureInstance.DYNAMIC_COMBO_CREATION_FLAG
	,StructureInstance.LAST_UPDATED_BY
	,StructureInstance.LAST_UPDATE_DATE 
	,StructureInstance.CREATED_BY
	,StructureInstance.CREATION_DATE 
	,StructureInstance.STRUCTURE_INSTANCE_NUMBER
	FROM fusion.FND_KF_STR_INSTANCES_VL StructureInstance
	, fusion.FND_KF_STRUCTURES_VL KeyFlexfieldStructureEO
	WHERE StructureInstance.STRUCTURE_ID = KeyFlexfieldStructureEO.STRUCTURE_ID 
	AND ( ( ( (StructureInstance.APPLICATION_ID = 101 )
	AND (StructureInstance.KEY_FLEXFIELD_CODE = 'GL#' ) ) ) ) 
	) Detail
,fusion.FND_KF_SEGMENT_INSTANCES KeyFlexfieldSegmentInstanceE1 

WHERE Head.APPLICATION_ID = Detail.APPLICATION_ID(+)
and  Detail.STRUCTURE_INSTANCE_ID = KeyFlexfieldSegmentInstanceE1.STRUCTURE_INSTANCE_ID(+)
ORDER BY Detail.NAME