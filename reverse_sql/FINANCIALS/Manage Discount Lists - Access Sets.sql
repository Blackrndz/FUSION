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
-- RSC_PREREQUISITE_OBJECTS=QP_DISCOUNT_LISTS_ALL_B_ST

SELECT QpDiscountListsTl.NAME RES_NAME
,FndSetidSets.SET_CODE RES_SET_CODE
,FndSetidSets.SET_NAME RES_SET_NAME
,FndSetidSets.DESCRIPTION RES_DESCRIPTION
,QpDiscountListsAllBSt.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,QpDiscountListsAllBSt.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,QpDiscountListsAllBSt.CREATED_BY  RSC_CREATED_BY
,QpDiscountListsAllBSt.CREATION_DATE  RSC_CREATION_DATE
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
,QP_DISCOUNT_LISTS_ALL_B_ST QpDiscountListsAllBSt
,FND_SETID_SETS FndSetidSets
WHERE QpDiscountListsTl.DISCOUNT_LIST_ID = QpDiscountListsAllBSt.DISCOUNT_LIST_ID
AND QpDiscountListsTl.DISCOUNT_LIST_ID = QpDiscountListsAllB.DISCOUNT_LIST_ID
AND QpDiscountListsAllBSt.SET_ID = FndSetidSets.SET_ID
AND QpDiscountListsTl.LANGUAGE = USERENV('LANG')
AND FndSetidSets.LANGUAGE = USERENV('LANG')
ORDER BY QpDiscountListsTl.NAME
,FndSetidSets.SET_CODE