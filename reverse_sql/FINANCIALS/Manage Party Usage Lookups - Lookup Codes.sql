/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-09-15  $:
 * $HeadURL: $:
 * $Id: Manage Party Usage Lookups - Lookup Codes.sql $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT LOOKUP_TYPE                                                              RES_LOOKUP_TYPE,
  LOOKUP_CODE                                                                   RES_LOOKUP_CODE,
  DISPLAY_SEQUENCE                                                              RES_DISPLAY_SEQUENCE,
  decode(ENABLED_FLAG,'Y','Yes','No')                                                                  RES_ENABLED,
  to_char(START_DATE_ACTIVE,'DD-Mon-YYYY')                                                             RES_START_DATE,
  to_char(END_DATE_ACTIVE,'DD-Mon-YYYY')                                                               RES_END_DATE,
  MEANING                                                                       RES_MEANING,
  DESCRIPTION                                                                   RES_DESCRIPTION,
  TAG                                                                           RES_TAG
,LookupEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LookupEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LookupEO.CREATED_BY RSC_CREATED_BY
,LookupEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,BoAttributeValuesEO.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
    
FROM FND_LOOKUP_VALUES_VL LookupEO 
      ,ASK_BO_ATTRIBUTE_VALUES BoAttributeValuesEO
WHERE    LookupEO.LOOKUP_TYPE   =   BoAttributeValuesEO.BO_ATTRIBUTE_VALUE
and BoAttributeValuesEO.BO_ATTRIBUTE_SHORT_NAME = 'lookupType' 
AND BoAttributeValuesEO.TASK_ID                 = 100000000003382 
ORDER BY LOOKUP_TYPE