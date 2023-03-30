/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EGO_CHANGE_TYPES_VL
 
SELECT changeOrderTypesE0.TYPE_NAME RES_NAME
,changeOrderTypesE0.TYPE_INTERNAL_NAME RES_INTERNAL_NAME
,changeOrderTypesE0.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(changeOrderTypesE0.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(changeOrderTypesE0.DISABLE_DATE,'DD-Mon-YYYY') RES_END_DATE
,(SELECT USERNAME
	FROM PER_USERS
	WHERE USER_GUID = changeOrderTypesE0.DEFAULT_ASSIGNEE_ID
	) RES_ASSIGNED_TO
,(CASE
	WHEN copyFromE0.EFFECTIVE_IMMEDIATELY_FLAG = 'N' THEN
		DECODE(changeOrderTypesE0.EFFECTIVE_IMMEDIATELY_FLAG,'N','Days after change order creation date','Y','Effective immediately')
	END) RES_ITEM_EFFECTIVE_DATE
,(CASE
	WHEN copyFromE0.EFFECTIVE_IMMEDIATELY_FLAG = 'N' THEN
		changeOrderTypesE0.EFFECTIVITY_INCREMENT_DAYS
	END) RES_NUMBER_OF_DAYS
,(SELECT TYPE_NAME
	FROM EGO_CHANGE_TYPES_VL
	WHERE CHANGE_MGMT_TYPE_CODE = changeOrderTypesE0.CHANGE_MGMT_TYPE_CODE
	AND BASE_CHANGE_MGMT_TYPE_CODE = changeOrderTypesE0.BASE_CHANGE_MGMT_TYPE_CODE
	AND TYPE_CLASSIFICATION = 'CATEGORY'
	) RES_CHANGE_CATEGORY
,copyFromE0.TYPE_NAME RES_COPIED_FROM
,changeOrderTypesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,changeOrderTypesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,changeOrderTypesE0.CREATED_BY  RSC_CREATED_BY
,changeOrderTypesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM EGO_CHANGE_TYPES_VL changeOrderTypesE0
,EGO_CHANGE_TYPES_VL copyFromE0
WHERE DECODE(changeOrderTypesE0.COPIED_FROM,'ECO','ECO','ORA_'||changeOrderTypesE0.COPIED_FROM) = copyFromE0.TYPE_INTERNAL_NAME
AND changeOrderTypesE0.COPIED_FROM IS NOT NULL
ORDER BY changeOrderTypesE0.TYPE_NAME