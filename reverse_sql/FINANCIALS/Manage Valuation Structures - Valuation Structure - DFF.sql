/* ****************************************************************************
* $Revision: 55454 $:
* $Author: dhara.pithadiya $:
* $Date: 2016-05-25 18:58:04 +0700 (Wed, 25 May 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Line%20Ordering%20Rules%20-%20AutoInvoice%20Line%20Ordering%20Rules%20-%20DFF.sql $:
* $Id: Manage AutoInvoice Line Ordering Rules - AutoInvoice Line Ordering Rules - DFF.sql 55454 2016-05-25 11:58:04Z dhara.pithadiya $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=707##RES##CST_VAL_STRUCTURES_B
-- DFF_ATTRIBUTES=ATTRIBUTE_CHAR,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE,ATTRIBUTE_TIMESTAMP

-- IMPORTANT:
--  - the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.

SELECT SetIdSetPEO.SET_NAME RES_VALUATION_STRUCTURE_SET
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'CST_VALUATION_STRUCTURE_TYPES'
	AND LOOKUP_CODE   = ValStructureEO.VAL_STRUCTURE_TYPE_CODE
	) RES_VALUATION_STRUCTURE_TYPE
,ValStructureEO.VAL_STRUCTURE_CODE RES_VALUATION_STRUCTURE_CODE
,ValStructureEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,ValStructureEO.ATTRIBUTE_CHAR1
,ValStructureEO.ATTRIBUTE_CHAR2
,ValStructureEO.ATTRIBUTE_CHAR3
,ValStructureEO.ATTRIBUTE_CHAR4
,ValStructureEO.ATTRIBUTE_CHAR5
,ValStructureEO.ATTRIBUTE_CHAR6
,ValStructureEO.ATTRIBUTE_CHAR7
,ValStructureEO.ATTRIBUTE_CHAR8
,ValStructureEO.ATTRIBUTE_CHAR9
,ValStructureEO.ATTRIBUTE_CHAR10
,ValStructureEO.ATTRIBUTE_CHAR11
,ValStructureEO.ATTRIBUTE_CHAR12
,ValStructureEO.ATTRIBUTE_CHAR13
,ValStructureEO.ATTRIBUTE_CHAR14
,ValStructureEO.ATTRIBUTE_CHAR15
,ValStructureEO.ATTRIBUTE_CHAR16
,ValStructureEO.ATTRIBUTE_CHAR17
,ValStructureEO.ATTRIBUTE_CHAR18
,ValStructureEO.ATTRIBUTE_CHAR19
,ValStructureEO.ATTRIBUTE_CHAR20
,ValStructureEO.ATTRIBUTE_NUMBER1
,ValStructureEO.ATTRIBUTE_NUMBER2
,ValStructureEO.ATTRIBUTE_NUMBER3
,ValStructureEO.ATTRIBUTE_NUMBER4
,ValStructureEO.ATTRIBUTE_NUMBER5
,ValStructureEO.ATTRIBUTE_NUMBER6
,ValStructureEO.ATTRIBUTE_NUMBER7
,ValStructureEO.ATTRIBUTE_NUMBER8
,ValStructureEO.ATTRIBUTE_NUMBER9
,ValStructureEO.ATTRIBUTE_NUMBER10
,TO_CHAR(ValStructureEO.ATTRIBUTE_DATE1,'DD-Mon-YYYY') ATTRIBUTE_DATE1
,TO_CHAR(ValStructureEO.ATTRIBUTE_DATE2,'DD-Mon-YYYY') ATTRIBUTE_DATE2
,TO_CHAR(ValStructureEO.ATTRIBUTE_DATE3,'DD-Mon-YYYY') ATTRIBUTE_DATE3
,TO_CHAR(ValStructureEO.ATTRIBUTE_DATE4,'DD-Mon-YYYY') ATTRIBUTE_DATE4
,TO_CHAR(ValStructureEO.ATTRIBUTE_DATE5,'DD-Mon-YYYY') ATTRIBUTE_DATE5
,ValStructureEO.ATTRIBUTE_TIMESTAMP1
,ValStructureEO.ATTRIBUTE_TIMESTAMP2
,ValStructureEO.ATTRIBUTE_TIMESTAMP3
,ValStructureEO.ATTRIBUTE_TIMESTAMP4
,ValStructureEO.ATTRIBUTE_TIMESTAMP5
,ValStructureEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ValStructureEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ValStructureEO.CREATED_BY RSC_CREATED_BY
,ValStructureEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_VAL_STRUCTURES_VL ValStructureEO
,FND_SETID_SETS_VL SetIdSetPEO
WHERE ValStructureEO.SET_ID             = SetIdSetPEO.SET_ID
AND(ValStructureEO.ATTRIBUTE_CATEGORY  IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR1      IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR2      IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR3      IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR4      IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR5      IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR6      IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR7      IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR8      IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR9      IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR10     IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR11     IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR12     IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR13     IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR14     IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR15     IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR16     IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR17     IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR18     IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR19     IS NOT NULL
OR ValStructureEO.ATTRIBUTE_CHAR20     IS NOT NULL
OR ValStructureEO.ATTRIBUTE_NUMBER1    IS NOT NULL
OR ValStructureEO.ATTRIBUTE_NUMBER2    IS NOT NULL
OR ValStructureEO.ATTRIBUTE_NUMBER3    IS NOT NULL
OR ValStructureEO.ATTRIBUTE_NUMBER4    IS NOT NULL
OR ValStructureEO.ATTRIBUTE_NUMBER5    IS NOT NULL
OR ValStructureEO.ATTRIBUTE_NUMBER6    IS NOT NULL
OR ValStructureEO.ATTRIBUTE_NUMBER7    IS NOT NULL
OR ValStructureEO.ATTRIBUTE_NUMBER8    IS NOT NULL
OR ValStructureEO.ATTRIBUTE_NUMBER9    IS NOT NULL
OR ValStructureEO.ATTRIBUTE_NUMBER10   IS NOT NULL
OR ValStructureEO.ATTRIBUTE_DATE1      IS NOT NULL
OR ValStructureEO.ATTRIBUTE_DATE2      IS NOT NULL
OR ValStructureEO.ATTRIBUTE_DATE3      IS NOT NULL
OR ValStructureEO.ATTRIBUTE_DATE4      IS NOT NULL
OR ValStructureEO.ATTRIBUTE_DATE5      IS NOT NULL
OR ValStructureEO.ATTRIBUTE_TIMESTAMP1 IS NOT NULL
OR ValStructureEO.ATTRIBUTE_TIMESTAMP2 IS NOT NULL
OR ValStructureEO.ATTRIBUTE_TIMESTAMP3 IS NOT NULL
OR ValStructureEO.ATTRIBUTE_TIMESTAMP4 IS NOT NULL
OR ValStructureEO.ATTRIBUTE_TIMESTAMP5 IS NOT NULL)
ORDER BY ValStructureEO.VAL_STRUCTURE_CODE