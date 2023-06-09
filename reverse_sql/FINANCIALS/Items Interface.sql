/* ****************************************************************************
 * $Revision: 79774 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-12-06 16:47:44 +0700 (Tue, 06 Dec 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Items%20Interface.sql $:
 * $Id: Items Interface.sql 79774 2022-12-06 09:47:44Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EGP_SYSTEM_ITEMS_B
-- REPLACE_HTML_KEYWORD = RES_FORMATTED_DESCRIPTION
-- STRICTLY_BATCH_SEQ = RES_ITEM_NUMBER,RSC_ORGANIZATION_ID

SELECT /*+ PARALLEL(8) */ 'CREATE' RES_TRANSACTION_TYPE
,'' RES_BATCH_ID
,'' RES_BATCH_NUMBER
,ItemsE0.ITEM_NUMBER RES_ITEM_NUMBER
,ItemsE0.OUTSIDE_PROCESS_SERVICE_FLAG RES_OUTSIDE_PROCESSING_SERVICE
,(SELECT ORGANIZATION_CODE
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = ItemsE0.ORGANIZATION_ID
	) RES_ORGANIZATION_CODE
,(SELECT DESCRIPTION
	FROM EGP_SYSTEM_ITEMS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND INVENTORY_ITEM_ID = ItemsE0.INVENTORY_ITEM_ID
	AND ORGANIZATION_ID = ItemsE0.ORGANIZATION_ID
	) RES_DESCRIPTION
,(SELECT TEMPLATE_NAME
	FROM EGP_SYSTEM_ITEMS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND INVENTORY_ITEM_ID = ItemsE0.INVENTORY_ITEM_ID
	AND ORGANIZATION_ID = ItemsE0.ORGANIZATION_ID
	) RES_TEMPLATE_NAME
,'' RES_SOURCE_SYSTEM_CODE
,'' RES_SOURCE_SYSTEM_REFERENCE
,'' RES_SOURCE_SYSTEM_REFERENCE_DE
,(SELECT ITEM_CLASS_NAME 
	FROM EGP_ITEM_CLASSES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND ITEM_CLASS_ID = ItemsE0.ITEM_CATALOG_GROUP_ID 
	) RES_ITEM_CLASS_NAME
,(SELECT UNIT_OF_MEASURE 
	FROM INV_UNITS_OF_MEASURE_VL
	WHERE UOM_CODE = ItemsE0.PRIMARY_UOM_CODE
	) RES_PRIMARY_UNIT_OF_MEASURE
,(SELECT PHASE_NAME 
	FROM EGP_PHASES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND PHASE_CODE = ItemsE0.CURRENT_PHASE_CODE
	) RES_LIFECYCLE_PHASE
,ItemsE0.INVENTORY_ITEM_STATUS_CODE RES_ITEM_STATUS
,'' RES_NEW_ITEM_CLASS_NAME
,ItemsE0.ASSET_TRACKED_FLAG RES_ASSET_TRACKED
,ItemsE0.ALLOW_MAINTENANCE_ASSET_FLAG RES_ALLOW_MAINTENANCE_ASSET
,ItemsE0.ENABLE_GENEALOGY_TRACKING_FLAG RES_ENABLE_GENEALOGY_FLAG
,ItemsE0.ASSET_CLASS RES_ASSET_CLASS
,ItemsE0.EAM_ITEM_TYPE RES_ASSET_ITEM_TYPE
,ItemsE0.EAM_ACTIVITY_TYPE_CODE RES_ACTIVITY_TYPE
,ItemsE0.EAM_ACTIVITY_CAUSE_CODE RES_ACTIVITY_CAUSE
,ItemsE0.EAM_ACT_NOTIFICATION_FLAG RES_ACTIVITY_NOTIFICATION_REQU
,ItemsE0.EAM_ACT_SHUTDOWN_STATUS RES_SHUTDOWN_TYPE
,ItemsE0.EAM_ACTIVITY_SOURCE_CODE RES_ACTIVITY_SOURCE
,ItemsE0.COSTING_ENABLED_FLAG RES_COSTING_ENABLED
,ItemsE0.STD_LOT_SIZE RES_STANDARD_LOT_SIZE
,ItemsE0.INVENTORY_ASSET_FLAG RES_INVENTORY_ASSET_VALUE
,ItemsE0.DEFAULT_INCLUDE_IN_ROLLUP_FLAG RES_INCLUDE_IN_ROLLUP
,ItemsE0.ORDER_COST RES_ORDER_COST
,ItemsE0.VMI_MINIMUM_DAYS RES_MINIMUM_DAYS_OF_SUPPLY
,ItemsE0.VMI_FIXED_ORDER_QUANTITY RES_FIXED_QUANTITY
,ItemsE0.MINIMUM_ORDER_QUANTITY RES_MINIMUM_ORDER
,ItemsE0.ASN_AUTOEXPIRE_FLAG RES_AUTOMATICALLY_EXPIRE_ASN
,ItemsE0.CARRYING_COST RES_CARRYING_COST_PERCENTAGE
,ItemsE0.CONSIGNED_FLAG RES_CONSIGNED
,ItemsE0.FIXED_DAYS_SUPPLY RES_FIXED_DAYS_SUPPLY
,ItemsE0.FIXED_LOT_MULTIPLIER RES_FIXED_LOT_SIZE_MULTIPLIER
,ItemsE0.FIXED_ORDER_QUANTITY RES_FIXED_ORDER_QUANTITY
,ItemsE0.FORECAST_HORIZON RES_WINDOW_DAYS
,ItemsE0.INVENTORY_PLANNING_CODE RES_INVENTORY_PLANNING_METHOD
,ItemsE0.SAFETY_STOCK_PLANNING_METHOD RES_SAFETY_STOCK_PLANNING_METH
,(CASE
	WHEN ItemsE0.SAFETY_STOCK_PLANNING_METHOD = 'NON_MRP_PLANNED' AND ItemsE0.DEMAND_PERIOD IS NULL THEN
		'#NULL'
	ELSE
		TO_CHAR(ItemsE0.DEMAND_PERIOD)
	END) RES_DEMAND_PERIOD
,(CASE
	WHEN ItemsE0.SAFETY_STOCK_PLANNING_METHOD = 'NON_MRP_PLANNED' AND ItemsE0.DAYS_OF_COVER IS NULL THEN
		'#NULL'
	ELSE
		TO_CHAR(ItemsE0.DAYS_OF_COVER)
	END) RES_DAYS_OF_COVER
