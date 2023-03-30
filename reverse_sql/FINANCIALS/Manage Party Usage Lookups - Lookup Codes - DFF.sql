/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-09-18  $:
 * $HeadURL: $:
 * $Id: Manage Party Usage Lookups - Lookup Codes - DFF.sql $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=0##RES##FND_LOOKUP_VALUES_B
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields. 

SELECT LOOKUP_TYPE                                                              RES_LOOKUP_TYPE,
  LOOKUP_CODE                                                                   RES_LOOKUP_CODE,
 LookupEO.ATTRIBUTE_CATEGORY 												RES_CONTEXT_CODE
,LookupEO.ATTRIBUTE1
,LookupEO.ATTRIBUTE2
,LookupEO.ATTRIBUTE3
,LookupEO.ATTRIBUTE4
,LookupEO.ATTRIBUTE5
,LookupEO.ATTRIBUTE6
,LookupEO.ATTRIBUTE7
,LookupEO.ATTRIBUTE8
,LookupEO.ATTRIBUTE9
,LookupEO.ATTRIBUTE10
,LookupEO.ATTRIBUTE11
,LookupEO.ATTRIBUTE12
,LookupEO.ATTRIBUTE13
,LookupEO.ATTRIBUTE14
,LookupEO.ATTRIBUTE15
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
AND (LookupEO.ATTRIBUTE_CATEGORY IS NOT NULL
	OR LookupEO.ATTRIBUTE1            IS NOT NULL
	OR LookupEO.ATTRIBUTE2            IS NOT NULL
	OR LookupEO.ATTRIBUTE3            IS NOT NULL
	OR LookupEO.ATTRIBUTE4            IS NOT NULL
	OR LookupEO.ATTRIBUTE5            IS NOT NULL
	OR LookupEO.ATTRIBUTE6            IS NOT NULL
	OR LookupEO.ATTRIBUTE7            IS NOT NULL
	OR LookupEO.ATTRIBUTE8            IS NOT NULL
	OR LookupEO.ATTRIBUTE9            IS NOT NULL
	OR LookupEO.ATTRIBUTE10           IS NOT NULL
	OR LookupEO.ATTRIBUTE11           IS NOT NULL
	OR LookupEO.ATTRIBUTE12           IS NOT NULL
	OR LookupEO.ATTRIBUTE13           IS NOT NULL
	OR LookupEO.ATTRIBUTE14           IS NOT NULL
	OR LookupEO.ATTRIBUTE15           IS NOT NULL

)
ORDER BY LOOKUP_TYPE