/* ****************************************************************************
 * $Revision: 54943 $:
 * $Author: paul.wakefield $:
 * $Date: 2016-05-04 13:45:23 +0700 (Wed, 04 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Trading%20Community%20Person%20Lookups%20-%20Standard%20Lookup%20Type.sql $:
 * $Id: Manage Trading Community Person Lookups - Standard Lookup Type.sql 54943 2016-05-04 06:45:23Z paul.wakefield $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT payFLOWEO.FLOW_NAME  RES_FLOW_PATTERN
,(SELECT FLOW_TASK_NAME FROM PAY_FLOW_TASKS_VL WHERE FLOW_TASK_ID = payFLOWTASKINTERAEO.FROM_FLOW_TASK_ID) RES_TASK
,(SELECT FLOW_TASK_NAME FROM PAY_FLOW_TASKS_VL WHERE FLOW_TASK_ID = payFLOWTASKINTERAEO.TO_FLOW_TASK_ID) RES_FOLLOWING_TASK


,payFLOWTASKINTERAEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,payFLOWTASKINTERAEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,payFLOWTASKINTERAEO.CREATED_BY RSC_CREATED_BY
,payFLOWTASKINTERAEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PAY_FLOWS_VL payFLOWEO
,PAY_FLOW_TASK_INTERACTNS payFLOWTASKINTERAEO
WHERE payFLOWEO.FLOW_ID = payFLOWTASKINTERAEO.BASE_FLOW_ID 
ORDER BY payFLOWEO.FLOW_NAME