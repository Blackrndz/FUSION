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
,partnersE0.PARTNER_GUID RES_PARTNER_KEY
,catsE0.CATEGORY_NAME RES_SERVICE_CATEGORY
,'' RES_LOGO
,NVL(catsE0.SUB_CATEGORY_NAME,'None') RES_SERVICE_SUB_CATEGORY
,DECODE(bcsE0.PACKAGE_SELECTION_FLAG,'Y','Yes','No') RES_LOCAL_PACKAGE_SELECTION
,DECODE(bcsE0.MULTIPLE_REQUEST_FLAG,'Y','Yes','No') RES_MULTIPLE_PHASES_OR_STATES

,accvalidatesE0.URL RES_ACCOUNT_VALIDATION_WEB_SER 				-- Account Validation Web Service - Web Service Endpoint
,accvalidatesE0.METHODS RES_ACCOUNT_VALIDATION_WEB_S_0 			-- Account Validation Web Service - Method
,'' RES_ACCOUNT_VALIDATION_WEB_S_1 								-- Account Validation Web Service - Default Parameters
,accvalidatesE0.CUSTOM_PARAMS RES_ACCOUNT_VALIDATION_WEB_S_2 	-- Account Validation Web Service - Partner Specific Parameters

,sccWebLinksE0.URL RES_SCREENING_SETUP_WEBSITE_LI 				-- Screening Setup Website Link - URL
,'' RES_SCREENING_SETUP_WEBSITE__3 								-- Screening Setup Website Link - Default Parameters
,sccWebLinksE0.CUSTOM_PARAMS RES_SCREENING_SETUP_WEBSITE__4 	-- Screening Setup Website Link - Partner Specific Parameters

,bcSubmitsE0.URL RES_BACKGROUND_CHECK_SUBMISSIO 				-- Background Check Submission Web Service - Web Service Endpoint
,bcSubmitsE0.METHODS RES_BACKGROUND_CHECK_SUBMISS_5 			-- Background Check Submission Web Service - Method
,'' RES_BACKGROUND_CHECK_SUBMISS_6 								-- Background Check Submission Web Service - Default Parameters
,bcSubmitsE0.CUSTOM_PARAMS RES_BACKGROUND_CHECK_SUBMISS_7 		-- Background Check Submission Web Service - Partner Specific Parameters

,sccResultsE0.URL RES_SCREENING_RESULTS_WEBSITE_ 				-- Screening Results Website Link - URL
,'' RES_SCREENING_RESULTS_WEBSIT_8 								-- Screening Results Website Link - Default Parameters
,sccResultsE0.CUSTOM_PARAMS RES_SCREENING_RESULTS_WEBSIT_9 		-- Screening Results Website Link - Partner Specific Parameters

,acTokensE0.URL RES_ACCESS_TOKEN_URL_OAUTH_WEB 					-- Access Token URL OAuth - Web Service Endpoint
,acTokensE0.METHODS RES_ACCESS_TOKEN_URL_OAUTH_MET 				-- Access Token URL OAuth - Method
,'' RES_ACCESS_TOKEN_URL_OAUTH_DEF 								-- Access Token URL OAuth - Default Parameters
,acTokensE0.CUSTOM_PARAMS RES_ACCESS_TOKEN_URL_OAUTH_PAR 		-- Access Token URL OAuth - Partner Specific Parameters

,acvalidOathsE0.URL RES_ACCOUNT_VALIDATION_WEB__10 				-- Account Validation Web Service OAuth - Web Service Endpoint
,acvalidOathsE0.METHODS RES_ACCOUNT_VALIDATION_WEB__11 			-- Account Validation Web Service OAuth - Method
,'' RES_ACCOUNT_VALIDATION_WEB__12 								-- Account Validation Web Service OAuth - Default Parameters
,acvalidOathsE0.CUSTOM_PARAMS RES_ACCOUNT_VALIDATION_WEB__13 	-- Account Validation Web Service OAuth - Partner Specific Parameters