,ItemsE0.MIN_MINMAX_QUANTITY RES_MINIMUM_MIN_MAX_QUANTITY
,ItemsE0.MAX_MINMAX_QUANTITY RES_MAXIMUM_MIN_MAX_QUANTITY
,ItemsE0.MINIMUM_ORDER_QUANTITY RES_MINIMUM_ORDER_QUANTITY
,ItemsE0.MAXIMUM_ORDER_QUANTITY RES_MAXIMUM_ORDER_QUANTITY
,ItemsE0.PLANNER_CODE RES_PLANNER
,ItemsE0.PLANNING_MAKE_BUY_CODE RES_MAKE_OR_BUY
,ItemsE0.SOURCE_SUBINVENTORY RES_SOURCE_SUBINVENTORY
,ItemsE0.SOURCE_TYPE RES_REPLENISHMENT_SOURCE_TYPE
,ItemsE0.SO_AUTHORIZATION_FLAG RES_RELEASE_AUTHORIZATION_REQU
,ItemsE0.SUBCONTRACTING_COMPONENT RES_SUBCONTRACTING_COMPONENT
,ItemsE0.VMI_FORECAST_TYPE RES_FORECAST_TYPE
,ItemsE0.VMI_MAXIMUM_UNITS RES_MAXIMUM_ORDER
,ItemsE0.VMI_MAXIMUM_DAYS RES_MAXIMUM_DAYS_OF_SUPPLY
,(SELECT ORGANIZATION_CODE
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = ItemsE0.SOURCE_ORGANIZATION_ID
	) RES_SOURCE_ORGANIZATION
,ItemsE0.RESTRICT_SUBINVENTORIES_CODE RES_SUBINVENTORY_RESTRICTIONS
,ItemsE0.RESTRICT_LOCATORS_CODE RES_RESTRICT_LOCATORS
,ItemsE0.CHILD_LOT_FLAG RES_CHILD_LOT_ENABLED
,ItemsE0.CHILD_LOT_PREFIX RES_CHILD_LOT_PREFIX
,ItemsE0.CHILD_LOT_STARTING_NUMBER RES_CHILD_LOT_STARTING_NUMBER
,ItemsE0.CHILD_LOT_VALIDATION_FLAG RES_CHILD_LOT_FORMAT_VALIDATIO
,ItemsE0.COPY_LOT_ATTRIBUTE_FLAG RES_COPY_LOT_ATTRIBUTES
,ItemsE0.EXPIRATION_ACTION_CODE RES_EXPIRATION_ACTION
,ItemsE0.EXPIRATION_ACTION_INTERVAL RES_EXPIRATION_ACTION_INTERVAL
,ItemsE0.STOCK_ENABLED_FLAG RES_STOCKED
,ItemsE0.START_AUTO_LOT_NUMBER RES_STARTING_LOT_NUMBER
,ItemsE0.SHELF_LIFE_CODE RES_LOT_EXPIRATION_CONTROL
,ItemsE0.SHELF_LIFE_DAYS RES_SHELF_LIFE_DAYS
,ItemsE0.SERIAL_NUMBER_CONTROL_CODE RES_SERIAL_NUMBER_CONTROL
,ItemsE0.SERIAL_STATUS_ENABLED RES_SERIAL_STATUS_ENABLED
,ItemsE0.REVISION_QTY_CONTROL_CODE RES_REVISION_CONTROL
,ItemsE0.RETEST_INTERVAL RES_RETEST_INTERVAL
,ItemsE0.AUTO_LOT_ALPHA_PREFIX RES_STARTING_LOT_PREFIX
,ItemsE0.AUTO_SERIAL_ALPHA_PREFIX RES_STARTING_SERIAL_PREFIX
,ItemsE0.BULK_PICKED_FLAG RES_BULK_PICKED
,ItemsE0.CHECK_SHORTAGES_FLAG RES_CHECK_MATERIAL_SHORTAGE
,ItemsE0.CYCLE_COUNT_ENABLED_FLAG RES_CYCLE_COUNT_ENABLED
,ItemsE0.DEFAULT_GRADE RES_DEFAULT_GRADE
,ItemsE0.GRADE_CONTROL_FLAG RES_GRADE_CONTROLLED
,ItemsE0.HOLD_DAYS RES_HOLD_DAYS
,ItemsE0.LOT_DIVISIBLE_FLAG RES_LOT_DIVISIBLE
,ItemsE0.MATURITY_DAYS RES_MATURITY_DAYS
,(SELECT STATUS_CODE
	FROM INV_MATERIAL_STATUSES_VL
	WHERE STATUS_ID = ItemsE0.DEFAULT_LOT_STATUS_ID
	) RES_DEFAULT_LOT_STATUS
,(SELECT STATUS_CODE
	FROM INV_MATERIAL_STATUSES_VL
	WHERE STATUS_ID = ItemsE0.DEFAULT_SERIAL_STATUS_ID
	) RES_DEFAULT_SERIAL_STATUS
,ItemsE0.LOT_SPLIT_ENABLED RES_LOT_SPLIT_ENABLED
,ItemsE0.LOT_MERGE_ENABLED RES_LOT_MERGE_ENABLED
,ItemsE0.INVENTORY_ITEM_FLAG RES_INVENTORY_ITEM
,ItemsE0.LOCATION_CONTROL_CODE RES_STOCK_LOCATOR_CONTROL
,ItemsE0.LOT_CONTROL_CODE RES_LOT_CONTROL
,ItemsE0.LOT_STATUS_ENABLED RES_LOT_STATUS_ENABLED
,ItemsE0.LOT_SUBSTITUTION_ENABLED RES_LOT_SUBSTITUTION_ENABLED
,ItemsE0.LOT_TRANSLATE_ENABLED RES_LOT_TRANSLATE_ENABLED
,ItemsE0.MTL_TRANSACTIONS_ENABLED_FLAG RES_TRANSACTION_ENABLED
,ItemsE0.POSITIVE_MEASUREMENT_ERROR RES_POSITIVE_MEASUREMENT_ERROR
,ItemsE0.NEGATIVE_MEASUREMENT_ERROR RES_NEGATIVE_MEASUREMENT_ERROR
,ItemsE0.PARENT_CHILD_GENERATION_FLAG RES_CHILD_LOT_GENERATION
,ItemsE0.RESERVABLE_TYPE RES_RESERVABLE
,ItemsE0.START_AUTO_SERIAL_NUMBER RES_STARTING_SERIAL_NUMBER
,(SELECT NAME
	FROM RA_RULES
	WHERE RULE_ID = ItemsE0.INVOICING_RULE_ID
	) RES_INVOICING_RULE
