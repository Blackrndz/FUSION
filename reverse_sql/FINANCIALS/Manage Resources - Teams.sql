/* ****************************************************************************
 * $Revision: 55017 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-06 17:03:01 +0700 (Fri, 06 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Contact%20Point%20Lookups%20-%20Standard%20Lookup%20Type.sql $:
 * $Id: Manage Contact Point Lookups - Standard Lookup Type.sql 55017 2016-05-06 10:03:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT PartyPEO.PARTY_NAME RES_RESOURCE_NAME
,PartyPEO.PARTY_NUMBER RES_REGISTRY_ID
,TeamRuleE0.TEAM_NAME RES_TEAM
,TO_CHAR(ResourceEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_EFFECTIVE_AS_OF_DATE
,TeamRuleE0.ROLE_NAME RES_ROLE
,DECODE(TeamRuleE0.MEMBER_FLAG,'Y','Yes','No') RES_MEMBER
,DECODE(TeamRuleE0.MANAGER_FLAG,'Y','Yes','No') RES_MANAGER
,DECODE(TeamRuleE0.ADMIN_FLAG,'Y','Yes','No') RES_ADMINISTRATOR
,DECODE(TeamRuleE0.LEAD_FLAG,'Y','Yes','No') RES_LEAD
,TO_CHAR(TeamRuleE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,DECODE(TO_CHAR(TeamRuleE0.END_DATE_ACTIVE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(TeamRuleE0.END_DATE_ACTIVE,
	'DD-Mon-YYYY')) RES_TO_DATE
,TeamRuleE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,TeamRuleE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,TeamRuleE0.CREATED_BY RSC_CREATED_BY
,TeamRuleE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM JTF_RS_RESOURCE_PROFILES ResourceEO
,HZ_PARTIES PartyPEO
,(SELECT PERSON_ID
	FROM PER_ALL_PEOPLE_F 
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	) PersonDPEONQ1
,HZ_ORIG_SYS_REFERENCES OrigSysRefPEONQ1
,(SELECT ResourceTeamMemberPEO.TEAM_MEMBER_ID
	,ResourceTeamEO.TEAM_NAME
	,ResourceTeamMemberPEO.TEAM_RESOURCE_ID
	,ResourceRoleAssignPEO.START_DATE_ACTIVE
	,ResourceRoleAssignPEO.ROLE_RELATE_ID
	,ResourceRoleAssignPEO.END_DATE_ACTIVE
	,ResourceRoleAssignPEO.DELETE_FLAG AS DELETE_FLAG1
	,ResourceRolePEO.ADMIN_FLAG
	,ResourceRolePEO.ROLE_ID
	,ResourceRolePEO.ROLE_NAME
	,ResourceRolePEO.LEAD_FLAG
	,ResourceRolePEO.MEMBER_FLAG
	,ResourceRolePEO.MANAGER_FLAG
	,ResourceRolePEO.ACTIVE_FLAG
	,ResourceRoleAssignPEO.LAST_UPDATED_BY
	,ResourceRoleAssignPEO.LAST_UPDATE_DATE
	,ResourceRoleAssignPEO.CREATED_BY
	,ResourceRoleAssignPEO.CREATION_DATE
	FROM JTF_RS_TEAM_MEMBERS ResourceTeamMemberPEO
	,JTF_RS_TEAMS_VL ResourceTeamEO
	,JTF_RS_ROLE_RELATIONS ResourceRoleAssignPEO
	,JTF_RS_ROLES_VL ResourceRolePEO
	WHERE ResourceTeamMemberPEO.TEAM_MEMBER_ID = ResourceRoleAssignPEO.ROLE_RESOURCE_ID
	AND ResourceTeamMemberPEO.TEAM_ID          = ResourceTeamEO.TEAM_ID
	AND('RS_TEAM_MEMBER')                      = ResourceRoleAssignPEO.ROLE_RESOURCE_TYPE
	AND ResourceRoleAssignPEO.ROLE_ID          = ResourceRolePEO.ROLE_ID
	) TeamRuleE0
WHERE ResourceEO.PARTY_ID                    = PartyPEO.PARTY_ID
AND ResourceEO.PARTY_ID                        = TeamRuleE0.TEAM_RESOURCE_ID
AND TO_CHAR(PersonDPEONQ1.PERSON_ID)         = OrigSysRefPEONQ1.ORIG_SYSTEM_REFERENCE
AND ResourceEO.PARTY_ID                      = OrigSysRefPEONQ1.OWNER_TABLE_ID
AND(SYSDATE BETWEEN TeamRuleE0.START_DATE_ACTIVE AND TeamRuleE0.END_DATE_ACTIVE)
ORDER BY RES_RESOURCE_NAME