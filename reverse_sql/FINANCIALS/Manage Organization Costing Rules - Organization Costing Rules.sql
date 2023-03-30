/* ****************************************************************************
 * $Revision: 63805 $:
 * $Author: phermwit.seethong $:
 * $Date: 2017-09-12 15:37:52 +0700 (Tue, 12 Sep 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Revaluations%20-%20Revaluations.sql $:
 * $Id: Manage Revaluations - Revaluations.sql 63805 2017-09-12 08:37:52Z phermwit.seethong $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT buE0.BU_NAME RES_BUSINESS_UNIT
,(SELECT NAME
    FROM HR_ALL_ORGANIZATION_UNITS
    WHERE ORGANIZATION_ID = orgCostRulesE0.ORGANIZATION_ID
    ) RES_EXPENDITURE_ORGANIZATION
,(SELECT MEANING
    FROM FND_LOOKUPS
    WHERE LOOKUP_TYPE = 'PJF_ORG_CST_RULE_SCH_TYPE'
    AND LOOKUP_CODE = orgCostRulesE0.SCHEDULE_TYPE
    ) RES_SCHEDULE_TYPE
,orgCostRulesE0.COMP_RULE_SET_NAME RES_LABOR_COSTING_RULE
,(SELECT RATE_SCHEDULE_NAME
    FROM PJF_RATE_SCHEDULES_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND RATE_SCHEDULE_ID = orgCostRulesE0.RATE_SCHEDULE_ID
    ) RES_COST_RATE_SCHEDULE
,TO_CHAR(orgCostRulesE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(orgCostRulesE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
,projectsE0.NAME RES_PROJECT_NAME
,tasksE0.NAME RES_TASK_NAME
,orgCostRulesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,orgCostRulesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,orgCostRulesE0.CREATED_BY RSC_CREATED_BY
,orgCostRulesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,orgCostRulesE0.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_ORG_COST_SCH_RULES orgCostRulesE0
,FUN_ALL_BUSINESS_UNITS_V buE0
,PJF_PROJECTS_ALL_VL projectsE0
,PJF_PROJ_ELEMENTS_VL tasksE0
WHERE orgCostRulesE0.ORG_ID = buE0.BU_ID
AND orgCostRulesE0.OVERTIME_PROJECT_ID = projectsE0.PROJECT_ID(+)
AND orgCostRulesE0.OVERTIME_TASK_ID = tasksE0.PROJ_ELEMENT_ID(+)
ORDER BY 1