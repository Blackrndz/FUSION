/* ****************************************************************************
* $Revision: 55523 $:
* $Author: dhara.pithadiya $:
* $Date: 2016-05-30 10:55:30 +0700 (Mon, 30 May 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Resource%20Teams%20-%20Resource%20Members.sql $:
* $Id: Manage Resource Teams - Resource Members.sql 55523 2016-05-30 03:55:30Z dhara.pithadiya $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT
	(SELECT TEAM_NAME
	FROM JTF_RS_TEAMS_VL
	WHERE TEAM_ID = ResourceTeamMemberPEO.TEAM_ID
	) AS RES_TEAM_NAME
,(SELECT PARTY_NAME
	FROM HZ_PARTIES
	WHERE PARTY_ID = ResourceTeamMemberPEO.TEAM_RESOURCE_ID
	) AS RES_RESOURCE
,ResourceRolePEO.ROLE_NAME AS RES_ROLE_NAME
,(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ResourceRolePEO.MEMBER_FLAG
	) AS RES_MEMBER
,(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ResourceRolePEO.MANAGER_FLAG
	) AS RES_MANAGER
,(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ResourceRolePEO.ADMIN_FLAG
	) AS RES_ADMINISTRATOR
,(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ResourceRolePEO.LEAD_FLAG
	) AS RES_LEAD
,TO_CHAR(ResourceRoleAssignPEO.START_DATE_ACTIVE,'DD-Mon-YYYY') AS RES_FROM_DATE
,TO_CHAR(ResourceRoleAssignPEO.END_DATE_ACTIVE,'DD-Mon-YYYY')   AS RES_TO_DATE
,ResourceTeamMemberPEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ResourceTeamMemberPEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ResourceTeamMemberPEO.CREATED_BY RSC_CREATED_BY
,ResourceTeamMemberPEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM JTF_RS_TEAM_MEMBERS ResourceTeamMemberPEO
,JTF_RS_ROLE_RELATIONS ResourceRoleAssignPEO
,JTF_RS_ROLES_VL ResourceRolePEO
WHERE ResourceTeamMemberPEO.TEAM_MEMBER_ID = ResourceRoleAssignPEO.ROLE_RESOURCE_ID
AND('RS_TEAM_MEMBER')                      = ResourceRoleAssignPEO.ROLE_RESOURCE_TYPE
AND ResourceRoleAssignPEO.ROLE_ID          = ResourceRolePEO.ROLE_ID
ORDER BY RES_TEAM_NAME