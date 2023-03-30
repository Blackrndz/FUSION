/* ****************************************************************************
 * $Revision: 55675 $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2016-12-23  $:
 * $HeadURL:$:
 * $Id: Manage Contact Lookups - Lookup Codes - DFF.sql$:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=0##RES##FND_LOOKUP_VALUES_B
-- DFF_ATTRIBUTES=ATTRIBUTE,GLOBAL_ATTRIBUTE,GLOBAL_ATTRIBUTE_NUMBER,GLOBAL_ATTRIBUTE_DATE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.
 
SELECT fndlookups.LOOKUP_TYPE RES_LOOKUP_TYPE
, LookupValue.LOOKUP_CODE RES_LOOKUP_CODE
,LookupValue.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,LookupValue.ATTRIBUTE1 
,LookupValue.ATTRIBUTE2
,LookupValue.ATTRIBUTE3
,LookupValue.ATTRIBUTE4
,LookupValue.ATTRIBUTE5
,LookupValue.ATTRIBUTE6
,LookupValue.ATTRIBUTE7
,LookupValue.ATTRIBUTE8
,LookupValue.ATTRIBUTE9
,LookupValue.ATTRIBUTE10
,LookupValue.ATTRIBUTE11
,LookupValue.ATTRIBUTE12
,LookupValue.ATTRIBUTE13
,LookupValue.ATTRIBUTE14
,LookupValue.ATTRIBUTE15
,LookupValue.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LookupValue.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LookupValue.CREATED_BY RSC_CREATED_BY
,LookupValue.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_LOOKUP_TYPES_VL fndlookups
,Fusion.FND_LOOKUP_VALUES_VL LookupValue
WHERE fndlookups.LOOKUP_TYPE = LookupValue.LOOKUP_TYPE
AND fndlookups.LOOKUP_TYPE  IN
	(SELECT BoAttributeValuesEO.BO_ATTRIBUTE_VALUE
	FROM ASK_BO_ATTRIBUTE_VALUES BOATTRIBUTEVALUESEO
	WHERE(BOATTRIBUTEVALUESEO.BO_ATTRIBUTE_SHORT_NAME = 'lookupType'
	AND BoAttributeValuesEO.TASK_ID                   =
		(SELECT task_id
		FROM ASK_TASKS_VL
		WHERE TASK_SHORT_NAME = 'HZ_MANAGE_RESOURCE_NOTE_TYPE'
		))
	)
AND fndlookups.VIEW_APPLICATION_ID  = 0
AND LookupValue.VIEW_APPLICATION_ID = 0
AND LookupValue.SET_ID              = 0
AND (LookupValue.ATTRIBUTE_CATEGORY IS NOT NULL OR
LookupValue.ATTRIBUTE1 IS NOT NULL OR 
LookupValue.ATTRIBUTE2 IS NOT NULL OR 
LookupValue.ATTRIBUTE3 IS NOT NULL OR 
LookupValue.ATTRIBUTE4 IS NOT NULL OR 
LookupValue.ATTRIBUTE5 IS NOT NULL OR 
LookupValue.ATTRIBUTE6 IS NOT NULL OR 
LookupValue.ATTRIBUTE7 IS NOT NULL OR 
LookupValue.ATTRIBUTE8 IS NOT NULL OR 
LookupValue.ATTRIBUTE9 IS NOT NULL OR 
LookupValue.ATTRIBUTE10 IS NOT NULL OR 
LookupValue.ATTRIBUTE11 IS NOT NULL OR 
LookupValue.ATTRIBUTE12 IS NOT NULL OR 
LookupValue.ATTRIBUTE13 IS NOT NULL OR 
LookupValue.ATTRIBUTE14 IS NOT NULL OR 
LookupValue.ATTRIBUTE15 IS NOT NULL)
Order By Fndlookups.Lookup_Type
,LookupValue.DISPLAY_SEQUENCE