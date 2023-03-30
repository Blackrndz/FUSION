/* ****************************************************************************
* $Revision: 78693 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-07 17:22:14 +0700 (Tue, 07 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Templates%20-%20Budget%20Generation%20Options.sql $:
* $Id: Manage Project Templates - Budget Generation Options.sql 78693 2022-06-07 10:22:14Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT projTemplatesE0.NAME RES_TEMPLATE_NAME
,projTemplatesE0.SEGMENT1 RES_TEMPLATE_NUMBER
,budgetsE0.VERSION_NAME RES_NAME
,(SELECT MEANING 
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'PJO_REV_CLASSIFICATION_METHOD'
	AND LOOKUP_CODE = planningOptionsE0.REV_CLASSIFICATION_METHOD
	) RES_REVENUE_GENERATION_METHOD
,(CASE
	WHEN planningOptionsE0.BUDGET_CREATION_METHOD != 'MANUAL' THEN
		DECODE(planningOptionsE0.RET_OVER_RATES_FRM_SRC_FLAG,'Y','Yes','No')
	END) RES_RETAIN_OVERRIDE_RATES_FROM
,budgetsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,budgetsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,budgetsE0.CREATED_BY  RSC_CREATED_BY
,budgetsE0.CREATION_DATE  RSC_CREATION_DATE
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
,PJO_PLAN_VERSIONS_VL budgetsE0
,PJO_PLANNING_OPTIONS planningOptionsE0
WHERE projTemplatesE0.TEMPLATE_FLAG = 'Y'
AND projTemplatesE0.ORG_ID = buE0.BU_ID
AND projTemplatesE0.PROJECT_ID = budgetsE0.PROJECT_ID
AND budgetsE0.PLAN_CLASS_CODE = 'BUDGET'
AND budgetsE0.STRUCTURE_VERSION_ID IS NULL
AND budgetsE0.PLAN_VERSION_ID = planningOptionsE0.PLAN_VERSION_ID
AND budgetsE0.PLANNED_FOR_CODE IN ('COST_AND_REV_TOGETHER','Revenue')
ORDER BY projTemplatesE0.NAME
,budgetsE0.VERSION_NAME