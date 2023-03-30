/* ****************************************************************************
 * $Revision: 48779 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2015-08-07 18:53:26 +0700 (Fri, 07 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 48779 2015-08-07 11:53:26Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT Head.RES_KEY_FLEXFIELD_CODE RES_KEY_FLEXFIELD_CODE
,Head.RES_KEY_FLEXFIELD_NAME RES_KEY_FLEXFIELD_NAME
,Head.STRUCTURE_INSTANCE_CODE RES_STRUCTURE_INSTANCE_CODE
,Head.NAME RES_NAME
,Detail.SEGMENT_CODE RES_SEGMENT_CODE
,(SELECT VALUE_SET_CODE
	FROM fusion.FND_VS_VALUE_SETS
	WHERE VALUE_SET_ID = Detail.VALUE_SET_ID
	) RES_VALUE_SET_CODE
,DECODE(Detail.REQUIRED_FLAG,'Y','Yes','No') RES_REQUIRED
,DECODE(Detail.DISPLAY_FLAG,'Y','Yes','No') RES_DISPLAYED
,DECODE(Detail.BI_ENABLED_FLAG,'Y','Yes','No') RES_BI_ENABLED
,DECODE(Detail.DEFAULT_TYPE,'CONSTANT','Constant',Detail.DEFAULT_TYPE) RES_DEFAULT_TYPE
,Detail.DEFAULT_VALUE RES_DEFAULT_VALUE
,DECODE(Detail.QUERY_REQUIRED_TYPE,'OPTIONAL','Optional','SELECTIVELY_REQUIRED','Selectively required',Detail.QUERY_REQUIRED_TYPE) RES_QUERY_REQUIRED
,Detail.TREE_NAME RES_TREE_NAME
,Detail.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,Detail.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,Detail.CREATED_BY  RSC_CREATED_BY
,Detail.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,HEAD.STRUCTURE_INSTANCE_NUMBER RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
(SELECT Head_menu.KEY_FLEXFIELD_CODE RES_KEY_FLEXFIELD_CODE
	,Head_menu.NAME RES_KEY_FLEXFIELD_NAME
	,Head_menu.USER_MODULE_NAME RES_MODULE
	,Detail_menu.STRUCTURE_INSTANCE_CODE
	,Detail_menu.NAME
	,Detail_menu.STRUCTURE_NAME
	,Detail_menu.STRUCTURE_INSTANCE_ID
	,Head_menu.LAST_UPDATED_BY
	,Head_menu.LAST_UPDATE_DATE
	,Detail_menu.STRUCTURE_ID 
	,Detail_menu.STRUCTURE_INSTANCE_NUMBER
	FROM
		(SELECT KeyFlexfieldEO.KEY_FLEXFIELD_CODE
		,KeyFlexfieldEO.NAME
		,ApplTaxonomyPEO.USER_MODULE_NAME
		,KeyFlexfieldEO.APPLICATION_ID
		,KeyFlexfieldEO.LAST_UPDATED_BY
		,KeyFlexfieldEO.LAST_UPDATE_DATE
		FROM fusion.FND_KF_FLEXFIELDS_VL KeyFlexfieldEO
		,fusion.FND_APPL_TAXONOMY_VL ApplTaxonomyPEO
		,fusion.FND_APPLICATION_VL ApplicationPEO
		WHERE KeyFlexfieldEO.MODULE_ID    = ApplTaxonomyPEO.MODULE_ID
		AND KeyFlexfieldEO.APPLICATION_ID = ApplicationPEO.APPLICATION_ID
		AND(KeyFlexfieldEO.module_id     IN
			(SELECT rf.child_module_id
			FROM fusion.fnd_appl_taxonomy_rf rf
			INNER JOIN fusion.fnd_appl_taxonomy t
			ON rf.ancestor_module_id = t.module_id
			WHERE t.module_type      = 'APPLICATION'
			AND t.module_key         = 'GL'
			))
		) Head_menu
	,(SELECT StructureInstance.STRUCTURE_INSTANCE_ID
		,StructureInstance.APPLICATION_ID
		,StructureInstance.KEY_FLEXFIELD_CODE
		,StructureInstance.STRUCTURE_INSTANCE_CODE
		,StructureInstance.NAME
		,StructureInstance.ENABLED_FLAG
		,StructureInstance.STRUCTURE_ID
		,KeyFlexfieldStructureEO.STRUCTURE_ID AS STRUCTURE_ID1
		,KeyFlexfieldStructureEO.NAME        AS STRUCTURE_NAME
		,StructureInstance.DESCRIPTION
		,StructureInstance.STRUCTURE_INSTANCE_IDENTIFIER
		,StructureInstance.DYNAMIC_COMBO_CREATION_FLAG
		,StructureInstance.STRUCTURE_INSTANCE_NUMBER
		FROM fusion.FND_KF_STR_INSTANCES_VL StructureInstance
		,fusion.FND_KF_STRUCTURES_VL KeyFlexfieldStructureEO
		WHERE StructureInstance.STRUCTURE_ID     = KeyFlexfieldStructureEO.STRUCTURE_ID
		AND((((StructureInstance.APPLICATION_ID  = 101)
		AND(StructureInstance.KEY_FLEXFIELD_CODE = 'GL#'))))
		) Detail_menu
	WHERE Head_menu.APPLICATION_ID = Detail_menu.APPLICATION_ID(+)
	) Head
,(SELECT STRUCTURE_INSTANCE_ID
	,ENTERPRISE_ID
	,SEGMENT_CODE
	,VALUE_SET_ID
	,TREE_STRUCTURE_CODE
	,TREE_CODE
	,REQUIRED_FLAG
	,DISPLAY_FLAG
	,DEFAULT_TYPE
	,DEFAULT_VALUE
	,BI_ENABLED_FLAG
	,QUERY_REQUIRED_TYPE	
	,LAST_UPDATE_DATE
	,LAST_UPDATED_BY
	,LAST_UPDATE_LOGIN	
	,CREATION_DATE
	,CREATED_BY
	,(SELECT tree.tree_name
		FROM fusion.fnd_tree_vl tree
		WHERE KeyFlexfieldSegmentInstanceE1.tree_code IS NOT NULL
		AND tree.tree_code                             = KeyFlexfieldSegmentInstanceE1.tree_code
		AND tree.tree_structure_code                   = NVL(KeyFlexfieldSegmentInstanceE1.tree_structure_code,(SELECT
				kff.tree_structure_code
			FROM fusion.fnd_kf_flexfields_b kff
			JOIN fusion.fnd_kf_str_instances_b stri
			ON kff.application_id            = stri.application_id
			AND kff.key_flexfield_code       = stri.key_flexfield_code
			WHERE stri.structure_instance_id = KeyFlexfieldSegmentInstanceE1.structure_instance_id
			))
		) AS TREE_NAME
	,(SELECT s.sequence_number
		FROM fusion.fnd_kf_str_instances_b st
		,fusion.fnd_kf_segments_b s
		WHERE KeyFlexfieldSegmentInstanceE1.structure_instance_id = st.structure_instance_id
		AND st.structure_id                                       = s.structure_id
		AND KeyFlexfieldSegmentInstanceE1.segment_code            = s.segment_code
		) AS SEQUENCE_NUMBER
	FROM fusion.FND_KF_SEGMENT_INSTANCES KeyFlexfieldSegmentInstanceE1
	ORDER BY KeyFlexfieldSegmentInstanceE1.STRUCTURE_INSTANCE_ID
	,SEQUENCE_NUMBER
	) Detail
WHERE Head.STRUCTURE_INSTANCE_ID = Detail.STRUCTURE_INSTANCE_ID
ORDER BY Detail.STRUCTURE_INSTANCE_ID
,SEQUENCE_NUMBER