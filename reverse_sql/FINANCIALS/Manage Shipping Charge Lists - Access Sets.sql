/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-11-03 $:
* $HeadURL:  $:
* $Id: Manage Shipping Charge Lists - Access Sets.sql  $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=QP_SHIPPING_CHARGE_LISTS_VL
-- RSC_PREREQUISITE_OBJECTS=QP_SHIPPING_CHARGE_LISTS_ST

select  SHIPPING.NAME                                             			        RES_NAME,
ACC_SET.SET_CODE                                              			            RES_SET_CODE,
ACC_SET.SET_NAME                                                                 	RES_SET_NAME,
ACC_SET.DESCRIPTION                                                              	RES_SET_DESCRIPTION,

SHIPPING_ST.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,SHIPPING_ST.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,SHIPPING_ST.CREATED_BY RSC_CREATED_BY
,SHIPPING_ST.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,SHIPPING.ORG_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM  QP_SHIPPING_CHARGE_LISTS_VL  SHIPPING
     , QP_SHIPPING_CHARGE_LISTS_ST  SHIPPING_ST
     , FND_SETID_SETS_VL  ACC_SET
WHERE SHIPPING.SHIPPING_CHARGE_LIST_ID =  SHIPPING_ST.SHIPPING_CHARGE_LIST_ID
AND   SHIPPING_ST.SET_ID  = ACC_SET.SET_ID
ORDER BY SHIPPING.NAME 