,ItemsE0.TAX_CODE RES_OUTPUT_TAX_CLASSIFICATION_
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL',KEY_FLEX_CODE => 'GL#',STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID FROM GL_CODE_COMBINATIONS WHERE CODE_COMBINATION_ID = ItemsE0.SALES_ACCOUNT),COMBINATION_ID => ItemsE0.SALES_ACCOUNT) RES_SALES_ACCOUNT
,(SELECT NAME 
	FROM RA_TERMS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND TERM_ID = ItemsE0.PAYMENT_TERMS_ID
	) RES_PAYMENT_TERMS
,ItemsE0.INVOICE_ENABLED_FLAG RES_INVOICE_ENABLED
,ItemsE0.INVOICEABLE_ITEM_FLAG RES_INVOICED
,(SELECT NAME
	FROM RA_RULES
	WHERE RULE_ID = ItemsE0.ACCOUNTING_RULE_ID
	) RES_ACCOUNTING_RULE
,ItemsE0.AUTO_CREATED_CONFIG_FLAG RES_AUTOCREATED_CONFIGURATION
,ItemsE0.REPLENISH_TO_ORDER_FLAG RES_ASSEMBLE_TO_ORDER
,ItemsE0.PICK_COMPONENTS_FLAG RES_PICK_COMPONENTS
,(SELECT ITEM_NUMBER
	FROM EGP_SYSTEM_ITEMS_B
	WHERE INVENTORY_ITEM_ID = ItemsE0.BASE_ITEM_ID
	AND ORGANIZATION_ID = ItemsE0.ORGANIZATION_ID
	) RES_BASE_MODEL
,ItemsE0.EFFECTIVITY_CONTROL RES_EFFECTIVITY_CONTROL
,ItemsE0.CONFIG_ORGS RES_CREATE_CONFIGURED_ITEM
,ItemsE0.CONFIG_MATCH RES_MATCH_CONFIGURATION
,ItemsE0.CONFIG_MODEL_TYPE RES_CONFIGURATOR_MODEL_TYPE
,ItemsE0.BOM_ITEM_TYPE RES_STRUCTURE_ITEM_TYPE
,ItemsE0.CUM_MANUFACTURING_LEAD_TIME RES_CUMULATIVE_MANUFACTURING_L
,ItemsE0.PREPROCESSING_LEAD_TIME RES_PREPROCESSING_DAYS
,ItemsE0.CUMULATIVE_TOTAL_LEAD_TIME RES_CUMULATIVE_TOTAL_LEAD_TIME
,ItemsE0.FIXED_LEAD_TIME RES_FIXED_LEAD_TIME
,ItemsE0.VARIABLE_LEAD_TIME RES_VARIABLE_LEAD_TIME
,ItemsE0.FULL_LEAD_TIME RES_PROCESSING_DAYS
,ItemsE0.LEAD_TIME_LOT_SIZE RES_LEAD_TIME_LOT_SIZE
,ItemsE0.POSTPROCESSING_LEAD_TIME RES_POSTPROCESSING_DAYS
,ItemsE0.ATO_FORECAST_CONTROL RES_FORECAST_CONTROL
,ItemsE0.CRITICAL_COMPONENT_FLAG RES_CRITICAL_COMPONENT
,ItemsE0.ACCEPTABLE_EARLY_DAYS RES_ACCEPTABLE_EARLY_DAYS
,ItemsE0.CREATE_SUPPLY_FLAG RES_CREATE_SUPPLY
,ItemsE0.DAYS_TGT_INV_SUPPLY RES_TARGET_INVENTORY_DAYS_OF_S
,ItemsE0.DAYS_TGT_INV_WINDOW RES_TARGET_INVENTORY_WINDOW
,ItemsE0.DAYS_MAX_INV_SUPPLY RES_MAXIMUM_INVENTORY_DAYS_OF_
,ItemsE0.DAYS_MAX_INV_WINDOW RES_MAXIMUM_INVENTORY_WINDOW
,ItemsE0.DEMAND_TIME_FENCE_CODE RES_DEMAND_TIME_FENCE
,ItemsE0.DEMAND_TIME_FENCE_DAYS RES_DEMAND_TIME_DAYS
,ItemsE0.DRP_PLANNED_FLAG RES_DISTRIBUTION_PLANNED
,ItemsE0.END_ASSEMBLY_PEGGING_FLAG RES_END_ASSEMBLY_PEGGING
,ItemsE0.EXCLUDE_FROM_BUDGET_FLAG RES_EXCLUDE_FROM_BUDGET
,ItemsE0.MRP_CALCULATE_ATP_FLAG RES_CALCULATE_ATP
,ItemsE0.MRP_PLANNING_CODE RES_PLANNING_METHOD
,ItemsE0.PLANNED_INV_POINT_FLAG RES_PLANNED_INVENTORY_POINT
,ItemsE0.PLANNING_TIME_FENCE_CODE RES_PLANNING_TIME_FENCE_CODE
,ItemsE0.PLANNING_TIME_FENCE_DAYS RES_PLANNING_TIME_FENCE_DAYS
,ItemsE0.PREPOSITION_POINT RES_PREPOSITION_POINT
,ItemsE0.RELEASE_TIME_FENCE_CODE RES_RELEASE_TIME_FENCE_CODE
,ItemsE0.RELEASE_TIME_FENCE_DAYS RES_RELEASE_TIME_FENCE_DAYS
,ItemsE0.REPAIR_LEADTIME RES_REPAIR_LEAD_TIME
,ItemsE0.REPAIR_YIELD RES_REPAIR_YIELD
,ItemsE0.REPAIR_PROGRAM RES_REPAIR_PROGRAM
,ItemsE0.ROUNDING_CONTROL_TYPE RES_ROUND_ORDER_QUANTITIES
,ItemsE0.SHRINKAGE_RATE RES_SHRINKAGE_RATE
,ItemsE0.SUBSTITUTION_WINDOW_CODE RES_SUBSTITUTION_WINDOW_CODE
,ItemsE0.SUBSTITUTION_WINDOW_DAYS RES_SUBSTITUTION_WINDOW_DAYS
,ItemsE0.TRADE_ITEM_DESCRIPTOR RES_PACK_TYPE
,ItemsE0.ALLOWED_UNITS_LOOKUP_CODE RES_CONVERSIONS
,ItemsE0.DUAL_UOM_DEVIATION_HIGH RES_POSITIVE_DEVIATION_FACTOR
,ItemsE0.DUAL_UOM_DEVIATION_LOW RES_NEGATIVE_DEVIATION_FACTOR
,ItemsE0.ITEM_TYPE RES_USER_ITEM_TYPE
,(SELECT LONG_DESCRIPTION
	FROM EGP_SYSTEM_ITEMS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND INVENTORY_ITEM_ID = ItemsE0.INVENTORY_ITEM_ID
	AND ORGANIZATION_ID = ItemsE0.ORGANIZATION_ID
	) RES_LONG_DESCRIPTION
