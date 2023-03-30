/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Cross-Validation%20Rules%20-%20Manage%20Cross-Validation%20Rules.sql $:
 * $Id: Manage Cross-Validation Rules - Manage Cross-Validation Rules.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT STRUCTUREINSTANCE.name RES_CHART_OF_ACCOUNTS
,KFFCROSSVALRULEEO.RULE_CODE RES_NAME
,KFFCROSSVALRULEEO.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(KFFCROSSVALRULEEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(KFFCROSSVALRULEEO.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
,DECODE(KFFCROSSVALRULEEO.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,MessageE0.MESSAGE_TEXT RES_ERROR_MESSAGE
,KFFCrossValRuleEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,KFFCrossValRuleEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,KFFCrossValRuleEO.CREATED_BY  RSC_CREATED_BY
,KFFCrossValRuleEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,StructureInstance.STRUCTURE_INSTANCE_NUMBER RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_KF_CROSS_VAL_RULES KFFCrossValRuleEO
,FND_KF_STR_INSTANCES_VL StructureInstance
,FND_MESSAGES_TL MessageE0
WHERE KFFCrossValRuleEO.STRUCTURE_INSTANCE_ID = StructureInstance.STRUCTURE_INSTANCE_ID
AND StructureInstance.APPLICATION_ID          = 101
AND StructureInstance.KEY_FLEXFIELD_CODE      = 'GL#'
AND KFFCROSSVALRULEEO.ERROR_MSG_NAME = MessageE0.MESSAGE_NAME
AND MessageE0.LANGUAGE = USERENV('LANG')
ORDER BY RES_CHART_OF_ACCOUNTS
,KFFCROSSVALRULEEO.RULE_CODE 