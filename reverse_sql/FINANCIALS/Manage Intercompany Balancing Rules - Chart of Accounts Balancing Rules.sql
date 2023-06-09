/* ****************************************************************************
 * $Revision: 53935 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-03-25 16:18:48 +0700 (Fri, 25 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Bank%20Statement%20Transaction%20Creation%20Rules%20-%20Manage%20Bank%20Statement%20Transaction%20Creation%20Rules.sql $:
 * $Id: Manage Bank Statement Transaction Creation Rules - Manage Bank Statement Transaction Creation Rules.sql 53935 2016-03-25 09:18:48Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


-- FIELD_TO_APPLY_FUNCTION=RES_RECEIVABLES_ACCOUNT/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_PAYABLES_ACCOUNT/GET_CODE_COMBINATION

SELECT NVL((SELECT USER_JE_SOURCE_NAME 
	FROM GL_JE_SOURCES_TL
	WHERE JE_SOURCE_NAME = FUNBALINTERRULES.JE_SOURCE_NAME
	AND LANGUAGE = USERENV('LANG')
	),'None') RES_SOURCE
,NVL((SELECT USER_JE_CATEGORY_NAME 
	FROM GL_JE_CATEGORIES_TL
	WHERE JE_CATEGORY_NAME = FUNBALINTERRULES.JE_CATEGORY_NAME
	AND LANGUAGE = USERENV('LANG')
	),'None') RES_CATEGORY
,DECODE(FUNBALINTERRULES.TRX_TYPE_ID, - 1,'All Other', - 2,'None',TRANSACTIONTYPEPEO.TRX_TYPE_NAME) RES_TRANSACTION_TYPE
,DECODE(FUNBALINTERRULES.API_RULE_TYPE,'COA',KFFStructureInstancePEO.NAME,NULL) RES_CHART_OF_ACCOUNTS
,FUNBALINTERRULES.DR_CCID RES_RECEIVABLES_ACCOUNT
,FUNBALINTERRULES.CR_CCID RES_PAYABLES_ACCOUNT
,TO_CHAR(FUNBALINTERRULES.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(FUNBALINTERRULES.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,FunBalInterRules.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,FunBalInterRules.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,FunBalInterRules.CREATED_BY RSC_CREATED_BY
,FunBalInterRules.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FUN_BAL_INTER_RULES FunBalInterRules
,FND_KF_STR_INSTANCES_VL KFFStructureInstancePEO
,FUN_TRX_TYPES_VL TransactionTypePEO
WHERE FunBalInterRules.FROM_STRUCTURE_ID       = KFFStructureInstancePEO.STRUCTURE_INSTANCE_NUMBER
AND KFFStructureInstancePEO.KEY_FLEXFIELD_CODE = 'GL#'
AND KFFSTRUCTUREINSTANCEPEO.APPLICATION_ID     = 101
AND FUNBALINTERRULES.TRX_TYPE_ID               = TRANSACTIONTYPEPEO.TRX_TYPE_ID(+)
AND FUNBALINTERRULES.API_RULE_TYPE = 'COA'
ORDER BY FUNBALINTERRULES.API_RULE_TYPE
,FUNBALINTERRULES.JE_SOURCE_NAME