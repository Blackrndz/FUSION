/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-07-04 $:
 * $HeadURL:$:
 * $Id: Manage Bank Branch Addresses - Botswana.sql $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=EGO_RL_USER_RULES_VL

WITH EXPRESSION AS (SELECT RULE_ID
	,1 SEQ
	,SECONDARY_IF_EXPRESSION1 IF_EX
	,SECONDARY_IF_RETURN_VALUE1 IF_RT
	FROM EGO_RL_USER_RULES_VL
	
	UNION
	
	SELECT RULE_ID
	,2 SEQ
	,SECONDARY_IF_EXPRESSION2 IF_EX
	,SECONDARY_IF_RETURN_VALUE2 IF_RT
	FROM EGO_RL_USER_RULES_VL
	
	UNION
	
	SELECT RULE_ID
	,3 SEQ
	,SECONDARY_IF_EXPRESSION3 IF_EX
	,SECONDARY_IF_RETURN_VALUE3 IF_RT
	FROM EGO_RL_USER_RULES_VL
	UNION
	
	SELECT RULE_ID
	,4 SEQ
	,SECONDARY_IF_EXPRESSION4 IF_EX
	,SECONDARY_IF_RETURN_VALUE4 IF_RT
	FROM EGO_RL_USER_RULES_VL
	
	UNION
	
	SELECT RULE_ID
	,5 SEQ
	,SECONDARY_IF_EXPRESSION5 IF_EX
	,SECONDARY_IF_RETURN_VALUE5 IF_RT
	FROM EGO_RL_USER_RULES_VL
	)
	
SELECT ruleSetsE0.RULE_SET_DISPLAY_NAME RES_DISPLAY_NAME
,ruleSetsE0.RULE_SET_NAME RES_INTERNAL_NAME
,rulesE0.SEQUENCE RES_SEQUENCE
,rulesE0.RULE_NAME RES_NAME
,EXPRESSION.IF_EX RES_SECONDARY_IF_EXPRESSION
,EXPRESSION.IF_RT RES_RETURN_VALUE
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
,EXPRESSION
WHERE ruleSetsE0.RULE_SET_ID = rulesE0.RULE_SET_ID
AND ruleSetsE0.RULE_SET_TYPE = 'ASSIGNMENTS'
AND rulesE0.RULE_ID = EXPRESSION.RULE_ID
AND (EXPRESSION.IF_EX IS NOT NULL OR EXPRESSION.IF_RT IS NOT NULL)
ORDER BY ruleSetsE0.RULE_SET_DISPLAY_NAME
,rulesE0.SEQUENCE
,EXPRESSION.SEQ