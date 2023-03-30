/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=PAY_BALANCE_TYPES_VL

SELECT timeBalDefsE0.BALANCE_NAME RES_NAME
,timeBalDefsE0.REPORTING_NAME RES_REPORTING_NAME
,timeBalDefsE0.DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_HWM_UOM'
    AND LOOKUP_CODE = timeBalDefsE0.BALANCE_UOM
    ) RES_ENTRY_UNIT_OF_MEASURE
,dimensionsE0.BASE_DIMENSION_NAME RES_BALANCE_DIMENSION
,timeBalDefsE0.BALANCE_NAME||dimensionsE0.BASE_DB_ITEM_SUFFIX RES_DIMENSION_NAME
,dimensionsE0.BASE_DB_ITEM_SUFFIX RES_DIMENSION_SUFFIX
,'' RES_EFFECTIVE_START_DATE -->> Alway show current date
,timeBalDefsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,timeBalDefsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,timeBalDefsE0.CREATED_BY RSC_CREATED_BY
,timeBalDefsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,timeBalDefsE0.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PAY_BALANCE_TYPES_VL timeBalDefsE0
,PAY_DEFINED_BALANCES balDimensionsE0
,PAY_BALANCE_DIMENSIONS dimensionsE0
WHERE timeBalDefsE0.APPLICATION_ID = 10446
AND timeBalDefsE0.BALANCE_TYPE_ID = balDimensionsE0.BALANCE_TYPE_ID
AND balDimensionsE0.BALANCE_DIMENSION_ID = dimensionsE0.BALANCE_DIMENSION_ID
ORDER BY timeBalDefsE0.BALANCE_NAME