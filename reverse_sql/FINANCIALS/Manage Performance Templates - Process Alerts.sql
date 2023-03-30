/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Performance%20Templates%20-%20Process%20Alerts.sql $:
 * $Id: Manage Performance Templates - Process Alerts.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 -- RSC_PREREQUISITE_OBJECTS = HRA_PROCESS_STEP_ALERTS 
 
SELECT pfTemplatesE0.NAME RES_NAME
,(SELECT TASK_NAME
    FROM HRA_PF_TASK_DEFNS_VL
    WHERE TASK_CODE = processAlertsE0.STEP_CODE
    ) RES_TASK
,processAlertsE0.STANDARD_ALERT_DAYS RES_STANDARD_ALERT_DAYS
,DECODE(processAlertsE0.STANDARD_ALERT_DAILY_FLAG,'Y','Yes','No') RES_REPEAT_STANDARD_ALERT_UNTI
,processAlertsE0.CRITICAL_ALERT_DAYS RES_CRITICAL_ALERT_DAYS
,DECODE(processAlertsE0.CRITICAL_ALERT_DAILY_FLAG,'Y','Yes','No') RES_REPEAT_CRITICAL_ALERT_UNTI

,processAlertsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,processAlertsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,processAlertsE0.CREATED_BY  RSC_CREATED_BY
,processAlertsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
  

FROM HRA_TMPL_DEFNS_VL pfTemplatesE0
,HRA_PROCESS_STEP_ALERTS processAlertsE0
WHERE pfTemplatesE0.TEMPLATE_DEFN_ID = processAlertsE0.TEMPLATE_DEFN_ID
ORDER BY pfTemplatesE0.NAME