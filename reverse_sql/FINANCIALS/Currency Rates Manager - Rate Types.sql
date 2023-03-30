/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Currency%20Rates%20Manager%20-%20Rate%20Types.sql $:
 * $Id: Currency Rates Manager - Rate Types.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select DAILYCONVERSIONTYPEEO.USER_CONVERSION_TYPE RES_NAME
,DAILYCONVERSIONTYPEEO.DESCRIPTION RES_DESCRIPTION
,null RES_DEFAULT_RATE_TYPE
,DECODE(DAILYCONVERSIONTYPEEO.ENFORCE_INVERSE_RATE_FLAG,'Y','Yes','No') RES_ENFORCE_INVERSE_RELATIONSH
,DECODE(DAILYCONVERSIONTYPEEO.ENABLE_CROSS_RATE_FLAG,'Y','Yes','No') RES_ENABLE_CROSS_RATES
,DECODE(DAILYCONVERSIONTYPEEO.USER_OVERRIDE_CROSS_RATE_FLAG,'Y','Yes','No') RES_ALLOW_CROSS_RATES_OVERRIDE
,nvl2(DailyConversionTypeEO.PIVOT_CURRENCY_CODE,(CURRENCYEO.CURRENCY_CODE ||' - ' ||CURRENCYEO.name),DailyConversionTypeEO.PIVOT_CURRENCY_CODE) RES_CROSS_RATE_PIVOT_CURRENCY
,DailyConversionTypeEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,DailyConversionTypeEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,DailyConversionTypeEO.CREATED_BY  RSC_CREATED_BY
,DailyConversionTypeEO.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, DAILYCONVERSIONTYPEEO.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from GL_DAILY_CONVERSION_TYPES DAILYCONVERSIONTYPEEO 
,FUSION.FND_CURRENCIES_VL CURRENCYEO
where  DailyConversionTypeEO.PIVOT_CURRENCY_CODE  = CURRENCYEO.CURRENCY_CODE(+)
ORDER BY USER_CONVERSION_TYPE