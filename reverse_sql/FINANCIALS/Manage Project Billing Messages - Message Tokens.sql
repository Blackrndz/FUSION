/* ****************************************************************************
* $Revision: 55207 $:
* $Author: dhara.pithadiya $:
* $Date: 2016-05-13 15:25:32 +0700 (Fri, 13 May 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Applications%20Core%20Messages%20-%20Message%20Tokens.sql $:
* $Id: Manage Applications Core Messages - Message Tokens.sql 55207 2016-05-13 08:25:32Z dhara.pithadiya $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT messagesE0.MESSAGE_NAME RES_MESSAGE_NAME
,(SELECT APPLICATION_NAME
	FROM FND_APPLICATION_VL
	WHERE APPLICATION_ID = messagesE0.APPLICATION_ID
	) RES_APPLICATION
,messageTokensE0.TOKEN_NAME RES_TOKEN_NAME
,(SELECT meaning
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'TOKEN_DATA_TYPE'
	AND LOOKUP_CODE   = messageTokensE0.DATA_TYPE
	) RES_DATA_TYPE
,messageTokensE0.DESCRIPTION RES_DESCRIPTION
,messageTokensE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,messageTokensE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,messageTokensE0.CREATED_BY RSC_CREATED_BY
,messageTokensE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_MESSAGES_VL messagesE0
,FND_MESSAGE_TOKENS messageTokensE0
WHERE messagesE0.MESSAGE_NAME = messageTokensE0.MESSAGE_NAME
AND messagesE0.APPLICATION_ID = messageTokensE0.APPLICATION_ID
AND messagesE0.MODULE_ID  IN 
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	where at.MODULE_TYPE = 'APPLICATION'
	AND at.module_key    = 'PJB'
	AND at.module_id     = rf.ancestor_module_id)
ORDER BY messagesE0.MESSAGE_NAME
,messageTokensE0.TOKEN_NAME