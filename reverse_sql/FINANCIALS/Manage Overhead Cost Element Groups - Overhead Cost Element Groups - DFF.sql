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
-- DFF_LOGIC_TO_APPLY=707##RES##CST_COST_ELEMENT_GRPS_B
-- DFF_ATTRIBUTES=ATTRIBUTE_CHAR,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE,ATTRIBUTE_TIMESTAMP

-- IMPORTANT:
--  - the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.

SELECT DECODE(CstElementGrpE0.COST_ORGANIZATION_ID,NULL,'All'
	,(SELECT NAME
		FROM HR_ORGANIZATION_V
		WHERE CLASSIFICATION_CODE = 'CST'
		AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
		AND ORGANIZATION_ID = CstElementGrpE0.COST_ORGANIZATION_ID
		)
	) RES_COST_ORGANIZATION
,CstElementGrpE0.GROUP_CODE RES_GROUP_NAME
,CstElementGrpE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,CstElementGrpE0.ATTRIBUTE_CHAR1
,CstElementGrpE0.ATTRIBUTE_CHAR2
,CstElementGrpE0.ATTRIBUTE_CHAR3
,CstElementGrpE0.ATTRIBUTE_CHAR4
,CstElementGrpE0.ATTRIBUTE_CHAR5
,CstElementGrpE0.ATTRIBUTE_CHAR6
,CstElementGrpE0.ATTRIBUTE_CHAR7
,CstElementGrpE0.ATTRIBUTE_CHAR8
,CstElementGrpE0.ATTRIBUTE_CHAR9
,CstElementGrpE0.ATTRIBUTE_CHAR10
,CstElementGrpE0.ATTRIBUTE_CHAR11
,CstElementGrpE0.ATTRIBUTE_CHAR12
,CstElementGrpE0.ATTRIBUTE_CHAR13
,CstElementGrpE0.ATTRIBUTE_CHAR14
,CstElementGrpE0.ATTRIBUTE_CHAR15
,CstElementGrpE0.ATTRIBUTE_CHAR16
,CstElementGrpE0.ATTRIBUTE_CHAR17
,CstElementGrpE0.ATTRIBUTE_CHAR18
,CstElementGrpE0.ATTRIBUTE_CHAR19
,CstElementGrpE0.ATTRIBUTE_CHAR20
,CstElementGrpE0.ATTRIBUTE_NUMBER1
,CstElementGrpE0.ATTRIBUTE_NUMBER2
,CstElementGrpE0.ATTRIBUTE_NUMBER3
,CstElementGrpE0.ATTRIBUTE_NUMBER4
,CstElementGrpE0.ATTRIBUTE_NUMBER5
,CstElementGrpE0.ATTRIBUTE_NUMBER6
,CstElementGrpE0.ATTRIBUTE_NUMBER7
,CstElementGrpE0.ATTRIBUTE_NUMBER8
,CstElementGrpE0.ATTRIBUTE_NUMBER9
,CstElementGrpE0.ATTRIBUTE_NUMBER10
,TO_CHAR(CstElementGrpE0.ATTRIBUTE_DATE1,'DD-Mon-YYYY') ATTRIBUTE_DATE1
,TO_CHAR(CstElementGrpE0.ATTRIBUTE_DATE2,'DD-Mon-YYYY') ATTRIBUTE_DATE2
,TO_CHAR(CstElementGrpE0.ATTRIBUTE_DATE3,'DD-Mon-YYYY') ATTRIBUTE_DATE3
,TO_CHAR(CstElementGrpE0.ATTRIBUTE_DATE4,'DD-Mon-YYYY') ATTRIBUTE_DATE4
,TO_CHAR(CstElementGrpE0.ATTRIBUTE_DATE5,'DD-Mon-YYYY') ATTRIBUTE_DATE5
,CstElementGrpE0.ATTRIBUTE_TIMESTAMP1
,CstElementGrpE0.ATTRIBUTE_TIMESTAMP2
,CstElementGrpE0.ATTRIBUTE_TIMESTAMP3
,CstElementGrpE0.ATTRIBUTE_TIMESTAMP4
,CstElementGrpE0.ATTRIBUTE_TIMESTAMP5
,CstElementGrpE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CstElementGrpE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CstElementGrpE0.CREATED_BY RSC_CREATED_BY
,CstElementGrpE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,CstElementGrpE0.COST_ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_COST_ELEMENT_GRPS_VL CstElementGrpE0
WHERE(CstElementGrpE0.ATTRIBUTE_CATEGORY IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR1       IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR2       IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR3       IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR4       IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR5       IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR6       IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR7       IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR8       IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR9       IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR10      IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR11      IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR12      IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR13      IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR14      IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR15      IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR16      IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR17      IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR18      IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR19      IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_CHAR20      IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_NUMBER1     IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_NUMBER2     IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_NUMBER3     IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_NUMBER4     IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_NUMBER5     IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_NUMBER6     IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_NUMBER7     IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_NUMBER8     IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_NUMBER9     IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_NUMBER10    IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_DATE1       IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_DATE2       IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_DATE3       IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_DATE4       IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_DATE5       IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_TIMESTAMP1  IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_TIMESTAMP2  IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_TIMESTAMP3  IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_TIMESTAMP4  IS NOT NULL
OR CstElementGrpE0.ATTRIBUTE_TIMESTAMP5  IS NOT NULL)
ORDER BY DECODE(CstElementGrpE0.IS_SEED,'Y',1,2),1,2