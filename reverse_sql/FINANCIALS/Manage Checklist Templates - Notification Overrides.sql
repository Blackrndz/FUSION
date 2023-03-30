/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah.Dusenmahamad $:
 * $Date: 2017-08-28 $:
 * $HeadURL:  $:
 * $Id: Manage Pricing Bases - Pricing Basis.sql 54097 2016-03-30 09:27:56Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=PER_TASK_NOTIFICATIONS

SELECT chklistsE0.NAME RES_CHECKLIST_NAME
,tasksE0.CHECKLIST_TASK_NAME RES_TASK_NAME
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_PER_CHK_TASK_NOTIF_OVR_OPT'
    AND LOOKUP_CODE = notificationsE0.TASK_EVENT
    ) RES_NOTIFY
,DECODE(notificationsE0.NOTIFY_OWNER,'Y','Yes','No') RES_OWNER
,DECODE(notificationsE0.NOTIFY_PERFORMER,'Y','Yes','No') RES_PERFORMER
,notificationsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,notificationsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,notificationsE0.CREATED_BY RSC_CREATED_BY
,notificationsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_CHECKLISTS_VL chklistsE0
,PER_TASKS_IN_CHECKLIST_VL tasksE0
,PER_TASK_NOTIFICATIONS notificationsE0
WHERE chklistsE0.CHECKLIST_ID = tasksE0.CHECKLIST_ID
AND tasksE0.TASK_IN_CHECKLIST_ID = notificationsE0.TASK_IN_CHECKLIST_ID
ORDER BY chklistsE0.NAME
,tasksE0.CHECKLIST_TASK_NAME