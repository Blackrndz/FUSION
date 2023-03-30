 /* ****************************************************************************
 * $Revision: 48884 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2015-08-18 14:24:02 +0700 (Tue, 18 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Types%20-%20Manage%20Transaction%20Types.sql $:
 * $Id: Manage Transaction Types - Manage Transaction Types.sql 48884 2015-08-18 07:24:02Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=QP_DISCOUNT_LISTS_TL 
-- RSC_PREREQUISITE_OBJECTS=QP_DISCOUNT_LISTS_ALL_B 
-- RSC_PREREQUISITE_OBJECTS=QP_DISCOUNT_LIST_ITEMS

SELECT QpDiscountListsTl.NAME RES_NAME
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_QP_ITEM_LEVELS'
	AND LOOKUP_CODE = QpDiscountListItems.ITEM_LEVEL_CODE
	) RES_ITEM_LEVEL
,(SELECT ITEM_NUMBER
	FROM EGP_SYSTEM_ITEMS_VL
	WHERE INVENTORY_ITEM_ID = QpDiscountListItems.ITEM_ID
	AND INVENTORY_ORGANIZATION_ID = QpDiscountListsAllB.ORG_ID
	) RES_DISCOUNT_LINES_NAME
,(SELECT DESCRIPTION
	FROM EGP_SYSTEM_ITEMS_VL
	WHERE INVENTORY_ITEM_ID = QpDiscountListItems.ITEM_ID
	AND INVENTORY_ORGANIZATION_ID = QpDiscountListsAllB.ORG_ID
	) RES_DESCRIPTION
,(SELECT UNIT_OF_MEASURE
	FROM INV_UNITS_OF_MEASURE_VL
	WHERE UOM_CODE = QpDiscountListItems.PRICING_UOM_CODE
	) RES_PRICING_UOM
,DECODE(QpDiscountListItems.LINE_TYPE_CODE,'ALL','All',(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE IN('ORA_QP_RETURN_LINE_TYPES','ORA_QP_ORDER_LINE_TYPES')
	AND LOOKUP_CODE = QpDiscountListItems.LINE_TYPE_CODE
	)) RES_LINE_TYPE
,QpDiscountListItems.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,QpDiscountListItems.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,QpDiscountListItems.CREATED_BY  RSC_CREATED_BY
,QpDiscountListItems.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,QpDiscountListsAllB.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM QP_DISCOUNT_LISTS_TL QpDiscountListsTl
,QP_DISCOUNT_LISTS_ALL_B QpDiscountListsAllB
,QP_DISCOUNT_LIST_ITEMS QpDiscountListItems
WHERE QpDiscountListsTl.DISCOUNT_LIST_ID = QpDiscountListsAllB.DISCOUNT_LIST_ID
AND QpDiscountListsTl.DISCOUNT_LIST_ID = QpDiscountListItems.DISCOUNT_LIST_ID
AND QpDiscountListsTl.LANGUAGE = USERENV('LANG')
ORDER BY QpDiscountListsTl.NAME
,RES_ITEM_LEVEL
,RES_DISCOUNT_LINES_NAME