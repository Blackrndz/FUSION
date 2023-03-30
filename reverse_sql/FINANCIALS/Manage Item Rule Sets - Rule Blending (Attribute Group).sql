/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-07-04 $:
 * $HeadURL:$:
 * $Id: Manage Bank Branch Addresses - Botswana.sql $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=EGO_RL_BLEND_RULE_ATTR_GROUPS

SELECT ruleSetsE0.RULE_SET_DISPLAY_NAME RES_DISPLAY_NAME
,ruleSetsE0.RULE_SET_NAME RES_INTERNAL_NAME
,rulesE0.SEQUENCE RES_SEQUENCE
,rulesE0.RULE_NAME RES_NAME
,attrGroupsE0.ATTR_GROUP_DISP_NAME RES_ATTRIBUTE_GROUP_DISPLAY_NA
,attrGroupsE0.ATTR_GROUP_NAME RES_ATTRIBUTE_GROUP_INTERNAL_N
,ruleAttrGroupsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ruleAttrGroupsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ruleAttrGroupsE0.CREATED_BY RSC_CREATED_BY
,ruleAttrGroupsE0.CREATION_DATE RSC_CREATION_DATE
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
,EGO_RL_BLEND_RULE_ATTR_GROUPS ruleAttrGroupsE0
,(SELECT DISTINCT ATTR_GROUP_NAME,ATTR_GROUP_DISP_NAME
	FROM EGP_ITEM_ATTRIBUTES_VL) attrGroupsE0
WHERE ruleSetsE0.RULE_SET_ID = rulesE0.RULE_SET_ID
AND ruleSetsE0.RULE_SET_TYPE = 'ORA_BLENDING'
AND rulesE0.RULE_ID = ruleAttrGroupsE0.RULE_ID
AND ruleAttrGroupsE0.ATTR_GROUP_NAME = attrGroupsE0.ATTR_GROUP_NAME
ORDER BY ruleSetsE0.RULE_SET_DISPLAY_NAME
,rulesE0.SEQUENCE
,attrGroupsE0.ATTR_GROUP_DISP_NAME