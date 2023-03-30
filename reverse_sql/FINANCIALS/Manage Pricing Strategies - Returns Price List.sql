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
-- RSC_PREREQUISITE_OBJECTS=QP_PRICING_STRATEGY_DETAILS
 
SELECT QpStrategiesTLE0.NAME RES_NAME
,(SELECT NAME
	FROM QP_PRICE_LISTS_TL
	WHERE PRICE_LIST_ID = QpStrategyDetailE0.DETAIL_ENTITY_ID
	AND LANGUAGE        = USERENV('LANG')
	) RES_RETURNS_PRICE_LIST_NAME
,TO_CHAR(QpStrategyDetailE0.START_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_STRATEGY_ASSOCIATION_START
,TO_CHAR(QpStrategyDetailE0.END_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_STRATEGY_ASSOCIATION_END_D
,QpStrategyDetailE0.PRECEDENCE RES_STRATEGY_ASSOCIATION_PRECE
,QpStrategyDetailE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QpStrategyDetailE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QpStrategyDetailE0.CREATED_BY RSC_CREATED_BY
,QpStrategyDetailE0.CREATION_DATE RSC_CREATION_DATE
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
,QP_PRICING_STRATEGY_DETAILS QpStrategyDetailE0
WHERE QpStrategiesTLE0.PRICING_STRATEGY_ID     = QpStrategiesBE0.PRICING_STRATEGY_ID
AND QpStrategiesTLE0.LANGUAGE                  = USERENV('LANG')
AND QpStrategiesTLE0.PRICING_STRATEGY_ID       = QpStrategyDetailE0.PRICING_STRATEGY_ID
AND QpStrategyDetailE0.DETAIL_ENTITY_TYPE_CODE = 'RETURN_PRICE_LIST'
ORDER BY QpStrategiesTLE0.NAME
,RES_RETURNS_PRICE_LIST_NAME