,sccSetupsE0.URL RES_SCREENING_SETUP_URL_WEB_SE 				-- Screening Setup URL Web Service OAuth - Web Service Endpoint
,sccSetupsE0.METHODS RES_SCREENING_SETUP_URL_WEB_14 			-- Screening Setup URL Web Service OAuth - Method
,'' RES_SCREENING_SETUP_URL_WEB_15 								-- Screening Setup URL Web Service OAuth - Default Parameters
,sccSetupsE0.CUSTOM_PARAMS RES_SCREENING_SETUP_URL_WEB_16 		-- Screening Setup URL Web Service OAuth - Partner Specific Parameters

,bcChkSumitsE0.URL RES_BACKGROUND_CHECK_SUBMIS_17 				-- Background Check Submission Web Service OAuth - Web Service Endpoint
,bcChkSumitsE0.METHODS RES_BACKGROUND_CHECK_SUBMIS_18 			-- Background Check Submission Web Service OAuth - Method
,'' RES_BACKGROUND_CHECK_SUBMIS_19 								-- Background Check Submission Web Service OAuth - Default Parameters
,bcChkSumitsE0.CUSTOM_PARAMS RES_BACKGROUND_CHECK_SUBMIS_20 	-- Background Check Submission Web Service OAuth - Partner Specific Parameters

,sccResultOathsE0.URL RES_SCREENING_RESULTS_URL_WEB_ 			-- Screening Results URL Web Service OAuth - Web Service Endpoint
,sccResultOathsE0.METHODS RES_SCREENING_RESULTS_URL_W_21 		-- Screening Results URL Web Service OAuth - Method
,'' RES_SCREENING_RESULTS_URL_W_22 								-- Screening Results URL Web Service OAuth - Default Parameters
,sccResultOathsE0.CUSTOM_PARAMS RES_SCREENING_RESULTS_URL_W_23 	-- Screening Results URL Web Service OAuth - Partner Specific Parameters

,bcChkNotisE0.URL RES_BACKGROUND_CHECK_NOTIFICAT 				-- Background Check Notification Web Service OAuth - Web Service Endpoint
,bcChkNotisE0.METHODS RES_BACKGROUND_CHECK_NOTIFI_24 			-- Background Check Notification Web Service OAuth - Method
,'' RES_BACKGROUND_CHECK_NOTIFI_25 								-- Background Check Notification Web Service OAuth - Default Parameters
,bcChkNotisE0.CUSTOM_PARAMS RES_BACKGROUND_CHECK_NOTIFI_26 		-- Background Check Notification Web Service OAuth - Partner Specific Parameters

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
,IRC_BC_ACTIVATION_CONFIG bcsE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_CONFIG'
	) accvalidatesE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_REQ_CONFIG'
	) sccWebLinksE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_SUBMIT'
	) bcSubmitsE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_RESULT'
	) sccResultsE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_TOKEN_GRANT'
	) acTokensE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_CONFIG_V2'
	) acvalidOathsE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_REQ_CONFIG_V2'
	) sccSetupsE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_SUBMIT_V2'
	) bcChkSumitsE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_RESULT_V2'
	) sccResultOathsE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_NOTIFY'
	) bcChkNotisE0
WHERE partnersE0.PARTNER_ID = ptProvisngsE0.PARTNER_ID
AND ptProvisngsE0.CATEGORY_ID = catsE0.CATEGORY_ID
AND ptProvisngsE0.PROVISIONING_ID = bcsE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = accvalidatesE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = sccWebLinksE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = bcSubmitsE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = sccResultsE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = acTokensE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = acvalidOathsE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = sccSetupsE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = bcChkSumitsE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = sccResultOathsE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = bcChkNotisE0.PROVISIONING_ID(+)

AND catsE0.CODE = 'BACKGROUND_CHECK'

ORDER BY partnersE0.NAME