/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Labor%20Costing%20Rules%20-%20Overtime%20Labor%20Cost%20Multipliers.sql $:
* $Id: Manage Labor Costing Rules - Overtime Labor Cost Multipliers.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT  pjfCompRuleEO.COMP_RULE_SET_NAME		RES_NAME
,pjfEXPTypeEO.EXPENDITURE_TYPE_NAME				RES_EXPENDITURE_TYPE
,pjfLaborMULTIEO.MULTIPLIER_NAME				RES_LABOR_COST_MULTIPLIER
,pjfCompRuleEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjfCompRuleEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjfCompRuleEO.CREATED_BY  RSC_CREATED_BY
,pjfCompRuleEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_COMP_RULE_SETS pjfCompRuleEO
,PJF_COMP_OT_EXP_TYPES pjfLaborMULTIEO
,PJF_EXP_TYPES_VL pjfEXPTypeEO
WHERE pjfCompRuleEO.COMP_RULE_SET_NAME = pjfLaborMULTIEO.COMP_RULE_SET_NAME
AND pjfLaborMULTIEO.EXPENDITURE_TYPE_ID = pjfEXPTypeEO.EXPENDITURE_TYPE_ID
ORDER BY pjfEXPTypeEO.EXPENDITURE_TYPE_NAME	

