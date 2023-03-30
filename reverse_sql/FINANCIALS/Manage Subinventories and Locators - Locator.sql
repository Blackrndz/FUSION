/* ****************************************************************************
 * $Revision: 50797 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-24 16:49:46 +0700 (Tue, 24 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Revenue%20Policies%20-%20Manage%20Revenue%20Policies.sql $:
 * $Id: Manage Revenue Policies - Manage Revenue Policies.sql 50797 2015-11-24 09:49:46Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##KFF_CODE
-- KFF_LOGIC_TO_APPLY=401##RES##MTLL
-- KFF_PREFIX_ALIAS=RES_LOCATOR
-- KFF_COLUMN_NAME=SEGMENT

-- IMPORTANT: 
-- - the order of segments must start from 1 to ...

SELECT OrganizationUnitPEO.ORGANIZATION_CODE RES_ORGANIZATION
,MtlSecondaryInventories.SECONDARY_INVENTORY_NAME RES_SUBINVENTORY
,(SELECT NAME
	FROM FND_KF_STR_INSTANCES_VL
	WHERE STRUCTURE_INSTANCE_NUMBER = MtlSecondaryInventories.STRUCTURE_INSTANCE_NUMBER
	)RES_LOCATOR_STRUCTURE
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
,MtlItemLocations.SEGMENT14 RES_LOCATOR_15
,MtlItemLocations.SEGMENT14 RES_LOCATOR_16

,MtlItemLocations.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(MtlItemLocations.DISABLE_DATE,'DD-Mon-YYYY') RES_END_DATE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'INV_LOCATOR_TYPES'
	AND LOOKUP_CODE = MtlItemLocations.INVENTORY_LOCATION_TYPE
	) RES_TYPE
,MtlItemLocations.PICKING_ORDER RES_PICKING_ORDER
,(SELECT STATUS_CODE
	FROM INV_MATERIAL_STATUSES_VL
	WHERE STATUS_ID = MtlSecondaryInventories.STATUS_ID
	) RES_MATERIAL_STATUS
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
ORDER BY MtlSecondaryInventories.DISABLE_DATE ASC NULLS FIRST
,MtlSecondaryInventories.SECONDARY_INVENTORY_NAME ASC