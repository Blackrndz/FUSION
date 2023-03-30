/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT schedulesE0.SCHEDULE_NAME RES_NAME
,schedulePatternsE0.PATTERN_SEQ_NUM RES_SEQUENCE
,patternsE0.PATTERN_NAME RES_PATTERN_NAME
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ZMM_SR_PATTERN_TYPE'
    AND LOOKUP_CODE = patternsE0.PATTERN_TYPE_CODE
    ) RES_TYPE
,patternsE0.LENGTH_DAYS_NUM RES_LENGTH_IN_DAYS
,patternsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,patternsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,patternsE0.CREATED_BY RSC_CREATED_BY
,patternsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZMM_SR_SCHEDULES_VL schedulesE0
,ZMM_SR_SCHEDULE_PATTERNS schedulePatternsE0
,ZMM_SR_PATTERNS_VL patternsE0
WHERE schedulesE0.SCHEDULE_ID = schedulePatternsE0.SCHEDULE_ID
AND schedulePatternsE0.PATTERN_ID = patternsE0.PATTERN_ID
ORDER BY schedulesE0.SCHEDULE_NAME
,schedulePatternsE0.PATTERN_SEQ_NUM