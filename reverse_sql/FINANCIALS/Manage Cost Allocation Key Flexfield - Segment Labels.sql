/* ****************************************************************************
* $Revision: 60908 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2017-02-06 10:19:47 +0700 (Mon, 06 Feb 2017) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Fixed%20Assets%20Key%20Flexfields%20-%20Manage%20Segment%20Labels.sql $:
* $Id: Manage Fixed Assets Key Flexfields - Manage Segment Labels.sql 60908 2017-02-06 03:19:47Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT FndKfFlexfieldVl.KEY_FLEXFIELD_CODE AS RES_KEY_FLEXFIELD_CODE
,FndKfFlexfieldVl.NAME AS RES_KEY_FLEXFIELD_NAME
,FndKfStructuresVl.STRUCTURE_CODE AS RES_STRUCTURE_CODE
,SegmentLabel.SEGMENT_CODE AS RES_SEGMENT_CODE
,SegmentLabelDetail.NAME AS RES_SELECTED_LABELS
,SegmentLabel.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,SegmentLabel.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,SegmentLabel.CREATED_BY RSC_CREATED_BY
,SegmentLabel.CREATION_DATE RSC_CREATION_DATE
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
,FND_KF_LABELED_SEGMENTS SegmentLabel
,FND_KF_SEGMENT_LABELS_TL SegmentLabelDetail
WHERE FndKfFlexfieldVl.KEY_FLEXFIELD_CODE = FndKfStructuresVl.KEY_FLEXFIELD_CODE
AND FndKfStructuresVl.STRUCTURE_ID = SegmentLabel.STRUCTURE_ID
AND SegmentLabel.SEGMENT_LABEL_CODE = SegmentLabelDetail.SEGMENT_LABEL_CODE
AND SegmentLabelDetail.LANGUAGE = USERENV('LANG')
AND FndKfFlexfieldVl.KEY_FLEXFIELD_CODE IN (
	SELECT AskBoAttributeValues.BO_ATTRIBUTE_VALUE
	FROM ASK_BO_ATTRIBUTE_VALUES AskBoAttributeValues
	,ASK_TASKS_VL AskTasksVl
	WHERE AskBoAttributeValues.TASK_ID = AskTasksVl.TASK_ID
	AND AskTasksVl.TASK_SHORT_NAME = 'PAY_MANAGE_KEY_FLEXFIELD_FOR_COST_ALLOCATION')
ORDER BY RES_KEY_FLEXFIELD_CODE
,RES_STRUCTURE_CODE
,SegmentLabel.SEGMENT_CODE