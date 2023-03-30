/* ****************************************************************************
* $Revision: 78284 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-13 13:03:20 +0700 (Wed, 13 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Catalog%20Descriptive%20Flexfields%20-%20Context%20Segments.sql $:
* $Id: Manage Catalog Descriptive Flexfields - Context Segments.sql 78284 2022-04-13 06:03:20Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT DescriptiveFlexfieldEO.NAME                        AS RES_FLEXFIELD_NAME
,DescriptiveFlexfieldContextE1.DESCRIPTIVE_FLEXFIELD_CODE AS RES_FLEXFIELD_CODE
,DescriptiveFlexfieldContextE1.NAME                       AS RES_DISPLAY_NAME
,DescriptiveFlexfieldContextE1.CONTEXT_CODE               AS RES_CONTEXT_CODE
,ContextSegment.SEQUENCE_NUMBER            AS RES_SEQUENCE
,ContextSegment.NAME                AS RES_SEGMENT_NAME
,ContextSegment.SEGMENT_CODE               AS RES_SEGMENT_CODE
,ContextSegment.SEGMENT_IDENTIFIER         AS RES_API_NAME
,ContextSegment.DESCRIPTION                AS RES_DESCRIPTION
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ContextSegment.ENABLED_FLAG
	),'No') AS RES_ENABLED
,DECODE(
	(SELECT ColumnE0.COLUMN_TYPE 
	FROM FND_DF_TABLE_USAGES TableUsage
	,FND_FF_COLUMN_USAGES ColumnUsageE0
	,FND_DF_FLEX_USAGES_VL DescriptiveFlexfieldUsageEO
	,FND_TABLES TableE0
	,FND_COLUMNS ColumnE0 
	WHERE TableUsage.TABLE_USAGE_CODE = ColumnUsageE0.TABLE_USAGE_CODE
	AND TableE0.TABLE_ID                                        = ColumnE0.TABLE_ID
	AND TableE0.TABLE_NAME                                      = ColumnUsageE0.TABLE_NAME
	AND ColumnE0.COLUMN_NAME                                    = ColumnUsageE0.COLUMN_NAME
	AND TableUsage.DESCRIPTIVE_FLEXFIELD_CODE                   = DescriptiveFlexfieldUsageEO.DESCRIPTIVE_FLEXFIELD_CODE
	AND TableUsage.FLEXFIELD_USAGE_CODE                         = DescriptiveFlexfieldUsageEO.FLEXFIELD_USAGE_CODE
	AND DescriptiveFlexfieldUsageEO.USAGE_TYPE                  = 'D'
	AND TableUsage.DESCRIPTIVE_FLEXFIELD_CODE                   = ContextSegment.DESCRIPTIVE_FLEXFIELD_CODE
	AND ColumnUsageE0.COLUMN_NAME                               = ContextSegment.COLUMN_NAME
	),'V','Character','D','Date','N','Number','TIMESTAMP','Date Time') AS RES_DATA_TYPE
,ContextSegment.COLUMN_NAME AS RES_TABLE_COLUMN
,(SELECT VALUE_SET_CODE
	FROM FND_VS_VALUE_SETS
	WHERE VALUE_SET_ID = ContextSegment.VALUE_SET_ID
	) AS RES_VALUE_SET
,(SELECT DESCRIPTION
	FROM FND_VS_VALUE_SETS
	WHERE VALUE_SET_ID = ContextSegment.VALUE_SET_ID
	) AS RES_VALUE_SET_DESCRIPTION
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_FF_SEGMENT_RANGE_TYPES'
	AND LOOKUP_CODE   = ContextSegment.RANGE_TYPE
	) AS RES_RANGE_TYPE
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ContextSegment.REQUIRED_FLAG
	),'No') AS RES_REQUIRED
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_DF_SEGMENT_DEFAULT_TYPES'
	AND LOOKUP_CODE   = ContextSegment.DEFAULT_TYPE
	)                               AS RES_DEFAULT_TYPE
,ContextSegment.DEFAULT_VALUE    AS RES_DEFAULT_VALUE
,ContextSegment.DERIVATION_VALUE AS RES_DERIVATION_VALUE
,ContextSegment.PROMPT           AS RES_PROMPT
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_DF_SEGMENT_DISPLAY_TYPES'
	AND lookup_code   = ContextSegment.DISPLAY_TYPE
	)                             AS RES_DISPLAY_TYPE
,ContextSegment.DISPLAY_WIDTH  AS RES_DISPLAY_SIZE
,ContextSegment.DISPLAY_HEIGHT AS RES_DISPLAY_HEIGHT
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ContextSegment.READ_ONLY_FLAG
	),'No') AS RES_READ_ONLY
,ContextSegment.CHECKBOX_CHECKED_VALUE AS RES_CHECKED_VALUE
,ContextSegment.CHECKBOX_UNCHECKED_VALUE AS RES_UNCHECKED_VALUE
,ContextSegment.TERMINOLOGY_HELP_TEXT AS RES_DEFINITION_HELP_TEXT
,ContextSegment.IN_FIELD_HELP_TEXT    AS RES_INSTRUCTION_HELP_TEXT
,DECODE(DescriptiveFlexfieldEO.BI_ENABLED_FLAG,'Y',NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ContextSegment.BI_ENABLED_FLAG
	),'No'),NULL) AS RES_BI_ENABLED
,DECODE(DescriptiveFlexfieldEO.BI_ENABLED_FLAG,'Y',(SELECT NAME
	FROM FND_DF_SEGMENT_LABELS_VL
	WHERE DESCRIPTIVE_FLEXFIELD_CODE = ContextSegment.DESCRIPTIVE_FLEXFIELD_CODE
	AND SEGMENT_LABEL_CODE = ContextSegment.BI_EQUALIZATION_TAG
	),NULL) AS RES_BI_LABEL
,ContextSegment.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,ContextSegment.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,ContextSegment.CREATED_BY  RSC_CREATED_BY
,ContextSegment.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID
    
FROM FND_DF_CONTEXTS_VL DescriptiveFlexfieldContextE1
,FND_DF_SEGMENTS_VL ContextSegment
,FND_DF_FLEXFIELDS_VL DescriptiveFlexfieldEO
WHERE ContextSegment.APPLICATION_ID = 10011
and DescriptiveFlexfieldContextE1.APPLICATION_ID = ContextSegment.APPLICATION_ID
and DescriptiveFlexfieldContextE1.DESCRIPTIVE_FLEXFIELD_CODE = ContextSegment.DESCRIPTIVE_FLEXFIELD_CODE
and DescriptiveFlexfieldContextE1.CONTEXT_CODE = ContextSegment.CONTEXT_CODE
AND DescriptiveFlexfieldEO.DESCRIPTIVE_FLEXFIELD_CODE        = DescriptiveFlexfieldContextE1.DESCRIPTIVE_FLEXFIELD_CODE
AND DescriptiveFlexfieldEO.FLEXFIELD_TYPE                    = 'DFF'
AND ContextSegment.DESCRIPTIVE_FLEXFIELD_CODE IN
	(SELECT BoAttributeValuesEO.BO_ATTRIBUTE_VALUE
	FROM ASK_BO_ATTRIBUTE_VALUES BOATTRIBUTEVALUESEO
	WHERE(BOATTRIBUTEVALUESEO.BO_ATTRIBUTE_SHORT_NAME = 'descriptiveFlexfieldCode'
	AND BoAttributeValuesEO.TASK_ID                   =
		(SELECT task_id
		FROM ASK_TASKS_VL
		WHERE TASK_SHORT_NAME = 'EGP_MANAGE_CATALOG_ATTRIBUTES'))
		)
ORDER BY RES_FLEXFIELD_NAME
,ContextSegment.CONTEXT_CODE  
,ContextSegment.SEQUENCE_NUMBER 