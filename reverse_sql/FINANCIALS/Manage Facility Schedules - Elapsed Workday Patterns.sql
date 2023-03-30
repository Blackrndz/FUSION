/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT ScheduleEO.SCHEDULE_NAME RES_NAME
,SchedulePatternEO.PATTERN_SEQ_NUM RES_SEQUENCE
,PatternEO.PATTERN_NAME RES_PATTERN_NAME
,SchedulePatternEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,SchedulePatternEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,SchedulePatternEO.CREATED_BY  RSC_CREATED_BY
,SchedulePatternEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM ZMM_SR_SCHEDULES_VL ScheduleEO
,ZMM_SR_SCHEDULE_PATTERNS SchedulePatternEO
,ZMM_SR_PATTERNS_VL PatternEO
WHERE ScheduleEO.SCHEDULE_TYPE_CODE = 'ELAPSED'
AND ScheduleEO.SCHEDULE_ID = SchedulePatternEO.SCHEDULE_ID
AND SchedulePatternEO.PATTERN_ID = PatternEO.PATTERN_ID
ORDER BY ScheduleEO.SCHEDULE_NAME
,SchedulePatternEO.PATTERN_SEQ_NUM