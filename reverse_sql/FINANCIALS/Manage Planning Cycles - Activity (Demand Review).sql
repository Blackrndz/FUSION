/* ****************************************************************************
* $Revision: 67218 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2018-03-21 11:56:22 +0700 (Wed, 21 Mar 2018) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Key%20Flexfields%20-%20Key%20Flexfield%20Segment.sql $:
* $Id: Manage Key Flexfields - Key Flexfield Segment.sql 67218 2018-03-21 04:56:22Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=MSC_SOP_PLAN_CYCLE_VL

SELECT PlanCycleE0.PLAN_CYCLE_NAME RES_NAME
,ActivitiesE0.ACTIVITY_NAME RES_TITLE
,(SELECT SUB_PROCESS_NAME
	FROM MSC_SOP_PLAN_SUB_PROCESS_TL
	WHERE SUB_PROCESS_ID = ActivitiesE0.CATEGORY
	AND LANGUAGE = USERENV('LANG')
	) RES_CATEGORY
,(SELECT USERNAME
	FROM PER_USERS
	WHERE USER_ID = ActivitiesE0.OWNER
	AND SYSDATE BETWEEN START_DATE AND NVL(END_DATE,SYSDATE+1)
	) RES_OWNER
,(SELECT USERNAME
	FROM PER_USERS
	WHERE USER_ID = ActivitiesE0.ASSIGNED_TO
	AND SYSDATE BETWEEN START_DATE AND NVL(END_DATE,SYSDATE+1)
	) RES_ASSIGNEE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_MSC_SOP_ACTIVITY_TASK_TYPE'
	AND LOOKUP_CODE = 	ActivitiesE0.ACTIVITY_TYPE
	) RES_TYPE
,ActivitiesE0.LINK_TO RES_LINK
,ActivitiesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ActivitiesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ActivitiesE0.CREATED_BY RSC_CREATED_BY
,ActivitiesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_SOP_PLAN_CYCLE_VL PlanCycleE0
,MSC_SOP_PLAN_ACTIVITY_VL ActivitiesE0
WHERE PlanCycleE0.PLAN_CYCLE_ID = ActivitiesE0.PLAN_CYCLE_ID
AND ActivitiesE0.SUB_PROCESS_ID = 2
ORDER BY PlanCycleE0.PLAN_CYCLE_NAME
,ActivitiesE0.DISPLAY_ORDER