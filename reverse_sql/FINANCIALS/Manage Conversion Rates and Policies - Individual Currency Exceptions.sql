/* ****************************************************************************
 * $Revision: 54592 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-04-21 17:22:38 +0700 (Thu, 21 Apr 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Lookup%20Codes%20-%20Financials%20Generic%20Lookup%20Type.sql $:
 * $Id: Manage Tax Lookup Codes - Financials Generic Lookup Type.sql 54592 2016-04-21 10:22:38Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT BusinessUnitPEO.BU_NAME RES_BUSINESS_UNIT
,CurrenciesE0.CURRENCY_CODE || ' - ' || CurrenciesE0.NAME RES_CURRENCY
,DECODE(ExchangeRateToleranceEO.DFLT_EXCHANGE_RATE_FLAG,'Y','Yes','No') RES_DEFAULT_CONVERSION_RATE
,ExchangeRateToleranceEO.WARNING_TOLERANCE RES_WARNING_TOLERANCE_PERCENTA
,DECODE(ExchangeRateToleranceEO.DISP_WARNING_TO_USER,'Y','Yes','No') RES_DISPLAY_WARNING_TO_USER
,ExchangeRateToleranceEO.ERROR_TOLERANCE RES_ERROR_TOLERANCE_PERCENTAGE
,ExchangeRateToleranceEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExchangeRateToleranceEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExchangeRateToleranceEO.CREATED_BY RSC_CREATED_BY
,ExchangeRateToleranceEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,BusinessUnitPEO.BU_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_EXCH_RATE_OPTIONS ExchangeRateOptionEO
,FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
,EXM_EXCH_RATE_TOLERANCES ExchangeRateToleranceEO
,FND_CURRENCIES_VL CurrenciesE0
WHERE BusinessUnitPEO.BU_ID               = ExchangeRateOptionEO.ORG_ID(+)
AND ExchangeRateOptionEO.EXCHANGE_RATE_ID = ExchangeRateToleranceEO.EXCHANGE_RATE_ID
AND ExchangeRateToleranceEO.CURRENCY_CODE = CurrenciesE0.CURRENCY_CODE
AND BusinessUnitPEO.STATUS                = 'A'
AND BusinessUnitPEO.BU_ID                <> - 1
ORDER BY BusinessUnitPEO.BU_NAME
,ExchangeRateToleranceEO.CURRENCY_CODE