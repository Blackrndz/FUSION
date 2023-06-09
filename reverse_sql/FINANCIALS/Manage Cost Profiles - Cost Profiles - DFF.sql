/* ****************************************************************************
 * $Revision: 54470 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-04-19 10:52:05 +0700 (Tue, 19 Apr 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Contact%20Point%20Lookups%20-%20Lookup%20Codes.sql $:
 * $Id: Manage Contact Point Lookups - Lookup Codes.sql 54470 2016-04-19 03:52:05Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
  
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=707##RES##CST_COST_PROFILES_B
-- DFF_ATTRIBUTES=ATTRIBUTE_CHAR,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE,ATTRIBUTE_TIMESTAMP

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT CostProfileEO.COST_PROFILE_CODE RES_COST_PROFILE
,CostProfileEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,CostProfileEO.ATTRIBUTE_CHAR1
,CostProfileEO.ATTRIBUTE_CHAR2
,CostProfileEO.ATTRIBUTE_CHAR3
,CostProfileEO.ATTRIBUTE_CHAR4
,CostProfileEO.ATTRIBUTE_CHAR5
,CostProfileEO.ATTRIBUTE_CHAR6
,CostProfileEO.ATTRIBUTE_CHAR7
,CostProfileEO.ATTRIBUTE_CHAR8
,CostProfileEO.ATTRIBUTE_CHAR9
,CostProfileEO.ATTRIBUTE_CHAR10
,CostProfileEO.ATTRIBUTE_CHAR11
,CostProfileEO.ATTRIBUTE_CHAR12
,CostProfileEO.ATTRIBUTE_CHAR13
,CostProfileEO.ATTRIBUTE_CHAR14
,CostProfileEO.ATTRIBUTE_CHAR15
,CostProfileEO.ATTRIBUTE_CHAR16
,CostProfileEO.ATTRIBUTE_CHAR17
,CostProfileEO.ATTRIBUTE_CHAR18
,CostProfileEO.ATTRIBUTE_CHAR19
,CostProfileEO.ATTRIBUTE_CHAR20
,CostProfileEO.ATTRIBUTE_NUMBER1
,CostProfileEO.ATTRIBUTE_NUMBER2
,CostProfileEO.ATTRIBUTE_NUMBER3
,CostProfileEO.ATTRIBUTE_NUMBER4
,CostProfileEO.ATTRIBUTE_NUMBER5
,CostProfileEO.ATTRIBUTE_NUMBER6
,CostProfileEO.ATTRIBUTE_NUMBER7
,CostProfileEO.ATTRIBUTE_NUMBER8
,CostProfileEO.ATTRIBUTE_NUMBER9
,CostProfileEO.ATTRIBUTE_NUMBER10
,TO_CHAR(CostProfileEO.ATTRIBUTE_DATE1,'DD-Mon-YYYY') ATTRIBUTE_DATE1
,TO_CHAR(CostProfileEO.ATTRIBUTE_DATE2,'DD-Mon-YYYY') ATTRIBUTE_DATE2
,TO_CHAR(CostProfileEO.ATTRIBUTE_DATE3,'DD-Mon-YYYY') ATTRIBUTE_DATE3
,TO_CHAR(CostProfileEO.ATTRIBUTE_DATE4,'DD-Mon-YYYY') ATTRIBUTE_DATE4
,TO_CHAR(CostProfileEO.ATTRIBUTE_DATE5,'DD-Mon-YYYY') ATTRIBUTE_DATE5
,CostProfileEO.ATTRIBUTE_TIMESTAMP1
,CostProfileEO.ATTRIBUTE_TIMESTAMP2
,CostProfileEO.ATTRIBUTE_TIMESTAMP3
,CostProfileEO.ATTRIBUTE_TIMESTAMP4
,CostProfileEO.ATTRIBUTE_TIMESTAMP5
,CostProfileEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CostProfileEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CostProfileEO.CREATED_BY RSC_CREATED_BY
,CostProfileEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_COST_PROFILES_VL CostProfileEO
WHERE(CostProfileEO.ATTRIBUTE_CATEGORY IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR1       IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR2       IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR3       IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR4       IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR5       IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR6       IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR7       IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR8       IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR9       IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR10      IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR11      IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR12      IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR13      IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR14      IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR15      IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR16      IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR17      IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR18      IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR19      IS NOT NULL
OR CostProfileEO.ATTRIBUTE_CHAR20      IS NOT NULL
OR CostProfileEO.ATTRIBUTE_NUMBER1     IS NOT NULL
OR CostProfileEO.ATTRIBUTE_NUMBER2     IS NOT NULL
OR CostProfileEO.ATTRIBUTE_NUMBER3     IS NOT NULL
OR CostProfileEO.ATTRIBUTE_NUMBER4     IS NOT NULL
OR CostProfileEO.ATTRIBUTE_NUMBER5     IS NOT NULL
OR CostProfileEO.ATTRIBUTE_NUMBER6     IS NOT NULL
OR CostProfileEO.ATTRIBUTE_NUMBER7     IS NOT NULL
OR CostProfileEO.ATTRIBUTE_NUMBER8     IS NOT NULL
OR CostProfileEO.ATTRIBUTE_NUMBER9     IS NOT NULL
OR CostProfileEO.ATTRIBUTE_NUMBER10    IS NOT NULL
OR CostProfileEO.ATTRIBUTE_DATE1       IS NOT NULL
OR CostProfileEO.ATTRIBUTE_DATE2       IS NOT NULL
OR CostProfileEO.ATTRIBUTE_DATE3       IS NOT NULL
OR CostProfileEO.ATTRIBUTE_DATE4       IS NOT NULL
OR CostProfileEO.ATTRIBUTE_DATE5       IS NOT NULL
OR CostProfileEO.ATTRIBUTE_TIMESTAMP1  IS NOT NULL
OR CostProfileEO.ATTRIBUTE_TIMESTAMP2  IS NOT NULL
OR CostProfileEO.ATTRIBUTE_TIMESTAMP3  IS NOT NULL
OR CostProfileEO.ATTRIBUTE_TIMESTAMP4  IS NOT NULL
OR CostProfileEO.ATTRIBUTE_TIMESTAMP5  IS NOT NULL)
ORDER BY CostProfileEO.COST_PROFILE_CODE