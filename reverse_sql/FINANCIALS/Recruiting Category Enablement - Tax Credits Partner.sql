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

,acctokensE0.URL RES_ACCESS_TOKEN_URL_WEB_SERVI
,acctokensE0.METHODS RES_ACCESS_TOKEN_URL_METHOD
,'' RES_ACCESS_TOKEN_URL_DEFAULT_P 								-- Access Token URL - Default Parameters
,acctokensE0.CUSTOM_PARAMS RES_ACCESS_TOKEN_URL_PARTNER_S 		-- Access Token URL - Partner Specific Parameters

,accvalidatesE0.URL RES_ACCOUNT_VALIDATION_WEB_SER 				-- Account Validation Web Service - Web Service Endpoint
,accvalidatesE0.METHODS RES_ACCOUNT_VALIDATION_WEB_S_0 			-- Account Validation Web Service - Method
,'' RES_ACCOUNT_VALIDATION_WEB_S_1 								-- Account Validation Web Service - Default Parameters
,accvalidatesE0.CUSTOM_PARAMS RES_ACCOUNT_VALIDATION_WEB_S_2 	-- Account Validation Web Service - Partner Specific Parameters

,taxSubmitsE0.URL RES_TAX_CREDIT_SUBMISSION_WEB_ 				-- Tax Credit Submission Web Service - Web Service Endpoint
,taxSubmitsE0.METHODS RES_TAX_CREDIT_SUBMISSION_WE_3 			-- Tax Credit Submission Web Service - Method
,'' RES_TAX_CREDIT_SUBMISSION_WE_4 								-- Tax Credit Submission Web Service - Default Parameters
,taxSubmitsE0.CUSTOM_PARAMS RES_TAX_CREDIT_SUBMISSION_WE_5 		-- Tax Credit Submission Web Service - Partner Specific Parameters

,taxResultsE0.URL RES_TAX_CREDIT_RESULTS_URL_WEB 				-- Tax Credit Results URL Web Service - Web Service Endpoint
,taxResultsE0.METHODS RES_TAX_CREDIT_RESULTS_URL_W_6 			-- Tax Credit Results URL Web Service - Method
,'' RES_TAX_CREDIT_RESULTS_URL_W_7 								-- Tax Credit Results URL Web Service - Default Parameters
,taxResultsE0.CUSTOM_PARAMS RES_TAX_CREDIT_RESULTS_URL_W_8 		-- Tax Credit Results URL Web Service - Partner Specific Parameters

,candidateWSsE0.URL RES_CANDIDATE_URL_WEB_SERVICE_ 				-- Candidate URL Web Service - Web Service Endpoint
,candidateWSsE0.METHODS RES_CANDIDATE_URL_WEB_SERVIC_9 			-- Candidate URL Web Service - Method
,'' RES_CANDIDATE_URL_WEB_SERVI_10 								-- Candidate URL Web Service - Default Parameters
,candidateWSsE0.CUSTOM_PARAMS RES_CANDIDATE_URL_WEB_SERVI_11 	-- Candidate URL Web Service - Partner Specific Parameters

,taxNotisE0.URL RES_TAX_CREDIT_NOTIFICATION_WE 					-- Tax Credit Notification Web Service - Web Service Endpoint
,taxNotisE0.METHODS RES_TAX_CREDIT_NOTIFICATION_12 				-- Tax Credit Notification Web Service - Method
,'' RES_TAX_CREDIT_NOTIFICATION_13 								-- Tax Credit Notification Web Service - Default Parameters
,taxNotisE0.CUSTOM_PARAMS RES_TAX_CREDIT_NOTIFICATION_14 		-- Tax Credit Notification Web Service - Partner Specific Parameters

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
	WHERE PHASE_CODE = 'ORA_TOKEN_GRANT'
	) acctokensE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_CONFIG'
	) accvalidatesE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_SUBMIT'
	) taxSubmitsE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_RESULT'
	) taxResultsE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_INFO'
	) candidateWSsE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_NOTIFY'
	) taxNotisE0
WHERE partnersE0.PARTNER_ID = ptProvisngsE0.PARTNER_ID
AND ptProvisngsE0.CATEGORY_ID = catsE0.CATEGORY_ID
AND ptProvisngsE0.PROVISIONING_ID = acctokensE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = accvalidatesE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = taxSubmitsE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = taxResultsE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = candidateWSsE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = taxNotisE0.PROVISIONING_ID(+)

AND catsE0.CODE = 'TAX_CREDITS'

ORDER BY partnersE0.NAME