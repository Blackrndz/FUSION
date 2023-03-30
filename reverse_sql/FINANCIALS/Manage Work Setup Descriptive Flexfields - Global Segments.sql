/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-10-25 $:
* $HeadURL:  $:
* $Id: Manage Work Setup Descriptive Flexfields - Global Segments.sql  $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT DescriptiveFlexfieldEO.NAME        AS RES_FLEXFIELD_NAME
,GlobalSegment.DESCRIPTIVE_FLEXFIELD_CODE AS RES_FLEXFIELD_CODE
,GlobalSegment.SEQUENCE_NUMBER            AS RES_SEQUENCE
,GlobalSegment.NAME                       AS RES_SEGMENT_NAME
,GlobalSegment.SEGMENT_CODE               AS RES_SEGMENT_CODE
,GlobalSegment.SEGMENT_IDENTIFIER         AS RES_API_NAME
,GlobalSegment.DESCRIPTION                AS RES_DESCRIPTION
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = GlobalSegment.ENABLED_FLAG
	),'No') AS RES_ENABLED
,DECODE(
	(SELECT ColumnE0.COLUMN_TYPE FROM FND_DF_TABLE_USAGES TableUsage
	,FND_FF_COLUMN_USAGES ColumnUsageE0
	,FND_DF_FLEX_USAGES_VL DescriptiveFlexfieldUsageEO
	,FND_TABLES TableE0
	,FND_COLUMNS ColumnE0 WHERE TableUsage.TABLE_USAGE_CODE = ColumnUsageE0.TABLE_USAGE_CODE
	AND TableE0.TABLE_ID                                        = ColumnE0.TABLE_ID
	AND TableE0.TABLE_NAME                                      = ColumnUsageE0.TABLE_NAME
	AND ColumnE0.COLUMN_NAME                                    = ColumnUsageE0.COLUMN_NAME
	AND TableUsage.DESCRIPTIVE_FLEXFIELD_CODE                   = DescriptiveFlexfieldUsageEO.DESCRIPTIVE_FLEXFIELD_CODE
	AND TableUsage.FLEXFIELD_USAGE_CODE                         = DescriptiveFlexfieldUsageEO.FLEXFIELD_USAGE_CODE
	AND DescriptiveFlexfieldUsageEO.USAGE_TYPE                  = 'D'
	AND TableUsage.DESCRIPTIVE_FLEXFIELD_CODE                   = GlobalSegment.DESCRIPTIVE_FLEXFIELD_CODE
	AND ColumnUsageE0.COLUMN_NAME                               = GlobalSegment.COLUMN_NAME
	),'V','Character','D','Date','N','Number','TIMESTAMP','Date Time') AS RES_DATA_TYPE
,GlobalSegment.COLUMN_NAME                                          AS RES_TABLE_COLUMN
,(SELECT VALUE_SET_CODE
	FROM FND_VS_VALUE_SETS
	WHERE VALUE_SET_ID = GlobalSegment.VALUE_SET_ID
	) AS RES_VALUE_SET
,(SELECT DESCRIPTION
	FROM FND_VS_VALUE_SETS
	WHERE VALUE_SET_ID = GlobalSegment.VALUE_SET_ID
	) AS RES_VALUE_SET_DESCRIPTION
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_FF_SEGMENT_RANGE_TYPES'
	AND LOOKUP_CODE   = GlobalSegment.RANGE_TYPE
	) AS RES_RANGE_TYPE
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = GlobalSegment.REQUIRED_FLAG
	),'No') AS RES_REQUIRED
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_DF_SEGMENT_DEFAULT_TYPES'
	AND LOOKUP_CODE   = GlobalSegment.DEFAULT_TYPE
	)                              AS RES_DEFAULT_TYPE
,GlobalSegment.DEFAULT_VALUE    AS RES_DEFAULT_VALUE
,GlobalSegment.DERIVATION_VALUE AS RES_DERIVATION_VALUE
,GlobalSegment.PROMPT           AS RES_PROMPT
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_DF_SEGMENT_DISPLAY_TYPES'
	AND lookup_code   = GlobalSegment.DISPLAY_TYPE
	)                            AS RES_DISPLAY_TYPE
,GlobalSegment.DISPLAY_WIDTH  AS RES_DISPLAY_SIZE
,GlobalSegment.DISPLAY_HEIGHT AS RES_DISPLAY_HEIGHT
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = GlobalSegment.READ_ONLY_FLAG
	),'No')                                AS RES_READ_ONLY
,GlobalSegment.CHECKBOX_CHECKED_VALUE   AS RES_CHECKED_VALUE
,GlobalSegment.CHECKBOX_UNCHECKED_VALUE AS RES_UNCHECKED_VALUE
,GlobalSegment.TERMINOLOGY_HELP_TEXT    AS RES_DEFINITION_HELP_TEXT
,GlobalSegment.IN_FIELD_HELP_TEXT       AS RES_INSTRUCTION_HELP_TEXT
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = GlobalSegment.BI_ENABLED_FLAG
	),'No') AS RES_BI_ENABLED
,(SELECT NAME
	FROM FND_DF_SEGMENT_LABELS_VL
	WHERE SEGMENT_LABEL_CODE = GlobalSegment.BI_EQUALIZATION_TAG
	AND DESCRIPTIVE_FLEXFIELD_CODE = GlobalSegment.DESCRIPTIVE_FLEXFIELD_CODE
	) AS RES_BI_LABEL
,GlobalSegment.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,GlobalSegment.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,GlobalSegment.CREATED_BY RSC_CREATED_BY
,GlobalSegment.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DF_FLEXFIELDS_VL DescriptiveFlexfieldEO
,FND_DF_SEGMENTS_VL GlobalSegment
WHERE GlobalSegment.CONTEXT_CODE                      = 'Global Data Elements'
AND DescriptiveFlexfieldEO.DESCRIPTIVE_FLEXFIELD_CODE = GlobalSegment.DESCRIPTIVE_FLEXFIELD_CODE
AND(DescriptiveFlexfieldEO.module_id                 IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	INNER JOIN fnd_appl_taxonomy t
	ON rf.ancestor_module_id = t.module_id
	WHERE t.module_type      = 'APPLICATION'
	AND t.module_key         = 'WIS'
	))
ORDER BY RES_FLEXFIELD_NAME
,GlobalSegment.SEQUENCE_NUMBER