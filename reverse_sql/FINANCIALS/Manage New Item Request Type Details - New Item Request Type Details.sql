/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20New%20Item%20Request%20Type%20Details%20-%20New%20Item%20Request%20Type%20Details.sql $:
 * $Id: Manage New Item Request Type Details - New Item Request Type Details.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EGO_CHANGE_TYPES_VL
 
SELECT changeOrderTypesE0.TYPE_NAME RES_NAME
,changeOrderTypesE0.TYPE_INTERNAL_NAME RES_INTERNAL_NAME
,changeOrderTypesE0.DESCRIPTION RES_DESCRIPTION
,DECODE(changeOrderTypesE0.EFFECTIVE_IMMEDIATELY_FLAG,'N','Days after change order creation date','Y','Effective immediately')
	 RES_ITEM_EFFECTIVE_DATE
,changeOrderTypesE0.EFFECTIVITY_INCREMENT_DAYS RES_NUMBER_OF_DAYS
,(SELECT USERNAME
	FROM PER_USERS
	WHERE USER_GUID = changeOrderTypesE0.DEFAULT_ASSIGNEE_ID
	) RES_ASSIGNED_TO
,null RES_COPIED_FROM
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
where changeOrderTypesE0.TYPE_INTERNAL_NAME = 'NewItemRequest'
ORDER BY changeOrderTypesE0.TYPE_NAME