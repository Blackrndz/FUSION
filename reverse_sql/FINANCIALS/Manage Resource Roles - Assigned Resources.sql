/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Resource%20Roles%20-%20Assigned%20Resources.sql $:
 * $Id: Manage Resource Roles - Assigned Resources.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT ResourceRoleEO.ROLE_NAME RES_ROLE_NAME
,RESOURCEROLEEO.ROLE_CODE RES_ROLE_CODE
,PARTYPEO.PARTY_NAME RES_RESOURCE
,TO_CHAR(RESOURCEROLEASSIGNEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,decode(TO_CHAR(ResourceRoleAssignEO.END_DATE_ACTIVE,'DD-MM-YYYY'),'31-12-4712',null,TO_CHAR(ResourceRoleAssignEO.END_DATE_ACTIVE,'DD-Mon-YYYY')) RES_TO_DATE
,RESOURCEROLEASSIGNEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,RESOURCEROLEASSIGNEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,RESOURCEROLEASSIGNEO.CREATED_BY RSC_CREATED_BY
,RESOURCEROLEASSIGNEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM JTF_RS_ROLE_RELATIONS ResourceRoleAssignEO
,HZ_PARTIES PartyPEO
,JTF_RS_ROLES_VL ResourceRoleEO
WHERE(ResourceRoleAssignEO.ROLE_RESOURCE_ID = PartyPEO.PARTY_ID)
AND(ResourceRoleAssignEO.ROLE_ID            = ResourceRoleEO.ROLE_ID)
AND('RS_INDIVIDUAL'                         = ResourceRoleAssignEO.ROLE_RESOURCE_TYPE)
AND(((ResourceRoleAssignEO.START_DATE_ACTIVE <= sysdate)
AND(RESOURCEROLEASSIGNEO.END_DATE_ACTIVE   >= sysdate)
AND(RESOURCEROLEASSIGNEO.DELETE_FLAG       <> 'Y')))
order by ResourceRoleEO.ROLE_NAME,PARTYPEO.PARTY_NAME