,(SELECT REPLACE(REPLACE(REPLACE(HTML_LONG_DESCRIPTION,'&','#AMP#'),'<','#OPENTAG#'),'>','#CLOSETAG#')
	FROM EGP_SYSTEM_ITEMS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND INVENTORY_ITEM_ID = ItemsE0.INVENTORY_ITEM_ID
	AND ORGANIZATION_ID = ItemsE0.ORGANIZATION_ID
	) RES_FORMATTED_DESCRIPTION
,ItemsE0.ONT_PRICING_QTY_SOURCE RES_PRICING_UNIT_OF_MEASURE
,ItemsE0.SECONDARY_DEFAULT_IND RES_DEFAULTING_CONTROL
,(SELECT UNIT_OF_MEASURE 
	FROM INV_UNITS_OF_MEASURE_VL
	WHERE UOM_CODE = ItemsE0.SECONDARY_UOM_CODE
	) RES_SECONDARY_UNIT_OF_MEASURE
,ItemsE0.TRACKING_QUANTITY_IND RES_TRACKING_UNIT_OF_MEASURE
,ItemsE0.ENGINEERED_ITEM_FLAG RES_ENGINEERED_ITEM_FLAG
,ItemsE0.ATP_COMPONENTS_FLAG RES_ATP_COMPONENTS
,ItemsE0.ATP_FLAG RES_CHECK_ATP
,ItemsE0.OVER_SHIPMENT_TOLERANCE RES_OVER_SHIPMENT_TOLERANCE
,ItemsE0.UNDER_SHIPMENT_TOLERANCE RES_UNDER_SHIPMENT_TOLERANCE
,ItemsE0.OVER_RETURN_TOLERANCE RES_OVER_RETURN_TOLERANCE
,ItemsE0.UNDER_RETURN_TOLERANCE RES_UNDER_RETURN_TOLERANCE
,ItemsE0.DOWNLOADABLE_FLAG RES_DOWNLOADABLE
,ItemsE0.ELECTRONIC_FLAG RES_ELECTRONIC_FORMAT
,ItemsE0.INDIVISIBLE_FLAG RES_ORDER_MANAGEMENT_INDIVISIB
,ItemsE0.INTERNAL_ORDER_ENABLED_FLAG RES_INTERNAL_ORDERS_ENABLED
,(SELECT RULE_NAME 
	FROM MSC_ATP_RULES
	WHERE RULE_ID = ItemsE0.ATP_RULE_ID
	) RES_ATP_RULE
,ItemsE0.CHARGE_PERIODICITY_CODE RES_CHARGE_PERIODICITY
,ItemsE0.CUSTOMER_ORDER_ENABLED_FLAG RES_CUSTOMER_ORDERS_ENABLED
,(SELECT ORGANIZATION_CODE
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = ItemsE0.DEFAULT_SHIPPING_ORG
	) RES_DEFAULT_SHIPPING_ORGANIZAT
,ItemsE0.DEFAULT_SO_SOURCE_TYPE RES_DEFAULT_SALES_ORDER_SOURCE
,ItemsE0.ELIGIBILITY_COMPATIBILITY_RULE RES_ELIGIBILITY_RULE
,ItemsE0.FINANCING_ALLOWED_FLAG RES_FINANCING_ALLOWED
,ItemsE0.INTERNAL_ORDER_FLAG RES_INTERNAL_ORDERED
,(SELECT RULE_NAME
	FROM INV_RULES_VL
	WHERE RULE_ID = ItemsE0.PICKING_RULE_ID
	) RES_PICKING_RULE
,ItemsE0.RETURNABLE_FLAG RES_RETURNABLE
,ItemsE0.RETURN_INSPECTION_REQUIREMENT RES_RMA_INSPECTION_REQUIRED
,ItemsE0.SALES_PRODUCT_TYPE RES_SALES_PRODUCT_TYPE
,ItemsE0.BACK_TO_BACK_ENABLED RES_BACK_TO_BACK_ENABLED
,ItemsE0.SHIPPABLE_ITEM_FLAG RES_SHIPPABLE
,ItemsE0.SHIP_MODEL_COMPLETE_FLAG RES_SHIP_MODEL_COMPLETE
,ItemsE0.SO_TRANSACTIONS_FLAG RES_ORDER_MANAGEMENT_TRANSACTI
,ItemsE0.CUSTOMER_ORDER_FLAG RES_CUSTOMER_ORDERED
,ItemsE0.UNIT_WEIGHT RES_UNIT_WEIGHT
,(SELECT UNIT_OF_MEASURE 
	FROM INV_UNITS_OF_MEASURE_VL
	WHERE UOM_CODE = ItemsE0.WEIGHT_UOM_CODE
	) RES_WEIGHT_UNIT_OF_MEASURE
,ItemsE0.UNIT_VOLUME RES_UNIT_VOLUME
,(SELECT UNIT_OF_MEASURE 
	FROM INV_UNITS_OF_MEASURE_VL
	WHERE UOM_CODE = ItemsE0.VOLUME_UOM_CODE
	) RES_VOLUME_UNIT_OF_MEASURE
,(SELECT UNIT_OF_MEASURE 
	FROM INV_UNITS_OF_MEASURE_VL
	WHERE UOM_CODE = ItemsE0.DIMENSION_UOM_CODE
	) RES_DIMENSION_UNIT_OF_MEASURE
