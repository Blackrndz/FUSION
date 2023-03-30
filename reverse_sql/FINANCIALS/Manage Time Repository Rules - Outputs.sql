/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Time%20Repository%20Rules%20-%20Outputs.sql $:
 * $Id: Manage Time Repository Rules - Outputs.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT hwnRuleEO.RULE_NAME  RES_NAME
,(SELECT USER_DEFINED_OUT_NAME FROM HWM_RULE_TMPLT_USAGES_VL
	WHERE RULE_TMPLT_USAGES_ID = hwnRuleOutputEO.RULE_TMPLT_USAGES_ID
	AND OUTPUT_NAME = hwnRuleOutputEO.OUTPUT_NAME
	AND DISPLAY_SEQUENCE = hwnRuleOutputEO.DISPLAY_SEQUENCE)  RES_DISPLAY_NAME
,hwnRuleOutputEO.MSG_SEVERITY RES_MESSAGE_SEVERITY
,'Output Group:'||' '||TBB_GROUP_NUMBER RES_GROUPING_STRUCTURE
,hwnRuleOutputEO.VALUE_TEXT RES_VALUE
,hwnRuleOutputEO.ATRB_FLD_NAME RES_TIME_ATTRIBUTE

,hwnRuleOutputEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,hwnRuleOutputEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,hwnRuleOutputEO.CREATED_BY RSC_CREATED_BY
,hwnRuleOutputEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HWM_RULES hwnRuleEO
,HWM_RULE_OUTPUTS hwnRuleOutputEO
WHERE hwnRuleEO.RULE_ID = hwnRuleOutputEO.RULE_ID
ORDER BY hwnRuleEO.RULE_NAME , hwnRuleOutputEO.RULE_OUTPUT_ID
