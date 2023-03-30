/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Time%20Repository%20Rule%20Templates%20-%20Explanation.sql $:
 * $Id: Manage Time Repository Rule Templates - Explanation.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT hwnRuleEO.RULE_NAME  RES_NAME
,hwnRuleTmpltsEO.RT_EXPLANATION  RES_EXPLANATION

,hwnRuleTmpltsEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,hwnRuleTmpltsEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,hwnRuleTmpltsEO.CREATED_BY RSC_CREATED_BY
,hwnRuleTmpltsEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HWM_RULES hwnRuleEO
,HWM_RULE_TMPLTS_VL hwnRuleTmpltsEO
WHERE hwnRuleEO.RULE_TMPLTS_ID = hwnRuleTmpltsEO.RULE_TMPLTS_ID
ORDER BY hwnRuleEO.RULE_NAME
