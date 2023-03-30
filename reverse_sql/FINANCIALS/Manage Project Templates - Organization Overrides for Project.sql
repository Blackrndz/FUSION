/* ****************************************************************************
* $Revision: 78693 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-07 17:22:14 +0700 (Tue, 07 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Templates%20-%20Organization%20Overrides%20for%20Project.sql $:
* $Id: Manage Project Templates - Organization Overrides for Project.sql 78693 2022-06-07 10:22:14Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT projTemplatesE0.NAME RES_TEMPLATE_NAME
,projTemplatesE0.SEGMENT1 RES_TEMPLATE_NUMBER
,(SELECT NAME
    FROM HR_ALL_ORGANIZATION_UNITS
    WHERE ORGANIZATION_ID = projOverridesE0.OVERRIDE_FROM_ORGANIZATION_ID
    ) RES_SOURCE_ORGANIZATION
,(SELECT FULL_NAME
    FROM PER_PERSON_NAMES_F
    WHERE PERSON_ID = projOverridesE0.PERSON_ID
    AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
    AND NAME_TYPE = 'GLOBAL'
    ) RES_PERSON_NAME
,(SELECT EXPENDITURE_CATEGORY_NAME
    FROM PJF_EXP_CATEGORIES_TL
    WHERE LANGuaGE = USERENV('LANG')
    AND EXPENDITURE_CATEGORY_ID = projOverridesE0.EXPENDITURE_CATEGORY_ID
    ) RES_EXPENDITURE_CATEGORY
,(SELECT NAME
    FROM HR_ALL_ORGANIZATION_UNITS
    WHERE ORGANIZATION_ID = projOverridesE0.OVERRIDE_TO_ORGANIZATION_ID
    ) RES_DESTINATION_ORGANIZATION
,TO_CHAR(projOverridesE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(projOverridesE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
,projOverridesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,projOverridesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,projOverridesE0.CREATED_BY  RSC_CREATED_BY
,projOverridesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,projTemplatesE0.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_PROJECTS_ALL_VL projTemplatesE0
,FUN_ALL_BUSINESS_UNITS_V buE0
,PJC_COST_DIST_OVERRIDES projOverridesE0
WHERE projTemplatesE0.TEMPLATE_FLAG = 'Y'
AND projTemplatesE0.ORG_ID = buE0.BU_ID
AND projTemplatesE0.PROJECT_ID = projOverridesE0.PROJECT_ID
ORDER BY projTemplatesE0.NAME,2