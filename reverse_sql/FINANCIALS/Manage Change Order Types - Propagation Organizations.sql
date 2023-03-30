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
,(SELECT ORGANIZATION_CODE
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = propagationOrgsE0.ORGANIZATION_ID
	) RES_ORGANIZATIONS
,orgsE0.NAME RES_ORGANIZATION_NAMES
,propagationOrgsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,propagationOrgsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,propagationOrgsE0.CREATED_BY  RSC_CREATED_BY
,propagationOrgsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,propagationOrgsE0.ORGANIZATION_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM EGO_CHANGE_TYPES_VL changeOrderTypesE0
,EGO_CHANGE_TYPE_ORGANIZATIONS propagationOrgsE0
,HR_ORGANIZATION_V orgsE0
WHERE changeOrderTypesE0.COPIED_FROM IS NOT NULL
AND changeOrderTypesE0.CHANGE_TYPE_ID = propagationOrgsE0.CHANGE_TYPE_ID
AND propagationOrgsE0.ORGANIZATION_ID = orgsE0.ORGANIZATION_ID
ORDER BY changeOrderTypesE0.TYPE_NAME
,orgsE0.ORGANIZATION_CODE