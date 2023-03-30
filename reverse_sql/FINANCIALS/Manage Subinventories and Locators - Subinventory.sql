/* ****************************************************************************
 * $Revision: 50797 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-24 16:49:46 +0700 (Tue, 24 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Revenue%20Policies%20-%20Manage%20Revenue%20Policies.sql $:
 * $Id: Manage Revenue Policies - Manage Revenue Policies.sql 50797 2015-11-24 09:49:46Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT OrganizationUnitPEO.ORGANIZATION_CODE RES_ORGANIZATION
,MtlSecondaryInventories.SECONDARY_INVENTORY_NAME RES_SUBINVENTORY
,MtlSecondaryInventories.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(MtlSecondaryInventories.DISABLE_DATE,'DD-Mon-YYYY') RES_END_DATE
,MtlMaterialStatusesVl.STATUS_CODE RES_MATERIAL_STATUS
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'INV_SUB_TYPE'
	AND LOOKUP_CODE = MtlSecondaryInventories.QUANTITY_TRACKED
	) RES_SUBINVENTORY_TYPE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'INV_SUB_LOCATOR_CONTROL'
	AND LOOKUP_CODE = MtlSecondaryInventories.LOCATOR_TYPE
	) RES_LOCATOR_CONTROL
,DECODE(MtlSecondaryInventories.location_id,NULL,NULL,(SELECT location_code
	FROM HR_LOCATIONS_ALL_F_VL loc
	WHERE MtlSecondaryInventories.location_id = loc.location_id
	AND TRUNC(sysdate) BETWEEN loc.effective_start_date AND loc.effective_end_date
	)) RES_LOCATION
,(SELECT NAME
	FROM FND_KF_STR_INSTANCES_VL
	WHERE STRUCTURE_INSTANCE_NUMBER = MtlSecondaryInventories.STRUCTURE_INSTANCE_NUMBER
	)RES_STRUCTUREINSTANCENUMBER
,DefLocMaterialStatus.STATUS_CODE RES_DEFAULT_LOCATOR_STATUS
,MtlSecondaryInventories.PICKING_ORDER RES_PICKING_ORDER
,DECODE(MtlSecondaryInventories.ASSET_INVENTORY,1,'Yes','No') RES_ASSET_SUBINVENTORY
,DECODE(MtlSecondaryInventories.DEPRECIABLE_FLAG,1,'Yes','No') RES_DEPRECIABLE
,DECODE(MtlSecondaryInventories.QUANTITY_TRACKED,1,'Yes','No') RES_QUANTITY_TRACKED
,MtlSecondaryInventories.PREPROCESSING_LEAD_TIME RES_PREPROCESSING
,MtlSecondaryInventories.PROCESSING_LEAD_TIME RES_PROCESSING
,MtlSecondaryInventories.POSTPROCESSING_LEAD_TIME RES_POSTPROCESSING
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'INV_SOURCE_TYPES'
	AND LOOKUP_CODE = MtlSecondaryInventories.SOURCE_TYPE
	)  RES_TYPE
,(SELECT NAME 
	FROM HR_ALL_ORGANIZATION_UNITS_F_VL
	WHERE ORGANIZATION_ID = MtlSecondaryInventories.SOURCE_ORGANIZATION_ID
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	) RES_SOURCING_ORGANIZATION
,MtlSecondaryInventories.SOURCE_SUBINVENTORY RES_SOURCING_SUBINVENTORY
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
,INV_MATERIAL_STATUSES_VL MtlMaterialStatusesVl
,INV_MATERIAL_STATUSES_VL DefLocMaterialStatus
WHERE MtlSecondaryInventories.ORGANIZATION_ID = OrganizationUnitPEO.ORGANIZATION_ID
AND MtlSecondaryInventories.STATUS_ID           = MtlMaterialStatusesVl.STATUS_ID
AND MtlSecondaryInventories.DEFAULT_LOC_STATUS_ID = DefLocMaterialStatus.STATUS_ID(+)
ORDER BY MtlSecondaryInventories.DISABLE_DATE ASC NULLS FIRST
,MtlSecondaryInventories.SECONDARY_INVENTORY_NAME ASC