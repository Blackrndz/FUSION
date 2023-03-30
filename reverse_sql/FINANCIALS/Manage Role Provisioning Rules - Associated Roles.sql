/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=PER_ROLE_MAPPINGS

SELECT rolesE0.MAPPING_NAME RES_MAPPING_NAME
,RolePEO.Role_NAME RES_ROLE_NAME
,RolePEO.ROLE_COMMON_NAME RES_ROLE_CODE
,'' RES_DELEGATION_ALLOWED
,DECODE(mapRolesE0.REQUESTABLE_FLAG,'Y','Yes','No') RES_REQUESTABLE
,DECODE(mapRolesE0.SELF_REQUESTABLE_FLAG,'Y','Yes','No') RES_SELF_REQUESTABLE
,DECODE(mapRolesE0.USE_FOR_AUTO_PROVISIONING_FLAG,'Y','Yes','No') RES_AUTOPROVISION
,mapRolesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,mapRolesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,mapRolesE0.CREATED_BY  RSC_CREATED_BY
,mapRolesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,rolesE0.BUSINESS_UNIT_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM PER_ROLE_MAPPINGS rolesE0
,PER_ROLE_MAPPING_ROLES mapRolesE0
,PER_ROLES_DN_VL RolePEO
WHERE rolesE0.ROLE_MAPPING_ID = mapRolesE0.ROLE_MAPPING_ID
AND mapRolesE0.ROLE_ID = RolePEO.ROLE_ID
ORDER BY rolesE0.MAPPING_NAME