,ItemsE0.UNIT_LENGTH RES_LENGTH
,ItemsE0.UNIT_WIDTH RES_WIDTH
,ItemsE0.UNIT_HEIGHT RES_HEIGHT
,ItemsE0.COLLATERAL_FLAG RES_COLLATERAL
,ItemsE0.CONTAINER_ITEM_FLAG RES_CONTAINER
,ItemsE0.CONTAINER_TYPE_CODE RES_CONTAINER_TYPE
,ItemsE0.EQUIPMENT_TYPE RES_WAREHOUSE_EQUIPMENT
,ItemsE0.EVENT_FLAG RES_EVENT
,ItemsE0.INTERNAL_VOLUME RES_INTERNAL_VOLUME
,ItemsE0.MAXIMUM_LOAD_WEIGHT RES_MAXIMUM_LOAD_WEIGHT
,ItemsE0.MINIMUM_FILL_PERCENT RES_MINIMUM_FILL_PERCENT
,ItemsE0.VEHICLE_ITEM_FLAG RES_VEHICLE
,ItemsE0.CAS_NUMBER RES_CAS_NUMBER
,ItemsE0.HAZARDOUS_MATERIAL_FLAG RES_HAZARDOUS_MATERIAL
,ItemsE0.PROCESS_COSTING_ENABLED_FLAG RES_PROCESS_COSTING_ENABLED
,ItemsE0.PROCESS_EXECUTION_ENABLED_FLAG RES_PROCESS_EXECUTION_ENABLED
,ItemsE0.PROCESS_QUALITY_ENABLED_FLAG RES_PROCESS_QUALITY_ENABLED
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'INV',KEY_FLEX_CODE => 'MTLL',STRUCTURE_NUMBER =>
	invLocatorsE1.STRUCTURE_INSTANCE_NUMBER,COMBINATION_ID => ItemsE0.PROCESS_SUPPLY_LOCATOR_ID,DATA_SET_NUMBER => invLocatorsE1.SUBINVENTORY_ID)  RES_PROCESS_SUPPLY_LOCATOR
,ItemsE0.PROCESS_SUPPLY_SUBINVENTORY RES_PROCESS_SUPPLY_SUBINVENTOR
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'INV',KEY_FLEX_CODE => 'MTLL',STRUCTURE_NUMBER =>
	invLocatorsE2.STRUCTURE_INSTANCE_NUMBER,COMBINATION_ID => ItemsE0.PROCESS_YIELD_LOCATOR_ID,DATA_SET_NUMBER => invLocatorsE2.SUBINVENTORY_ID)  RES_PROCESS_YIELD_LOCATOR
,ItemsE0.PROCESS_YIELD_SUBINVENTORY RES_PROCESS_YIELD_SUBINVENTORY
,ItemsE0.RECIPE_ENABLED_FLAG RES_RECIPE_ENABLED
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL',KEY_FLEX_CODE => 'GL#',STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID FROM GL_CODE_COMBINATIONS WHERE CODE_COMBINATION_ID = ItemsE0.EXPENSE_ACCOUNT),COMBINATION_ID => ItemsE0.EXPENSE_ACCOUNT) RES_EXPENSE_ACCOUNT
,(SELECT UN_NUMBER_CODE
	FROM PO_UN_NUMBERS_B
	WHERE UN_NUMBER_ID = ItemsE0.UN_NUMBER_ID 
	) RES_UN_NUMBER
,ItemsE0.UNIT_OF_ISSUE RES_UNIT_OF_ISSUE
,ItemsE0.ROUNDING_FACTOR RES_ROUNDING_FACTOR
,ItemsE0.RECEIVE_CLOSE_TOLERANCE RES_RECEIPT_CLOSE_TOLERANCE_PE
,ItemsE0.PURCHASING_TAX_CODE RES_INPUT_TAX_CLASSIFICATION_C
,ItemsE0.PURCHASING_ITEM_FLAG  RES_PURCHASED
,ItemsE0.PRICE_TOLERANCE_PERCENT RES_PRICE_TOLERANCE_PERCENTAGE
,ItemsE0.OUTSOURCED_ASSEMBLY RES_OUTSOURCED_ASSEMBLY
,ItemsE0.OUTSIDE_OPERATION_UOM_TYPE RES_OUTSIDE_PROCESSING_UNIT_TY
,ItemsE0.NEGOTIATION_REQUIRED_FLAG RES_NEGOTIATION_REQUIRED
,ItemsE0.MUST_USE_APPROVED_VENDOR_FLAG RES_USE_APPROVED_SUPPLIER
,ItemsE0.MATCH_APPROVAL_LEVEL RES_MATCH_APPROVAL_LEVEL
,ItemsE0.INVOICE_MATCH_OPTION RES_INVOICE_MATCH_OPTION
,ItemsE0.LIST_PRICE_PER_UNIT RES_LIST_PRICE
,ItemsE0.INVOICE_CLOSE_TOLERANCE RES_INVOICE_CLOSE_TOLERANCE_PE
,(SELECT HAZARD_CLASS
	FROM PO_HAZARD_CLASSES_TL
	WHERE HAZARD_CLASS_ID = ItemsE0.HAZARD_CLASS_ID
	AND LANGUAGE = USERENV('LANG')
	) RES_HAZARD_CLASS
,(SELECT DISTINCT LIST_NAME
	FROM PO_AGENT_ACCESSES BuyerPEO
	,PER_PERSON_NAMES_F_V PersonNameDPEO
	WHERE SYSDATE BETWEEN PersonNameDPEO.EFFECTIVE_START_DATE AND PersonNameDPEO.EFFECTIVE_END_DATE
	AND BuyerPEO.AGENT_ID = PersonNameDPEO.PERSON_ID
	AND BuyerPEO.ASSIGNMENT_ID = ItemsE0.BUYER_ID
	) RES_DEFAULT_BUYER
