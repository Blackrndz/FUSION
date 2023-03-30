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
-- DFF_LOGIC_TO_APPLY=401##RES##INV_ITEM_LOCATIONS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- syntax: APPLICATION_ID##RES##KFF_CODE
-- KFF_LOGIC_TO_APPLY=401##RES##MTLL
-- KFF_PREFIX_ALIAS=RES_LOCATOR
-- KFF_COLUMN_NAME=SEGMENT
 
SELECT OrganizationUnitPEO.ORGANIZATION_CODE RES_ORGANIZATION
,MtlSecondaryInventories.SECONDARY_INVENTORY_NAME RES_SUBINVENTORY
,MtlItemLocations.SEGMENT1 RES_LOCATOR_1
,MtlItemLocations.SEGMENT2 RES_LOCATOR_2
,MtlItemLocations.SEGMENT3 RES_LOCATOR_3
,MtlItemLocations.SEGMENT4 RES_LOCATOR_4
,MtlItemLocations.SEGMENT5 RES_LOCATOR_5
,MtlItemLocations.SEGMENT6 RES_LOCATOR_6
,MtlItemLocations.SEGMENT7 RES_LOCATOR_7
,MtlItemLocations.SEGMENT8 RES_LOCATOR_8
,MtlItemLocations.SEGMENT9 RES_LOCATOR_9
,MtlItemLocations.SEGMENT10 RES_LOCATOR_10
,MtlItemLocations.SEGMENT11 RES_LOCATOR_11
,MtlItemLocations.SEGMENT12 RES_LOCATOR_12
,MtlItemLocations.SEGMENT13 RES_LOCATOR_13
,MtlItemLocations.SEGMENT14 RES_LOCATOR_14
,MtlItemLocations.SEGMENT15 RES_LOCATOR_15
,MtlItemLocations.SEGMENT16 RES_LOCATOR_16

,MtlItemLocations.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,MtlItemLocations.ATTRIBUTE1
,MtlItemLocations.ATTRIBUTE2
,MtlItemLocations.ATTRIBUTE3
,MtlItemLocations.ATTRIBUTE4
,MtlItemLocations.ATTRIBUTE5
,MtlItemLocations.ATTRIBUTE6
,MtlItemLocations.ATTRIBUTE7
,MtlItemLocations.ATTRIBUTE8
,MtlItemLocations.ATTRIBUTE9
,MtlItemLocations.ATTRIBUTE10
,MtlItemLocations.ATTRIBUTE11
,MtlItemLocations.ATTRIBUTE12
,MtlItemLocations.ATTRIBUTE13
,MtlItemLocations.ATTRIBUTE14
,MtlItemLocations.ATTRIBUTE15
,MtlItemLocations.STRUCTURE_INSTANCE_NUMBER RSC_EXTRA_COLUMN1
,MtlItemLocations.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,MtlItemLocations.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,MtlItemLocations.CREATED_BY RSC_CREATED_BY
,MtlItemLocations.CREATION_DATE RSC_CREATION_DATE
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
,INV_ITEM_LOCATIONS MtlItemLocations
WHERE MtlSecondaryInventories.ORGANIZATION_ID = OrganizationUnitPEO.ORGANIZATION_ID
AND MtlItemLocations.ORGANIZATION_ID = MtlSecondaryInventories.ORGANIZATION_ID
AND MtlItemLocations.SUBINVENTORY_ID = MtlSecondaryInventories.SUBINVENTORY_ID
AND (MtlItemLocations.ATTRIBUTE_CATEGORY IS NOT NULL
OR MtlItemLocations.ATTRIBUTE1            IS NOT NULL
OR MtlItemLocations.ATTRIBUTE2            IS NOT NULL
OR MtlItemLocations.ATTRIBUTE3            IS NOT NULL
OR MtlItemLocations.ATTRIBUTE4            IS NOT NULL
OR MtlItemLocations.ATTRIBUTE5            IS NOT NULL
OR MtlItemLocations.ATTRIBUTE6            IS NOT NULL
OR MtlItemLocations.ATTRIBUTE7            IS NOT NULL
OR MtlItemLocations.ATTRIBUTE8            IS NOT NULL
OR MtlItemLocations.ATTRIBUTE9            IS NOT NULL
OR MtlItemLocations.ATTRIBUTE10           IS NOT NULL
OR MtlItemLocations.ATTRIBUTE11           IS NOT NULL
OR MtlItemLocations.ATTRIBUTE12           IS NOT NULL
OR MtlItemLocations.ATTRIBUTE13           IS NOT NULL
OR MtlItemLocations.ATTRIBUTE14           IS NOT NULL
OR MtlItemLocations.ATTRIBUTE15           IS NOT NULL)
ORDER BY MtlSecondaryInventories.DISABLE_DATE ASC NULLS FIRST
,MtlSecondaryInventories.SECONDARY_INVENTORY_NAME ASC