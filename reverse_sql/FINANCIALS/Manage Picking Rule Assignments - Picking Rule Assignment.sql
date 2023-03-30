/* ****************************************************************************
 * $Revision:  $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-04-19 $:
 * $HeadURL:  $:
 * $Id: Manage Picking Rule Assignments - Picking Rule Assignment.sql $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=INV_TRANSACTION_REASONS_VL

SELECT
  MtlParametersAll.ORGANIZATION_CODE                                            		RES_ORGANIZATION,
  RuleSelectionCriterionEO.SEQUENCE_NUMBER                                      		RES_SEQUENCE,
  (select distinct InventoryRuleEO.RULE_NAME 
   FROM INV_RULES_VL InventoryRuleEO 
   where  InventoryRuleEO.RULE_ID  = RuleSelectionCriterionEO.RETURN_TYPE_ID 
   and InventoryRuleEO.TYPE_CODE     = RuleSelectionCriterionEO.RULE_TYPE_CODE 
  )                                                                             		RES_PICKING_RULE,
  InventoryRuleEO.DESCRIPTION                                                   		RES_DESCRIPTION,
  Decode(RuleSelectionCriterionEO.ENABLED_FLAG,'Y','Yes','No')                  		RES_ACTIVE,
  (select  LookupPEO.MEANING
  FROM FND_LOOKUPS LookupPEO
  WHERE LookupPEO.LOOKUP_TYPE = 'INV_RULES_DATE_TYPE'
  and   LookupPEO.LOOKUP_CODE = RuleSelectionCriterionEO.DATE_TYPE_CODE )       		RES_DATE_TYPE,
  (case 
       when RuleSelectionCriterionEO.DATE_TYPE_CODE  = '1' then  
          to_char(RuleSelectionCriterionEO.EFFECTIVE_FROM,'DD-Mon-YYYY')
       when RuleSelectionCriterionEO.DATE_TYPE_CODE  = '4' then  
          (select  LookupPEO.MEANING
          FROM FND_LOOKUPS LookupPEO
          WHERE LookupPEO.LOOKUP_TYPE = 'MONTH'
          and   LookupPEO.LOOKUP_CODE = RuleSelectionCriterionEO.DATE_TYPE_FROM)
       when RuleSelectionCriterionEO.DATE_TYPE_CODE  = '6' then  
         (select  ShiftEO.SHIFT_NAME 
          from ZMM_SR_SHIFTS_VL ShiftEO
          where  ShiftEO.SHIFT_ID  = RuleSelectionCriterionEO.DATE_TYPE_FROM)
       when RuleSelectionCriterionEO.DATE_TYPE_CODE  = '10' then  
         (select  LookupPEO.MEANING
         FROM FND_LOOKUPS LookupPEO
         WHERE LookupPEO.LOOKUP_TYPE = 'INV_RULES_DATE_TYPE_QUARTERS'
         and   LookupPEO.LOOKUP_CODE = RuleSelectionCriterionEO.DATE_TYPE_FROM)
    else
         to_char(RuleSelectionCriterionEO.DATE_TYPE_FROM)
	end) 																				RES_START_DATE
  
  ,(case 
       when RuleSelectionCriterionEO.DATE_TYPE_CODE  = '1' then  
          to_char(RuleSelectionCriterionEO.EFFECTIVE_TO,'DD-Mon-YYYY')
       when RuleSelectionCriterionEO.DATE_TYPE_CODE  = '4' then  
         (select  LookupPEO.MEANING
         FROM FND_LOOKUPS LookupPEO
         WHERE LookupPEO.LOOKUP_TYPE = 'MONTH'
         and   LookupPEO.LOOKUP_CODE = RuleSelectionCriterionEO.DATE_TYPE_TO)
       when RuleSelectionCriterionEO.DATE_TYPE_CODE  = '6' then  
          (select  ShiftEO.SHIFT_NAME 
          from ZMM_SR_SHIFTS_VL ShiftEO
          where  ShiftEO.SHIFT_ID  = RuleSelectionCriterionEO.DATE_TYPE_TO)
       when RuleSelectionCriterionEO.DATE_TYPE_CODE  = '10' then  
         (select  LookupPEO.MEANING
         FROM FND_LOOKUPS LookupPEO
         WHERE LookupPEO.LOOKUP_TYPE = 'INV_RULES_DATE_TYPE_QUARTERS'
         and   LookupPEO.LOOKUP_CODE = RuleSelectionCriterionEO.DATE_TYPE_TO)
      else
        to_char(RuleSelectionCriterionEO.DATE_TYPE_TO )
	end) 																				RES_END_DATE
  
 ,( select  PartyEO.PARTY_NAME 
    FROM HZ_PARTIES PartyEO 
    where PartyEO.PARTY_ID = RuleSelectionCriterionEO.CUSTOMER_ID          
  )                                                                             		RES_CUSTOMER_NAME,
  RuleSelectionCriterionEO.VENDOR_ID                                            		RES_CUSTOMER_REGISTRY_ID,
  (SELECT PARTY_NAME
	FROM HZ_PARTIES
	WHERE PARTY_ID = RuleSelectionCriterionEO.FREIGHT_CARRIER_ID)                       RES_CARRIER,
  ( select UOM_CLASS_TL 
   from  INV_UOM_CLASSES_VL UnitOfMeasureClassPEO
    where UnitOfMeasureClassPEO.UOM_CLASS = RuleSelectionCriterionEO.UOM_CLASS
  )                                                                             		RES_UOM_CLASS,
  (
   SELECT UNIT_OF_MEASURE
  FROM INV_UNITS_OF_MEASURE_VL UnitOfMeasurePEO
  WHERE UnitOfMeasurePEO.UOM_CODE =  RuleSelectionCriterionEO.UOM_CODE 
  )                                                                             		RES_UOM_NAME,
  RuleSelectionCriterionEO.FROM_SUBINVENTORY_NAME                               		RES_SOURCE_SUBINVENTORY,
  RuleSelectionCriterionEO.TO_SUBINVENTORY_NAME                                 		RES_DESTINATION_SUBINVENTORY,
  RuleSelectionCriterionEO.USER_ID                                               		RES_MOVEMENT_REQUESTS_CREATED_,
  RuleSelectionCriterionEO.INVENTORY_ITEM_ID                                    		RES_ITEM,
  CategoryPEO.CATEGORY_NAME                                                     		RES_CATEGORY_NAME,
  (select  LookupPEO.MEANING
   FROM FND_LOOKUPS LookupPEO
   WHERE LookupPEO.LOOKUP_TYPE = 'EGP_ITEM_TYPE'
   and   LookupPEO.LOOKUP_CODE = RuleSelectionCriterionEO.ITEM_TYPE
  )       																				RES_ITEM_TYPE,
  (  AbcAssignmentGroupPEO.assignment_group_name
  || NVL2(AbcClassPEO.abc_class_name, ' - '
  || AbcClassPEO.abc_class_name, '')  )                                        			RES_ABC_ASSIGNMENT_GROUP_AND_C,
  MtlTxnSourceTypes.TRANSACTION_SOURCE_TYPE_NAME                                		RES_TRANSACTION_SOURCE_TYPE,
  MtlTransactionTypes.TRANSACTION_TYPE_NAME                                    			RES_TRANSACTION_TYPE,
  (select  LookupPEO.MEANING
   FROM FND_LOOKUPS LookupPEO
   WHERE LookupPEO.LOOKUP_TYPE = 'INV_TRANSACTION_ACTION'
   and   LookupPEO.LOOKUP_CODE = RuleSelectionCriterionEO.TRANSACTION_ACTION_ID)        RES_TRANSACTION_ACTION,
  MtlTransactionReasons.REASON_NAME                                             		RES_REASON
,RuleSelectionCriterionEO.LAST_UPDATED_BY  as RSC_LAST_UPDATED_BY
,RuleSelectionCriterionEO.last_update_date  as RSC_LAST_UPDATE_DATE
,RuleSelectionCriterionEO.CREATED_BY  RSC_CREATED_BY
,RuleSelectionCriterionEO.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, MtlParametersAll.ORGANIZATION_ID 		RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID
   
FROM INV_SELECTION_CRITERIA_TXN RuleSelectionCriterionEO,
  INV_RULES_VL InventoryRuleEO,
  INV_TRANSACTION_REASONS_VL MtlTransactionReasons,
  INV_TRANSACTION_TYPES MtlTransactionTypes,
  INV_ABC_ASSIGNMENT_GROUPS AbcAssignmentGroupPEO,
  INV_UOM_CLASSES_VL UOMClassPEO,
  INV_ABC_CLASSES AbcClassPEO,
  INV_UNITS_OF_MEASURE_VL UnitOfMeasurePEO,
  INV_TXN_SOURCE_TYPES MtlTxnSourceTypes,
  INV_ORG_PARAMETERS_V MtlParametersAll,
  HZ_PARTIES PartyPEO,
  HZ_PARTIES CarrierPartyPEO,
  EGP_CATEGORIES_VL CategoryPEO
WHERE (((((((((((RuleSelectionCriterionEO.RETURN_TYPE_ID = InventoryRuleEO.RULE_ID)
AND (RuleSelectionCriterionEO.REASON_ID                  = MtlTransactionReasons.REASON_ID(+)))
AND (RuleSelectionCriterionEO.TRANSACTION_TYPE_ID        = MtlTransactionTypes.TRANSACTION_TYPE_ID(+)))
AND (RuleSelectionCriterionEO.ASSIGNMENT_GROUP_ID        = AbcAssignmentGroupPEO.ASSIGNMENT_GROUP_ID(+)))
AND (RuleSelectionCriterionEO.UOM_CLASS                  = UOMClassPEO.UOM_CLASS(+)))
AND (RuleSelectionCriterionEO.ABC_CLASS_ID               = AbcClassPEO.ABC_CLASS_ID(+)))
AND (RuleSelectionCriterionEO.UOM_CODE                   = UnitOfMeasurePEO.UOM_CODE(+)))
AND (RuleSelectionCriterionEO.TRANSACTION_SOURCE_TYPE_ID = MtlTxnSourceTypes.TRANSACTION_SOURCE_TYPE_ID(+)))
AND (RuleSelectionCriterionEO.FROM_ORGANIZATION_ID       = MtlParametersAll.ORGANIZATION_ID))
AND (RuleSelectionCriterionEO.CUSTOMER_ID                = PartyPEO.PARTY_ID(+)))
AND (RuleSelectionCriterionEO.FREIGHT_CARRIER_ID         = CarrierPartyPEO.PARTY_ID(+)))
AND (RuleSelectionCriterionEO.CATEGORY_ID                = CategoryPEO.CATEGORY_ID(+))
ORDER BY RuleSelectionCriterionEO.SEQUENCE_NUMBER