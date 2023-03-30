/* ****************************************************************************
 * $Revision$:
 * $Author$:
 * $Date$:
 * $HeadURL$:
 * $Id$:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT (SELECT ORGANIZATION_CODE 
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = CycleCountHE0.ORGANIZATION_ID
	) RES_ORGANIZATION
,CycleCountHE0.CYCLE_COUNT_HEADER_NAME RES_COUNT_NAME
,CategoriesE0.CATEGORY_NAME RES_CATEGORY_NAME
,SystemITEME0.ITEM_NUMBER RES_ITEM
,SystemITEME0.DESCRIPTION RES_ITEM_DESCRIPTION
,DECODE(InvCYCLEITEME0.INCLUDE_IN_SCHEDULE,1,'Yes','No')  RES_INCLUDE_IN_SCHEDULE
,InvCYCLEITEME0.COST_TOLERANCE_POSITIVE RES_ADJUSTMENT_VALUE_TOLERANCE
,InvCYCLEITEME0.COST_TOLERANCE_NEGATIVE RES_ADJUSTMENT_VALUE_TOLERAN_0
,InvCYCLEITEME0.APPROVAL_TOLERANCE_POSITIVE  RES_QUANTITY_VARIANCE_PERCENTA
,InvCYCLEITEME0.APPROVAL_TOLERANCE_NEGATIVE RES_QUANTITY_VARIANCE_PERCEN_1
,InvCYCLEITEME0.ITEM_LAST_SCHEDULE_DATE RES_LAST_SCHEDULED_DATE

,InvCYCLEITEME0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,InvCYCLEITEME0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,InvCYCLEITEME0.CREATED_BY  RSC_CREATED_BY
,InvCYCLEITEME0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,InvCYCLEITEME0.ORGANIZATION_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM INV_CYCLE_COUNT_HEADERS CycleCountHE0
,INV_CYCLE_COUNT_ITEMS InvCYCLEITEME0
,EGP_CATEGORIES_VL CategoriesE0
,EGP_SYSTEM_ITEMS_VL  SystemITEME0
WHERE CycleCountHE0.CYCLE_COUNT_HEADER_ID = InvCYCLEITEME0.CYCLE_COUNT_HEADER_ID
AND CycleCountHE0.ORGANIZATION_ID = InvCYCLEITEME0.ORGANIZATION_ID
AND InvCYCLEITEME0.ABC_CLASS_ID = CategoriesE0.CATEGORY_ID
AND InvCYCLEITEME0.INVENTORY_ITEM_ID = SystemITEME0.INVENTORY_ITEM_ID
AND InvCYCLEITEME0.ORGANIZATION_ID = SystemITEME0.ORGANIZATION_ID
ORDER BY 1,2,3