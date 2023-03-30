/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-11-07 $:
* $HeadURL: $:
* $Id: Manage Structure Substitute Component Descriptive Flexfields - Descriptive Flexfields.sql
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT DescriptiveFlexfieldEO.NAME                 AS RES_FLEXFIELD_NAME
,DescriptiveFlexfieldEO.DESCRIPTIVE_FLEXFIELD_CODE AS RES_FLEXFIELD_CODE
,DescriptiveFlexfieldEO.DESCRIPTION                AS RES_DESCRIPTION
,DescriptiveFlexfieldEO.DELIMITER                  AS RES_SEGMENT_SEPARATOR
,(SELECT APPLICATION_NAME
	FROM FND_APPLICATION_VL
	WHERE APPLICATION_ID = DescriptiveFlexfieldEO.APPLICATION_ID
	) AS RES_APPLICATION
,(SELECT USER_MODULE_NAME
	FROM FND_APPL_TAXONOMY_VL
	WHERE MODULE_ID = DescriptiveFlexfieldEO.MODULE_ID
	)                                 AS RES_MODULE
,ContextSegment.PROMPT             AS RES_PROMPT
,ContextSegment.SEGMENT_IDENTIFIER AS RES_API_NAME
,(SELECT VALUE_SET_CODE
	FROM FND_VS_VALUE_SETS
	WHERE VALUE_SET_ID = ContextSegment.VALUE_SET_ID
	) AS RES_VALUE_SET
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_DF_SEGMENT_DEFAULT_TYPES'
	AND LOOKUP_CODE   = ContextSegment.DEFAULT_TYPE
	)                               AS RES_DEFAULT_TYPE
,ContextSegment.DEFAULT_VALUE    AS RES_DEFAULT_VALUE
,ContextSegment.DERIVATION_VALUE AS RES_DERIVATION_VALUE
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ContextSegment.REQUIRED_FLAG
	),'No')                                                 AS RES_REQUIRED
,DECODE(ContextSegment.DISPLAY_TYPE,'HIDDEN','No','Yes') AS RES_DISPLAYED
,(SELECT MEANING 
	FROM FND_LOOKUP_VALUES_VL
	WHERE LOOKUP_TYPE = 'FND_DF_SEGMENT_DISPLAY_TYPES'
	AND LOOKUP_CODE = ContextSegment.DISPLAY_TYPE) AS RES_DISPLAY_TYPE
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ContextSegment.BI_ENABLED_FLAG
	),'No') AS RES_BI_ENABLED
,(SELECT distinct NAME
	FROM FND_DF_SEGMENT_LABELS_VL
	WHERE DESCRIPTIVE_FLEXFIELD_CODE = ContextSegment.DESCRIPTIVE_FLEXFIELD_CODE
	AND SEGMENT_LABEL_CODE = ContextSegment.BI_EQUALIZATION_TAG
	) AS RES_BI_LABEL
,ContextSegment.TERMINOLOGY_HELP_TEXT AS RES_DEFINITION_HELP_TEXT
,ContextSegment.IN_FIELD_HELP_TEXT    AS RES_INSTRUCTION_HELP_TEXT
,DescriptiveFlexfieldEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,DescriptiveFlexfieldEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,DescriptiveFlexfieldEO.CREATED_BY RSC_CREATED_BY
,DescriptiveFlexfieldEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DF_FLEXFIELDS_VL DescriptiveFlexfieldEO
,FND_DF_SEGMENTS_VL ContextSegment
WHERE DescriptiveFlexfieldEO.FLEXFIELD_TYPE           = 'DFF'
AND DescriptiveFlexfieldEO.APPLICATION_ID             = ContextSegment.APPLICATION_ID
AND DescriptiveFlexfieldEO.DESCRIPTIVE_FLEXFIELD_CODE = ContextSegment.DESCRIPTIVE_FLEXFIELD_CODE
AND ContextSegment.CONTEXT_CODE = 'Context Data Element'
AND ContextSegment.SEGMENT_CODE = 'Context Segment'
and DescriptiveFlexfieldEO.DESCRIPTIVE_FLEXFIELD_CODE =  'EGP_SUBSTITUTE_COMPONENT_DFF'
/*AND(DescriptiveFlexfieldEO.module_id     IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	INNER JOIN fnd_appl_taxonomy t
	ON rf.ancestor_module_id = t.module_id
	WHERE t.module_type      = 'APPLICATION'
	AND t.module_key         = 'EGP'
	))*/
ORDER BY RES_FLEXFIELD_NAME