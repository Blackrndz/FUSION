/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-10-31 $:
* $HeadURL:  $:
* $Id: Manage Shipping Charge Lists - Shipping Charge List.sql  $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=QP_SHIPPING_CHARGE_LISTS_VL

select  SHIPPING.NAME                                             			RES_NAME,
SHIPPING.DESCRIPTION                                              			RES_DESCRIPTION,
(select CURRENCYEO.CURRENCY_CODE ||' - ' ||CURRENCYEO.name
from FND_CURRENCIES_VL CURRENCYEO
where CURRENCYEO.CURRENCY_CODE =   SHIPPING.CURRENCY_CODE
and ENABLED_FLAG = 'Y')                 									RES_CURRENCY,
BusinessUnitPEO.BU_NAME                                           			RES_BUSINESS_UNIT,
to_char(SHIPPING.START_DATE,'DD-Mon-YYYY hh24:MI:SS')                      	RES_START_DATE,
to_char(SHIPPING.END_DATE ,'DD-Mon-YYYY hh24:MI:SS')                       	RES_END_DATE
,SHIPPING.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
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

FROM  QP_SHIPPING_CHARGE_LISTS_VL  SHIPPING
,FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
WHERE SHIPPING.ORG_ID =  BusinessUnitPEO.bu_id(+) 
ORDER BY SHIPPING.NAME 