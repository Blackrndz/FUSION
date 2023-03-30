/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Reference%20Data%20Sets%20-%20Manage%20Reference%20Data%20Sets.sql $:
 * $Id: Manage Reference Data Sets - Manage Reference Data Sets.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT SetIdSetsEO.SET_CODE AS RES_SET_CODE
,SetIdSetsEO.SET_NAME AS RES_SET_NAME
,SetIdSetsEO.DESCRIPTION AS RES_DESCRIPTION
,SetIdSetsEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,SetIdSetsEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,SetIdSetsEO.CREATED_BY  RSC_CREATED_BY
,SetIdSetsEO.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM FND_SETID_SETS_VL SetIdSetsEO
ORDER BY SetIdSetsEO.SET_CODE