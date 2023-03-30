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
,QpDiscountListsTl.DESCRIPTION RES_DESCRIPTION
,(SELECT CURRENCY_CODE||' - '||NAME
	FROM FND_CURRENCIES_VL
	WHERE CURRENCY_CODE = QpDiscountListsAllB.CURRENCY_CODE
	) RES_CURRENCY
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = QpDiscountListsAllB.ORG_ID
	AND SYSDATE BETWEEN DATE_FROM AND DATE_TO
	) RES_BUSINESS_UNIT
,TO_CHAR(QpDiscountListsAllB.START_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_START_DATE
,TO_CHAR(QpDiscountListsAllB.END_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_END_DATE
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