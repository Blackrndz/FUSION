/* ****************************************************************************
* $Revision: 57094 $:
* $Author: wuttipong.thongvises $:
* $Date: 2016-08-03 15:10:42 +0700 (Wed, 03 Aug 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Fixed%20Assets%20Key%20Flexfields%20-%20Manage%20Key%20Flexfield%20Segment.sql $:
* $Id: Manage Fixed Assets Key Flexfields - Manage Key Flexfield Segment.sql 57094 2016-08-03 08:10:42Z wuttipong.thongvises $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT FndKfFlexfieldVl.KEY_FLEXFIELD_CODE AS RES_KEY_FLEXFIELD_CODE
,FndKfFlexfieldVl.NAME AS RES_KEY_FLEXFIELD_NAME
,FndKfStructuresVl.STRUCTURE_CODE AS RES_STRUCTURE_CODE
,KeyFlexfieldSegmentEO.SEGMENT_CODE       AS RES_SEGMENT_CODE
,KeyFlexfieldSegmentEO.SEGMENT_IDENTIFIER AS RES_API_NAME
,KeyFlexfieldSegmentEO.NAME               AS RES_NAME
,KeyFlexfieldSegmentEO.DESCRIPTION        AS RES_DESCRIPTION
,KeyFlexfieldSegmentEO.SEQUENCE_NUMBER    AS RES_SEQUENCE_NUMBER
,KeyFlexfieldSegmentEO.PROMPT             AS RES_PROMPT
,KeyFlexfieldSegmentEO.SHORT_PROMPT       AS RES_SHORT_PROMPT
,NVL((SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = KeyFlexfieldSegmentEO.ENABLED_FLAG
	),'No')                                   AS RES_ENABLED
,KeyFlexfieldSegmentEO.DISPLAY_WIDTH AS RES_DISPLAY_WIDTH
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_FF_SEGMENT_RANGE_TYPES'
	AND LOOKUP_CODE   = KeyFlexfieldSegmentEO.RANGE_TYPE
	)                                 AS RES_RANGE_TYPE
,KeyFlexfieldSegmentEO.COLUMN_NAME AS RES_COLUMN_NAME
,(SELECT VALUE_SET_CODE
	FROM FND_VS_VALUE_SETS
	WHERE VALUE_SET_ID = KeyFlexfieldSegmentEO.DEFAULT_VALUE_SET_ID
	) AS RES_DEFAULT_VALUE_SET_CODE
,KeyFlexfieldSegmentEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,KeyFlexfieldSegmentEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,KeyFlexfieldSegmentEO.CREATED_BY RSC_CREATED_BY
,KeyFlexfieldSegmentEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_KF_FLEXFIELDS_VL FndKfFlexfieldVl
,FND_KF_STRUCTURES_VL FndKfStructuresVl
,FND_KF_SEGMENTS_VL KeyFlexfieldSegmentEO
WHERE FndKfFlexfieldVl.KEY_FLEXFIELD_CODE = FndKfStructuresVl.KEY_FLEXFIELD_CODE
AND FndKfStructuresVl.STRUCTURE_ID = KeyFlexfieldSegmentEO.STRUCTURE_ID
AND FndKfFlexfieldVl.KEY_FLEXFIELD_CODE IN (
	SELECT AskBoAttributeValues.BO_ATTRIBUTE_VALUE
	FROM ASK_BO_ATTRIBUTE_VALUES AskBoAttributeValues
	,ASK_TASKS_VL AskTasksVl
	WHERE AskBoAttributeValues.TASK_ID = AskTasksVl.TASK_ID
	AND AskTasksVl.TASK_SHORT_NAME = 'CST_MANAGE_COSTING_KEY_FLEXFIELDS')
ORDER BY FndKfFlexfieldVl.KEY_FLEXFIELD_CODE
,FndKfStructuresVl.STRUCTURE_CODE
,KeyFlexfieldSegmentEO.SEQUENCE_NUMBER