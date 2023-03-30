/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=INV_PICK_GROUPING_RULES_VL

SELECT InvPickGroupingRules.PICK_GROUPING_RULE_NAME RES_NAME
,InvPickGroupingRules.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(InvPickGroupingRules.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(InvPickGroupingRules.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
,DECODE(InvPickGroupingRules.ORDER_NUMBER_FLAG,'Y','Yes','No') RES_ORDER_NUMBER
,DECODE(InvPickGroupingRules.CUSTOMER_FLAG,'Y','Yes','No') RES_CUSTOMER
,DECODE(InvPickGroupingRules.SHIP_TO_FLAG,'Y','Yes','No') RES_SHIP_TO_LOCATION
,DECODE(InvPickGroupingRules.CARRIER_FLAG,'Y','Yes','No') RES_CARRIER
,DECODE(InvPickGroupingRules.DELIVERY_FLAG,'Y','Yes','No') RES_SHIPMENT
,DECODE(InvPickGroupingRules.SHIPMENT_PRIORITY_FLAG,'Y','Yes','No') RES_SHIPPING_PRIORITY
,DECODE(InvPickGroupingRules.ITEM_FLAG,'Y','Yes','No') RES_ITEM
,DECODE(InvPickGroupingRules.SUBINVENTORY_FLAG,'Y','Yes','No') RES_SOURCE_SUBINVENTORY
,DECODE(InvPickGroupingRules.LOCATOR_FLAG,'Y','Yes','No') RES_SOURCE_LOCATOR
,DECODE(InvPickGroupingRules.DEST_ORG_FLAG,'Y','Yes','No') RES_DESTINATION_ORGANIZATION
,DECODE(InvPickGroupingRules.DEST_SUB_FLAG,'Y','Yes','No') RES_DESTINATION_SUBINVENTORY
,DECODE(InvPickGroupingRules.DEST_LOC_FLAG,'Y','Yes','No') RES_DESTINATION_LOCATOR
,DECODE(InvPickGroupingRules.WORKAREA_FLAG,'Y','Yes','No') RES_WORK_AREA
,DECODE(InvPickGroupingRules.ORDER_NUMBER_FLAG,'Y','Yes','No') RES_WORK_CENTER
,DECODE(InvPickGroupingRules.DEPARTMENT_FLAG,'Y','Yes','No') RES_OPERATION
,DECODE(InvPickGroupingRules.PUSH_VS_PULL_FLAG,'Y','Yes','No' )RES_PUSH_OR_PULL
,DECODE(InvPickGroupingRules.PROJECT_FLAG,'Y','Yes','No') RES_PROJECT
,DECODE(InvPickGroupingRules.TASK_FLAG,'Y','Yes','No') RES_TASK
,InvPickGroupingRules.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,InvPickGroupingRules.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,InvPickGroupingRules.CREATED_BY RSC_CREATED_BY
,InvPickGroupingRules.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_PICK_GROUPING_RULES_VL InvPickGroupingRules
ORDER BY InvPickGroupingRules.PICK_GROUPING_RULE_NAME