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
,(SELECT CATEGORY_NAME
	FROM MSC_ENGINE_PARAMS_CAT_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND CATEGORY_ID = ForcastCateE0.CATEGORY_ID
	) RES_CATEGORY_NAME
,ForecastParamsE0.PARAMETER_NAME RES_PARAMETER_NAME
,ForecastParamsE0.PARAMETER_DEF_VALUE RES_DEFAULT
,ForcastCateE0.PARAM_VALUE RES_VALUE
,ForecastParamsE0.PARAMETER_DESCRIPTION RES_DESCRIPTION
,ForecastProfilesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ForecastProfilesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ForecastProfilesE0.CREATED_BY RSC_CREATED_BY
,ForecastProfilesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_FORECAST_PROFILES_VL ForecastProfilesE0
,MSC_FCSTPRF_ENG_PARAMS ForcastCateE0
,MSC_ENGINE_PARAMS_VL ForecastParamsE0
WHERE ForecastProfilesE0.PROFILE_ID = ForcastCateE0.PROFILE_ID 
AND ForcastCateE0.PARAMETER_ID = ForecastParamsE0.PARAMETER_ID
ORDER BY 1,2,3