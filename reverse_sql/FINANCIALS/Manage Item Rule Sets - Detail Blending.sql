/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-07-04 $:
 * $HeadURL:$:
 * $Id: Manage Bank Branch Addresses - Botswana.sql $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=EGO_RL_BLEND_RULE_LINES

SELECT ruleSetsE0.RULE_SET_DISPLAY_NAME RES_DISPLAY_NAME
,ruleSetsE0.RULE_SET_NAME RES_INTERNAL_NAME
,rulesE0.SEQUENCE RES_SEQUENCE
,rulesE0.RULE_NAME RES_NAME
,blendRuleLinesE0.PRIORITY RES_PRIORITY
,(SELECT ORIG_SYSTEM_NAME
	FROM HZ_ORIG_SYSTEMS_VL
	WHERE ORIG_SYSTEM_TYPE = 'SPOKE'
	AND ORIG_SYSTEM = blendRuleLinesE0.SPOKE_SYSTEM_INTERNAL_NAME
	AND ORIG_SYSTEM_ID = blendRuleLinesE0.SPOKE_SYSTEM_ID
	) RES_SPOKE_SYSTEM
,DECODE(blendRuleLinesE0.IGNORE_NULL,'Y','Yes','No') RES_IGNORE_NULL
,blendRuleLinesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,blendRuleLinesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,blendRuleLinesE0.CREATED_BY RSC_CREATED_BY
,blendRuleLinesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGO_RL_RULE_SETS_VL ruleSetsE0
,EGO_RL_USER_RULES_VL rulesE0
,EGO_RL_BLEND_RULE_LINES blendRuleLinesE0
WHERE ruleSetsE0.RULE_SET_ID = rulesE0.RULE_SET_ID
AND ruleSetsE0.RULE_SET_TYPE = 'ORA_BLENDING'
AND rulesE0.RULE_ID = blendRuleLinesE0.RULE_ID
ORDER BY ruleSetsE0.RULE_SET_DISPLAY_NAME
,rulesE0.SEQUENCE
,blendRuleLinesE0.PRIORITY