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
,DECODE(asmtsE0.INLINE_FLAG,'Y','Yes','No') RES_INLINE_SUPPORT
,DECODE(asmtsE0.MULTI_PHASE_FLAG,'Y','Yes','No') RES_MULTIPHASE_SUPPORT
,asmtsE0.PHASE_COUNT RES_NUMBER_OF_SUPPORTED_PHASES

,acctokensE0.URL RES_ACCESS_TOKEN_URL_WEB_SERVI
,acctokensE0.METHODS RES_ACCESS_TOKEN_URL_METHOD
,'' RES_ACCESS_TOKEN_URL_DEFAULT_P 								-- Access Token URL - Default Parameters
,acctokensE0.CUSTOM_PARAMS RES_ACCESS_TOKEN_URL_PARTNER_S 		-- Access Token URL - Partner Specific Parameters

,accvalidatesE0.URL RES_ACCOUNT_VALIDATION_WEB_SER 				-- Account Validation Web Service - Web Service Endpoint
,accvalidatesE0.METHODS RES_ACCOUNT_VALIDATION_WEB_S_0 			-- Account Validation Web Service - Method
,'' RES_ACCOUNT_VALIDATION_WEB_S_1 								-- Account Validation Web Service - Default Parameters
,accvalidatesE0.CUSTOM_PARAMS RES_ACCOUNT_VALIDATION_WEB_S_2 	-- Account Validation Web Service - Partner Specific Parameters

,assSubmitsE0.URL RES_ASSESSMENT_SUBMISSION_WEB_ 				-- Assessment Submission Web Service - Web Service Endpoint
,assSubmitsE0.METHODS RES_ASSESSMENT_SUBMISSION_WE_3 			-- Assessment Submission Web Service - Method
,'' RES_ASSESSMENT_SUBMISSION_WE_4 								-- Assessment Submission Web Service - Default Parameters
,assSubmitsE0.CUSTOM_PARAMS RES_ASSESSMENT_SUBMISSION_WE_5 		-- Assessment Submission Web Service - Partner Specific Parameters

,assResultsE0.URL RES_ASSESSMENT_RESULTS_URL_WEB 				-- Assessment Results URL Web Service - Web Service Endpoint
,assResultsE0.METHODS RES_ASSESSMENT_RESULTS_URL_W_6 			-- Assessment Results URL Web Service - Method
,'' RES_ASSESSMENT_RESULTS_URL_W_7 								-- Assessment Results URL Web Service - Default Parameters
,assResultsE0.CUSTOM_PARAMS RES_ASSESSMENT_RESULTS_URL_W_8 		-- Assessment Results URL Web Service - Partner Specific Parameters

,assNotisE0.URL RES_ASSESSMENT_NOTIFICATION_WE 					-- Assessment Notification Web Service - Web Service Endpoint
,assNotisE0.METHODS RES_ASSESSMENT_NOTIFICATION__9 				-- Assessment Notification Web Service - Method
,'' RES_ASSESSMENT_NOTIFICATION_10 								-- Assessment Notification Web Service - Default Parameters
,assNotisE0.CUSTOM_PARAMS RES_ASSESSMENT_NOTIFICATION_11 		-- Assessment Notification Web Service - Partner Specific Parameters

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
,IRC_ASMT_PARTNER_CONFIG asmtsE0
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
	) assSubmitsE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_RESULT'
	) assResultsE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_NOTIFY'
	) assNotisE0
WHERE partnersE0.PARTNER_ID = ptProvisngsE0.PARTNER_ID
AND ptProvisngsE0.CATEGORY_ID = catsE0.CATEGORY_ID
AND ptProvisngsE0.PROVISIONING_ID = asmtsE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = acctokensE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = accvalidatesE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = assSubmitsE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = assResultsE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = assNotisE0.PROVISIONING_ID(+)

AND catsE0.CODE = 'ASSESSMENT'

ORDER BY partnersE0.NAME