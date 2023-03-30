/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Organization%20Security%20Profile%20-%20Organization%20Security%20Profile.sql $:
 * $Id: Manage Organization Security Profile - Organization Security Profile.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=PER_ORG_SECURITY_PROFILES

SELECT orgSecPflsE0.NAME RES_NAME
,DECODE(orgSecPflsE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,DECODE(orgSecPflsE0.VIEW_ALL,'Y','Yes','No') RES_VIEW_ALL
,DECODE(orgSecPflsE0.INCLUDE_FUTURE_ORGANIZATIONS,'Y','Yes','No') RES_INCLUDE_FUTURE_ORGANIZATIO

--Organization Hierarchy
,DECODE(orgSecPflsE0.SECURE_BY_ORG_HIERARCHY,'Y','Yes','No') RES_SECURE_BY_ORGANIZATION_HIE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'PER_ORG_TREE_STRUCTURES'
    AND LOOKUP_CODE = orgSecPflsE0.ORG_HIER_TREE_STRUCT_CODE
    ) RES_TREE_STRUCTURE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'PER_ORG_SEC_PROF_TOP_ORG_SEL'
    AND LOOKUP_CODE = orgSecPflsE0.TOP_ORG_SELECTION
    ) RES_TOP_ORGANIZATION_SELECTION
,(CASE
    WHEN orgSecPflsE0.ORG_HIER_TREE_STRUCT_CODE = 'PER_DEPT_TREE_STRUCTURE' THEN
        (SELECT TREE_NAME
            FROM FND_TREE_VL
            WHERE TREE_STRUCTURE_CODE = orgSecPflsE0.ORG_HIER_TREE_STRUCT_CODE
            AND TREE_CODE = orgSecPflsE0.ORG_HIER_TREE_CODE)
    END) RES_DEPARTMENT_TREE
,(CASE
    WHEN orgSecPflsE0.ORG_HIER_TREE_STRUCT_CODE = 'PER_ORG_TREE_STRUCTURE' THEN
        (SELECT TREE_NAME
            FROM FND_TREE_VL
            WHERE TREE_STRUCTURE_CODE = orgSecPflsE0.ORG_HIER_TREE_STRUCT_CODE
            AND TREE_CODE = orgSecPflsE0.ORG_HIER_TREE_CODE)
    END) RES_ORGANIZATION_TREE
,(CASE
    WHEN orgSecPflsE0.TOP_ORG_SELECTION = 'S' THEN
        (SELECT NAME
            FROM HR_ORGANIZATION_UNITS
            WHERE SYSDATE BETWEEN DATE_FROM AND DATE_TO
            AND ORGANIZATION_ID = orgSecPflsE0.TOP_ORGANIZATION_ID)
    END) RES_ORGANIZATION
,DECODE(orgSecPflsE0.INCLUDE_TOP_ORGANIZATION,'Y','Yes','No') RES_INCLUDE_TOP_ORGANIZATION

--Organization Classification
,DECODE(orgSecPflsE0.SECURE_BY_ORG_CLASS,'Y','Yes','No') RES_SECURE_BY_ORGANIZATION_CLA

--Organizations
,DECODE(orgSecPflsE0.SECURE_BY_ORG_LIST,'Y','Yes','No') RES_SECURE_BY_ORGANIZATION_LIS

,orgSecPflsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,orgSecPflsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,orgSecPflsE0.CREATED_BY RSC_CREATED_BY
,orgSecPflsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,orgSecPflsE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_ORG_SECURITY_PROFILES orgSecPflsE0
ORDER BY orgSecPflsE0.NAME