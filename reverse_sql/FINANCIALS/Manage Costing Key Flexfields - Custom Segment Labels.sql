/* ****************************************************************************
 * $Revision: 63862 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-09-15 10:07:01 +0700 (Fri, 15 Sep 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Structures%20-%20Manage%20Segment%20Labels.sql $:
 * $Id: Manage Chart of Accounts Structures - Manage Segment Labels.sql 63862 2017-09-15 03:07:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT keyFlexFieldsE0.KEY_FLEXFIELD_CODE RES_KEY_FLEXFIELD_CODE
,keyFlexFieldsE0.NAME RES_KEY_FLEXFIELD_NAME
,kffSegmentLabelsE0.SEGMENT_LABEL_CODE RES_SEGMENT_LABEL_CODE
,kffSegmentLabelsE0.NAME RES_NAME
,kffSegmentLabelsE0.DESCRIPTION RES_DESCRIPTION
,DECODE(kffSegmentLabelsE0.GLOBAL_FLAG,'Y','Yes','No') RES_GLOBAL
,DECODE(kffSegmentLabelsE0.REQUIRED_FLAG,'Y','Yes','No') RES_REQUIRED
,DECODE(kffSegmentLabelsE0.UNIQUE_FLAG,'Y','Yes','No') RES_UNIQUE
,kffSegmentLabelsE0.BI_OBJECT_NAME RES_BI_OBJECT_NAME
,kffSegmentLabelsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,kffSegmentLabelsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,kffSegmentLabelsE0.CREATED_BY  RSC_CREATED_BY
,kffSegmentLabelsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_KF_FLEXFIELDS_VL keyFlexFieldsE0
,FND_KF_SEGMENT_LABELS_VL kffSegmentLabelsE0
WHERE keyFlexFieldsE0.APPLICATION_ID = kffSegmentLabelsE0.APPLICATION_ID
AND keyFlexFieldsE0.KEY_FLEXFIELD_CODE = kffSegmentLabelsE0.KEY_FLEXFIELD_CODE
AND keyFlexFieldsE0.KEY_FLEXFIELD_CODE IN (
	SELECT AskBoAttributeValues.BO_ATTRIBUTE_VALUE
	FROM ASK_BO_ATTRIBUTE_VALUES AskBoAttributeValues
	,ASK_TASKS_VL AskTasksVl
	WHERE AskBoAttributeValues.TASK_ID = AskTasksVl.TASK_ID
	AND AskTasksVl.TASK_SHORT_NAME = 'CST_MANAGE_COSTING_KEY_FLEXFIELDS')
ORDER BY keyFlexFieldsE0.KEY_FLEXFIELD_CODE
,kffSegmentLabelsE0.NAME