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
-- DFF_LOGIC_TO_APPLY=222##RES##AR_AUTOCASH_HIERARCHIES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT arAutocashSetE0.HIERARCHY_NAME RES_NAME
,arAutocashSetE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,arAutocashSetE0.ATTRIBUTE1 
,arAutocashSetE0.ATTRIBUTE2
,arAutocashSetE0.ATTRIBUTE3
,arAutocashSetE0.ATTRIBUTE4
,arAutocashSetE0.ATTRIBUTE5
,arAutocashSetE0.ATTRIBUTE6
,arAutocashSetE0.ATTRIBUTE7
,arAutocashSetE0.ATTRIBUTE8
,arAutocashSetE0.ATTRIBUTE9
,arAutocashSetE0.ATTRIBUTE10
,arAutocashSetE0.ATTRIBUTE11
,arAutocashSetE0.ATTRIBUTE12
,arAutocashSetE0.ATTRIBUTE13
,arAutocashSetE0.ATTRIBUTE14
,arAutocashSetE0.ATTRIBUTE15
,arAutocashSetE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,arAutocashSetE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,arAutocashSetE0.CREATED_BY RSC_CREATED_BY
,arAutocashSetE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AR_AUTOCASH_HIERARCHIES arAutocashSetE0
WHERE (arAutocashSetE0.ATTRIBUTE_CATEGORY IS NOT NULL OR
arAutocashSetE0.ATTRIBUTE1 IS NOT NULL OR 
arAutocashSetE0.ATTRIBUTE2 IS NOT NULL OR 
arAutocashSetE0.ATTRIBUTE3 IS NOT NULL OR 
arAutocashSetE0.ATTRIBUTE4 IS NOT NULL OR 
arAutocashSetE0.ATTRIBUTE5 IS NOT NULL OR 
arAutocashSetE0.ATTRIBUTE6 IS NOT NULL OR 
arAutocashSetE0.ATTRIBUTE7 IS NOT NULL OR 
arAutocashSetE0.ATTRIBUTE8 IS NOT NULL OR 
arAutocashSetE0.ATTRIBUTE9 IS NOT NULL OR 
arAutocashSetE0.ATTRIBUTE10 IS NOT NULL OR 
arAutocashSetE0.ATTRIBUTE11 IS NOT NULL OR 
arAutocashSetE0.ATTRIBUTE12 IS NOT NULL OR 
arAutocashSetE0.ATTRIBUTE13 IS NOT NULL OR 
arAutocashSetE0.ATTRIBUTE14 IS NOT NULL OR 
arAutocashSetE0.ATTRIBUTE15 IS NOT NULL)
ORDER BY arAutocashSetE0.HIERARCHY_NAME