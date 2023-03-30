/* ****************************************************************************
* $Revision: 55207 $:
* $Author: dhara.pithadiya $:
* $Date: 2016-05-13 15:25:32 +0700 (Fri, 13 May 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Applications%20Core%20Messages%20-%20Manage%20Applications%20Core%20Messages.sql $:
* $Id: Manage Applications Core Messages - Manage Applications Core Messages.sql 55207 2016-05-13 08:25:32Z dhara.pithadiya $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT messagesE0.MESSAGE_NAME RES_MESSAGE_NAME
,(SELECT APPLICATION_NAME
	FROM FND_APPLICATION_VL
	WHERE APPLICATION_ID = messagesE0.APPLICATION_ID
	) RES_APPLICATION
,(SELECT USER_MODULE_NAME
	FROM FND_APPL_TAXONOMY_VL
	WHERE MODULE_ID = messagesE0.MODULE_ID
	) RES_MODULE
,messagesE0.MESSAGE_NUMBER RES_MESSAGE_NUMBER
,messagesE0.CONTEXT RES_TRANSLATION_NOTES
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'MESSAGE_TYPE'
	AND LOOKUP_CODE   = messagesE0.TYPE
	) RES_MESSAGE_TYPE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'MESSAGE_CATEGORY'
	AND LOOKUP_CODE   = messagesE0.MESSAGE_CATEGORY
	) RES_CATEGORY
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'MESSAGE_SEVERITY'
	AND LOOKUP_CODE   = messagesE0.MESSAGE_SEVERITY
	) RES_SEVERITY
,NVL((SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = messagesE0.LOGGABLE_ALERTABLE
	),'No') RES_LOGGING_ENABLED
,messagesE0.MESSAGE_TEXT RES_SHORT_TEXT
,messagesE0.MESSAGE_USER_DETAILS RES_USER_DETAILS
,messagesE0.MESSAGE_ADMIN_DETAILS RES_ADMINISTRATOR_DETAILS
,messagesE0.MESSAGE_CAUSE RES_CAUSE
,messagesE0.MESSAGE_USER_ACTION RES_USER_ACTION
,messagesE0.MESSAGE_ADMIN_ACTION RES_ADMINISTRATOR_ACTION
,messagesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,messagesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,messagesE0.CREATED_BY RSC_CREATED_BY
,messagesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_MESSAGES_VL messagesE0
WHERE messagesE0.MODULE_ID  IN 
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	where at.MODULE_TYPE = 'APPLICATION'
	AND at.module_key    = 'PJB'
	AND at.module_id     = rf.ancestor_module_id)
ORDER BY messagesE0.MESSAGE_NAME