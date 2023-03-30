/* ****************************************************************************
* $Revision: 53610 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-31 11:01:59 +0700 (Thu, 17 Mar 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cash%20Management%20Descriptive%20Flexfields%20-%20Manage%20Cash%20Management%20Descriptive%20Flexfields.sql $:
* $Id: Manage Requisition Descriptive Flexfields - Context Segments.sql 53610 2016-03-17 04:01:59Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT DescriptiveFlexfieldEO.NAME     			RES_FLEXFIELD_NAME,
GlobalSegment.DESCRIPTIVE_FLEXFIELD_CODE                                        			RES_FLEXFIELD_CODE,
DescriptiveFlexfieldContextE1.NAME                                                        	RES_DISPLAY_NAME,
GlobalSegment.CONTEXT_CODE    																RES_CONTEXT_CODE,
GlobalSegment.SEQUENCE_NUMBER                               								RES_SEQUENCE,
GlobalSegment.NAME                                                        					RES_SEGMENT_NAME,
GlobalSegment.SEGMENT_CODE                                  								RES_SEGMENT_CODE,
GlobalSegment.SEGMENT_IDENTIFIER            												RES_API_NAME,
GlobalSegment.DESCRIPTION                                                 					RES_DESCRIPTION,
decode(GlobalSegment.ENABLED_FLAG,'Y','Yes','No')                                              					RES_ENABLED,
DECODE(
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
	AND TableUsage.DESCRIPTIVE_FLEXFIELD_CODE                   = GlobalSegment.DESCRIPTIVE_FLEXFIELD_CODE
	AND ColumnUsageE0.COLUMN_NAME                               = GlobalSegment.COLUMN_NAME
	),'V','Character','D','Date','N','Number','TIMESTAMP','Date Time') 						RES_DATA_TYPE,
GlobalSegment.COLUMN_NAME                                   								RES_TABLE_COLUMN,
ValueSet.VALUE_SET_CODE                      												RES_VALUE_SET,
ValueSet.DESCRIPTION                            											RES_VALUE_SET_DESCRIPTION,
(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_FF_SEGMENT_RANGE_TYPES'
	AND lookup_code   =  GlobalSegment.RANGE_TYPE  )                            										RES_RANGE_TYPE,
decode(GlobalSegment.REQUIRED_FLAG,'Y','Yes','No')                           										RES_REQUIRED,
(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_DF_SEGMENT_DEFAULT_TYPES'
	AND LOOKUP_CODE   =  GlobalSegment.DEFAULT_TYPE     )                            		RES_DEFAULT_TYPE,
GlobalSegment.DEFAULT_VALUE                           										RES_DEFAULT_VALUE,
GlobalSegment.DERIVATION_VALUE AS RES_DERIVATION_VALUE,
GlobalSegment.PROMPT                                  										RES_PROMPT,
(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_DF_SEGMENT_DISPLAY_TYPES'
	AND lookup_code   =  GlobalSegment.DISPLAY_TYPE    )                            		RES_DISPLAY_TYPE,
GlobalSegment.DISPLAY_WIDTH                             									RES_DISPLAY_SIZE,
GlobalSegment.DISPLAY_HEIGHT                          										RES_DISPLAY_HEIGHT,
decode(GlobalSegment.READ_ONLY_FLAG,'Y','Yes','No') 									RES_READ_ONLY,
GlobalSegment.CHECKBOX_CHECKED_VALUE                 										RES_CHECKED_VALUE,
GlobalSegment.CHECKBOX_UNCHECKED_VALUE               										RES_UNCHECKED_VALUE,
GlobalSegment.TERMINOLOGY_HELP_TEXT                 										RES_DEFINITION_HELP_TEXT,
GlobalSegment.IN_FIELD_HELP_TEXT                     										RES_INSTRUCTION_HELP_TEXT,
DECODE(DescriptiveFlexfieldEO.BI_ENABLED_FLAG,'Y',NVL(
	decode(GlobalSegment.BI_ENABLED_FLAG,'Y','Yes','N','No'),'No'),NULL)									RES_BI_ENABLED,
DECODE(DescriptiveFlexfieldEO.BI_ENABLED_FLAG,'Y',
	(SELECT distinct NAME
	FROM FND_DF_SEGMENT_LABELS_VL
	WHERE DESCRIPTIVE_FLEXFIELD_CODE = GlobalSegment.DESCRIPTIVE_FLEXFIELD_CODE
	AND SEGMENT_LABEL_CODE =  GlobalSegment.BI_EQUALIZATION_TAG ),NULL)                     	RES_BI_LABEL
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
 

FROM FND_DF_SEGMENTS_VL GlobalSegment,
  FND_VS_VALUE_SETS ValueSet,
  FND_DF_CONTEXTS_VL DescriptiveFlexfieldContextE1
,FND_DF_FLEXFIELDS_VL DescriptiveFlexfieldEO
WHERE GlobalSegment.VALUE_SET_ID             = ValueSet.VALUE_SET_ID
--AND GlobalSegment.CONTEXT_CODE          =      'Context Data Element 1'--'Global Data Elements'
AND GlobalSegment.CONTEXT_CODE NOT IN ('Global Data Elements')
AND GlobalSegment.APPLICATION_ID             = 8402
AND DescriptiveFlexfieldEO.DESCRIPTIVE_FLEXFIELD_CODE        = DescriptiveFlexfieldContextE1.DESCRIPTIVE_FLEXFIELD_CODE
AND DescriptiveFlexfieldEO.FLEXFIELD_TYPE                    = 'DFF'
and DescriptiveFlexfieldContextE1.APPLICATION_ID = GlobalSegment.APPLICATION_ID
and DescriptiveFlexfieldContextE1.DESCRIPTIVE_FLEXFIELD_CODE = GlobalSegment.DESCRIPTIVE_FLEXFIELD_CODE
and DescriptiveFlexfieldContextE1.CONTEXT_CODE = GlobalSegment.CONTEXT_CODE
AND DescriptiveFlexfieldEO.bi_enabled_flag = 'Y'
ORDER BY GlobalSegment.APPLICATION_ID, GlobalSegment.DESCRIPTIVE_FLEXFIELD_CODE
,GlobalSegment.CONTEXT_CODE  
,GlobalSegment.SEQUENCE_NUMBER 