/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT patternsE0.PATTERN_NAME RES_NAME
,patternsE0.PATTERN_DESC RES_DESCRIPTION
,patternsE0.LENGTH_DAYS_NUM RES_LENGTH_IN_DAYS
,patternsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,patternsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,patternsE0.CREATED_BY RSC_CREATED_BY
,patternsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZMM_SR_PATTERNS_VL patternsE0
WHERE patternsE0.PATTERN_TYPE_CODE = 'ELAPSED'
ORDER BY patternsE0.PATTERN_NAME