,ItemsE0.TAXABLE_FLAG RES_TAXABLE
,ItemsE0.PURCHASING_ENABLED_FLAG  RES_PURCHASABLE
,ItemsE0.OUTSIDE_OPERATION_FLAG RES_OUTSIDE_PROCESSING_ITEM_EN
,ItemsE0.MARKET_PRICE RES_MARKET_PRICE
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'FA',KEY_FLEX_CODE => (SELECT KEY_FLEXFIELD_CODE FROM FND_KF_STR_INSTANCES_VL WHERE STRUCTURE_INSTANCE_NUMBER= assetCategoriesE0.STRUCTURE_INSTANCE_NUMBER),STRUCTURE_NUMBER => assetCategoriesE0.STRUCTURE_INSTANCE_NUMBER,COMBINATION_ID => assetCategoriesE0.CATEGORY_ID) RES_ASSET_CATEGORY
,ItemsE0.ALLOW_ITEM_DESC_UPDATE_FLAG RES_ALLOW_PURCHASING_DOCUMENT_
,ItemsE0.ALLOW_EXPRESS_DELIVERY_FLAG RES_ALLOW_EXPRESS_TRANSACTIONS
,ItemsE0.ALLOW_SUBSTITUTE_RECEIPTS_FLAG RES_ALLOW_SUBSTITUTE_RECEIPTS
,ItemsE0.ALLOW_UNORDERED_RECEIPTS_FLAG RES_ALLOW_UNORDERED_RECEIPTS
,ItemsE0.DAYS_EARLY_RECEIPT_ALLOWED RES_DAYS_EARLY_RECEIPT_ALLOWED
,ItemsE0.DAYS_LATE_RECEIPT_ALLOWED RES_DAYS_LATE_RECEIPT_ALLOWED
,ItemsE0.RECEIVING_ROUTING_ID RES_RECEIPT_ROUTING
,ItemsE0.ENFORCE_SHIP_TO_LOCATION_CODE RES_ENFORCE_SHIP_TO_LOCATION
,ItemsE0.QTY_RCV_EXCEPTION_CODE RES_QUANTITY_RECEIVED_ACTION
,ItemsE0.QTY_RCV_TOLERANCE RES_QUANTITY_RECEIVED_TOLERANC
,ItemsE0.RECEIPT_DAYS_EXCEPTION_CODE RES_RECEIPT_DATE_EXCEPTION_ACT
,ItemsE0.ASSET_CREATION_CODE RES_ASSET_CREATION_CODE
,ItemsE0.SERVICE_START_TYPE_CODE RES_SERVICE_START_TYPE
,ItemsE0.COMMS_NL_TRACKABLE_FLAG RES_TRACK_IN_INSTALLED_BASE

,ItemsE0.CSS_ENABLED_FLAG RES_ENABLE_FOR_CUSTOMER_SELF_S -- Enable for Customer Self Service

,ItemsE0.CONTRACT_ITEM_TYPE_CODE RES_CONTRACT_ITEM_TYPE
--,ItemsE0.COVERAGE_SCHEDULE_ID RES_COVERAGE_SCHEDULE_NAME
,ItemsE0.COVERAGE_SCHEDULE_ID RES_STANDARDCOVERAGE
,ItemsE0.DEFECT_TRACKING_ON_FLAG RES_ENABLE_DEFECT_TRACKING
,ItemsE0.IB_ITEM_INSTANCE_CLASS RES_INSTANCE_CLASS
,ItemsE0.MATERIAL_BILLABLE_FLAG RES_BILLING_TYPE
,ItemsE0.RECOVERED_PART_DISP_CODE RES_RECOVERED_PART_DISPOSITION
,ItemsE0.SERVICEABLE_PRODUCT_FLAG RES_ENABLE_CONTRACT_COVERAGE
,ItemsE0.SERVICE_STARTING_DELAY RES_STARTING_DELAY_IN_DAYS
,ItemsE0.SERVICE_DURATION RES_SERVICE_DURATION
,ItemsE0.SERVICE_DURATION_PERIOD_CODE RES_SERVICE_DURATION_PERIOD
,ItemsE0.SERV_REQ_ENABLED_CODE RES_SERVICE_REQUEST
,ItemsE0.ALLOW_SUSPEND_FLAG RES_ALLOW_SUSPEND
,ItemsE0.ALLOW_TERMINATE_FLAG RES_ALLOW_TERMINATE
,ItemsE0.REQUIRES_FULFILLMENT_LOC_FLAG RES_REQUIRES_FULFILLMENT_LOCAT
,ItemsE0.REQUIRES_ITM_ASSOCIATION_FLAG RES_REQUIRES_ITEM_ASSOCIATION
,ItemsE0.SERVICE_START_DELAY RES_SERVICE_START_DELAY
,ItemsE0.SERVICE_DURATION_TYPE_CODE RES_SERVICE_DURATION_TYPE
,ItemsE0.COMMS_ACTIVATION_REQD_FLAG RES_ENABLE_PROVISIONING
,ItemsE0.SERV_BILLING_ENABLED_FLAG RES_ENABLE_SERVICE_BILLING
,ItemsE0.ORDERABLE_ON_WEB_FLAG RES_ORDERABLE_ON_THE_WEB
,ItemsE0.BACK_ORDERABLE_FLAG RES_BACK_ORDERABLE
,ItemsE0.WEB_STATUS RES_WEB_STATUS
,ItemsE0.MINIMUM_LICENSE_QUANTITY RES_MINIMUM_LICENSE_QUANTITY
,ItemsE0.BUILD_IN_WIP_FLAG RES_BUILD_IN_WIP
,ItemsE0.CONTRACT_MANUFACTURING RES_CONTRACT_MANUFACTURING
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'INV',KEY_FLEX_CODE => 'MTLL',STRUCTURE_NUMBER =>
	invLocatorsE0.STRUCTURE_INSTANCE_NUMBER,COMBINATION_ID => ItemsE0.WIP_SUPPLY_LOCATOR_ID,DATA_SET_NUMBER => invLocatorsE0.SUBINVENTORY_ID) RES_WIP_SUPPLY_LOCATOR
,ItemsE0.WIP_SUPPLY_TYPE RES_WIP_SUPPLY_TYPE
,ItemsE0.WIP_SUPPLY_SUBINVENTORY RES_WIP_SUPPLY_SUBINVENTORY
,ItemsE0.OVERCOMPLETION_TOLERANCE_TYPE RES_OVERCOMPLETION_TOLERANCE_T
,ItemsE0.OVERCOMPLETION_TOLERANCE_VALUE RES_OVERCOMPLETION_TOLERANCE_V
,ItemsE0.INVENTORY_CARRY_PENALTY RES_INVENTORY_CARRY_PENALTY
,ItemsE0.OPERATION_SLACK_PENALTY RES_OPERATION_SLACK_PENALTY
,'' RES_REVISION
,ItemsE0.STYLE_ITEM_FLAG RES_STYLE_ITEM
,(SELECT ITEM_NUMBER
	FROM EGP_SYSTEM_ITEMS_B
	WHERE INVENTORY_ITEM_ID = ItemsE0.STYLE_ITEM_ID
	AND ORGANIZATION_ID = ItemsE0.ORGANIZATION_ID
	) RES_STYLE_ITEM_NUMBER
