/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-04-25 $:
 * $HeadURL: $:
 * $Id: Manage Ship Confirm Rules - Ship Confirm Rule.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=WSH_SHIP_CONFIRM_RULES

SELECT
  WshShipConfirmRules.SHIP_CONFIRM_RULE_NAME                                    										RES_NAME,
  WshShipConfirmRules.DESCRIPTION                                               										RES_DESCRIPTION,
  to_char(WshShipConfirmRules.EFFECTIVE_START_DATE,'DD-Mon-YYYY HH24:MI:SS')                                      		RES_START_DATE,
  to_char(WshShipConfirmRules.EFFECTIVE_END_DATE,'DD-Mon-YYYY HH24:MI:SS')      										RES_END_DATE,
  (SELECT MEANING
  FROM FND_LOOKUPS
  WHERE LOOKUP_TYPE = 'WSH_SCR_SHIP_QTY'
  AND LOOKUP_CODE = DECODE(WshShipConfirmRules.ACTION_FLAG,'A','A','S')
  ) RES_SHIP_WITH,
  ( select distinct ShippingLookupEO.MEANING 
    FROM WSH_LOOKUPS ShippingLookupEO
    where ShippingLookupEO.LOOKUP_TYPE                           = 'WSH_SCR_SHIP_UNSPEC_QTY' 
    and  ShippingLookupEO.LOOKUP_CODE   = WshShipConfirmRules.ACTION_FLAG    
   )        																											RES_OPTIONS_IF_SHIPPED_QUANTIT,
  decode(WshShipConfirmRules.STAGE_DEL_FLAG,'Y','Yes','No')                                             			RES_CREATE_SHIPMENT_FOR_REMAIN,
  decode( WshShipConfirmRules.AC_BOL_FLAG,'Y','Yes','No')                                                    		RES_CREATE_BILL_OF_LADING_AND_,
  decode( WshShipConfirmRules.AC_CLOSE_DELIVERY_FLAG ,'Y','Yes','No')                                          		RES_CLOSE_SHIPMENT,
  decode( WshShipConfirmRules.AC_DEFER_INTERFACE_FLAG ,'Y','Yes','No')                                       		RES_DEFER_SENDING_INVENTORY_UP,
  ( select distinct (PartyPEO.PARTY_NAME ||'-' ||ModeOfTransportPEO.MEANING ||'-' ||ServiceLevelPEO.MEANING) AS ShipMethod
    FROM WSH_ORG_CARRIER_SERVICES WarehouseCarrierServicePEO,
      RCS_LOOKUPS ModeOfTransportPEO,
      RCS_LOOKUPS ServiceLevelPEO,
      HZ_PARTIES PartyPEO
    WHERE (WarehouseCarrierServicePEO.CARRIER_ID         = PartyPEO.PARTY_ID)
    AND (WarehouseCarrierServicePEO.MODE_OF_TRANSPORT    = ModeOfTransportPEO.LOOKUP_CODE)
    AND (ModeOfTransportPEO.LOOKUP_TYPE                  = 'WSH_MODE_OF_TRANSPORT')
    AND (WarehouseCarrierServicePEO.SERVICE_LEVEL        = ServiceLevelPEO.LOOKUP_CODE)
    AND (ServiceLevelPEO.LOOKUP_TYPE                     = 'WSH_SERVICE_LEVELS')
    and WarehouseCarrierServicePEO.SHIP_METHOD_CODE = WshShipConfirmRules.SHIP_METHOD_CODE 
  )                                            																			RES_OVERRIDE_SHIPPING_METHOD,
 decode(WshShipConfirmRules.PACKING_SLIP_STATUS,'F','Final','D','Draft')           										RES_PACKING_SLIP_STATUS
,WshShipConfirmRules.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,WshShipConfirmRules.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,WshShipConfirmRules.CREATED_BY RSC_CREATED_BY
,WshShipConfirmRules.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WSH_SHIP_CONFIRM_RULES WshShipConfirmRules 
ORDER BY WshShipConfirmRules.SHIP_CONFIRM_RULE_NAME