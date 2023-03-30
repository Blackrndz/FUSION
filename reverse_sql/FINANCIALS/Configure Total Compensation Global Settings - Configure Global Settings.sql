/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT MAX_STATEMENT_PERIODS RES_MAXIMUM_NUMBER_OF_STATEMEN
,EST_STOCK_PRICE RES_DEFAULT_STOCK_PRICE
,(SELECT NAME
    FROM FND_CURRENCIES_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND CURRENCY_CODE = EST_STOCK_PRICE_CURRENCY_CD
    ) RES_CURRENCY
,DECODE(WATCH_STATEMENT_FLAG,'Y','Yes','No') RES_SHOW_STATEMENT_AVAILABILIT
,WATCH_STATEMENT_DAYS RES_DAYS_ON_WATCHLIST
,LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CREATED_BY RSC_CREATED_BY
,CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_PROFILE_VALUES