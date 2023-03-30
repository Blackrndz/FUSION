/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Costing%20Messages%20-%20Project%20Costing%20Messages.sql $:
 * $Id: Manage Project Costing Messages - Project Costing Messages.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


 
SELECT fndMessageE0.MESSAGE_NAME RES_MESSAGE_NAME
 ,(SELECT APPLICATION_NAME
	FROM FND_APPLICATION_VL
	WHERE APPLICATION_ID = fndMessageE0.APPLICATION_ID
	) RES_APPLICATION
,(SELECT USER_MODULE_NAME
	FROM FND_APPL_TAXONOMY_VL
	WHERE MODULE_ID = fndMessageE0.MODULE_ID
	) RES_MODULE
,fndMessageE0.MESSAGE_NUMBER RES_MESSAGE_NUMBER
,fndMessageE0.CONTEXT RES_TRANSLATION_NOTES
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'MESSAGE_TYPE'
	AND LOOKUP_CODE   = fndMessageE0.TYPE
	) RES_MESSAGE_TYPE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'MESSAGE_CATEGORY'
	AND LOOKUP_CODE   = fndMessageE0.MESSAGE_CATEGORY
	) RES_CATEGORY
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'MESSAGE_SEVERITY'
	AND LOOKUP_CODE   = fndMessageE0.MESSAGE_SEVERITY
	) RES_SEVERITY
,NVL((SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = fndMessageE0.LOGGABLE_ALERTABLE
	),'No') RES_LOGGING_ENABLED
,fndMessageE0.MESSAGE_TEXT RES_SHORT_TEXT
,fndMessageE0.MESSAGE_USER_DETAILS RES_USER_DETAILS
,fndMessageE0.MESSAGE_ADMIN_DETAILS RES_ADMINISTRATOR_DETAILS
,fndMessageE0.MESSAGE_CAUSE RES_CAUSE
,fndMessageE0.MESSAGE_USER_ACTION RES_USER_ACTION
,fndMessageE0.MESSAGE_ADMIN_ACTION RES_ADMINISTRATOR_ACTION
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
WHERE fndMessageE0.MODULE_ID  IN 
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	where at.MODULE_TYPE = 'APPLICATION'
	AND at.module_key    = 'PJC'
	AND at.module_id     = rf.ancestor_module_id)
ORDER BY 1



	
	 