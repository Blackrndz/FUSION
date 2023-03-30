/* ****************************************************************************
* $Revision: 78693 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-07 17:22:14 +0700 (Tue, 07 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Templates%20-%20Budget%20Amount%20Types.sql $:
* $Id: Manage Project Templates - Budget Amount Types.sql 78693 2022-06-07 10:22:14Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT projTemplatesE0.NAME RES_TEMPLATE_NAME
,projTemplatesE0.SEGMENT1 RES_TEMPLATE_NUMBER
,budgetsE0.VERSION_NAME RES_NAME
,(CASE
	WHEN pjoPlanTypeEO.PLAN_OPTION_CODE = 'COST_AND_REV_TOGETHER' THEN	
		DECODE(pjoFinPlanAMTEO.ALL_QTY_FLAG,'Y','Yes','No') 
	END) RES_QUANTITY
,(CASE
	WHEN planningOptionsE0.PLANNED_FOR_CODE != 'REVENUE' AND pjoPlanTypeEO.PLAN_OPTION_CODE != 'COST_AND_REV_TOGETHER' THEN	
		DECODE(pjoFinPlanAMTEO.COST_QTY_FLAG,'Y','Yes','No') 
	END) RES_COST_QUANTITY
,(CASE
	WHEN planningOptionsE0.PLANNED_FOR_CODE != 'REVENUE' THEN	
		DECODE(pjoFinPlanAMTEO.RAW_COST_FLAG,'Y','Yes','No')
	END) RES_RAW_COST
,(CASE
	WHEN planningOptionsE0.PLANNED_FOR_CODE != 'REVENUE' THEN	
		DECODE(pjoFinPlanAMTEO.COST_RATE_FLAG,'Y','Yes','No') 
	END) RES_RAW_COST_RATE
,(CASE
	WHEN planningOptionsE0.PLANNED_FOR_CODE = 'REVENUE' THEN	
		DECODE(pjoFinPlanAMTEO.REVENUE_QTY_FLAG,'Y','Yes','No') 
	END) RES_REVENUE_QUANTITY
,(CASE
	WHEN planningOptionsE0.PLANNED_FOR_CODE = 'REVENUE' OR pjoPlanTypeEO.PLAN_OPTION_CODE = 'COST_AND_REV_TOGETHER' THEN	
		DECODE(pjoFinPlanAMTEO.REVENUE_FLAG,'Y','Yes','No') 
	END) RES_REVENUE
,(CASE
	WHEN planningOptionsE0.PLANNED_FOR_CODE != 'COST' THEN	
		DECODE(pjoFinPlanAMTEO.BILL_RATE_FLAG,'Y','Yes','No') 
	END) RES_BILL_RATE
,(CASE
	WHEN planningOptionsE0.PLANNED_FOR_CODE = 'COST_AND_REV_TOGETHER' THEN	
		DECODE(pjoFinPlanAMTEO.BRDND_COST_FLAG,'Y','Yes','No') 
	END) RES_BURDENED_COST
,(CASE
	WHEN planningOptionsE0.PLANNED_FOR_CODE = 'COST_AND_REV_TOGETHER' THEN	
		DECODE(pjoFinPlanAMTEO.BRDND_RATE_FLAG,'Y','Yes','No')
	END) RES_BURDENED_COST_RATE
,pjoFinPlanAMTEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjoFinPlanAMTEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjoFinPlanAMTEO.CREATED_BY  RSC_CREATED_BY
,pjoFinPlanAMTEO.CREATION_DATE  RSC_CREATION_DATE
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
,PJO_FIN_PLAN_AMT_SETS pjoFinPlanAMTEO
,PJO_PLAN_TYPES_VL pjoPlanTypeEO
WHERE projTemplatesE0.TEMPLATE_FLAG = 'Y'
AND projTemplatesE0.ORG_ID = buE0.BU_ID
AND projTemplatesE0.PROJECT_ID = budgetsE0.PROJECT_ID
AND budgetsE0.PLAN_CLASS_CODE = 'BUDGET'
AND budgetsE0.STRUCTURE_VERSION_ID IS NULL
AND budgetsE0.PLAN_VERSION_ID = planningOptionsE0.PLAN_VERSION_ID
AND planningOptionsE0.AMOUNT_SET_ID = pjoFinPlanAMTEO.FIN_PLAN_AMT_SET_ID
AND pjoPlanTypeEO.PLAN_TYPE_ID = planningOptionsE0.PLAN_TYPE_ID
ORDER BY projTemplatesE0.NAME
,budgetsE0.VERSION_NAME