/* ****************************************************************************
* $Revision: 74000 $:
* $Author: tanawat.wongjan $:
* $Date: 2020-04-17 15:10:24 +0700 (Fri, 17 Apr 2020) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Work%20Schedule%20Assignment%20Administration%20-%20Resource%20Assignments.sql $:
* $Id: Manage Work Schedule Assignment Administration - Resource Assignments.sql 74000 2020-04-17 08:10:24Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT schedulesE0.SCHEDULE_NAME RES_NAME
,schedulesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,schedulesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,schedulesE0.CREATED_BY RSC_CREATED_BY
,schedulesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZMM_SR_SCHEDULES_VL schedulesE0
WHERE schedulesE0.SCHEDULE_ID IN (SELECT SCHEDULE_ID FROM PER_SCHEDULE_ASSIGNMENTS)
ORDER BY schedulesE0.SCHEDULE_NAME