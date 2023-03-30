/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Resource%20Teams%20-%20Resource%20Members.sql $:
* $Id: Manage Resource Teams - Resource Members.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT TeamsE0.TEAM_NAME AS RES_TEAM_NAME
,partiesE0.PARTY_NAME AS RES_RESOURCE
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

FROM JTF_RS_TEAMS_VL TeamsE0
,JTF_RS_TEAM_MEMBERS ResourceTeamMemberPEO
,HZ_PARTIES partiesE0
WHERE TeamsE0.TEAM_ID = ResourceTeamMemberPEO.TEAM_ID
AND ResourceTeamMemberPEO.TEAM_RESOURCE_ID = partiesE0.PARTY_ID
ORDER BY TeamsE0.TEAM_NAME