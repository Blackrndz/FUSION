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
,rulesE0.SEQUENCE RES_SEQUENCE
,rulesE0.RULE_NAME RES_NAME
,rulesE0.DESCRIPTION RES_DESCRIPTION
,'' RES_VALID_COMPONENT_RULES
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EGO_RL_RULE_SEVERITIES'
	AND LOOKUP_CODE = rulesE0.SEVERITY
	) RES_SEVERITY
,DECODE(rulesE0.HAS_ABORT_VALIDATION,'Y','Yes','No') RES_STOP_FURTHER_PROCESSING_WH
,rulesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,rulesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,rulesE0.CREATED_BY RSC_CREATED_BY
,rulesE0.CREATION_DATE RSC_CREATION_DATE
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
WHERE ruleSetsE0.RULE_SET_ID = rulesE0.RULE_SET_ID
AND ruleSetsE0.RULE_SET_TYPE = 'VALIDATIONS'
ORDER BY ruleSetsE0.RULE_SET_DISPLAY_NAME
,rulesE0.SEQUENCE