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

SELECT QpDiscountListsTl.NAME RES_NAME
,DECODE(QpDiscountListsAllB.LINE_TYPE_CODE,'ALL','All',(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE IN('ORA_QP_RETURN_LINE_TYPES','ORA_QP_ORDER_LINE_TYPES')
	AND LOOKUP_CODE = QpDiscountListsAllB.LINE_TYPE_CODE
	)) RES_LINE_TYPE
,DECODE(QpDiscountListsAllB.PRICE_TYPE_CODE,'ALL','All',(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_QP_PRICE_TYPES'
	AND LOOKUP_CODE = QpDiscountListsAllB.PRICE_TYPE_CODE
	)) RES_PRICE_TYPE
,DECODE(QpDiscountListsAllB.CHARGE_TYPE_CODE,'ALL','All',(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_QP_CHARGE_TYPES'
	AND LOOKUP_CODE = QpDiscountListsAllB.CHARGE_TYPE_CODE
	)) RES_CHARGE_TYPE
,DECODE(QpDiscountListsAllB.CHARGE_SUBTYPE_CODE,'ALL','All',(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_QP_CHARGE_SUBTYPES'
	AND LOOKUP_CODE = QpDiscountListsAllB.CHARGE_SUBTYPE_CODE
	)) RES_CHARGE_SUBTYPE
,(CASE
	WHEN QpDiscountListsAllB.PRICE_TYPE_CODE = 'ALL' THEN
		'All'
	ELSE 
		DECODE(QpDiscountListsAllB.PRICE_PERIODICITY_CODE,'ALL','All',
			(SELECT UNIT_OF_MEASURE
			FROM INV_UNITS_OF_MEASURE_VL
			WHERE UOM_CODE = QpDiscountListsAllB.PRICE_PERIODICITY_CODE)
		)
	END) RES_PRICE_PERIODICITY
,QpDiscountListsAllB.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,QpDiscountListsAllB.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,QpDiscountListsAllB.CREATED_BY  RSC_CREATED_BY
,QpDiscountListsAllB.CREATION_DATE  RSC_CREATION_DATE
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
WHERE QpDiscountListsTl.DISCOUNT_LIST_ID = QpDiscountListsAllB.DISCOUNT_LIST_ID
AND QpDiscountListsTl.LANGUAGE = USERENV('LANG')
ORDER BY QpDiscountListsTl.NAME