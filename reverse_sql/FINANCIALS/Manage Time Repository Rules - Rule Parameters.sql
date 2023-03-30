/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Time%20Repository%20Rules%20-%20Rule%20Parameters.sql $:
 * $Id: Manage Time Repository Rules - Rule Parameters.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
-- RSC_PREREQUISITE_OBJECTS=HWM_RULE_INPUTS

SELECT hwnRuleEO.RULE_NAME  RES_NAME
,(SELECT USER_DEFINED_IN_NAME FROM HWM_RULE_TMPLT_INPUTS_VL
	WHERE RULE_TMPLT_INPUT_ID = hwnRuleInputEO.RULE_TMPLT_INPUT_ID
	AND INPUT_NAME = hwnRuleInputEO.INPUT_NAME
	AND DISPLAY_SEQUENCE = hwnRuleInputEO.DISPLAY_SEQUENCE) RES_DISPLAY_NAME
,DECODE(hwnRuleInputEO.PARM_VALUE_REQUIRED,'Y','Yes','No') RES_REQUIRED
,hwnRuleInputEO.VALUE_TEXT RES_VALUE

,hwnRuleInputEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,hwnRuleInputEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,hwnRuleInputEO.CREATED_BY RSC_CREATED_BY
,hwnRuleInputEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HWM_RULES hwnRuleEO
,HWM_RULE_INPUTS hwnRuleInputEO
WHERE hwnRuleEO.RULE_ID = hwnRuleInputEO.RULE_ID
ORDER BY hwnRuleEO.RULE_NAME
