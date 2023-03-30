/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Costing%20Messages%20-%20Message%20Tokens.sql $:
 * $Id: Manage Project Costing Messages - Message Tokens.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT fndMessageE0.MESSAGE_NAME RES_MESSAGE_NAME
,(SELECT APPLICATION_NAME
	FROM FND_APPLICATION_VL
	WHERE APPLICATION_ID = fndMessageE0.APPLICATION_ID
	) RES_APPLICATION
,fndMessageTokensE0.TOKEN_NAME RES_TOKEN_NAME
,(SELECT meaning
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'TOKEN_DATA_TYPE'
	AND LOOKUP_CODE   = fndMessageTokensE0.DATA_TYPE
	) RES_DATA_TYPE
,fndMessageTokensE0.DESCRIPTION RES_DESCRIPTION
,fndMessageE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,fndMessageE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,fndMessageE0.CREATED_BY RSC_CREATED_BY
,fndMessageE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_MESSAGES_VL fndMessageE0
,FND_MESSAGE_TOKENS fndMessageTokensE0
WHERE fndMessageE0.MESSAGE_NAME = fndMessageTokensE0.MESSAGE_NAME
AND fndMessageE0.APPLICATION_ID = fndMessageTokensE0.APPLICATION_ID
AND fndMessageE0.MODULE_ID  IN 
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	where at.MODULE_TYPE = 'APPLICATION'
	AND at.module_key    = 'PJC'
	AND at.module_id     = rf.ancestor_module_id)
ORDER BY 1

	
	 