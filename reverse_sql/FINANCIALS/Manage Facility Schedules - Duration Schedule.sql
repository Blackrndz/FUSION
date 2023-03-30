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
,ScheduleEO.SCHEDULE_DESC RES_DESCRIPTION
,(SELECT MEANING 
	FROM FND_LOOKUP_VALUES_VL 
	WHERE LOOKUP_TYPE = 'ZMM_SR_SCHEDULE_CATEGORY' 
	AND LOOKUP_CODE = ScheduleEO.CATEGORY_CODE) RES_CATEGORY
,TO_CHAR(ScheduleEO.EFFECTIVE_FROM_DATE, 'DD-Mon-YYYY') RES_EFFECTIVE_FROM_DATE
,TO_CHAR(ScheduleEO.EFFECTIVE_TO_DATE, 'DD-Mon-YYYY') RES_EFFECTIVE_TO_DATE
,(SELECT MEANING 
	FROM FND_LOOKUP_VALUES_VL 
	WHERE LOOKUP_TYPE = 'ZMM_SR_QTRLY_TYPE' 
	AND LOOKUP_CODE = ScheduleEO.QTRLY_TYPE_CODE) RES_QUARTERLY_TYPE
,'Yes' RES_ACTIVE
,ScheduleEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ScheduleEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ScheduleEO.CREATED_BY  RSC_CREATED_BY
,ScheduleEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM ZMM_SR_SCHEDULES_VL ScheduleEO
WHERE ScheduleEO.SCHEDULE_TYPE_CODE = 'DURATION'
ORDER BY ScheduleEO.SCHEDULE_NAME