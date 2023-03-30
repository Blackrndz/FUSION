/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Workforce%20Profile%20Descriptive%20Flexfields%20-%20Global%20Segments.sql $:
* $Id: Manage Workforce Profile Descriptive Flexfields - Global Segments.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT DescriptiveFlexfieldEO.NAME      AS RES_FLEXFIELD_NAME
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
,DECODE((select ColumnE0.COLUMN_TYPE
from FND_DF_TABLE_USAGES TableUsage
,FND_FF_COLUMN_USAGES ColumnUsageE0
,FND_DF_FLEX_USAGES_VL DescriptiveFlexfieldUsageEO
,FND_TABLES TableE0
,FND_COLUMNS ColumnE0
WHERE TableUsage.TABLE_USAGE_CODE = ColumnUsageE0.TABLE_USAGE_CODE
AND TableE0.TABLE_ID = ColumnE0.TABLE_ID
AND TableE0.TABLE_NAME = ColumnUsageE0.TABLE_NAME
AND ColumnE0.COLUMN_NAME = ColumnUsageE0.COLUMN_NAME
AND TableUsage.DESCRIPTIVE_FLEXFIELD_CODE = DescriptiveFlexfieldUsageEO.DESCRIPTIVE_FLEXFIELD_CODE
AND TableUsage.FLEXFIELD_USAGE_CODE = DescriptiveFlexfieldUsageEO.FLEXFIELD_USAGE_CODE
AND DescriptiveFlexfieldUsageEO.USAGE_TYPE = 'D'
AND TableUsage.DESCRIPTIVE_FLEXFIELD_CODE = GlobalSegment.DESCRIPTIVE_FLEXFIELD_CODE
AND ColumnUsageE0.COLUMN_NAME = GlobalSegment.COLUMN_NAME),'V','Character','D','Date','N','Number','TIMESTAMP','Date Time') AS RES_DATA_TYPE
,GlobalSegment.COLUMN_NAME AS RES_TABLE_COLUMN
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
	),'No') AS RES_READ_ONLY
,GlobalSegment.CHECKBOX_CHECKED_VALUE AS RES_CHECKED_VALUE
,GlobalSegment.CHECKBOX_UNCHECKED_VALUE AS RES_UNCHECKED_VALUE
,GlobalSegment.TERMINOLOGY_HELP_TEXT AS RES_DEFINITION_HELP_TEXT
,GlobalSegment.IN_FIELD_HELP_TEXT    AS RES_INSTRUCTION_HELP_TEXT
,DECODE(DescriptiveFlexfieldEO.BI_ENABLED_FLAG,'Y',
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = NVL(GlobalSegment.BI_ENABLED_FLAG,'N')
	),NULL) AS RES_BI_ENABLED
,DECODE(DescriptiveFlexfieldEO.BI_ENABLED_FLAG,'Y',
	(SELECT NAME
	FROM FND_DF_SEGMENT_LABELS_VL
	WHERE SEGMENT_LABEL_CODE = GlobalSegment.BI_EQUALIZATION_TAG
	AND DESCRIPTIVE_FLEXFIELD_CODE = GlobalSegment.DESCRIPTIVE_FLEXFIELD_CODE
	),NULL) AS RES_BI_LABEL
,GlobalSegment.CREATED_BY  AS RSC_CREATED_BY
,GlobalSegment.CREATION_DATE AS RSC_CREATION_DATE
,GlobalSegment.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,GlobalSegment.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM FND_DF_SEGMENTS_VL GlobalSegment
,FND_DF_FLEXFIELDS_VL DescriptiveFlexfieldEO
WHERE GlobalSegment.CONTEXT_CODE = 'Global Data Elements'
AND DescriptiveFlexfieldEO.DESCRIPTIVE_FLEXFIELD_CODE = GlobalSegment.DESCRIPTIVE_FLEXFIELD_CODE
AND GlobalSegment.APPLICATION_ID = 800
AND DescriptiveFlexfieldEO.DESCRIPTIVE_FLEXFIELD_CODE NOT IN ('HRT_POOL_MEMBERS','HRT_POOLS_B')
AND(DescriptiveFlexfieldEO.module_id     IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	INNER JOIN fnd_appl_taxonomy t
	ON rf.ancestor_module_id = t.module_id
	WHERE t.module_type      = 'LBA'
	AND t.module_key         IN ('HcmProfileTop')
	))
ORDER BY RES_FLEXFIELD_NAME
,GlobalSegment.SEQUENCE_NUMBER