/* ****************************************************************************
 * $Revision: 68520 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2018-08-30 14:13:44 +0700 (Thu, 30 Aug 2018) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Revenue%20Categories%20-%20Lookup%20Codes.sql $:
 * $Id: Manage Revenue Categories - Lookup Codes.sql 68520 2018-08-30 07:13:44Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT messagesE0.MESSAGE_NAME RES_MESSAGE_NAME
,(SELECT APPLICATION_NAME
	FROM FND_APPLICATION_VL
	WHERE APPLICATION_ID = messagesE0.APPLICATION_ID 
	) RES_APPLICATION
,tokensE0.TOKEN_NAME RES_TOKEN_NAME
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'TOKEN_DATA_TYPE'
	AND LOOKUP_CODE = tokensE0.DATA_TYPE 
	) RES_DATA_TYPE
,tokensE0.DESCRIPTION RES_DESCRIPTION
,tokensE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,tokensE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,tokensE0.CREATED_BY RSC_CREATED_BY
,tokensE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_MESSAGES_VL messagesE0
,FND_MESSAGE_TOKENS tokensE0
WHERE messagesE0.MESSAGE_NAME = tokensE0.MESSAGE_NAME
ORDER BY messagesE0.MESSAGE_NAME