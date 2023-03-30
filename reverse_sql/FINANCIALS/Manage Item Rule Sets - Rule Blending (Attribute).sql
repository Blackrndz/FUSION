/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-07-04 $:
 * $HeadURL:$:
 * $Id: Manage Bank Branch Addresses - Botswana.sql $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=EGO_RL_BLEND_RULE_ATTRS

SELECT ruleSetsE0.RULE_SET_DISPLAY_NAME RES_DISPLAY_NAME
,ruleSetsE0.RULE_SET_NAME RES_INTERNAL_NAME
,rulesE0.SEQUENCE RES_SEQUENCE
,rulesE0.RULE_NAME RES_NAME
,segmentsE0.NAME RES_ATTRIBUTE_DISPLAY_NAME
,segmentsE0.SEGMENT_CODE RES_ATTRIBUTE_INTERNAL_NAME
,ruleAttrsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ruleAttrsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ruleAttrsE0.CREATED_BY RSC_CREATED_BY
,ruleAttrsE0.CREATION_DATE RSC_CREATION_DATE
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
,EGO_RL_BLEND_RULE_ATTRS ruleAttrsE0
,FND_DF_SEGMENTS_VL segmentsE0
WHERE ruleSetsE0.RULE_SET_ID = rulesE0.RULE_SET_ID
AND ruleSetsE0.RULE_SET_TYPE = 'ORA_BLENDING'
AND rulesE0.RULE_ID = ruleAttrsE0.RULE_ID
AND rulesE0.TARGET_ATTR_GROUP_NAME = segmentsE0.CONTEXT_CODE
AND ruleAttrsE0.ATTR_NAME = segmentsE0.SEGMENT_CODE
AND segmentsE0.DESCRIPTIVE_FLEXFIELD_CODE = 'EGO_ITEM_EFF'
ORDER BY ruleSetsE0.RULE_SET_DISPLAY_NAME
,rulesE0.SEQUENCE
,segmentsE0.NAME