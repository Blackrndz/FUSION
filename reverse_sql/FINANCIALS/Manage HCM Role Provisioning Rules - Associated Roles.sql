/* ****************************************************************************
* $Revision: 49069 $:
* $Author: Pisan.Jariyasettachok $:
* $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
* $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */



SELECT  
  RoleMappingEO.MAPPING_NAME         AS RES_MAPPING_NAME,
  RolePEO.Role_NAME                                AS RES_ROLE_NAME,
  RolePEO.ROLE_COMMON_NAME RES_ROLE_CODE,
  DECODE(RolePEO.DELEGATION_ALLOWED, 'N', 'No', 'Y', 'Yes')                       AS RES_DELEGATION_ALLOWED,
  DECODE(RoleMappingRoleEO.REQUESTABLE_FLAG, 'N', 'No', 'Yes')               AS RES_REQUESTABLE,
  DECODE(RoleMappingRoleEO.SELF_REQUESTABLE_FLAG, 'N', 'No', 'Yes')          AS RES_SELF_REQUESTABLE,
  DECODE(RoleMappingRoleEO.USE_FOR_AUTO_PROVISIONING_FLAG, 'N', 'No', 'Yes') AS RES_AUTOPROVISION
  ,RoleMappingRoleEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,RoleMappingRoleEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,RoleMappingRoleEO.CREATED_BY  RSC_CREATED_BY
  ,RoleMappingRoleEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,RoleMappingRoleEO.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_ROLE_MAPPINGS RoleMappingEO,
  PER_ROLE_MAPPING_ROLES RoleMappingRoleEO,
  PER_ROLES_DN_VL RolePEO
WHERE RoleMappingEO.ROLE_MAPPING_ID        = RoleMappingRoleEO.ROLE_MAPPING_ID(+)
AND RoleMappingRoleEO.role_id              = RolePEO.role_id(+)
ORDER BY RoleMappingEO.mapping_name