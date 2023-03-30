/* ****************************************************************************
* $Revision: 78557 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-05-24 10:32:18 +0700 (Tue, 24 May 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Templates%20-%20Quick%20Entries.sql $:
* $Id: Manage Project Templates - Quick Entries.sql 78557 2022-05-24 03:32:18Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT projTemplatesE0.NAME RES_TEMPLATE_NAME
,projTemplatesE0.SEGMENT1 RES_TEMPLATE_NUMBER
,(SELECT MEANING 
    FROM FND_LOOKUPS 
    WHERE LOOKUP_TYPE = 'PJF_OVERRIDE_FIELD'
    AND LOOKUP_CODE = quickEntE0.FIELD_NAME
    ) RES_FIELD_NAME
,(CASE
    WHEN quickEntE0.FIELD_NAME = 'CLASSIFICATION' THEN
        (SELECT CLASS_CATEGORY
            FROM PJF_CLASS_CATEGORIES_TL
            WHERE LANGUAGE = USERENV('LANG')
            AND CLASS_CATEGORY_ID = quickEntE0.LIMITING_VALUE)
    WHEN quickEntE0.FIELD_NAME = 'TEAM_MEMBER' THEN
        (SELECT PROJECT_ROLE_NAME
            FROM PJF_PROJ_ROLE_TYPES_TL
            WHERE LANGUAGE = USERENV('LANG')
            AND PROJECT_ROLE_ID = quickEntE0.LIMITING_VALUE)
    END) RES_SPECIFICATION
,quickEntE0.DISPLAY_NAME RES_PROMPT
,DECODE(quickEntE0.MANDATORY_FLAG,'Y','Yes','No') RES_REQUIRED
,quickEntE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,quickEntE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,quickEntE0.CREATED_BY  RSC_CREATED_BY
,quickEntE0.CREATION_DATE  RSC_CREATION_DATE
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
,PJF_PROJ_COPY_OVERRIDES_VL quickEntE0
WHERE projTemplatesE0.TEMPLATE_FLAG = 'Y'
AND projTemplatesE0.ORG_ID = buE0.BU_ID
AND projTemplatesE0.PROJECT_ID = quickEntE0.PROJECT_ID
ORDER BY projTemplatesE0.NAME