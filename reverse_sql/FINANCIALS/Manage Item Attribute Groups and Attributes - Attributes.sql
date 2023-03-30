/* ****************************************************************************
* $Revision: 59053 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-20 13:59:22 +0700 (Wed, 19 Oct 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Time%20Shift.sql $:
* $Id: Manage Buyer Assignment Rule Sets Lookup - Lookup Codes.sql 59053 2016-10-19 06:59:22Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT contextFlexfeildsE0.NAME RES_DISPLAY_NAME
,contextSegmentFFsE0.SEQUENCE_NUMBER RES_SEQUENCE
,contextSegmentFFsE0.NAME RES_NAME
,contextSegmentFFsE0.SEGMENT_CODE RES_INTERNAL_NAME
,contextSegmentFFsE0.SEGMENT_IDENTIFIER RES_API_NAME
,contextSegmentFFsE0.DESCRIPTION RES_DESCRIPTION
,DECODE(contextSegmentFFsE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,(CASE
	WHEN contextFlexfeildsE0.MULTIROW_FLAG = 'Y' THEN
		DECODE(contextSegmentFFsE0.MULTIROW_UNIQUE_KEY_FLAG,'Y','Yes','No')
	END) RES_UNIQUE_KEY
,DECODE(
	(SELECT DISTINCT ColumnE0.COLUMN_TYPE 
	FROM FND_DF_TABLE_USAGES TableUsage
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
	AND TableUsage.DESCRIPTIVE_FLEXFIELD_CODE = contextSegmentFFsE0.DESCRIPTIVE_FLEXFIELD_CODE
	AND ColumnUsageE0.COLUMN_NAME = contextSegmentFFsE0.COLUMN_NAME
	),'V','Character','D','Date','N','Number','TIMESTAMP','Date Time') RES_DATA_TYPE
,contextSegmentFFsE0.COLUMN_NAME RES_TABLE_COLUMN
,DECODE(contextSegmentFFsE0.INDEXED_FLAG,'Y','Yes','No') RES_INDEXED
,valueSetsE0.VALUE_SET_CODE RES_VALUE_SET
,valueSetsE0.DESCRIPTION RES_VALUE_SET_DESCRIPTION
,contextSegmentFFsE0.UOM_CLASS RES_UOM_CLASS
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_FF_SEGMENT_RANGE_TYPES'
	AND LOOKUP_CODE = contextSegmentFFsE0.RANGE_TYPE
	) RES_RANGE_TYPE
,DECODE(contextSegmentFFsE0.REQUIRED_FLAG,'Y','Yes','No') RES_REQUIRED
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_DF_SEGMENT_DEFAULT_TYPES'
	AND LOOKUP_CODE = contextSegmentFFsE0.DEFAULT_TYPE
	) RES_DEFAULT_TYPE
,contextSegmentFFsE0.DEFAULT_VALUE RES_DEFAULT_VALUE
,contextSegmentFFsE0.PROMPT RES_PROMPT
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_DF_SEGMENT_DISPLAY_TYPES'
	AND lookup_code = contextSegmentFFsE0.DISPLAY_TYPE
	) RES_DISPLAY_TYPE
,contextSegmentFFsE0.DISPLAY_WIDTH RES_DISPLAY_SIZE
,contextSegmentFFsE0.DISPLAY_HEIGHT RES_DISPLAY_HEIGHT
,DECODE(contextSegmentFFsE0.READ_ONLY_FLAG,'Y','Yes','No') RES_READ_ONLY
,contextSegmentFFsE0.CHECKBOX_CHECKED_VALUE RES_CHECKED_VALUE
,contextSegmentFFsE0.CHECKBOX_UNCHECKED_VALUE RES_UNCHECKED_VALUE
,DECODE(contextSegmentFFsE0.SHOW_VALUE_DESCRIPTION,'Y','Yes','No') RES_SHOW_VALUE_DESCRIPTION
,contextSegmentFFsE0.TERMINOLOGY_HELP_TEXT RES_DEFINITION_HELP_TEXT
,contextSegmentFFsE0.IN_FIELD_HELP_TEXT RES_INSTRUCTION_HELP_TEXT
,DECODE(contextSegmentFFsE0.BI_ENABLED_FLAG,'Y','Yes','No') RES_BI_ENABLED
,contextSegmentFFsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,contextSegmentFFsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,contextSegmentFFsE0.CREATED_BY RSC_CREATED_BY
,contextSegmentFFsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DF_FLEXFIELDS_VL flexfiieldsE0
,FND_DF_CONTEXTS_VL contextFlexfeildsE0
,FND_DF_SEGMENTS_VL contextSegmentFFsE0
,FND_VS_VALUE_SETS valueSetsE0
WHERE flexfiieldsE0.DESCRIPTIVE_FLEXFIELD_CODE = contextFlexfeildsE0.DESCRIPTIVE_FLEXFIELD_CODE
AND flexfiieldsE0.DESCRIPTIVE_FLEXFIELD_CODE = 'EGO_ITEM_EFF'
AND contextFlexfeildsE0.DESCRIPTIVE_FLEXFIELD_CODE = contextSegmentFFsE0.DESCRIPTIVE_FLEXFIELD_CODE
AND contextFlexfeildsE0.APPLICATION_ID = contextSegmentFFsE0.APPLICATION_ID
AND contextFlexfeildsE0.CONTEXT_CODE = contextSegmentFFsE0.CONTEXT_CODE
AND contextSegmentFFsE0.CONTEXT_CODE NOT IN ('Context Data Element', 'Global Data Elements')
AND contextSegmentFFsE0.VALUE_SET_ID = valueSetsE0.VALUE_SET_ID(+)
ORDER BY contextFlexfeildsE0.NAME
,contextSegmentFFsE0.SEQUENCE_NUMBER