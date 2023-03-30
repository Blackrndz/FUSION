/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-07-04 $:
 * $HeadURL:$:
 * $Id: Manage Bank Branch Addresses - Botswana.sql $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT ruleSetsE0.RULE_SET_DISPLAY_NAME RES_DISPLAY_NAME
,ruleSetsE0.RULE_SET_NAME RES_INTERNAL_NAME
,(SELECT RULE_SET_DISPLAY_NAME
	FROM EGO_RL_RULE_SETS_VL
	WHERE RULE_SET_ID = includeRulesE0.INCLUDED_RULE_SET_ID
	) RES_DISPLAY_NAME_RULE_SET
,includeRulesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,includeRulesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,includeRulesE0.CREATED_BY RSC_CREATED_BY
,includeRulesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGO_RL_RULE_SETS_VL ruleSetsE0
,EGO_RL_INC_RULE_SETS includeRulesE0
WHERE ruleSetsE0.RULE_SET_TYPE = 'ASSIGNMENT_AND_VALIDATION'
AND ruleSetsE0.RULE_SET_ID = includeRulesE0.RULE_SET_ID
ORDER BY ruleSetsE0.RULE_SET_DISPLAY_NAME
,includeRulesE0.SEQUENCE