,TO_CHAR(ItemsE0.VERSION_START_DATE,'YYYY/MM/DD') RES_VERSION_START_DATE
,'' RES_VERSION_REVISION_CODE
,'' RES_VERSION_LABEL
,ItemsE0.START_UPON_MILESTONE_CODE RES_SERVICE_START_UPON_MILESTO
,ItemsE0.SALES_PRODUCT_SUB_TYPE RES_SALES_PRODUCT_SUB_TYPE
,ItemsE0.GLOBAL_ATTRIBUTE_CATEGORY RES_GLOBAL_ATTRIBUTE_CATEGORY
,ItemsE0.GLOBAL_ATTRIBUTE1 RES_GLOBAL_ATTRIBUTE1
,ItemsE0.GLOBAL_ATTRIBUTE2 RES_GLOBAL_ATTRIBUTE2
,ItemsE0.GLOBAL_ATTRIBUTE3 RES_GLOBAL_ATTRIBUTE3
,ItemsE0.GLOBAL_ATTRIBUTE4 RES_GLOBAL_ATTRIBUTE4
,ItemsE0.GLOBAL_ATTRIBUTE5 RES_GLOBAL_ATTRIBUTE5
,ItemsE0.GLOBAL_ATTRIBUTE6 RES_GLOBAL_ATTRIBUTE6
,ItemsE0.GLOBAL_ATTRIBUTE7 RES_GLOBAL_ATTRIBUTE7
,ItemsE0.GLOBAL_ATTRIBUTE8 RES_GLOBAL_ATTRIBUTE8
,ItemsE0.GLOBAL_ATTRIBUTE9 RES_GLOBAL_ATTRIBUTE9
,ItemsE0.GLOBAL_ATTRIBUTE10 RES_GLOBAL_ATTRIBUTE10
,ItemsE0.ATTRIBUTE_CATEGORY RES_ATTRIBUTE_CATEGORY
,ItemsE0.ATTRIBUTE1 RES_ATTRIBUTE1
,ItemsE0.ATTRIBUTE2 RES_ATTRIBUTE2
,ItemsE0.ATTRIBUTE3 RES_ATTRIBUTE3
,ItemsE0.ATTRIBUTE4 RES_ATTRIBUTE4
,ItemsE0.ATTRIBUTE5 RES_ATTRIBUTE5
,ItemsE0.ATTRIBUTE6 RES_ATTRIBUTE6
,ItemsE0.ATTRIBUTE7 RES_ATTRIBUTE7
,ItemsE0.ATTRIBUTE8 RES_ATTRIBUTE8
,ItemsE0.ATTRIBUTE9 RES_ATTRIBUTE9
,ItemsE0.ATTRIBUTE10 RES_ATTRIBUTE10
,ItemsE0.ATTRIBUTE11 RES_ATTRIBUTE11
,ItemsE0.ATTRIBUTE12 RES_ATTRIBUTE12
,ItemsE0.ATTRIBUTE13 RES_ATTRIBUTE13
,ItemsE0.ATTRIBUTE14 RES_ATTRIBUTE14
,ItemsE0.ATTRIBUTE15 RES_ATTRIBUTE15
,ItemsE0.ATTRIBUTE16 RES_ATTRIBUTE16
,ItemsE0.ATTRIBUTE17 RES_ATTRIBUTE17
,ItemsE0.ATTRIBUTE18 RES_ATTRIBUTE18
,ItemsE0.ATTRIBUTE19 RES_ATTRIBUTE19
,ItemsE0.ATTRIBUTE20 RES_ATTRIBUTE20
,ItemsE0.ATTRIBUTE21 RES_ATTRIBUTE21
,ItemsE0.ATTRIBUTE22 RES_ATTRIBUTE22
,ItemsE0.ATTRIBUTE23 RES_ATTRIBUTE23
,ItemsE0.ATTRIBUTE24 RES_ATTRIBUTE24
,ItemsE0.ATTRIBUTE25 RES_ATTRIBUTE25
,ItemsE0.ATTRIBUTE26 RES_ATTRIBUTE26
,ItemsE0.ATTRIBUTE27 RES_ATTRIBUTE27
,ItemsE0.ATTRIBUTE28 RES_ATTRIBUTE28
,ItemsE0.ATTRIBUTE29 RES_ATTRIBUTE29
,ItemsE0.ATTRIBUTE30 RES_ATTRIBUTE30
,ItemsE0.ATTRIBUTE_NUMBER1 RES_ATTRIBUTE_NUMBER1
,ItemsE0.ATTRIBUTE_NUMBER2 RES_ATTRIBUTE_NUMBER2
,ItemsE0.ATTRIBUTE_NUMBER3 RES_ATTRIBUTE_NUMBER3
,ItemsE0.ATTRIBUTE_NUMBER4 RES_ATTRIBUTE_NUMBER4
,ItemsE0.ATTRIBUTE_NUMBER5 RES_ATTRIBUTE_NUMBER5
,ItemsE0.ATTRIBUTE_NUMBER6 RES_ATTRIBUTE_NUMBER6
,ItemsE0.ATTRIBUTE_NUMBER7 RES_ATTRIBUTE_NUMBER7
,ItemsE0.ATTRIBUTE_NUMBER8 RES_ATTRIBUTE_NUMBER8
,ItemsE0.ATTRIBUTE_NUMBER9 RES_ATTRIBUTE_NUMBER9
,ItemsE0.ATTRIBUTE_NUMBER10 RES_ATTRIBUTE_NUMBER10
,ItemsE0.ATTRIBUTE_DATE1 RES_ATTRIBUTE_DATE1
,ItemsE0.ATTRIBUTE_DATE2 RES_ATTRIBUTE_DATE2
,ItemsE0.ATTRIBUTE_DATE3 RES_ATTRIBUTE_DATE3
,ItemsE0.ATTRIBUTE_DATE4 RES_ATTRIBUTE_DATE4
,ItemsE0.ATTRIBUTE_DATE5 RES_ATTRIBUTE_DATE5
,ItemsE0.ATTRIBUTE_TIMESTAMP1 RES_ATTRIBUTE_TIMESTAMP1
,ItemsE0.ATTRIBUTE_TIMESTAMP2 RES_ATTRIBUTE_TIMESTAMP2
,ItemsE0.ATTRIBUTE_TIMESTAMP3 RES_ATTRIBUTE_TIMESTAMP3
,ItemsE0.ATTRIBUTE_TIMESTAMP4 RES_ATTRIBUTE_TIMESTAMP4
,ItemsE0.ATTRIBUTE_TIMESTAMP5 RES_ATTRIBUTE_TIMESTAMP5
,ItemsE0.GLOBAL_ATTRIBUTE11 RES_GLOBAL_ATTRIBUTE11
,ItemsE0.GLOBAL_ATTRIBUTE12 RES_GLOBAL_ATTRIBUTE12
,ItemsE0.GLOBAL_ATTRIBUTE13 RES_GLOBAL_ATTRIBUTE13
,ItemsE0.GLOBAL_ATTRIBUTE14 RES_GLOBAL_ATTRIBUTE14
,ItemsE0.GLOBAL_ATTRIBUTE15 RES_GLOBAL_ATTRIBUTE15
,ItemsE0.GLOBAL_ATTRIBUTE16 RES_GLOBAL_ATTRIBUTE16
,ItemsE0.GLOBAL_ATTRIBUTE17 RES_GLOBAL_ATTRIBUTE17
,ItemsE0.GLOBAL_ATTRIBUTE18 RES_GLOBAL_ATTRIBUTE18
,ItemsE0.GLOBAL_ATTRIBUTE19 RES_GLOBAL_ATTRIBUTE19
,ItemsE0.GLOBAL_ATTRIBUTE20 RES_GLOBAL_ATTRIBUTE20
,ItemsE0.GLOBAL_ATTRIBUTE_NUMBER1 RES_GLOBAL_ATTRIBUTE_NUMBER1
,ItemsE0.GLOBAL_ATTRIBUTE_NUMBER2 RES_GLOBAL_ATTRIBUTE_NUMBER2
,ItemsE0.GLOBAL_ATTRIBUTE_NUMBER3 RES_GLOBAL_ATTRIBUTE_NUMBER3
,ItemsE0.GLOBAL_ATTRIBUTE_NUMBER4 RES_GLOBAL_ATTRIBUTE_NUMBER4
,ItemsE0.GLOBAL_ATTRIBUTE_NUMBER5 RES_GLOBAL_ATTRIBUTE_NUMBER5
,ItemsE0.GLOBAL_ATTRIBUTE_DATE1 RES_GLOBAL_ATTRIBUTE_DATE1
,ItemsE0.GLOBAL_ATTRIBUTE_DATE2 RES_GLOBAL_ATTRIBUTE_DATE2
,ItemsE0.GLOBAL_ATTRIBUTE_DATE3 RES_GLOBAL_ATTRIBUTE_DATE3
,ItemsE0.GLOBAL_ATTRIBUTE_DATE4 RES_GLOBAL_ATTRIBUTE_DATE4
,ItemsE0.GLOBAL_ATTRIBUTE_DATE5 RES_GLOBAL_ATTRIBUTE_DATE5

