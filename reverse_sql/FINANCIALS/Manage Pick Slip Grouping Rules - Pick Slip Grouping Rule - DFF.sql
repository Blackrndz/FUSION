/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=INV_PICK_GROUPING_RULES_VL

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=401##RES##INV_PICK_GROUPING_RULES
-- DFF_ATTRIBUTES=ATTRIBUTE,SEGMENT_ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields. 

SELECT InvPickGroupingRules.PICK_GROUPING_RULE_NAME RES_NAME
,InvPickGroupingRules.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,InvPickGroupingRules.ATTRIBUTE1
,InvPickGroupingRules.ATTRIBUTE2
,InvPickGroupingRules.ATTRIBUTE3
,InvPickGroupingRules.ATTRIBUTE4
,InvPickGroupingRules.ATTRIBUTE5
,InvPickGroupingRules.ATTRIBUTE6
,InvPickGroupingRules.ATTRIBUTE7
,InvPickGroupingRules.ATTRIBUTE8
,InvPickGroupingRules.ATTRIBUTE9
,InvPickGroupingRules.ATTRIBUTE10
,InvPickGroupingRules.ATTRIBUTE11
,InvPickGroupingRules.ATTRIBUTE12
,InvPickGroupingRules.ATTRIBUTE13
,InvPickGroupingRules.ATTRIBUTE14
,InvPickGroupingRules.ATTRIBUTE15
,InvPickGroupingRules.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,InvPickGroupingRules.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,InvPickGroupingRules.CREATED_BY RSC_CREATED_BY
,InvPickGroupingRules.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_PICK_GROUPING_RULES_VL InvPickGroupingRules
WHERE(InvPickGroupingRules.ATTRIBUTE_CATEGORY IS NOT NULL
OR InvPickGroupingRules.ATTRIBUTE1            IS NOT NULL
OR InvPickGroupingRules.ATTRIBUTE2            IS NOT NULL
OR InvPickGroupingRules.ATTRIBUTE3            IS NOT NULL
OR InvPickGroupingRules.ATTRIBUTE4            IS NOT NULL
OR InvPickGroupingRules.ATTRIBUTE5            IS NOT NULL
OR InvPickGroupingRules.ATTRIBUTE6            IS NOT NULL
OR InvPickGroupingRules.ATTRIBUTE7            IS NOT NULL
OR InvPickGroupingRules.ATTRIBUTE8            IS NOT NULL
OR InvPickGroupingRules.ATTRIBUTE9            IS NOT NULL
OR InvPickGroupingRules.ATTRIBUTE10           IS NOT NULL
OR InvPickGroupingRules.ATTRIBUTE11           IS NOT NULL
OR InvPickGroupingRules.ATTRIBUTE12           IS NOT NULL
OR InvPickGroupingRules.ATTRIBUTE13           IS NOT NULL
OR InvPickGroupingRules.ATTRIBUTE14           IS NOT NULL
OR InvPickGroupingRules.ATTRIBUTE15           IS NOT NULL)
ORDER BY InvPickGroupingRules.PICK_GROUPING_RULE_NAME