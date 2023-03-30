/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Applications%20Core%20Messages%20-%20Message%20Tokens.sql $:
* $Id: Manage Applications Core Messages - Message Tokens.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT MessageTokenEO.MESSAGE_NAME AS RES_MESSAGE_NAME
,MessageTokenEO.TOKEN_NAME         AS RES_TOKEN_NAME
,(SELECT meaning
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'TOKEN_DATA_TYPE'
	AND LOOKUP_CODE   = MessageTokenEO.DATA_TYPE
	)                          AS RES_DATA_TYPE
,MessageTokenEO.DESCRIPTION AS RES_DESCRIPTION
,MessageTokenEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,MessageTokenEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,MessageTokenEO.CREATED_BY RSC_CREATED_BY
,MessageTokenEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_MESSAGE_TOKENS MessageTokenEO
ORDER BY RES_MESSAGE_NAME