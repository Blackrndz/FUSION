/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Labor%20Costing%20Rules%20-%20Default%20Overtime%20Transaction%20Attributes.sql $:
* $Id: Manage Labor Costing Rules - Default Overtime Transaction Attributes.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */
SELECT  pjfCompRuleEO.COMP_RULE_SET_NAME		RES_NAME
,(SELECT NAME FROM HR_ORGANIZATION_UNITS
	WHERE ORGANIZATION_ID = pjfCOMPotDefEO.ORG_ID 
	)	RES_BUSINESS_UNIT
,pjfProjAllEO.NAME  							RES_PROJECT_NAME
,pjfProjAllEO.SEGMENT1							RES_PROJECT_NUMBER
,pjfProjElementEO.NAME							RES_TASK_NAME
,pjfProjElementEO.ELEMENT_NUMBER				RES_TASK_NUMBER
,pjfCompRuleEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjfCompRuleEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjfCompRuleEO.CREATED_BY  RSC_CREATED_BY
,pjfCompRuleEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,pjfCOMPotDefEO.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_COMP_RULE_SETS pjfCompRuleEO
,PJF_COMP_OT_DEFAULTS_ALL pjfCOMPotDefEO
,PJF_PROJ_ELEMENTS_VL pjfProjElementEO
,PJF_PROJECTS_ALL_VL pjfProjAllEO
WHERE pjfCompRuleEO.COMP_RULE_SET_NAME = pjfCOMPotDefEO.COMP_RULE_SET_NAME
AND pjfCOMPotDefEO.TASK_ID = pjfProjElementEO.PROJ_ELEMENT_ID (+)
AND pjfCOMPotDefEO.PROJECT_ID = pjfProjAllEO.PROJECT_ID
ORDER BY RES_BUSINESS_UNIT
