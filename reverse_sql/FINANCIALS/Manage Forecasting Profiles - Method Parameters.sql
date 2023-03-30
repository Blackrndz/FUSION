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
,ForcastMedthodsE0.METHOD_NAME RES_NAME
,ForcastMedthodsParametersTLE0.PARAM_NAME RES_PARAMETER_NAME
,ForcastMedthodsParametersTLE0.PARAM_DESCRIPTION RES_DESCRIPTION
,(SELECT (CASE
		WHEN PARAM_VALUE_LOOKUP_TYPE IS NOT NULL THEN
			(SELECT MEANING
				FROM FND_LOOKUPS
				WHERE LOOKUP_TYPE = PARAM_VALUE_LOOKUP_TYPE
				AND LOOKUP_CODE = ForcastMedthodsParametersE0.PARAM_VALUE)
		ELSE
			ForcastMedthodsParametersE0.PARAM_VALUE
		END)
	FROM MSC_FCST_METHOD_PARAMS_ASSIGN
	WHERE METHOD_ID = ForcastMedthodsParametersE0.METHOD_ID
	AND PARAM_ID = ForcastMedthodsParametersE0.PARAM_ID
	AND DEF_PARAM_VALUE = ForcastMedthodsParametersE0.PARAM_VALUE
	) RES_VALUE
,ForcastMedthodsParametersE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ForcastMedthodsParametersE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ForcastMedthodsParametersE0.CREATED_BY RSC_CREATED_BY
,ForcastMedthodsParametersE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_FORECAST_PROFILES_VL ForecastProfilesE0
,MSC_FCSTPRF_METHODS ForcastProfileMedthodsE0
,MSC_FCST_METHODS_TL ForcastMedthodsE0
,MSC_FCSTPRF_METHOD_PARAMS ForcastMedthodsParametersE0
,MSC_FCST_METHOD_PARAMS_TL ForcastMedthodsParametersTLE0
WHERE ForecastProfilesE0.PROFILE_ID = ForcastProfileMedthodsE0.PROFILE_ID
AND ForcastProfileMedthodsE0.METHOD_ID = ForcastMedthodsE0.METHOD_ID
AND ForcastMedthodsE0.LANGUAGE = USERENV('LANG')
AND ForcastProfileMedthodsE0.PROFILE_ID = ForcastMedthodsParametersE0.PROFILE_ID
AND ForcastProfileMedthodsE0.METHOD_ID = ForcastMedthodsParametersE0.METHOD_ID
AND ForcastMedthodsParametersE0.PARAM_ID = ForcastMedthodsParametersTLE0.PARAM_ID
AND ForcastMedthodsParametersTLE0.LANGUAGE = USERENV('LANG')
ORDER BY 1,2,3