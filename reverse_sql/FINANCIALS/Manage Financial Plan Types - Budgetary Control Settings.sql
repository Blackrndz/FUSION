/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Financial%20Plan%20Types%20-%20Budgetary%20Control%20Settings.sql $:
* $Id: Manage Financial Plan Types - Budgetary Control Settings.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT 	pjoPlanTypeEO.NAME RES_NAME
,(CASE
	WHEN EXISTS (SELECT 1 FROM PJO_XCC_SETTINGS , PJO_PLANNING_OPTIONS
					WHERE PJO_XCC_SETTINGS.PLANNING_OPTION_ID = PJO_PLANNING_OPTIONS.PLANNING_OPTION_ID
						AND PJO_PLANNING_OPTIONS.PLAN_TYPE_ID = pjoPlanTypeEO.PLAN_TYPE_ID
						AND PJO_PLANNING_OPTIONS.PLAN_OPTION_LEVEL_CODE = 'PLAN_TYPE'
						AND PJO_XCC_SETTINGS.CONTROL_BUDGET_CODE = 'AWD_FUND_PROJECT') THEN
		DECODE(pjoXccSetEO.CONTROL_BUDGET_CODE
		,'PROJECT','Award-Project'
		,'TOP_RES','Award-Project-Top Resource'
		,'AWD_FUND_PROJECT','Award-Project-Funding Source'
		,'AWD_FUND_TOP_RES','Award-Project-Top-Funding Source')
	ELSE
		DECODE(pjoXccSetEO.CONTROL_BUDGET_CODE
		,'PROJECT','Project'
		,'TOP_RES','Top Resource')
	END) RES_CONTROL_BUDGET
,DECODE(pjoXccSetEO.CONTROL_LEVEL_CODE
	,'ABSOLUTE','Absolute'
	,'TRACK','Track'
	,'ADVISORY','Advisory'
	,'NO_CB','Do Not Create Control Budget'
	) RES_CONTROL_LEVEL
,(SELECT USER_CONVERSION_TYPE 
	FROM GL_DAILY_CONVERSION_TYPES
	WHERE CONVERSION_TYPE = pjoXccSetEO.DEFAULT_RATE_TYPE
	) RES_DEFAULT_RATE_TYPE
,pjoXccSetEO.TOLERANCE_PERCENTAGE RES_TOLERANCE_PERCENTAGE
,pjoXccSetEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjoXccSetEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjoXccSetEO.CREATED_BY  RSC_CREATED_BY
,pjoXccSetEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJO_PLAN_TYPES_VL pjoPlanTypeEO
,PJO_PLANNING_OPTIONS pjoPlanOptionEO
,PJO_XCC_SETTINGS  pjoXccSetEO
WHERE pjoPlanTypeEO.PLAN_TYPE_CODE = 'FINANCIAL_PLAN'
AND pjoPlanTypeEO.PLAN_TYPE_ID = pjoPlanOptionEO.PLAN_TYPE_ID
AND pjoPlanOptionEO.PLANNING_OPTION_ID = pjoXccSetEO.PLANNING_OPTION_ID
AND pjoPlanOptionEO.PLAN_OPTION_LEVEL_CODE = 'PLAN_TYPE'
AND pjoPlanOptionEO.PROJECT_ID = 0
ORDER BY pjoPlanTypeEO.NAME