,'' RES_PROCUREMENT_BUSINESS_UNIT
,ItemsE0.FORCE_PURCHASE_LEAD_TIME_FLAG RES_ENFORCE_PURCHASING_LEAD_TI -- Enforce Purchasing Lead Time Flag
,ItemsE0.REPLACEMENT_TYPE RES_REPLACEMENT_TYPE
,'' RES_BUYER_EMAIL_ADDRESS
,ItemsE0.EXPENDITURE_TYPE_ID RES_DEFAULT_EXPENDITURE_TYPE
,ItemsE0.HARD_PEGGING_LEVEL RES_HARD_PEGGING_LEVEL
,ItemsE0.COMN_SUPPLY_PRJ_DEMAND_FLAG RES_ALLOW_USE_OF_COMMON_SUPPLI -- Allow Use of Common Supplies
,ItemsE0.ENABLE_IOT_FLAG RES_ENABLE_IOT
,ItemsE0.PACKAGING_STRING_ID RES_PACKAGING_STRING
,TO_CHAR(ItemsE0.CREATE_SUPPLY_AFTER_DATE,'YYYY-MM-DD') RES_CREATE_SUPPLY_AFTER
,ItemsE0.ASSET_CREATION_CODE RES_CREATE_FIXED_ASSET
,ItemsE0.UNDER_COMPL_TOLERANCE_TYPE RES_UNDERCOMPLETION_TOLERANCE_
,ItemsE0.UNDER_COMPL_TOLERANCE_VALUE RES_UNDERCOMPLETION_TOLERANC_0


,ItemsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ItemsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ItemsE0.CREATED_BY  RSC_CREATED_BY
,ItemsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,ItemsE0.ORGANIZATION_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_SYSTEM_ITEMS_B ItemsE0
,FA_CATEGORIES_B assetCategoriesE0
,INV_ITEM_LOCATIONS invLocatorsE0
,INV_ITEM_LOCATIONS invLocatorsE1
,INV_ITEM_LOCATIONS invLocatorsE2
WHERE ItemsE0.ASSET_CATEGORY_ID = assetCategoriesE0.CATEGORY_ID(+)
AND ItemsE0.WIP_SUPPLY_LOCATOR_ID = invLocatorsE0.INVENTORY_LOCATION_ID(+)
AND ItemsE0.ORGANIZATION_ID = invLocatorsE0.ORGANIZATION_ID(+)
AND ItemsE0.WIP_SUPPLY_SUBINVENTORY = invLocatorsE0.SUBINVENTORY_CODE(+)
AND ItemsE0.PROCESS_SUPPLY_LOCATOR_ID = invLocatorsE1.INVENTORY_LOCATION_ID(+)
AND ItemsE0.ORGANIZATION_ID = invLocatorsE1.ORGANIZATION_ID(+)
AND ItemsE0.PROCESS_SUPPLY_SUBINVENTORY = invLocatorsE1.SUBINVENTORY_CODE(+)
AND ItemsE0.PROCESS_YIELD_LOCATOR_ID = invLocatorsE2.INVENTORY_LOCATION_ID(+)
AND ItemsE0.ORGANIZATION_ID = invLocatorsE2.ORGANIZATION_ID(+)
AND ItemsE0.PROCESS_YIELD_SUBINVENTORY = invLocatorsE2.SUBINVENTORY_CODE(+)
AND ItemsE0.TEMPLATE_ITEM_FLAG = 'N'
AND ItemsE0.ACD_TYPE = 'PROD'