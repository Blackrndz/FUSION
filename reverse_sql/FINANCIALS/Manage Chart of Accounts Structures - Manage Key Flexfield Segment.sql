/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Structures%20-%20Manage%20Key%20Flexfield%20Segment.sql $:
 * $Id: Manage Chart of Accounts Structures - Manage Key Flexfield Segment.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT HEAD.KEY_FLEXFIELD_CODE             RES_KEY_FLEXFIELD_CODE
,HEAD.NAME                           RES_KEY_FLEXFIELD_NAME
,HEAD.STRUCTURE_CODE                 RES_STRUCTURE_CODE
,Detail_Segment.SEGMENT_CODE         RES_SEGMENT_CODE
,Detail_Segment.SEGMENT_IDENTIFIER   RES_API_NAME
,Detail_Segment.NAME                 RES_NAME
,Detail_Segment.DESCRIPTION          RES_DESCRIPTION
,Detail_Segment.SEQUENCE_NUMBER      RES_SEQUENCE_NUMBER
,Detail_Segment.PROMPT               RES_PROMPT
,Detail_Segment.SHORT_PROMPT         RES_SHORT_PROMPT
,decode(Detail_Segment.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,Detail_Segment.DISPLAY_WIDTH        RES_DISPLAY_WIDTH
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LOOKUP_TYPE = 'FND_FF_SEGMENT_RANGE_TYPES'
	AND LOOKUP_CODE = Detail_Segment.RANGE_TYPE
	AND LANGUAGE = USERENV('LANG')
	) RES_RANGE_TYPE
,Detail_Segment.COLUMN_NAME          RES_COLUMN_NAME
,( select VALUE_SET_CODE 
	from Fusion.FND_VS_VALUE_SETS 
	where VALUE_SET_ID = Detail_Segment.DEFAULT_VALUE_SET_ID 
	)  RES_DEFAULT_VALUE_SET_CODE
,Detail_Segment.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,Detail_Segment.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,Detail_Segment.CREATED_BY  RSC_CREATED_BY
,Detail_Segment.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
(Select distinct HEAD_SUB.KEY_FLEXFIELD_CODE
    ,HEAD_SUB.NAME
    ,HEAD_SUB.USER_MODULE_NAME
    ,Detail_SUB.STRUCTURE_CODE
    ,Detail_SUB.NAME RES_NAME
    ,Detail_SUB.DESCRIPTION RES_DESCRIPTION
    ,Detail_SUB.DELIMITER RES_DELIMITER
    ,Detail_SUB.ENABLED_FLAG RES_ENABLED
    ,Detail_SUB.STRUCTURE_ID
	--,Detail_SUB.STRUCTURE_INSTANCE_NUMBER
	FROM 
    (SELECT KeyFlexfieldEO.APPLICATION_ID,
		KeyFlexfieldEO.KEY_FLEXFIELD_CODE,
		KeyFlexfieldEO.MODULE_ID,
		KeyFlexfieldEO.NAME,
		KeyFlexfieldEO.BI_ENABLED_FLAG,
		KeyFlexfieldEO.DEPLOYMENT_STATUS,
		KeyFlexfieldEO.DEPLOYMENT_ERROR_MESSAGE,
		KeyFlexfieldEO.DEPLOYMENT_DATE,
		ApplTaxonomyPEO.MODULE_ID AS MODULE_ID1,
		ApplTaxonomyPEO.MODULE_TYPE,
		ApplTaxonomyPEO.MODULE_KEY,
		ApplTaxonomyPEO.USER_MODULE_NAME,
		ApplicationPEO.APPLICATION_ID AS APPLICATION_ID1,
		ApplicationPEO.APPLICATION_NAME,
		KeyFlexfieldEO.LAST_UPDATED_BY,
		KeyFlexfieldEO.LAST_UPDATE_DATE 
		FROM Fusion.FND_KF_FLEXFIELDS_VL KeyFlexfieldEO,
        Fusion.FND_APPL_TAXONOMY_VL ApplTaxonomyPEO,
        Fusion.FND_APPLICATION_VL ApplicationPEO
		WHERE KeyFlexfieldEO.MODULE_ID    = ApplTaxonomyPEO.MODULE_ID
		AND KeyFlexfieldEO.APPLICATION_ID = ApplicationPEO.APPLICATION_ID
		AND (KeyFlexfieldEO.module_id    IN
			  (SELECT rf.child_module_id
			  FROM Fusion.fnd_appl_taxonomy_rf rf
			  INNER JOIN Fusion.fnd_appl_taxonomy t
			  ON rf.ancestor_module_id = t.module_id
			  WHERE t.module_type      = 'APPLICATION'
			  AND t.module_key         = 'GL'
			  ))
    ) HEAD_SUB
	,(SELECT KeyFlexfieldStructureEO.STRUCTURE_ID,
		KeyFlexfieldStructureEO.APPLICATION_ID,
		KeyFlexfieldStructureEO.KEY_FLEXFIELD_CODE,
		KeyFlexfieldStructureEO.STRUCTURE_CODE,
		KeyFlexfieldStructureEO.NAME,
		KeyFlexfieldStructureEO.ENABLED_FLAG,
		KeyFlexfieldStructureEO.DESCRIPTION,
		KeyFlexfieldStructureEO.DELIMITER
		--,StructureInstance.STRUCTURE_INSTANCE_NUMBER
		FROM /*fusion.FND_KF_STR_INSTANCES_VL StructureInstance
		,*/Fusion.FND_KF_STRUCTURES_VL KeyFlexfieldStructureEO
		WHERE ( ( ( (KeyFlexfieldStructureEO.APPLICATION_ID = 101 )
		AND (KeyFlexfieldStructureEO.KEY_FLEXFIELD_CODE     = 'GL#' ) ) ) )
		--AND StructureInstance.STRUCTURE_ID = KeyFlexfieldStructureEO.STRUCTURE_ID 
		ORDER BY KeyFlexfieldStructureEO.NAME
		) Detail_SUB
	WHERE HEAD_SUB.APPLICATION_ID  = Detail_SUB.APPLICATION_ID(+)
	) HEAD
,(SELECT STRUCTURE_ID,
    SEGMENT_CODE,
    SEGMENT_IDENTIFIER,
    COLUMN_NAME,
    NAME,
    DESCRIPTION,
    PROMPT,
    SHORT_PROMPT,
    SEQUENCE_NUMBER,
    ENABLED_FLAG,
    DISPLAY_WIDTH,
    RANGE_TYPE,
    DEFAULT_VALUE_SET_ID,    
    CREATED_BY,
	CREATION_DATE,
    LAST_UPDATE_DATE,
    LAST_UPDATED_BY,
    LAST_UPDATE_LOGIN
	FROM Fusion.FND_KF_SEGMENTS_VL KeyFlexfieldSegmentEO
	) Detail_Segment
WHERE HEAD.STRUCTURE_ID = Detail_Segment.STRUCTURE_ID
ORDER BY HEAD.STRUCTURE_CODE
,Detail_Segment.SEQUENCE_NUMBER