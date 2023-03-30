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

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=667##RES##QP_DISCOUNT_LISTS_FLEX
-- DFF_ATTRIBUTES=ATTRIBUTE_CHAR,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE,ATTRIBUTE_TIMESTAMP

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.
 
SELECT QpDiscountListsTl.NAME RES_NAME
,QpDiscountListsAllB.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,QpDiscountListsAllB.ATTRIBUTE_CHAR1
,QpDiscountListsAllB.ATTRIBUTE_CHAR2
,QpDiscountListsAllB.ATTRIBUTE_CHAR3
,QpDiscountListsAllB.ATTRIBUTE_CHAR4
,QpDiscountListsAllB.ATTRIBUTE_CHAR5
,QpDiscountListsAllB.ATTRIBUTE_CHAR6
,QpDiscountListsAllB.ATTRIBUTE_CHAR7
,QpDiscountListsAllB.ATTRIBUTE_CHAR8
,QpDiscountListsAllB.ATTRIBUTE_CHAR9
,QpDiscountListsAllB.ATTRIBUTE_CHAR10
,QpDiscountListsAllB.ATTRIBUTE_CHAR11
,QpDiscountListsAllB.ATTRIBUTE_CHAR12
,QpDiscountListsAllB.ATTRIBUTE_CHAR13
,QpDiscountListsAllB.ATTRIBUTE_CHAR14
,QpDiscountListsAllB.ATTRIBUTE_CHAR15
,QpDiscountListsAllB.ATTRIBUTE_CHAR16
,QpDiscountListsAllB.ATTRIBUTE_CHAR17
,QpDiscountListsAllB.ATTRIBUTE_CHAR18
,QpDiscountListsAllB.ATTRIBUTE_CHAR19
,QpDiscountListsAllB.ATTRIBUTE_CHAR20
,QpDiscountListsAllB.ATTRIBUTE_NUMBER1
,QpDiscountListsAllB.ATTRIBUTE_NUMBER2
,QpDiscountListsAllB.ATTRIBUTE_NUMBER3
,QpDiscountListsAllB.ATTRIBUTE_NUMBER4
,QpDiscountListsAllB.ATTRIBUTE_NUMBER5
,QpDiscountListsAllB.ATTRIBUTE_NUMBER6
,QpDiscountListsAllB.ATTRIBUTE_NUMBER7
,QpDiscountListsAllB.ATTRIBUTE_NUMBER8
,QpDiscountListsAllB.ATTRIBUTE_NUMBER9
,QpDiscountListsAllB.ATTRIBUTE_NUMBER10
,TO_CHAR(QpDiscountListsAllB.ATTRIBUTE_DATE1,'DD-Mon-YYYY') ATTRIBUTE_DATE1
,TO_CHAR(QpDiscountListsAllB.ATTRIBUTE_DATE2,'DD-Mon-YYYY') ATTRIBUTE_DATE2
,TO_CHAR(QpDiscountListsAllB.ATTRIBUTE_DATE3,'DD-Mon-YYYY') ATTRIBUTE_DATE3
,TO_CHAR(QpDiscountListsAllB.ATTRIBUTE_DATE4,'DD-Mon-YYYY') ATTRIBUTE_DATE4
,TO_CHAR(QpDiscountListsAllB.ATTRIBUTE_DATE5,'DD-Mon-YYYY') ATTRIBUTE_DATE5
,TO_CHAR(QpDiscountListsAllB.ATTRIBUTE_TIMESTAMP1,'DD-Mon-YYYY HH24:MI:SS') ATTRIBUTE_TIMESTAMP1
,TO_CHAR(QpDiscountListsAllB.ATTRIBUTE_TIMESTAMP2,'DD-Mon-YYYY HH24:MI:SS') ATTRIBUTE_TIMESTAMP2
,TO_CHAR(QpDiscountListsAllB.ATTRIBUTE_TIMESTAMP3,'DD-Mon-YYYY HH24:MI:SS') ATTRIBUTE_TIMESTAMP3
,TO_CHAR(QpDiscountListsAllB.ATTRIBUTE_TIMESTAMP4,'DD-Mon-YYYY HH24:MI:SS') ATTRIBUTE_TIMESTAMP4
,TO_CHAR(QpDiscountListsAllB.ATTRIBUTE_TIMESTAMP5,'DD-Mon-YYYY HH24:MI:SS') ATTRIBUTE_TIMESTAMP5
,QpDiscountListsAllB.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,QpDiscountListsAllB.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,QpDiscountListsAllB.CREATED_BY RSC_CREATED_BY
,QpDiscountListsAllB.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,QpDiscountListsAllB.ORG_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM QP_DISCOUNT_LISTS_TL QpDiscountListsTl
,QP_DISCOUNT_LISTS_ALL_B QpDiscountListsAllB
WHERE QpDiscountListsTl.DISCOUNT_LIST_ID = QpDiscountListsAllB.DISCOUNT_LIST_ID
AND QpDiscountListsTl.LANGUAGE = USERENV('LANG')
AND (QpDiscountListsAllB.ATTRIBUTE_CATEGORY IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR1            IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR2            IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR3            IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR4            IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR5            IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR6            IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR7            IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR8            IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR9            IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR10           IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR11           IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR12           IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR13           IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR14           IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR15           IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR16           IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR17           IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR18           IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR19           IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_CHAR20           IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_NUMBER1     IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_NUMBER2     IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_NUMBER3     IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_NUMBER4     IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_NUMBER5     IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_NUMBER6     IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_NUMBER7     IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_NUMBER8     IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_NUMBER9     IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_NUMBER10    IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_DATE1       IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_DATE2       IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_DATE3       IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_DATE4       IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_DATE5       IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_TIMESTAMP1       IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_TIMESTAMP2       IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_TIMESTAMP3       IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_TIMESTAMP4       IS NOT NULL
OR QpDiscountListsAllB.ATTRIBUTE_TIMESTAMP5      IS NOT NULL)
ORDER BY QpDiscountListsTl.NAME