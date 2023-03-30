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
-- DFF_LOGIC_TO_APPLY=707##RES##CST_ELEMENT_ANALYSIS_GROUPS
-- DFF_ATTRIBUTES=ATTRIBUTE_CHAR,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE,ATTRIBUTE_TIMESTAMP

-- IMPORTANT:
--  - the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.

SELECT CostElementPEO.COST_ELEMENT_CODE RES_COST_ELEMENT
,(SELECT SET_NAME
	FROM FND_SETID_SETS_VL
	WHERE SET_ID = CostElementPEO.SET_ID
	) RES_COST_ELEMENT_SET
,AnalysisGroupPEO.ANALYSIS_GROUP_CODE RES_ANALYSIS_GROUP
,AnalysisCodePEO.ANALYSIS_CODE RES_ANALYSIS_CODE
,ElementAnalysisGroupEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR1
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR2
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR3
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR4
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR5
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR6
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR7
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR8
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR9
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR10
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR11
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR12
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR13
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR14
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR15
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR16
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR17
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR18
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR19
,ElementAnalysisGroupEO.ATTRIBUTE_CHAR20
,ElementAnalysisGroupEO.ATTRIBUTE_NUMBER1
,ElementAnalysisGroupEO.ATTRIBUTE_NUMBER2
,ElementAnalysisGroupEO.ATTRIBUTE_NUMBER3
,ElementAnalysisGroupEO.ATTRIBUTE_NUMBER4
,ElementAnalysisGroupEO.ATTRIBUTE_NUMBER5
,ElementAnalysisGroupEO.ATTRIBUTE_NUMBER6
,ElementAnalysisGroupEO.ATTRIBUTE_NUMBER7
,ElementAnalysisGroupEO.ATTRIBUTE_NUMBER8
,ElementAnalysisGroupEO.ATTRIBUTE_NUMBER9
,ElementAnalysisGroupEO.ATTRIBUTE_NUMBER10
,TO_CHAR(ElementAnalysisGroupEO.ATTRIBUTE_DATE1,'DD-Mon-YYYY') ATTRIBUTE_DATE1
,TO_CHAR(ElementAnalysisGroupEO.ATTRIBUTE_DATE2,'DD-Mon-YYYY') ATTRIBUTE_DATE2
,TO_CHAR(ElementAnalysisGroupEO.ATTRIBUTE_DATE3,'DD-Mon-YYYY') ATTRIBUTE_DATE3
,TO_CHAR(ElementAnalysisGroupEO.ATTRIBUTE_DATE4,'DD-Mon-YYYY') ATTRIBUTE_DATE4
,TO_CHAR(ElementAnalysisGroupEO.ATTRIBUTE_DATE5,'DD-Mon-YYYY') ATTRIBUTE_DATE5
,ElementAnalysisGroupEO.ATTRIBUTE_TIMESTAMP1
,ElementAnalysisGroupEO.ATTRIBUTE_TIMESTAMP2
,ElementAnalysisGroupEO.ATTRIBUTE_TIMESTAMP3
,ElementAnalysisGroupEO.ATTRIBUTE_TIMESTAMP4
,ElementAnalysisGroupEO.ATTRIBUTE_TIMESTAMP5
,ElementAnalysisGroupEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ElementAnalysisGroupEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ElementAnalysisGroupEO.CREATED_BY RSC_CREATED_BY
,ElementAnalysisGroupEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,CostElementPEO.INV_ORG_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_COST_ELEMENTS_VL CostElementPEO
,CST_ELEMENT_ANALYSIS_GROUPS ElementAnalysisGroupEO
,CST_ANALYSIS_GROUPS_VL AnalysisGroupPEO
,CST_ANALYSIS_CODES_VL AnalysisCodePEO
WHERE ElementAnalysisGroupEO.ANALYSIS_GROUP_ID = AnalysisGroupPEO.ANALYSIS_GROUP_ID
AND ElementAnalysisGroupEO.ANALYSIS_ID         = AnalysisCodePEO.ANALYSIS_ID
AND ElementAnalysisGroupEO.COST_ELEMENT_ID     = CostElementPEO.COST_ELEMENT_ID
AND(ElementAnalysisGroupEO.ATTRIBUTE_CATEGORY IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR1       IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR2       IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR3       IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR4       IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR5       IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR6       IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR7       IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR8       IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR9       IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR10      IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR11      IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR12      IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR13      IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR14      IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR15      IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR16      IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR17      IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR18      IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR19      IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_CHAR20      IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_NUMBER1     IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_NUMBER2     IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_NUMBER3     IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_NUMBER4     IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_NUMBER5     IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_NUMBER6     IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_NUMBER7     IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_NUMBER8     IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_NUMBER9     IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_NUMBER10    IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_DATE1       IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_DATE2       IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_DATE3       IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_DATE4       IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_DATE5       IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_TIMESTAMP1  IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_TIMESTAMP2  IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_TIMESTAMP3  IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_TIMESTAMP4  IS NOT NULL
OR ElementAnalysisGroupEO.ATTRIBUTE_TIMESTAMP5  IS NOT NULL)
ORDER BY CostElementPEO.COST_ELEMENT_CODE
,AnalysisGroupPEO.ANALYSIS_GROUP_CODE
,AnalysisCodePEO.ANALYSIS_CODE