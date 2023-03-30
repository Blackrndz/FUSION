/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Labor%20Costing%20Rules%20-%20Labor%20Costing%20Rules.sql $:
* $Id: Manage Labor Costing Rules - Labor Costing Rules.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT  pjfCompRuleEO.COMP_RULE_SET_NAME		RES_NAME
,(SELECT MEANING FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'PJF_LABOR_COSTING_METHOD'
		AND LOOKUP_CODE = pjfCompRuleEO.COSTING_METHOD 
	)	RES_COSTING_METHOD
,TO_CHAR(pjfCompRuleEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(pjfCompRuleEO.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
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
ORDER BY pjfCompRuleEO.COMP_RULE_SET_NAME

