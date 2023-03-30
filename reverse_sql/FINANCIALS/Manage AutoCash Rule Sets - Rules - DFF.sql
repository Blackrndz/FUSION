/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date:  $:
* $HeadURL:  $:
* $Id: Manage FOB Lookup - Standard Lookup Type.sql  $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=222##RES##AR_AUTOCASH_RULES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT arAutocashSetE0.HIERARCHY_NAME RES_NAME
,arAutocashRulesE0.RULE_SEQUENCE RES_SEQUENCE
,(SELECT MEANING
	FROM AR_LOOKUPS
	WHERE LOOKUP_TYPE = 'AUTOCASH_RULE'
	AND LOOKUP_CODE = arAutocashRulesE0.AUTOCASH_RULE
	) RES_RULE
,arAutocashRulesE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,arAutocashRulesE0.ATTRIBUTE1 
,arAutocashRulesE0.ATTRIBUTE2
,arAutocashRulesE0.ATTRIBUTE3
,arAutocashRulesE0.ATTRIBUTE4
,arAutocashRulesE0.ATTRIBUTE5
,arAutocashRulesE0.ATTRIBUTE6
,arAutocashRulesE0.ATTRIBUTE7
,arAutocashRulesE0.ATTRIBUTE8
,arAutocashRulesE0.ATTRIBUTE9
,arAutocashRulesE0.ATTRIBUTE10
,arAutocashRulesE0.ATTRIBUTE11
,arAutocashRulesE0.ATTRIBUTE12
,arAutocashRulesE0.ATTRIBUTE13
,arAutocashRulesE0.ATTRIBUTE14
,arAutocashRulesE0.ATTRIBUTE15
,arAutocashRulesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,arAutocashRulesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,arAutocashRulesE0.CREATED_BY RSC_CREATED_BY
,arAutocashRulesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AR_AUTOCASH_HIERARCHIES arAutocashSetE0
,AR_AUTOCASH_RULES arAutocashRulesE0
WHERE arAutocashSetE0.AUTOCASH_HIERARCHY_ID = arAutocashRulesE0.AUTOCASH_HIERARCHY_ID
AND (arAutocashRulesE0.ATTRIBUTE_CATEGORY IS NOT NULL OR
arAutocashRulesE0.ATTRIBUTE1 IS NOT NULL OR 
arAutocashRulesE0.ATTRIBUTE2 IS NOT NULL OR 
arAutocashRulesE0.ATTRIBUTE3 IS NOT NULL OR 
arAutocashRulesE0.ATTRIBUTE4 IS NOT NULL OR 
arAutocashRulesE0.ATTRIBUTE5 IS NOT NULL OR 
arAutocashRulesE0.ATTRIBUTE6 IS NOT NULL OR 
arAutocashRulesE0.ATTRIBUTE7 IS NOT NULL OR 
arAutocashRulesE0.ATTRIBUTE8 IS NOT NULL OR 
arAutocashRulesE0.ATTRIBUTE9 IS NOT NULL OR 
arAutocashRulesE0.ATTRIBUTE10 IS NOT NULL OR 
arAutocashRulesE0.ATTRIBUTE11 IS NOT NULL OR 
arAutocashRulesE0.ATTRIBUTE12 IS NOT NULL OR 
arAutocashRulesE0.ATTRIBUTE13 IS NOT NULL OR 
arAutocashRulesE0.ATTRIBUTE14 IS NOT NULL OR 
arAutocashRulesE0.ATTRIBUTE15 IS NOT NULL)
ORDER BY arAutocashSetE0.HIERARCHY_NAME
,arAutocashRulesE0.RULE_SEQUENCE