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

SELECT InventoryTransactionReasonEO.REASON_NAME      RES_NAME,
  InventoryTransactionReasonEO.DESCRIPTION      RES_DESCRIPTION,
  TO_CHAR(InventoryTransactionReasonEO.ENABLE_DATE,'DD-Mon-YYYY')      RES_START_DATE,
  TO_CHAR(InventoryTransactionReasonEO.DISABLE_DATE ,'DD-Mon-YYYY')      RES_END_DATE,
  ( select  LookupPEO.MEANING 
    FROM FND_LOOKUPS LookupPEO
    WHERE LookupPEO.LOOKUP_TYPE = 'INV_REASON_TYPES' 
    and  LookupPEO.LOOKUP_CODE = InventoryTransactionReasonEO.REASON_TYPE    
  )RES_REASON_TYPE,
 ( select  LookupPEO.MEANING 
   FROM FND_LOOKUPS LookupPEO
   WHERE LookupPEO.LOOKUP_TYPE = 'INV_REASON_CONTEXT' 
   and  LookupPEO.LOOKUP_CODE =InventoryTransactionReasonEO.REASON_CONTEXT_CODE   
 )RES_REASON_CONTEXT,
  InventoryTransactionReasonEO.LAST_UPDATED_BY  as RSC_LAST_UPDATED_BY
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
ORDER BY InventoryTransactionReasonEO.REASON_NAME
