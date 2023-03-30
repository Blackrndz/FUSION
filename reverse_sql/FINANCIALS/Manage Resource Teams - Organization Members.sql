/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Resource%20Teams%20-%20Organization%20Members.sql $:
* $Id: Manage Resource Teams - Organization Members.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT DISTINCT
	(SELECT TEAM_NAME
	FROM JTF_RS_TEAMS_VL
	WHERE TEAM_ID = ResourceTeamMemberEO.TEAM_ID
	)                                        AS RES_TEAM_NAME
,OrganizationUnitPEO.NAME                 AS RES_ORGANIZATION
,OrgClassificationPEO.CLASSIFICATION_NAME AS RES_USAGE
,ResourceTeamMemberEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ResourceTeamMemberEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ResourceTeamMemberEO.CREATED_BY RSC_CREATED_BY
,ResourceTeamMemberEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,OrganizationUnitPEO.ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM JTF_RS_TEAM_MEMBERS ResourceTeamMemberEO
,HR_ALL_ORGANIZATION_UNITS_F_VL OrganizationUnitPEO
,HR_ORGANIZATION_V OrganizationDPEO
,HR_ORG_CLASSIFICATIONS_VL OrgClassificationPEO
WHERE ResourceTeamMemberEO.TEAM_RESOURCE_ID = OrganizationUnitPEO.ORGANIZATION_ID
AND OrganizationUnitPEO.ORGANIZATION_ID     = OrganizationDPEO.ORGANIZATION_ID
AND OrganizationDPEO.CLASSIFICATION_CODE    = OrgClassificationPEO.CLASSIFICATION_CODE
AND OrgClassificationPEO.INFORMATION1       = 'RESOURCE_ORG'
AND(sysdate BETWEEN OrganizationUnitPEO.EFFECTIVE_START_DATE AND OrganizationUnitPEO.EFFECTIVE_END_DATE)
ORDER BY RES_TEAM_NAME