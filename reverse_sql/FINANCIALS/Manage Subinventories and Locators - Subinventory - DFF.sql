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
-- DFF_LOGIC_TO_APPLY=401##RES##INV_SECONDARY_INVENTORIES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.
 
SELECT OrganizationUnitPEO.ORGANIZATION_CODE RES_ORGANIZATION
,MtlSecondaryInventories.SECONDARY_INVENTORY_NAME RES_SUBINVENTORY
,MtlSecondaryInventories.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,MtlSecondaryInventories.ATTRIBUTE1
,MtlSecondaryInventories.ATTRIBUTE2
,MtlSecondaryInventories.ATTRIBUTE3
,MtlSecondaryInventories.ATTRIBUTE4
,MtlSecondaryInventories.ATTRIBUTE5
,MtlSecondaryInventories.ATTRIBUTE6
,MtlSecondaryInventories.ATTRIBUTE7
,MtlSecondaryInventories.ATTRIBUTE8
,MtlSecondaryInventories.ATTRIBUTE9
,MtlSecondaryInventories.ATTRIBUTE10
,MtlSecondaryInventories.ATTRIBUTE11
,MtlSecondaryInventories.ATTRIBUTE12
,MtlSecondaryInventories.ATTRIBUTE13
,MtlSecondaryInventories.ATTRIBUTE14
,MtlSecondaryInventories.ATTRIBUTE15
,MtlSecondaryInventories.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,MtlSecondaryInventories.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,MtlSecondaryInventories.CREATED_BY RSC_CREATED_BY
,MtlSecondaryInventories.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,MtlSecondaryInventories.ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_SECONDARY_INVENTORIES MtlSecondaryInventories
,INV_ORGANIZATION_DEFINITIONS_V OrganizationUnitPEO
WHERE MtlSecondaryInventories.ORGANIZATION_ID = OrganizationUnitPEO.ORGANIZATION_ID
AND (MtlSecondaryInventories.ATTRIBUTE_CATEGORY IS NOT NULL
OR MtlSecondaryInventories.ATTRIBUTE1            IS NOT NULL
OR MtlSecondaryInventories.ATTRIBUTE2            IS NOT NULL
OR MtlSecondaryInventories.ATTRIBUTE3            IS NOT NULL
OR MtlSecondaryInventories.ATTRIBUTE4            IS NOT NULL
OR MtlSecondaryInventories.ATTRIBUTE5            IS NOT NULL
OR MtlSecondaryInventories.ATTRIBUTE6            IS NOT NULL
OR MtlSecondaryInventories.ATTRIBUTE7            IS NOT NULL
OR MtlSecondaryInventories.ATTRIBUTE8            IS NOT NULL
OR MtlSecondaryInventories.ATTRIBUTE9            IS NOT NULL
OR MtlSecondaryInventories.ATTRIBUTE10           IS NOT NULL
OR MtlSecondaryInventories.ATTRIBUTE11           IS NOT NULL
OR MtlSecondaryInventories.ATTRIBUTE12           IS NOT NULL
OR MtlSecondaryInventories.ATTRIBUTE13           IS NOT NULL
OR MtlSecondaryInventories.ATTRIBUTE14           IS NOT NULL
OR MtlSecondaryInventories.ATTRIBUTE15           IS NOT NULL)
ORDER BY MtlSecondaryInventories.DISABLE_DATE ASC NULLS FIRST
,MtlSecondaryInventories.SECONDARY_INVENTORY_NAME ASC