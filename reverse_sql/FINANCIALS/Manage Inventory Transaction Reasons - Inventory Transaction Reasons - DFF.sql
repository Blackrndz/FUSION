/* ****************************************************************************
 * $Revision:  $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-04-19 $:
 * $HeadURL:  $:
 * $Id: Manage Inventory Transaction Reasons - Inventory Transaction Reasons.sql $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=INV_TRANSACTION_REASONS_VL

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=401##RES##INV_TRANSACTION_REASONS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields. 

SELECT InventoryTransactionReasonEO.REASON_NAME      					RES_NAME
--  TO_CHAR(InventoryTransactionReasonEO.ENABLE_DATE,'DD-Mon-YYYY')      	RES_START_DATE
,InventoryTransactionReasonEO.ATTRIBUTE_CATEGORY 						RES_CONTEXT_CODE
,InventoryTransactionReasonEO.ATTRIBUTE1
,InventoryTransactionReasonEO.ATTRIBUTE2
,InventoryTransactionReasonEO.ATTRIBUTE3
,InventoryTransactionReasonEO.ATTRIBUTE4
,InventoryTransactionReasonEO.ATTRIBUTE5
,InventoryTransactionReasonEO.ATTRIBUTE6
,InventoryTransactionReasonEO.ATTRIBUTE7
,InventoryTransactionReasonEO.ATTRIBUTE8
,InventoryTransactionReasonEO.ATTRIBUTE9
,InventoryTransactionReasonEO.ATTRIBUTE10
,InventoryTransactionReasonEO.ATTRIBUTE11
,InventoryTransactionReasonEO.ATTRIBUTE12
,InventoryTransactionReasonEO.ATTRIBUTE13
,InventoryTransactionReasonEO.ATTRIBUTE14
,InventoryTransactionReasonEO.ATTRIBUTE15
,InventoryTransactionReasonEO.LAST_UPDATED_BY  as RSC_LAST_UPDATED_BY
,InventoryTransactionReasonEO.last_update_date  as RSC_LAST_UPDATE_DATE
,InventoryTransactionReasonEO.CREATED_BY  RSC_CREATED_BY
,InventoryTransactionReasonEO.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID
   
FROM INV_TRANSACTION_REASONS_VL InventoryTransactionReasonEO
WHERE(InventoryTransactionReasonEO.ATTRIBUTE_CATEGORY IS NOT NULL
OR InventoryTransactionReasonEO.ATTRIBUTE1            IS NOT NULL
OR InventoryTransactionReasonEO.ATTRIBUTE2            IS NOT NULL
OR InventoryTransactionReasonEO.ATTRIBUTE3            IS NOT NULL
OR InventoryTransactionReasonEO.ATTRIBUTE4            IS NOT NULL
OR InventoryTransactionReasonEO.ATTRIBUTE5            IS NOT NULL
OR InventoryTransactionReasonEO.ATTRIBUTE6            IS NOT NULL
OR InventoryTransactionReasonEO.ATTRIBUTE7            IS NOT NULL
OR InventoryTransactionReasonEO.ATTRIBUTE8            IS NOT NULL
OR InventoryTransactionReasonEO.ATTRIBUTE9            IS NOT NULL
OR InventoryTransactionReasonEO.ATTRIBUTE10           IS NOT NULL
OR InventoryTransactionReasonEO.ATTRIBUTE11           IS NOT NULL
OR InventoryTransactionReasonEO.ATTRIBUTE12           IS NOT NULL
OR InventoryTransactionReasonEO.ATTRIBUTE13           IS NOT NULL
OR InventoryTransactionReasonEO.ATTRIBUTE14           IS NOT NULL
OR InventoryTransactionReasonEO.ATTRIBUTE15           IS NOT NULL)
ORDER BY InventoryTransactionReasonEO.REASON_NAME
