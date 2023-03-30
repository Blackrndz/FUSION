/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-11-01 $:
* $HeadURL:  $:
* $Id: Manage Shipping Charge Lists - Shipping Charges (Item Charge).sql  $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=QP_SHIPPING_CHARGE_LISTS_VL
-- RSC_PREREQUISITE_OBJECTS=QP_SHIPPING_CHARGES
-- RSC_PREREQUISITE_OBJECTS=QP_SHIPPING_DETAILS
-- RSC_PREREQUISITE_OBJECTS=QP_CHARGE_DEFINITIONS_VL


select  SHIPPING.NAME                                             									RES_NAME,
CHARGES.CHARGE_LINE_NUMBER                                                              			RES_LINE_NUMBER,
(
SELECT DISTINCT (PartyPEO.PARTY_NAME||'-'||ModeOfTransportPEO.MEANING||'-'||ServiceLevelPEO.MEANING) AS ShipMethod
	FROM WSH_ORG_CARRIER_SERVICES WarehouseCarrierServicePEO
	,RCS_LOOKUPS ModeOfTransportPEO
	,RCS_LOOKUPS ServiceLevelPEO
	,HZ_PARTIES PartyPEO
	,WSH_CARRIERS CarrierPEO
	WHERE(WarehouseCarrierServicePEO.CARRIER_ID      = PartyPEO.PARTY_ID)
	AND(WarehouseCarrierServicePEO.MODE_OF_TRANSPORT = ModeOfTransportPEO.LOOKUP_CODE)
	AND(ModeOfTransportPEO.LOOKUP_TYPE               = 'WSH_MODE_OF_TRANSPORT')
	AND(WarehouseCarrierServicePEO.SERVICE_LEVEL     = ServiceLevelPEO.LOOKUP_CODE)
	AND(ServiceLevelPEO.LOOKUP_TYPE                  = 'WSH_SERVICE_LEVELS')
	AND(CarrierPEO.CARRIER_ID                        = WarehouseCarrierServicePEO.CARRIER_ID)
	AND(CarrierPEO.CARRIER_ID                        = PartyPEO.PARTY_ID)
  AND WarehouseCarrierServicePEO.ORG_CARRIER_SERVICE_ID =  XXX.ORG_CARRIER_SERVICE_ID
	--AND WarehouseCarrierServicePEO.SHIP_METHOD_CODE = 224
  )                                                                                   				RES_SHIPPING_METHOD,

(select NAME
from QP_CHARGE_DEFINITIONS_VL D
where D.CHARGE_DEFINITION_ID   = CHARGES.CHARGE_DEFINITION_ID     
)                                                                               					RES_PRICING_CHARGE_DEFINITION,
decode((select LINE_TYPE_CODE
       from QP_SHIPPING_DETAILS A
       where A.SHIPPING_DETAIL_ID =  CHARGES.SHIPPING_DETAIL_ID
       and A.SHIPPING_CHARGE_LIST_ID =  CHARGES.SHIPPING_CHARGE_LIST_ID
       ) ,'ORA_BUY','Buy','ORA_RETURN','Return')                                                    RES_LINE_TYPE,
       
  (select distinct B.ITEM_NUMBER
  from EGP_SYSTEM_ITEMS_VL B       
  where B.INVENTORY_ITEM_ID =  XXX.ITEM_ID 
  --and    B.ORGANIZATION_ID  = SHIPPING.ORG_ID     
  )                                                                            						RES_ITEMS_NAME,
 '' RES_DESCRIPTION,
 (SELECT UNIT_OF_MEASURE
	FROM INV_UNITS_OF_MEASURE_VL
	WHERE UOM_CODE = XXX.PRICING_UOM_CODE     )                                                     RES_PRICING_UOM,
 decode(XXX.PRIMARY_PRICING_UOM_FLAG ,'Y','Yes','No')                                           RES_PRIMARY_PRICING_UOM,
to_char(CHARGES.START_DATE,'DD-Mon-YYYY hh24:MI:SS')                      	    					RES_START_DATE,
to_char(CHARGES.END_DATE ,'DD-Mon-YYYY hh24:MI:SS')                       	    					RES_END_DATE,

( SELECT MEANING
	FROM FND_LOOKUPS
  where LOOKUP_TYPE = 'ORA_QP_CALCULATION_METHODS'
  and   LOOKUP_CODE =   CHARGES.CALCULATION_METHOD_CODE  
)                                                                                         			RES_CALCULATION_METHOD,
CHARGES.BASE_PRICE                                                                        			RES_BASE_PRICE,
( SELECT MEANING
	FROM FND_LOOKUPS
  where LOOKUP_TYPE = 'OKC_SAGR_PRICE_ADJ_TYPES'
  and   LOOKUP_CODE = CHARGES.CALCULATION_TYPE_CODE             
)                                                                                           		RES_CALCULATION_TYPE,
CHARGES.COST_CALCULATION_AMOUNT                                                         			RES_COST_CALCULATION_AMOUNT,
decode(CHARGES.CAN_ADJUST_FLAG,'Y','Yes','No')                                                  RES_ALLOW_MANUAL_ADJUSTMENT,

 SHIPPING.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,SHIPPING.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,SHIPPING.CREATED_BY RSC_CREATED_BY
,SHIPPING.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,SHIPPING.ORG_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM   QP_SHIPPING_CHARGES  CHARGES
     , QP_SHIPPING_CHARGE_LISTS_VL    SHIPPING
     , QP_SHIPPING_DETAILS  XXX
WHERE SHIPPING.SHIPPING_CHARGE_LIST_ID =  CHARGES.SHIPPING_CHARGE_LIST_ID
and  XXX.RULE_TYPE_CODE  = 'ORA_ITEM_SHIP_METHOD'
and XXX.ITEM_LEVEL_CODE  = 'ITEM'
and CHARGES.SHIPPING_DETAIL_ID =  XXX.SHIPPING_DETAIL_ID(+)
 and CHARGES.SHIPPING_CHARGE_LIST_ID =  XXX.SHIPPING_CHARGE_LIST_ID(+)
ORDER BY SHIPPING.NAME ,CHARGES.CHARGE_DEFINITION_ID,RES_SHIPPING_METHOD