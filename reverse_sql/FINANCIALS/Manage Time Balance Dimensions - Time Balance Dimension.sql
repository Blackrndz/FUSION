/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=PAY_BALANCE_DIMENSIONS

SELECT dimensionsE0.BASE_DIMENSION_NAME RES_NAME
,dimensionsE0.DESCRIPTION RES_DESCRIPTION
,DECODE(dimensionsE0.DIMENSION_LEVEL,'PER','Person','ASG','Assignment') RES_DIMENSION_LEVEL
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_HWM_PERIOD_TYPES'
    AND LOOKUP_CODE = dimensionsE0.PERIOD_TYPE
    ) RES_PERIOD_TYPE
,(SELECT NAME
    FROM HWM_RP_TM_PERIODS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND REPEATING_TM_PERIOD_ID = dimensionsE0.TIME_PERIOD_ID
    ) RES_TIME_PERIOD
,dimensionsE0.BASE_DB_ITEM_SUFFIX RES_DIMENSION_SUFFIX
,dimensionsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,dimensionsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,dimensionsE0.CREATED_BY RSC_CREATED_BY
,dimensionsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PAY_BALANCE_DIMENSIONS dimensionsE0
WHERE dimensionsE0.APPLICATION_ID = 10446
ORDER BY dimensionsE0.BASE_DIMENSION_NAME