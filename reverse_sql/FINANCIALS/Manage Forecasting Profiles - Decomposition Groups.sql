/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=MSC_FORECAST_PROFILES_VL
 
SELECT ForecastProfilesE0.PROFILE_NAME RES_PROFILE_NAME
,DECODE(ForecastProfileDecompGroupsE0.IS_SELECTED,'1','Yes','No') RES_ACTIVE
,DecompositionGroupE0.CF_DECOMP_GRP_NAME RES_DECOMPOSITION_GROUP
,DecompositionGroupE0.CF_DECOMP_GRP_DESC RES_DESCRIPTION
,ForecastProfileDecompGroupsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ForecastProfileDecompGroupsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ForecastProfileDecompGroupsE0.CREATED_BY RSC_CREATED_BY
,ForecastProfileDecompGroupsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_FORECAST_PROFILES_VL ForecastProfilesE0
,MSC_FCSTPRF_DECOMP_GRP ForecastProfileDecompGroupsE0
,MSC_CF_DECOMP_GROUPS_TL DecompositionGroupE0
WHERE ForecastProfilesE0.PROFILE_ID = ForecastProfileDecompGroupsE0.PROFILE_ID
AND ForecastProfileDecompGroupsE0.CF_DECOMP_GRP_ID = DecompositionGroupE0.CF_DECOMP_GRP_ID
AND DecompositionGroupE0.LANGUAGE = USERENV('LANG')
ORDER BY 1,3