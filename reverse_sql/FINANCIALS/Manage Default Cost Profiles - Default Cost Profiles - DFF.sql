/* ****************************************************************************
* $Revision: 55391 $:
* $Author: dhara.pithadiya $:
* $Date: 2016-05-24 15:07:24 +0700 (Tue, 24 May 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Categories%20-%20Accounts.sql $:
* $Id: Manage Asset Categories - Accounts.sql 55391 2016-05-24 08:07:24Z dhara.pithadiya $:
* ****************************************************************************
* Description:
* ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=707##RES##CST_DEFAULT_COST_PROFILES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT OrganizationUnitPEO.NAME RES_COST_ORGANIZATION
,CostBookPEO.COST_BOOK_CODE RES_COST_BOOK
,CategoryPEO.CATEGORY_NAME RES_CATEGORY_NAME
,DefaultCostProfileEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,DefaultCostProfileEO.ATTRIBUTE_CHAR1
,DefaultCostProfileEO.ATTRIBUTE_CHAR2
,DefaultCostProfileEO.ATTRIBUTE_CHAR3
,DefaultCostProfileEO.ATTRIBUTE_CHAR4
,DefaultCostProfileEO.ATTRIBUTE_CHAR5
,DefaultCostProfileEO.ATTRIBUTE_CHAR6
,DefaultCostProfileEO.ATTRIBUTE_CHAR7
,DefaultCostProfileEO.ATTRIBUTE_CHAR8
,DefaultCostProfileEO.ATTRIBUTE_CHAR9
,DefaultCostProfileEO.ATTRIBUTE_CHAR10
,DefaultCostProfileEO.ATTRIBUTE_CHAR11
,DefaultCostProfileEO.ATTRIBUTE_CHAR12
,DefaultCostProfileEO.ATTRIBUTE_CHAR13
,DefaultCostProfileEO.ATTRIBUTE_CHAR14
,DefaultCostProfileEO.ATTRIBUTE_CHAR15
,DefaultCostProfileEO.ATTRIBUTE_CHAR16
,DefaultCostProfileEO.ATTRIBUTE_CHAR17
,DefaultCostProfileEO.ATTRIBUTE_CHAR18
,DefaultCostProfileEO.ATTRIBUTE_CHAR19
,DefaultCostProfileEO.ATTRIBUTE_CHAR20
,DefaultCostProfileEO.ATTRIBUTE_NUMBER1
,DefaultCostProfileEO.ATTRIBUTE_NUMBER2
,DefaultCostProfileEO.ATTRIBUTE_NUMBER3
,DefaultCostProfileEO.ATTRIBUTE_NUMBER4
,DefaultCostProfileEO.ATTRIBUTE_NUMBER5
,DefaultCostProfileEO.ATTRIBUTE_NUMBER6
,DefaultCostProfileEO.ATTRIBUTE_NUMBER7
,DefaultCostProfileEO.ATTRIBUTE_NUMBER8
,DefaultCostProfileEO.ATTRIBUTE_NUMBER9
,DefaultCostProfileEO.ATTRIBUTE_NUMBER10
,TO_CHAR(DefaultCostProfileEO.ATTRIBUTE_DATE1,'DD-Mon-YYYY') ATTRIBUTE_DATE1
,TO_CHAR(DefaultCostProfileEO.ATTRIBUTE_DATE2,'DD-Mon-YYYY') ATTRIBUTE_DATE2
,TO_CHAR(DefaultCostProfileEO.ATTRIBUTE_DATE3,'DD-Mon-YYYY') ATTRIBUTE_DATE3
,TO_CHAR(DefaultCostProfileEO.ATTRIBUTE_DATE4,'DD-Mon-YYYY') ATTRIBUTE_DATE4
,TO_CHAR(DefaultCostProfileEO.ATTRIBUTE_DATE5,'DD-Mon-YYYY') ATTRIBUTE_DATE5
,DefaultCostProfileEO.ATTRIBUTE_TIMESTAMP1
,DefaultCostProfileEO.ATTRIBUTE_TIMESTAMP2
,DefaultCostProfileEO.ATTRIBUTE_TIMESTAMP3
,DefaultCostProfileEO.ATTRIBUTE_TIMESTAMP4
,DefaultCostProfileEO.ATTRIBUTE_TIMESTAMP5
,DefaultCostProfileEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,DefaultCostProfileEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,DefaultCostProfileEO.CREATED_BY RSC_CREATED_BY
,DefaultCostProfileEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,DefaultCostProfileEO.COST_ORG_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_DEFAULT_COST_PROFILES DefaultCostProfileEO
,HR_ALL_ORGANIZATION_UNITS_F_VL OrganizationUnitPEO
,CST_COST_BOOKS_VL CostBookPEO
,EGP_CATEGORIES_VL CategoryPEO
WHERE DefaultCostProfileEO.COST_ORG_ID = OrganizationUnitPEO.ORGANIZATION_ID
AND SYSDATE BETWEEN OrganizationUnitPEO.EFFECTIVE_START_DATE AND OrganizationUnitPEO.EFFECTIVE_END_DATE
AND DefaultCostProfileEO.COST_BOOK_ID = CostBookPEO.COST_BOOK_ID
AND DefaultCostProfileEO.CATEGORY_ID = CategoryPEO.CATEGORY_ID(+)
AND(DefaultCostProfileEO.ATTRIBUTE_CATEGORY IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR1          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR2          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR3          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR4          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR5          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR6          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR7          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR8          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR9          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR10         IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR11         IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR12         IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR13         IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR14         IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR15         IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR16          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR17          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR18          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR19          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_CHAR20          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_NUMBER1          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_NUMBER2          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_NUMBER3          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_NUMBER4          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_NUMBER5          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_NUMBER6          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_NUMBER7          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_NUMBER8          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_NUMBER9          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_NUMBER10         IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_DATE1          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_DATE2          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_DATE3          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_DATE4          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_DATE5          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_TIMESTAMP1          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_TIMESTAMP2          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_TIMESTAMP3          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_TIMESTAMP4          IS NOT NULL
OR DefaultCostProfileEO.ATTRIBUTE_TIMESTAMP5          IS NOT NULL)
ORDER BY OrganizationUnitPEO.NAME 
,CostBookPEO.COST_BOOK_CODE 