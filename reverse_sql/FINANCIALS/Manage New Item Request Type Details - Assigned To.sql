/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20New%20Item%20Request%20Type%20Details%20-%20Assigned%20To.sql $:
 * $Id: Manage New Item Request Type Details - Assigned To.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EGO_CHANGE_TYPES_VL
 
SELECT changeOrderTypesE0.TYPE_NAME RES_NAME
,changeStatusE0.STATUS_NAME RES_STATUS
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_EGO_STEP_ACTIVITY_CODES'
	AND LOOKUP_CODE = statusDetailsE0.STEP_ACTIVITY_TYPE
	) RES_ACTIVITY_TYPE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EGO_ROUTE_ASSIGNEE_TYPES'
	AND LOOKUP_CODE = assignsE0.ASSIGNEE_TYPE_CODE
	) RES_ASSIGNEE_TYPE
,(CASE
	WHEN assignsE0.ASSIGNEE_TYPE_CODE = 'EGO_PERSON' THEN
		(SELECT USERNAME
		FROM PER_USERS
		WHERE USER_GUID = assignsE0.ASSIGNEE_ID)
	WHEN assignsE0.ASSIGNEE_TYPE_CODE = 'EGO_ROLE' THEN
		(SELECT ROLE_NAME
		FROM PER_ROLES_DN_VL
		WHERE ROLE_GUID = assignsE0.ASSIGNEE_ID)
	END) RES_ASSIGNED_TO
,assignsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,assignsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,assignsE0.CREATED_BY  RSC_CREATED_BY
,assignsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM EGO_CHANGE_TYPES_VL changeOrderTypesE0
,(SELECT ENTITY_ID1
	,CHANGE_LIFECYCLE_STATUS_ID
	,STATUS_CODE
	,SEQUENCE_NUMBER
	FROM EGO_LIFECYCLE_STATUSES
	WHERE ENTITY_NAME = 'EGO_CHANGE_TYPE'
	) workflowsE0
,EGO_CHANGE_STATUSES_VL changeStatusE0
,(SELECT STEP_ACTIVITY_TYPE
	,TASK_STAGE_TYPE
	,OBJECT_PK1
	,OBJECT_PK2
	,STEP_ID
	FROM EGO_ROUTE_STEPS 
	WHERE OBJECT_NAME = 'EGO_CHANGE'
	) statusDetailsE0
,EGO_ROUTE_PEOPLE assignsE0
WHERE changeOrderTypesE0.CHANGE_TYPE_ID = workflowsE0.ENTITY_ID1
AND workflowsE0.STATUS_CODE = changeStatusE0.STATUS_CODE
AND changeOrderTypesE0.CHANGE_TYPE_ID = statusDetailsE0.OBJECT_PK1
AND workflowsE0.CHANGE_LIFECYCLE_STATUS_ID = statusDetailsE0.OBJECT_PK2
AND DECODE(changeOrderTypesE0.TYPE_CLASSIFICATION,'HEADER','EGO_HEADER_STAGE','LINE','EGO_LINE_STAGE') = statusDetailsE0.TASK_STAGE_TYPE
AND statusDetailsE0.STEP_ID = assignsE0.STEP_ID
AND changeOrderTypesE0.TYPE_INTERNAL_NAME = 'NewItemRequest'
ORDER BY changeOrderTypesE0.TYPE_NAME
,workflowsE0.SEQUENCE_NUMBER
,statusDetailsE0.STEP_ACTIVITY_TYPE