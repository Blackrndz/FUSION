/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT lookupsE0.MEANING RES_NAME
,lookupsE0.DESCRIPTION RES_DESCRIPTION
,usagesE0.NUMBER_VALUE1 RES_TOTAL_THREADS
,usagesE0.NUMBER_VALUE2 RES_CHUNK_SIZE
,usagesE0.NUMBER_VALUE3 RES_MAXIMUM_ERRORS_ALLOWED
,usagesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,usagesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,usagesE0.CREATED_BY RSC_CREATED_BY
,usagesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_LOOKUP_VALUES lookupsE0
,CMP_LOOKUP_USAGES_VL usagesE0
WHERE lookupsE0.LANGUAGE = USERENV('LANG')
AND lookupsE0.LOOKUP_TYPE = 'CMP_BATCH_PROCESS'
AND lookupsE0.LOOKUP_TYPE = usagesE0.ATTRIBUTE_NAME
AND lookupsE0.LOOKUP_CODE = usagesE0.ATTRIBUTE_VALUE
ORDER BY lookupsE0.MEANING