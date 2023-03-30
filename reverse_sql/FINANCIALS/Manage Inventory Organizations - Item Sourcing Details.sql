/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Inventory%20Organizations%20-%20Item%20Sourcing%20Details.sql $:
 * $Id: Manage Inventory Organizations - Item Sourcing Details.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=INV_TRANSACTION_REASONS_TL 
-- RSC_PREREQUISITE_OBJECTS=INV_ORG_PARAMETERS

SELECT OrganizationParameterEO.ORGANIZATION_CODE AS RES_ORGANIZATION
,OrgClassificationPEO.CLASSIFICATION_NAME AS RES_CLASSIFICATION
,(SELECT RULE_NAME
	FROM INV_RULES_VL
	WHERE RULE_ID = OrganizationParameterEO.DEFAULT_PICKING_RULE_ID
	)                                                   AS RES_PICKING_RULE
,OrganizationParameterEO.DEFAULT_SUBINV_ORDER_VALUE  AS RES_SUBINVENTORY_ORDER
,OrganizationParameterEO.DEFAULT_LOCATOR_ORDER_VALUE AS RES_LOCATOR_ORDER
,(SELECT REASON_NAME
	FROM INV_TRANSACTION_REASONS_TL
	WHERE REASON_ID = OrganizationParameterEO.PICK_QTY_DEFAULT_REASON_ID
	AND LANGUAGE = USERENV('LANG')
	) AS RES_QUANTITY_EXCEPTION_REASON
,(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'INV_YES_NO_NUMERIC'
	AND lookup_code   = NVL(OrganizationParameterEO.MO_PICK_CONFIRM_REQUIRED,2)
	) AS RES_PICK_CONFIRMATION_REQUIRED
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = NVL(OrganizationParameterEO.OVPK_TRANSFER_ORDERS_ENABLED,'N')
	) AS RES_OVERPICKING_FOR_MOVEMENT_R
,DECODE(OrganizationParameterEO.SPECIAL_HNDLNG_OVRPK_FLAG,'Y','Yes','No') RES_ALLOW_OVERPICKING_FOR_SPEC
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = NVL(OrganizationParameterEO.PRE_FILL_PICKED_QTY,'N')
	) AS RES_AUTOMATICALLY_POPULATE_PIC
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = NVL(OrganizationParameterEO.CAPTURE_PICKING_EXCEPTION,'N')
	) AS RES_CAPTURE_PICKING_EXCEPTIONS
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE lookup_type = 'INV_SOURCE_TYPES'
	AND lookup_code   = OrganizationParameterEO.SOURCE_TYPE
	) AS RES_TYPE
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = NVL(OrganizationParameterEO.PURCHASING_BY_REVISION,'N')
	) AS RES_PURCHASING_BY_REVISION
,OrganizationParameterEO.ORGANIZATION_CODE RES_ITEM_SOURCING_DETAILS_ORGA
,OrganizationParameterEO.SOURCE_SUBINVENTORY RES_SUBINVENTORY
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = NVL(OrganizationParameterEO.DISTRIBUTED_ORGANIZATION_FLAG,'N')
	) AS RES_LOGISTICS_SERVICES_ORGANIZ

,OrganizationParameterEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,OrganizationParameterEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,OrganizationParameterEO.CREATED_BY RSC_CREATED_BY
,OrganizationParameterEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,OrganizationParameterEO.LEGAL_ENTITY_ID RSC_LEGAL_ENTITY_ID
,OrganizationParameterEO.ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_ORG_PARAMETERS OrganizationParameterEO
,HR_ORGANIZATION_V InventoryOrganizationEO
,HR_ORG_CLASSIFICATIONS_VL OrgClassificationPEO
WHERE InventoryOrganizationEO.ORGANIZATION_ID   = OrganizationParameterEO.ORGANIZATION_ID
AND InventoryOrganizationEO.CLASSIFICATION_CODE = 'INV'
AND OrganizationParameterEO.INVENTORY_FLAG      = 'Y'
AND InventoryOrganizationEO.CLASSIFICATION_CODE  = OrgClassificationPEO.CLASSIFICATION_CODE
AND SYSDATE BETWEEN InventoryOrganizationEO.EFFECTIVE_START_DATE AND InventoryOrganizationEO.EFFECTIVE_END_DATE
ORDER BY InventoryOrganizationEO.name