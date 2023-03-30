/* ****************************************************************************
* $Revision: 74359 $:
* $Author: tanawat.wongjan $:
* $Date: 2020-07-20 16:16:20 +0700 (Mon, 20 Jul 2020) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Applications%20Core%20Messages%20-%20Manage%20Applications%20Core%20Messages.sql $:
* $Id: Manage Applications Core Messages - Manage Applications Core Messages.sql 74359 2020-07-20 09:16:20Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT MessageEO.MESSAGE_NAME AS RES_MESSAGE_NAME
,(SELECT APPLICATION_NAME
	FROM fnd_application_vl
	WHERE APPLICATION_ID = MessageEO.APPLICATION_ID
	) AS RES_APPLICATION
,(SELECT USER_MODULE_NAME
	FROM FND_APPL_TAXONOMY_VL
	WHERE MODULE_ID = MessageEO.MODULE_ID
	)                        AS RES_MODULE
,MessageEO.MESSAGE_NUMBER AS RES_MESSAGE_NUMBER
,MessageEO.CONTEXT        AS RES_TRANSLATION_NOTES
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'MESSAGE_TYPE'
	AND LOOKUP_CODE   = MessageEO.TYPE
	) AS RES_MESSAGE_TYPE
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'MESSAGE_CATEGORY'
	AND LOOKUP_CODE   = MessageEO.MESSAGE_CATEGORY
	) AS RES_CATEGORY
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'MESSAGE_SEVERITY'
	AND LOOKUP_CODE   = MessageEO.MESSAGE_SEVERITY
	) AS RES_SEVERITY
,NVL((SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = MessageEO.LOGGABLE_ALERTABLE
	),'No')                               AS RES_LOGGING_ENABLED
,MessageEO.MESSAGE_TEXT          AS RES_SHORT_TEXT
,MessageEO.MESSAGE_USER_DETAILS  AS RES_USER_DETAILS
,MessageEO.MESSAGE_ADMIN_DETAILS AS RES_ADMINISTRATOR_DETAILS
,MessageEO.MESSAGE_CAUSE         AS RES_CAUSE
,MessageEO.MESSAGE_USER_ACTION   AS RES_USER_ACTION
,MessageEO.MESSAGE_ADMIN_ACTION  AS RES_ADMINISTRATOR_ACTION
,MessageEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,MessageEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,MessageEO.CREATED_BY RSC_CREATED_BY
,MessageEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_MESSAGES_VL MessageEO
ORDER BY RES_MESSAGE_NAME