/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=QP_PRICING_STRATEGIES_TL
-- RSC_PREREQUISITE_OBJECTS=QP_PRICING_STRATEGIES_ALL_B
-- RSC_PREREQUISITE_OBJECTS=QP_OVERRIDE_CURRENCIES

SELECT QpStrategiesTLE0.NAME RES_NAME
,QpOverrideCurrenciesE0.CURRENCY_CODE||' - '||(SELECT NAME FROM FND_CURRENCIES_VL WHERE CURRENCY_CODE = QpOverrideCurrenciesE0.CURRENCY_CODE) RES_CURRENCY
,TO_CHAR(QpOverrideCurrenciesE0.START_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_START_DATE
,TO_CHAR(QpOverrideCurrenciesE0.END_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_END_DATE
,QpOverrideCurrenciesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QpOverrideCurrenciesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QpOverrideCurrenciesE0.CREATED_BY RSC_CREATED_BY
,QpOverrideCurrenciesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,QpStrategiesBE0.ORG_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM QP_PRICING_STRATEGIES_TL QpStrategiesTLE0
,QP_PRICING_STRATEGIES_ALL_B QpStrategiesBE0
,QP_OVERRIDE_CURRENCIES QpOverrideCurrenciesE0
WHERE QpStrategiesTLE0.PRICING_STRATEGY_ID     = QpStrategiesBE0.PRICING_STRATEGY_ID
AND QpStrategiesTLE0.LANGUAGE                  = USERENV('LANG')
AND QpStrategiesTLE0.PRICING_STRATEGY_ID       = QpOverrideCurrenciesE0.PRICING_STRATEGY_ID
ORDER BY QpStrategiesTLE0.NAME
,RES_CURRENCY