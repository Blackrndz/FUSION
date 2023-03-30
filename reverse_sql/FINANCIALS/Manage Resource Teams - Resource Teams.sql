/* ****************************************************************************
* $Revision: 55523 $:
* $Author: dhara.pithadiya $:
* $Date: 2016-05-30 10:55:30 +0700 (Mon, 30 May 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Resource%20Teams%20-%20Manage%20Resource%20Teams.sql $:
* $Id: Manage Resource Teams - Manage Resource Teams.sql 55523 2016-05-30 03:55:30Z dhara.pithadiya $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT ResourceTeamTranslationEO.TEAM_NAME                          AS RES_TEAM_NAME
,ResourceTeamTranslationEO.TEAM_NUMBER                              AS RES_TEAM_NUMBER
,ResourceTeamTranslationEO.TEAM_DESC                                AS RES_TEAM_DESCRIPTION
,TO_CHAR(ResourceTeamTranslationEO.START_DATE_ACTIVE,'DD-Mon-YYYY') AS RES_FROM_DATE
,TO_CHAR(ResourceTeamTranslationEO.END_DATE_ACTIVE,'DD-Mon-YYYY')   AS RES_TO_DATE
,ResourceTeamTranslationEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ResourceTeamTranslationEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ResourceTeamTranslationEO.CREATED_BY RSC_CREATED_BY
,ResourceTeamTranslationEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM JTF_RS_TEAMS_VL ResourceTeamTranslationEO
ORDER BY RES_TEAM_NAME