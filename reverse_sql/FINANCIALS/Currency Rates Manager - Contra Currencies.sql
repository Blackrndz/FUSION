/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Currency%20Rates%20Manager%20-%20Contra%20Currencies.sql $:
 * $Id: Currency Rates Manager - Contra Currencies.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select DAILYCONVERSIONTYPEEO.USER_CONVERSION_TYPE RES_NAME
,CURRENCYEO.CURRENCY_CODE ||' - ' ||CURRENCYEO.name RES_CURRENCY
,CROSSRATERULE.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,CROSSRATERULE.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,CROSSRATERULE.CREATED_BY  RSC_CREATED_BY
,CROSSRATERULE.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from GL_DAILY_CONVERSION_TYPES DAILYCONVERSIONTYPEEO 
,GL_CROSS_RATE_RULE_DTLS CROSSRATERULE
,FUSION.FND_CURRENCIES_VL CURRENCYEO
where DAILYCONVERSIONTYPEEO.CONVERSION_TYPE = CROSSRATERULE.CONVERSION_TYPE
and CROSSRATERULE.from_currency = CROSSRATERULE.to_currency
and CROSSRATERULE.FROM_CURRENCY  = CURRENCYEO.CURRENCY_CODE
ORDER BY USER_CONVERSION_TYPE,CROSSRATERULE.FROM_CURRENCY