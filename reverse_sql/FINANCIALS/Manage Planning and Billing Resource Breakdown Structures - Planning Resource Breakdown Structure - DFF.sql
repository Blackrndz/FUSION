/* ****************************************************************************
 * $Revision: 61016 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-02-10 11:47:39 +0700 (Fri, 10 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Sources%20-%20Manage%20Transaction%20Sources.sql $:
 * $Id: Manage Transaction Sources - Manage Transaction Sources.sql 61016 2017-02-10 04:47:39Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10037##RES##PJF_RBS_HEADERS_DESC_FLEX
-- DFF_ATTRIBUTES=ATTRIBUTE_CHAR,ATTRIBUTE_DATE,ATTRIBUTE_NUMBER

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT resourcesE0.NAME RES_PLANNING_NAME
,resourcesE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,resourcesE0.ATTRIBUTE_CHAR1
,resourcesE0.ATTRIBUTE_CHAR2
,resourcesE0.ATTRIBUTE_CHAR3
,resourcesE0.ATTRIBUTE_CHAR4
,resourcesE0.ATTRIBUTE_CHAR5
,resourcesE0.ATTRIBUTE_CHAR6
,resourcesE0.ATTRIBUTE_CHAR7
,resourcesE0.ATTRIBUTE_CHAR8
,resourcesE0.ATTRIBUTE_CHAR9
,resourcesE0.ATTRIBUTE_CHAR10
,resourcesE0.ATTRIBUTE_CHAR11
,resourcesE0.ATTRIBUTE_CHAR12
,resourcesE0.ATTRIBUTE_CHAR13
,resourcesE0.ATTRIBUTE_CHAR14
,resourcesE0.ATTRIBUTE_CHAR15
,resourcesE0.ATTRIBUTE_CHAR16
,resourcesE0.ATTRIBUTE_CHAR17
,resourcesE0.ATTRIBUTE_CHAR18
,resourcesE0.ATTRIBUTE_CHAR19
,resourcesE0.ATTRIBUTE_CHAR20
,resourcesE0.ATTRIBUTE_DATE1
,resourcesE0.ATTRIBUTE_DATE2
,resourcesE0.ATTRIBUTE_DATE3
,resourcesE0.ATTRIBUTE_DATE4
,resourcesE0.ATTRIBUTE_DATE5
,resourcesE0.ATTRIBUTE_NUMBER1
,resourcesE0.ATTRIBUTE_NUMBER2
,resourcesE0.ATTRIBUTE_NUMBER3
,resourcesE0.ATTRIBUTE_NUMBER4
,resourcesE0.ATTRIBUTE_NUMBER5
,resourcesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,resourcesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,resourcesE0.CREATED_BY RSC_CREATED_BY
,resourcesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,resourcesE0.PROJECT_UNIT_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_RBS_HEADERS_VL resourcesE0
,PJF_RBS_VERSIONS_B resVersionsE0
WHERE resourcesE0.RBS_TYPE = 'PLANNING'
AND resourcesE0.PROJECT_ID IS NULL
AND resourcesE0.CENTRALLY_CONTROL_FLAG <> 'I'
AND resourcesE0.RBS_HEADER_ID = resVersionsE0.RBS_HEADER_ID
AND (resourcesE0.ATTRIBUTE_CATEGORY IS NOT NULL OR
resourcesE0.ATTRIBUTE_CHAR1 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR2 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR3 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR4 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR5 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR6 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR7 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR8 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR9 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR10 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR11 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR12 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR13 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR14 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR15 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR16 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR17 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR18 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR19 IS NOT NULL OR 
resourcesE0.ATTRIBUTE_CHAR20 IS NOT NULL OR
resourcesE0.ATTRIBUTE_DATE1 IS NOT NULL OR
resourcesE0.ATTRIBUTE_DATE2 IS NOT NULL OR
resourcesE0.ATTRIBUTE_DATE3 IS NOT NULL OR
resourcesE0.ATTRIBUTE_DATE4 IS NOT NULL OR
resourcesE0.ATTRIBUTE_DATE5 IS NOT NULL OR
resourcesE0.ATTRIBUTE_NUMBER1 IS NOT NULL OR
resourcesE0.ATTRIBUTE_NUMBER2 IS NOT NULL OR
resourcesE0.ATTRIBUTE_NUMBER3 IS NOT NULL OR
resourcesE0.ATTRIBUTE_NUMBER4 IS NOT NULL OR
resourcesE0.ATTRIBUTE_NUMBER5 IS NOT NULL)
ORDER BY resourcesE0.NAME