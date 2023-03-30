/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HWM_TCATS_VL

WITH SERVICES AS (SELECT serveicesE0.PROVISIONING_ID
	,catphasesE0.PHASE_CODE
	,serveicesE0.URL
	,(SELECT MEANING
		FROM FND_LOOKUP_VALUES
		WHERE LANGUAGE = USERENV('LANG')
		AND LOOKUP_TYPE = 'ORA_IRC_TP_HTTP_METHOD'
		AND LOOKUP_CODE = serveicesE0.HTTP_METHOD_TYPE_CODE
		) METHODS
	,serveicesE0.CUSTOM_PARAMS
	FROM IRC_TP_PARTNER_SERVICES serveicesE0
	,IRC_TP_CATEGORY_PHASES catphasesE0
	WHERE serveicesE0.CATEGORY_PHASE_ID = catphasesE0.CATEGORY_PHASE_ID)

SELECT partnersE0.NAME RES_NAME
,'' RES_LOGO
,partnersE0.PARTNER_GUID RES_PARTNER_KEY
,catsE0.CATEGORY_NAME RES_SERVICE_CATEGORY
,NVL(catsE0.SUB_CATEGORY_NAME,'None') RES_SERVICE_SUB_CATEGORY

,accvalidatesE0.URL RES_ACCOUNT_VALIDATION_WEB_SER 				-- Account Validation Web Service - Web Service Endpoint
,accvalidatesE0.METHODS RES_ACCOUNT_VALIDATION_WEB_S_0 			-- Account Validation Web Service - Method
,'' RES_ACCOUNT_VALIDATION_WEB_S_1 								-- Account Validation Web Service - Default Parameters
,accvalidatesE0.CUSTOM_PARAMS RES_ACCOUNT_VALIDATION_WEB_S_2 	-- Account Validation Web Service - Partner Specific Parameters

,jpWebLinksE0.URL RES_JOB_POSTING_WEBSITE_LINK_U 				-- Job Posting Website Link - URL
,'' RES_JOB_POSTING_WEBSITE_LINK_D 								-- Job Posting Website Link - Default Parameters
,jpWebLinksE0.CUSTOM_PARAMS RES_JOB_POSTING_WEBSITE_LINK_P 		-- Job Posting Website Link - Partner Specific Parameters

,jpRemovalsE0.URL RES_JOB_POSTING_REMOVAL_WEB_SE 				-- Job Posting Removal Web Service - Web Service Endpoint
,jpRemovalsE0.METHODS RES_JOB_POSTING_REMOVAL_WEB__3 			-- Job Posting Removal Web Service - Method
,'' RES_JOB_POSTING_REMOVAL_WEB__4 								-- Job Posting Removal Web Service - Default Parameters
,jpRemovalsE0.CUSTOM_PARAMS RES_JOB_POSTING_REMOVAL_WEB__5 		-- Job Posting Removal Web Service - Partner Specific Parameters

,ptProvisngsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ptProvisngsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ptProvisngsE0.CREATED_BY RSC_CREATED_BY
,ptProvisngsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM IRC_TP_PARTNERS partnersE0
,IRC_TP_PARTNER_PROVISNGS ptProvisngsE0
,IRC_TP_CATEGORIES_VL catsE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_CONFIG'
	) accvalidatesE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_SUBMIT'
	) jpWebLinksE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_REMOVE'
	) jpRemovalsE0
WHERE partnersE0.PARTNER_ID = ptProvisngsE0.PARTNER_ID
AND ptProvisngsE0.CATEGORY_ID = catsE0.CATEGORY_ID
AND ptProvisngsE0.PROVISIONING_ID = accvalidatesE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = jpWebLinksE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = jpRemovalsE0.PROVISIONING_ID(+)

AND catsE0.CODE = 'JOB_DISTRIBUTION'

ORDER BY partnersE0.NAME