/* ****************************************************************************
* $Revision: 78502 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-05-17 12:33:58 +0700 (Tue, 17 May 2022) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20Receivables%20Descriptive%20Flexfields%20-%20Manage%20Descriptive%20Flexfields.sql $:
* $Id: Manage Receivables Descriptive Flexfields - Manage Descriptive Flexfields.sql 53187 2016-03-01 11:52:21Z
dhara.pithadiya $:
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
,DECODE(DescriptiveFlexfieldEO.BI_ENABLED_FLAG,'Y',NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ContextSegment.BI_ENABLED_FLAG
	),'No'),NULL) AS RES_BI_ENABLED
,DECODE(DescriptiveFlexfieldEO.BI_ENABLED_FLAG,'Y',(SELECT DISTINCT NAME
	FROM FND_DF_SEGMENT_LABELS_VL
	WHERE DESCRIPTIVE_FLEXFIELD_CODE = ContextSegment.DESCRIPTIVE_FLEXFIELD_CODE
	AND SEGMENT_LABEL_CODE = ContextSegment.BI_EQUALIZATION_TAG
	),NULL)                                    AS RES_BI_LABEL
,ContextSegment.TERMINOLOGY_HELP_TEXT AS RES_DEFINITION_HELP_TEXT
,ContextSegment.IN_FIELD_HELP_TEXT    AS RES_INSTRUCTION_HELP_TEXT
,(CASE WHEN DescriptiveFlexfieldEO.LAST_UPDATED_BY = 'SEED_DATA_FROM_APPLICATION'
	THEN ContextSegment.LAST_UPDATED_BY 
	ELSE DescriptiveFlexfieldEO.LAST_UPDATED_BY END) RSC_LAST_UPDATED_BY
,DescriptiveFlexfieldEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,(CASE WHEN DescriptiveFlexfieldEO.CREATED_BY = 'SEED_DATA_FROM_APPLICATION'
	THEN ContextSegment.CREATED_BY 
	ELSE DescriptiveFlexfieldEO.LAST_UPDATED_BY END) RSC_CREATED_BY
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
ORDER BY RES_FLEXFIELD_NAME
